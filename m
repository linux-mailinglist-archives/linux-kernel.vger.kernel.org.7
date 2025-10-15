Return-Path: <linux-kernel+bounces-854827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51818BDF7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9B619C7DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67030BF67;
	Wed, 15 Oct 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Q1aqJgQ"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C713093A1
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543467; cv=fail; b=uHlz92HFBq/jVy0eAzGX+0MUFw/1X9C+3dmtI07mgCvcGgBVFjajwgb08HjsudNxV3s49wAknjnIF88/H4tkGQb7vBeAIaz1IgnNWiiceLLP2PFL/zY3mHCq7HNfIur1gzE+xn2qmCHAU06I3cHIV3WsbjRb1NIMY7fLXatieEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543467; c=relaxed/simple;
	bh=4zcErgbSl6aDTnBiSd35FYreuih6Vw0pdTXWlYAM3jU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4L3j6W0D+MMxI0yzw+iOh7e6CkWoJs01DiYHrTDnAUukgN7+vtjeT8dOUcAN3Po77RWJGucNg2knl/pm1cUNuCTW5OPPtnOVG9jr9tLR/JyimaHNohUE2eEylnHTOrxdAmih6/YcWR9XvVo8m0y8zqsbn/T/bTolsIcgECB3+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Q1aqJgQ; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRT6y2yImJC9/5pc2V5kx+XuPn5DqwxfFcDN/q1lk6HYRYxa6Rbjt8HbVVeiNkuanxhbprBDBcU05GiMfuXxAvVYBIVVa24otMAs56PVgjJBNtANhxkvr8nEuqN5LFPW1HZQ67rx+F13D+8+X+nn8sbcOz/oIamPNBndduTu9d1Qoc7RuaPtbpLnGQBhJRoYVbS7yvNwCRjzTPceVnPuhuaMbvQOrTVPNZnNs1fx7loQE9fI7JreFZRq199IwBDjQvadNLjLPR9SaBcB5ZLC4FK0y5kr/8JIAQ11C2uAti+vQyUKgdGCLk4e4MTwN7YACWaVGNZun6TGZNzReBPJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zcErgbSl6aDTnBiSd35FYreuih6Vw0pdTXWlYAM3jU=;
 b=kUP1yJl28e9pnm9tFmvKQfzAaukokm1kbTlYnmsSYm2PrBA3hxow8aS5HfHY8zShm8jC7+z/YQI7SRr4lXF1SH75RF+/xq3UgOwlsuKn+qzdTt0uoa0JzuSa4iorCSsBm9HiPg1qb9XN3wRiBgce999+QcHKJXnZrj6eq/lMBDGcRlFtOvXWXFlUX1BkpyhOAw50E3uNNQdqzYDN9I7iou3u+9Y2oMsTdZbmzn6RNvRwV3/NYpnSj4sC+vm+g+PQun7N1mgySX21oLOWax3nZDrflgiP8w+M1Beh1evXMvXJKvcZSxplWCX6MuiZ3zSEaQ47g5R7zSapQJiPjVOdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zcErgbSl6aDTnBiSd35FYreuih6Vw0pdTXWlYAM3jU=;
 b=5Q1aqJgQAdUo7PXdmg2Ab2ttVIHXYQocYzkPooKuoIQJ7zp0pY+SDYrJ75HtOzMmzJLfUcZ2PLRGjcK6TBW3QylGLXeMkEJhXjM0Fa6cVhZzUJ0CWHWKRRSdDxtXQl1e0YthTfB6440cYQ5+oHALtLCRKEVUilSd5zf8tOxjkp8=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Wed, 15 Oct 2025 15:51:01 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 15:51:01 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Aaron Rainbolt <arraybolt3@gmail.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 00/56] Dynamic mitigations
Thread-Topic: [RFC PATCH 00/56] Dynamic mitigations
Thread-Index: AQHcPYmqb7qd0BZyXkK7jo/Wse1167TDOpgwgAAfIoCAAACCsA==
Date: Wed, 15 Oct 2025 15:51:01 +0000
Message-ID:
 <LV3PR12MB9265837FA51DFD9D2F11474D94E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251014231039.6d23008f@kf-m2g5>
 <LV3PR12MB926564CC5E88E16CE373185694E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <cnwawavsdedrp6yyylt2wqiglekwsgrofimkvh32fknj676xsh@4vyzzoky5hzd>
