Return-Path: <linux-kernel+bounces-892262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1486C44B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572A03B0FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48DD221542;
	Mon, 10 Nov 2025 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bx8FdL29"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4C34D387;
	Mon, 10 Nov 2025 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738153; cv=fail; b=UIjMpRMsasc/1DzkBANazj6mPWg1O3LUZRt/elapidFOtTTY7Ve5lxm+KpV6OPbX8zJ2U8Pul2/3wg6hvAPpspwjC0+uPq3maYjZSuk1uvGRhXlMnuGwL+v93ndB1AEO/IipYa7WD2bHT5hn5ZzSE3ScVxIl1ZdxzgcfvTMB5NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738153; c=relaxed/simple;
	bh=PPwPzFNVLrUSpjHkrD/v9m9r8mdP2Tvr/9g9wT1euhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RU+rMx/1rTfEkv7e6iyFfMtWInyVzDQPZwvzxCcB3SAmCoyMfTFLtKKAHlDHRrWxnWKvyfRYkKaoSpWHicOwSaNmhZnpGwoMZSmmgxSejAUO8uMg80H9j/IzsnHj3m1SGxX20R3+eCjJfKxAWyapSTr0WloSWDXqoUrzRoMoUpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bx8FdL29; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzGLfLabG79stgfOMu2DhKBgxJTQ9Ac5Kd6gEoViWYF+HnKhsR5JVdY30eLlWafSSWbXtEdszHwBuZ865xQtgzpBd36gMCiwdAf7QPaEro/c70T/jNkvmJVNnzy5/zSQiQers2m2NUbSS/2BTFoPR/oLai1bNhEjUdPjrNaefbXZXzfkQRI2P9RcInjKL/Q8aXnCZE6hmn/rU/ejJdPWpPEOJ6T6w1FlaIHN4W7ipBIvdk1yF5tt50tHj1xJLY9e8rgyE/q7jypXuggJ+QHTPrcE+n4VOty+UUD+m6FVCSeKGXxNXAG9BLIWoKjZEHSo+S/XVZSNbDQKuVHZta2EGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6FPGNlxyAKyr0CuOsCsUcAyzyJK30BjXGKN5m5bmmc=;
 b=rR5V9i0yqpxAow10k28QnHP1SlAjShnmPJeiLUUKkborFsINXZRJwXuVK6vwo4Uf/Vu35+dfdB/oN9vAg70I39xVaMji/3OrIMhb5kYBDVuS/maWGU5qgpPh61PHJCI9L2EmF2OXA8vZ0vb2uc0O6m8R6YE0n/wboO4UVO+74wg9e86Qcx4XYgZgicLbxZ0jIczzgqqQ9fRt0Yi3mrw123PQnHIJddudFc5G2MC/OLQpxz84ehG2j8t2ZtVQCs4GfKIwIatyWk7z8IEjOpoKZlunG5orQrzuhfV2lGBlgbxDSWPerUlvkDiQs0FIbfSjQ7+hpWlWcPOWntXnlDY6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6FPGNlxyAKyr0CuOsCsUcAyzyJK30BjXGKN5m5bmmc=;
 b=bx8FdL29fndH++YCfLy5FTR6otJMSK+N5D1CeDEKbHKHFwXLjd8yng252wIvhyzacWoF7cPCBwYiae27SJxKKz/iaRuCbxSFQUkr0ykJGVA2LZfaQhuKAygggSlq4i2VD3uUfTegaGvdqWUD58lWT7SndsR3xoRfcg5Ld+CieLg9fcSQMBpRmbkkbQWRMROOhgYAeKpiHCVDdONZNTKAT9WvMkZqbiTsqeT3MItjnVpZiFzrn0iU/fki7bUJaoHU3nCNQB5GXZ3/sO7agJ944xzjrlAvpwH8/tbupur4GRud814ADT1wNfGtP41yswFTqUFTLvAqb3RpcxLXXYq5PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by VI0PR04MB12136.eurprd04.prod.outlook.com (2603:10a6:800:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 01:29:07 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 01:29:06 +0000
Message-ID: <b0f41153-00b5-43ca-ad7a-bfa874f9043c@oss.nxp.com>
Date: Mon, 10 Nov 2025 09:28:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] media: docs: dev-decoder: Trigger dynamic source
 change for colorspace
