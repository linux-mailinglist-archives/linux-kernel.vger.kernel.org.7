Return-Path: <linux-kernel+bounces-856299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D81BE3C87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8FA5875C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F5333A000;
	Thu, 16 Oct 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wDjj7NgE"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DE1A0728
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622367; cv=fail; b=XprtYqeh2Bdf5ZzXo6lG8WXCZRpL1DZodi9azKpLwfunYZ1/TIxlqp5WDK8kHV3FRu9U0cXfWt/5OnTHMw9jFCAa49dCQfBCAPZH3n8gpJtkWNVgiqZhm3bkyXss8KSMKUQQeqZr7kkP3illNav4VcK44ipNLHHo00Au+nSsBtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622367; c=relaxed/simple;
	bh=ooh0OPs1N/hNx0i0mNoHtNSiqUCQtjPldh6cD2OzQLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBe59JdmWM39qXaefxovnCGii7svjaokIr7azMDiVBbEfHzFqQwfultisT7OvXIV6YNc89b+B/545Wf+rQI60aJ2yLsYn7vCuZo5CtkVjKS1aLRslh6neakEnq6F6SgB1ScJHjaMjweFBr1NEBVsRUODtsjZyjepXm7FpCsGT5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wDjj7NgE; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqT+bJkqojJj9BQkcEtnMH4RShgRc9TQHKowG/c4Kg3ZvR57sgbrL3tCebPS6m5vjTnrOxiKXZxVn/p5JW58c1b9+JJjbXZG+t2jdqr/wGUt6THBybhR6CbpD7YueU87IKWDratsRnSw/4gQOnjirb1tXb26pFCksONjhhybSgsDye8QbrrhKrI6zS+ETaOmbe+PggG5z2ota2Nrk8iJ4FSeVWhi4GcZy9XlLa5C1RtqVUtciBAXQ9WwQ8B9G8R1jePHN3geuJPwgySR/wWGERRvXWe9gzQzfcYb7YS8DyLGUPawDGOl/ey1eGgbNkfsOQ/pW6LnH6iMSlE1gHzSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooh0OPs1N/hNx0i0mNoHtNSiqUCQtjPldh6cD2OzQLY=;
 b=M8zeXDBBrTsxCSu/Qgbin7dp9+Yf0FxGUnBU6U3SB+Guq9chCke2zMXoegGw9RZt/KjAIwE8gZwNF4/T5Nqa1BVRlGQ3kb5noQhZgJtM3E74g8A0dlo8/x/Rd0eNkKYXowdKvWxWjcJWz5MpxCY6d+FEf4Fgxhg1HhjSdrU+BQrSNZ9xbOqgSq5BVeS97Kmg15fs2YP9JBLYCDji3XbKB7L5tYz6QNN2kyuAeLPfSONsAZCpuUPbtKRMrQgFaZCYEJ3VdjBrSXGdldjIbQGgtBdH5RWFhMdvCuE8m4UPxzbCyIOB5qjw6Xa7o/1zm98uHz+kAu9aAj2y+kSKHPU4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooh0OPs1N/hNx0i0mNoHtNSiqUCQtjPldh6cD2OzQLY=;
 b=wDjj7NgEL8TkuRf4frwRqUvTFNEF7zplzl/poFtPUqQoGp2ad3KxCgJ3eOMmg7yEqECiCAvqHSZHiY2dE6ytkHjyr+efE0IIOjMghSSHo0lqV7bQzB9CnL21ORDik1Z85m7KSgC90gOpqPX77RXkHNrGctsQi+Sul9hn49lsLb4=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 13:46:00 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 13:46:00 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Brendan Jackman <jackmanb@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 20/56] x86/bugs: Move bugs.c logic out of .init
 section
Thread-Topic: [RFC PATCH 20/56] x86/bugs: Move bugs.c logic out of .init
 section
Thread-Index: AQHcPpjUZP9WFoHZTUuhVfLBNVoye7TEyF3g
Date: Thu, 16 Oct 2025 13:46:00 +0000
Message-ID:
 <DS0PR12MB927341C26CE262CDDDB67EAA94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-21-david.kaplan@amd.com>
 <DDJQYGOJ4VTT.20JIC6NWZXUYW@google.com>