In-Reply-To: <cnwawavsdedrp6yyylt2wqiglekwsgrofimkvh32fknj676xsh@4vyzzoky5hzd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-15T15:44:56.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DM3PR12MB9435:EE_
x-ms-office365-filtering-correlation-id: 9f47f9e3-45f6-4d48-68d7-08de0c02a3df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGpOR1paMnVnZlM2ckN6UFVWTnEzcE15LzJheHFYdGdjS2FDNjVhbjZFQ3hP?=
 =?utf-8?B?K3pZVis4Y2xodHlkaGlDN25xYVdrb293YjdQdnRqZmZKWEN5RGJEN3lYL2dD?=
 =?utf-8?B?V3hTbHB0N3hoNGZyRHY0TW9uTTJ3ZUNFY2Y3SktvZFJiS1BmNEtxT1FiTjNq?=
 =?utf-8?B?dGlsazEwa2wyVzdzci81bHVNMXhzVTZBM1AyYjY0TlppVytZSnBxdFovamt6?=
 =?utf-8?B?WFQ2SVlyNi91K3NnRTJ2anY0YytEdVh5Rk9pVjR2dTV5RHNYUloxL20xNEF6?=
 =?utf-8?B?WDkxTFJvK29vQUE5Z1hVY0FSN1NkcElIc1VNMmN5VzRYSldJQW1EN3lYMUV4?=
 =?utf-8?B?VU5IRjU1MVN4b0ZXblhWRlBJR2hhY09KT042L0o4SmRESExzMWVYZGE4ak0w?=
 =?utf-8?B?RXYvS2hQdllvNmR4eGlRYU11eGRwbk8wd1hSNmlOVmF6dkZ0cyt5VVVMa1Zo?=
 =?utf-8?B?ZkJVekFyaDUwaDArK20rbHdFd0o3eFdoM3QzQ0lyYTBaZDZVM3MramwyWGFu?=
 =?utf-8?B?S05FdzR6c2M3SmIzSWx6S3hpVGFMMElVdmFYUWRpVm9yZ3pkbFV5Rm02bzRm?=
 =?utf-8?B?TEtxRXlsVDErVU5rK0o0bjRKZzVGK3VRMmJqeFVTS1JKdFB4NkdEMVZGTldj?=
 =?utf-8?B?NVZBbk90bmRaaEtFNUU2UGp5ZjM4cEZXeUx4aWp4VklwRmcyNVQvUG1FK1Nz?=
 =?utf-8?B?KzliOGlkWFpIWDExb29EYlVla3BvZC93ZlVvS2tVOG80Y2NUUW1PbHVJM3Zt?=
 =?utf-8?B?MGJvWW41ZWVkMTl6NlRhWUtSam5XVXZqbm1DL3R4bjBOU2l1NXJzTDJqbDJD?=
 =?utf-8?B?aU9rMkpJdDFwdnJjRWxKbXAra1I4S29KV2dHU21RZktPVzl0bnNiRjB2YVkw?=
 =?utf-8?B?N3FZeDQ4WDRjRjdOUVBKSHp0bTlyMVU4VzRPOENBK0pUNmlzUGlyb2krcXF0?=
 =?utf-8?B?Skg5c0Y0WUZpWjBKZEZxdXNoUHlVRlNOZ1NaUGRMQUtPeThuVUEvREJaVGJT?=
 =?utf-8?B?RjNOV1F5WjZHMmpDRG0xZlpKa2xxcmN2RmZmMnVNZEliMStaaWdYYmpVMU9i?=
 =?utf-8?B?ZmYxKzRWdkcyZVhHR2dFbGxyTGNlWkRzcExRVTFVazF4UkRMRnlIUHlRbjRr?=
 =?utf-8?B?OTlrRno3RjFvNHBBdG56dWxHaE5IRzlkVVJnTDlvdXpvSkdxaTJadGhlWnJG?=
 =?utf-8?B?aEZnSG84N1pmb2tKUWlmWTZ5bHdtWkxtVHRBMzZQY0QvZDVIa0wzVTI3ZitG?=
 =?utf-8?B?Y0dHclU2cTA3cXZmVUMrOXBsWXBCZU0xa3RuT2pybUc2RzdSOWtvZzNLMDM0?=
 =?utf-8?B?NkdYZm85c0JpV0Z1ejhiYVgwUGVXWGdMY0dsOVZjZEV1OU1jNkx0MHo2WUw0?=
 =?utf-8?B?ak5udEd4YkdISlRrQTdSd1hmRmttSkpCUUlxMTRRcC9tQzNkbnZyMFp2dUZh?=
 =?utf-8?B?NzIxRFU4YkdBNjVWTloyYXcyaGQ3N0Zabmk0U0haRkN4Qk9FTHp2eGJZVkNq?=
 =?utf-8?B?ZUdJRjVhcDRtZTlJUEFLYXVETWF5SXpHOWlaRVQwVlNtTElJcHovb3UvL2U2?=
 =?utf-8?B?OW1rVWRSNzRJeVNIZHE2SUxXVHRQaGM3alpFR1FkR0F1SjFhYVpLWDBEZXVu?=
 =?utf-8?B?R1hZWnNjZ0thdEJpY2hBY2JOQUE3ZHR6WWVXcDM4U3llNjZmb0w3K3hCVi9p?=
 =?utf-8?B?TUxkQUt6L2VCVVZsL3hZVzI0dE9KQWk5SGZEelVlRXVXR1FpeWlMYTBOdVpp?=
 =?utf-8?B?UDBrSGp2YW54QnhiSGh3VGEvNUd3MGozRFRpdUlGZ2NsNUpiaHVUdFYzQUFn?=
 =?utf-8?B?M3FLcVFGaXBUSGVObVRXbHlIZHUrUWFNK1EyVzUyK1RWRjhYb00xMzJTbmdZ?=
 =?utf-8?B?amFmbnFBdUg4dDdGVjNBTk5Benk3V0tPd1ZBR29uaE1wbzBFUFY4ZE43VG1p?=
 =?utf-8?B?WXA1K2p6dFArQ0hXSCt1QTA4ZnhKMW44OTZzaG81MDVZR2tQMWFXWnlaQkV5?=
 =?utf-8?B?VE5uN1pYdjdyS2M0aWRnb3NLTVhUUTdJS3A5QXNqbVk5dkZKTjhHTGk3cnd4?=
 =?utf-8?Q?jUf6i1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enMyK1owNzB4Sm85QloxUmYrZWU4alJnRDRXZ1MvYUsrZThrR1BSQ3A5SjNo?=
 =?utf-8?B?WGdaTnBxMDdtMHhZenh6TDVKZHFpZ0JuRGRWME9RQzNqUmdUWjNOSlNGa3pT?=
 =?utf-8?B?NTBLZjZFd3NobXNVUjdERVhFZzJ5c0x5U2xXQjdmbjlPUzFQV090ampSQ21C?=
 =?utf-8?B?WEltK0xBYUtQdkIra20rU3puQ1FFankyYWZ1QjFlclNGZjJxUzUwZjlDQXVN?=
 =?utf-8?B?RU5OMjg0bEVoakJnNklBZHk2aGZ1VmdSUURycVhVVCtuZis4VVU1aDJsVENw?=
 =?utf-8?B?Z3NlazZMbCtQMGhKbWNOQkxHM0p4a2E0dFVuOHk1c09XcXdxdmFJNVhJWlpt?=
 =?utf-8?B?bDdIVTFNNWc2djh4aXZ4M2lxN09TZ0xBTzFQOUp5cCsyK3FJczN4VnAxVlZS?=
 =?utf-8?B?Q3hpbkNOZkxiS3NseHdtYzNLVVdIMzJabTh0YnEwMUdmQ2FFY2VIcENIRFVj?=
 =?utf-8?B?Q0pwMWdXRzJsUUgydUxWc0hxeEJxK29pMzNRNElEekpDMU83cXhPU2FpMUdn?=
 =?utf-8?B?Szh4VTQ3WmJRNllGc1VTWm4vaGYzc3ZzMVdUU1NDeUFWK3UrRXVlTFhMU0Y2?=
 =?utf-8?B?NVhCZUFVNDV2QVE3dXl1VEt5UmMwUU5DQVJjOE92WE5pZ3ZZTkRuYmxVUTZX?=
 =?utf-8?B?QjI5ZDQvYWtpR1JpNnRCK1M4YkJGeUNHbDNEeS9ubTJoZDJ4TXVjb3lnajU3?=
 =?utf-8?B?QVhBUGtXQlpmTStNUG9IbW9CYmxkSURqa0VCT0gvOWQyK0tONlQ5cWg1VGRo?=
 =?utf-8?B?WHVWMHp1Z2t3UGF6Q1JIL0wrQm5WazJUY2pQc1I1S29YNlR2alpEcG13bW14?=
 =?utf-8?B?cXdySzVucGFpeFg2T0U2bTFuQWhpcG16NUlsandVajhDQXFvSmpQRDhHTmtC?=
 =?utf-8?B?R3g3SWtMMS93UWVUcCt3azloM1hoNGxVdXd3eWt0WENQanJFclRMbStqNVhi?=
 =?utf-8?B?NlZIY1JSbUo0T3ZHSU5NaXltbHJVRS92VkNDcVYxV04vZnJrZC9DUDhaQThH?=
 =?utf-8?B?VmVUcVJHcE9MNFBQYWQzbDUvVlJsUEVZMmxaa3JqbU9lUVR6RTc2N3dRdHM5?=
 =?utf-8?B?OUtrZ09aZjk2YVJJaEN5WERpZ1RHaDdNVWJtZHZVaHZlM042Q2xtOWdGdTVr?=
 =?utf-8?B?d0djMmZ6bHdQVWViTjd1Q0kyVHUyeitvSXZtb1RpRTZnVWZjN1lvc3NVejdr?=
 =?utf-8?B?angzSjczUG5vaG8xVnp6dzlrUUh4cGI4QWdzYVdyWjdOS1pkZ2tHTnBFdy80?=
 =?utf-8?B?SjYvNmxLeDVHS1NDS2VaTWUrL0FwYTFzaUQrcGZMd1cyUkw5VW1idVYyQlV6?=
 =?utf-8?B?RW5LbGJZRC8rUm9salFsbElmS0pUVllNZ0w3aVltbk1ZUEplUHdEaW04Nkp0?=
 =?utf-8?B?RTloYloxZ3lWMDlBUWVibjhaSVZHN3RJNkpvM1FNYTZUQ0N4cDlVWjZnakF4?=
 =?utf-8?B?a3pKTUpzYjRuZG1iNEZzMEhYL1NKUzVjOFJwWGM4dnFlM3RGaDBzTDdONGdj?=
 =?utf-8?B?M2JUN3RQMjVURDFGa09WY2tzN01UWC9aZWFoRi85cC84dWpEUFpLa0ZXRzRB?=
 =?utf-8?B?cTJIMld3WXloL0MzaTQ5N2ZUWTR6N0FhOVB2NkYxUWVzaEZDSXpNdXhpWDJT?=
 =?utf-8?B?TnBwQTBzNEZsV0k2OXNFSFR4cUNmVkFPUGlzQWU4TWtWdUpLZUdOcnA4WG9U?=
 =?utf-8?B?bEtCRExiNmF0VHFUMkl3Rkt4Mlo2Y1NOMVpFUFYraTJ3dmtlUmQyUHBCWWNr?=
 =?utf-8?B?T0FlajZzaE42NkFwc1VLbENIeUtIdjh6dSs1dGVNNmsra1dWVklDNEVJRE43?=
 =?utf-8?B?aUJWRWZXT040aXBOemQ5OTdqV05vQkdQaGV2T01YM0EzQkVMYWNFcm5WKzF2?=
 =?utf-8?B?ZXRwdE5qSW1OTGpTQlA1dnlFZDZvMDYwOFBrTEsxSmNDMEoxK2NHUmhGNXhN?=
 =?utf-8?B?dVcrZDhjOTI0U0xZM1Vwb3JSek00NTNoMmF2VnJyTUxIa2lWZGNPMmdIcVhl?=
 =?utf-8?B?Y0lhdUx5aGZDSzBXRGRKc1ByVHcvNmJZMEhmS2wrd254RUhjVG1QN1RpRk5l?=
 =?utf-8?B?Ny9DdVEwZmNud2NhV0RqUHI2VW9LQ0hzcGxBbFZsNEE3ZnVEZFZGYnE3Sm9t?=
 =?utf-8?Q?Ja7s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f47f9e3-45f6-4d48-68d7-08de0c02a3df
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 15:51:01.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmKYqKmvs0asbyoSm/Ye5PcJJ+1iJf/liAR0xysUMQIyO4ND7/gXkY7bd+p6QW7k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDE1LCAyMDI1
IDEwOjQzIEFNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4g
Q2M6IEFhcm9uIFJhaW5ib2x0IDxhcnJheWJvbHQzQGdtYWlsLmNvbT47IFRob21hcyBHbGVpeG5l
cg0KPiA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
OyBQZXRlciBaaWpsc3RyYQ0KPiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQYXdhbiBHdXB0YSA8
cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsNCj4gSW5nbyBNb2xuYXIgPG1pbmdv
QHJlZGhhdC5jb20+OyBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsN
Cj4geDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT47IEFsZXhh
bmRlciBHcmFmDQo+IDxncmFmQGFtYXpvbi5jb20+OyBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9z
dHJvdnNreUBvcmFjbGUuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDAvNTZdIER5bmFtaWMgbWl0aWdhdGlvbnMNCj4NCj4g
Q2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2Uu
IFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5n
IGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIE9jdCAxNSwgMjAyNSBhdCAw
MTo1MzozMVBNICswMDAwLCBLYXBsYW4sIERhdmlkIHdyb3RlOg0KPiA+ID4gSWYgYHJvb3RgIGlz
IGNhcGFibGUgb2Ygc2V0dGluZyBgbWl0aWdhdGlvbnM9b2ZmYCB2aWEgdGhpcyBpbnRlcmZhY2Us
DQo+ID4gPiBkb2Vzbid0IHRoYXQgc29tZXdoYXQgZGVmZWF0IHRoZSBwdXJwb3NlIG9mIGRlbnlp
bmcgYC9wcm9jL2tjb3JlYA0KPiA+ID4gYWNjZXNzIGluIGxvY2tkb3duIGNvbmZpZGVudGlhbGl0
eSBtb2RlPyBBc3N1bWluZyBvbmUgaXMgcnVubmluZyBvbiBhDQo+ID4gPiBDUFUgd2l0aCBzb21l
IGZvcm0gb2Ygc2lkZS1jaGFubmVsIG1lbW9yeSByZWFkIHZ1bG5lcmFiaWxpdHkgKHdoaWNoIHRo
ZXkNCj4gPiA+IHZlcnkgbGlrZWx5IGFyZSksIHRoZXkgY2FuIHR1cm4gb2ZmIGFsbCBtaXRpZ2F0
aW9ucywgdGhlbiByZWFkIGtlcm5lbA0KPiA+ID4gbWVtb3J5IHZpYSBvbmUgb2YgdGhvc2UgZXhw
bG9pdHMuDQo+ID4gPg0KPiA+ID4gVGhlcmUgc2hvdWxkIGJlIGEgb25lLXdheSBzd2l0Y2ggdG8g
YWxsb3cgZGVueWluZyBhbGwgZnVydGhlciB3cml0ZXMgdG8NCj4gPiA+IHRoaXMgaW50ZXJmYWNl
LCBzbyB0aGF0IG9uY2UgdGhlIHN5c3RlbSdzIG1pdGlnYXRpb25zIGFyZSBzZXQgcHJvcGVybHks
DQo+ID4gPiBhbnkgZnVydGhlciBhdHRlbXB0cyB0byBjaGFuZ2UgdGhlbSB1bnRpbCB0aGUgbmV4
dCByZWJvb3QgY2FuIGJlDQo+ID4gPiBwcmV2ZW50ZWQuDQo+ID4gPg0KPiA+DQo+ID4gVGhhdCdz
IGEgZ29vZCBpZGVhLCB0aGVyZSBjb3VsZCBiZSBhIHNlcGFyYXRlIG1pdGlnYXRpb25fbG9jayBm
aWxlDQo+ID4gcGVyaGFwcyB0aGF0IG9uY2Ugd3JpdHRlbiB0byAxIGRlbmllcyBhbnkgZnVydGhl
ciBjaGFuZ2VzLg0KPg0KPiBXb3VsZG4ndCB0aGUgZW5hYmxlbWVudCBvZiBsb2NrZG93biBtb2Rl
IGVmZmVjdGl2ZWx5IGZ1bmN0aW9uIGFzIHRoYXQNCj4gb25lIHdheSBzd2l0Y2g/DQo+DQoNCkkn
bSBub3QgdG9vIGZhbWlsaWFyIHdpdGggbG9ja2Rvd24gbW9kZSwgYnV0IHRoYXQgZ2V0cyBlbmFi
bGVkICh3aXRoIHJpZ2h0IGNtZGxpbmUgb3B0aW9ucykgZHVyaW5nIGJvb3QgcmlnaHQ/ICBJIGd1
ZXNzIHRoZSBxdWVzdGlvbiBpcyB3b3VsZCB3ZSB3YW50IHRvIGFsbG93IGFueSB3aW5kb3cgZm9y
IHVzZXJzcGFjZSB0byByZWNvbmZpZ3VyZSB0aGluZ3MgYW5kIHRoZW4gbG9jayB0aGluZ3MgZG93
biwgb3Igc2F5IHRoYXQgaWYgeW91IGVuYWJsZSBsb2NrZG93biB0aGVuIHRoaXMgaW50ZXJmYWNl
IGlzIGNvbXBsZXRlbHkgZGlzYWJsZWQgYW5kIHlvdSBuZWVkIHRvIHNwZWNpZnkgeW91ciBtaXRp
Z2F0aW9uIG9wdGlvbnMgb24gdGhlIGNtZGxpbmUgb25seS4NCg0KLS1EYXZpZCBLYXBsYW4NCg==