To: Nicolas Dufresne <nicolas@ndufresne.ca>, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, xiahong.bao@nxp.com,
 eagle.zhou@nxp.com, imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250418085422.193-1-ming.qian@oss.nxp.com>
 <20250418085422.193-2-ming.qian@oss.nxp.com>
 <4d1260be46be22d7b40fab9788763af796d118dc.camel@ndufresne.ca>
 <0c68a2c0-7e30-46da-abf1-759a7dbb7ecf@oss.nxp.com>
 <141a14f366abe431be65e3977c27d2b39180f38e.camel@ndufresne.ca>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <141a14f366abe431be65e3977c27d2b39180f38e.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|VI0PR04MB12136:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1ec496-cf95-406a-5f4f-08de1ff889fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2lObXdaVHN2WjJJOU5qVWxJMXRRQmE1U2FKZFdxdG9GSkxKeWd5WmxSajkv?=
 =?utf-8?B?SEN2VkU3dHZwekljQ01JemVKQzVIZjYwWUdUT0ZkbS80aEJDK0JOcCtDSzBG?=
 =?utf-8?B?VnRzOXZQcms2ZEtVVTFvZXRFekUwRTJqQjJtbTdlTDJ6UHg4TkdFL0t2dUJX?=
 =?utf-8?B?Vk9jRnZCd0tMMXN0TldpSGE4NmlJUDQwR0lIWVhuMk5lR0pUY2J5YS9seTF3?=
 =?utf-8?B?ZFM5dy9WdzZ4SEI3T0RnL0JESk14WVR5VGQyZnhNNmF2eHZMc0liWmQ5OVph?=
 =?utf-8?B?U0F6dGNmVGpYZjVuRzd4VlNIc21VVXJRa2J5Z1E5dTUrREgraS9oNUZKNVYw?=
 =?utf-8?B?eC8zRm1LdHdTS2pQdURySzRUVG1sRGhocjVNUnp1S2hpbFMxUkg4U1N0SzhB?=
 =?utf-8?B?b3BpR1ZLanF4YU9RMVMva3kxQUxQbCtYRncrMkZuazBQRk93Y0h0cEF6ZDE0?=
 =?utf-8?B?WUp0UFdLTzBhd1FYZXdDUHpRUkswZ21RMjJLQUwxR2FlZk9EdEhOdmtjc09K?=
 =?utf-8?B?QTI4bkpnbVoyUmhGVXd0cHdFcnFvMWs3bCtuMWRyWjRVWGJrUDk4Rnd5SXZ3?=
 =?utf-8?B?Ym1PNGw2NkQ2TEpNWWxRK3Z6ZUh2N3plTjVjamVoYUhQMFdQUENkZVFtdE1r?=
 =?utf-8?B?TFpyUUJ6eHJoUElkUGYxMkV4dWZ2ZzZvd0gzNGpjaHRCSHoxeHJhak9QdnZs?=
 =?utf-8?B?NVNwMnVCaDM2NWN2eUVEcE5rUTVUcWM1allrSEhUZTZ0UTMwQlpoZDBYazhs?=
 =?utf-8?B?eGF4YUx3c0JlSEppUTVMNnROd0hTb2MrNXpPWkNUYVduRkdDOTQ5YjhJbmZw?=
 =?utf-8?B?Mklzd1JFTVFmZStWc1hzYm9ZU3dGUDkxU01RWFcyUXRIbXloS242QVFFaVpq?=
 =?utf-8?B?NU5nQitPY3E4T2IxNmFMT05oOE0yaGlXcFpUV01TN2l4eGFvOTR4bkNHb3Bo?=
 =?utf-8?B?Q0tReHlVSHVrTktLUlR4SGN1ek56SStSczBmWG9ITTZFelFiK2d0U2d3aG5Z?=
 =?utf-8?B?eE1taUJDOFk5SXdjeE5JMVNNZGxhSTdQL2E4WXJoYUlHc2prNHVacmptMzhY?=
 =?utf-8?B?RldaMjhHRE5PeWVzcnU1YTNBSXVYaG1mSDlTdXVDSStHSFluUm94UnBKQ1Y2?=
 =?utf-8?B?Y0Mva05Cckd3R2NVUm8yc3RwMk14SG81dW9GMk94TXhkdERNcXoyVVMxT1Vt?=
 =?utf-8?B?c3F4Y3BzWGt4R0ZWK0ZhemMwblBwQVN2dkh1ZkVEVFlIdXgrQklOSTBzNlZq?=
 =?utf-8?B?S3dTakVmZTNqemhPNVc2TXZ0TE1Xc0NhT3ovUmpTZWJXYitYbVRLRUk5ZWUr?=
 =?utf-8?B?VDhhRXRnKzlId0JncFVud2IvV1VGNi9qN0Q3alVaWVJjY3B0YU83VWFlMTBQ?=
 =?utf-8?B?M1NnMmk3K3ZObDZha1JuRklPejRCenlxOGtBRFNwZG5BWkt3REg2Mnh5MFhy?=
 =?utf-8?B?RjBWRzBpT0d2Vk9vSlRkaXpCVWdnNHQ1RXg2SXpFclpTZExHVi9KdzRlak95?=
 =?utf-8?B?a0pDSExONnQzd2dsMm1MRXoyZCtNaUlJVXYyMWE2eEkrMUxpcndtbXEwOWl0?=
 =?utf-8?B?UUZldU80MHdlbDROTXVCck0rS3FXMDZjVi85R05qNnBBb1Vna1NWc01EQWhI?=
 =?utf-8?B?c1hITDB2VTNTb1pKYUdKVnpQcFBKcmQ1ci8vVUJLNVExV1UwMk5QcHRHd0NX?=
 =?utf-8?B?bytSUVFwUkJCYzhoNDBZMUlMaDN1SUZqT0dtRkE4MzZMY3FMQUt4VkVMQnVE?=
 =?utf-8?B?WmRraTBDRHpobDgvNUlZU0VCZWlneXJ5d05DNWFJeWhtb3dZTGJQaklOMDNN?=
 =?utf-8?B?RE5DZ0ZiSlRlSHBKK1RxcjJzNzdUaTlUWml3OGt1cWVtK2tTV0JjeEVpSnZ4?=
 =?utf-8?B?S2RsTy9hUDhtb2RzcUVIYlVGR01sU0ZWNlBtUkJBdGVKQ1RuYzVRQ1cwNHp1?=
 =?utf-8?Q?o/upxIhsJEr5bFE782Fyvqx1DmMYDUfn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VCtzV3R2RzFkZFQ5QlVyV2RTSU5SYlZmRVd3WFlLZmZpaEJKUi94TGxMTFNn?=
 =?utf-8?B?UlFEUTlycGpNdHpVSktDN1FSUEZqaWxRN3RMek9XRDFJdjk4K1UvaUkrUTYr?=
 =?utf-8?B?V1YwODFFVXFZcHhsVyt2SDBzK0NJODNia2FaMW5aQ1E5M3hlalUzK1llNFg2?=
 =?utf-8?B?cXZzandNMnJsMWYreE1LMXdmeS85bSsvZ3JlWEJlWlY5ZGJhZzBRaUZjUnVP?=
 =?utf-8?B?VHllcmkyWHM4YXhPckdXNHlEK3dlUko5dXM1SnJ2cVNieGF6Y0M3MmF0MVU1?=
 =?utf-8?B?NGdBYkN5bUFlWS9Ubm9mZUNhbXFYMWNYQ1ExNVdNNWg5cVJROTlDSkZicEtr?=
 =?utf-8?B?S3RGM1lKOWJHa2JrMExlVXdKcm9kS2ZWYmRGc0M5TjUxR0t0Z05VbUoybmtr?=
 =?utf-8?B?c2FtSEIrbS9NRk91bC8yVDYwMVBQR2VqeVZEUy85TDV1TytFZFNXcjRweEgy?=
 =?utf-8?B?QzZVYUhWei9YK0VETGlpWHVCUGdjeElUNDZINnNqODFUa3dPcjJjYjNTeFdO?=
 =?utf-8?B?SHRxbXVycHhNRzdqTGZJY0ZCTURPOTZqVzFoelE4T3l5VXBpSnhzSUsvQ1U3?=
 =?utf-8?B?eWNHSDZXbi9FNnRCREZXVkQzV3p1K0xKVVgxNHV1dUJUQkNMOUJaajBuTzQv?=
 =?utf-8?B?TnFUU3dudGVLY095ZWFZaHNzMlo2NFl0K0YxRkVhSis3UElOVzdXSzVUaGZE?=
 =?utf-8?B?aHFlSW1Dem9sQ1FRNXp0NExEd05ZQjhOYUdjUEtuNGU2RGtmaG8xZVZqYmNT?=
 =?utf-8?B?VzBVL3lOTE9XNmpzZHo1b1M2Q0tTVThmc1owczR4YXQrVXJFbXVVc3lZSWs1?=
 =?utf-8?B?b0dCVTJBZHlVekJTRTBWTzJuSHJUUDdLQmE1a2dpTVJ3bFNNNThkSytTdm5z?=
 =?utf-8?B?dlA5dWdBMnlmcXlQZERINzNpVlV1WXo1RWRweTVCZmV1OG5LUVVhbUlBalg0?=
 =?utf-8?B?TlZnQjd6S3JmMTdiUHJqakNBaU9pWk1rZVl6bFR4Y1RoemhQVmRjLzBTalZG?=
 =?utf-8?B?R0ptVWE4UElYV3BTakFFS2hUdXRUVUtFVlFZa3Y2NTNKeXMzM0lhdkkvZXdC?=
 =?utf-8?B?UnU4WEg1RlpmRVdXdjIyNnFPOTN0QjVOUEduQVpWRy9yMExTc2NDeWZCVlVz?=
 =?utf-8?B?cnhiZWtmWWxDQWsvV0VsYVROUlZQTTJNVW1mRVN4bTJkSjAwV1pwMVVvTHhy?=
 =?utf-8?B?d3RnRzFBdkdFc1VwZ2o5NDR5dFZ1NmwyQ3BHZEcycVJtUTBIaDJ4cUNqUDk3?=
 =?utf-8?B?c0ZWY3gwMm1Bb1ZzTkdCREZCZ1ZabWZCekZIRFBsL04zN3RDbytHTTdZWnVn?=
 =?utf-8?B?MENDRzRnekd2eFFiVXRIQ3NlMHZ5cDgyT0pQK1lBekFTMjFibE5VQVc1RWFM?=
 =?utf-8?B?bTlaT1FCWkp2SWZnVjE1ZStaTjRSY1lZQU9nZlpzTkh2WVJ6Zms4QzVrbDVK?=
 =?utf-8?B?VzRObCsvRTlYK1BRYXJ2RDhzaFJWSUhRVTcySEVEbUYrdEtpYW84TFVockNt?=
 =?utf-8?B?aVJBTitJSE5SV05JTUkxSWF5T0xueFRWTXhPWHlGakhjTytrS1lHb3FCZ2tj?=
 =?utf-8?B?NjNtc25HSGxVS3lnaEVEZlc1S0ZLVmJVTlFzR1l4TDYraWxMNW9iUnVHUWNx?=
 =?utf-8?B?Y0diSi9rV0I0RUtPT3dLWHo5S0Zpd29tRTdHM2M4YlFqTkxNM3oza2NtNmNy?=
 =?utf-8?B?Y3lueE1PYllXMmg1bjFRU0dwaWplMTF2cW52SG1oakprZmd5Vi8vbHhRdlQx?=
 =?utf-8?B?M0F3Y003NEVSVlJXYkJoTWhtK1A2WURiUFFIZmdxRmRSaXFTaEZsOURUVngr?=
 =?utf-8?B?WE1XYllWNGtEZWxaRVpXRmpFQmVGZTQ0M0J0MFlkbHYvU0EyL2NpTFZudk4v?=
 =?utf-8?B?OWhLdmZWaE9BSGI1UEFXcUkzSkFHcjlISTg0MXdIcERWcDVBektkcGYvSlBX?=
 =?utf-8?B?a29kSWhCYlRyZDk0eXgxR0IxN2ZZSDhHcXdQRVBJaHFwNmsrSGZLdkJpeXh3?=
 =?utf-8?B?UjhPRDF6c0hFQStQOWh0OEJ4SDdWbEkvcnNJSXROOEJJZjhySHNQVEo1Yk5Z?=
 =?utf-8?B?MGpLMjVXUkNmb2tNbGhoRVhzMkpZMmVFaGxPSmJEZnd4Zk1YbHJTeVpBNGdr?=
 =?utf-8?Q?dI6R66AOVzMIkIfVmlaHIkT9N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1ec496-cf95-406a-5f4f-08de1ff889fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 01:29:06.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nmW9Tk/7iRLqoKxZbDCTP++JL+Su0UxnIjZixn6Zedoe1rdjRCek8+YkD/k5Os3G22/bib0JzVHtwcJiINT6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12136


