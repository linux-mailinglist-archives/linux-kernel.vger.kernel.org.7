Return-Path: <linux-kernel+bounces-853255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B3BDB071
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E053B2A61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B5827E045;
	Tue, 14 Oct 2025 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QVaTcnLn"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6981A073F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469394; cv=fail; b=jXxyCHfMEpCmiP5ZkmJi+EcHQl73FjAW6zIBxCVapQxCpcZvqJgk9EGi5ebeuuwfJWIdJaQWNGmaCcbmVKUojPGfar1uDOHn4ZZ47s0Fpc7eCEUoAF8g74M2FfP11PN5qg6GMmWLhhym5O3mYPtisv/xjJqghgiggesZPm1310E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469394; c=relaxed/simple;
	bh=1GbwqTxpJrFWW2DLnSiQAnpUBD6TbsZLE9yTm05iBA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VGeuIxyzrbjA5lBPFYBrIQIs1h/su/DuZXPncsoqqLjjfkHX99eOS4Kc7h3j2H//ToN6H3ypFvd759SiODzOFWI2+X7SwcS2+flWIEwbF/TTyDrb/mnjZenguocwWc6fZE+OTN59qDbL3+J7C90Uzx0PBACvnkpN2uE3d+rKDBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QVaTcnLn; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPoOTidMeA/DmQUmmsVtbzprzuVIpnyk7kMP3U0GnCWfHfnrE07lE5VUsa6MzP8l8zVAq3G857+T5/zrI99Sy/JuvXcoB23IReVpOmJ64BTqMgLwQ5tBp2uLxANuy0SZjU3hBOP4pDMnlHjVxj/KugNNVLWQ2jVszx5td+Z9ZOVyl/rM+monh6N0/kFA5V+pJWZUde7w/jvbhWTqUZFK0S60o4DGFP3Kd7T5pSd5DGcgiTz/pq1wqH8exjzmw1oQZdeXpXmTvIfP2dIeA3Rv1Fp3odcTezEahODeV0Gpt1+rH2Jp3UU4zaW1zpbNlb0Ni3f/eucxK82k5krQMLmgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GbwqTxpJrFWW2DLnSiQAnpUBD6TbsZLE9yTm05iBA0=;
 b=R7s1JvPXcH+QgH+OO41AX9wjhXXIh+NvAINVQzxi3RREm0uBIhM4/Km00fJQ8+Ck+Df6QTooHK1AKK2l1XBrRUBudzmrq6TsNwnMLXJhQK+UF2vPMdlruWIvXrb0dcYsTpp00nrZJlzTnjaxm3q8Lm+eVYjgNTisgnW/+6BKiUMw7DhSuefQs+MKe9SlieWIYgE1WcdfPGD8Sw3qAB9qMDTMoVBocZJW+dcMSXpbazl9DQzVG4v9jKVG7xNlBY/ytAprIfQSQLfPj1qm0QFUYfJk2oZiFr/VVTi38lhjK2raQBDQ/2gkmQ6iiFtkFDThkv4zrG3WVvWgNh1W6yjIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GbwqTxpJrFWW2DLnSiQAnpUBD6TbsZLE9yTm05iBA0=;
 b=QVaTcnLnonplvpNlpQVPeoipEC/WsWkVhbsOklMI5o0nKVQ6W47yl7CKMJ2F1wV53WAZjUh3V/D9z3D4cC+s7+PJjWP7JaXVd61IqOkNCMfToiQla3JvczjcaXpq+O/XhuC1oIhbM1jpMJWlH1WBCtg9lkqM0g6NzUgCedwe5QU=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 19:16:28 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%4]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 19:16:27 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 04/56] x86/bugs: Reset spectre_v1 mitigations
Thread-Topic: [RFC PATCH 04/56] x86/bugs: Reset spectre_v1 mitigations
Thread-Index: AQHcPTmsRe1Ck9Ncck2JRlQCLRKbhbTB/oog
Date: Tue, 14 Oct 2025 19:16:27 +0000
Message-ID:
 <LV3PR12MB926554015AFB93D35AE3098094EBA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-5-david.kaplan@amd.com>
 <839b7bc9-b155-4458-ad36-fa083659283c@intel.com>
