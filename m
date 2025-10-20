Return-Path: <linux-kernel+bounces-861053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABB9BF1A87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF313BE3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0D031B81B;
	Mon, 20 Oct 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t9Tqua5U"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989B315D52
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968397; cv=fail; b=By8RzYbRmrOO4MiPI1HmKRiGlrKqPEIYJD8zU1Imfai/RIJ+ayucqYQlc2TYoTH7hAUs2dHOeUeWUqtxk/NApXDPIpOJFFAhi6GCT4QnQoPdxbHVlQyvSzYJRAhBjvhLeAufmBq8AOleikD5kKKPV++Jh73klSahrSwu1gdTibc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968397; c=relaxed/simple;
	bh=24EyC5Kw7nYrR0uaeo+V9bvq3e0bAStnZuDDVEE0Dwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PcA3/4TPXH3j/bLV6+ATit+cgQgOOzvd2ukmkw6eReAc/nJcJx4RUUU0T6VTlwpDDweSvr/DTpJD//za+NX66E0b+4Fytzb5uBAIPIC3lefKMb6/Cpup+uJHR0p3YmWgbLKlXs1ii/qCp+UmbvLKBpfM2AO3olSjTZKliDgox/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t9Tqua5U; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/gaZsO6Jp+squAjnMGzlEKe3eyAuKB4RbZkXkzBPpKuNejmlQmLVpfGdaDKSuwpPi4mtLo6Iy0VUEMdZyY+ueaKIECu+G+/0nNY3fSlPun8Kzxmn2JAGsb8R+V5Q525KyPKmAuSvawfW6zSI3jH2zdG+RnGOtHeUarIpPFrW/KBnSMG0D1Xk1kBaDY6oA+3D9V7wKZLB+iNXfOdDPbOHX31gl4v8TjIDnU1X9hUxmABl5hW7DVR+RPty2aZVBnz7G7NF8sC0aSfVp+zz1tUEADFoMZhJyz2rmBKY9FZBuGZCK5NLYRvO0magHXJ2ZhESiP2EJS0UspG5jgXgVxdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24EyC5Kw7nYrR0uaeo+V9bvq3e0bAStnZuDDVEE0Dwg=;
 b=d66t1sH+sMucBY+jwP9akmRpL5CypVog6DPU0nSLgttyjTR1bGWoXPu8O7o429W1idA6LQMV8J7G8wNr60gi2JSabj7oyR26EC7My5Kokj4dGkx75jY84NbKkcrJ8b98igM+QcOrpBIA8PCIG5GSfa3g8y2GZ7r3ke9xe6wk5eg461szuPav/7/pmiMm9mxiO9Gu+pQIVSYRXEN8HPeChwC4iBr2Un+BHt621Pzil0Uri/VVIK1/Afg63DNKaqE79r8h2J/EHecSvvib8tnm5PzUuCIEOEVPKz9drIorBc0Ya7SLToXfSexeS7sfHyLsvLxcJMKMJLIUpAWffGxiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24EyC5Kw7nYrR0uaeo+V9bvq3e0bAStnZuDDVEE0Dwg=;
 b=t9Tqua5UgMsDXHdyAnQe+rNKd2iGiaxXXAh5zhiXhx9uWFhF0KYOzhVuEn1fU09eK97GkdgOhPwSqAtUAjWLEWAb7nAFHEd0N6jnAj+7GFBSNPfoGzRXQV4DGiVEKsNEQCqhv5KWte+h3YUX2Vtg49lP45Ww6bWQ6At4ZIJ/Rlw=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:53:12 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 13:53:11 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 01/56] Documentation/admin-guide: Add documentation
Thread-Topic: [RFC PATCH 01/56] Documentation/admin-guide: Add documentation
Thread-Index: AQHcQDSW5c8pgJt5hkmBzm7RrZp2d7TLEGVA
Date: Mon, 20 Oct 2025 13:53:11 +0000
Message-ID:
 <LV3PR12MB9265578BE201F1D5E1D7488194F5A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-2-david.kaplan@amd.com>
 <20251018133913.GHaPOYgR0YNlz-KexS@fat_crate.local>
