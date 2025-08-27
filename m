Return-Path: <linux-kernel+bounces-788887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E559B38BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC0816D1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30F30F819;
	Wed, 27 Aug 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lRn21bga"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2430F923
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331947; cv=fail; b=PAxgISD8Tk1cVxdUJ3rTApSOLu52aCX9kkDbt29xdk2GLn5eipEN1jtkR43jVm1cUSjYUoB2wGdLHo9BOhug7v0y/Qfk/LrzFS8DXabYsFjqFIlivfCfJ7Hv02CwjHIgTwj1fO9dQGuyL78sNkcBTA+bHnygIvULEbo0VULpsc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331947; c=relaxed/simple;
	bh=UCsGYAuVCcq+nHXFcQ/9a5GrJKdNKScEGntbiU5Fl3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZR7tl97iD78jNNwvBAm/XercrD4mvXZSPMqVW46OCBBQJcb+kLsDM5cER6GhyEkVnIByC57F7O+pJwrZlZOpULu0K+eaJ/khoKxPiSOPVblnZc5z51FAVOSqiAI2HuN3E/5fCfVdXYx/MZB7KsYK4RqdBgn60X0uLx8ELtRxhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lRn21bga; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8LUdrG+Ji3rNMYL0dG55gGAEgvXQyU43L4JKzGtwEUj+pzJAapVzzCd+xW0F51DHOXAdQW7AUChx2l6eoQE7av0lHLx+ieOCENAxjHSBdBgfAWMIscseQNIJmAB3CIGX8K5N+jE9ohhSvpyaxo/uBb55lw4nkByeiIp1Zw3uetfIVtdUGMLUVSWmHdAN5k5wQBXb0Yvyb5Ma0p+ybx9dk5YJ8M14bUXz3Jn+PA3nhE2UZOHWGUd4hl/2uI7A8mzxe+7NCk2M+42v+LQkDtTqIT2dap8AKOuLiZ8S5cu+KgoZM1LB8pIMEUJ+bvOdSoh2fPlHUDtuLdDJd1c0A/drA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCsGYAuVCcq+nHXFcQ/9a5GrJKdNKScEGntbiU5Fl3Q=;
 b=sBEY1SljGibz8WzOFIB8a6CiVkUwfpAkwV9ChxARh5R4/ZAsXY9Q+bAf/JbXVVcRost9d+KRncjTjmOdLZs4mxn0XZpXeqwR0Xvdpfhl00jC4HXyeVSTC3xgEPcE4imke0L650CaElsIvv91AcKwQ7gxJBP9QbwbTQ2mD37TMkq4307AUYi+DqVJYbvsVNzuID/jCv56lcm9Ihhbv1YAyoXwtoOkwAjEaIa1X/k4yq1np+o3m5HZrVyfN9+ll2fO7ruge78yVAv3u8yL1P/RTmefBJu22X8Zf92yR2WMP6VXr1f7mF7+Lqni6jyR2QiDU87UIo96z2VAO1xCuJFoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCsGYAuVCcq+nHXFcQ/9a5GrJKdNKScEGntbiU5Fl3Q=;
 b=lRn21bga8gCZC+pi83le0IkGfAvsgXDzea7bh6eGIFpkA/mlOWVfTnyfR76mmHtLQEE0RIL5sK3Z60amTs1EEKapgVEcvvF5ZsFHaCxiaaCeWYVl1mQGegOQy+eL72pzfC64TmHQXkZbKGvBC+pzphWFsCMB+ET/XXq7Lj7/7BE=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CY3PR12MB9579.namprd12.prod.outlook.com (2603:10b6:930:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 21:59:04 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 21:59:04 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] x86/bugs: Use early_param for spectre_v2_user
