Return-Path: <linux-kernel+bounces-892299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F284C44CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B926F188C9BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CF523C4FD;
	Mon, 10 Nov 2025 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="RcLTX6GQ"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023100.outbound.protection.outlook.com [40.107.44.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EDC233707;
	Mon, 10 Nov 2025 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762743029; cv=fail; b=q1o1N2/0IuzjOoySKyYGwZOt+m0TMLoyi//Hh3jbg07ce/Dg8CuxT99QTbdiGiWBViYOhcaiBbyqr/yKFh3wYeZ2d6ACbTPcinkAHS95WRl/YuMfm1o2EDitOhPKM64IeFjlvNUc8g/mugpTbZLZWJeC6O6x25rzMQSFbqt0rRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762743029; c=relaxed/simple;
	bh=3nlxRlwYYK9hKtnv6GxMfaE70+hEJVCF8m1q0pkJMz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KwUtzNaPwo7N6G7hW06CtqACBXRtMtpEsYASt0M63wZD8ddtfDrRPVlgh09mIqPm7ntwLJAPCLWiN6zLw11/l/LVVv6xXcK+MePmX3Dh7Bs8SuoUuHjfBCI5sjxuBhDZehIS2jujsVEjVjJbbNIYkXm1a1dTX9m/Ul0Uynw0mJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=RcLTX6GQ; arc=fail smtp.client-ip=40.107.44.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWQLSFfk+i0WlpWjw2kHz6noovIJ25sqsYzfZ0eaUx1nndLYzscwte+vNPigpKstyN40bV6gk8mUe42/LZdNZ4pfxpyqhaODxTGOUgs3MbnHXyaHF6wvrOzqFRP9JXT2aQeVgBdD3zMdodZhaKJF632WeZoLj7eTyhMlVXY18Zk3RntDnlsnUEwSdS0eeo3ZkRSZaUnValSgEJX4N7eES/Mp904XUKdH1/euo1KU8WOHt8J+/4Ng9bJ7y1JdXN7pKi17hHo/dIjmp+rsnlv0wJi4H8eyMBW8Ix2PVrnKGm3tbAGjU3A7ogt0yKqIGNjjv5TKp/I2p3mm0nlro7NB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+npg3JgvV20C4F4h9AgUZAk0WszRM4esTGfJkYT8vk=;
 b=uulbYriPCZ3i9t1YUni+aalNzk53P+WFNVP14bRcq49YU4pI+gvDMFjB8HEjOIz6eImxYqnjDaeBMl1QROIp4FVB3bSc0Zt7aDYq84uUvxs4nC2m2qd5ETWBasqs7NzupDr0aSO378LkVGYO0JNbJIhaPtMShkaw95zUSydQ/8kJin+60eP6AQ4VRqyb5e1HoKtlU+NsjfhS+95mDKByqtKIkaenar3jWFy0fyaH7ISjZUuFj9jw419OxbVL2GXuBo1u7aC58IhbNoVawOp1DbL3Uji1i4QSwjX8UPg0CdqE38Jxb70KIgXcYgd35EvJ7iQI2I3/h91wZzRVtH3+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+npg3JgvV20C4F4h9AgUZAk0WszRM4esTGfJkYT8vk=;
 b=RcLTX6GQaWvV6YSJSEXNR8Wrlvq849rfelC1owVrM3s2qYctSFNjcY9l3B/HPvDiGNcSOCYkxHxcvydPYNtkTgjceJiEz20wybaNhZeL4Sze4+PsFplGTGwQ03r53u/AZMxFwVD3sYUvTmWo0PftI2P91WF6SzojTK1mgAkmFV71PonVPb6poYCdYY5uabQxZC/TSF1At15FpBZs2tiEsQbdLN+ERW2bcKsOQVsuIOLMKVlvj1d18RaQbKWZCJdepiSJr9+6Gt2txGvlH3PBN2rAgg51GMN9RLiBQCfWhGLZeGm/V6fSOPcXqGG7UHW/h28Tqdi6zSiFhG6pzGFONA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SI2PR03MB5786.apcprd03.prod.outlook.com (2603:1096:4:150::10)
 by PUZPR03MB7015.apcprd03.prod.outlook.com (2603:1096:301:f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 02:50:22 +0000
Received: from SI2PR03MB5786.apcprd03.prod.outlook.com
 ([fe80::3f37:cacc:420b:9b86]) by SI2PR03MB5786.apcprd03.prod.outlook.com
 ([fe80::3f37:cacc:420b:9b86%2]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 02:50:21 +0000
Message-ID: <a43d769b-bc61-40df-aa96-c67eb30105d6@amlogic.com>
Date: Mon, 10 Nov 2025 10:49:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] clk: amlogic: optimize the PLL driver
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
 <CAFBinCBSjKzHZ_k+c70B+YsJHiOS4qbjAgtnWaEeQy11xg94cA@mail.gmail.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <CAFBinCBSjKzHZ_k+c70B+YsJHiOS4qbjAgtnWaEeQy11xg94cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To SI2PR03MB5786.apcprd03.prod.outlook.com
 (2603:1096:4:150::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR03MB5786:EE_|PUZPR03MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 341109da-64b1-496b-4c6a-08de2003e404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmhieHpvdVJUWmxFTnRDMlpQaHF3dXVyMWNDeFVMeE5QN3VkOEw2emNWVUtD?=
 =?utf-8?B?RmY5T2NDMWNzbFBjS0hhbWVCNVRROURLdkxrUnNaSm1WUkcxM1UyVXpzMkMv?=
 =?utf-8?B?T3JkbGtKSUtsamVUb1BNMHZ2SFZLbTZhaHFmM1N6dzJBNytmU1lIdHJMZGRx?=
 =?utf-8?B?bCtqSUZuTjh3ZHNJR3ZZSWFZeUhzNWFRaTk1WUhLaGxocUpQYStQU2NWdkxt?=
 =?utf-8?B?YUQ4eVlhdlJjMzNSMksyTnNzRTVvVEFXUTZRN1gvWjh4NkxhWlp4VFBMSGdS?=
 =?utf-8?B?eEc3NkdoaEp1SjFqVUc1c1d1N3ZBeDVQY25BaFNlU3QwSVJJbXNZYWlGWDly?=
 =?utf-8?B?Vy9sRmV1UVR4OGhKYXNkL2F4NVhUVFdGOXRHUldqaDF3eFVJZExVUnV0bkpY?=
 =?utf-8?B?Y0ZWdVo5Q3RVUm93UGFGZ1pEOGhlZzArRWtVUWRLdUt3RDBiY04vNWtQWlR1?=
 =?utf-8?B?YmJQbWFVUzMrZlFoc3pmTmcxcHppS1FMSE9JZDZSV1Y4VGgxenNZM2dpMkVJ?=
 =?utf-8?B?MjM1S2tFd0xVTEx6YTljTmgvN2pud3RJNjl2ZVFZcUREeDZRYUZrTW5kdlpj?=
 =?utf-8?B?V0JRVEUzNnM1VTlhZzN5SStLekY3Q2d3THdwcE1PUkFTdmhSa2tiTlR5aFMv?=
 =?utf-8?B?RU5MZWFIU0swY3BUZXhMU2FmcVgzK2pYcjNhdUE3dGIwWFN3dWRoSDNQL1lS?=
 =?utf-8?B?OC9QazF4NGtTZzBGK0pMNnY5WTZDZHV5TTlkM1d4dTFRTC8xbWlvM1Z1ek5W?=
 =?utf-8?B?SmxtRkZ6S3hHS0wyb3VrWXBydTAyaVoycDg4bjVKMnJ4OCswc2FQdk5kOUdB?=
 =?utf-8?B?SnNac3pxemlVUjFCRmVTWm40UmJGVnlaUFVOWjI5S25UQ3JNWU9GV0tveG1W?=
 =?utf-8?B?b2VzN04yL3BLdS83Q2xxWUtFVDc2SDVLZmJ1UVg2MHVpMm1zWmRUeEpyNmVr?=
 =?utf-8?B?ZTkyMFFqQTZ4M09KOTNHWXNSUHd5VDdGc1JwR2FRS2dsUmQvZTNIQ1pJY2Nu?=
 =?utf-8?B?dlB5RFBTaG1lemI2a3NLdW91emFWNTM4SHgyZGhYNkVmc2l5ZU84QXJ2Nldm?=
 =?utf-8?B?NXdqN0E1SEFhelNWQTdpL1hVU2dVUzBZRWt4NVlMN1M2UnlDNUZRZHh1enNl?=
 =?utf-8?B?bXFBempLVFZlNUtCRmFqKzZDNDNBOFF6SWx6Rmw3VG1uYlNSVW1JVnQ3cWNp?=
 =?utf-8?B?aTlEVnZWQzhESU9ZQzdSZVNML3FJZ3YwY2g1UE9NL21OR09SN3U0bThFTW1a?=
 =?utf-8?B?OUV1eUoxaElURVIwc2ZjZTdzWTBjcWFSQXE2RE1XMDBSK2s3YUdnV3JjS2E0?=
 =?utf-8?B?dlhORjROK3ZsVnNrYkkyaFVNL2R5MkNsL281c0ZuekZybk1Za2wzaXM0S1BZ?=
 =?utf-8?B?NDNjS1FyeTgzcS9WSjFoRTBMU3FpY1JzdzhpNjFpYnk3QlE0SDFPdGVtcmI1?=
 =?utf-8?B?Q2draisrV3NQSW0rOVhybDFTYi9UbDBVMkIxZnZ0dTR4SCtUNW1FNGRuN3pv?=
 =?utf-8?B?WURaKy9wWjRpb24vdjRnN0x3dy9pemNZek9TcWZJTUF4dW92K3RNUzhqWmxH?=
 =?utf-8?B?QnFURk9kdlRtMFpGd3BxanQ3cDdGSWNlaG9XYnpzdC85UW9GTnZaZGgzbW5K?=
 =?utf-8?B?RGdGcTNLa1N2d2xTbHU1OXJSbVhYenlvZW9KVEhiVjVPMXNlNTFYZkZZeHdr?=
 =?utf-8?B?Mm1YRU5UbFk2ZEVEcVV3Z1pNSTI1ZTYwbEtHNjJDZ2VZWVVDSlRSaVIrNytC?=
 =?utf-8?B?amFvZEVyUkh6MFpTa0gyK0phdUUvSDE4UWV4Uk5ucDhHTnZHY3FqWUJwR0R4?=
 =?utf-8?B?VWxUcjErNTI2NjVtVU51RUJxTWlhM1NJWWNONENFNUFYK1JoMTdkTGo1ZnZa?=
 =?utf-8?B?c09xdERrV1BjdDNXcW1NR2JNSVNBeDNOTys3Y1IwQ3Jaek5pU3JLd2FQVUd2?=
 =?utf-8?Q?oXLhySewnJ7omE0X/WBCMrmi9Z38AKKl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QSswU1VHRjdxeUVIMlJydEU4K1JkRVVzOWQ5aU5MOXJVYWpxT0JJRVAwZmF1?=
 =?utf-8?B?QmpsaFk2S1FHUnRndXhNcDkvSG5odTJxWGZCaTBWaVpieHJmcnVqczZxV1FF?=
 =?utf-8?B?eTdUYTlmRDkxRGxvOWVNOGxGSVZXR2tySkZpTy9INTE5UHV0SXBOTndhZXdp?=
 =?utf-8?B?cmRtejZaeXhwWVRGMUZQS3hVeS9HQ0ZjWjloQUpkSTlkTWczZ1ZVYTZLZ2RS?=
 =?utf-8?B?UmM2Q212OWhWaThBa2R2dCtXRG5tRkFzbFF1a1h0V3hqWjlHVGJDeE45WjQ0?=
 =?utf-8?B?U24yWk5KY09KUE1sZXFudTUyMW1Ia0pkSjM1Y09WQUFocVRPR2ltRWltOEpL?=
 =?utf-8?B?T1dJNEJ1SmUyYXJ6azkyZUZ5Q2JaTVNQK050Q0pKM3VSbGFERkxWN2RPMUNq?=
 =?utf-8?B?eSsyRU5GelVuM2ZCeGJTY09ZSGNuU1BHQlV1YzBPMjFISTUxY3BTM1J3eUsv?=
 =?utf-8?B?R0JlWkJtUkozNGFZQ1JNTmhDamZRWnczVWl5K3VZcG1YZUxFU1JMbE5PMm5O?=
 =?utf-8?B?b0poNUhyS0VJd1dyWDd2TWxIRlJ5U1pBSGFCaUhvK1FKbTQ5MWJjL2t0azFs?=
 =?utf-8?B?aEttNzJEbnJLT3NMMG5udnpqa2wyb2JkOTlXSFpHTmVQRlhHd0ErRkJvNWNX?=
 =?utf-8?B?eXJCbzc5dVBuZzZnZGJLT2NScTA5VnNSRG43Tzhua3B4ZU1uMkowSjc4Q3RU?=
 =?utf-8?B?VG1Ra2NvNUt3U0dmUHIxMlU1SmxCWjJkWmt6N1dXWUFBalRjb1RyTnlkY2lj?=
 =?utf-8?B?MVRIYmdJTURDeTVQY3pDbnQzMDd0ck51eld4akpBUWNiVHB5T1FTNjJzcVpp?=
 =?utf-8?B?eWFnK1RQemRmSkxycGwweDM3Ky85b2k0OVJTV0oyOUl4SmFDRzBOK1B5SFh0?=
 =?utf-8?B?OTFZVit3TmZ5Tng4TGM1ejk3T3UrNHQ4Y0NlUnQvU1Evc3IrRm9wckhTYzgx?=
 =?utf-8?B?aFIweVJiRlFrUDM0VHcreEppbXNkbVd6NnlwT1cycG4remlncHcwbHl0Sjky?=
 =?utf-8?B?VG11ZXVHSUNTUzI3RytBM1NCRktheWtPTTU2azNaNGtpdjNPbFBrUElhTXFQ?=
 =?utf-8?B?U2N6NjhIdE91UEtmNU9BYUd6Nmd2eU1WNGZlcHJqaW1sWkZPTysvUVpGcWd3?=
 =?utf-8?B?YmlZZ3lrYThJdk5jYTlubGJSSTlLRVh2eEE4VVB5S21VVGpjOFpMQmxrdENF?=
 =?utf-8?B?N3Q1NmdKOVpzYlFBODF5bjdTZUQrUi9NZG9WVFJrY1NaZHhySmZublRoU2hR?=
 =?utf-8?B?VWo0b210N0J6RjVBNHFUUURDMk1WajZuUEMzY3JmaUFBMlZza09VeHVEemEr?=
 =?utf-8?B?ci9oemYrTCttV29XNG9BV0Qwb29NZU5ZSDJxMndreStIUm42OWE4NDFQRHov?=
 =?utf-8?B?SXdReHBabmRpK3FnY0R2ZHUyTHArbUIwRmY3UFdZNldNS0g1WDFrVHdjdUl6?=
 =?utf-8?B?U1B5dHhjUXJMVE1zR1FYbitLdGNuK2hjU25nSythRVkwRG9zbnlNdysyOVZL?=
 =?utf-8?B?ekJjbXJ5UzVjZGN4OXE5UlFvWWIwWis1S3lSWW5JaEVONm9zdlZPM0NZY1lj?=
 =?utf-8?B?dU9LK0EwZU9pSmZiNTlmOHhGMERMSHVxRXl5TzlTK2hLRm9WTTdLKzI5NXox?=
 =?utf-8?B?SThoWWpldS96TVgvRlR2YllLZUVmSXJsbTN6OHU5VUhVREZlb0FXTkJwczAx?=
 =?utf-8?B?Q3c1WWlPOGVUL1lCdnN4V0VVZ2NTSThWYUlWNU1XTkcrSFlwVmEzTzBDdkpt?=
 =?utf-8?B?R0F6dUhJeEsyQVVTTkZyQmNMNFo2ZkEzVEhWZzFickYybVFudldVQ21JMU9O?=
 =?utf-8?B?ZnNwaDF2QkpydXJVRldWRlk0d0VOK0xtSkhldVZXcXpGcGJjY0ltSzByaFQw?=
 =?utf-8?B?TVBybUFGUmVFcm9DZG5TWmtFMGxCWmtsVnFoNkxlbW1rYThQQzVucDYydVBT?=
 =?utf-8?B?c1ZXNEVmRFdrR1o1ajI1RmtvUHRveHdrb3Q3U0swSUNOWU04dnljS3VEQXo5?=
 =?utf-8?B?QmxvRHQ2UjJXczhadEN0YXgwVTJjTVZBN1FQYmRtRXZpSDErWDhBWHV0ak9S?=
 =?utf-8?B?eVVKNVI5Y0VPcm9UV21LL2RCUWZuKzVLRi9XVG1SbFZFYXcwNXZZTDNzcWxY?=
 =?utf-8?Q?NMgVe69fXkrgQSSgu9C232K6Y?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341109da-64b1-496b-4c6a-08de2003e404
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 02:50:21.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dLPwhlzp9FBf8QWcABilgWyc798TzQzD3YbmRm80C8Z0PZAQFeM9ScRQyhTaRHTKRcpnbwSU6sH8fvYGAaDug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7015

Hi Martin,

Thank you for providing the test results. I previously found a
Meson8b board and wanted to try a stress test, but it threw errors
when running in the kernel (maybe because my bootloader version is
too old)... Anyway, thank you!

On 11/9/2025 5:04 AM, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri, Oct 31, 2025 at 9:10 AM Chuan Liu via B4 Relay
> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>
>> This patch series consists of four topics involving the amlogic PLL
>> driver:
>> - Fix out-of-range PLL frequency setting.
>> - Improve the issue of PLL lock failures.
>> - Add handling for PLL lock failure.
>> - Optimize PLL enable timing.
>>
>> For easier review and management, these are submitted as a single
>> patch series.
>>
>> The PLL timing optimization changes were merged into our internal
>> repository quite some time ago and have been verified on a large
>> number of SoCs:
>> - Already supported upstream: G12A, G12B, SM1, S4, A1, C3.
>> - Planned for upstream support: T7, A5, A4, S7, S7D, S6, etc.
>>
>> Based on the upstream code base, I have performed functional testing
>> on G12A, A1, A5, A4, T7, S7, S7D, and S6, all of which passed.
> In the past I had most problems with Meson8/8b/8m2 CPU clock scaling
> (via sys_pll).
> So I tested this series locally using the following shell script on an
> Odroid-C1 (Meson8b):
> #!/bin/bash
> 
> CPUFREQ="/sys/bus/cpu/devices/cpu0/cpufreq"
> 
> echo "userspace" > "${CPUFREQ}/scaling_governor"
> 
> while read -ra LINE
> do
>      for (( i=0; i<${#LINE[*]}; i++ ))
>      do
>          for (( j=0; j<${#LINE[*]}; j++ ))
>          do
>              if [ $i != $j ]
>              then
>                  echo "${LINE[i]} -> ${LINE[j]}"
>                  echo "${LINE[i]}" > "${CPUFREQ}/scaling_setspeed"
>                  sleep 1s
>                  echo "${LINE[j]}" > "${CPUFREQ}/scaling_setspeed"
>                  sleep 1s
>              fi
>          done
>      done
> done < "${CPUFREQ}/scaling_available_frequencies"
> 
> This has been running in a loop for two hours (at an ambient
> temperature of ~13°C) and I haven't observed any problem.
> Since most patches are a no-op for my case I'll separately reply to
> patch #2 with my Tested-by (as that's what I've been effectively
> testing).
> 
> 
> Best regards,
> Martin



