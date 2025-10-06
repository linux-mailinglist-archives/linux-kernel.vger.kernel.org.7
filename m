Return-Path: <linux-kernel+bounces-843035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F5BBE41F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F11188AE45
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9222D3EF1;
	Mon,  6 Oct 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lgZgxSNL"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4429B217
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759151; cv=fail; b=UNSHFWpEVP1Ngp+jLxDZdcRkJhMSmwRNovq4cG1X8aEgpIx6S48at5UPqowTe1qlnDB1pKY4KRsq6NP1kg6SZhTaNvQGDa4eNbBCz7iYy+//cJwsxaqpfN76e/DslfiVMI4Hk/FB05oKgDPPvtCXhMpMGXC79yZ4FnfvPfOR36U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759151; c=relaxed/simple;
	bh=GSGRuJb+7cX3AX3BJxHLvULHND6xbz6fNheVDy0aX4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4ntTBwRtjeF9R88LExYYPsk+xIDe8n1CX+xF3IOL0OsSb33dSCn0pA6uSh640AaKop/ReN5Ta+mFNhK9GYSRMoi3pJkdesmJJpRtudxK/xW+JroNt3o0MEaMZtbLR8XmGekZuCGntkZVAbcGdqn04h+4jiteCUpV7N7V6GmLhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lgZgxSNL; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjmR5JbZL+qI6MkqeaQ+pqIexf4MWGKN/m1k6M1gEpLUpkLSEGuQhRuF8ruLlM6zhXacX580QsjHtJf1+FDUHZzqcmcEeIDLGlGCEPwJ/O4AqxnTvWMuY5t3xYVgbsHR3omgl4+nMoGcCyRXw+BpTGZA5Zhmxn7veQ5y4x7VvBzGIdE0vh1SYxbpUvB3z7WZ6tPVr17vmnxaipt6nN1Z3nc6HYT8S/CXfyVRR3E465Rr800WLLEMb2jV1gllRw+JoKl87nCCLAfsIzbyZS+gQ+0tojKFZMPaSEf03BK3VR9fz+/UHZr1lhEKI10GyXWku6rxESVtKI5+4Lsp3qGe1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSGRuJb+7cX3AX3BJxHLvULHND6xbz6fNheVDy0aX4k=;
 b=WsxUfnxnPdgarxmUem7V9yTWUkCDmPP6CX+F7ok/1WR3Y1+C8V8afMKcHBA97UcK5gHZwwrR1Vvl+7XKUmIcIlFkdgnq927mRkDhESeC5jOATDlWY3Ty2JLqU5wciqDrdEQI2IyIMg+FfXgIPfNgoYDcKMjSNfRNINM2QlEW1DYTxNKO0l1HxofKLWHp2vLzmfRwXfCeYMUn4CPo0hyv/kZDIwapfauvfxi7bJd8lXarmq2jsa2g1yIynvusEq0wSf8Lv1atN7f6Q9ki77xH6DzQd1NT9kJ1+mfTRfE4HYuvktQJMhpNzqY/6Qm4ethpW2GqcslFjTQJ7N0upfJU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSGRuJb+7cX3AX3BJxHLvULHND6xbz6fNheVDy0aX4k=;
 b=lgZgxSNLfGBNFlfxIdwEf/QBBrJkDsOkqoxaKP0xfz87b18uhMslzZzvAw/tH49Ete2BgC5e5sA0Y2Qc47X6cflzbGZoQCGVJXOL2iXsjVadcUtfSZ5FPsGQfT7IoorDtIgk5c4oyv0ui7WL6ooDyWLv6XlS6ATnSw/vubnuz2g=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.21; Mon, 6 Oct
 2025 13:58:58 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 13:58:55 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Thread-Topic: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Thread-Index: AQHcNsLPYAWj0urMzky4n4OHi8ST+rS1I8Ew
