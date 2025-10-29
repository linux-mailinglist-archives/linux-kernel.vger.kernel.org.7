Return-Path: <linux-kernel+bounces-876272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5809CC1B36D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F5875A0EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551293346BC;
	Wed, 29 Oct 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lo8oYHjp"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5FF3314C8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745690; cv=fail; b=s+B2UqBvLv29XoCYoYyUy8NArlBVqy/EWJngZipXhxNB21uZyNc9m6EI7HbJ1ESa0XwRswlGxaG5z0gOTk6dwA8RDvhZzMx4QOpZKQ91ncoKEQkEqHHd6IuZclnnlfBv48w3MnblBM3WkqF7cP4QG+3hqWYMHaiyqER/9HCNvdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745690; c=relaxed/simple;
	bh=n+tRA13z9ffWSc04pOdujaXxnP66CPYMY9XZEuIR7/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RqWyl4udMbg5chhR91w+2halHMOVtW3PXYT/pYDz65/RMKFEhq6u//H38pikaY6Df6nKCsUmK9BXDX7j3KtbCDN5xILRiJ+pWHPJpYOchloVq89DJ6Y5d0kuyhTg/AoIbzvy85MeOoPxRvWa/i8+fCt+eGyqwqa6IPUzy0OeWCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lo8oYHjp; arc=fail smtp.client-ip=52.101.62.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEp/F+5i0Xf1BMd5k9zLsQhq42E0KXG1E0WQDbV0o3xOCmQUYnf8AIxJsuD55WzNb7Q8+oRGusoOnuErmUMjS9E+Nxtvs9rlR78sjE3u+OnDYPxDnoduD1NP+7P/8V60fz45DncRiBOpVDfx+oyHX2gur/9EabuE9coSNmOWUutlMjMbNewSzoRpaqAo7ytKzaaW8PDf/XUzW+F8kmEQ+XF5XW8ksqb264VWNSuBRjn4jHsVT1GHrcVWtk3cTdYPh6beILrINAG0hBYzHN9Q/aRshsb9gX9R6KyKgZxsm1crKokFshuFLAWzuo3nMmv7Y19wNfWp7fNVfLBrZbvbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+tRA13z9ffWSc04pOdujaXxnP66CPYMY9XZEuIR7/8=;
 b=qzYB6DoVAeNjpU+C1kpriyRioTZqKlN7q05KXnhQPcoVKXeUdM+OXNzMkxYB9+5HRciT3ZjJxF2iyTqTIy2/0uTvWhGQvbUikkxOQcQeByeCs9GauozZgfDZr9EUsMkiMGiVOM09cyARRxm3Tee2M+iFhsVxM1UvQ2COSpel9eiZhetdaEE+o1NzF/ETN83nc6G/t1Fa5hSsPInQhpa1PxDtbI57KFb50ej6MiSQgEd51A7Z4yH5GzCF7dgJ8/N1K4+dL0O+GX9FxdPaEEiL1Zr/nDORh713PaHUWM50mvHSdU3nS9zP9x155pdjWn6WfWS5xICXiZSnL/trrBv2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+tRA13z9ffWSc04pOdujaXxnP66CPYMY9XZEuIR7/8=;
 b=lo8oYHjpd+QjC6c0jYGvqPI8LTUSiDoyfvbf75UCq8EHjsZLiehVMYf8deidPe7VIR0LGSjVQP941Wq1OOiE9qqabYMFJgcQ7/5k/rRWcN+QhsPBNHUXtzxhtSegfQrjUbZycfzbI1OML0oplTI91hANdYGPQPE59787wOSclrs=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 13:48:03 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 13:48:03 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 04/56] x86/bugs: Reset spectre_v1 mitigations
