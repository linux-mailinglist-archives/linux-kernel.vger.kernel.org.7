Return-Path: <linux-kernel+bounces-885165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE4C32284
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E69018C0A56
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C93337BB0;
	Tue,  4 Nov 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aOq7rO7e"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00BB33710D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275288; cv=fail; b=YQHEyChaCb4AbKWvFIiVohmuC91PcAsdX+/+XYdkBNCf3D/WlJr7GX14DP2SMoVGuufAtrnvw0/a/AWdZPaFGU9lvGwFbE0Xstpn5C0ejwpaCFn9QVWiEw93yQ9rucZeWMbjCkBdC3UD+BZ8gKy0srXuIIitTXcEKWLHmBbHSGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275288; c=relaxed/simple;
	bh=01jSwjcRV9ZY/YwegS3RVSeMG0PlnJuBuKJnPlwLZ9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cd1O7xNrIhpOAzJjhc78kVkN/SvhukLHtJoSdOhocrFCtFm4Zbx8Hz2gNDqA73jOvJuBQ4fKRFyXgcLzfgKBMcPcg3raV3W8SSd7hINPAhpGC2R3a5C9uKvSV4FyRXSVDqgsN55PBpe6qemPOWus9Ce8hdpxM0RinJR/aNyL8LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aOq7rO7e; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBOgBMlDZqOY3YT8+SFR4rynNynERfiHbP3ieqosoajr3yef6gp/KfMle2DgwElpmd/gXoIuznKDZknwPLQBMVCWfJ58SiyJ608C+36iODcUYK/fC7rU265zyK6B8ANwjUPMEVi7qpejw9JM+T0iAsEJ9DmS/kBLw12U91tQZ0Sd/WQHE6FZiYyf1eVc9/Xp59IJ6aJbP24WU5kH1508Dc1tXbOppWYI4cDEj+ijOtWpOkoMcq1oCeI71wiH7Y/9cpBN2GO51Q5Vqc70n6IOH6m9m4YewqnlcMIhyQpdChm7bvDvFnNYkSN89b7YTS3ZKHOE9JhPHluVyo3Y3tQHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01jSwjcRV9ZY/YwegS3RVSeMG0PlnJuBuKJnPlwLZ9s=;
 b=dvZiZM1HSfIIp8wpio82XUSmEEd42SFUR5ebJgAYuIU19HprWXecCN+8aNmOeTYWUspdzfDmu9ZNEjN+jyWF8jKLEC9Gl8TLGYGIcVCrYBqExvWWcIago7EWEWvGMlCdDrXgArZihKh6BWvxmbnfshXOO0535crOoDZ32i5Bcf62ga+QQW3sCUrwcUz3w2SmWNITm2cMeJidqGVwEx1iiLjnosvZs61N8DRHjYDQvFaQWdwkfenAyNgpkuE+PV3DlONLLwlNAmsafUriMZDhuAKl737+PmU7DFfWgtD9npyPYEoPTX76w1gtu9V/tmEa8BBuM1ABG+2Q3pYDslfcBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01jSwjcRV9ZY/YwegS3RVSeMG0PlnJuBuKJnPlwLZ9s=;
 b=aOq7rO7emgXicp3dbbEgU0RlXH5ehWEFqAdyxWNOuQTdgUMCH077FyBOPZsad/cyq5mYHqMhtJFf3pomOWkZ9M3UU9jSLG2Zbfk2W5Y1fZfvCDEU7SPCgbTjlPx3+Y+OsP2jekNQ5My4Tmy9wssAkvMNKgppaFixiliFtMcWMpo=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 16:54:43 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 16:54:43 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 50/56] x86/alternative: Add re-patch support
Thread-Topic: [RFC PATCH 50/56] x86/alternative: Add re-patch support
Thread-Index: AQHcSlBZYXuGYGoE4UmU6Q4N+2GkBrTiwjnA
Date: Tue, 4 Nov 2025 16:54:43 +0000
Message-ID:
 <LV3PR12MB92652373139858D54C5D538C94C4A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-51-david.kaplan@amd.com>
 <d255d8a9-8e45-485e-9853-80c343bbb73b@suse.com>
