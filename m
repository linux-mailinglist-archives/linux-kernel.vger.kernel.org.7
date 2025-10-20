Return-Path: <linux-kernel+bounces-861647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF553BF340C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AD364FC999
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15081331A44;
	Mon, 20 Oct 2025 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="wX7iyO4z";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="NyHbC+kI"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764571EDA0B;
	Mon, 20 Oct 2025 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989351; cv=fail; b=SA+AiRc5O7W2YEPzztLuaZmuphIBoB3bmq7y5ouUif3XFEr4G6xN+hZQBtbC82NtTcbHMNMOvxcTaHfvQBq7sAP1/i43fTBOEm1c0+o8cERUk1DnTa9to+Jcp0GrUsCtPKqdFmLDLDaGJcg85Ulrn3vCmqAguZeahk0/w0he62s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989351; c=relaxed/simple;
	bh=H0j6gWfKZpYZD/wQ2PVqlK8csJQmyE7Jvr6gqN8v9cA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oo3fikBic3ytUqrU+ZGJoNrTRp65hHj7gcDmFaFH/GNyiBEfJ95IvOnqZllwIIpCTOKwGkr2aSNd1P9BWZR1osNzm/yfKqH9R2pn6qGp491ENNIsVaYN9RHPNhvVLldriXTrLi74gJY1UfB4Am2mZ0r8aSfrgJc40DKKnA7nvNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=wX7iyO4z; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=NyHbC+kI; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59KEFe6c1905029;
	Mon, 20 Oct 2025 12:38:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=H0j6gWfKZpYZD/wQ2PVqlK8csJQmyE7Jvr6gqN8v9
	cA=; b=wX7iyO4zANAWsLwLTBOvvlUjPiNmcf0B6HGl2hrdbO0k5zZ0AwWpZ/0Lj
	8IYZTi95Lm1ayLa3a8xgI2mLlkZbrs+5wvmjWlGrdLzCnB0oXnD2WouQ0T/4tIBO
	aIqZgNGYTaalXh7RnZYGIA8H5xjz9WaMA3Nzzxl1vKts725b6v21RWEt6tIPOgpE
	93StJyHapbO/EB4dyfPm2IEdvoUOOEWkiq9+Tj2lTj8aDra1jKI/q80/PKPIxuRm
	ZO4atWqRBYuYHmVMYJhMszF9V31aJ8fxc84pVo4iAWZc2OpVKek0q/qvP1K63Mrz
	q+VRc26kCHjrlXBQJ262TGjG6IA4Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021128.outbound.protection.outlook.com [52.101.57.128])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49vaevbvt5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 12:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDhHI1FKJKfAOnj6B/9+e9Tv/U0qD2XOUYdlwocAMrFDmnIMUSW2Nayy5LOGBmwAWtr9A92BWn2f5ROu2quaHEyz2T7lbdjfE45e3gkrP/b76MNknijP4BLIcjNODBDyL3BOTBWaS8Ch8X/2kz2CbYXC81uwI+SO9kv80ItZcg5JObn4Vfj3Pi3TzvnfTXb5g2oMvUJhcvOlb/QlvMR35+u9/dBlT/Tw+ZvJacKI+N6bCYIQdwTUdOZSSOUmGMyRIX80KJIml4FE84jhx3hO9VvRHX6CU2Ehyga3yVFgw2koI+EVxhpEUtMhWKDLUJw5sdBRppfAZlHgiLdf4orSMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0j6gWfKZpYZD/wQ2PVqlK8csJQmyE7Jvr6gqN8v9cA=;
 b=LBXGiYvX5UJl+EMYGFoi6ba9qI7OGMC2YWvnP7f+PQHSF01h0zb8r4To5JZ40/LfxH2RHDPNeAimZodpEFYPWp38oyPQQPEZEQFXFFjsywXbCyN6iOkf+k3x4G46J+QkTD/fLCx5bQnHd9QGZFiyOAfAlPOcjSahj3b9coVgflIbciB3Sca3UzBBCnklboCCBT2HWiYXnUL+9FGurg8oZimBX3PFvwYyyUq+lAiCkfkA6q5ZlJF9z473QGZWWzoy6RXl7AIHifM6tG3DeX4t70wYPo11kfd1CsnoAlLhaSM5CvQA/7ytkHiMppTrYuQbOmG/XmoUBukLAcSEXqDWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0j6gWfKZpYZD/wQ2PVqlK8csJQmyE7Jvr6gqN8v9cA=;
 b=NyHbC+kI7y+fs1D86UPm1SPPkTzI9d/GSXyho5jzfgtdNeobk2yyJ3QuedR08/6ra4lgFbVzihAmwfbBGEdTpYE/mURv76cJRXROGl/yp+Fdqdtr5x8H28dl4FP59+QOUnBqakN+JXVrOkoIcWHZKaf4RYXhkc3zjtSSfjaT8va8oZHBBAdMtRdXQTt940v24EHRfiK5oPPkEvkiW1TsvJEbJE2ysVm5468MX7dkbZ2TLJv/UiWMN/973qYMMDIJ7wcz+j2niR5AfqaunbX84WMO73oszc/wCXc2UyWCUQkrq8rBUvzrPnulhG4iWbyhT9OmSWGRAkPjUL2M4P9dHA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CYYPR02MB9826.namprd02.prod.outlook.com
 (2603:10b6:930:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:38:41 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 19:38:40 +0000
From: Jon Kohler <jon@nutanix.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson
	<seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
	<bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf
	<jpoimboe@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Ingo Molnar
	<mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Brian
 Gerst <brgerst@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        "Ahmed S.
 Darwish" <darwi@linutronix.de>,
        Alexandre Chartre
	<alexandre.chartre@oracle.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Topic: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Index: AQHcPv2ViIPRgARTk0+c7Boi5TEVVrTLM+0AgAAE4QCAAARygIAAM4aAgAADeAA=
Date: Mon, 20 Oct 2025 19:38:40 +0000
Message-ID: <7985318A-3669-4A1C-9282-D940F142252F@nutanix.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <aPZZwoqWV8cJG2HH@google.com>
 <413D20D7-AB18-4D46-8128-6179F2565765@nutanix.com>
 <c1b2162f-5a1e-4072-8695-6c663a1ba0c5@intel.com>
 <20251020192605.yqg5mmvah2fzyjvu@desk>
In-Reply-To: <20251020192605.yqg5mmvah2fzyjvu@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|CYYPR02MB9826:EE_
x-ms-office365-filtering-correlation-id: b420623b-e3d5-466a-9d90-08de101045b4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGoxeEpuWTJWbnBpNGhpMzBlNXlPTWIzUzZNczBoVmFIOGtRQUtDc05WbzNq?=
 =?utf-8?B?VnpnY2ZwenorQVZTWWN4RTZwdjZXL3RmQ1NSd0dMZEMrSmVMck5YdzN5bGV2?=
 =?utf-8?B?ZElBV041MzU1NmlEUFNURHBXMldEQm9RYnAvcjBYTTJSaWpwbXpCT2RxUU5I?=
 =?utf-8?B?Tko4MkxiTmlDV00rUVFteTdiUENLdHlzWUttQWdyRHJmOHZpTXVZcXltT3JO?=
 =?utf-8?B?dVBXUi9zck5zRHhjcHowMmcvWTVNLzhkR1o2RDRWS0RwOEVOb3BLQnFKYTda?=
 =?utf-8?B?M2VqNmFSdmdQZ2V5RW5weU5DWFBIRXRqazZtdkxZbUNmSkZ2cmJPaENTM3Ns?=
 =?utf-8?B?MGpPODNtVmszS3Vsa05ab1VMTk1QNEpxOHZkSkxiSjVMUUN3UU5GWXkwT2tB?=
 =?utf-8?B?U3N0Y1JKdXBnUHdLQVMzdjRZUkpVVFJxdUFPVUpCNy9BTEY4KzY3REpleU9x?=
 =?utf-8?B?ZzZ6RjZaSkJqVmVwTERYanZwQnVqeE1qMDg0REV4aXB0WFhLaTMrSTNiTVhS?=
 =?utf-8?B?V0ZrQ1ZGTk9NK3J5V2x0WkpFV3ZpSm5Tc3YybzBmcGRVU1FDYlMzdSs0UmhN?=
 =?utf-8?B?WGJMeHVYV3JjVW4rMFozaHdzNFZIMlQ2MlAva0RTSi9TbnFPLzRvN3JOQldp?=
 =?utf-8?B?cWsvc2tXc3V3R1MyT041aXpvc0d5R3JvTjZZenR2cy8ybmE1ckNLRG1RT1lN?=
 =?utf-8?B?T3IvaHVwZXRLNWwvSDZlN1dSZUZ3bVhocmlzcU1TNlpUTmU4MkpScTFHQjZO?=
 =?utf-8?B?YWdrQjlTTlFEdGoxb3RLTFRKRnVJT2hxSFNEbGc0Sk9PMjUwQVJtbVlrbEph?=
 =?utf-8?B?UEllK3I5NGNUOUo2YmxTdGY3b2N0Tis1Ti96OTRycFZ0SkdEb29mMVp0Zkhj?=
 =?utf-8?B?S051S1ErcVVwQ3oxNkZHczd2WjBhaUpWdFp5TWhYd1lQdVE3S3dmdURBN250?=
 =?utf-8?B?MktKNUZpTXgzeXp5cW0vNFVwVmFBMWNMdHVPeXdPV0RsRnRFM2xlT2JOY1hP?=
 =?utf-8?B?anVNTnhvOTRXNjJxRGZPZHJ3Rm5XaUJRK3c3Nm1INHVtY2VWa0hHa255WDFp?=
 =?utf-8?B?aFFJeGw1QWFKYWlIOUN5eTZwNmpJaUs5TXpidm5KVTZkS2h0NTMwa29XNjhC?=
 =?utf-8?B?VkxWZjY4RXdHTE9telpQbkVZRG1KWGRyL2pUYkVFbEsreE16YzltcTRUdnls?=
 =?utf-8?B?T0lDcjNObSt4ZTBrNGx4YlRVWDNrMkJ0WW5OSWsxeTdSbVhWL0t6bjdmUzBB?=
 =?utf-8?B?dUxaYVpPY05jZGtPamJtL0ZCVUhoaVpyTXFMOC9adG5objdWY3pGbmFFWk5L?=
 =?utf-8?B?MW03U0FObmt5MXRXcE4vYmdkNVo3ekRKMkFTWGpva1VDK3JUNDZraFJOaEFI?=
 =?utf-8?B?bEpNSGtuVzVXZlBpYlpBeG5CWi9NUERscDFuSU9QNG1VeTFIU1UyYVZQMmJp?=
 =?utf-8?B?ZUdDRURRYWpmbW1HaG9obk0veU1NZnl5djlpSXJBZ2V4UGFXanVlMXhSeWpi?=
 =?utf-8?B?MkNRM3lZU3ljTTVIZGtrYVdWeG5adXVqcENmWmJpUDZDL3hhRzRKZjd4YjVi?=
 =?utf-8?B?OGkwcnVWVnZhRm4zL0ZJTldwa2FUVlNONThWY28rQ29iY05GS2lVaUxTUnlk?=
 =?utf-8?B?STcyNlowenZ2MGlubjU5aytLTi9vY0ZiblVRcHZYaitiM3k3UGJGT1RTVXFQ?=
 =?utf-8?B?dGtIM2VCWkpkMzU3RTFwcjREQldSNmhSeGQ2aG55S0lwR3RDUVFJb21jSVdB?=
 =?utf-8?B?ZUdzZ2tpOGZFRjJLRlNEQWJaNldOL2RaaWVCTDEyaUU3UEZldU1zSUJnVyti?=
 =?utf-8?B?UzBEMURsZGVhc1B0NFMyNUNBVzRNY3hVcXlXL0kxQXBDVnF4ZVB4ZXhjamZH?=
 =?utf-8?B?UFIvYzJpbVF5QXcrbHdVYUdkUk9Edjl0OUVVcVI2QXh4d2ZsWFU1enhISE1K?=
 =?utf-8?B?SEEyblorUWNLRlFNZ2pMQUQ1eGdUbjlsWVg3KzBwVEJ0eDIyQWVwdldpS0o3?=
 =?utf-8?B?Z0EzbjdUVDZ2cU15ajRWdU1ja09ETEZINTMxbk5QTGlOQWN3R3hLNlcrY0hx?=
 =?utf-8?Q?igH0FC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUJ2NDNTQnRFNDluQ0QwVVJRSGcxSXc2NlU1ODhhZ1gxMURXU1duQnhVYXNm?=
 =?utf-8?B?S2x0bzMyNVJwQjRrbUNyMmRqQzJaaWJRZEYxQ3k3QzFuL0xzVjJ5Ty91amxB?=
 =?utf-8?B?THlZZ0xwaWUvZ3Q3RzhQUi8vSVBudUZIRHhtWUl2dUZ2WnFoZWQ1RzRWaTA2?=
 =?utf-8?B?L0d5NERaUDBVclZtSWc2YlJoOStsSTN5VWpxa0pNNGF4aDdFQUxXdjlJYXFE?=
 =?utf-8?B?bjNiNWthQ2VjNDBGN3l1VXZTTDQyWElteitaNEZtQlVwYTNVZzRRNVVIZ0RB?=
 =?utf-8?B?MzM2bWdJMHJLNXJQbzlaelpwV2F3V3VHTEZqUkVMNG9sSXdtTVQ0c2g5MGxs?=
 =?utf-8?B?QVlMbnB1RzBwTGo0a1FPZXRIWjRiNE9tWkxyaFFHN3hXU0NOODFKbzRiZnlF?=
 =?utf-8?B?aUFrdXp0b0xXUmZHLzkxT3c4NnJmVXl1ZlYwUHpmazlnWHN4S1A5WDV5a3Ra?=
 =?utf-8?B?NXIyT3c1NUtLNUw3VUpkUytkdnVpcVRKM2FQcEtjNTUvTm93NmlQVWliWFlR?=
 =?utf-8?B?Y21FYXFJV3JUZHVwcDlPaXA0b3dKZjMwM2djNzJmQmwrUyttQUpkY2V4THZn?=
 =?utf-8?B?V0VNbkluOXpEMHUrRENTMm15UllsUTN2d2NJVktaNEpPU3JyRUpwVW1KbUMr?=
 =?utf-8?B?ZUF2b0o1aTBmR3NpTUFDUzdGSjJDQ2lpZ0FwM1B3MUtIdGhkelByUG04bDFm?=
 =?utf-8?B?NFVVMS9Xd0wzYUh6eWc0eDRsMmo5QmE3NmlNQk1iZGxUajJVcFgyR2Z6Nmh2?=
 =?utf-8?B?ZUVMd1lNWUF1Mlp4ZFhUUTlJMXlIOVRFQStGRnczOTkzMmx2Mk44U3E3c0NB?=
 =?utf-8?B?eUdqSmJsWGpwOHZDRmdsVXcxdG4yV29uOVZBQjJIcHlqenlSMGxaOTAyWi8y?=
 =?utf-8?B?NEZYK01VY25qSW5ER0N1RFk5RzdWMHpkKy81RFRLOTYvRFBEYnl2dTIrdTRu?=
 =?utf-8?B?L1ZqU24rMm1nS1p4Mlk0U1hNWGpiZ1EwVzFYbDFHRFJnTzViVHJkOUJDcmFh?=
 =?utf-8?B?K2FSU0ZyL3ZUSDMwanE4OEx6RE5LT0xHU2o1NVQyYWxrOXdYRTVPVXBIaEdy?=
 =?utf-8?B?YXV4VWJ3bUY1YlVndFBBZmg0NVY4MW9DZ2F3L29Mbm5QbXZEVlpYRWpwSTFH?=
 =?utf-8?B?R3RFcWF1VGZaenRibjNwYnpweGhXbU5GaEROOXV6S2tIREJ3bHkvQm1FQ2tT?=
 =?utf-8?B?bWFFSDJjZi9PWDVHMlhvMjhhS1hDcGpyZ0NNa2tMZjBVc3JMV3duTnJRbnZt?=
 =?utf-8?B?N1lOM3hpU1BsRU1FTDdEdVNzSjBxNDZkWml6ejZJS2ZiRy9naHhBbGhUQlJx?=
 =?utf-8?B?RVhtSkQyUzZCbnQ5a3dtdnZ2TXl5K25aU1lJUkcvWFNpbTNqalNPeTJ1eDMr?=
 =?utf-8?B?ckQzZDZnenhkd1ExUHNmMG0zUDQyS21WZlY2N0h2bEo2KzE4VVowa0h5Z0sz?=
 =?utf-8?B?WUhTRUJuWmgwdDFoV1laMnhqcjRJUFFCMFJhN3hFM2tXK1ozNkFYWWM1NTI3?=
 =?utf-8?B?K28raFJLekVQKzRLOElhRjVmK1RqUER6TmtaMnJLTDFVaW50NjFpNmRCRXAy?=
 =?utf-8?B?dDlpbVpycC8xTWhzeno4U3pQOEpBbWlRWkhST1BuZHVHVDZPaWh5WWVlcVhQ?=
 =?utf-8?B?U3ZoeGlRN25Ub2tCT2pXTVFlMjgyU0Q5dDNiRlRaaWk0b2krU2o3cW1nbmNn?=
 =?utf-8?B?UFFOMmFYVDN6MEt0T0c5bllNeXZXTmNMY2swZnlHaVptcWYwcHBIeTlFTnJK?=
 =?utf-8?B?VzhsMGZUQlNYVE1ZRUhuZWJaQzF6cjU4WDdSdnpqUWkzdkovekF1Z29nMCs2?=
 =?utf-8?B?WmtmK0xXRitlem9kQkJKSnR6QVNzdDVlZ1B0aFUxK2Zrd1U2SWhtbGtZWFZE?=
 =?utf-8?B?OGRWM0dHRWtWRXRveVJNblp6VjI0VFg3WTBidTFseVpMdnJZcWNna1cxMHhl?=
 =?utf-8?B?aXpIdk5yTmh0VWhTNVlMVmRzeVRlQ2Z4dVdtVWhKZTFOSzM5Yld5bExUeW84?=
 =?utf-8?B?djc2WlowZGp0SzVsZFBsR3ViUzBqVjhZc0g3cUIwZWhPWTM4NVprYzhuYzkx?=
 =?utf-8?B?aFRtanBYck9PMTJ5NWtUZTBsYnJRUVFSL1ZkOFNkMXBQazRPd3YxeW5jOHU5?=
 =?utf-8?B?eWdzY0FmOFFYSEFpQ0hVMXovVk1GeVdnaVdTNFh0MWtIdzNnbjBRQlFDRkRi?=
 =?utf-8?B?R2ZuYTVnVjVUNUF4S0piUFhzRTV5VndZajVJL3BFWmNCT0xWbVk4bW9WVS94?=
 =?utf-8?B?aFAwV0svejF1QSsreWYzSTZnd3B3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <901BCD3EC2FAC949AEBD0A5291C2E922@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b420623b-e3d5-466a-9d90-08de101045b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 19:38:40.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKzcQtJhn91lcpJFVSltIkyXYtQ6pmCcDM7h9WDUjnlcwbeQEjXa/9kXW7FkENa/ckyR0q/zpzSXHNpL1Qv6pliIByzpHQpVHzrRdGgjycU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9826
X-Proofpoint-ORIG-GUID: 0rxfnFxHXeKhkCZuEKgLOZQnPHpjtEkz
X-Proofpoint-GUID: 0rxfnFxHXeKhkCZuEKgLOZQnPHpjtEkz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE2MyBTYWx0ZWRfX+mS39ldKqgjZ
 7AtskJgD9RsHEfLrdWKGB8kZQe1JM+NvFGPVvX6cLxLBs6pm1ZjaJ/lSTyfujL5+SMpOfsYQQAD
 bcx1vS8YcPfOwTfrkG2KkjZYOBG98Xs0e5YZ4NrxsWLIMacb27IgyHgwTURN7WJwSTFopqZPVxx
 1yUBjrgAhoZo4qCLLBTNXaVQVmCOx5OMOHvhfJSEmf9txt3KwCpE51c5QTwo4uLeprNamINp80A
 gQtsZbbXhUYfxYkTeLxinSNzNxfdUiqJj/0EGRj+zb38uJ5TsS7WMCCrzT/u29eZFcGWCxIdT+T
 nXs0Qo/ID8Vrxl9evdOm3YlFsJp5F54f1vzis0YFTgV/tJrEZei9MmIJ9gKM+3TwXDhQOnn7Bi8
 Nu2IB2aMBoigcGMjCe1lm468w4oTcQ==
X-Authority-Analysis: v=2.4 cv=Fs0IPmrq c=1 sm=1 tr=0 ts=68f68fc3 cx=c_pps
 a=EDQZ7307M/d1MXNVkApkJA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=2ivJPN3Lr2IdQPmj6RgA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDIwLCAyMDI1LCBhdCAzOjI24oCvUE0sIFBhd2FuIEd1cHRhIDxwYXdhbi5r
dW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+
ICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBPbiBN
b24sIE9jdCAyMCwgMjAyNSBhdCAwOToyMTo0MUFNIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToN
Cj4+IE9uIDEwLzIwLzI1IDA5OjA1LCBKb24gS29obGVyIHdyb3RlOg0KPj4+IFdhcyBydW5uaW5n
IGludG8gc29tZSB0ZXN0aW5nIGlzc3VlcyB3aXRoIG15IHFlbXUgY2hhbmdlIGludGVybmFsbHks
DQo+Pj4gYnV0IEnigJlsbCBnZXQgdGhhdCBvdXQgdGhpcyB3ZWVrIG9uY2UgSSBjbGVhciB0aGVt
Lg0KPj4gDQo+PiBCVFcsIGlmIHRoZXJlIGFyZSBmb2xrcyBvdXQgdGhlcmUgdGhhdCBhcmUgd29y
a2luZyBvbiB0aGluZ3MgbGlrZSBRRU1VDQo+PiBhbmQgd2FudCBtb3JlIGZvcm1hbCBvciByZWd1
bGFyIG5vdGlmaWNhdGlvbiBmcm9tIHZlbmRvcnMgdGhhdCBhIEZPT19OTw0KPj4gYml0IGhhcyBi
ZWVuIGFkZGVkLCB0aGF0IGNhbiBwcm9iYWJseSBiZSBhcnJhbmdlZC4NCj4+IA0KPj4gVGhlIHJl
YWwgaXNzdWUgaGVyZSBpcyB0aGF0IG5vYm9keSBjYXJlZCBlbm91Z2ggdG8gZ2V0IFFFTVUgdG8N
Cj4+IGNvbXByZWhlbmQgSVRTX05PIHJpZ2h0IGFmdGVyIHRoZSBlbWJhcmdvIHdhcyBsaWZ0ZWQs
IHJpZ2h0Pw0KPiANCj4gSVRTX05PIHN1cHBvcnQgd2FzIGFkZGVkIHRvIFFFTVUgcmlnaHQgYWZ0
ZXIgdGhlIGVtYmFyZ28gd2FzIGxpZnRlZDoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC84YzE3OTdlNDg4YjQyNjUwZjYyZDgxNmYyNWM1ODcyNmViNTIyZmFkLjE3NDU5NDYwMjku
Z2l0LnBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbS8NCg0KUGF3YW4gLSBJIHNhdyB0
aGF0LCBidXQgSSB3YXNu4oCZdCBhYmxlIHRvIGdldCB0aGF0IHRvIHdvcmssIGFzIHRoZSBzdXBw
b3J0ZWQNCmZlYXR1cmUgY2hlY2tlciB3aWxsIGZhaWwsIGFuZCB0aGUgVk0gd2lsbCBmYWlsIHRv
IHN0YXJ0Lg0KDQpTcGVjaWZpY2FsbHksIGt2bV9hcmNoX2dldF9zdXBwb3J0ZWRfbXNyX2ZlYXR1
cmUoKSB3aWxsIG5vdCBzaG93IGl0IGFzIGENCuKAnHN1cHBvcnRlZOKAnSBiaXQsIGFuZCBraWNr
IGl0IGJhY2ssIGFuZCB5b3XigJlsbCBnZXQgYW4gZXJyb3IgbGlrZSBzbyB3aGVuIHNldHRpbmcN
Ci1jcHUg4oCmIOKAnCxpdHMtbm89eWVzIg0KDQpxZW11LWt2bTogd2FybmluZzogaG9zdCBkb2Vz
bid0IHN1cHBvcnQgcmVxdWVzdGVkIGZlYXR1cmU6IE1TUigxMEFIKS5pdHMtbm8gW2JpdCA2Ml0N
Cg0KVGhhdOKAmXMgYmVjYXVzZSBxZW11IHF1ZXJpZXMgS1ZNIHNpZGUsIHdoaWNoIGlzIGNoZWNr
aW5nIGFnYWluc3Qgc3VwcG9ydGVkDQpoYXJkd2FyZSBiaXRzLiBTaW5jZSB0aGlzIGRvZXNu4oCZ
dCBjb21lIGZyb20gaGFyZHdhcmUsIGl0IGdvZXMgYm9vbS4NCg0KSSByYW4gaW50byBzb21ldGhp
bmcgc2ltaWxhciB3aGVuIGRlYWxpbmcgd2l0aCB0aGUgZmItY2xlYXIgZW11bGF0aW9uIFsxXSB0
aGF0IEkgYWRkZWQgdG8NCnFlbXUgYSB3ZWVrIG9yIHNvIGFnbywgYW5kIHdhcyB0aGlua2luZyBv
ZiBzb21ldGhpbmcgc29tZXRoaW5nIHNpbWlsYXItaXNoIHRvDQpnZXQgYXJvdW5kIGp1c3QgdGhp
cyBzYW1lIGlzc3VlIHdpdGggaXRzLW5vLiBJIG5lZWQgdG8gZmluaXNoIGNvb2tpbmcgdGhhdCB1
cCBhbmQNCknigJlsbCBDQyB5b3Ugb24gdGhlIFFFTVUgc2lkZSBmaXguDQoNClsxXSBodHRwczov
L2dpdGh1Yi5jb20vcWVtdS9xZW11L2NvbW1pdC8wMDAwMWEyMmQxODNjZTk2YzExMDY5MDk4N2Jm
OWRkNmE4NTQ4NTUy