Thread-Topic: [RFC PATCH 04/56] x86/bugs: Reset spectre_v1 mitigations
Thread-Index: AQHcSMstRe1Ck9Ncck2JRlQCLRKbhbTZIozQ
Date: Wed, 29 Oct 2025 13:48:03 +0000
Message-ID:
 <LV3PR12MB92654784A9E2D5E5639B875394FAA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-5-david.kaplan@amd.com>
 <20251029115719.GEaQIBH1j4vVEQLas9@fat_crate.local>
In-Reply-To: <20251029115719.GEaQIBH1j4vVEQLas9@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-29T13:43:54.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SA0PR12MB4448:EE_
x-ms-office365-filtering-correlation-id: 25efda2c-b6ca-4765-d6d3-08de16f1c846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?V242YkN1cUw1ZW5nWGF0MEM2bFpiaWVSYk5CVlc2aXZBV0RzYXRjaWI2K0l1?=
 =?utf-8?B?bi9WL0ZDOTJVM0wvS3ZJWHZWeEhqK0xUcDdoUk4wRmVUTFFZKzAvNVlEeHhB?=
 =?utf-8?B?VXg2NkNjeUdsaTRZTnoxY21FVUhrMWNjNDJkNEgvcTRaVnhvTkZVUDNuZnVo?=
 =?utf-8?B?bzh4ZGNpZGRHVWRWRG1helNMVk5DVUpESUlQbUdhWStidUJDQWRsa2NqUnhM?=
 =?utf-8?B?NGNicWFRVktWZGpjaVk0OGhkZk1wS2tKSmkwOG1IcjZqcThvNk9vaitkQStu?=
 =?utf-8?B?Q2FMeFhSVFlSM0NpWVorcjBxWEd0TG5WM1ZQWVQ5WjJyV0o5WUJTWlB0dzQx?=
 =?utf-8?B?c0t0dE94NkVwajBuZ0lhY0drdWFUblpjTElJOEMrRW5XS2NKKzVNZzZ2dEQz?=
 =?utf-8?B?WTV4OVNhWUxzTE9pYVlPQyt2TUpKUEJwb3JuZHZMa2M4RmRsUWhqQ2ZWS1lY?=
 =?utf-8?B?RFk5SEdXZDhYcXYxc0IxUk5yZnF3MVc1OXpnTEovRm51TVgwd2FsVVBDMXJl?=
 =?utf-8?B?NzNFejVKZXZXL3QvTTZGa0dkK0pRWjJUa2gvOHFYVEIxeUJDL0piWGdPcnFE?=
 =?utf-8?B?dWsvZ3czNmlxVHpqbXRUR1JhT2FKOVdwLzJVSVRHb3ArdWo0VkhtTFRtVDgz?=
 =?utf-8?B?bldVTW1HWkF4eTdSVEhVK0E5cjhxQlQzbTJJSWlWUmRPOXJWT0NCaGJkNkpZ?=
 =?utf-8?B?QzVreVBqRi9ZT1FEQjU5TExXSGZBd2djaDg2a0JSbDEzRDJoaXFBWW40WnJR?=
 =?utf-8?B?REZvUVh1OFVoSm4vdU1HQnFKZ3M5WVpSUW4yL1lGTWMzSVM5cWZLTHVXSERp?=
 =?utf-8?B?dmhyNkEvcmNjNXhaTVUzdExtNXc5VmR3cGoxNEtXUldJY0Y5bTYyM2JoUEZn?=
 =?utf-8?B?WUlaSEhkelJkclFpSFZWaHBnelhaL3pDSU5TSW1ZVVJFN0QxemdLd2hKSk0v?=
 =?utf-8?B?dEdpREc5dTJkRzhsdTVmdzFzK1hXRVE2VXlsNkU5bm9kSVdPN1hwTlZGNTFR?=
 =?utf-8?B?SHlnc3B3YjIzcGlLTElLaXNtUVR5RDgrdlhERzZQdmphd0ZZZVFkanJ5a2tE?=
 =?utf-8?B?T04vNkVrRDlYTnlCN0Q1anU2NXFJdzlvWG82VlVZSG8wNklIaGxML205VVdk?=
 =?utf-8?B?c1lhVEs0UW13S2RBRlNva1g4MGFjVkRPbXJiOXVGdVdrM00zdGZ6ZGlMZ1d3?=
 =?utf-8?B?TSs0UWtNUlRJRDkwTnFIeE4wUmdMZU5PRHJWNHBLNm0zS0E5MzZxeUc5L1hP?=
 =?utf-8?B?QjNJU2hlTXo3N01CRzRFdGVTSGh0cTEwUHFlYVJ6SjY2M1JPUU9qa0ZqY1Rz?=
 =?utf-8?B?UUU5cGNIdmx5eEg1RzNlck82T1RZYVRtM2lJNGwxVFc0SkhpOEdZQ2tla1Zs?=
 =?utf-8?B?MzNWbXlLaERjZE91UnM3RVE2cS9kSDNZbWhHdHFvOWh6azQrbkNaSEZsQ3VY?=
 =?utf-8?B?VW5aMmEwUVREcjQyeHlxUUNhWDU2OXdzVE5zMjFlaXJpUW1kREE4ZXUwL1N4?=
 =?utf-8?B?NzhDTWQ4ZEV1Nm1IcFdaNUpzWmdOTUtXc3pvb2c5TlF3Ky9jVjhQdzBKWGgz?=
 =?utf-8?B?TDFsUUhxMVVLZ0xTNGVMbXJrVlBsdUVhNjhRMnI0ME1iQ2VRLy91elZxY0hJ?=
 =?utf-8?B?YUN5WEFZQmpESVNDUnpSbml3S2JRcnhNSFh4Z2g5d1ZpVERkT3piSFFGVHhw?=
 =?utf-8?B?ZTNQcFhiSWpLRkdnNlkreHh3TXU4azdsNElVRkw2dlhJbW9xcTg3MjRISEpw?=
 =?utf-8?B?UGNYNXVNenFZcTVjakdFbHcwN1hxcVRYWUJnMHp6YTJVVmFUaitCb1NqeFpU?=
 =?utf-8?B?aDNyclpUcWcvRnJFbkh3NDZSeFpJUFg3RGQ5WmlTbzdMVVlZS095aWUvOEZi?=
 =?utf-8?B?c0s3bGpuNSthTXlFK3Q2SE4yNnVySllySlhXQWVVTFBmNUlDcnYvK0Vpa1gx?=
 =?utf-8?B?bkVuem1hV1BsUFRKK1ZGdjkrYmV5d2pGVXBSSmhKRVJ2MjUxUUp0UFFaQThs?=
 =?utf-8?B?OVJFM2grVG0xK0l5Rm82VkNDNW91VE5iSlZuVGJyMGFsOU1JTEpFVlQ5am5C?=
 =?utf-8?Q?IOTlZa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUQvVmVFVVpCMW4xSDI1NEFsTkhvaG1NejhQczFMSVkxWDZlcVROaTZDaFZS?=
 =?utf-8?B?ckEyWlNOTnMwZVpGWVNDMDFDbk1rRkRXSTZyN0ZQQ2lHbmkxS0VSZjRTVGxT?=
 =?utf-8?B?cWZjWWRza0xXTjhuZXVHK0ltTXhnWG9qVFU5b0dNYUtVTklqaFdJRk9qaGJw?=
 =?utf-8?B?RWJMcFdPZG1kVGlNMUU5RC9iYVROejlPSStwY0FoeHdoamErQTh2ekI2RXRJ?=
 =?utf-8?B?KzVReU05Q25GazRyNUZtMGhlcVZyVG44WEJHQmw0TEh0OWw4eCsvY2ZrTmdK?=
 =?utf-8?B?a2FOQ2VKdlUwdzBtak9JdUh5bW1TRms2clgyVSs1TTVjRW05YllYUGgvRGJI?=
 =?utf-8?B?VExYZGJPU0V0NVN1Z3F1UGZERXREbWtOZit1M3hqQ2MzR2dIWjhVUUFkejBU?=
 =?utf-8?B?U05MazVJWjVSQUtaTXJFZWxaTG9HemJHcFN5ZlZ1ZUtRbmVnRkhncGN0WXcz?=
 =?utf-8?B?K1pPenBZbGd0L1FwckJNU0dQTXhUS1d0L0FhTkVuVTNMR21jVDZhTWZmZ0h6?=
 =?utf-8?B?RUVXYXMxZTlYdnd6UFAxTnhnWitrWXFRbENWMm5NbFZtWi9Kcm96TlY4ZFo3?=
 =?utf-8?B?azdiNWp5Ti85Rng2alRZTGloaTByYjdoVGtYSm1ON0hVQk1hcUNodmVkTGp5?=
 =?utf-8?B?SlhOWjNyRm1ZZk41ZUkvcnRxWGtON3FXM0tJME1UcFM1MExBc3d4T1hVbVRF?=
 =?utf-8?B?TXZ2QjVPUm0weDFxMjNzVDZIcTcwd1g5UUNpWFB5ZzRxSU1jU2c5bXBqTFBM?=
 =?utf-8?B?NkpqNkt5SGRpVUlENzFra0tROU13ZlZIWmQwQkFJcG51dkgvTWZRRWVIQk5K?=
 =?utf-8?B?R2NyWmxDY1ViZWxzaEJuUkVlRktVb3RhVXludmJDWk5vZ09YMHhhOTV2KzQr?=
 =?utf-8?B?VlNEL01WMy84QjllNkg5L2FCazV4UkQxNWJhQnMvSjdvU21yRjROSnBURytT?=
 =?utf-8?B?cjFEZXk5UmovQU84eUFMdlh1MVFyM242aGJLaytvdy83WDRtaDdoNlBIY3dJ?=
 =?utf-8?B?QXh5d0F3c3JSN2JOVG84ZnBlQ3plWmFSYlZZdFI5Q2toa1BtYkNYVm9sWkp2?=
 =?utf-8?B?S1E2bytteDVEbUlIdklFUmRCTkZKdGo4TGh2QjRYMnVvTzdnbDhOY25BTEFZ?=
 =?utf-8?B?WFIwZm1VUGJUZEJ1YndXRzB3NWk4YWZBZVZFdmxYTkhDSm51VUliZWlyZVhs?=
 =?utf-8?B?Z2tFVitZMlNCeURFRmFMSDQrZjFqeEpYWjJVMVFNcHY2aCtrVjJ2b2xScjBI?=
 =?utf-8?B?dFhwUG9iOTFDUm11ZFFxZlRaVjQ0UEdMUCtoa0s4ZFdMUmZROU96QlFvNGpJ?=
 =?utf-8?B?WXJWMDZtZjNkcTN2c3pzanJIWkJSRDdDSnFZRktTdTBrL3RsSXNzZThoR0tC?=
 =?utf-8?B?N1NTUGpScXlLdjV4blREWUJLWFMrelVTQjZmR05EUi9KT2lpZlQzMkF3MTdz?=
 =?utf-8?B?Y2dxSnVvU3dYNXFldDlIdDBidTNFaEh0T2QydFloOVpoaUhicVQwb29jMHFQ?=
 =?utf-8?B?VEdQOEQ5K1hkWW1FdFNGb3ZKSFdKamxxVXJrNXFrcGg4UlJhRFF6bHlJQnlF?=
 =?utf-8?B?NG5SazJZbnNaK3hsVUxPMzhCd1JxdGdqeXJNZDFBQ2hsVDJzb0tNNC9Wa2pK?=
 =?utf-8?B?VDM5a2Rmb2ExbVZwVER5a2kzSG1UL3NXbU5aT0tYQzdpdDNTNGtGYXVWODlp?=
 =?utf-8?B?Sm04Y2JaaUxZOFQ1bjhDTGhxUEFBcDlkVGhiRmx2N040SWMyQjc1Ull1OG1I?=
 =?utf-8?B?aThHSU9oMXVYc251bHRSZTBHekl3TE1tdk8rdXJtOUt5THUwYVd4dEZjY3dW?=
 =?utf-8?B?S1dHcE1ndFlzVVZEYXdSZGg0blAza3JZekswdGJJTWErOGJBbUZZbFh2bjdY?=
 =?utf-8?B?VVVsOUlZTDBxNjlWUUV5cy9oTTR0VFpDNC9PQXhaYlZIa29oVnQ4eUlKQytO?=
 =?utf-8?B?SGNoSkcrOWxjMGZqanI3Y3RPNWVUTWdXVGRLelFHdllYUDVoWnhkMklpaW9p?=
 =?utf-8?B?SzZyWkNXTjUvSjQ4NUhnNlJBRmIzVVltU1BRR2dJVlRjVFJBSEV6QWRlb3ZI?=
 =?utf-8?B?alRmWWdBeWxFd3BmTmJnQkJiQ2YzZnZGT3U5QXlWSU9mSTh1c3Y0Sk1xTmJJ?=
 =?utf-8?Q?Yhy8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25efda2c-b6ca-4765-d6d3-08de16f1c846
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 13:48:03.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1mfXrSWdHmmz1d0Df+cmSUjmVH8ayGYECiOR3kU41PcMAUo60SYM/9SnvjtIKy6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI5LCAyMDI1IDY6NTcg
QU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogVGhv
bWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+Ow0KPiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAa2VybmVsLm9yZz47
IFBhd2FuIEd1cHRhDQo+IDxwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+OyBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IERhdmUNCj4gSGFuc2VuIDxkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluDQo+IDxocGFA
enl0b3IuY29tPjsgQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT47IEJvcmlzIE9zdHJv
dnNreQ0KPiA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDA0LzU2XSB4ODYvYnVnczogUmVz
ZXQgc3BlY3RyZV92MSBtaXRpZ2F0aW9ucw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3Jp
Z2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdo
ZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+
DQo+DQo+IE9uIE1vbiwgT2N0IDEzLCAyMDI1IGF0IDA5OjMzOjUyQU0gLTA1MDAsIERhdmlkIEth
cGxhbiB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMg
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYw0KPiA+IGluZGV4IDZhNTI2YWUxZmU5OS4uOWQ1
YzZhM2U1MGUxIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jDQo+
ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4gPiBAQCAtNDYsNiArNDYsOCBA
QA0KPiA+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1heSB3YW50IHRvIGNoYW5n
ZSBiYXNlZCBvbiBvdGhlciBjaG9pY2VzDQo+ID4gICAqICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbWFkZS4gIFRoaXMgZnVuY3Rpb24gaXMgb3B0aW9uYWwuDQo+ID4gICAqICAgPHZ1bG4+
X2FwcGx5X21pdGlnYXRpb24oKSAtLSBFbmFibGUgdGhlIHNlbGVjdGVkIG1pdGlnYXRpb24uDQo+
ID4gKyAqICAgPHZ1bG4+X3Jlc2V0X21pdGlnYXRpb24oKSAtLSBVbmRvJ3MgdGhlIGFwcGx5X21p
dGlnYXRpb24gc3RlcCwgdGhpcyBpcyB1c2VkDQo+DQo+ICJVbmRvZXMiIG5vPw0KDQpZZXMsIHdp
bGwgZml4DQoNCj4NCj4gPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdpdGggcnVu
dGltZSBtaXRpZ2F0aW9uIHBhdGNoaW5nLg0KPiA+ICAgKg0KPiA+ICAgKiBUaGUgY29tcGlsZS10
aW1lIG1pdGlnYXRpb24gaW4gYWxsIGNhc2VzIHNob3VsZCBiZSBBVVRPLiAgQW4gZXhwbGljaXQN
Cj4gPiAgICogY29tbWFuZC1saW5lIG9wdGlvbiBjYW4gb3ZlcnJpZGUgQVVUTy4gIElmIG5vIHN1
Y2ggb3B0aW9uIGlzDQo+ID4gQEAgLTEyNDcsNiArMTI0OSwxNSBAQCBzdGF0aWMgdm9pZCBfX2lu
aXQgc3BlY3RyZV92MV9hcHBseV9taXRpZ2F0aW9uKHZvaWQpDQo+ID4gICAgICAgcHJfaW5mbygi
JXNcbiIsIHNwZWN0cmVfdjFfc3RyaW5nc1tzcGVjdHJlX3YxX21pdGlnYXRpb25dKTsNCj4gPiAg
fQ0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfRFlOQU1JQ19NSVRJR0FUSU9OUw0KPiA+ICtzdGF0
aWMgdm9pZCBzcGVjdHJlX3YxX3Jlc2V0X21pdGlnYXRpb24odm9pZCkNCj4gPiArew0KPiA+ICsg
ICAgIHNldHVwX2NsZWFyX2NwdV9jYXAoWDg2X0ZFQVRVUkVfRkVOQ0VfU1dBUEdTX1VTRVIpOw0K
PiA+ICsgICAgIHNldHVwX2NsZWFyX2NwdV9jYXAoWDg2X0ZFQVRVUkVfRkVOQ0VfU1dBUEdTX0tF
Uk5FTCk7DQo+ID4gKyAgICAgc3BlY3RyZV92MV9taXRpZ2F0aW9uID0gU1BFQ1RSRV9WMV9NSVRJ
R0FUSU9OX0FVVE87DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+DQo+IFJpZ2h0LCBsZXQncyBzZWUg
aW4gdGhlIGVuZCB3aGF0IGlzIGVhc2llcjogd2UgaGF2ZSB0aGUgY3Jvc3MtZGVwZW5kZW5jaWVz
DQo+IGJldHdlZW4gbWl0aWdhdGlvbnMgc28gaGF2aW5nIHNlcGFyYXRlICJ1bmRvIiBmdW5jdGlv
bnMgbWlnaHQgcmVxdWlyZSB0aGVtIHRvDQo+IHJ1biBpbiByZXZlcnNlIG9yZGVyIHRvIHRoZSAi
YXBwbHkiIGZ1bmN0aW9ucy4gSSBjYW4gaW1hZ2luZSBhIHNpbmdsZSAidW5kbyINCj4gZnVuY3Rp
b24gd291bGQgYmUgZWFzaWVyIGJlY2F1c2UgeW91IGhhdmUgZXZlcnl0aGluZyBpbiBvbmUgcGxh
Y2UuDQo+DQo+IFdlJ2xsIHNlZS4NCj4NCg0KV2UgaGF2ZSBjcm9zcy1kZXBlbmRlbmNpZXMgYXJv
dW5kIHRoZSAqc2VsZWN0aW9uKiBvZiBtaXRpZ2F0aW9ucywgYnV0IG5vdCBhcm91bmQgdGhlIGFw
cGxpY2F0aW9uIG9mIHRoZW0uICBUaGVyZSBpcyBubyBvcmRlcmluZyByZXF1aXJlbWVudCBhcm91
bmQgdGhlICpfYXBwbHlfbWl0aWdhdGlvbigpIGZ1bmN0aW9ucy4gIEFzIHN1Y2ggSSB3b3VsZCBu
b3QgZXhwZWN0IChhbmQgaGF2ZSBub3Qgb2JzZXJ2ZWQpIGFueSBvcmRlcmluZyByZXF1aXJlbWVu
dHMgYXJvdW5kIHRoZSByZXNldCBmdW5jdGlvbnMuDQoNCi0tRGF2aWQgS2FwbGFuDQoNCg0K