Hi Nicolas，

On 11/7/2025 10:50 PM, Nicolas Dufresne wrote:
> Hi,
> 
> I'm reviewing my backlog and this one has been stalled.
> 
> Le lundi 03 novembre 2025 à 09:45 +0800, Ming Qian(OSS) a écrit :
>> Hi Nicolas,
>>
>> On 8/1/2025 11:23 PM, Nicolas Dufresne wrote:
>>> Hi Ming,
>>>
>>> Le vendredi 18 avril 2025 à 16:54 +0800, ming.qian@oss.nxp.com a écrit :
>>>> From: Ming Qian <ming.qian@oss.nxp.com>
>>>>
>>>> If colorspace changes, the client needs to renegotiate the pipeline,
>>>> otherwise the decoded frame may not be displayed correctly.
>>>>
>>>> When a colorspace change in the stream, the decoder sends a
>>>> V4L2_EVENT_SOURCE_CHANGE event with changes set to
>>>> V4L2_EVENT_SRC_CH_COLORSPACE. After client receive this source change
>>>> event, then client can switch to the correct stream setting. And each
>>>> frame can be displayed properly.
>>>
>>> sorry for the long delay. While reading this, in any case userspace have to read
>>> the new format. Why can't userspace compare the old and new v4l2_format and
>>> decide to avoid re-allocation that way ?
>>>
>>> There is also backward compatbility issues for driver that was sending
>>> V4L2_EVENT_SRC_CH_RESOLUTION for colorspace change before. Despite the costly
>>> re-allocation, userspace only watching for V4L2_EVENT_SRC_CH_RESOLUTION would
>>> endup not updating the colorspace anymore.
>>>
>>> Combining both would be an option, but then V4L2_EVENT_SRC_CH_RESOLUTION means
>>> any v4l2_format changes, which is awkward. What do you think of leaving to
>>> userspace the task of comparing the old and new v4l2_format ?
>>>
>>> Nicolas
>>>
>>
>> Sorry for the delay response (I don't understand why I received this
>> email several months late.)
>>
>> I agree that comparing the old and new v4l2_format is feasible. And
>> there are currently four conditions that can trigger source change.
>> - coded resolution (OUTPUT width and height),
>> - visible resolution (selection rectangles),
>> - the minimum number of buffers needed for decoding,
>> - bit-depth of the bitstream has been changed.
>>
>> Therefore, comparing only v4l2_format is insufficient. This is much more
>> complicated than checking a flag. I'm not sure if existing applications
>> have already done this.
>>
>> I also think it's OK for driver to send V4L2_EVENT_SRC_CH_RESOLUTION for
>> colorspace change, This will only incur additional allocation overhead,
>> without causing any functional issues.
>>
>> Therefore, from a driver perspective:
>> - V4L2_EVENT_SRC_CH_RESOLUTION for format change      OK
>> - V4L2_EVENT_SRC_CH_RESOLUTION for colorspace chagne  OK, but
>> re-allocation cost
>> - V4L2_EVENT_SOURCE_CHANGE for colorspace change      OK
>>
>> from a client perspective:
>> - V4L2_EVENT_SRC_CH_RESOLUTION without compareing format    OK,
>> re-allocation
>> - V4L2_EVENT_SRC_CH_RESOLUTION with comparing format        OK,
>> additional support required
>> - V4L2_EVENT_SOURCE_CHANGE                                  OK,
>> additional support required
>>
>>
>> I believe that adding a V4L2_EVENT_SOURCE_CHANGE flag will help simplify
>> the process and will not cause too many backward compatibility issues.
> 
> So stepping back a little, the point is the V4L2_EVENT_SRC_CH_RESOLUTION is not
> clear enough. For backward compatibility reason we have to keep it though. So
> that gives two choices:
> 
> 1. We don't add new API, and its up to clients to check what actually changes.
> Documentation to help this would be nice.
> 
> This is easy driver side, you just emit more SOURCE_CHANGE event, and get a
> performance hit on client that have not been updated and just naively re-
> allocate.
> 
> 2. We keep V4L2_EVENT_SRC_CH_RESOLUTION, but introduce SRC_CH_REALLOC,
> SRC_CH_COLORSPACE, ...
> 
> We still endup seding more events. If the flags are exactly
> V4L2_EVENT_SRC_CH_RESOLUTION, we have a legacy driver and can't assume anything.
> Just realloc or check in the format details. Then if one or more flags of the
> other are present, use this in order to minimize the work.
> 
> In all cases, a drain operation must happen, otherwise you would not know at
> which boundary this change takes place. I will mark this as "Change Requested"
> so it is removed from my queue. If you want to continue this work, I think this
> is best plan I can think of with consideration for backward compatibility. If
> you go for 1, no new API is needed, but perhaps some better doc would help.
> 
> Nicolas
> 
> 

