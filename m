Return-Path: <linux-kernel+bounces-845753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123DBC6058
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F53D3ADDA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E5E2EC548;
	Wed,  8 Oct 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="A7XHfpHW";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="aUaTTxIn"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09532BE65F;
	Wed,  8 Oct 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940860; cv=fail; b=d1fM0MoStKqbC7fiS8A0vlFQqTugkl4CKSSp0sMm1JFAyhaiG9ubCMbwneNVqAtBIE13V2xTycCFxnOQPbUA/I3ufXadpsLdIXCvik2DS1nvEu7gXpn9m+lsBRc2jyOs6HId+MS2ocr4VJYLZxaHqqNClwpYqLqW00NiJNMIhpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940860; c=relaxed/simple;
	bh=lJVovH3rfH77XSt2Gt5KNweTWVAfSzOd+CmkI99PTPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h80f444GaKkqAL6QilmbNYcEvFahr2mVWLWG6Ik26zCNeOA40zZRmdnL3MjAHD1PHUIVhW32m7+wS8AJDoSRZ7VnvZz+TkbzZTNAWcgzmnFFwPoKK6wQtAMYV/O56r8FJMYGygXtEEohwmG68suvtuT1Vadg472lMgijCBc+N00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=A7XHfpHW; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=aUaTTxIn; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5985Yjk2073905;
	Wed, 8 Oct 2025 11:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=kJjrGi1FlZMZSQq51Kxud2faaf3FuLeYGLx1KHA0Eks=; b=
	A7XHfpHWRaMoJWR0ulRH+S4dDXwCIDIbEr4OBqiTAi4rA9io7kcOXj5qajLFO5zN
	viZ1ce9keRU0aF/lbjXocz3tkCep0KYPO5L4tv5kIZ2AcCSBHnTwuIdEB/7i3xIl
	8Ac1x5fpRIm9J7U1jefDWg5oLkp1YycxMIA6yrZ56qAClxVdv0IzFNC9sYu5QHrm
	AQOVazWn5NVZVE97nGOCa9CVzzboo3lySCZ2LlQZCBVLgsl+q2QX583XIluy4sls
	9R0Abohn5IVAIFRWYB7jmMgRq0OA5sz6U/AS5PQfBZZwoAZPB2H4DPqkLMC72jmT
	7GVZXIHFMTfzeelUf88Zeg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020130.outbound.protection.outlook.com [52.101.46.130])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49ktb7bsqx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 11:27:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuKvZcEP9ejM0ITDfdW/1nG15T7lT2xhIwpn1RM7CXWcdHnFKhP180sESY1z9Ck8mBsAwJ7VcTlLSWcea64I2XXlChao0J8cEGpJEh23M4OjD2ScjbRsFhYCqjPck2DD/qLmtD/le+agAx4c30GdhgDSvsDViwBNwdNjhYDVM93mV7YungSuC/E8oeU2ECAZDxk0GxxRp2sB30KHCB2ZUjO/tEjKIUT6K7MozMXG76L7M3paSiEuvqf2vGnmo7dXrABKA9lgJRgS3rt9qoqwsMDle8JuJ3dMj0+xfQUl1BY5Nq5BG6FiAPpvQKKYNJuBKXQkkhkJL4eXdZ/IZYRbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJjrGi1FlZMZSQq51Kxud2faaf3FuLeYGLx1KHA0Eks=;
 b=USgFbTctyZ/pgD/tGukRDm+NBoeDBRzbQR8zwuXxLfxZJCA2y1eKt/GUlaFu0b3vz99Fk0eHwcgz3LpPBSV0kMuQ67WSSD/8WRgnWB86PLnrfTEOWOEOKpIGtc5VIkXeloOH9aFOnBR8SSecyPF8yuNSk4di2odOYgkkcAwwaGnDCswiisMiZFuwyP2N/yzGagC4LXpb6KDT+VGS4BuJbjM6MHnQv91hHdFKJr/isgR1S7rNd/b5gJXHDrWcEa8HIZihVt4R15s2VW2dukuC9QIX+Lfbb+32CAPz68rbku0yDIDtY13wdmqZVdkmjKFMEEo7ZOj4nbc9pCTm78UPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJjrGi1FlZMZSQq51Kxud2faaf3FuLeYGLx1KHA0Eks=;
 b=aUaTTxInohmCwQ5V1qHfTRyKTR9BLrnIpe8+Ei8JknCQwY1kwCyP4wWRbZBm0kPeaFnnPO9vJAsMrUAtKlFHn2qM0168kOiJqFzXDyqKrSQtU4yVbzXtYwCmrvC0NTOZYHDfiairzrG/Kihea4cNrgsgSMfIQuC2gZI4Rk8ZbUs=
