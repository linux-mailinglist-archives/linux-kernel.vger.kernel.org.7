Return-Path: <linux-kernel+bounces-858161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDFBE92CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68A0C581ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A23396EA;
	Fri, 17 Oct 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pRCTHK4e"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B83396E4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710788; cv=fail; b=WzRsg5XiO/o5LMgSSXTJLj5Y2sy7UnSCeL5kwTLYnk6p8NsGOei9aoZTXaYCqoSaJOAXzAxDi9SnE+9yaOv6iQ0lO5lSURt5zQUrnnVLwbw6H4h8vn9pLLZ83TU2pOTBHzMJ5sKz+3JGfbfNUFkfP5EjZ30Za7aI+qviJ0YxbiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710788; c=relaxed/simple;
	bh=cmsV2fCZgGqXI+h8sa6xiSl+h45CQVopY/HXjXSyJys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BV+cEw13qnaGO3X4cYQbZKLJCxYbu4jIQvCUAZOjRSxurQWABrXIvHVp9hUfLw9DkQiqDjxkXF2j5lgt7Bh61GmZ++2KNuSNcMMBj6czziWZV68corE9Dl3WrnwTkVAHwW+eQf8aByeAt4CRE4Q/N2bsapvJvIu7KaiXV/yxDgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pRCTHK4e; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0n8L1rI+ghCepgdPULZi7Ab+G4Ey1t1BA1RgDJY4MK3p3tU3sBq0vLRk1lH2nzrT6zC/Sp1tXpeVtn+pCZ/03kw1JLX79s3NBMfC/cmHaYZn9SLFupobFO/QkyKvJfDjtkobmQ3kVUyMJiWqfTMRIYpv6VX9VPWDgvTPWHqOh4SdVbGsc/giFLNreQ6Out9ky9SpqbbrtuDOxdEMJtGhts7Gt9sPS9IDX1yCmxXefnNvuqNaDlNzLcfxg202h6VdzM5oyEYDx/RyQ3bAMbMGHm6Gpj7nj0jQNz54/D4qX8D2SDk/nUob3ZDm8f31RvA1rCm+vL4mABeomhSry8U4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmsV2fCZgGqXI+h8sa6xiSl+h45CQVopY/HXjXSyJys=;
 b=BnIU7cBIC8kQveTes9atgXb2yKKL57JYxce4N4GjeASfnlN1G62F0cXzWqU7bqsUZdRrNx2FFqocg0doR0xcGn03qHiqpRZjoG3sEGdjjdiI6iZl6uKSqvcjpOBSyi7+dCXAOEt0637cC5+gA8TXXGVCnpwgYfaOP9uiWUDWa4k38lNAQm/5gYwBkd9a78av6z0n3jL58Q+dORBYLfYUgjoYwQnLxwYGleTRWtfYoqbokDYpc8nLofplkJLG2k8ctHOWUapbuCrfAqy86WBM8TSs6q7ez3fV6qelJO2gqNteJ2F+98fer2ugv5CGjKDyukAzXA/cwFc7g+q24WNhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmsV2fCZgGqXI+h8sa6xiSl+h45CQVopY/HXjXSyJys=;
 b=pRCTHK4eM5vwW8jvtXLupq+Oa+NYRgvxw2q6BYDOe1sxGu6MvzdONM2kt/nIkdhuSEt2B/IyyC5PixkI0C7+P6m3Poj74MCOjZYg3vtT7elkmYvixFk6+O+1AxHTYm2VO03RvoPaMZ9XZNFwt0iJfls/ppoR+y8woyziR4pk+K8=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 14:19:43 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 14:19:43 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 03/56] cpu: Reset global mitigations
Thread-Topic: [RFC PATCH 03/56] cpu: Reset global mitigations
Thread-Index: AQHcPuSmgZjhqZAw90aoTx01YlegKbTGYD3AgAAA+7A=
Date: Fri, 17 Oct 2025 14:19:43 +0000
Message-ID:
 <LV3PR12MB92656CCC8F8776F50FE92B8894F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-4-david.kaplan@amd.com>
 <fxgzzp3yokq24swgfkokdnqb7jf53s3na2wjitr5koiamfizgm@d7uvxnuzkebd>
 <LV3PR12MB926591EA45E7186AA3BD2A7E94F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