In-Reply-To: <20251018133913.GHaPOYgR0YNlz-KexS@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-20T13:49:49.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|IA0PR12MB7577:EE_
x-ms-office365-filtering-correlation-id: dc8fa47b-cd08-4985-c0ed-08de0fe0024f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MHVVdTdvajAvUHJpR3RpUGtkaTNtWWdoRVlRT1E3OHBOQ1hBSEMxcmdLVU5i?=
 =?utf-8?B?aDQvbFl0UmJpanppMElzc2taOGF0Z2N6T1VwSitGSDRBRDdXS1lxRWxCd1hZ?=
 =?utf-8?B?V3dneGNJL3NhVFE1L2R5T1lYdURyRnBmN0ZJMDNQcEhoSWFhaTI4SUhlQTFF?=
 =?utf-8?B?WWRoQ3BlOERsMWpQWVI1Qm5qQmN2aU1oUGhuTTFlUDBTQkNPci9BWmk4NjUv?=
 =?utf-8?B?VzBGTzloLzM5ell1Q29YVXlWck9RelNGdXY5Ui9UWWlUUU52cjBKaTNNSW82?=
 =?utf-8?B?N0l4T3hkY2NFYU9DL2ZkalNOTVpsaDhBUTUzUXhVV1kyZUwyMmYyWlhXOXR0?=
 =?utf-8?B?cGhLblJtMWNRRUNLTEtYdWdkRENLa3pQakFOSGhVRElvdDFiRk80RzVqNlBT?=
 =?utf-8?B?bUExRWxuV0FZZEVFVTVEOEZFR2FVZjk1S3RSRmI3N2wydHpqNHlpditzSWZF?=
 =?utf-8?B?MFUwdkg3Vk95dHlkN0dpTTU1NDNuZzB2SzE5LzRsL3piNWxQZWg1QmF3bFFo?=
 =?utf-8?B?ZVE3byt0REVkZlByVlcrcXFrQ2pVelBnbXRNMmZldlpCVVE1RGxqUTFUcFdn?=
 =?utf-8?B?Mk4xcjZqcDlGU1VZQTA3UWE2WTFOTVhEbHcrQng3YnRuMEx4aW9sclhjaUlS?=
 =?utf-8?B?bC9LTi9YallnbFEwNWp4NnVYMis4dm8xenhUVW9sbzUwMjFod2dZQmIwM1p6?=
 =?utf-8?B?RFNIVkMyS0oyTmJtTWNTQ1dWNnRmQk9LZ2IySnRVTnREYStnUTlEVTJmbFho?=
 =?utf-8?B?U2RTU1dwM1VTWnozSnBZMGNIVHBKUUtZRnJab2QxRTRLVXRXVUhKbHFxWHA1?=
 =?utf-8?B?dkM4NFJ5SzF0K2tobzNWbTNLOHJoMDNvbi9WWFlNenhWK0YzK2JtZlRyajRU?=
 =?utf-8?B?TEZhSWQwYVJHalNTZjU0OWc0NFhQekhpWWNIT3pQM0pKWDh0UkgyeWVQUVdM?=
 =?utf-8?B?SGw2RHNjYnBFNU42QUFhSTJVOVBMVW5hZlZ5VlNjS0t0NWZPWnBXcGZkZlE4?=
 =?utf-8?B?d1dRZkczNExwNEZLMC9VUkc2SG9mcDhuZWZnSmZnTlVhR2hYOG5zUmhqNk1Q?=
 =?utf-8?B?UkI0QzVRSnQ5UDViM0VrNjNzSWkxaUladUwrRytZZ0tETGoxRzh1NmZWU1Qv?=
 =?utf-8?B?TjFzYTlUSmh5SnBTaGY4ZzFGTkF0MGl4QzNhYkRsMWNPVXFUSi9uMXBvcTVs?=
 =?utf-8?B?TkRnbHJWZVU0cVUrM0c5eUl6dUgybGhTck1YMzZoQ29TRkZkT3JtT1ZVR0VT?=
 =?utf-8?B?cEx5Rk96K2tnajRhQWgzV04rYUNtSjA4Si8rdUNMMGQ0MHppbnJvZWtSeXN6?=
 =?utf-8?B?V0ZRQ1JxcDRaZWw3YXNCZ2F3WFJmSkIrS25zMFFuZGFRRTlJd2g4L1FzaWc2?=
 =?utf-8?B?ZFBpU1p4RXhaRVM4UHlvQjI3ZHJZeW02L3Vib0JnQW5kZWt3ZUNjZlRXVlla?=
 =?utf-8?B?KzNEcjVhaisxZmg4RGs2OVVORDV1cDZmVzZLQmFhM29KUDE3VFlpbGZlVVVJ?=
 =?utf-8?B?dmxJTTJEVXNJOFVvelFaU05hZ25xQXRnK0NuRFR6eVVHYTB1OVYzdWllaGoz?=
 =?utf-8?B?L0wvNlZyZnRDQWVqM1oyblBmOXFxODBDOXB3Q3dmR1lwTDRxRWwrakxuM0lM?=
 =?utf-8?B?K0R4OWk2cXFrd3dEMklTcEIybFBaTEtwTzRXTWcwM2Y5ZFJvRFRuOTJCcm03?=
 =?utf-8?B?OENDTWNJZnBlMmpDNkZnS2dvWm5BZnNyT3RUTlJ0RzFsUkFGbDlraEFISHQ3?=
 =?utf-8?B?cDVWZ0NGQTJzaXd1WEVOVGNTaDZtTUNZc2FuVDZFYjViQTZDVDdOQlJRMkFI?=
 =?utf-8?B?QThIK3VRbzdMRVdNWnlLSWxib3kxclpJdWZEbzV1dlg1ek5hVEJLUUsxYXQ1?=
 =?utf-8?B?L0hZVk12bldRZ1ZiaUZqRVRUaVZyZzRRTXgwVUE0Ny9JMWlzTzk5UmUrT2ZG?=
 =?utf-8?B?YmN5dGk5aEU1RlhMU2VrNno3UWl4ZkpoUkZ5ZFNLN1BkejB1Ym9JbEpDYWpN?=
 =?utf-8?B?ZHhHTUhBLzJCV2xibTE1UGJNSVUwemYwUDBWd1dzL1lxRW9VQXIrMkgreDN2?=
 =?utf-8?Q?RlU52O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGwzVFNnMVBRQTErZHV5b21NcWkwZ2taeTkvZ2hOVkUrNXNIUFRLQTNHYlRq?=
 =?utf-8?B?Y1BBdjUwejd0aHU4ME9NRlZNQXR4WmtEMUVXdjBoaXNjRzFrL1dmOEMvSUVm?=
 =?utf-8?B?cU92U0hFU3JQRGtFWjZiK083bFFlSEVLTnJXU0ljYktBK3Z5dURYNWNTdlFn?=
 =?utf-8?B?ay95QTVNNlRTSjB2M0t6VWx0Zlc4L1JkMjhRU2pYUjhkSjZQazlqOFdJdjJh?=
 =?utf-8?B?VUxlWUxxVHZzVWlKTHJYTGk0WjMxSUo2aXNCVDJLTUt2RGp6elNVUXF1U2tu?=
 =?utf-8?B?emcwRGpGNDZTcEdlQ1JLTEZIVTlpYjJ1TGVqVkV6UDhWdzM5aGtXSitrSHhU?=
 =?utf-8?B?Z2p2NHdtWUJqS0VjdS9QN1lLb0hmTHlOSUVia1ZYbGplb0FsRkY2M001L2l6?=
 =?utf-8?B?bWF3RTZET3kzRG5xaTVBMk9UQ0lsUlB2aVB5dDJUdTZUQitRcVhyekpNTnIz?=
 =?utf-8?B?NlFSTVlCdmFOMjlYb0dFUDMvU3NTRG1TZXBielR3NGxreGR0clhZd0FRR2NZ?=
 =?utf-8?B?U2p4L2NBaFRPRHcwZFdzQ3V1MllHM2lYUFA5enBld0VTVGpOUW8zT0d5N1lB?=
 =?utf-8?B?cndMQTJ2WmtoTzZLSXJCNjhVQVM3KzF4RElBZFhINXB3VUpDdUtNWHRYVTNC?=
 =?utf-8?B?YWM3OHBCWHJtUzJsLzl1SkZsN3VTY09mamJnbEU1cDlHMkVXMkd0OVFndWhB?=
 =?utf-8?B?Mk1SQTZZWWFyajBYdUtDWVJWcDZXRjg3N3FUNllNTjFsNlRSUWQ0dzdhNmY0?=
 =?utf-8?B?dHl6RTYvc2dSams5THl2QXZYWFpSeStWVy80NU1XWUErT2gyT2F3dUwrTGtv?=
 =?utf-8?B?aktDSWpEU1pOcW1jZWx2ZWJZZ0ZMbGhWVXhqODBvOUxvNXo3U0syYWwxUjUz?=
 =?utf-8?B?cmVtWjY0ckQvdjZWNUVodTJ2ellUK2xxN2JpTHlwZzkwZUhYUklRK3FaN0dS?=
 =?utf-8?B?M3hySVJub1czci8vQkUwOHZ1TjlxSnY3WFd1ZTNnL21ESVI1S3g2VW4wTU1m?=
 =?utf-8?B?eThGR0ZXNEFxY2c0OHZCUXJ1QXBkVTFRdmU4OXZWZDNuYjJNamNMOW9MTmFG?=
 =?utf-8?B?dHVKbU02ZU1DdkQyalkzS1VmQU80bW9iUlhCN2p2d0FTOFRFcFRoMG9qR0lN?=
 =?utf-8?B?K3BhQU02MnRXMm9hY3FHcXZZd1I1UUp6UXptc0E1eWR0UjBxNU80STJmK2Fl?=
 =?utf-8?B?RFU3VVpncHIvU3ZoWW5ZL2E3bnFMMTRFRUYxRjFGMFl4dFlhUy95N2xkQUNH?=
 =?utf-8?B?TzNaUDdiQkJQYy9sUy9yTm8wUEd0YXpBa1hpUDNnenF6RUZNeEh3OEh0Ky9t?=
 =?utf-8?B?ck5pYmM2U0tiZytHTXpidnpyOFRSSTIxR3Vrd3RUUEVVVFNGQW1wM2M2VmNK?=
 =?utf-8?B?RDJUYldybHFRSEQrVVh6Nm1UTHZxb1pxRnFnd2JFb294aEEyTFlyK3ZpWE9B?=
 =?utf-8?B?NTlBNDVTS3hHdHlMbTBZU2svc1JTOUlmdEt0ZTdLN0hBeFhaTmUrcVhxekd6?=
 =?utf-8?B?RUtRYUt4TzZlczdxcHpSbnl0dHIrbVpDa01Vd0pJSlZSL3hFV0JnUmtPRDJR?=
 =?utf-8?B?RWhZTG1uMXN6Nmo2SkdSMDJHOHJxMGZMbktQYy9rMlBRVXJvQk1UNkF1ek5M?=
 =?utf-8?B?RENIakZ2K2tuMFhqMmNBTE85QXJGWTArekc5aHNiTHhhKzFFbzE4WmZUN3lC?=
 =?utf-8?B?Z2NlSHN3aTdsUEhSZ0duQ2lFTFB1WXZjZXFvOGsvLzJjbFhiNnNySGk5NkJ0?=
 =?utf-8?B?MVpBQmZYS1Ivakxucm03NTBtNFJ5ZVBRTTVpc1k0WW1EZlVDUVFhbGRGbHpJ?=
 =?utf-8?B?Q2ozOGNOTWt5YmUwTUdIeDZDV3BzM1U5TlM2WWMvdFk3QzdtMWNjVXE3VnV2?=
 =?utf-8?B?cjd2Q1hiamdubCtNRkR4cEwxZE42WjdJdzhveDNNMk1IeEd3SWZyVkVCTjdY?=
 =?utf-8?B?aWZFZlV0UHJ0OTdsMDNDeUtIaklsd3pkTE1vQlk2czZnOE5FT2xRS3pBUTZZ?=
 =?utf-8?B?aS9IRjVCQ0JBcndEMzJjR2pQTjhpVDRXMVJnWm1PRHZ1cHFlZHEraS9nWENy?=
 =?utf-8?B?SU8yUDNTV095WWZsOGtPc3M1ZyttcHdKamZnOER6SzB6bng2WjBGeTgzVHdw?=
 =?utf-8?Q?JJqI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8fa47b-cd08-4985-c0ed-08de0fe0024f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 13:53:11.8505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+0cLTs+KQgsKehGF3HdG6QFk9kbQnQA7T3d40vYXvpATncF1HgAvoH0+KubGUFS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTgsIDIwMjUgODozOSBB
TQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENjOiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz47DQo+IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsg
UGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6
eXRvci5jb20+OyBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPjsgQm9yaXMgT3N0cm92
c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDEvNTZdIERvY3VtZW50YXRpb24v
YWRtaW4tZ3VpZGU6IEFkZCBkb2N1bWVudGF0aW9uDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2Fn
ZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24N
Cj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGlu
Zy4NCj4NCj4NCj4gT24gTW9uLCBPY3QgMTMsIDIwMjUgYXQgMDk6MzM6NDlBTSAtMDUwMCwgRGF2
aWQgS2FwbGFuIHdyb3RlOg0KPiA+ICtNb3ZlIFBvbGljeSBUbyBVc2Vyc3BhY2UNCj4gPiArXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eDQo+ID4gKw0KPiA+ICtNaXRpZ2F0aW9uIGNob2ljZXMgYXJl
IHJlbGF0ZWQgdG8gdGhlIHNlY3VyaXR5IHBvbGljeSBhbmQgcG9zdHVyZSBvZiB0aGUgc3lzdGVt
Lg0KPiA+ICtNb3N0IG1pdGlnYXRpb25zIGFyZSBvbmx5IG5lY2Vzc2FyeSBvbiBzaGFyZWQsIG11
bHRpLXVzZXIgc3lzdGVtcyBpZiB1bnRydXN0ZWQNCj4gPiArY29kZSBtYXkgYmUgcnVuIG9uIHRo
ZSBzeXN0ZW0sIHN1Y2ggYXMgdGhyb3VnaCB1bnRydXN0ZWQgdXNlcnNwYWNlIG9yDQo+IHVudHJ1
c3RlZA0KPiA+ICt2aXJ0dWFsIG1hY2hpbmVzLiAgVGhlIGtlcm5lbCBtYXkgbm90IGtub3cgaG93
IHRoZSBzeXN0ZW0gd2lsbCBiZSB1c2VkIG9uDQo+IGJvb3QsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5e
Xl5eXl5eXl4NCj4NCj4gImFmdGVyIGl0IGhhcyBiZWVuIGJvb3RlZCIgSSdkIHNheS4NCg0KQWNr
DQoNCj4NCj4gPiArYW5kIHRoZXJlZm9yZSBtdXN0IGFkb3B0IGEgc3Ryb25nIHNlY3VyaXR5IHBv
c3R1cmUgZm9yIHNhZmV0eS4NCj4gPiArDQo+ID4gK1dpdGggZHluYW1pYyBtaXRpZ2F0aW9ucywg
dXNlcnNwYWNlIGNhbiByZS1zZWxlY3QgbWl0aWdhdGlvbnMgb25jZSB0aGUgbmVlZHMgb2YNCj4g
PiArdGhlIHN5c3RlbSBjYW4gYmUgZGV0ZXJtaW5lZCBhbmQgbW9yZSBwb2xpY3kgaW5mb3JtYXRp
b24gaXMgYXZhaWxhYmxlLg0KPiA+ICsNCj4gPiArTWl0aWdhdGlvbiBUZXN0aW5nDQo+ID4gK15e
Xl5eXl5eXl5eXl5eXl5eXg0KPiA+ICsNCj4gPiArRHluYW1pYyBtaXRpZ2F0aW9uIHN1cHBvcnQg
bWFrZXMgaXQgZWFzeSB0byB0b2dnbGUgaW5kaXZpZHVhbCBtaXRpZ2F0aW9ucyBvcg0KPiA+ICtj
aG9vc2UgYmV0d2VlbiBkaWZmZXJlbnQgbWl0aWdhdGlvbiBvcHRpb25zIHdpdGhvdXQgdGhlIGV4
cGVuc2Ugb2YgYSByZWJvb3Qgb3INCj4gPiAra2V4ZWMuICBUaGlzIG1heSBiZSB1c2VmdWwgd2hl
biBldmFsdWF0aW5nIHRoZSBwZXJmb3JtYW5jZSBvZiB2YXJpb3VzDQo+ID4gK21pdGlnYXRpb24g
b3B0aW9ucy4gIEl0IGNhbiBhbHNvIGJlIHVzZWZ1bCBmb3IgcGVyZm9ybWluZyBidWcgZml4ZXMg
d2l0aG91dCBhDQo+DQo+ICJmb3IgZml4aW5nIGJ1Z3MgaW4gdGhlIG1pdGlnYXRpb25zIHRoZW1z
ZWx2ZXMiIC0gc2ltcGxlcg0KPg0KPiA+ICtyZWJvb3QsIGluIGNhc2UgYSBwYXJ0aWN1bGFyIG1p
dGlnYXRpb24gaXMgdW5kZXNpcmVkIG9yIGJ1Z2d5Lg0KPg0KDQpBY2suICBBbHRob3VnaCB0byBi
ZSBjbGVhciwgYWxsIGl0IGNhbiBkbyBpcyBzZWxlY3QgYSBkaWZmZXJlbnQgbWl0aWdhdGlvbi4g
IEZvciBpbnN0YW5jZSwgaWYgdGhlcmUgd2FzIGEgYnVnIGluIHNhZmUtUkVULCBpdCBjYW4ndCBm
aXggdGhhdCBidWcuICBCdXQgaXQgY291bGQgYWxsb3cgc2VsZWN0aW5nIGEgZGlmZmVyZW50IFNS
U08gbWl0aWdhdGlvbi4NCg0KVGhhbmtzDQotLURhdmlkIEthcGxhbg0K

