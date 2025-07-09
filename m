Return-Path: <linux-kernel+bounces-722960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D42AFE125
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31D154239B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701B326FD99;
	Wed,  9 Jul 2025 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="PIqJw1nP"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020129.outbound.protection.outlook.com [52.101.69.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E002AD2F;
	Wed,  9 Jul 2025 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045510; cv=fail; b=XPQ7H+DTvLxxsfxIhP/nCxdUFGbT9WIYzI+Yz2Xl903WsH/y3ZzIWwz5chqQG9BbWtgM3+3mr/Y1XRaqZjcOlAZv7XqYjzF2DvCrKNUr1MGkN98KaChPk4kj/rlFfnmcgwAHJvYj3yzlZZmrm5gVeNRTg0hGARJnWPseSxJnOaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045510; c=relaxed/simple;
	bh=opd9LSJkeqnBazaZgAjB9XJYBZBZsniX6CHGeYnyqi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J2Qq3qx6uvyJEPkI8OotqWnsU9H89KVG0SD0w1pz/nKiz/1LvZ7hhBcHJetgnoDDb91UE2Nm1BaebMNQTrRzEBizcO8XKHGOi/oVb1fSpz7Ntcbuc1OJUP19nvYMjwqrfDKaaZdgkr7RqRawU7YUKRyVcfVMANMs8iwrGjSIsjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=PIqJw1nP; arc=fail smtp.client-ip=52.101.69.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvLAjoD9fdMYW2oK3iCICIAuRc8UyYtn2+S/3ZOwnKxHn5HnzX9KPId4aS41f73wgcMe42xQrDosNi+DStgANadtwGi+FEIRIXFbKKPivZNV9kkEEDBJVcaF64I90NOG4nXWih0fbIbbTjjXiK68oUF66uIa/Ov/pKxF2k38kNswckl0fgjCbaM5nNNsuSUGv0Aj+Rg5+GmSM3NOaqp7fpkv1IdzqR7v9Ib2b96au8acMSVEexVIRDlyaFkch93bToq1WGZx7Ql53DUM9YwbT8+12i1fl8QX4NZFSftd2+maOKmA/FnUkXgZOxd1FRHUvgOlIJuu/Uhsce1PnpXeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKsqRNLZ3Lpzo8jBdJvPKgxKSLbcSIOiKeWv/cQ6CYw=;
 b=Hbh+rxuSemhUJ2d+JYpMFlogxvda2XM/qvOSnnJMSvcBHyqo1KXSczaH2SYvexzEidhTOUWghnDGtkyo5c9jxrVHgaOiAwdLVfKtjEZbTvlzYnKh5XdYhf/0Xf5gY0/YC8kZypbMw4C3KrybDgfvyYVJhBWMnyf6/NkFZNXALRQJAOeVuIdJwOfTRTW0bMa1BIVeYsM1y1SmwD2vozT6B7xnrtnSNSPFBDEkeN0EK15UK8w6ljhQ+s0DlEVVEmxoFFEaEy91JFPBucB7mDau+2rUh5Mem23Y25YjtgD6/8A/WKJOUw2iNZjsMGPiG7Dd5NQZhStSaVms9TTGtSY/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKsqRNLZ3Lpzo8jBdJvPKgxKSLbcSIOiKeWv/cQ6CYw=;
 b=PIqJw1nPe5OMGrM1a7SuzJgYX4ttKfUPdTy2vRhoxOEHAg5HzKzAeHAk1/W2N9A8ePtm3eoWqLRYLqfTogzuHnawa+/tPdgnposWnmaTm0/s8JR0jP/FhLi3ietatui/gGWspZmFEifDhCPvYtycx7jRX/WPEUFQMFh5l/JBE/gKZ/w1PuVhhFUI+Sk2s8Gq5XvStsfdvgr0ZfL3UjjwpUZyfMo7Ny6Yu9nWC+cWAHi3trdbhv/2DYNt7XfjNfUZJXaJlAj25hzZq35bBeOGr4/qq7fCeTkWdCf+Dn9sgRlC6vtm9AQ/A8FibPNu8j6hlRX5XvE6jVSUmuagN1jEQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS4PR10MB5248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 07:18:23 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:18:22 +0000
Message-ID: <a5712254-bb68-429d-9297-bd334ee568bd@kontron.de>
Date: Wed, 9 Jul 2025 09:18:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6ul-kontron-sl-common: Add SPI NOR
 partitions
To: Frank Li <Frank.li@nxp.com>, Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Eberhard Stoll <eberhard.stoll@kontron.de>,
 Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20250708125607.66113-1-frieder@fris.de>
 <aG1cCK1U7cs+Jf1n@lizhi-Precision-Tower-5810>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <aG1cCK1U7cs+Jf1n@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0310.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS4PR10MB5248:EE_
X-MS-Office365-Filtering-Correlation-Id: d7820cee-f9c5-456b-a651-08ddbeb8c9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVgwL1gzRjhTb2NTd1BTb0QrekFmWVhsLytrbVpxUkY4eEVYU1FZai9Ra1Ba?=
 =?utf-8?B?Zzh6VUlTL1RJd0doTjd4czI2OTkvUUdtdUNZSGpxZ1ZFb0REQ2JmZ0NKSVkx?=
 =?utf-8?B?Vzl4TXd0Q3k2d3RkdlUyVmtkaDJmRnlFeDVtRjU3UC82Slp5dkdXem5kYk10?=
 =?utf-8?B?a1F6RVFCVTJmdzRIVm52RVZwZWtMWHduRmM3N0RMNDRlallsMzNXTitKcVdO?=
 =?utf-8?B?YVpLOXZic3pmd0NYRVk5NlUwVm9DcG9QalE1YUx3Q2Y4QWVWalhyMWtKVG0z?=
 =?utf-8?B?YjVianl6aGxtYnM1YWlXbWdsMERNTmxmaTNLSG1ROGZDbU1TbjA0Qk80MVU1?=
 =?utf-8?B?RkdoUkErWEEwOXUzcjhLMDkybXB3bVlhQktnRkh6dm5YNG5GenpMR2ZaVDJ3?=
 =?utf-8?B?cThqR1JZZlpnY2g0bmkxTUNlT0ZEamEzaUxGM08vWkxydGNGNFpYM3pyb0pu?=
 =?utf-8?B?QmhSRHF3YURTYVBacGZSVGJkcVhLVSt5YlRPY1hrZU1FRExJdFVYekVFcW1n?=
 =?utf-8?B?SFdsd0MrNDRkdnRBVWJDL2ZVS2M1YmtDZi92RkZhL0RyN1A4SERvVmFwYUw5?=
 =?utf-8?B?emtyc0kyRnl2dUcyT1lreVJMV2dPUFZ6Z1RQdms3cXgzZ1ZDQUpBTkF5elFN?=
 =?utf-8?B?WStEOTdKSW85ZGlmbXB0cm1WQW51Mk5ZQ1BHK0ljVlAwMHZZekRiUmtzdmtu?=
 =?utf-8?B?SVQ4TzhTdGExS3AzT1lUYjh4V0RaVGJvTGFVekErYjJoRGxWWTZLL2R3OUZO?=
 =?utf-8?B?ZHprWWltZWVRZ3k3bHJzZzQwNU1aL2d4b2taZTlrZDFnRzdiRnM0d1RVZUt6?=
 =?utf-8?B?Z0hUYmY2WitLMUlUbE13RWtpcnV0cmNXcnFCK0pYeDNTNHpxbXZUWnVWWVI2?=
 =?utf-8?B?V2ViOWxJMFJmM0oyK1RXVnBpYlVkN1NTVXhrWGpNTFB2ZDQwYzNhYU1RQk5R?=
 =?utf-8?B?TzZ4T1BXalpnOGJRTzZIVU1HY1dGOE1iVlhUb2x5ZlJ6T3RQR1R6Q1FVczRX?=
 =?utf-8?B?ekpWUzRRRGZlOXpaS1JmNTJBV3I5QlVpdTdnbm4yUVEzL05FbEl1OXRnbTVT?=
 =?utf-8?B?MlN5SmRaWHBpdExQUFFHZ29ZemJDd0pKVEVjMGdBWlN1YUhPY3FrK1duVjUr?=
 =?utf-8?B?bzRqZnduSEF5S1pyMHk1a3BYSERMZW4zTUROZk5Fam5VcVhneXFkMEo3Yy9h?=
 =?utf-8?B?NCtIRmdBaVhjWVNTai9iUTdWNUlhTTlkWFV3bTBXeGQ2eU1sbTdZMjE5QUkx?=
 =?utf-8?B?K2txWWJLQ1p6Vk50a0J4aU8zMEw1Nmx2MElYem9WNFRMUEtVditKSXBrWDBC?=
 =?utf-8?B?dlJpR2hEeWVJUWxjVlJMa1FlUE5xeUc3YmtOODNFNkc0OFFWNFJicWFrR0N1?=
 =?utf-8?B?aGRORVBNWWpSUXI2bnNIdWZPV0R1YkI3ckxLOEd4OEc5ZnJCblg4SU52Q3R5?=
 =?utf-8?B?ZFFqQ2JqMU1HalRDU2tHNnVXSllVKzVDcjVLLzBldjNRaVNEZVN6WnNESHlh?=
 =?utf-8?B?SDYyUTRzZ3Ywa2lRbFZQVWYwWVVnOWlvSXp1cTNOMWVkcG9yM2o3V21ES2o4?=
 =?utf-8?B?NlhTbVBZQ1RHaEFiU2NEWmZBNUxGemdSV2d5bVMvT255RCtxdFBPTnRxSDkz?=
 =?utf-8?B?b0VkNTlLdXBScmtML0RVTVN1T1N1ZWxMY0hqYndTZzl0aWU1Vy8rQmlrVlBF?=
 =?utf-8?B?MEozbjVtZElOVTR5YzBQd3VXWGZkRHpUZ2d6TW1yZE9qblc1MkZ1b3pBeGZS?=
 =?utf-8?B?UmdBRXhLWjZIdEFtV25HSG1JY2hSdE9ZOVVvNG82MVViTlpXUXFwbHBlQlpl?=
 =?utf-8?B?dktUaWU4QWlHOE5jcVpTMnNEYW5HLzdvd1dEZWtvY1FxdlFqSTBIdVVKOFhV?=
 =?utf-8?B?OW1BaGc5b1g2VnNWeEFSUWhVM3JCZHdCNWF3aFFFU3NYS3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dklxV0JORGgvNjhtMHBoeXd0NGxoTGRHRnY1L05hbkQwUlRzVWkvM2M0UGph?=
 =?utf-8?B?TGpCOGFFWHdYYVV6MTFVbFl3VkhYTWh2RXdyRXNjbGtiUDBuamJjbUtuRjRI?=
 =?utf-8?B?V1JiaHcwaFBoaHpwNjJKTUxVL05sOFozdm50S0FxZmhXdTBjUDRaQ0tDVHRB?=
 =?utf-8?B?VmZralV0S3BrZGlGWnZna3FXdm1LOXpscVBPVGc1ekpGNVEzZEFwYmZUMUh6?=
 =?utf-8?B?dW94bHZBSWNnaS85MVhqdWs4R3VTaUJBR21HSmI3Qzg4SnZvMzV6TlNVQ3Ar?=
 =?utf-8?B?eTdMTlBOeUpDb0k5R1RycHVXSDdnRksvYlpDaWRxQnBUMUJPZW1UZk84aTlV?=
 =?utf-8?B?NVRUZU9SamJTa0p0UXg5OTdic0FFRklEZG5MV2xid3ZFcTNGeEU0RytCZGQz?=
 =?utf-8?B?ZVR1d3RtTDJ4VFJFZzBTTGZkY2kySHNZZjZPVXMrOEZMNEQ5OXQwbTVPVVpY?=
 =?utf-8?B?L2g2djVzbmtkTXJPS3pwRHdJa04yOVhYTGxYRzU3Uk5XRUk1djhHOEdoQm9T?=
 =?utf-8?B?SE9pU215NXE0TUIydHowS3ZBck5JcXpQcHlDMUhEb0hoYVhqRlh1cDB5Tnpu?=
 =?utf-8?B?eEJ4VGkzQ3czS0dDaW0yTWFFV0tEOHlGT2hraExyNWJYRUhNVzNKanRZYlF6?=
 =?utf-8?B?SEhidFRPZkZuL0tmVWg3bXlMRlRaNi95clhjM0UyTEExL2t5VER1L056Smgv?=
 =?utf-8?B?K1QyMjlaQXkweTRXZDMyRy9XbmRScTFGV1FEYkRPeEl6UkgydGRTWlZCOFZl?=
 =?utf-8?B?QmczVklRQkdlWS9TZzBsQ0JRandrc01RVWVtUUZyQnNwT0dndGVzUkpKc1Jt?=
 =?utf-8?B?Wk5zS3RYUFlUbVJUOWJQK25naTE2Y25oZENDTUc4Ykd6RUhxd1JhSlZSVHBl?=
 =?utf-8?B?c0h6a3FROE5RcXZxR1dnL2RSdnViYlVWdFNQMVVwV216YXVueEUzQ3FEV1RH?=
 =?utf-8?B?MjlycE1lRG1WWjZCblBBWHV6SE16MWdpYVZRUDJqb0FXQVc2c2gvcWpCUzl2?=
 =?utf-8?B?WU45L2lneTRDZUd0R1R4VWcySnZaOHNlMjJpb1RGUXdjQitQVDVPdTFFVFZB?=
 =?utf-8?B?Y0w0TitKWkpndWE1bUFubFZPNlFoOGlDMVRQc0pxdUVmbW0rdDZyZFZ1blp2?=
 =?utf-8?B?emxOdnpxSlExMGF2QnlTaXVVR214Q2JTNitobll6ZEsxQ2VJUlluSUJEOXpN?=
 =?utf-8?B?YVRSaUMxL05hR3RFTEJSYXBmOWkxL0R1YWRtTUdCZjVpczBjRmZvWXNaeGNT?=
 =?utf-8?B?dlpwdWplaVFZQnJiMjNwdFZxUFNrb2p2MWYrcDVRY1VIcmpoSXJiRXdLOEMx?=
 =?utf-8?B?Qks2Y3czemYxOGtIc2F6dlJxSWZzRzFFVXBVT1ZzaFlDQTl6SHN4enNuelRB?=
 =?utf-8?B?cnRNQm5BR2RDNTlzTmkrUmZjb2plWnFPR0RCR2R6Q0ttdjdhRXcxS3FLV3Fp?=
 =?utf-8?B?c0pwKy9IMzNHUlRaaGVGbjVTNzU2Q1pnUTJSYURNeUEyUkJ6aWdkT1pCanRV?=
 =?utf-8?B?WW1UU0hkbzVNT08yazZ6bEx0N1p4eG80THRHMWw3YkhiRUhCeTVSN01IZGNx?=
 =?utf-8?B?SmkyS2lmN0ZBTC9ZVmtVajQ4b2hRZXZaZU5TRE8wK2I0c2ovS2pGdk9ram90?=
 =?utf-8?B?UUJyeHNBazBjenpvKzN5SUxwd3JiT1M0L1UyRjQ5Qkh5eDRKS2c0NDNaVDFC?=
 =?utf-8?B?MmZCbDkwUDBZV0NLN3l6R1lNRm11S05jVXd0WlZYWjR6blFMQSttWXVvZzk2?=
 =?utf-8?B?Um9IU1VmL1hvZEhDalVReXAwSnBCeGNyTE5ubUhrTVpkT0VoTVVqbC9yS3Ew?=
 =?utf-8?B?ZmJmNDVMNFI1UmhncVd6VFl5bS9QUTRpU2wzNmFZSG40V0VPRjNTTVFBa3dV?=
 =?utf-8?B?cHNTODVLd2tzMlNBS0ZNRVovS2RweVI0KzNpWng0djlqQms0aWs4akNKQ3NM?=
 =?utf-8?B?T2JXcVlRakhqQWhpSXp2Sk5WbmV6V1BEUjNNVHYxU2hYK0JFOHNWcVFidDBN?=
 =?utf-8?B?SituVmEyaU5VYTZha1djYW5mNnMzWFJkR0NZOVhBZklmOFBuMnZ0ODJSN00x?=
 =?utf-8?B?cGFxRFlDcEl4U1kwa2IyRCtoem9lcU9UTTl3cjZwenRyNURsYzZGM3pOSzBN?=
 =?utf-8?B?bE42dWRZc2syeDcwb1BsRHJDV3pMYTg4N3I0aVEyMTNuRE51VlZpWUJ6V0tu?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d7820cee-f9c5-456b-a651-08ddbeb8c9d8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 07:18:22.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5VbB9V8mAchs8WkXVK2fkq1IRRUWwUFBzTHNY/1+wXQx9rhXKg45Wka+0LDFWrGvUQBFoZkSlaXpZnf0uT8U5BiLAi51t++NJQcpQ1upiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5248

Am 08.07.25 um 19:57 schrieb Frank Li:
> On Tue, Jul 08, 2025 at 02:56:04PM +0200, Frieder Schrempf wrote:
>> From: Eberhard Stoll <eberhard.stoll@kontron.de>
>>
>> Describe the partitions for the bootloader and the environment
>> on the SPI NOR.
>>
>> Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Changes for v2:
>> * Fix name order in SoB
>> ---
>>  .../dts/nxp/imx/imx6ul-kontron-sl-common.dtsi | 21 +++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
>> index dcf88f6103466..ab149c40a9cc1 100644
>> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
>> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-sl-common.dtsi
>> @@ -28,6 +28,27 @@ flash@0 {
>>  		compatible = "mxicy,mx25v8035f", "jedec,spi-nor";
>>  		spi-max-frequency = <50000000>;
>>  		reg = <0>;
>> +
>> +		partitions {
>> +			compatible = "fixed-partitions";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			partition@0 {
>> +				label = "u-boot";
>> +				reg = <0x0 0xf0000>;
> 
> I think reg should first property.
> first is 'compatible', the second is 'reg'.

Thanks! Now fixed in v3.