Received: from PH7P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::35)
 by BL1PR19MB5746.namprd19.prod.outlook.com (2603:10b6:208:391::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 16:27:15 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::e2) by PH7P220CA0036.outlook.office365.com
 (2603:10b6:510:32b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 16:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Wed, 8 Oct 2025 16:27:14 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1C86C406540;
	Wed,  8 Oct 2025 16:27:13 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0D79E820244;
	Wed,  8 Oct 2025 16:27:13 +0000 (UTC)
Message-ID: <53ba5ea7-ab5f-41dd-853e-2e39efac1321@opensource.cirrus.com>
Date: Wed, 8 Oct 2025 17:27:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoC: wm8978: add missing BCLK divider setup
To: Brian Sune <briansune@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251008160452.1741-1-briansune@gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20251008160452.1741-1-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|BL1PR19MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 37441f9b-8b0f-4892-eb66-08de06878a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGY0djU4a3BhVXliV1RyTTI2U280UVNqd0l0UFFtbTlpVmJrNmhoYUUxV1VQ?=
 =?utf-8?B?ZElyK1VleUVYeFg5cmkzT3laVmdwTkJlYTZEWkM5cXEzZnltcHBBWkxZSHR1?=
 =?utf-8?B?aTYxR3pUc3dTV3V2WUEwbjlBckIrM0JKS3k1bFFENmthdTNUb3BwbFJtWlZq?=
 =?utf-8?B?aG9IRWE0NitobHducWt6TWlKMU1Kemd3RzR2RWVoTnh3d1plVHZQcHRsdEk5?=
 =?utf-8?B?MFdsc2V6bDBqVS96dFZNczlSdFNJMThVRUdRb2J6UE03NVFSOW9lT3BsaGgx?=
 =?utf-8?B?dWt0L1VFUEQrYXEvZU5FMjlNTzhEOWJwQVZnOWVlcDlLZU4rV2MwMTRjc1ZO?=
 =?utf-8?B?WUEyV0xweDc2Z0xFQTA4NnhoTUdSZWNZSE5LZ29TOUh0NFl5b2tBQTl6Qk1U?=
 =?utf-8?B?eTZRQk4yOUJtVVVQVWY1bi84YzZSaEI0K1V0WnAwRVM4VW9nd29FbWpWM1Zh?=
 =?utf-8?B?NDgwWkZUeUFpYktxZ1RqWlRqRHJzeFV6TlNGOUlRYldKNlpVN2Y3MXJzcnht?=
 =?utf-8?B?alVDblQ5T3FTMkRMa3d6SUNzdFcvQTZnS2JESHN3bTUvUGZlM0JnaGYwNk9L?=
 =?utf-8?B?MHM5VUxGQ1lNeVJENHRodEFNa016SkQ3VkZEb0IwRk8vSFM5UFdEN0QrZFhq?=
 =?utf-8?B?c1J3bjZmSVlRajZUMHlLcEl5eTFVYnlFWkJOdmJlWU9keW80eXBIMHpiMkRh?=
 =?utf-8?B?WFl3QWpHQ0NXYkNQYjlHWkdXVXpzQTJDcDhSaEpBalEzYjdvUFdmczdJbFlk?=
 =?utf-8?B?WWhiQ1ZBMjRzQXVNN2ZHQ0o4S3A0RmpWaWRDUzB3T1FUakVpM05tUnp6cDlz?=
 =?utf-8?B?R2t3QnQ1UGRuZTZaK2hsNU1LRElLZVF1Tk00Z0FXTnBjeE92Q0xCUWxBWWVN?=
 =?utf-8?B?TlBGNWNrRkxPWnBkd09uSjUwS3p6NjlLdkorS25BTzU4RXhmWmhCUE1HZ2Vo?=
 =?utf-8?B?RnpvdVBaYmcxZndoQzFacWdDWHBITENVWkx6bUg0YzJZNlE3eVhsOE16NDNN?=
 =?utf-8?B?cHlVc3gzNWJQVmN2TTVXK1pIZmdzSElGNHNsN2w2M0t5OHRSakNJQzdGeDR3?=
 =?utf-8?B?cFFBQSsvMVV6aGZUSHYzT0xKV28vRno5WTUzQkVKaVY2RWk5YWo4ei94aEhm?=
 =?utf-8?B?R0Q1ZXB0SnZNRFBrcFlzK1FuQm9yeEQwM3VQZnlHOUVNY1k3VGowSWtNYlFl?=
 =?utf-8?B?bE40YVNPZ0dYZWxuNEk3L1lTbVJlOHNOZmFoN243eHFJRjFpQnlIaWJacTNC?=
 =?utf-8?B?b3ZqeUtsOGwwYmFVR0lyZkZidEl2djQvZzdFTmFJRm9iczl5NXl5aklrVTFT?=
 =?utf-8?B?eDFtVW40WVFNVitwUE1ENERHdjhVU2M3dmlrSitkWkQvbkE0eXhXWG81TGVQ?=
 =?utf-8?B?NUFjaXkrQWI4Ny9hS2tFay9NOGlwNTFVVnQ4ck1teFdXWGFzSmxLVk5mQnJi?=
 =?utf-8?B?NERjTE9OUzdTanRwV042R0NnUCtuU0E2VWdTRDVxaDhDZ3pyVllqZ29saEhh?=
 =?utf-8?B?OS85L0kyaEN4WEZ6V3d0TDhCMHlGTHRCeWxmMEZvTHhiM296TmFYbHlzOXJD?=
 =?utf-8?B?cGFTeEMza1JsRUFaeHhxWFNSS1dHNWY3aFgrQ3BTK2xGZC9YM0J0U2tMdUNw?=
 =?utf-8?B?TGdyVHc4R3FVOGZZai96ZWw4bHVMMzJJc3J1b1dzdkpSUTlTamNocjhBV2Zy?=
 =?utf-8?B?ZlJOeW5Dc01kU0lpWjZsSUQyVWdCUjlGVFIwSVg3dkczOHJjNlF6dldTL2Vt?=
 =?utf-8?B?T3VNSzlIdFVjY25YdS80Wm9kL2J1WVFZOFI3ZUxKWU5STjNlTTZ4VmxCZ2N6?=
 =?utf-8?B?TW53Q2hLa2oxMmRMZFFtM0RlRFdCTGJVOVNOR1J5T21EaEwyZ0J0MjZ1NEI5?=
 =?utf-8?B?QUh2Rkc4bk4yUUw5SXc1QWtxSEZjbzF4UytzR0RPMnY5NFpGSVR5ZjRIVDBN?=
 =?utf-8?B?c3I1a2VReDh3RGpGUXFtSVRsQ05Iampab2I1UU1Td0kyRFloN3dta0JpTGhw?=
 =?utf-8?B?OGpOQ0Z1dE9vQ3JEWEZsQlpyWW1EcFdWdklGSVRmaUJlZDV5MThJNlo2MjMr?=
 =?utf-8?B?NWZoTVF4UjI2Y3JUYkFwOS9RTW41bFpxZkdHbWZzS25adTR3VC9nRWVIZFJj?=
 =?utf-8?Q?fjM0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 16:27:14.1948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37441f9b-8b0f-4892-eb66-08de06878a59
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5746
X-Proofpoint-ORIG-GUID: QxOY2FbbAp1hFQCWDBOZMH7HG64zgu66
X-Proofpoint-GUID: QxOY2FbbAp1hFQCWDBOZMH7HG64zgu66
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDExNiBTYWx0ZWRfXzDfuSQeP0mbq
 P+ulWBPhgS5v0MGAshtljfn/5F+4cFjraNyidGkrrVuyp+VmPBiMg+yX+NG1rUhkIUaStk4ls/L
 t26F2pWS452OdG/ELxihTT0ucMK+NdGa2KNHyGoXV31IoEBJ5WGMoGE5unVK0AJOt9m0nWFRDjC
 OAa6tK7jDbql7wVpeze1YBn10uh8b5ovNyXjbMQ0hDox6qtH1c/Mj8V1XDtjDtcmWFW9S4ai82z
 9BnaeJS9az9ID2NexZlrQvGL4bZJW0ERlO/WHh4cBuAHvxDSM/I/kGnLGLJaYAvmOBR6rhBP4Rf
 qqwW5cyztD/8tMzVLMRw/0/mDoU2BqA67tBgNVruS5x2+7qHDxRtltZv2A7MohAHqXfxDJw/AGI
 28HAFrzQN+bzBZaAxOAh2hrt0+6ttg==
X-Authority-Analysis: v=2.4 cv=ePceTXp1 c=1 sm=1 tr=0 ts=68e690e8 cx=c_pps
 a=9hhwatWKa7/vLw/BZzsOGQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=U2_j2L6mtO50HzZEORoA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On 08/10/2025 5:04 pm, Brian Sune wrote:
> In previous WM8978 codec driver versions, wm8978_set_dai_clkdiv
> might not have been called for BCLK, leaving the bit clock
> divider unconfigured. This could cause incorrect or unstable audio
> clocks depending on sample rate and word length.
> 
> This patch adds a check in wm8978_hw_params: if the BCLK divider
> has not been set via wm8978_set_dai_clkdiv, it is dynamically
> calculated and configured at runtime.
> This ensures that BCLK is always correctly set, whether the
> machine driver configures it explicitly or not.
> 
> Apart from this core patch, due to request from Mark Brown and
> Charles Keepax. Overclock BCLK setup is applied, and dropped the
> possible lowest error BCLK result.

Selecting a lowest-error rate is not valid I2S.
You must have enough BCLK cycles to send all the data. If number
of BCLK cycles < number of sample bits you cannot send all the
sample bits. So that would be an incorrect setup.

> On top of the overclocking,

Using a higher BCLK is valid I2S. In fact, it is exactly defined in the
I2S specification that there can be more BCLK cycles than data bits
and the RX end should ignore extra cycles.

> warning message is given to user as a reminding.

Warning the user that you selected the correct BCLK is strange.

> This patch author do not agree with this design nor
> concept from first place!

For example if you are sending stereo 16-bit samples at 48 kHz you must
have a BCLK at least 48000 * 16 * 2 = 1536000 Hz.

If the _nearest_ BCLK is < 1536000 you don't have enough clock
cycles to send all the sample bits.