In-Reply-To:
 <LV3PR12MB926591EA45E7186AA3BD2A7E94F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-17T14:04:54.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|PH7PR12MB8777:EE_
x-ms-office365-filtering-correlation-id: 154b3322-5b3a-46ff-8439-08de0d8837cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1F4azBLL3RlY1ZIMnNYekJSd3lQY1hidlA1eDNDUnNIZGpSbE9ZWk10ZUc0?=
 =?utf-8?B?YUFZRDgwdmxFMTdhRm5qMUQ2QUh6YU5rTDh1M2JnUjRxcFNXcjEzL3RxSVpy?=
 =?utf-8?B?VjU5RHVnNXZlanM0NWE2OWtzOE9idloyZ2llMTFPRW9Wak1NWXdpQVczeHZl?=
 =?utf-8?B?UlU5UXpYOE9LMU9neDdFdExGYjhXVkorRG1pY1VxT204d0Y5Q3l4UDRYc01E?=
 =?utf-8?B?ZWlQNkh2Q0JGcUd5ZzYvdkJZRXFMMzNWSDB2Tjd4UGNuOEF2SlgyY2lLT1A2?=
 =?utf-8?B?Q1hWdmoxb1M2anV4MmFXdDFKKytQZnVsZHprSnRLR0pCdzNnNjZhNlF0dzEv?=
 =?utf-8?B?dDNpSWd1cXVNTjhubllkYncxSXgwN0huMC9rREJ0d2JxbDEwc25qdk5qdXFj?=
 =?utf-8?B?dU8wYnhNWFZYNVhIcjgrbTYyQ0JaVEVHVlAvYWlWd2hhckN2TjB5UHBGdFBN?=
 =?utf-8?B?RS9BNHJYT3d5R1pFSE5PUHBKTFZIRm4yaFpUbjE4UEF3RmdQMUxHWENaT09B?=
 =?utf-8?B?TUFoM0pqc0l3YUZZWVhXZXg4QTA4Wk9WSWVRUFdOOHdYUndidEdCYnZJcFFR?=
 =?utf-8?B?QlZpY2N2ZzVsNXlubWFJYmlwcC85RWV2QVl4bXNuRGlpVUxsLytIdW40R0ox?=
 =?utf-8?B?TEl3eVZFRjd2WTdWTzhsTWdacEdLdUhVb0RUMmdSY3ZNKzFWMnkwZThiL1Zy?=
 =?utf-8?B?U1ZPaDlCMC9xeDFmWEh0bFFHTWk1TGZLRFdTbHBUd0hHRWp6d2ZHRVlQaWIy?=
 =?utf-8?B?R1lpK3BrMkJSOHBLV3E1RE9EL1AyRFFQT0tMS2I0MmdiSU9iWEtGUzRpL1Nu?=
 =?utf-8?B?WE4vWXFKUXdKRitkZXZmNUZ0aTVMWGN3K2ZmNzJpakJUZTNkM0w4K0cwMXpL?=
 =?utf-8?B?ZkJuRm1hSDJmTWxHVTRpV2dobXNWQ1ZJTVA2V2R0UkFvVExnSEI5YXQyUEp0?=
 =?utf-8?B?aEFRd2VELzV5NlJoM0dLQWczc1JKeTZYRW0ycHIvSlhhS1NSTzVXYndNeHRX?=
 =?utf-8?B?WHhrQTVsRG0xMWVTaG10aFVjVkpIWHl4WTB0V2FNU1piZDhBVlFBZkJKNWoz?=
 =?utf-8?B?Q1RreWJYdk9oOTlrZThubks3Mm9pY3N0VzYxK0U1a2xsK1ZPSmRzNFJJaWhW?=
 =?utf-8?B?R1FxTExTODJpVnFMYm5XQkdHR05wdzBUazUrN1QvTkVmMXl5N2lydlM4NmtU?=
 =?utf-8?B?Nm0xT1RsQ2s5NzJtbkhKY3ZPbVNzRU5UakdjV1RZZEJNTURKb1VPNFhneXk4?=
 =?utf-8?B?TW0rL2pPRkgySGJxbkpEOEMvMTNkWkxqWGFZdmtqVjQzZHJua3pPQVI1VVJE?=
 =?utf-8?B?cVBiUGdPVjlnWTIzWjVOLzRSelZNRHJSMndRQnhnNk5ORW90bzYxUlViZDMv?=
 =?utf-8?B?bk5acWIvT0o1VUllYXhPSXlGRU5VV0JncEJqYmROTzZqK1NiNDFWQ1VMcTVo?=
 =?utf-8?B?SUt6UlpGRmF5MFNpc2daYSthWXIwTzgxR05OakRCWVhkazZvWHNZakJpcVlU?=
 =?utf-8?B?dHcvbG1IbXlyUDJlbnZ5NHI0aXczZGxxa28zeGZhNFRNK0hoeHVSM3dKMWVK?=
 =?utf-8?B?KzFOVTV5eHpLSzFjSktTNzNkY1cvZENjejduT2pqQVVETFBobTVPeHVyb29D?=
 =?utf-8?B?dXJHT1RmVzJWYllwaDRuOTk5MWYvdmxPbTJRNy82R2xIcERqUVkvM0JPZnA2?=
 =?utf-8?B?QkFETktOOEJMdGRCblR1TjFoQ1dsamZiV044VXpQbmd6dDVwdjQyd1Irelpr?=
 =?utf-8?B?Y29NWU1kcXBTR2NkWnh0UHlEcTlxMWp2UlJzMWJKSUdRTVVhOVEyT25GdUlY?=
 =?utf-8?B?NTljUm40UUZkVEF1anNMRU9kamR3aUFCYm9JUENrazBrS0hPWDJWdnFoREJr?=
 =?utf-8?B?WGNRMU12MmF6MW4xemcyNnJNaFJLN2JoVEdyZFdjc1k4Y25DM09ubklmbURS?=
 =?utf-8?B?NkJrcUN4RnVMZ2dUdERyQXFaNnlMbENoWFBDVDVpeXhRMHJ6MkZRV3ZZOHl6?=
 =?utf-8?B?K0xIVWh1a3UwVGlaQjFMcUdEVFR1RUx4Wm01RWhXYWRGK1A3UlBaUStVRXkw?=
 =?utf-8?Q?bjl379?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkRoWHBiRVVJWWh5dE9oUG90T3doUWJsbVJta2oxRTRGZHV4R2grblV3L0Qy?=
 =?utf-8?B?cHNJbjJrbFJldndWV0hYYS93NTJSaXladFE2TTdSQXpGMnVLOGlTOGVadis4?=
 =?utf-8?B?K0NibUx5SXllMjk1a200SUhGcVo0N0lzM0tQM05IN2ZZOEptYlRNVDlVYlVK?=
 =?utf-8?B?bmYwSEZjbFUycDRuQ0JVZG1MKzdPV0JvRElzdjRHME9DeWtOcnFZUEc0TC9r?=
 =?utf-8?B?bTg5dXN3blVNY29xTFhqbFpnRDdMVS9VMUNpQTJBR3VaSVVieXFZNkVPTnRK?=
 =?utf-8?B?RVhsSXA4ZVFuWDFya3lxQ3Uza3ZzY0MwZFVMY0dHMThQeXo1SmgvclJrK1RI?=
 =?utf-8?B?UXNaY0JTMHMyRDFScHpUVElqUzJlUnRvdTU2bjh5UkJoRlVFblA0L1VDWWNC?=
 =?utf-8?B?Z0htUGNDRTRha1hrZ0ZCYjJ3UXJNM1ByQzUyb3RMbTNFaFVINlI5eHRMSGdR?=
 =?utf-8?B?OUtPMDNpemd5ZGQ1cE8yczVxaVNjaWdOOERxVWdxY2ZyYTlUZ0o0cHl6RTFq?=
 =?utf-8?B?VGhsR3NSZ3B5UVJMald1TFVlSlNCWXlydW5rVFJQYk1lTG1YQjJQUi9NNklw?=
 =?utf-8?B?QjR6ODVIZVRwZE1qL0VkTVJVMUg2Nzg3dmlvWFFEcDU5SDVuNEdBdVFuTlEv?=
 =?utf-8?B?dXJEQXlSSGM4MDd0MWsxbzQxaHBFeU0wbUtmWkZERyt0Q3krY0YrOTJtbUtl?=
 =?utf-8?B?N0E2MWVJYVAzV295c3h4UDFnQWRZcGZudkkzYWxBbjJtSzhXYjRpaFBEaW1C?=
 =?utf-8?B?SWRhQlFCVzBVOXFCQzFMbEI3MFROcXlFMHArdTdxTERyTHk0cFFrbG9GOFJC?=
 =?utf-8?B?SmZFaTVTWmR5b1l0cUM1a3FnNG8rR1J4clVVQWJYV24ydzJ3bllUYWllb0tB?=
 =?utf-8?B?NnJOMXJIZGtad3RhbncxSXVMTUhFUVdjVjQ3b3BVQ1p2TG9pTDYybjFoTTNo?=
 =?utf-8?B?dkRSNHdxYlhlZXFwWDNNWjNsU0huUVkzcG5GS3VncmZkNzVWNlQ2cUVEeFNF?=
 =?utf-8?B?TkpFeFI2d2ZXSHlUclhveXYyNDdwU01YaTNoWW5jSEloa3I3SHE5dWFKekMr?=
 =?utf-8?B?Y1BhOHRSTDM2MTZkODQrR2tGUTByV2cyTno4L1VEN3N5M01iWkNMc2VzMUlU?=
 =?utf-8?B?Y3hlU0cyNkgzL3E1VGhFNVdpVEw2VVRMOEkzRDViS1RyNlpnQzljQ01jWEtN?=
 =?utf-8?B?THFPYjd2TXpuWnh3VlhlaXJTMmVkS3hMYU9oWUJrL1lpRDdNZWdabHpNcDFz?=
 =?utf-8?B?NU9OeDFFYmppSHl6a3RRME84MGMyZHVBcXd0N2sxczBhN1E0U2grdjBzWVE2?=
 =?utf-8?B?SGM1MFcxa0gzb0ZPaXp5dUtRUUpBWCttL3d0eGpmVXNaNkxhUkVUZWpZU2Ey?=
 =?utf-8?B?alA5ZUNxR3pNLzg1YmMrZDZxY2JKTjNDM2dYdHZNdXh0dG4rWk95T1RKMDV4?=
 =?utf-8?B?U1BsYmtLV2pRZTc5bitrUVFwRC9pbjRDVU40NEdmNG4xNDZkcFRyNnFEdGV2?=
 =?utf-8?B?N1FuR1RheXRoQ0JETnVtTDZqRFp2M0lJTVhReTNnbktCd2NLNjhLTkM3dUpT?=
 =?utf-8?B?eXFsR2dTMTBsS1JOYUFaN3BodEMreDMvc0pHajFqaUVwMHBTYVJDMENnZ0J6?=
 =?utf-8?B?VjBCUlFsNzZHTHVRclRxWmFtY1l2NnZyQkpQbzVvVTU3bXJBcDRsU295TVJl?=
 =?utf-8?B?Uks1dHhFS000aVpuY0s0SjF0SWgwNUo3VmhVdW1qYm5DRnhNZ1lUNGQyQ29r?=
 =?utf-8?B?cVdmeW1MYmkrSndaUzQrVTJwQmovSWdvRmhzalcxWWhFUG9RWktYL0svOFdC?=
 =?utf-8?B?b29TNm5qL0VhMEdUVEsvWlg3NitIWnJjeWU4Sk9DcWJEcStnWFpuOFV0V0tS?=
 =?utf-8?B?Z0V2aVNHR3hmalFLeW5WY2c2Z3cwNVhqOFRkKzlIVVprcFRmR0l3RVMrSjNn?=
 =?utf-8?B?SEdsMjR6TmVrb2VyUER6QWl1YmhCTk92SWovMjBoQlRobEJ4dXkwTXJmQms0?=
 =?utf-8?B?UE1HLzl0RU5UaVFCWE8ycjgxS0hrSWlhWE82WnJWNlRHTytjdVBQU3BnUTVz?=
 =?utf-8?B?YUduL1k1RDV4QVJQVUVJSWlHOXpQVXlaaFZHaXBnQktrNXNrMERPTTFUdENq?=
 =?utf-8?Q?vQbg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 154b3322-5b3a-46ff-8439-08de0d8837cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 14:19:43.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIdOtO3h3ZxPQz9f/o2LZLLKscbZNzHsjq9Gze8L96ywsnw3jaNpcFBcNd5DY4R6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYXBsYW4sIERhdmlkDQo+
IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxNywgMjAyNSA5OjA2IEFNDQo+IFRvOiBKb3NoIFBvaW1i
b2V1ZiA8anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+OyBQZXRlcg0KPiBa
aWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQYXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3Vt
YXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+
OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtlcm5l
bC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5dG9yLmNvbT47IEFsZXhhbmRlciBHcmFm
IDxncmFmQGFtYXpvbi5jb20+OyBCb3JpcyBPc3Ryb3Zza3kNCj4gPGJvcmlzLm9zdHJvdnNreUBv
cmFjbGUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTog
W1JGQyBQQVRDSCAwMy81Nl0gY3B1OiBSZXNldCBnbG9iYWwgbWl0aWdhdGlvbnMNCj4NCj4NCj4N
Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEpvc2ggUG9pbWJvZXVm
IDxqcG9pbWJvZUBrZXJuZWwub3JnPg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE2LCAy
MDI1IDQ6MzQgUE0NCj4gPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+
DQo+ID4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYg
UGV0a292IDxicEBhbGllbjguZGU+Ow0KPiBQZXRlcg0KPiA+IFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47IFBhd2FuIEd1cHRhDQo+ID4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4Lmlu
dGVsLmNvbT47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiA+IEhhbnNl
biA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRl
ciBBbnZpbg0KPiA+IDxocGFAenl0b3IuY29tPjsgQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9u
LmNvbT47IEJvcmlzIE9zdHJvdnNreQ0KPiA+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRD
SCAwMy81Nl0gY3B1OiBSZXNldCBnbG9iYWwgbWl0aWdhdGlvbnMNCj4gPg0KPiA+IENhdXRpb246
IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJv
cGVyIGNhdXRpb24NCj4gPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtz
LCBvciByZXNwb25kaW5nLg0KPiA+DQo+ID4NCj4gPiBPbiBNb24sIE9jdCAxMywgMjAyNSBhdCAw
OTozMzo1MUFNIC0wNTAwLCBEYXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4gPiArI2lmZGVmIENPTkZJ
R19EWU5BTUlDX01JVElHQVRJT05TDQo+ID4gPiArdm9pZCBfX3dlYWsgYXJjaF9jcHVfcmVzZXRf
bWl0aWdhdGlvbnModm9pZCkNCj4gPiA+ICt7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gK3Zv
aWQgY3B1X3Jlc2V0X21pdGlnYXRpb25zKHZvaWQpDQo+ID4gPiArew0KPiA+ID4gKyAgICAgc210
X21pdGlnYXRpb25zID0gU01UX01JVElHQVRJT05TX0FVVE87DQo+ID4gPiArICAgICBjcHVfbWl0
aWdhdGlvbnMgPSBDUFVfTUlUSUdBVElPTlNfQVVUTzsNCj4gPiA+ICsgICAgIGF0dGFja192ZWN0
b3JzW0NQVV9NSVRJR0FURV9VU0VSX0tFUk5FTF0gPSB0cnVlOw0KPiA+ID4gKyAgICAgYXR0YWNr
X3ZlY3RvcnNbQ1BVX01JVElHQVRFX1VTRVJfVVNFUl0gPSB0cnVlOw0KPiA+ID4gKyAgICAgYXR0
YWNrX3ZlY3RvcnNbQ1BVX01JVElHQVRFX0dVRVNUX0hPU1RdID0NCj4gPiBJU19FTkFCTEVEKENP
TkZJR19LVk0pOw0KPiA+ID4gKyAgICAgYXR0YWNrX3ZlY3RvcnNbQ1BVX01JVElHQVRFX0dVRVNU
X0dVRVNUXSA9DQo+ID4gSVNfRU5BQkxFRChDT05GSUdfS1ZNKTsNCj4gPiA+ICsgICAgIGFyY2hf
Y3B1X3Jlc2V0X21pdGlnYXRpb25zKCk7DQo+ID4gPiArfQ0KPiA+ID4gKyNlbmRpZg0KPiA+DQo+
ID4gQ29uc2lkZXJpbmcgdGhpcyB3aWxsIGhhdmUgbm8gZWZmZWN0IG9uIG90aGVyIGFyY2hlcyAo
b3IgZXZlbiBvbiB4ODYgYXQNCj4gPiB0aGlzIHBvaW50IGluIHRoZSBzZXJpZXMpLCBzaG91bGQg
Q09ORklHX0RZTkFNSUNfTUlUSUdBVElPTlMgZGVwZW5kIG9uDQo+ID4gYW4gYXJjaC1zcGVjaWZp
YyBDT05GSUdfSEFWRV9EWU5BTUlDX01JVElHQVRJT05TPw0KPiA+DQo+ID4gVGhlbiB0aGUgd2Vh
ayBmdW5jdGlvbiBjYW4gYmUgcmVtb3ZlZCAoYW5kIHdlYWsgZnVuY3Rpb25zIHNob3VsZCBiZQ0K
PiA+IGF2b2lkZWQgYW55d2F5LCBJTU8pLg0KPiA+DQo+DQo+IE9rLiAgSSBhZ3JlZSwgdGhlIGZl
YXR1cmUgZG9lc24ndCBtYWtlIHNlbnNlIHdpdGhvdXQgYXJjaC1zcGVjaWZpYyBzdXBwb3J0IGFu
eXdheSwNCj4gc28gdGhhdCBzZWVtcyByZWFzb25hYmxlLg0KDQpXZWxsLCBzbyByaWdodCBub3cg
Q09ORklHX0RZTkFNSUNfTUlUSUdBVElPTlMgaXMgb25seSBkZWZpbmVkIGluIGFyY2gveDg2L0tj
b25maWcgc28gaXQncyBhbHJlYWR5IGFyY2gtc3BlY2lmaWMuICBJdCdzIHBhcnQgb2YgdGhlIENQ
VSBtaXRpZ2F0aW9ucyBtZW51IHRoZXJlLg0KDQpTbyBJIGd1ZXNzIHRoZXNlIHdlYWsgZnVuY3Rp
b25zIGFyZW4ndCBhY3R1YWxseSBuZWVkZWQgaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQpBbHRlcm5h
dGl2ZWx5IEkgc3VwcG9zZSBJIGNvdWxkIG1ha2UgQ09ORklHX0RZTkFNSUNfTUlUSUdBVElPTlMg
YSBnZW5lcmljIGZlYXR1cmUgKHdoaWNoIHJlcXVpcmVzIGFuIGFyY2ggdG8gc3VwcG9ydCBpdCku
DQoNCi0tRGF2aWQgS2FwbGFuDQoNCg0K