Thread-Topic: [PATCH v2 1/5] x86/bugs: Use early_param for spectre_v2_user
Thread-Index: AQHcF5zQSlfKkLm6oE6D4sHd33H60rR3CxDQ
Date: Wed, 27 Aug 2025 21:59:03 +0000
Message-ID:
 <LV3PR12MB92652AE4AC9BECE03874409B9438A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-2-david.kaplan@amd.com>
 <5de5fl7tuo5tobdlck5a7inomwecrmw5lbhtp3ldqsxem2wzfy@4sdzpuu77zqe>
In-Reply-To: <5de5fl7tuo5tobdlck5a7inomwecrmw5lbhtp3ldqsxem2wzfy@4sdzpuu77zqe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-27T21:54:21.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CY3PR12MB9579:EE_
x-ms-office365-filtering-correlation-id: 43ca58ec-eadf-46eb-fc0d-08dde5b4f009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFFsUStPUVVsMGJ2T2VkZm93aEszV0FFVVZ5M3V6Ujh4eW80VVhJY2xZTUpl?=
 =?utf-8?B?MWl0WEpQcmZyWFZQalBqSzBWQ1Zvd3F3cTNXYWYwY1FPWVRJaE5DQ1paWitF?=
 =?utf-8?B?YlIzWHBHRzBPOE1Celc5dFNxVW9XQ2cyQjZPWEtWbE9PdnNmNmt6QUlrRnNq?=
 =?utf-8?B?UERTYUdDMXQ3NmpJUHhPNFRXcUZjbXdUUXdlT3MrN0kzYnI5SjNza3hydWFB?=
 =?utf-8?B?SnF2VFJRaFpxeDloRHl5V1VXaS81Z3ZEdzJ5ZkNEQzRCYjUyRXV2ejE1TmNM?=
 =?utf-8?B?NHkyVngzVnNZWmZyR0xFUTVmQ0dHR2xMVGc0aEpLb3orejduOWZIVzdUR0Q0?=
 =?utf-8?B?UklMNHlvRHZSdnlxOUFsT1hZdlVsUnIwYXgyKy9hVTIzZjM3aHM0VVl0TUcw?=
 =?utf-8?B?MG1nRVJNUi9LV21GYTRvMEkxaEpLWEt1YXp5aHBkSFdLdUc3MkduQnE4Y0lI?=
 =?utf-8?B?Z2hxRDRBdXVqMElTVVY1TmJEbHZLaG8yZmYraFNuVUlFZkh3emVGMVFRUWY0?=
 =?utf-8?B?OU9BRVF2SHVPMk94eitCalRqVXhXSmROMGhHRStYOXkydzFCN1BjcHdmc2Z1?=
 =?utf-8?B?dGJlQ05TYUNUUGNzTjVHM3kwcVBVdjZRaWZHNGU3VU1XUGZLWFZWais1YUZw?=
 =?utf-8?B?MnZ0UmpocXY4dU5FRmdaazZsYXBmYk5IRFNjWUtnVmNLaERpdmlUcWlWR0ZK?=
 =?utf-8?B?aWd0SWwyN0d3ZjNnd0M4UW1ESXVIb0VJYnFkeENOK0xNWEdGdnY2Zk5xT1Yr?=
 =?utf-8?B?MldTU2RMWFNIOVFqR21zbGVOeThuTEFxNWhBQWhLQ0hRY1liQ2hWd1NYVXF2?=
 =?utf-8?B?M240aDNUWkI2R0g2bzAwT01uUEVUVERJVnhsNW1qUlh4QlVKOStkU3M3Z2FZ?=
 =?utf-8?B?VXorbDc2dkRkUVpqWXhaZ1Mzb3NBdnd4ZGRqUm5KbmNybldwQ05HWWY3WmdT?=
 =?utf-8?B?K09kd284T25pU21YZ2tIU0drR3JMTUVZM2NkYlFPOTBiRm5DekFnMlA1QXgx?=
 =?utf-8?B?TE14ejJNeFl3dHdaaHRwSGJCZTVLZkVQajZWZHBET1lvaHlJMnRNWXp0RTZQ?=
 =?utf-8?B?cEwvQytPU0RFa2JEUkhON01MdU1HY0c2d1NITHhOS3V2bkwzcUlGRTM1UnVV?=
 =?utf-8?B?YUlNQUdMZFZRam9UUkNFWGVaSzVrRUJZVEdxOXpWVzJmZ0xlcHhsZnBxWFpB?=
 =?utf-8?B?K09mVHc0VTFObC9pK2lLQ1RWZm11SjRCdGxCY1BPdzBERXVtOUwwZ2JTUkkw?=
 =?utf-8?B?SEFLc0RMVm04aFJjeVRqUzBUMXJkMlZJQ2tBVzJLQ2hMZnpycXRDa3pVVG9h?=
 =?utf-8?B?ejRIaUdpUzZYZHBvNjRYWFZkbWNWMzMvVDBhdkZlSmJGUW5Hd2RNcVVZNzY1?=
 =?utf-8?B?WEVESDBFenYzSjV6ZUYrMGh1OWhMSTNlb2hSL1NGbnpJeFJyMzJtUWhyejh2?=
 =?utf-8?B?ditzb051empBYzJyQ1lSYnAvc2JiNjAxT3FaQndSaWJlNklLMW82dUNTMDVr?=
 =?utf-8?B?Wi9KYUhGWTBUU3J4ZE1qWnpzSnIwa3VnL01laE5RRFl3TVFFbU0wQTdGSWNV?=
 =?utf-8?B?Z1luUmJZb3pLUFJnalJyb1pRSHBKNDNkcEUvbDZQeVgzYS9PbEhidUlnQXFY?=
 =?utf-8?B?ek1aMGdUN29qSWRCNlF0MGlNdjFnTGhNaHdNL1VzcDBqRzkvMnZwbTNHR1pN?=
 =?utf-8?B?SldXL0J3WENwa1lwZi9heEo1Y2RUMFk0UCs4NWYwOUdvaThyc3BmR1VhRHZF?=
 =?utf-8?B?bUlFWklITjl0UVBqYnJxSDYzM0tWcHBlTnBmbmhRamtQYXlleldyd3FWM3hF?=
 =?utf-8?B?QytXbmxWTDJkMytrazdRajhkSjFxcVlBcUEwWUpZL3JaSld6ZHBCc1BsR3d6?=
 =?utf-8?B?Y29uL2NnVXVuVkVkUFFzd0JPWTdkbzhkSVFPaEtCMk93dnBqVXJvWnhnT0lh?=
 =?utf-8?B?UXZCU3dZQ1hqYjVEbWQrZDhyeGpPcnZoNGxRNHZMTUhDU00rNERJMXJEY2dw?=
 =?utf-8?Q?Mwq8vkWLNQLe7MAVV4cBDSkvSJYf6Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnUrTkNVcCtidWV2OExaSjU1V2Q1Wk53KzZzdXJWeGlST2NNZDdQdVk3c0t0?=
 =?utf-8?B?clVBVms5d0piaUI3VGRHcUNmNHhhb3BrUncweVFXa1ViUnRpaFp4SlcvRUpK?=
 =?utf-8?B?bXlzM3ZSWlpGQUF1bTJJQ1Z0QVJLR21aSVFjYmdBbU9HZlY1TlEvMStNV0Mw?=
 =?utf-8?B?VUx1a285T09PVCszalFtVGR6WktIV2YvUk5QRzNIOGNud1FSU2d6WVpGRVZn?=
 =?utf-8?B?VkczdXlQTUlVQkk4ZC9WZzVabHg2b1hyM1dpQ0wvclIwdU93MVo5SlJONHFB?=
 =?utf-8?B?YTBVZFgrUjRnU3EvQ3JHSkhvKzVmdHZvZjZWck9EVVBDNGRMcllnL2pJUDM5?=
 =?utf-8?B?dWNZK001TlQ1UzlLcUw0bjBFaHE3SVBGZlVoclBnOHA1b0dVNnBid2ZEM2xw?=
 =?utf-8?B?S0FDd0htY1JhTGs2S3RFU3BGWGtpRVQ1dnVLSkRaMVV5RkUrYXZhSUxPVGhT?=
 =?utf-8?B?aW9ZTmxvV0xIQ1BvN3JLNEdadFphdS9zKzhGRzVMNXhCc2hCMkFjWmh3NXZ6?=
 =?utf-8?B?amR0eXY0YVAveWowYndNM3Z5SVJ6Zmo4OTVOQWFraTBwUnZRb2Jmak5zc05C?=
 =?utf-8?B?QVNGSFBiS0ROY1VOUU5pb2lJNi9WcW9WKzQ0cmNMdWl4M2hsRHdDWWpEc24y?=
 =?utf-8?B?a05yWTFrUmJoR2ZSMytsb0p5ZWJVTDNENitBNEo5UWN3RkJwR3NrT1ZTdGtw?=
 =?utf-8?B?NS9WMnF4M0ZlSTBKYWEvaWNwSmk0Zi80MW8vRnJ0NXVEVkxCS1gzakMzK2JQ?=
 =?utf-8?B?TlErTmZCK3ZWM2c0TXVHb0pvblFBelhDTUx4SFRydVZaajNKTFhiNHJSU2JX?=
 =?utf-8?B?WGRrbkpCMkdQRjA5QzFIM2E1QmlPWDRQT0VoMkR6QThaRnkvdGZWUE9QOXVE?=
 =?utf-8?B?WXl2bDE3V2d4K1FMa2ozNGNLUHpGWTNXR0N6azZFbXM3eFRWMzRNcU1YRDNL?=
 =?utf-8?B?K3BCczVyUjBlSzhOWFI0RkRWK2JseFpVSGNTc2UvSEZ1TGFxOUN5V2tVNHpE?=
 =?utf-8?B?bXhTTGxaK0cvRnRITThYbCtKWnVHaWwvaHNhaW9LcUlIeHFBNXJhZTdtajVs?=
 =?utf-8?B?ZXRodWRweng4N0RVV1RKcnpXZWIxamN1MVJOV3RDZmRNWFd6cjZpVUJ3S3h3?=
 =?utf-8?B?Mkk5LzNYWDhkZGlKSVlLdkl6S1JvREVjMncwMm1jbitNMEVTK29QUmQxejUy?=
 =?utf-8?B?TEJGcm91VTlZUFBoVkoyZ2RNanc5RklpczFlbk0rRk52cHVKVjZHWGZxcU1N?=
 =?utf-8?B?UERDdEJ4NCtlV2M2SUxEaTJQazZNM1VzdjV3WEZ3WmRyaWp3akx3VStWekly?=
 =?utf-8?B?b1Rnc2lsSUhXbEJsL0ZQTGxBWVpPSHRxM1BpQ3BoYzk0SWp4WGsvTEpVakZx?=
 =?utf-8?B?emFYb1ZxYXc0RnRISzdnT0NzRmMwb2ZmMzJ0bndqSC9VMlFQNkFSdU9OdWx4?=
 =?utf-8?B?Q1lQSTUxdDZFb0creHNYSTdEUzROMXRBSnREeDJVcm1oVVZPbWJ2SXFPQWpO?=
 =?utf-8?B?WmxZcU5TOFhhc2Vrb21tRTlCWW5UOEpUYnJISlNlK2t2VkdsTTdWdjZBbklS?=
 =?utf-8?B?MzdBdyswVSsyT3ZSR0xVcnVvTnc3eHl1RVFpTkhZNHEwS3c1VzVqdXpGUFhT?=
 =?utf-8?B?aDZvZzNoYzZUek14czYwZm10a2UzWWw4RzE4NkxoMEk3a3lWSkRTazRwMHVu?=
 =?utf-8?B?ZGJiZFhhOGNoWitCMERkNk5sK3Jua0p4dmtqY2h5ZlRtZTR6bUo1Y3c1T2g3?=
 =?utf-8?B?Q2lmS05MRTFzdm1wTlhvcFBtOXdlcXhzVHY3MkpEYTJ4eEs5ZWc2ek9hanVq?=
 =?utf-8?B?dVUyU1RFaVowaHlMOUtuNENqUDI1ZHA3UzlBaG01Y3VabEMwNlB6cC9JNWhF?=
 =?utf-8?B?MmpBZk9wSVg0VmVvQkZnVDZ2RW1JV3A5eVhJUUxwQXBRZ3NFOTIrb3ZMNHZD?=
 =?utf-8?B?ZmNjRFpCZzZhM25PdkZnZC94MWt6K1VHUkhkL2VkdWw5SU5oYW5vbWVFdndq?=
 =?utf-8?B?RGRGV3lzVFFoS0wxdlppZ1dOdkJDdTMxNmhTK2lpSER4Uy9rSHdzUWk1RFg1?=
 =?utf-8?B?SlVNaUhhdStMcUFjYUtyamJTVkM2b1FpK2Y1Q1g2L1luVHRyVlRpUjg4U210?=
 =?utf-8?Q?fFxc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ca58ec-eadf-46eb-fc0d-08dde5b4f009
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 21:59:04.0377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3G/ZMX0xzYjjlNI50U5r7Ri4d0f371S2S81D7ajgpft4v1pGVAZXWw0WsAPf+CCK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9579

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjcsIDIwMjUg
NDo1MiBQTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENj
OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgUGV0ZXINCj4gWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
UGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6
eXRvci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMS81XSB4ODYvYnVnczogVXNlIGVhcmx5X3BhcmFtIGZvciBzcGVjdHJlX3YyX3Vz
ZXINCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5h
bCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMs
IGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBUdWUsIEF1ZyAxOSwg
MjAyNSBhdCAwMjoyMTo1NlBNIC0wNTAwLCBEYXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4gKysrIGIv
YXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4gPiBAQCAtMTgyNiw3ICsxODI2LDcgQEAgZW51
bSBzcGVjdHJlX3YyX21pdGlnYXRpb25fY21kIHsNCj4gPg0KPiA+ICBzdGF0aWMgZW51bSBzcGVj
dHJlX3YyX21pdGlnYXRpb25fY21kIHNwZWN0cmVfdjJfY21kIF9fcm9fYWZ0ZXJfaW5pdCA9DQo+
IFNQRUNUUkVfVjJfQ01EX0FVVE87DQo+ID4NCj4gPiAtZW51bSBzcGVjdHJlX3YyX3VzZXJfY21k
IHsNCj4gPiArZW51bSBzcGVjdHJlX3YyX3VzZXJfbWl0aWdhdGlvbl9jbWQgew0KPiA+ICAgICAg
IFNQRUNUUkVfVjJfVVNFUl9DTURfTk9ORSwNCj4gPiAgICAgICBTUEVDVFJFX1YyX1VTRVJfQ01E
X0FVVE8sDQo+ID4gICAgICAgU1BFQ1RSRV9WMl9VU0VSX0NNRF9GT1JDRSwNCj4gPiBAQCAtMTgz
Niw2ICsxODM2LDkgQEAgZW51bSBzcGVjdHJlX3YyX3VzZXJfY21kIHsNCj4gPiAgICAgICBTUEVD
VFJFX1YyX1VTRVJfQ01EX1NFQ0NPTVBfSUJQQiwNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMg
ZW51bSBzcGVjdHJlX3YyX3VzZXJfbWl0aWdhdGlvbl9jbWQgc3BlY3RyZV92Ml91c2VyX2NtZA0K
PiBfX3JvX2FmdGVyX2luaXQgPQ0KPiA+ICsgICAgIFNQRUNUUkVfVjJfVVNFUl9DTURfQVVUTzsN
Cj4NCj4gU2hvdWxkIHRoaXMgZGVmYXVsdCBub3QgYmUgZGVwZW5kZW50IG9uIENPTkZJR19NSVRJ
R0FUSU9OX1NQRUNUUkVfVjI/DQoNCkFoLCBnb29kIGNhdGNoLiAgWWVzLCBpdCBzaG91bGQgYmUg
bG9va2luZyBhdCB0aGF0Lg0KDQoNCj4NCj4gPiAtc3RhdGljIGVudW0gc3BlY3RyZV92Ml91c2Vy
X2NtZCBfX2luaXQgc3BlY3RyZV92Ml9wYXJzZV91c2VyX2NtZGxpbmUodm9pZCkNCj4gPiArc3Rh
dGljIGludCBfX2luaXQgc3BlY3RyZV92Ml9wYXJzZV91c2VyX2NtZGxpbmUoY2hhciAqc3RyKQ0K
Pg0KPiBTaG91bGQgcHJvYmFibHkgc3dhcCAicGFyc2UiIGFuZCAidXNlciIgdG8gbWF0Y2ggdGhl
IG5hbWVzcGFjZSBvZiB0aGUNCj4gc3Vycm91bmRpbmcgY29kZSwgaS5lLiBzcGVjdHJlX3YyX3Vz
ZXJfcGFyc2VfY21kbGluZSgpLiAgVGhpcyBpcyBmb3INCj4gcGFyc2luZyB0aGUgInNwZWN0cmVf
djJfdXNlciIgb3B0aW9uIGFmdGVyIGFsbC4NCg0KT2sNCg0KPg0KPiA+ICB7DQo+ID4gLSAgICAg
Y2hhciBhcmdbMjBdOw0KPiA+IC0gICAgIGludCByZXQsIGk7DQo+ID4gKyAgICAgaWYgKCFzdHIp
DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICAgICAgIGlmICgh
SVNfRU5BQkxFRChDT05GSUdfTUlUSUdBVElPTl9TUEVDVFJFX1YyKSkNCj4gPiAgICAgICAgICAg
ICAgIHJldHVybiBTUEVDVFJFX1YyX1VTRVJfQ01EX05PTkU7DQo+DQo+IFRoaXMgcmV0dXJuIHZh
bHVlIG5vIGxvbmdlciBtYWtlcyBzZW5zZSBoZXJlLCBhcyB0aGlzIG5vIGxvbmdlciByZXR1cm5z
DQo+ICdlbnVtIHNwZWN0cmVfdjJfdXNlcl9jbWQnLg0KDQpZZWFoLCB0aGlzIHNob3VsZCBiZSBy
ZW1vdmVkLiAgQW5kIHRoZSBjaGVjayBzaG91bGQgYmUgaW4gdGhlIGluaXRpYWxpemF0aW9uIGFz
IG5vdGVkIGFib3ZlLg0KDQo+DQo+IEJ1dCBhbHNvLCBtb3N0IG9mIHRoZSBvdGhlciBtaXRpZ2F0
aW9ucyBhbGxvdyB5b3UgdG8gb3ZlcnJpZGUgdGhlDQo+IGNvbXBpbGUgdGltZSBkZWZhdWx0IHdp
dGggdGhlIGNtZGxpbmUuICBNaWdodCBhcyB3ZWxsIGFsbG93IHRoYXQgaGVyZQ0KPiB0b28gZm9y
IGNvbnNpc3RlbmN5Lg0KPg0KDQpBZ3JlZWQsIGFuZCB3aXRoIHRoZSBjaGVjayByZW1vdmVkIHRo
YXQgc2hvdWxkIGhhcHBlbiBjb3JyZWN0bHkuDQoNClRoYW5rcw0KLS1EYXZpZCBLYXBsYW4NCg==