Date: Mon, 6 Oct 2025 13:58:55 +0000
Message-ID:
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
In-Reply-To: <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-06T13:53:48.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS0PR12MB7825:EE_
x-ms-office365-filtering-correlation-id: a9051285-6c14-4281-4383-08de04e07d1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODYyT0loMTNzT0FXdDQxL0VCYkFQQ01zYllDR3NncHNjV1hyaXdub2ZJUkND?=
 =?utf-8?B?THlLVzI4UnRtWGlaNnpMMTJnOFdrK3JQQzN0blorbTV1WmwzdFhnMWg3aWo2?=
 =?utf-8?B?MlB6azRZZSsvNkpGYUU1bCtTUURyc3B4Y1pxNTRFMlRQMlBTT1AxSHRya2JO?=
 =?utf-8?B?ckZEd2VLNGthWmVUNUhkcElaOUdxRzhDYmt5bldrQTVUTFRwNExXMlNSN1g2?=
 =?utf-8?B?bW5LSU5pbEFNNkxZdC91R1RMQ25HZzZBc29rQWs2NlJIL1U1b3d2eUhCbzNZ?=
 =?utf-8?B?QWY5VXppUGpjU3VvUDJUb0hxSzlRUUJYbFNsTkVlQVdHeXA0dzFwZG9MSEo4?=
 =?utf-8?B?NmJNZDBYSWRKRVJDU0J1azFkVWxKYlNmeTNLOHdockUyUTRkVUJrbTg0VEtN?=
 =?utf-8?B?cXlVd0p1ZXJjaHU3QnA5Ykpud2FsUUoxTjFLdmd2cGE5TFJNYzFKZkFjUEda?=
 =?utf-8?B?bEZqRkZweVpqYkczUWg3Szl0ajMzQ3RjRCtiOC9zdHB2b2VUTDV3NDM5bndT?=
 =?utf-8?B?b3BxRWk1WS9XQm1PdU5DWm1xMzhIbm1rdmE3L0RsOGpoZ3hxdkQ2VUE0eEpY?=
 =?utf-8?B?ZGIvV0NQUVNkZWt3TkM4K3dHb3hWZElBSG5VQkd6Z1cxenRRZ2pCcUd6U29L?=
 =?utf-8?B?OUh4T3dud2ZjdUlrdEdDYmRaOHErbzdMd0dCQzM5ZzlOT2xManVzOU04amZv?=
 =?utf-8?B?V1liNFgyWk5jQUlUK1UwalZLamU5VTNoei9iMmVsUXNUU1NsbzJtSTlDRXVh?=
 =?utf-8?B?VFdiaHY0WUZyMHEyUzNncTJydEFWS2dLN0x4UC90NWlxenlLYnlQTVM5MVo0?=
 =?utf-8?B?dW9hV1hWWUh3SThEZlo4c2U3SDFrd3pXdUYyWlAvcFZZYTJySk8xazlkU1Qv?=
 =?utf-8?B?R1htbHVUMEZBai9qYk8xMjc0eFIvYjZqYmxnSEZoV0hBdmxPQVp2aEFFemVk?=
 =?utf-8?B?dGtWMXhjNGpTUk9uU1BmWWY3bEQ0cDZYcVFxcENOMFFGVU9QaXJzdkxoS00x?=
 =?utf-8?B?SXZTSG9KUndXK1pPWU8rdDRNaDJpYzJlZlB5emNQeFJsREF5eTB2OFljQmJM?=
 =?utf-8?B?OHlSeGFWVDQ3bXJVRzhLSzFLeHJaSmdlSDlRcjR0dmc5aUNsSGJuYm0zZmlD?=
 =?utf-8?B?QWNodUdQRVNmdHliUXZaUnNGRlByejlnazBIT1pHcVBmL3ExajZBeHhxY0o3?=
 =?utf-8?B?amxzbk1pdTZHeGQ4K0RWMW8ya2l5Q0Zic09NdlJ6NGo5Ynd2M2tnU1Y5OWFC?=
 =?utf-8?B?RmdhT1p4NzFWamtibkE4NFNBZWJ0OUlQUlBuRTBsaWtkV0U0MDFoV1UvQkJt?=
 =?utf-8?B?ZDl3Sk9GaDBTN2VENlJ5ckdmcEtGL2QvUzZweGdENlkvbk5TSUxJZXNFT09i?=
 =?utf-8?B?anhXU1g4TFUvbXFyaE1VaFQ2dUZZazVBcDJQTmxINUJFeSt1WjR5UlFLdG0y?=
 =?utf-8?B?ZTdXZE5Qa2UvclVPTlJVakI0Zlh2SlZhb0czVkVqS1FkT2ZiVjUyOVh6WCtJ?=
 =?utf-8?B?Sk9OWU1yRVhhSFdRSzJDQUNGR3o2RWgyVDByeEgzVmpET0owS2pJN29kRUhS?=
 =?utf-8?B?UVJVZGRpYVpIcitlZGNxN2M4M3BZTndPR2kyVWtMeU03dEIyaEdWYXRXajZB?=
 =?utf-8?B?cjNVVUdNLzFWQ0c4alVwYU8xV2NWWUVKaDdENVRBYkpTcUI2dkNIOUtOM2VE?=
 =?utf-8?B?NTRkYTQrdUNqdzliTE0wL0dyaUt0MGY1N0EyNE1MYkJFQm56Wi91TkV1eThh?=
 =?utf-8?B?QTQ0WVh5RkpSU1IvWkQ5UjlxLzIwdXNQQ21rMGhpb1VYaUVRb3BmdXVycnFE?=
 =?utf-8?B?SDFUVlAyUnU5dTE5c2hjbjdKMUdVdUZHMDRyUVhYZXRZWTE1UENhVnBOZ2Rn?=
 =?utf-8?B?VEJ2b0tVMFVXYitsTllHTEtKb2lwR2RJM2N3VUR6YkVZaGkxZ2hhYXNaOTJ0?=
 =?utf-8?B?SG1lMjVrV1YveC96NXV3RkJ2eUhJWVM5YjZIeWpTSjFsYlhxTXpQbTRPR084?=
 =?utf-8?B?UmcwRUN4SGpRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cC9pZE5qeGxjTWRLN2ZBbnd0MFZuY0tUQmVvaWFkTHl2L2puampwZmQ4a1d1?=
 =?utf-8?B?TzRmdXBQb2s1enNDZ1pkbDFPYnpWY05oL25LMHdGRWkxczRnT2NpaklqNkl3?=
 =?utf-8?B?Y2pSMEt2VVRIbDg2aG81SHJaTk4wL1p2YS8yaWtVMUU4Q2FoVG9Ma2VjL0Ja?=
 =?utf-8?B?cmFxWVZrcVpYVEx2SEttTWVXTHQ3Nm1MOHNsaDZ5ZXpqSlNyN0hXMkh0bjhQ?=
 =?utf-8?B?RFkzMk1EUFU5OWlKRnBpUUJnVHloYlRPV25mTEhYdTg4bU14YUR5T0FkcUVU?=
 =?utf-8?B?aDVmdTZ5NGN6WnlzaUowajY5aDhpNlhmR3NCVElPWHpZNEdQTXdGT00vQjJE?=
 =?utf-8?B?RGlQL241bFdnMEhKL2FuNUlQcFIyTWJ1NTlwMG1nMVFzb1k1alhZV1B4cXNu?=
 =?utf-8?B?aGhoNFRzMkt3TzFweDBsTkU1bUtLNkhudmw1T2daNFhmSlQ4cWdXazhhc01Q?=
 =?utf-8?B?bXM3cWdjUWtaN1pYWWJiMm1kNG8renlqMndCZ3pDR2RlRWJiUStiREU0Z2tR?=
 =?utf-8?B?cG9iMnpGNklOeFN0NFliZ1JwWXlsN3VDQW91bVRqTFNWbU9lUm1iZlQ4M3pY?=
 =?utf-8?B?K3RPamIwQkNsYSs5MXptZUZISU1CM0l2Nkc5NGx1bkJQcEEyQVpNM1NnRnZU?=
 =?utf-8?B?bk5xVnNGYWdKUWpybUEzRHAwaHJBeThrQjZidzBPYmVrVU5PVWN3WFBhenYz?=
 =?utf-8?B?cjVZOHNXQWU4RkFIaVp1bDE2WXFQMzBKNCtqcllOeW1UTzM1NjlBbXd2UVJr?=
 =?utf-8?B?cUFmbVYyWXFBVEtvcm9SeUtXcGh2aEZja1NVa1FHdUhmSGRIYXdpU2VEVi9O?=
 =?utf-8?B?UVpQcjd3bW9Oc3V0NHFIU2dVdUd5ZXlLR0hSN1VHQkx3cVBtY3labVd5TGpP?=
 =?utf-8?B?VndqTEJydzZQUUlON051cHBqaSswSWt3d0tUVkl6MzBTRzExRm1jR1lxN2lr?=
 =?utf-8?B?WE9xcDR3VEdGZ01qNTV3TGE4c0VyM0c4NytHUE5tTmliQVlFM3RaWE1kVmdR?=
 =?utf-8?B?cXJEeWY5Um0wdzkxWE5zUFpXN1phL2hGL2NJNXNsZjNYblZpWnppYXB5aGRG?=
 =?utf-8?B?eW0yVnNVSS9oVkdqaS81Vy9pOGl5eGRHN0ZaVEZWdTM0ZnJTNlYvQkdmVEFs?=
 =?utf-8?B?SEhpRStmZjN5MENCczczbnM0ZER0SHowTnNraVMyZ0szL2t3cy8zT0swdXFo?=
 =?utf-8?B?dVZNNzRYYXJITDNMOEwwS0pXUUdOTFNYVGVjcTcvUzg0SUxiUTF2bFA1alBG?=
 =?utf-8?B?Vkd5U2hmaStBTVZ2ZWFVTFdEVjBPcytyemlidEVTb1VqeTVyQTg0a2IxbDRn?=
 =?utf-8?B?MkhkNzNKbGcxVnhCUWhtdG9ueHJGYkFvenRLVndxQlRkMHRpYlZBNTV2ampz?=
 =?utf-8?B?ekdWc3BCZ2tFeVV6dURZSm1RWjViSzNCWXpwWTZqU3dhOGszclF3VXExR2NI?=
 =?utf-8?B?cHpqNEhtaWMyYW1CSzFmZGpCQ2F4YzY4azlhNXkxTU1TNnhETG5PN2dLQVlY?=
 =?utf-8?B?aUlPQkpMZlVBU0xCdU5rNzFYY3hpS3Q0cldUbG9zU1FMdWVJSFlRbVNCMTVm?=
 =?utf-8?B?RDN0UEpmOVFweVNJV3NsTEsxYVNoMEZHVTdjZFdvVmFsUUp0bHpTUFNNZ2Vr?=
 =?utf-8?B?Q25xY2ljYUZidDRoSHVaN3I1S1YzU3NBT0RXYnRvV1hjeDB0YjJQWGo4TExM?=
 =?utf-8?B?TlFqc3poMnRBaEZhaFJlcXovWmlsaG94alJpSlNSaXVFQ2sxVUpETlUxdkM2?=
 =?utf-8?B?QVdvWU80T2dtdmE3TW5TT1RSTllSS3dnbjY2allSWnFSdnBJcmg4RE56eHBq?=
 =?utf-8?B?NXUzRGxQWVgrN2lVb1llQk50bnErcXVXaTdaaVlOSEd0LzVMVk5Ya0xiSWFX?=
 =?utf-8?B?M3dVOCt2L0VjOEt4UUdRR0hqSXlvRXVnRXc0SWJaUmc1WW9RbTRZRlVJd1lS?=
 =?utf-8?B?dVRNcU9Tczg4VVplc040RjhobTdkM3d2clMrV3BrRUEzWjJnSWJGNUJhUVdU?=
 =?utf-8?B?ZTE3OThkYTdoejFHTmZIeUtNSnpTTTA2ZjFDZXNpTy81djJBWll4TnlwQWo3?=
 =?utf-8?B?bVNDbVBVTXZabnVRdTBpS1Uvdk9hMktQbjZhSHpaQVRjWnBkb2Rvb0RkZGd5?=
 =?utf-8?Q?vEk8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9051285-6c14-4281-4383-08de04e07d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 13:58:55.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGaMOZYxTFiwj11miGj1xq3IP/UO0vqIOSiQt4h+DOYlFgikc3pMrwLBTARhYaZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDYsIDIwMjUgODoxMSBBTQ0K
PiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENjOiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47DQo+IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3
YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9s
bmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4
LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6eXRv
ci5jb20+OyBLbGF1cyBLdXNjaGUgPGtsYXVzLmt1c2NoZUBjb21wdXRlcml4LmluZm8+OyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB4ODYv
YnVnczogUXVhbGlmeSBSRVRCTEVFRF9JTlRFTF9NU0cNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNz
YWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlv
bg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25k
aW5nLg0KPg0KPg0KPiBPbiBGcmksIE9jdCAwMywgMjAyNSBhdCAxMjoxOTozNlBNIC0wNTAwLCBE
YXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4gV2hlbiByZXRibGVlZCBtaXRpZ2F0aW9uIGlzIGRpc2Fi
bGVkLCB0aGUga2VybmVsIGFscmVhZHkgcHJpbnRzIGFuIGluZm8NCj4gPiBtZXNzYWdlIHRoYXQg
dGhlIHN5c3RlbSBpcyB2dWxuZXJhYmxlLiAgUmVjZW50IGNvZGUgcmVzdHJ1Y3R1cmluZyBhbHNv
DQo+ID4gaW5hZHZlcnRlbnRseSBsZWQgdG8gUkVUQkxFRURfSU5URUxfTVNHIGJlaW5nIHByaW50
ZWQgYXMgYW4gZXJyb3IsIHdoaWNoIGlzDQo+ID4gdW5uZWNlc3NhcnkgYXMgcmV0YmxlZWQgbWl0
aWdhdGlvbiB3YXMgYWxyZWFkeSBleHBsaWNpdGx5IGRpc2FibGVkIChieQ0KPiA+IGNvbmZpZyBv
cHRpb24sIGNtZGxpbmUsIGV0Yy4pLg0KPiA+DQo+ID4gUXVhbGlmeSB0aGlzIHByaW50IHN0YXRl
bWVudCBzbyB0aGUgd2FybmluZyBpcyBub3QgcHJpbnRlZCB1bmxlc3MgYW4gYWN0dWFsDQo+ID4g
cmV0YmxlZWQgbWl0aWdhdGlvbiB3YXMgc2VsZWN0ZWQgYW5kIGlzIGJlaW5nIGRpc2FibGVkIGR1
ZSB0bw0KPiA+IGluY29tcGF0aWJpbGl0eSB3aXRoIHNwZWN0cmVfdjIuDQo+ID4NCj4gPiBDbG9z
ZXM6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjIwNjI0DQo+
ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgS2FwbGFuIDxkYXZpZC5rYXBsYW5AYW1kLmNvbT4NCj4g
PiAtLS0NCj4gPiAgYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMgfCA0ICsrKy0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9idWdzLmMNCj4gPiBpbmRleCA2YTUyNmFlMWZlOTkuLmUwOGRlNWIwZDIwYiAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC9jcHUvYnVncy5jDQo+ID4gQEAgLTE0NjMsNyArMTQ2Myw5IEBAIHN0YXRpYyB2b2lkIF9f
aW5pdCByZXRibGVlZF91cGRhdGVfbWl0aWdhdGlvbih2b2lkKQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gPiAgICAgICAgICAgICAgIGRlZmF1bHQ6DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgIGlmIChyZXRibGVlZF9taXRpZ2F0aW9uICE9IFJFVEJMRUVEX01JVElHQVRJ
T05fU1RVRkYpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoUkVU
QkxFRURfSU5URUxfTVNHKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAo
cmV0YmxlZWRfbWl0aWdhdGlvbiAhPSBSRVRCTEVFRF9NSVRJR0FUSU9OX05PTkUpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoUkVUQkxFRURfSU5URUxf
TVNHKTsNCj4gPiArDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0YmxlZWRf
bWl0aWdhdGlvbiA9IFJFVEJMRUVEX01JVElHQVRJT05fTk9ORTsNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgfQ0KPg0KPiBJIGd1ZXNzIHdlIGNhbiBkbyB0
aGF0IGZvciBub3cuLi4NCj4NCj4gQnV0IGV2ZW4gd2l0aCBpdCwgbXkgcmFuZG9tIGd1ZXN0IHNh
eXM6DQo+DQo+IFsgICAgMC40MjAzNzddIG1pdGlnYXRpb25zOiBFbmFibGVkIGF0dGFjayB2ZWN0
b3JzOiBTTVQgbWl0aWdhdGlvbnM6IG9mZg0KPiBbICAgIDAuNDIxMzU1XSBTcGVjdWxhdGl2ZSBT
dG9yZSBCeXBhc3M6IFZ1bG5lcmFibGUNCj4gWyAgICAwLjQyMjIzNF0gU3BlY3RyZSBWMiA6IFZ1
bG5lcmFibGUNCj4gWyAgICAwLjQyMjg0NV0gU3BlY3VsYXRpdmUgUmV0dXJuIFN0YWNrIE92ZXJm
bG93OiBWdWxuZXJhYmxlDQo+IFsgICAgMC40MjM3NTldIFNwZWN0cmUgVjEgOiBWdWxuZXJhYmxl
OiBfX3VzZXIgcG9pbnRlciBzYW5pdGl6YXRpb24gYW5kIHVzZXJjb3B5DQo+IGJhcnJpZXJzIG9u
bHk7IG5vIHN3YXBncyBiYXJyaWVycw0KPg0KPiBkdXJpbmcgYm9vdCB3aXRoDQo+DQo+ICMgQ09O
RklHX0NQVV9NSVRJR0FUSU9OUyBpcyBub3Qgc2V0DQo+DQo+IGluIGl0cyBjb25maWcuDQoNCkFs
bCBvZiB0aGUgYWJvdmUgbWVzc2FnZXMgYXJlIHByaW50ZWQgYXMgcHJfaW5mbygpIHRob3VnaCwg
d2hpbGUgdGhlIFJFVEJMRUVEX0lOVEVMX01TRyB3YXMgcHJpbnRlZCBhcyBwcl9lcnIoKS4gIFdo
aWNoIEkgdGhpbmsgaXMgYW4gaW1wb3J0YW50IGRpc3RpbmN0aW9uLg0KDQo+DQo+IFRoZSAiRW5h
YmxlZCBhdHRhY2sgdmVjdG9ycyIgZG9lc24ndCBtZWFuIGEgd2hvbGUgbG90IGlmIHdlJ3ZlIGRp
c2FibGVkDQo+IG1pdGlnYXRpb25zLiBJdCBwcm9iYWJseSBpcyBldmVuIGEgYml0IG1pc2xlYWRp
bmcuDQoNCldlIGNvdWxkIGZpeCB0aGF0IHRvIHByaW50IE5vbmUgb3Igc29tZXRoaW5nIGxpa2Ug
dGhhdCBpZiBub25lIGFyZSBzZWxlY3RlZCBJIHN1cHBvc2UuDQoNCj4NCj4gVGhlIG90aGVycyBh
cmUgcGVyaGFwcyAqdGVjaG5pY2FsbHkqIGNvcnJlY3QgYnV0IHRoZW4gd2UncmUgcmVwb3J0aW5n
IG9ubHkNCj4gYSBzdWJzZXQgb2YgdGhlIG1pdGlnYXRpb25zIGFuZCBub3QgYWxsIGZvciB3aGlj
aCB0aGUgbWFjaGluZSBpcyBhZmZlY3RlZC4NCj4NCj4gQnV0IGl0IGFpbid0IHRoZSByaWdodCBm
aXggbG9uZyB0ZXJtLCBBRkFJQ1QuDQo+DQo+IEJlY2F1c2Ugd2UgcHJvYmFibHkgc2hvdWxkIGRv
IHRoaXMgaW5zdGVhZDoNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvTWFr
ZWZpbGUgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L01ha2VmaWxlDQo+IGluZGV4IDJmOGE1OGVmNjkw
ZS4uYzc4OTI4NmE0ODBiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L01ha2Vm
aWxlDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvTWFrZWZpbGUNCj4gQEAgLTIyLDcgKzIy
LDcgQEAgb2JqLXkgICAgICAgICAgICAgICAgICs9IHRvcG9sb2d5X2NvbW1vbi5vIHRvcG9sb2d5
X2V4dC5vDQo+IHRvcG9sb2d5X2FtZC5vDQo+ICBvYmoteSAgICAgICAgICAgICAgICAgICs9IGNv
bW1vbi5vDQo+ICBvYmoteSAgICAgICAgICAgICAgICAgICs9IHJkcmFuZC5vDQo+ICBvYmoteSAg
ICAgICAgICAgICAgICAgICs9IG1hdGNoLm8NCj4gLW9iai15ICAgICAgICAgICAgICAgICAgKz0g
YnVncy5vDQo+ICtvYmotJChDT05GSUdfQ1BVX01JVElHQVRJT05TKSAgICAgICAgICArPSBidWdz
Lm8NCj4gIG9iai15ICAgICAgICAgICAgICAgICAgKz0gYXBlcmZtcGVyZi5vDQo+ICBvYmoteSAg
ICAgICAgICAgICAgICAgICs9IGNwdWlkLWRlcHMubyBjcHVpZF8weDJfdGFibGUubw0KPiAgb2Jq
LXkgICAgICAgICAgICAgICAgICArPSB1bXdhaXQubw0KPg0KPiBiZWNhdXNlIG9mZiBtZWFucyBv
ZmYgYW5kIHRoZXJlIHNob3VsZCBiZSBub3RoaW5nIGluIHRoZSBib290IGxvZyBhYm91dCBhbnkN
Cj4gbWl0aWdhdGlvbnMgYW5kIG5vIGNvZGUgc2hvdWxkIGJlIGJ1aWx0IGluLiBXaGljaCBpcyBk
b25lIG5vdyAtIGp1c3QgdGhlIGNvZGUNCj4gaXMgaW5hY3RpdmUgd2hpY2ggaXMgbm90IHdoYXQg
d2UgZG8gd2l0aCBkaXNhYmxlZCBjb2RlIGluIHRoZSBrZXJuZWwuDQo+DQo+IEJ1dCB0aGF0IHRo
ZW4gY2F1c2VzIGF0IGxlYXN0IHRoaXM6DQo+DQo+IEVSUk9SOiBtb2Rwb3N0OiAiY3B1X2J1Zl92
bV9jbGVhciIgW2FyY2gveDg2L2t2bS9rdm0ua29dIHVuZGVmaW5lZCENCj4gRVJST1I6IG1vZHBv
c3Q6ICJzd2l0Y2hfdmNwdV9pYnBiIiBbYXJjaC94ODYva3ZtL2t2bS5rb10gdW5kZWZpbmVkIQ0K
PiBFUlJPUjogbW9kcG9zdDogImdkc191Y29kZV9taXRpZ2F0ZWQiIFthcmNoL3g4Ni9rdm0va3Zt
LmtvXSB1bmRlZmluZWQhDQo+IEVSUk9SOiBtb2Rwb3N0OiAibDF0Zl92bXhfbWl0aWdhdGlvbiIg
W2FyY2gveDg2L2t2bS9rdm0ua29dIHVuZGVmaW5lZCENCj4gRVJST1I6IG1vZHBvc3Q6ICJ4ODZf
aWJwYl9leGl0X3RvX3VzZXIiIFthcmNoL3g4Ni9rdm0va3ZtLmtvXSB1bmRlZmluZWQhDQo+IEVS
Uk9SOiBtb2Rwb3N0OiAiaXRsYl9tdWx0aWhpdF9rdm1fbWl0aWdhdGlvbiIgW2FyY2gveDg2L2t2
bS9rdm0ua29dIHVuZGVmaW5lZCENCj4gRVJST1I6IG1vZHBvc3Q6ICJ4ODZfc3BlY19jdHJsX2N1
cnJlbnQiIFthcmNoL3g4Ni9rdm0va3ZtLWFtZC5rb10gdW5kZWZpbmVkIQ0KPiBFUlJPUjogbW9k
cG9zdDogIng4Nl92aXJ0X3NwZWNfY3RybCIgW2FyY2gveDg2L2t2bS9rdm0tYW1kLmtvXSB1bmRl
ZmluZWQhDQo+IG1ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0OjE0NzogTW9k
dWxlLnN5bXZlcnNdIEVycm9yIDENCj4gbWFrZVsxXTogKioqIFsvbW50L2sva2VybmVsL3IvMTEv
bGludXgvTWFrZWZpbGU6MTk2MDogbW9kcG9zdF0gRXJyb3IgMg0KPg0KPiB3aGljaCBtZWFucyB1
bnRhbmdsaW5nIGZyb20ga3ZtLi4uIHdoaWNoIG1lYW5zIHVnbHkgaWZkZWZmZXJ5Li4uDQo+DQo+
IFNvdW5kcyBsaWtlIGEgbG9uZ2VyIHByb2plY3QuLi4NCj4NCg0KU291bmRzIHJhdGhlciB5dWNr
eS4gIFdoYXQgYWJvdXQganVzdCBub3QgY2FsbGluZyBjcHVfc2VsZWN0X21pdGlnYXRpb25zKCkg
aWYgQ09ORklHX0NQVV9NSVRJR0FUSU9OUz1uPyAgVGhlbiB5b3Ugd29uJ3QgZ2V0IGFueSBwcmlu
dCBtZXNzYWdlcyBlaXRoZXIgSSdkIHRoaW5rLg0KDQotLURhdmlkIEthcGxhbg0K

