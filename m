Return-Path: <linux-kernel+bounces-861295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C49BF2508
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C9B3A604F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A62750FA;
	Mon, 20 Oct 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="iJjVaVo/";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="AnO2Qs1s"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42B283C89;
	Mon, 20 Oct 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976444; cv=fail; b=SrgMs+ad0VftabbUqCDmH9tlLUewFprSxTL6Zhm8wIoXDQO2N24nS4iW46+qIWtvoakWbxtFPhfT/XAMnC6fZWkmiBRUPfhYHk7XQg1knYWNdJHhHxjUTPDFdPjrWnGrts3E/dvYAbrxA0rwxvHYRDDgN6gWMtqcENV8y4nDEYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976444; c=relaxed/simple;
	bh=ZccCmzAJciPjSBvWYjfpXJQNWAx4nTViLXq5dNDRcl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UPs1j4cuaw7mvURu2vpud+UIcp5XQusjvAQq5KpLUH4j+81FqIuPqqGei+NJ4ZQPHrzCJRfLtOXgHJrmC+SlsnoX57gSKnuWvGdQAYkjgFolXNpC4yrBkp4OdK5uatLOwxcys6feE+kVqUx8sfOv/Vn2GsSe9rRdJLzevAkrbxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=iJjVaVo/; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=AnO2Qs1s; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59K7p2Tj762747;
	Mon, 20 Oct 2025 09:06:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=ZccCmzAJciPjSBvWYjfpXJQNWAx4nTViLXq5dNDRc
	l0=; b=iJjVaVo/uaHYTWO8Dj21Ut+z1mSW09CzhVyFj+DM8pOOFYyQ04M4321T4
	/AOVOMg8wSmE+HcHlSL+nrC4dgHqQpfRLuibHrxa8kKiWWVy3uaTV8U0Es9mrcbK
	OdEpQsHzG01uqyWQj+f5R0773/zJ3r2Avx9NAVKWQ6s1QILfgoHVGgMuVUysqZg6
	ceUdrgP2fVT7nuljXpWGa9PC1S/h0kWX1w5zkalxgMBOW+QjraTOON3pJyhFlCpO
	pbYHNfv1v1RDHmGtIMhVFd6lgM2Mt3XOzZuc9SAZwpWR2OXiVqZ0uAQmRfSsSvkp
	lpKLGhiXZMhX6EX1dFPIzjtrQuE/Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021094.outbound.protection.outlook.com [52.101.62.94])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49va7bbdqs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 09:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mThqG9eul5TAZ5slkzOR4hcCYlkLdaSSv4dovMjWeDFHnSxIUDPx3S2I10N2kizEDfPRDhI50p8JS7Rj5KIodOTyM8fAmqsz9ADFMjXiJ3gMJ9oEEGEvqWEr5WE/0NiXYxYOVO64wSvDf3lzoeUhMgh+r7m7jM/uN8pFUj+ZhRDB2R1G9kaozFoAqCfnKOulz9i2IIvGNEt8yoVRIT9xEawtkVfvxYTOz7W3tEynrI/CHGPQTKiWQEBMM515OgJT0BamY45WcJKCaNg1Tz6C+zg2YgTZsXpE1heFX2nd7MJIMB9yc+QwwxRz6TDnwxis6ikCzzYjsLmhuA9XV9EymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZccCmzAJciPjSBvWYjfpXJQNWAx4nTViLXq5dNDRcl0=;
 b=P18O0TEk9sYVEeSJheiRpKi5D4P7OrafNEP8NeuQFdqk8TtIjiQtXfTgS6u4Q+SM7Nxb0vnat3uxBzqmPzUlmZXaJPNdArGYIUYMG7JDXTtQmlW7ERUFhxTB7uugaVlYJyR9kk9BmSqwmTI6ecdROPAhLyXBHW3p+EnllWl2hcwOx68p049H+7thnTnMN/CJp3W1iXbBtiZJ6u3qi9Sf7v1mGQFUXakqXgg4qSVwlVbW2QpwL6yRuJBpqKLlmO6OwPSjwoZQNjDddwaQI0rtrkHMR/SJMJjCw29u0VINkDJXcYtr514yrPQFykIQ2rt4qrwB8c1JFM/YzHRWaUG8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZccCmzAJciPjSBvWYjfpXJQNWAx4nTViLXq5dNDRcl0=;
 b=AnO2Qs1sp14JDD62AVQD2AYdwGGF7k5Orc7wasyW0mZBhwQPBBDTH6IlmxurCadhCvq0ggw2DeSSRWjz11RZk+MbUSdDVZrFtz2pSfRjcGQOWksM8e4KZUPjHOXWvhL7FPb5O+XLhoJZXS6Oexxh75CzmBAs/OWahn2tSiHptEx1C550SqBhsifYIhXgfa8I8/p2Q9S2sU8tIwawTI1BvTqFNuShXh3iAiGSsmRGAkfSYlLiMi2yc7fYXemTTp2e4Tiz7Op8eqFOIOYB0PMIRQMFKLurRT18Bgz05ISy3C9C5hpRXtvHu8pQ5zDE6gpYCwUPPHizaVKUXO0AXvHkqw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by PH7PR02MB9339.namprd02.prod.outlook.com
 (2603:10b6:510:277::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 16:05:57 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 16:05:57 +0000
From: Jon Kohler <jon@nutanix.com>
To: Sean Christopherson <seanjc@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jonathan Corbet
	<corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>,
        Brian Gerst <brgerst@gmail.com>,
        Brendan Jackman
	<jackmanb@google.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Alexandre
 Chartre <alexandre.chartre@oracle.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Topic: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Index: AQHcPv2ViIPRgARTk0+c7Boi5TEVVrTLM+0AgAAE4QA=
Date: Mon, 20 Oct 2025 16:05:57 +0000
Message-ID: <413D20D7-AB18-4D46-8128-6179F2565765@nutanix.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <aPZZwoqWV8cJG2HH@google.com>
In-Reply-To: <aPZZwoqWV8cJG2HH@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|PH7PR02MB9339:EE_
x-ms-office365-filtering-correlation-id: 9d5008ac-dc26-4b37-7680-08de0ff28e2b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnFPK000U3hsMm5TSWd1bTFFWXdLL1NkZDFNVlVtZmMwU1JabjZnL1lMR2wz?=
 =?utf-8?B?RG5pVGtXM011ZXZEem40SmhkbEtwSkw3ODBuMlNvSjlTbXUxZzBhelFUTUJp?=
 =?utf-8?B?Z0RvbWhhdlRmY1pJRkdRYnVKMmRtU1ZXaDRFV3Jqb2ZwY0FCV3l1anVnelBF?=
 =?utf-8?B?a3RpQVphd3EwQ2tMRjlYMTl1ZDdzWVBGK3M0djlHZWE4NW45ZTV4NHZGY2RU?=
 =?utf-8?B?cENyL0p6MElYOTZQNnYrK2dJRCs5UkNSSkNFNW5tTmxwbmpvTWpxcGU2VzB6?=
 =?utf-8?B?UTVUVlRHbEdDMUhiREh4ZVoreVVHNFZPVVJKK3RNajFQSFM4TjUweVdjRnlI?=
 =?utf-8?B?Z1JuYWIxeTkyNDRpcFVaQUk1QTcvTjg3ckc1ajI0Znh6TzFtU2MrK0MrZmM0?=
 =?utf-8?B?Tm1sSFlQbWJxOG9RcVFUY2RqbUJWRDlzZ2FVejgvcTdNTzF3WnY2SjM4ZW5a?=
 =?utf-8?B?dVlHMzhGa0ZPNitqemZhZ0s2S0RNbDFUcG83REdrakordkZyVXNRVzQwK3dO?=
 =?utf-8?B?Wm1NTml1T3AzcXBPY2p6Umdma1ByNUprbDNITWNldHFMdUM5S3p6WUU3NE0v?=
 =?utf-8?B?VTM1bCtkaUdvaytuS3RmRmpQV1ZISU1SVElkakNBWkxYRjUvRGZSNFlkUFlR?=
 =?utf-8?B?SVg3bnl1Z2FTZmo0YW5Kem1uUXRBZWxjcEdIN2s3Sy9VMHhiaWowcitCODg1?=
 =?utf-8?B?M0U0K0dFNGluUXlvKzNEaWNmTEt4UXZVWktaY2o0ZmZ5RTh2dUowVlZDL2Ra?=
 =?utf-8?B?ek1rUVRTbXhiT2NhSGRoT3hLUmdHR3llLzM4a0VDQ3labmE0YXk1a0tReHpZ?=
 =?utf-8?B?OE54TDFuQnpPVzJ6OU10YzgvZU5zS09kemhObEVGQzFOMWZIYTRIQkJEdE9h?=
 =?utf-8?B?czdTeXJqaVpMbEdDK21ZT2FiOXYxYTBYQ2F3eWxjYUFjbEhPcXlpYXhaRldR?=
 =?utf-8?B?QWZlTlNiRWluOFArN3NlRTlFeERuN29BV2FuZnpCRTlJT0RKZzMwZjlMY2d5?=
 =?utf-8?B?Nk9BcU9sQXN4b2pTQnNoVjk0TklaTmE2S1BDSGwyQzQ1MTJORnovR2ttNm5y?=
 =?utf-8?B?eHZ2NDhFdnRpYmdkdkJnd3B5cFQ1Z0JNUlhtS0lVcy93NkFPZHByWWs5Q3dh?=
 =?utf-8?B?MzhtWjdCYXp3Qk5lcXY1VDVFWlVHUXBSTGNvOEZPTnU2ZEFqMVVycHFmd3pF?=
 =?utf-8?B?MmZBbG0zbU1HZnhvUFZBSG94VGFoUGY3ZndHd3BoVnBOVzlDOXIzOEptU0dZ?=
 =?utf-8?B?THphdW1Sd3FWS0pOM0dFZ0J5UGdlRjUvZms3NGpUUHVSSklQVE90b1ZlOUp6?=
 =?utf-8?B?VEloeFlNSXVVamtiY3VJZ2dKVlFmbEYxeXRnSzhJNldtWXRrNXFVbXVIbEpJ?=
 =?utf-8?B?dHg0KzZlSkhBNTZrK0J4NWtabWl0YXJxZnFPU0tqei9aVGkvblh6UjE2RDlW?=
 =?utf-8?B?cWtzRjB2ZTJaQ2h0YUJ1MEFwSDAvMTZFbGxvNkJPNHdQRGpPMWpiblhpa0R2?=
 =?utf-8?B?TnFHS3hQUDZ5QzhpYUVOQ0V6eURlbS8wQUE0OHJRRDhnc0VSRHBvL05OYmNJ?=
 =?utf-8?B?My8zVDVaRGhGYzZBOWlsbmFUZmZBc3MremVKdGZRM3VMTTEvQnBVaUJ6cHdU?=
 =?utf-8?B?MStycktMQ1JsbTZWNjhUSUNxUldENG5uM2RwcmlPalFyaGRXdDBpcndEYlcv?=
 =?utf-8?B?ZjlXay9QWlh0RDRmNTl0eGVSTUNvMXo3d3Z3L0RtRENlbHo5bTJqMjc2OVl2?=
 =?utf-8?B?RC9WR1l1UG9qSkFuVjd2OWliR0psWmJOYzJ2NldUQlpLdWk3SkpxcXpKam9q?=
 =?utf-8?B?aFZYYndHeVd4dHYzanp2TTZwb3dWRnlRempMV0JVZm5DSGVGMjBEc2tRMlJX?=
 =?utf-8?B?OGdOLytMZkhNTjFLWW1aRS9BYmtndDJnZ2JCcEpiSGJjSnByNHkzdGNGbEVK?=
 =?utf-8?B?cUtWbGNTdk5iL3pOcEZCc1paQ1Z1RnZjRy9Uek03NmJLRjhpUXFsMW9NVGF2?=
 =?utf-8?B?bS9BQUNVTHRCYzRtOE5uUW45U3ZrVHIzWXg1NkM5V3RBZ3BYSStPUm9CNXlj?=
 =?utf-8?Q?iWy9w0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0RzVWtzMVRnWk1pa3lqWVdhenVobGNzdndnelFGSmJvRi9BNVl2cTdrc1Nv?=
 =?utf-8?B?TGgvVXhDQXYxcmxvZTRXY1RKd09VaXRsSURiVnBlMG1ZSWRpUld5eTYvVnF0?=
 =?utf-8?B?SklLTjNpWCttUjB3R0pQZy90NmhrSzMyQm0zQ2I1OGt5TFlWbUYwSm9GSGMv?=
 =?utf-8?B?WE1qOEZ5ak15M0c3eS94dXB4N0FwaUxPNG9FUThZRTRXSnhCQkFuYmV3V3Fq?=
 =?utf-8?B?U3RibDZweUtVRStWbW1sYUp6WnVKL3lDR2ZHTkI3YzduNG5xdDJzejJPOGl2?=
 =?utf-8?B?eUNDN2FsOFlQYkdwQmMzYzhid0lEVnlUK3JJcGJTSnMrS0ttcGlGd3FRY2Q2?=
 =?utf-8?B?aGM3UlM5RURZWTdTTCthRzMrSGEvcDJ5UGZzb0RoUnV0ZnVzNUx3bnh1cUYx?=
 =?utf-8?B?MENnZ2Npdm9oM21KeEZHUUJWaWNaNXh1YktBQUwyWFp5Q3EwRjZMNkcyVVgz?=
 =?utf-8?B?cng0d1IrdlBCMHBjeDFxWGNjUFh2cWJiQWQ3TE1zT0FTdjNlWFJSMEpjczBL?=
 =?utf-8?B?ZGpsMlBqS2hLSkMrQVcvUG9SUzlxeTgvV0MxaDZnZitVYTBFeEJNSTM0Y2Vh?=
 =?utf-8?B?UjJBQy9tSjRpaHJObGN6OGhMaVZTUzJxV1ZYUmszTEVKbEFwUnN6WVdnbnBt?=
 =?utf-8?B?cmoxRkxDYWdqN0ZKS2g5RG8zbnVlS2szZnc5cHRVWk9LNkxtVmQrZHp4RVVa?=
 =?utf-8?B?dzNZb3YzN0M4b2R4d3czQXBhRDlCM0R5VU5nUVRFQ3VJQVhuTU9zem9Qb0NV?=
 =?utf-8?B?SEhwVGRaVDBidXZmMG8wYnQ5QzY5alRhdlhBSDZ0ZkVsaUJjeFltdWtHN1dr?=
 =?utf-8?B?VExVM0VUckpaMkhJMzltd3RRZUUvSndwSUx1UTl3WWdXSlJ1V05XenZOT1A0?=
 =?utf-8?B?ZThHdExSM1VtNk4xNmRod2hJSndmVFpQL2gyZHdYNFNmaFF0OWFKaXhPNVhk?=
 =?utf-8?B?bHIwRWtMSkIrdFhzR0dJLzE4MExwNzYxbU1TVU1mS0E0OFZ3ZTIzZGhwelhT?=
 =?utf-8?B?NXVoWG1jWkMrT0p0R1NEUXNnZFVOTU1iV2IwTnpBdDduNUR4ZTlURnEwd0Yz?=
 =?utf-8?B?OHZEY0dMQUlEMWZUNUZqdEl6UXU3aVFsR29zTGhDSDM5c3NTN2twSG5EeFFU?=
 =?utf-8?B?YktvNGZRWkJxZ2puUkZ1ejNIWjYrWWxyREtuNmZLQm94eno1cTBtQkVHQUxH?=
 =?utf-8?B?clM1RjJCSkJPWG8xZ2pLUUMyZWlyZExvYUF5czM2QVEyY2NnZFFqdDNtRHhR?=
 =?utf-8?B?UWFHUVRzUWtQTy9wSERPcHk0ZHVIdStQYW5Zc3krRVJsRUJzbUp0ZlEwSzly?=
 =?utf-8?B?RE5SSkwxSnlZejRlM2NMQXFNWnNuOVNiR0JXU0VyMmxlQ1ErNFdveUNqZzJW?=
 =?utf-8?B?UGFxaGxkdTF4U2JSQ0V1VlNMTnl6ZXczQy9RcEphK0lWc1lvaGh5L09MVDdX?=
 =?utf-8?B?cGorQ29DRGhIWGROYVV6d3FFNzhEMEdIUCtGRThLd3M4SXdMOUp1Y2hiUWda?=
 =?utf-8?B?bVMrZUg3bkw5TXJwaEpLL3Vhck1tTDBLTXZ0R0pBZElleXFMWnVOdmZKbEJ5?=
 =?utf-8?B?OVZMOUgyajRQNlZ6cGlZZktsNUhTdVZsbTVHN2tyejlYc2JSdHcweXh3R0hU?=
 =?utf-8?B?SXRmUGp1bEJTVkE5Y003bUJQN1ZTSHJENUlKd0JaeDlYUnFwMDJHdFE5a2s3?=
 =?utf-8?B?NlVOZGRCTm54cWtSTGo4WEs1dVBxb1dvRzJoWFNKR3hVZ0xOKzVybUhJYVR3?=
 =?utf-8?B?Ukh3bSt4YmFhOU9KeDkxQ2hHMjJOQkZCb09OZGxzUU05SjNCK2xneVMzRzdr?=
 =?utf-8?B?VHpSVk1OV0loeFF1eVJvOGk5SVRvb1pKMVhJL3BUellFS3hCWnBpclpOUHNY?=
 =?utf-8?B?aFpzL0VHL0txVGRBd3lseHFtb3pjVyt3a0JwRklaTUY2ajdBR2J3NC95Wnl4?=
 =?utf-8?B?cWkyMkMzV2VIRy84dDJ3MUFjVU1CejlVSVRJejN1by81OHp5YnRvR0JxVUl5?=
 =?utf-8?B?SnRZeVZ1WVJSY2x2NnUrK0hPdnRaN2FRY0IzTXdJV0xYcTN1SExKZVNkUVZR?=
 =?utf-8?B?ZmhqbXBidEc2emFBSFQ3YXNPWFJhdHpVaWRtb01oZHB1bWl2b3IrSTZ5ZTNB?=
 =?utf-8?B?L2FRalRMVzNrY25xVDl4M2IyUG8ycUd0SUVGME44bXhyclc0SWpoQ2NhRFhz?=
 =?utf-8?B?WU5MejZWVmg3dGRQd0NYdk1VSDdYSExJaFpESDlFSDg2NjRJYWVUMGV0VU9Q?=
 =?utf-8?B?a0U1VnBjdHVYaUtqU1U3STNEYkZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC851B630CA41F4F802E38300F0CCB15@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5008ac-dc26-4b37-7680-08de0ff28e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 16:05:57.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OM+T0yJqyGv2dRg9bAJpiv+6kw/yYC4KZ3tV8L+6ztndXCbPndHAZMpGd/TMx1HzbXSeXFcpOctrUwI6LRX6grvQCb3PxijLi9r9JBBYTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9339
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDEzMyBTYWx0ZWRfX9Fm3+FlfLmGz
 UkFLcfkRYKUumEpHq9Nh1omoSP5Qpe7QJFyI52D8HPmPoGL44qRYC+9+Ot0lVVYPNW11yRXfO/Q
 8BdfokfdMoRfDUuphsUHUboacmdKtt9V/C7vMCx8elMAlqPDpo056qi9euuuwZPzihS5ZKem9Io
 7chR0tpb3d3psA2v/YyJVAG+pQHrK5qOYlS29i9Og5JyGnADRqp5TjtEHfgZmYiAlt7t4b938oX
 5iTyM/RuqGh0pRzgy0bQ7xn4IB98/vpnRjoiWybyHCKw3HcFPvyfvCs6YQWCemh+hRv6cuBLs53
 ZE0Q6YxkjgfX3mKolwTQN3XQIWmqR52rFsQfOliyPT3eB4XHuTdeUcJbyq97aKQDcDThNtW2BKT
 sPv+I+L2y0eRNFdgL3vrJezAB0/N3w==
X-Authority-Analysis: v=2.4 cv=ZqDg6t7G c=1 sm=1 tr=0 ts=68f65de9 cx=c_pps
 a=QffN0g5EZ+Wxgj/Qwxz7mA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8 a=qS2813D5IqS8p9u6ryMA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Dq-HT9CLPIlNBt4QhUFhcAkhL1tFb9QQ
X-Proofpoint-GUID: Dq-HT9CLPIlNBt4QhUFhcAkhL1tFb9QQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDIwLCAyMDI1LCBhdCAxMTo0OOKAr0FNLCBTZWFuIENocmlzdG9waGVyc29u
IDxzZWFuamNAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJ
T046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIFRodSwgT2N0
IDE2LCAyMDI1LCBKb24gS29obGVyIHdyb3RlOg0KPj4gQSBWTU0gbWF5IG5vdCBleHBvc2UgSVRT
X05PIG9yIEJISV9DVEwsIHNvIGd1ZXN0cyBjYW5ub3QgcmVseSBvbiB0aG9zZQ0KPj4gYml0cyB0
byBkZXRlcm1pbmUgd2hldGhlciB0aGV5IG1pZ2h0IGJlIG1pZ3JhdGVkIHRvIElUUy1hZmZlY3Rl
ZA0KPj4gaGFyZHdhcmUuIFJhdGhlciB0aGFuIGRlcGVuZGluZyBvbiBhIGNvbnRyb2wgdGhhdCBt
YXkgYmUgYWJzZW50LCBkZXRlY3QNCj4+IElUUy11bmFmZmVjdGVkIGhvc3RzIHZpYSBhIENQVSBm
ZWF0dXJlIHRoYXQgaXMgZXhjbHVzaXZlIHRvIFNhcHBoaXJlDQo+PiBSYXBpZHMgYW5kIG5ld2Vy
IHByb2Nlc3NvcnMuDQo+PiANCj4+IFVzZSBYODZfRkVBVFVSRV9CVVNfTE9DS19ERVRFQ1QgYXMg
dGhlIGNhbmFyeTogaXQgaXMgcHJlc2VudCBvbg0KPj4gU2FwcGhpcmUgUmFwaWRzKyBwYXJ0cyBh
bmQgcHJvdmlkZXMgYSByZWxpYWJsZSBpbmRpY2F0b3IgdGhhdCB0aGUgZ3Vlc3QNCj4+IHdvbid0
IGJlIG1vdmVkIHRvIElUUy1hZmZlY3RlZCBoYXJkd2FyZS4gVGhpcyBhdm9pZHMgZmFsc2UgbmVn
YXRpdmVzDQo+PiBjYXVzZWQgYnkgVk1NcyB0aGF0IG9taXQgSVRTX05PIG9yIEJISV9DVEwuIEZv
ciBleGFtcGxlLCBRRU1VIGFkZGVkDQo+PiBiaGktY3RybCBvbmx5IGluIHY5LjIuMCBbMV0sIHdl
bGwgYWZ0ZXIgYWRkaW5nIHRoZSBTYXBwaGlyZSBSYXBpZHMNCj4+IG1vZGVsIGluIHY4LjAuMCBb
Ml0uDQo+PiANCj4+IFsxXSAxMGVhZjljMGZiNyAoInRhcmdldC9pMzg2OiBBZGQgbW9yZSBmZWF0
dXJlcyBlbnVtZXJhdGVkIGJ5IENQVUlELjcuMi5FRFgiKQ0KPj4gWzJdIDdlYjA2MWIwNmU5ICgi
aTM4NjogQWRkIG5ldyBDUFUgbW9kZWwgU2FwcGhpcmVSYXBpZHMiKQ0KPj4gDQo+PiBDYzogUGF3
YW4gR3VwdGEgPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT4NCj4+IEZpeGVzOiAx
NTkwMTNhN2NhMSAoIng4Ni9pdHM6IEVudW1lcmF0ZSBJbmRpcmVjdCBUYXJnZXQgU2VsZWN0aW9u
IChJVFMpIGJ1ZyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5j
b20+DQo+PiAtLS0NCj4+IC4uLi9hZG1pbi1ndWlkZS9ody12dWxuL2luZGlyZWN0LXRhcmdldC1z
ZWxlY3Rpb24ucnN0ICAgICAgIHwgNSArKystLQ0KPj4gYXJjaC94ODYva2VybmVsL2NwdS9jb21t
b24uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA2ICsrKystLQ0KPj4gMiBmaWxl
cyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2h3LXZ1bG4vaW5kaXJlY3QtdGFyZ2V0
LXNlbGVjdGlvbi5yc3QgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2h3LXZ1bG4vaW5kaXJl
Y3QtdGFyZ2V0LXNlbGVjdGlvbi5yc3QNCj4+IGluZGV4IGQ5Y2E2NDEwOGQyMy4uM2NmZTRiOWY5
YmQwIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9ody12dWxuL2lu
ZGlyZWN0LXRhcmdldC1zZWxlY3Rpb24ucnN0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL2h3LXZ1bG4vaW5kaXJlY3QtdGFyZ2V0LXNlbGVjdGlvbi5yc3QNCj4+IEBAIC05OCw4
ICs5OCw5IEBAIE1pdGlnYXRpb24gaW4gZ3Vlc3RzDQo+PiBeXl5eXl5eXl5eXl5eXl5eXl5eXg0K
Pj4gQWxsIGd1ZXN0cyBkZXBsb3kgSVRTIG1pdGlnYXRpb24gYnkgZGVmYXVsdCwgaXJyZXNwZWN0
aXZlIG9mIGVJQlJTIGVudW1lcmF0aW9uDQo+PiBhbmQgRmFtaWx5L01vZGVsIG9mIHRoZSBndWVz
dC4gVGhpcyBpcyBiZWNhdXNlIGVJQlJTIGZlYXR1cmUgY291bGQgYmUgaGlkZGVuDQo+PiAtZnJv
bSBhIGd1ZXN0LiBPbmUgZXhjZXB0aW9uIHRvIHRoaXMgaXMgd2hlbiBhIGd1ZXN0IGVudW1lcmF0
ZXMgQkhJX0RJU19TLCB3aGljaA0KPj4gLWluZGljYXRlcyB0aGF0IHRoZSBndWVzdCBpcyBydW5u
aW5nIG9uIGFuIHVuYWZmZWN0ZWQgaG9zdC4NCj4+ICtmcm9tIGEgZ3Vlc3QuIE9uZSBleGNlcHRp
b24gdG8gdGhpcyBpcyB3aGVuIGEgZ3Vlc3QgZW51bWVyYXRlcyBCSElfRElTX1Mgb3INCj4+ICtC
VVNfTE9DS19ERVRFQ1QsIGVpdGhlciBvZiB3aGljaCBpbmRpY2F0ZXMgdGhhdCB0aGUgZ3Vlc3Qg
aXMgcnVubmluZyBvbiBhbg0KPj4gK3VuYWZmZWN0ZWQgaG9zdCBhbmQgd291bGQgbm90IGJlIG1p
Z3JhdGFibGUgdG8gYW4gYWZmZWN0ZWQgaG9zdC4NCj4+IA0KPj4gVG8gcHJldmVudCBndWVzdHMg
ZnJvbSB1bm5lY2Vzc2FyaWx5IGRlcGxveWluZyB0aGUgbWl0aWdhdGlvbiBvbiB1bmFmZmVjdGVk
DQo+PiBwbGF0Zm9ybXMsIEludGVsIGhhcyBkZWZpbmVkIElUU19OTyBiaXQoNjIpIGluIE1TUiBJ
QTMyX0FSQ0hfQ0FQQUJJTElUSUVTLiBXaGVuDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2Vy
bmVsL2NwdS9jb21tb24uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4+IGluZGV4
IGM3ZDM1MTI5MTRjYS4uM2RlNGI1MWQ4NjgxIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2Vy
bmVsL2NwdS9jb21tb24uYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYw0K
Pj4gQEAgLTEzNjEsOSArMTM2MSwxMSBAQCBzdGF0aWMgYm9vbCBfX2luaXQgdnVsbmVyYWJsZV90
b19pdHModTY0IHg4Nl9hcmNoX2NhcF9tc3IpDQo+PiAvKg0KPj4gICogSWYgYSBWTU0gZGlkIG5v
dCBleHBvc2UgSVRTX05PLCBhc3N1bWUgdGhhdCBhIGd1ZXN0IGNvdWxkDQo+PiAgKiBiZSBydW5u
aW5nIG9uIGEgdnVsbmVyYWJsZSBoYXJkd2FyZSBvciBtYXkgbWlncmF0ZSB0byBzdWNoDQo+PiAt
ICAqIGhhcmR3YXJlLg0KPj4gKyAgKiBoYXJkd2FyZSwgZXhjZXB0IGluIHRoZSBzaXR1YXRpb24g
d2hlcmUgdGhlIGd1ZXN0IGlzIHByZXNlbnRlZA0KPj4gKyAgKiB3aXRoIGEgZmVhdHVyZSB0aGF0
IG9ubHkgZXhpc3RzIGluIG5vbi12dWxuZXJhYmxlIGhhcmR3YXJlLg0KPj4gICovDQo+PiAtIGlm
IChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikpDQo+PiArIGlmIChib290X2Nw
dV9oYXMoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikgfHwNCj4+ICsgICAgIGJvb3RfY3B1X2hhcyhY
ODZfRkVBVFVSRV9CVVNfTE9DS19ERVRFQ1QpKQ0KPiANCj4gVWgsIGRvbid0IHlvdSB3YW50IHNv
bWV0aGluZyBsaWtlIHRoaXM/DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2Nw
dS9jb21tb24uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4gaW5kZXggYzdkMzUx
MjkxNGNhLi44YzRiYzliNWQ4ZWQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
Y29tbW9uLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYw0KPiBAQCAtMTM2
NCw3ICsxMzY0LDcgQEAgc3RhdGljIGJvb2wgX19pbml0IHZ1bG5lcmFibGVfdG9faXRzKHU2NCB4
ODZfYXJjaF9jYXBfbXNyKQ0KPiAgICAgICAgICogaGFyZHdhcmUuDQo+ICAgICAgICAgKi8NCj4g
ICAgICAgIGlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikpDQo+IC0gICAg
ICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAhYm9vdF9j
cHVfaGFzKFg4Nl9GRUFUVVJFX0JVU19MT0NLX0RFVEVDVCk7DQo+IA0KPiAgICAgICAgaWYgKGNw
dV9tYXRjaGVzKGNwdV92dWxuX2JsYWNrbGlzdCwgSVRTKSkNCj4gICAgICAgICAgICAgICAgcmV0
dXJuIHRydWU7DQo+IA0KPiBGdW5jdGlvbmFsaXR5IGFzaWRlLCB0aGlzIGlzIHF1aXRlIGhlaW5v
dXMuICBJIGRvbid0IHNlZSB3aHkgdGhlIGFuc3dlciBpc24ndA0KPiAiRml4IHRoZSBWTU0gdG8g
c3BlY2lmeSBJVFNfTk8iLg0KDQpZZXMsIEkga25vdyBpdCBpc27igJl0IHRoZSBwcmV0dGllc3Qg
cGVyc29uIGF0IHRoZSBiYWxsOyBob3dldmVyLCB0aGUgcHJvYmxlbSBJIHdhcyB0cnlpbmcNCnRv
IHNvbHZlIGlzIGd1ZXN0cyBiZWluZyBkZXBsb3llZCBvbiDigJxvbGTigJ0gVk1Ncywgc28gd2Ug
Y291bGQgc3RvcCB0aGUgYmxlZWRpbmcNCmZyb20gdGhhdCBzaWRlLiBUaGUgYnVtbWVyIG9mIGFs
bCBvZiB0aGlzIGlzIHRoYXQgdGhlIGd1ZXN0IGRvZXMgaGF2ZSBlbm91Z2ggaW5mbw0KdG8gc29s
dmUgdGhpcyBmcm9tIHRoZSBndWVzdCBzaWRlIHdpdGhvdXQgVk1NIGludm9sdmVtZW50LCBidXQg
SeKAmW0gbm90IGdvaW5nIHRvDQpsaXRpZ2F0ZSB0aGF0IGFzIHRoZSBJVFNfTk8gYXBwcm9hY2gg
aXMgY2xlYXIuIElzIHdoYXQgaXQgaXMuDQoNCldhcyBydW5uaW5nIGludG8gc29tZSB0ZXN0aW5n
IGlzc3VlcyB3aXRoIG15IHFlbXUgY2hhbmdlIGludGVybmFsbHksIGJ1dCBJ4oCZbGwgDQpnZXQg
dGhhdCBvdXQgdGhpcyB3ZWVrIG9uY2UgSSBjbGVhciB0aGVtLg0KDQo=