In-Reply-To: <DDJQYGOJ4VTT.20JIC6NWZXUYW@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T13:42:56.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: d1181410-e25f-4246-152a-08de0cba5783
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFNCQlVYL0hpaXFuaGFsdk1IQi8zTmdJQ01UYUl6Z0ZiclVtaFNQT2FDVWZ3?=
 =?utf-8?B?OUk0UFV2U21oeUFjWEVnNGdMWTVOWkNPeGhjekMvQVU3d0p0ZTY0b2k2cUdW?=
 =?utf-8?B?UU1tRThJYUNKY1g0cUVrRXlHelpBKzJFcVdYcW95Sll3NWJGQjZ1V1VTR1Ry?=
 =?utf-8?B?Y09UNHhjZ1BvMDNpa1ptUkZoZkpXa0FSN0h5Z1FzRWNoT0Q5NlpjQjlKbzg3?=
 =?utf-8?B?SDR1RmhBK1ZwM0pQQWlZUElsZGN0WEcyTzV3U0xiNUZlUFVFTndVUzJCdTRT?=
 =?utf-8?B?SWZkcnU2eWVXODA5c3Zqd0c2TjhvQjdBenBDTUR6cU5OaVpCenh0VHZwRmZl?=
 =?utf-8?B?dHVKdTVvSGtXZkE0ditmKzc4ODNxYjFJNjgzZzd4azZjZWlQaU9DaUI2T2tO?=
 =?utf-8?B?SFR5UndDZ0lWSGphOWhESHNjUWhQalMxMXhqUmZrYjk5QWZLdEdVb0MvUVpj?=
 =?utf-8?B?SXpic0lFRjJiV1BsblFzZ3ZsaUV5NW9EOWNkWmVWd3ZuUXJhWm5TMlBsTUZi?=
 =?utf-8?B?bU0vNml1aXFqNmlKRlg3dkZIckNpUlgwdWxzZk5RcWNrOFUrWXdub282dEtV?=
 =?utf-8?B?M2t5MFdORWw0MTB3MS9zTjlWSFBueDNpZTJvUExITXM3b2l2MTNKMzJ2ZXJV?=
 =?utf-8?B?NVJHQmU3U1NpWWdtU09ubStEVmdNYndPZ2xrRHVOc1lUSG04WWJ1RHV6V3l3?=
 =?utf-8?B?QitqVlZRVTMzdHlNczNQQlhkdzh3WXQwMTFUVVZaTHNpRTVLdHk3YjJkSGpy?=
 =?utf-8?B?VHBqdmZWZkw3eks5VERMSnovNVZVTkxmRGEyVktYL1VQaW53RE5ZSnFrZ0xl?=
 =?utf-8?B?NkRWNHRHcktVMDlQS29YQUE2NWNiMi9zTEtnWXpVeFpHaHZaR3JDVzlhOGZz?=
 =?utf-8?B?UnlSSStoMUZUUUUxUFBha01ZZG1PS3lvVjh5L2xRN0ZlS21uaWduTm5UaXR0?=
 =?utf-8?B?UmYwTnJ0dWJnNXNuSkRiRWFzM2VmT0g1djhnNW9jSDZoQVEreXBUT2x3R2cy?=
 =?utf-8?B?emZQUkhSN1VPTjk3UXNxODB5ekwzZnNnNkRWMVFhVko3enlKN1VCNXVNTFo2?=
 =?utf-8?B?aEcxa0FPWDNXTnVGVUxFQ1ZqSzUrRTI5Q0tnNUpWcVhUYTZjUmRtczRCL1pm?=
 =?utf-8?B?V2d6aTU4SDF1b2RUM05hRmphY0ljWmV6M0JuQ1kvcm9PNENOclVYWE9EaGQv?=
 =?utf-8?B?bHFkTUdjR1M3ME9IbDFqVUFpWnZycFlmV0IyKy9EUXRwTmhQeDV0NXJGOHg4?=
 =?utf-8?B?QjVkbFg1T0h4NU9hS2tWSlhqRW1RaWIwSTlpOFRZcW5aTnNOMWpDc21CT2xD?=
 =?utf-8?B?a0lNSlU2ZFJXU1JNeTJGUzNudjFSQUFyMEZoa3ZKWG9HUjRueHVZSHhLYkp3?=
 =?utf-8?B?dWhtalBvSldCaU5KeUpqV1JZWm51VEtla2pBeFUyREwrTzdGc0ZZc3U0eGww?=
 =?utf-8?B?TTFhcVdyb29uTGNGK0RoYjg0OE5DNk9SUm5rQTlZSnBrSUZoZ3lZNi9tVFZM?=
 =?utf-8?B?UEFoMWtOOU82eVUwWlhXc3BYa2V4QnlWOTFkUkpPTGRrUm1mb0lzRFR0WmRt?=
 =?utf-8?B?UXh4ak9qWi93SXhweTQyOUpjNThMUityQ25mV1NRWWJjTFdWcVBvcGt1VUl1?=
 =?utf-8?B?cjNLUncvVGxYdjVNOW1IcHZTeEpuSnB3eTRwSVV2T0djL29mWmd1d1JPQ1lS?=
 =?utf-8?B?K08ranRsZVFSamhicnhVVXBTNTRrZzFOTDRTR2VQTlExUU9Pc3Q4ei9PdGxT?=
 =?utf-8?B?NlRPSHgzWGlUMUh6ZDZydURVbGVOanF6em5KN0tQcDhiRy9xSXRZbTFDRE51?=
 =?utf-8?B?YTZXQTBOMVY4YmdxUnRmVDRnUXJsbVZXVlZDa0ozc0FteGZubTkrdlRrd2xi?=
 =?utf-8?B?OXhzRzdpaW9UR0lLMW5xaFJ1bGVyd3pPbkRmSk85MUdLakxKSnNqd2RZRnVF?=
 =?utf-8?B?OGhLL1FRMnp6dDAyME9Hc3hyRmIzdEpFb1dhS1dUOVFXMlQ5eEFId1N1eU1a?=
 =?utf-8?B?NVdZVjBIYVhoTGN2MWZDL0drY01helNzVWJCOXpjenVjK0t4RjVZc3laaE85?=
 =?utf-8?B?TkRLc01qOU9nMmJsOEpBVGtCSWZaVW9FSEVkQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTNxbW0vcURic3dVaTBOUEJtay8yVm94UnpqUWREeUs3ekFLVXdKMUlSNGlH?=
 =?utf-8?B?SFBweW9qdGN2eExCNEpyYUU1SVNUbTVtemFwSDBwV0MydzJzU3ZOUUxOdkxy?=
 =?utf-8?B?aE1YY0g3L1BsVnN5dUE2VUp1V0RzTmZnS1dCR21UdVVLdndxUVhHTDA3MEw4?=
 =?utf-8?B?TnlNeCtHS0kyRTI2d1NHRlR2SkJRSmZqM0p4ODR6aTRUSHFNa24vNTFhbzV1?=
 =?utf-8?B?VTdjSDA3WHkvbjhVNjhJY29WYnBmalEzcGtad1k5MGVyZGtrVnFmanpoZ3p1?=
 =?utf-8?B?YmJUS2Vyc01GNWdvd2pJRVp3NVhUNC9Db29PUWNwb1hKSmNIL2t4dzNzOHdk?=
 =?utf-8?B?di9vV2M4WFdTclY0NlhSVmh0WllhRTFVbjduRmErWDJQanVsenFyaEdTWFM5?=
 =?utf-8?B?M3BrdUJ0alJTaXl0amtJT01jaDE4enRmYURHMlIwRkJzWE55Y2NVL0Y3dmE3?=
 =?utf-8?B?akNFcUN4M2xKUEhaNnNNTkFrSzZDU09iakpab2RvTTM3YXJNYVRjSHBqaGZj?=
 =?utf-8?B?MjVNQldLVE53M256TWxTb3VZSDJhL0dnMTFMRmlqTnNwMjUvb0JKek1lUjd5?=
 =?utf-8?B?QkVCVjYyMVMrK09pQlloUkErZ1hlT3JwK01kYXd1NGtrNktiNFloUlY2M0Jx?=
 =?utf-8?B?UzBsL1R0eTYvYWZnTVAwY0d2ZzlBWVo1aytUeGZZN0g2dm1hVkowRHdKc0hn?=
 =?utf-8?B?VDh0VVd1WGZ0R2FXU21WZDNIbTRkYkthbEp0UUZRcGRXMGpIc3p6Rk1yWXVq?=
 =?utf-8?B?Qk5WTDlqd3VObWtDMU9XZVc4MUpBa01aTVlIb0ZycURGQ2t5WnliK3QxTlpO?=
 =?utf-8?B?MmI0RTB5NUFSMXU2aGFvOFZKTy9CZkQ2YTZXTVQ0N0RRTklJSFdIalYzOU1m?=
 =?utf-8?B?WmYvbjJ6TW5JelNVN05UcVBiQ2UxUlk5N0pPZ0pMa2ZWcExHRFpIVHJRWGtX?=
 =?utf-8?B?Rmh1aVJIeFRtRlZlVHF1U0V2SGlRcG9aR1F2Mk5Ra0g0bFpab1RaZnd4UGF2?=
 =?utf-8?B?ZXc4MXN6b3hsNTRUL1ZMT3l6eWV1OXdQcFBqQkNYWUh0b3BvMkg2dXAzb2s0?=
 =?utf-8?B?bjRkREM0R01ZMVF5TFhKRVo2ZzRiMWxTcWFxaW1TOUh1aVZzOUxaa1k3dUI3?=
 =?utf-8?B?TGx5aDUwc0krSkYzMlhRaXRoWTZQNWJ4V3F6d21pQlNpZXhpZ1JjMm03Q0JX?=
 =?utf-8?B?Y0t0d2N4UU1raEVwaU9maDg1ZTNzRzhOM09Qc3Y4RGlYNHNsd3pDVHNLblhN?=
 =?utf-8?B?elJ4a1pHTkNqangxSnJJbjQvZ1BPVmZZc29LMGhNODUvWGRRMmRoMXZ3aERE?=
 =?utf-8?B?czh4U1pwakJUallhR05xWWJTYlpqT09pZHFKeEdRU3M4WWJqM3BtRklLOW5r?=
 =?utf-8?B?akxZNk0rSmdXN3Q1VzBIendaVUw2WHdFTTJsTk5ONkRlOUNOWVVGdndGSHZJ?=
 =?utf-8?B?Q2pNVzVpMTIwRW05VUJsU2xvUVdjS084OEZ4Vnprbi9NNTNxMW85SzN2Nk1W?=
 =?utf-8?B?QmhxUWM5RCtYcDBKQldHUitMRFJnc25aQTQ1MFppVE03K2ptbGtHeXJaZGQ5?=
 =?utf-8?B?ejBvcnRmeXN3T1NYbTJ2S0pXNVhGZXd4Rm02TTVOZE1WNVpqT0c1Ty9CMDNp?=
 =?utf-8?B?Nm54dDJmeXB2UUkvRkxhanNiTW93aFg1NlY0bHNKRHRhUGFRdXdQQjRESTZr?=
 =?utf-8?B?dnV5MDR5NUxoemwyK3UxNGs2cjJLN3E3NTBabkZYbDdtcDVPWEdiWFJ3TUti?=
 =?utf-8?B?OHo3QVVUZWNqYkUyclN6TEF3WTZPT2VtSXZzUWI4bE5qYW1Ha3duOVZRZ1lw?=
 =?utf-8?B?MXBnOUlpaE9mQXRzeUJtaTI5NG8wWCtzcFFVK1pmQ0dMSUcwWFNvSDNxZDY5?=
 =?utf-8?B?N1VHSkdNSVRWblV6NTBUQUlra2J5U0FLN1NDTmVEeC9YcUNNMkZuS3h5anZM?=
 =?utf-8?B?dzJhd3dSRThwU1VVdG1QNGd4Q0lTS2hsWTBsK2JWUlp3YlVMTUMwdUJXNDRB?=
 =?utf-8?B?b0JRSThGb2c5eE9EVGYxOXBDeFYwRWtLZ3AycUtWVHNkSkxKcDc4UjdhMWZO?=
 =?utf-8?B?NGRMUXkvb1BJNEJXMlBCL3ZyRnQ5djRRd0dkOWZvNUxabmhsMXV0YjQ3aENL?=
 =?utf-8?Q?eG5Y=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1181410-e25f-4246-152a-08de0cba5783
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 13:46:00.4291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHrcdp22YBKGD7Ya34TkJraZEEqiJ5/BVwY8cIzZlJFNiJGelDNvE8pCZ1gMq/c/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmVuZGFuIEphY2ttYW4g
PGphY2ttYW5iQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE2LCAyMDI1
IDc6MzIgQU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgVGhv
bWFzIEdsZWl4bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT47IFBldGVyIFppamxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEpv
c2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3YW4gR3VwdGENCj4gPHBhd2Fu
Lmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQu
Y29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47IHg4NkBr
ZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6eXRvci5jb20+DQo+IENjOiBBbGV4
YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPjsgQm9yaXMgT3N0cm92c2t5DQo+IDxib3Jpcy5v
c3Ryb3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtSRkMgUEFUQ0ggMjAvNTZdIHg4Ni9idWdzOiBNb3ZlIGJ1Z3MuYyBsb2dpYyBv
dXQgb2YgLmluaXQgc2VjdGlvbg0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRl
ZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3Bl
bmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+
IE9uIE1vbiBPY3QgMTMsIDIwMjUgYXQgMjozNCBQTSBVVEMsIERhdmlkIEthcGxhbiB3cm90ZToN
Cj4gPiBJZiBkeW5hbWljIG1pdGlnYXRpb25zIGFyZSBzdXBwb3J0ZWQsIGFsbCB0aGUgbWl0aWdh
dGlvbiBzZWxlY3Rpb24NCj4gPiBmdW5jdGlvbnMgYW5kIG1pdGlnYXRpb24gY2hvaWNlcyBtYXkg
Y2hhbmdlIGF0IHJ1bnRpbWUuICBUaGVyZWZvcmUsIG5vbmUgb2YNCj4gPiB0aGUgZnVuY3Rpb25z
IG1heSBleGlzdCBpbiAuaW5pdCBhbmQgdGhlIGRhdGEgbXVzdCBub3QgYmUgcmVhZC1vbmx5Lg0K
Pg0KPiBJIHN1cHBvc2Ugd2Ugc2hvdWxkIGhhdmUgc29tZXRoaW5nIGFraW4gdG8NCj4gX19tZW1p
bml0L19faW5pdF9vcl9tb2R1bGUvX19uZXRfaW5pdCBoZXJlIChsaWtlIF9faW5pdCwgYnV0IGNv
bmRpdGlvbmFsDQo+IG9uIEtjb25maWcpLCBzbyB0aGF0IHVzZXJzIHdpdGggQ09ORklHX0RZTkFN
SUNfTUlUSUdBVElPTlM9biBjYW4gc3RpbGwNCj4gZ2V0IHRoZSBSQU0gYmFjaz8NCg0KWWVhaCwg
dGhhdCdzIGFuIG9wdGlvbiAobWF5YmUgbGlrZSBfX2J1Z3NfaW5pdCkuICBJbml0aWFsIGZlZWRi
YWNrIEkgZ290IHdhcyBqdXN0IHRvIHJlbW92ZSB0aGVtIGZyb20gLmluaXQgc2luY2UgdGhleSdy
ZSBub3cgc29tZXRpbWVzIHVzZWQgbGF0ZXIsIGJ1dCB3ZSBjb3VsZCBjcmVhdGUgYSBzZXBhcmF0
ZSBhdHRyaWJ1dGUgdGFnLiAgU2ltaWxhciBmb3IgdGhlIF9fcm9fYWZ0ZXJfaW5pdCBvbmVzLg0K
DQpUaGFua3MNCi0tRGF2aWQgS2FwbGFuDQo=