In-Reply-To: <839b7bc9-b155-4458-ad36-fa083659283c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-14T18:58:15.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DM6PR12MB4267:EE_
x-ms-office365-filtering-correlation-id: a591cd82-5bfc-4fff-e79c-08de0b562c69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTgySmVsRFhHZjVYVXdnR25Fd3RrR2dVdG1vNXFBNDNjQzNseFRzUk9meVZj?=
 =?utf-8?B?MzFwR1VFb29QYmlUYjJXbzJQbEUzTFU3WEx2MFpLcUprUUxtb0dzMmlWa1hO?=
 =?utf-8?B?UHNod25UZmh0WE5HelhWcEdrMzhzSDNqQ0tZalZTM0dPeDVMRWlLbldXQ3Rp?=
 =?utf-8?B?N0FrR3JCbGlveEpDcHR4dTFTaWtQcmxtOWNlWjBTSlVYOVRHcTcwSkNkV1Mv?=
 =?utf-8?B?aVAxNmMxK2orRTlIUFFxRWxHbHIxMjkvRldJbXBVNFdyaFUzNnJmNnVIUHJI?=
 =?utf-8?B?WitQb1JaOHJESXo5ckRyTk5JZVhsNnhvS29DcURob29sTm1VSTFYa09lUkVm?=
 =?utf-8?B?UndNOEZwMTBXYkV0LzRxeTVBdnpka0E1NVR4ejJySVk1MGpxdEpQUExwNDJT?=
 =?utf-8?B?cXZvTEFhbnRYTkZqanZRdVlLR3FjV1JEbXc1WjNiU3pWa0ZiVXFKZS9iK1dq?=
 =?utf-8?B?L0o4cnF4Ulp2bXJ2TDlaTUltTXNWQWVSNTIrbk5rUjJyd1hrTXdJaHpSZWZU?=
 =?utf-8?B?bDJvL1ZpR1pqRGxWaGM1N25TblU2cjlsSTA0VjV5UjA1eGFTems3NVYwQXRp?=
 =?utf-8?B?WXZ3bk56akhnOERTaGZyL29uTWxzcnZwV01FemxOODI2WUVGR1ViZGYwNlVT?=
 =?utf-8?B?OCtpUE9RSXRxazJUS0hmT0JXZmZnQWdKRCttazJvNUs4cVNIelJJWC9SUzk4?=
 =?utf-8?B?OVZyM2tqZ09GZDFhZzR6NzNqeUF2OENVNW5WblFTRzFyWUU0b0lpVjJwaWVy?=
 =?utf-8?B?WUVRTUxSUFgrOGVlc1NkQ25vRk81SUs1dEhHQUhSSDlLVzJWc3dWV294M24z?=
 =?utf-8?B?Y3NZNUZsbG9zQkdhZTRGNjVHNyt5NHhpN1A4elRzK2w5Zks5SGVFVnI5VFVq?=
 =?utf-8?B?aDhzZXV1RUFiVld2QXZ2c0kxSEtkeFcxUG94anJOSVJPcTQzSVNjL2pwZ3RR?=
 =?utf-8?B?UGNhS2dRc1FiT0FRbFJjc2wxQ21lRno5VkZWUXlPRVFPQWhPbVJUaVRoNXl2?=
 =?utf-8?B?Mnc3K3NkQVNOcjRGbU5ySXVWQlVnSzFlbzQwU3gyQndmM1htaGxONjQ5VHhs?=
 =?utf-8?B?ZlovaVlaa20zUGwybjdiNVdpaGJzMUMxM2pXM0laVEZ6R3Q1RGQ1eWlBWkJm?=
 =?utf-8?B?b2V3S0VwMDk3QzM1cGhYcTJ6Z1AxTGlFNTRpUE5EYVFJMitqOEh5cnRmL09P?=
 =?utf-8?B?WTQzN2liVE9JZEU2TlcvcjNoQklIWUkwUjNKQkt3WS90K1B3YndTQ016bzBu?=
 =?utf-8?B?ZEo5VDhxVGRCSXMzemJZWXdwK1VINDdlLzhCR0dldEZNaVFxVjRLa3M1UFBw?=
 =?utf-8?B?Z09IOE1hVmdseTU2dFpBVTdPSG5qSVhJNFRKU3ArUVV5R0tnSDNMS3VoMUhn?=
 =?utf-8?B?T000TnE0QWRwbTk0dGc2OVlNU1o1UGl3b3loUENWWWpLSzNjalhLbDc2aG4x?=
 =?utf-8?B?RWw1ZXViZE5nck1Pc1RPQ2lPOUxpQWxoNHZBV0d3ZXJ6ZzJUNkQ3c2lidjVS?=
 =?utf-8?B?cHNyenhtbGZsV1NMRldKbmQzaGRFdytScS9aODJlQzJuanQyMzZLYTFmSDB0?=
 =?utf-8?B?MmhuNDlvT1BzNTJieTdISUR6a2NBbmxHdXZhckJoWHkyTm0yQkFSZGhWMUh3?=
 =?utf-8?B?YjBrQWtLQThpKzYxQnlWR3QwUmpUSDlzdjR6djBDODJwVGZmcnBwOVRVUlN1?=
 =?utf-8?B?Zm9tdnhYeDJqb0pSOVd0dFFPRHJhaUhMSVV4VTZPSWpGa2RFMWRTQXIrb3Z0?=
 =?utf-8?B?ZWhIVFBkdzIxbWx3UVNjc1lvVXREMElTS3R1SlBsaGtiY214OXJqMGVoZlpZ?=
 =?utf-8?B?ekFKZzNadWJoYkpSamkwdld6M3JidEh2d0w1UzBHU2piazNGdjd3NWRna3hY?=
 =?utf-8?B?YThsa1phenNqdTRaMUpUVEF2cUgrVUFacE1EczAzRTAyWDR6cWdrSkc3Q1Z5?=
 =?utf-8?B?cUdNM1VzUXVmQnlobnFnQjdVMjNvUGJZQW1NYUZQNGl1ZXljdXpPN0pEeml1?=
 =?utf-8?B?WDc5Z1E1MGFURTFkUlZPWkJpQjY2Y2MwTy9EZERveGlzRk1jTk9OU0l5dUtU?=
 =?utf-8?B?VzFmRmhxZHIwSEZJZXRKUXlSaEhSRmp1cHVJZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnhIT2lLY1ZPY3pwWS9EQ1EvK2hDMHpQL0s1dnpVVmQ5UWI1aXpHbWluckRU?=
 =?utf-8?B?aW1Ba1o0TGpBVFRLQUdQUUFDNTByeEpFN2xJN05CcXlKSHZ0NmhGVUdWcDF0?=
 =?utf-8?B?S1Y2dll2WlVYUEFBakhrZ2NuZ3JwdDNTUElFdGZKQTFvT0tORHlmbG01elNx?=
 =?utf-8?B?SHpYa3UzSVV5S0Y4MVNBMWxJZThORTM5bWhBQ1k4TE9SYmZ4aW1RandLRE84?=
 =?utf-8?B?NDd0RWVWaGpERWtLdEJQQ0tTOTBCbWdwWEJvTS9odUg4SkZlS1VxbVhKQkNT?=
 =?utf-8?B?U0hYNEJ6V0NjN0ZORzdGb05OMzBTOWpxQXNZYU5FQVZ1aldSYXRncktyckN2?=
 =?utf-8?B?anFpb2RUSzhoZUtOTmMyZzc3b2xZbzZ6RzYybnB2NjFWNVpoazJmSWp4OVZs?=
 =?utf-8?B?SDArOEphN044TVpQRVBiMit2OHE1ZkZuWlY3bExnU1FaeGk5VUxQL0VWMlBG?=
 =?utf-8?B?d1B1eEl0OGxoRWtOU0RUR1V2ZDdudVNjNTFoSFk4dTdHK3ljZlovQXRzTDNa?=
 =?utf-8?B?OWZpR1FFRWZzOERMVkZDRTRHTERPVHFURDJsL1FZRnF5QS8vc3dyL3dNNFRR?=
 =?utf-8?B?dWNKL1NLM3RVaGQvRXhsVjY3UXhVanQyQmtpN3dvbUNGNXlhcThNUUR6L3E4?=
 =?utf-8?B?NHc1THpGWGNFdGRiQXEyTHJZbzlPUW1zcGVDazRreUJzaG5ZWVhIdUsrTTh0?=
 =?utf-8?B?ZXp0am1Qb2dMTUt1MDRUWWFYS05HYVRKa0VTN1prTFE4WUE3K2VJZ21xZEtM?=
 =?utf-8?B?Y3R6VmNOVWFXTjBhZ0NkNDlFRkVscGZuQ2p2MkllNXQ5UmExbG1Pb1BqclYw?=
 =?utf-8?B?d3BhVzA2NEk4bWV3b1MwS3NFdEJ6cllZZC8xMlRDMkliZXpsK3VBeElsdXo2?=
 =?utf-8?B?ZytDRTlFNHVYMGcyYWRBQ0V3WW5CUlZXVk9wRFdvVCtRZ0lYUGtTZmRmSHZL?=
 =?utf-8?B?cWNuVWp1ZVpHZ2VPNFFuckRDcGo5ZlNjdkRLVGVjRkt6UFo5Ty9rUnhtdEFi?=
 =?utf-8?B?ck4renpLOWtXWXRoUEhPNCtLalJaQVpTOTMxR3FKNlFLTE40cy9NQVpaT1hO?=
 =?utf-8?B?UXRMdjB3YjdqSXluOHhIR2tsUkpmRnZIT0xwNlFwUFMwM1ZpdDl2KzEzSk0y?=
 =?utf-8?B?dVgzVUdsZmYxWGR6Ti9Wcmlvb2t2OXp0YTNjZmc1ai9ZTFYyd1dsUnRqSWVZ?=
 =?utf-8?B?Z3RRbHJodTZRRGYzRGV0T0hnMld0WW56YzR5MjVRajJBcG9OL3dmcUxxYS96?=
 =?utf-8?B?dzRxSVFZVUYvRkVYMUNGaDVQSi9JemhEaEU2dlJ0Wnh1b2hwK1Q0b1JMbGV5?=
 =?utf-8?B?eDU0emJEZEhZYlowZ1Y2ODF1TXI3ckVMVjNZQ3J5OWdHR3dDT0hNMzF1SjBS?=
 =?utf-8?B?WjZjTU51UzhUSUJ4QjVCRkZzR1BYdTdrS01uZHEzdlhmMjNIUXZjZlhyUVBa?=
 =?utf-8?B?MmpzNWVFd0FjaW1yaG5xT0dhcm5kcmlSY3pTRXhSRU1vMFQ5eExtNWRHWnVU?=
 =?utf-8?B?MWlwVDZ4ZFFCRzRvY2ZYUUkyMFMrbmR5aVYxR2JmOUZaUTROUS9WNDFOUktP?=
 =?utf-8?B?R0VJY0drN0tPRWZPK0FULzYxd3E0a1FmUTcrTHlUbVBRSm8rcXZLdHdxVHU5?=
 =?utf-8?B?Y3UrYkorN3FPQXhWTndCVjVFV1B0cVcweHU0OFBtVERtSFdRY3pqS1I0SnNm?=
 =?utf-8?B?NTNtZm5SY3BsVkVsdUdDdEFxR3RBL0NxcEw4anNNL1crQ3ZUcVdYMllSVURh?=
 =?utf-8?B?VWVMUnVIY1ZvVjUxeFIxSVZVdC9zcE9qeERTbkw0S0JRTmptdFRwZ0E5N3lP?=
 =?utf-8?B?M3c5R3psRGlveW92TnppWHY4TGtySzFCZ28za2pMTDF5UGdyb0Ird1hTUldU?=
 =?utf-8?B?SHRmb1c0UlRwRWRodkszYUxDNzE5Z0lYTGQwV1VzNExUUVByVkdJd0hQRk9i?=
 =?utf-8?B?NmMzQzVBRDVUYU8vS01NNCtubFpGbXBDZFNzQWxaNnkrK0k3QWtpcDJiV0JK?=
 =?utf-8?B?ZnZQTy80N0dqWEorejdXMnpEc1g5V2w5OWhGYzdxMmhyNGovTHc1Z3hQVEU2?=
 =?utf-8?B?SXpIajhDbXJZWmczOWtmSnk5bmt1Vi91M3c2UHVCZ1MyMGJVTkhmL0ZYVFBQ?=
 =?utf-8?Q?fDZ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a591cd82-5bfc-4fff-e79c-08de0b562c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 19:16:27.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MhE824C8dhnG/P0ap7u8VHaCMu+sqWZiPZl6nBVFVBITnKLbg0l++E7UsJpyDi3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2
ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE0LCAyMDI1IDE6
MzggUE0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgVGhvbWFz
IEdsZWl4bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFs
aWVuOC5kZT47IFBldGVyIFppamxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEpvc2gg
UG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1
bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29t
PjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47IHg4NkBrZXJu
ZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6eXRvci5jb20+DQo+IENjOiBBbGV4YW5k
ZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPjsgQm9yaXMgT3N0cm92c2t5DQo+IDxib3Jpcy5vc3Ry
b3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtSRkMgUEFUQ0ggMDQvNTZdIHg4Ni9idWdzOiBSZXNldCBzcGVjdHJlX3YxIG1pdGln
YXRpb25zDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0
ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1l
bnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMTAvMTMvMjUg
MDc6MzMsIERhdmlkIEthcGxhbiB3cm90ZToNCj4gLi4uDQo+ID4gKyNpZmRlZiBDT05GSUdfRFlO
QU1JQ19NSVRJR0FUSU9OUw0KPiA+ICtzdGF0aWMgdm9pZCBzcGVjdHJlX3YxX3Jlc2V0X21pdGln
YXRpb24odm9pZCkNCj4gPiArew0KPiA+ICsgICAgIHNldHVwX2NsZWFyX2NwdV9jYXAoWDg2X0ZF
QVRVUkVfRkVOQ0VfU1dBUEdTX1VTRVIpOw0KPiA+ICsgICAgIHNldHVwX2NsZWFyX2NwdV9jYXAo
WDg2X0ZFQVRVUkVfRkVOQ0VfU1dBUEdTX0tFUk5FTCk7DQo+ID4gKyAgICAgc3BlY3RyZV92MV9t
aXRpZ2F0aW9uID0gU1BFQ1RSRV9WMV9NSVRJR0FUSU9OX0FVVE87DQo+ID4gK30NCj4gPiArI2Vu
ZGlmDQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IF9faW5pdCBub3NwZWN0cmVfdjFfY21kbGluZShj
aGFyICpzdHIpDQo+ID4gIHsNCj4gPiAgICAgICBzcGVjdHJlX3YxX21pdGlnYXRpb24gPSBTUEVD
VFJFX1YxX01JVElHQVRJT05fTk9ORTsNCj4gPiBAQCAtMzc5NCwzICszODA1LDEwIEBAIHZvaWQg
X193YXJuX3RodW5rKHZvaWQpDQo+ID4gIHsNCj4gPiAgICAgICBXQVJOX09OQ0UoMSwgIlVucGF0
Y2hlZCByZXR1cm4gdGh1bmsgaW4gdXNlLiBUaGlzIHNob3VsZCBub3QNCj4gaGFwcGVuIVxuIik7
DQo+ID4gIH0NCj4gPiArDQo+ID4gKyNpZmRlZiBDT05GSUdfRFlOQU1JQ19NSVRJR0FUSU9OUw0K
PiA+ICt2b2lkIGFyY2hfY3B1X3Jlc2V0X21pdGlnYXRpb25zKHZvaWQpDQo+ID4gK3sNCj4gPiAr
ICAgICBzcGVjdHJlX3YxX3Jlc2V0X21pdGlnYXRpb24oKTsNCj4gPiArfQ0KPiA+ICsjZW5kaWYN
Cj4NCj4gQXJlIGFsbCB0aGUgI2lmZGVmcyBuZWNlc3Nhcnk/IEZvciBpbnN0YW5jZSwgYSBzaW5n
bGU6DQo+DQo+ICB2b2lkIGFyY2hfY3B1X3Jlc2V0X21pdGlnYXRpb25zKHZvaWQpDQo+ICB7DQo+
ICsgICAgICAgaWYgKCFJU19FTkFCTEVEKENPTkZJR19EWU5BTUlDX01JVElHQVRJT05TKSkNCj4g
KyAgICAgICAgICAgICAgIHJldHVybjsNCj4gLi4uDQo+DQo+IGFuZCByZW1vdmluZyAqYWxsKiB0
aGUgI2lmZGVmcyBtaWdodCBiZSBlbm91Z2ggdG8gdGVsbCB0aGUgY29tcGlsZXIgdGhhdA0KPiBh
bGwgdGhlICpfcmVzZXRfbWl0aWdhdGlvbigpIGZ1bmN0aW9ucyBhcmUgdW5yZWFjaGFibGUuDQoN
Ck9oLCBobW0geWVhaCB0aGF0IGNvdWxkIGJlIHdvcnRoIHRyeWluZyBpbnN0ZWFkLg0KDQo+DQo+
IEJ1dCB0aGUgbGFyZ2VyIGNvbmNlcm4gdGhyb3VnaCBhbGwgb2YgdGhpcyBpcyB0aGF0IHRoaXMg
aXMgYWxsICpuZXcqDQo+IGNvZGUuIFRoZSByZXNldCBjb25jZXB0IGlzIGNvbXBsZXRlbHkgbmV3
IGFuZCB0aGUgcmVzZXQgZnVuY3Rpb25zIGxvb2sNCj4gdG8gYmUgYWQtaG9jLiBUaGV5IGZvbGxv
dyBhIGZldyBwYXR0ZXJucywgYnV0IG5vdGhpbmcgc3VwZXIgY29uc2lzdGVudC4NCg0KVGhlIHJl
c2V0IGxvZ2ljIGlzIGJhc2ljYWxseSAndW5kbydpbmcgdGhlIGFwcGx5X21pdGlnYXRpb24oKSBm
dW5jdGlvbnMuICBTbyBhbnkgZmVhdHVyZSBmbGFnLCBzdGF0aWMgYnJhbmNoLCBldGMuIHRoYXQg
bWF5IGdldCB0b3VjaGVkIGluIHRoZSBhcHBseSBmdW5jdGlvbiBhcmUgcmVzZXQgaW4gdGhlIHJl
c2V0IGZ1bmN0aW9uLg0KDQpUaGF0J3Mgbm90IHRoZSBvbmx5IHdheSB0aGlzIGNvdWxkIGJlIHN0
cnVjdHVyZWQuLi50aGVyZSBjb3VsZCBiZSBhIHNpbmdsZSBmdW5jdGlvbiB0aGF0IHJlc2V0cyBh
bnkgYW5kIGFsbCBtaXRpZ2F0aW9uLXJlbGF0ZWQgdGhpbmdzIHVzZWQgYnkgYW55IG9mIHRoZSBt
aXRpZ2F0aW9uICh0aGVyZSBpcyBjZXJ0YWlubHkgb3ZlcmxhcCBpbiBtYW55IG9mIHRoZW0pLiAg
V2hlbiB3cml0aW5nIGl0LCBJIGZvdW5kIHRoZSBjaG9zZW4gYXBwcm9hY2ggdG8gYmUgcHJldHR5
IHN0cmFpZ2h0Zm9yd2FyZCBiZWNhdXNlIGl0IHdhcyBlYXN5IGVub3VnaCB0byBtb2RlbCB0aGUg
cmVzZXQgZnVuY3Rpb24gYWZ0ZXIgdGhlIGFwcGx5IGZ1bmN0aW9uIChhbmQgdGhhdCdzIHdoeSBp
dCB0eXBpY2FsbHkgZm9sbG93cyB0aGUgYXBwbHkgZnVuY3Rpb24gaW4gdGhlIGZpbGUpLg0KDQo+
DQo+IEFsc28sIHRoaXMgc2VyaWVzIGlzIGdvaW5nIHRvIG5lZWQgdG8gYmUgYnJva2VuIHVwLiBJ
J2Qgc3VnZ2VzdCBnb2luZw0KPiBhZnRlciB0aGUgZHluYW1pYyBhbHRlcm5hdGl2ZXMsIGZpcnN0
LiBJJ20gc3VyZSB0aGVyZSdzIGEgbmVlZCBmb3IgdGhhdA0KPiBfc29tZXdoZXJlXyBvdGhlciB0
aGFuIGZvciB2dWxuZXJhYmlsaXRpZXMuDQoNCk9rLiAgSSdtIGNlcnRhaW5seSBvcGVuIHRvIGlk
ZWFzIG9mIHdoYXQgZWxzZSBjb3VsZCBiZW5lZml0IGZyb20gdGhpcyB0eXBlIG9mIGZ1bmN0aW9u
YWxpdHkuDQoNCkkgdGhpbmsgdG8gcHJvcGVybHkgcmUtcGF0Y2ggdnVsbmVyYWJpbGl0aWVzLCB3
ZSBuZWVkIGFsbCAzIHRoaW5ncyAoYWx0ZXJuYXRpdmVzLCByZXR1cm5zLCBpbmRpcmVjdHMpLiAg
V2UgZG9uJ3Qgd2FudCB0byBjcmVhdGUgc29tZSBpbnRlcm1lZGlhdGUgdGhpbmcgd2hlcmUgdGhl
IGtlcm5lbCBpcyBwYXJ0aWFsbHkgcGF0Y2hlZCBpbiBvbmUgd2F5IGFuZCBwYXJ0aWFsbHkgcGF0
Y2hlZCBpbiBhbm90aGVyIHdheS4gIFBhcnQgb2YgbXkgZ29hbCBoZXJlIHdhcyB0aGF0IGFmdGVy
IHJlLXBhdGNoaW5nLCB0aGluZ3Mgc2hvdWxkIGxvb2sgbGlrZSB5b3UgaGFkIG9yaWdpbmFsbHkg
Ym9vdGVkIHVuZGVyIHRob3NlIHNhbWUgb3B0aW9ucy4NCg0KQnV0IGlmIHRoZXJlIHdhcyBhbm90
aGVyIHVzZSBjYXNlIGZvciBzYXkganVzdCByZS1wYXRjaGluZyBhbHRlcm5hdGl2ZXMsIHRoYXQg
c3VwcG9ydCBjb3VsZCBwcmVzdW1hYmx5IGJlIGV2ZW50dWFsbHkgbGV2ZXJhZ2VkIHRvIHBhdGNo
IG1pdGlnYXRpb25zLg0KDQo+DQo+IEJ1dCwgaW4gdGhlIGVuZCwgKElNTkhPKSB0aGlzIHNlcmll
cyByZWFsbHkganVzdCBhZGRzIGNvbXBsZXhpdHkuIEl0DQo+IGRvZXNuJ3QgZG8gZW5vdWdoIHJl
ZmFjdG9yaW5nIG9yIGNvbXBsZXhpdHkgcmVkdWN0aW9uIHRvIGdvIGluIHdpdGggdGhpcw0KPiBh
cHByb2FjaC4NCg0KRndpdywgdGhpcyBzZXJpZXMgZG9lcyBhY3R1YWxseSBoZWxwIGEgbG90IHdp
dGggbWl0aWdhdGlvbiB0ZXN0aW5nLiAgSW4gZmFjdCwgYXMgcGFydCBvZiB0aGUgZGV2ZWxvcG1l
bnQgSSB3cm90ZSBhIGZ1enplciB0byB0ZXN0IHZhcmlvdXMgY29tYmluYXRpb25zIG9mIFg4Nl9C
VUcgYml0cyBhbmQgY29tbWFuZCBsaW5lIG9wdGlvbnMuICBUaGF0IGZvdW5kIHNldmVyYWwgYnVn
cyBpbiB1cHN0cmVhbSBpbiBmYWN0ICh3aGljaCBJIHN1Ym1pdHRlZCBzZXBhcmF0ZSBwYXRjaGVz
IGZvcikuICBHaXZlbiB0aGUgbnVtYmVyIG9mIGRpZmZlcmVudCBwaWVjZXMgb2YgaGFyZHdhcmUg
dGhhdCBleGlzdCwgdmFyaW91cyBjbWRsaW5lIG9wdGlvbnMgKGFuZCB0aGVpciBpbnRlcmFjdGlv
bnMpLCBJIHNlZSBiZWluZyBhYmxlIHRvIGJldHRlciB0ZXN0IHRoZSBtaXRpZ2F0aW9uIGxvZ2lj
IGFzIGEgcG9zaXRpdmUgdGhpbmcuICBPYnZpb3VzbHkgdGhhdCBtdXN0IGJlIGJhbGFuY2VkIGFn
YWluc3QgdGhlIG92ZXJhbGwgY29tcGxleGl0eSwgYnV0IEkgdGhpbmsgaXQncyB3b3J0aCBub3Rp
bmcgdGhhdCB0aGVyZSBtYXkgYmUgc29tZSBtYWludGFpbmFiaWxpdHkgYmVuZWZpdHMgdG9vIG9m
IHJ1bnRpbWUgcmUtY29uZmlndXJhdGlvbi4NCg0KLS1EYXZpZCBLYXBsYW4NCg==