Thank you for your explanation. I agree that method 1 is more reasonable
and easier.
I'll prepare the V4 driver patch based on the method 1.

Regards,
Ming

>>
>> Regards,
>> Ming
>>
>>>>
>>>> So add colorspace as a trigger parameter for dynamic resolution change.
>>>>
>>>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>>>> ---
>>>> v2
>>>> - Add V4L2_EVENT_SRC_CH_COLORSPACE for colorspace source change event
>>>>
>>>>    .../userspace-api/media/v4l/dev-decoder.rst     | 17 +++++++++++++----
>>>>    1 file changed, 13 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/userspace-api/media/v4l/dev-decoder.rst
>>>> b/Documentation/userspace-api/media/v4l/dev-decoder.rst
>>>> index ef8e8cf31f90..51d6da3eea4a 100644
>>>> --- a/Documentation/userspace-api/media/v4l/dev-decoder.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/dev-decoder.rst
>>>> @@ -784,8 +784,8 @@ before the sequence started. Last of the buffers will have
>>>> the
>>>>    must check if there is any pending event and:
>>>>    
>>>>    * if a ``V4L2_EVENT_SOURCE_CHANGE`` event with ``changes`` set to
>>>> -  ``V4L2_EVENT_SRC_CH_RESOLUTION`` is pending, the `Dynamic Resolution
>>>> -  Change` sequence needs to be followed,
>>>> +  ``V4L2_EVENT_SRC_CH_RESOLUTION`` or ``V4L2_EVENT_SRC_CH_COLORSPACE`` is
>>>> pending,
>>>> +  the `Dynamic Resolution Change` sequence needs to be followed,
>>>>    
>>>>    * if a ``V4L2_EVENT_EOS`` event is pending, the `End of Stream` sequence
>>>> needs
>>>>      to be followed.
>>>> @@ -932,13 +932,17 @@ reflected by corresponding queries):
>>>>    
>>>>    * the minimum number of buffers needed for decoding,
>>>>    
>>>> -* bit-depth of the bitstream has been changed.
>>>> +* bit-depth of the bitstream has been changed,
>>>> +
>>>> +* colorspace of the bitstream has been changed.
>>>>    
>>>>    Whenever that happens, the decoder must proceed as follows:
>>>>    
>>>>    1.  After encountering a resolution change in the stream, the decoder sends a
>>>>        ``V4L2_EVENT_SOURCE_CHANGE`` event with ``changes`` set to
>>>> -    ``V4L2_EVENT_SRC_CH_RESOLUTION``.
>>>> +    ``V4L2_EVENT_SRC_CH_RESOLUTION``, or a colorspace change in the stream,
>>>> the
>>>> +    decoder sends a ``V4L2_EVENT_SOURCE_CHANGE`` event with ``changes`` set
>>>> to
>>>> +    ``V4L2_EVENT_SRC_CH_COLORSPACE``.
>>>>    
>>>>        .. important::
>>>>    
>>>> @@ -946,6 +950,11 @@ Whenever that happens, the decoder must proceed as
>>>> follows:
>>>>           values applying to the stream after the resolution change, including
>>>>           queue formats, selection rectangles and controls.
>>>>    
>>>> +.. note::
>>>> +        A ``V4L2_EVENT_SOURCE_CHANGE`` event with ``changes`` set to
>>>> +        ``V4L2_EVENT_SRC_CH_RESOLUTION`` will affect the allocation, but
>>>> +        ``V4L2_EVENT_SRC_CH_COLORSPACE`` won't.
>>>> +
>>>>    2.  The decoder will then process and decode all remaining buffers from
>>>> before
>>>>        the resolution change point.
>>>>    