In-Reply-To: <d255d8a9-8e45-485e-9853-80c343bbb73b@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-04T16:52:38.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS0PR12MB6605:EE_
x-ms-office365-filtering-correlation-id: af052c29-7b6d-4288-309a-08de1bc2da84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzhVSS9GajF0MmVsaFdGbXkvc252TUhnY2RsZEdYeGJsZVBlYWZJSUx3clMv?=
 =?utf-8?B?WGZBWVlXRTZEVm0vNFE0QS9pRHNPTEdGTE02OGozUG1aS0hnMkdnNjE4MUlN?=
 =?utf-8?B?STlZckpVZjZob2FNTmoxV0FVci9ubXc0d1dqQkRRZjVrVGZoaEVibEFVK0tD?=
 =?utf-8?B?bHJObkpweGhSL1pLQU02eFhRTGVRSFpZQUxMM1pxRHZqNk1WREFEcER3TTJB?=
 =?utf-8?B?cVhaZXRuNG5TNFlIdFRNWGZLelVhNWJzYWZXSHkrTGlSYTBQZHdFeU1QZnEz?=
 =?utf-8?B?VU9yVmdqYmNzaVFvOW1VdXdOSnBMaDhOUmRla1FMOS9kNTc2RmJQeG42YTB3?=
 =?utf-8?B?TGJua2pVR3J3ZkprR1h4M3JScXhJaHNGTGtObkVZS3ByZ3FHbkV3cXZKQkJJ?=
 =?utf-8?B?WlF6T1VIMUtLaGVLTFRTQ2FFNjVmYlh5NjFXWUQyMTZmK21VMzgvWWNNc2Qy?=
 =?utf-8?B?cVplWWxMLzJSalFXY0ZoaE9sT3JuMmNPSEhBS1M4MlM3QzF5bE16N0NWZTBi?=
 =?utf-8?B?RVZ6UE4vcHAxN1VUUGxDU24vTmNrMGRYTVllMHMweWJNY0pPMjNQZFZzTitK?=
 =?utf-8?B?dnE2OU9nM3pLNHJac3RIK0pLRk43enJqK1plRFJqZ1MxeS85Vnc5N2xZUHJY?=
 =?utf-8?B?eFBiTDFnWTU2SWFRa3BrL3pQb1hxQlhyVzJWWDBwbHl3NGg5VVZ6eWd2YVda?=
 =?utf-8?B?Z1RNMlI1aGczNldaR05yM1l5enJHK0p3MzlkRFNTeEd3OVYwdE83b2xiQnRN?=
 =?utf-8?B?SXBubWJSNVpRUUNIZGc2VGZKaFAzYTd1c2hYaGhyQnI4b1FxNlhyOW5nU3FR?=
 =?utf-8?B?b0JnZmVxNkxhRGV1MTdTTG5DV054a2JyMktCbGJsWVlEei8zQWVYV0ZlMm9H?=
 =?utf-8?B?MjhNYVA4RzhKVWRZWm05ZXRuUmVCMXdpYmxSWlpEeExmZXJZWGh5S1FPcEV0?=
 =?utf-8?B?eFh4SDFWSlNkcTFuV0I2UjB2SUZUamZ2Q3JDSTV4SjFNM2RuY3FaUk1vaFVp?=
 =?utf-8?B?T0tGUWgyWlJLNTBPYzd0c2dqd1NLNjRyTW96cUo2eTBjWHlNNlhIS1E3VzNl?=
 =?utf-8?B?VVVNbzRCNXdaT3JPY3lBVTZ5NWluWnhkcjgvTlV0S2ZzWS9KOUxIcGJ6akdX?=
 =?utf-8?B?OERvTDNVRkt3TmdNWmtwZGhSU2pUZkJzSG9pWEk3aFZ4b0JmbFh6N0ZNZmha?=
 =?utf-8?B?cmFNSFY0cHc3bDJ0bHZnenZwY0cvVE1NN3I3dVVQeC9WT0VaZ2habEZlTzB1?=
 =?utf-8?B?RXZENDhoQWRoeDZrTEJPZSt6cVFvQjVBcERMMzJGN0Vwa1NsQW1heDl6Q0tv?=
 =?utf-8?B?ZGQ2U0VwaWtNUFVuOWFIWlpJNkVhTnU5UVJhdVByYVJZU2MyRzh0dVhOWEt1?=
 =?utf-8?B?YTF3c3VzVW1aTzlTYkNIQXlLVkRDVllwcHArWElWOEMwOGt3WHNNRGptV044?=
 =?utf-8?B?RHZxSEVRaS9jRndQV2YreTVLdWJNQ1owWnh0WW9kU3BmbHpDeUVoY3hHZmdK?=
 =?utf-8?B?V2tFTEUwWmdUeCtOcElPWS9pQnR0YWNpY1RZUmhXeE5rUEV6UHlWQXZ5K3g0?=
 =?utf-8?B?dWt2RS9DL1poOGQxcUkyUFJlZU1xa09zZjBtYlRuSlFZZmR1cGFvUjV5aCtY?=
 =?utf-8?B?NjkrcjlhSXVBNWx6RUdXUDA0YmNjbGJ2WGFDVTJza3gzQXNtczhHdFdmZVhm?=
 =?utf-8?B?Tm9xVFFmcVBxR0xuaUZNeDJMN3ExMWxhRUFkUTcyV1BRbTFUZFVuZW1JSCtZ?=
 =?utf-8?B?QzNsREU3aUtTYmJLWSsxUnI5YlRyZG9YSGZXVzNGUTB3ZnlBSm5PbTZQMGw4?=
 =?utf-8?B?aGszMmRZT3ZEdWE0cTJTSmhQM1JxS3IvY1hWZDBBekZGdEFleHF4Zmt6R2hO?=
 =?utf-8?B?RDZIbGVmSzIwWEh0UVJ6cDJJeDY3eXFhUk1mdW42RTlMMk9PZUdmdjI1bkNK?=
 =?utf-8?B?ZlFwd3p0ZFpvTTIwVW9GdjhTdFlrQm4yOVIvd2V2Z1ZPTmtUKzFOTFdKSTVn?=
 =?utf-8?B?bVNrVCthRU1peTlWemZmQ201N29BSFhPeXdBSUJVZnA0TER4NG5ZSGJSQ1ZG?=
 =?utf-8?B?TE5rV1RabC81MlRWbVlNYk1ucUwrMWxrN0pXdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFVkMzlMT1M2T3BXN1lCaFBYa3R3MFM1LzVNYmVpcUFGUHRKTXBtSENQbjF1?=
 =?utf-8?B?OEZ1eEFSV2lnbHl4S1J6WDN4TzVUSkNNQkpCbUhxUFJYTXRxcytZcTZZcWtn?=
 =?utf-8?B?T1hWWWxDQmsvZExJNE00bHM2S0lzMWd4Q3o2Mks1TzErWVI4M1ovYkpPSENG?=
 =?utf-8?B?Ty9PWDlvU1I0YXFJY1F2R2QxSEM2Ny9NMFpNUlNCMjdCM0FjcXNxUXhaNmZN?=
 =?utf-8?B?ZnNpdDFLM0lUT0JHU0JIRG53bnJDdHk2c2FLTEN2VXhmMXlBYUhLQ1ptKzVa?=
 =?utf-8?B?YlhXbDNNT0Flb0FER2lVMkVrMStGR3RGSGNCV0ltdHJPMU1JalJLNXU0NmMv?=
 =?utf-8?B?VUVTellrRGUyeFJMTUJJWDBBci9PblBxWk92ZHlpK1g3Y2t6M1ExY2Y2T2NH?=
 =?utf-8?B?T1ptMnVzVkRaQmxmeVRWOEpWRnhCY2cvajZ3ZUl2djRNQnpDdTNNVkNCdENo?=
 =?utf-8?B?a1M5SEhlaGVoSnRsZGVzVDRrWEIrL3d4WFFVMXo3aGJjZWFnNmJIMlZzWHNE?=
 =?utf-8?B?bS94Rlp6U1c5OUp1TEF0RWpiVTZmaEM2cmJMcDZzVERJQXVRK3ErNjBrUjJS?=
 =?utf-8?B?dnlNWllZVjJZUEFGdU1LM1JPcjNJZlJqVDk4R3BCWHNxcjh6QnREYlUzai9u?=
 =?utf-8?B?ZDl5cjI4VE50ZU80WTk1UytPOTJNTVI5WHBMMW5FQVk1eWEyS2hMdGFTR1lq?=
 =?utf-8?B?MThyekdCVFY2MHRVc3lkU0VNTGVGV1hPaHRqcTkvUGpYZWh1bEdUS2FKQlZ5?=
 =?utf-8?B?bHRZQ1RZditmSFM5QlF5SElYaDhzNWh6TmNDYldvVjdDMmZvZkFKSWh3R20r?=
 =?utf-8?B?WmJTT0d3aHlZOWc3VkUrNS95MTMzM2dqT1lqVTR6M1NNeVE4WFJLelhUaXhL?=
 =?utf-8?B?UEtxbjN0N2VnNkhhS0lXNjhxMXNHankrRUE2eUMyc3lrRVVaRk1zbjlTN1M4?=
 =?utf-8?B?eC9rN3ZCaC9rNVZ1ZE9VNnc5WHY1azFNd1JCMnI0cnI2d0h2TzkyaytPTFd2?=
 =?utf-8?B?emx4NGF6cFRDcXpoa1YzTGlwK2Q1d0VQSGhnT2l0K3ZuOC9TMzB2dklJaWhQ?=
 =?utf-8?B?a2pnUkZOelBLaTRRa1V4VFdISmRGZ05qMkZ6UUVMK1NuUEo5dEp0UFJVTTNn?=
 =?utf-8?B?ZGgrZHFxNEc5NnYwNkFTT1g2cEdaRjVBM3hybERIcVZRQVc0SjNXMno5U1g4?=
 =?utf-8?B?TVdCajBwVnBIcjhrOXVBMnhtckl4cXFEQmhkelB3RlU2ZjVRajlsSHZnbEtC?=
 =?utf-8?B?WWRYZk9EdjBLOFBkWlQ3OGRVWDNnTjhFUkx2S2taRkFQeUZ1b1gybnJubGNG?=
 =?utf-8?B?NVlBZzlvRkp3dnlTU0JxYndrT21FenJYUXdRdDFUVi9HNnhkTkh0WTFSanJQ?=
 =?utf-8?B?aFUxWFVNeURtQVIxbExYUFZYdkdXS0VPRG5xYTBYNTVWWE5CRXFUdll2dHZG?=
 =?utf-8?B?VE9OSjg3amVjakxzUnRXbE1na1FFOU1na2UrMFk2YmJ4dHpTdWQvaTlsYWlt?=
 =?utf-8?B?MWdXWmhXeW1iS3RaYXBCMTRSM1FYSHFpZ3NMSEtiMGpLNzhRVE9vc1pNYmdR?=
 =?utf-8?B?UjdKbUFnUmdpUm96dUYvVnBvWmhBMkgyR3UrU1k4bWtTcjQ0cmh1R1pERkd0?=
 =?utf-8?B?YlQxQ1BnWUk2VlBPWE5xT1hCbEdhaENGV3FYdDhTVExFNjZFZHFPN3V5STl2?=
 =?utf-8?B?ZWM3MFhzYzVLdnB4UGpuV2Vsa2Q3ZXhpNXd2LzJsZmprbVFldTJoT0VvWm82?=
 =?utf-8?B?eS9DUy9PSHBTSElDR3pBdW5Qa25iOTZiSGdUcU4wQVoyWHN3SExsQlg4T2dQ?=
 =?utf-8?B?bnpsSmZvLzRQTVlYcDJoL0lGL3BxMFd0a3E3Q2xQa1dEOWNmeXJFNWVCNFhk?=
 =?utf-8?B?MHJRRFRhWjZaT0RsNENyWFpJVHJJR1o1OS9EeTUvay9EaitjSTdaMC9PL0Vr?=
 =?utf-8?B?aXBMS3BkRk82UmZWUW9hczkvNzFTazdEY1hKcFA0OHROOHlTT3o0L042L1ht?=
 =?utf-8?B?RG1LaHZESW9wenU4WTdOdUtLdGxXT0pLMGNISGlrcVV4N0FyTUp1YlVLajU5?=
 =?utf-8?B?dHBuWkVlZm80NmFQVFc3b2l6bmFCSmlmNEgweVlVQXR5aGQ0eFg0RVBLbGVr?=
 =?utf-8?Q?p2EA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af052c29-7b6d-4288-309a-08de1bc2da84
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 16:54:43.5632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFWQdrR8DaXGWjnEXRdrXOKEaESl2cJgouL5VEsZzv6sNsRkDws48FQT4wuZluo0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEJvcmlzb3Yg
PG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMzEsIDIwMjUg
NToyMyBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+OyBUaG9t
YXMgR2xlaXhuZXINCj4gPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8YnBA
YWxpZW44LmRlPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9z
aCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBQYXdhbg0KPiBHdXB0YSA8cGF3YW4u
a3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhh
dC5jb20+OyBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsNCj4geDg2
QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4NCj4gQ2M6IEFsZXhh
bmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+OyBCb3JpcyBPc3Ryb3Zza3kNCj4gPGJvcmlzLm9z
dHJvdnNreUBvcmFjbGUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1JGQyBQQVRDSCA1MC81Nl0geDg2L2FsdGVybmF0aXZlOiBBZGQgcmUtcGF0Y2gg
c3VwcG9ydA0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4
dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2ht
ZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIDEwLzEzLzI1
IDE3OjM0LCBEYXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4gVXBkYXRpbmcgYWx0ZXJuYXRpdmVzIGlz
IGRvbmUgdW5kZXIgdGhlIGJpZ2dlc3QgaGFtbWVycyBwb3NzaWJsZS4gIFRoZQ0KPiA+IGZyZWV6
ZXIgaXMgdXNlZCB0byBmcmVlemUgYWxsIHByb2Nlc3NlcyBhbmQga2VybmVsIHRocmVhZHMgYXQg
c2FmZQ0KPiA+IHBvaW50cyB0byBlbnN1cmUgdGhleSBhcmUgbm90IGluIHRoZSBtaWRkbGUgb2Yg
YSBzZXF1ZW5jZSB3ZSdyZSBhYm91dCB0bw0KPiA+IHBhdGNoLiAgVGhlbiBzdG9wX21hY2hpbmVf
bm1pKCkgc3luY2hyb25pemVzIGFsbCBDUFVzIGFuZCBwdXRzIHRoZW0gaW50bw0KPiA+IGEgdGln
aHQgc3BpbiBsb29wIHdoaWxlIHJlLXBhdGNoaW5nIG9jY3Vycy4gIFRoZSBhY3R1YWwgcGF0Y2hp
bmcgaXMgZG9uZQ0KPiA+IHVzaW5nIHNpbXBsZSBtZW1jcHksIGp1c3QgbGlrZSBkdXJpbmcgYm9v
dC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEthcGxhbiA8ZGF2aWQua2FwbGFuQGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9hbHRlcm5hdGl2ZS5o
IHwgICA2ICsrDQo+ID4gICBhcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYyAgICAgIHwgMTMx
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDEzNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vYWx0ZXJuYXRpdmUuaA0KPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FsdGVybmF0aXZl
LmgNCj4gPiBpbmRleCA2MWNlOGE0YjFhYTYuLmYwYjg2MzI5MmMzYyAxMDA2NDQNCj4gPiAtLS0g
YS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9hbHRlcm5hdGl2ZS5oDQo+ID4gKysrIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20vYWx0ZXJuYXRpdmUuaA0KPiA+IEBAIC0xOSw2ICsxOSw3IEBADQo+ID4gICAj
aWZuZGVmIF9fQVNTRU1CTEVSX18NCj4gPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3N0ZGRlZi5o
Pg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc3RhdGljX2NhbGxfdHlwZXMuaD4NCj4gPg0KPiA+ICAg
LyoNCj4gPiAgICAqIEFsdGVybmF0aXZlIGlubGluZSBhc3NlbWJseSBmb3IgU01QLg0KPiA+IEBA
IC04OSw2ICs5MCw5IEBAIGV4dGVybiBzMzIgX19jZmlfc2l0ZXNbXSwgICBfX2NmaV9zaXRlc19l
bmRbXTsNCj4gPiAgIGV4dGVybiBzMzIgX19pYnRfZW5kYnJfc2VhbFtdLCAgICAgIF9faWJ0X2Vu
ZGJyX3NlYWxfZW5kW107DQo+ID4gICBleHRlcm4gczMyIF9fc21wX2xvY2tzW10sICAgX19zbXBf
bG9ja3NfZW5kW107DQo+ID4NCj4gPiArZXh0ZXJuIHN0cnVjdCBzdGF0aWNfY2FsbF9zaXRlIF9f
c3RhcnRfc3RhdGljX2NhbGxfc2l0ZXNbXSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF9fc3RvcF9zdGF0aWNfY2FsbF9zaXRlc1tdOw0KPiA+ICsNCj4gPiAgIC8qDQo+ID4gICAg
KiBEZWJ1ZyBmbGFnIHRoYXQgY2FuIGJlIHRlc3RlZCB0byBzZWUgd2hldGhlciBhbHRlcm5hdGl2
ZQ0KPiA+ICAgICogaW5zdHJ1Y3Rpb25zIHdlcmUgcGF0Y2hlZCBpbiBhbHJlYWR5Og0KPiA+IEBA
IC05OCw2ICsxMDIsOCBAQCBleHRlcm4gaW50IGFsdGVybmF0aXZlc19wYXRjaGVkOw0KPiA+ICAg
c3RydWN0IG1vZHVsZTsNCj4gPg0KPiA+ICAgI2lmZGVmIENPTkZJR19EWU5BTUlDX01JVElHQVRJ
T05TDQo+ID4gK2V4dGVybiB2b2lkIGNwdV91cGRhdGVfYWx0ZXJuYXRpdmVzKHZvaWQpOw0KPiA+
ICtleHRlcm4gdm9pZCBjcHVfcHJlcGFyZV9yZXBhdGNoX2FsdGVybmF0aXZlcyh2b2lkKTsNCj4g
PiAgIGV4dGVybiB2b2lkIHJlc2V0X3JldHBvbGluZXMoczMyICpzdGFydCwgczMyICplbmQsIHN0
cnVjdCBtb2R1bGUgKm1vZCk7DQo+ID4gICBleHRlcm4gdm9pZCByZXNldF9yZXR1cm5zKHMzMiAq
c3RhcnQsIHMzMiAqZW5kLCBzdHJ1Y3QgbW9kdWxlICptb2QpOw0KPiA+ICAgZXh0ZXJuIHZvaWQg
cmVzZXRfYWx0ZXJuYXRpdmVzKHN0cnVjdCBhbHRfaW5zdHIgKnN0YXJ0LCBzdHJ1Y3QgYWx0X2lu
c3RyICplbmQsDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5j
IGIvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMNCj4gPiBpbmRleCAyM2JiMzM4NmVjNWUu
LjYxM2NiNjQ1YmQ5ZiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRp
dmUuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+ID4gQEAgLTYs
MTIgKzYsMTUgQEANCj4gPiAgICNpbmNsdWRlIDxsaW51eC92bWFsbG9jLmg+DQo+ID4gICAjaW5j
bHVkZSA8bGludXgvbWVtb3J5Lmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvZXhlY21lbS5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvc3RvcF9tYWNoaW5lLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9mcmVlemVyLmg+DQo+ID4NCj4gPiAgICNpbmNsdWRlIDxhc20vdGV4dC1wYXRjaGluZy5oPg0K
PiA+ICAgI2luY2x1ZGUgPGFzbS9pbnNuLmg+DQo+ID4gICAjaW5jbHVkZSA8YXNtL2lidC5oPg0K
PiA+ICAgI2luY2x1ZGUgPGFzbS9zZXRfbWVtb3J5Lmg+DQo+ID4gICAjaW5jbHVkZSA8YXNtL25t
aS5oPg0KPiA+ICsjaW5jbHVkZSA8YXNtL2J1Z3MuaD4NCj4gPg0KPiA+ICAgaW50IF9fcmVhZF9t
b3N0bHkgYWx0ZXJuYXRpdmVzX3BhdGNoZWQ7DQo+ID4NCj4gPiBAQCAtMzQ2OCw0ICszNDcxLDEz
MiBAQCB2b2lkIGl0c19mcmVlX2FsbChzdHJ1Y3QgbW9kdWxlICptb2QpDQo+ID4gICAgICAgaXRz
X3BhZ2UgPSBOVUxMOw0KPiA+ICAgfQ0KPiA+ICAgI2VuZGlmDQo+ID4gK3N0YXRpYyBhdG9taWNf
dCB0aHJlYWRfYWNrOw0KPiA+ICsNCj4gPiArLyoNCj4gPiArICogVGhpcyBmdW5jdGlvbiBpcyBj
YWxsZWQgYnkgQUxMIG9ubGluZSBDUFVzIGJ1dCBvbmx5IENQVTAgd2lsbCBkbyB0aGUNCj4gPiAr
ICogcmUtcGF0Y2hpbmcuICBJdCBpcyBpbXBvcnRhbnQgdGhhdCBhbGwgb3RoZXIgY29yZXMgc3Bp
biBpbiB0aGUgdGlnaHQgbG9vcA0KPiA+ICsgKiBiZWxvdyAoYW5kIG5vdCBpbiBtdWx0aV9jcHVf
c3RvcCkgYmVjYXVzZSB0aGV5IGNhbm5vdCBzYWZlbHkgZG8gcmV0dXJuDQo+ID4gKyAqIGluc3Ry
dWN0aW9ucyB3aGlsZSByZXR1cm5zIGFyZSBiZWluZyBwYXRjaGVkLiAgVGhlcmVmb3JlLCBzcGlu
IHRoZW0gaGVyZQ0KPiA+ICsgKiAod2l0aCBpbnRlcnJ1cHRzIGRpc2FibGVkKSB1bnRpbCBDUFUw
IGhhcyBmaW5pc2hlZCBpdHMgd29yay4NCj4gPiArICovDQo+ID4gK3N0YXRpYyBpbnQgX19jcHVf
dXBkYXRlX2FsdGVybmF0aXZlcyh2b2lkICpfX3VudXNlZCkNCj4gPiArew0KPiA+ICsgICAgIGlm
IChzbXBfcHJvY2Vzc29yX2lkKCkpIHsNCj4gPiArICAgICAgICAgICAgIGF0b21pY19kZWMoJnRo
cmVhZF9hY2spOw0KPiA+ICsgICAgICAgICAgICAgd2hpbGUgKCFSRUFEX09OQ0UoYWx0ZXJuYXRp
dmVzX3BhdGNoZWQpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBjcHVfcmVsYXgoKTsNCj4g
PiArDQo+ID4gKyAgICAgICAgICAgICBjcHVfYnVnc191cGRhdGVfc3BlY3VsYXRpb25fbXNycygp
Ow0KPiA+ICsgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICByZXBhdGNoX2luX3Byb2dy
ZXNzID0gdHJ1ZTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAvKiBXYWl0IGZvciBhbGwgY29y
ZXMgdG8gZW50ZXIgdGhpcyBmdW5jdGlvbi4gKi8NCj4gPiArICAgICAgICAgICAgIHdoaWxlIChh
dG9taWNfcmVhZCgmdGhyZWFkX2FjaykpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNwdV9y
ZWxheCgpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIC8qIFRoZXNlIG11c3QgYmUgdW4tZG9u
ZSBpbiB0aGUgb3Bwb3NpdGUgb3JkZXIgaW4gd2hpY2ggdGhleSB3ZXJlDQo+IGFwcGxpZWQuICov
DQo+ID4gKyAgICAgICAgICAgICByZXNldF9hbHRlcm5hdGl2ZXMoX19hbHRfaW5zdHJ1Y3Rpb25z
LCBfX2FsdF9pbnN0cnVjdGlvbnNfZW5kLCBOVUxMKTsNCj4gPiArICAgICAgICAgICAgIHJlc2V0
X2J1aWx0aW5fY2FsbHRodW5rcygpOw0KPiA+ICsgICAgICAgICAgICAgcmVzZXRfcmV0dXJucyhf
X3JldHVybl9zaXRlcywgX19yZXR1cm5fc2l0ZXNfZW5kLCBOVUxMKTsNCj4gPiArICAgICAgICAg
ICAgIHJlc2V0X3JldHBvbGluZXMoX19yZXRwb2xpbmVfc2l0ZXMsIF9fcmV0cG9saW5lX3NpdGVz
X2VuZCwgTlVMTCk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgYXBwbHlfcmV0cG9saW5lcyhf
X3JldHBvbGluZV9zaXRlcywgX19yZXRwb2xpbmVfc2l0ZXNfZW5kLCBOVUxMKTsNCj4gPiArICAg
ICAgICAgICAgIGFwcGx5X3JldHVybnMoX19yZXR1cm5fc2l0ZXMsIF9fcmV0dXJuX3NpdGVzX2Vu
ZCwgTlVMTCk7DQo+DQo+IFRoaXMgdHJpZ2dlcnMgdGhlIGZvbGxvd2luZyBzcGxhdDoNCj4NCj4g
WyAgMzYzLjQ2NzQ2OV0gQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlk
IGNvbnRleHQgYXQNCj4ga2VybmVsL2xvY2tpbmcvbXV0ZXguYzo1NzUNCj4gWyAgMzYzLjQ2NzQ3
Ml0gaW5fYXRvbWljKCk6IDEsIGlycXNfZGlzYWJsZWQoKTogMSwgbm9uX2Jsb2NrOiAwLCBwaWQ6
IDE4LCBuYW1lOg0KPiBtaWdyYXRpb24vMA0KPg0KPHNuaXA+DQoNCj4NCj4gVGhlIHJlYXNvbiBi
ZWluZyBhcHBseV9yZXR1cm5zLT5fX3N0YXRpY19jYWxsX2ZpeHVwIGFjcXVpcmVzIHRleHRfbXV0
ZXggZnJvbQ0KPiBOTUkgY29udGV4dC4NCj4NCg0KVGhhbmsgeW91IGZvciB0ZXN0aW5nIHRoZSBj
b2RlIGFuZCByZXBvcnRpbmcgdGhpcyEgIEkgYW0gbG9va2luZyBpbnRvIGhvdyBiZXN0IHRvIHJl
c29sdmUgdGhpcy4NCg0KLS1EYXZpZCBLYXBsYW4NCg==

