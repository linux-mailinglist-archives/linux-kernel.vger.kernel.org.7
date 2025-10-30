Return-Path: <linux-kernel+bounces-878752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A87C21689
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C455F4F2A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05631A554;
	Thu, 30 Oct 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q67r0nJi"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507033678DB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844228; cv=fail; b=Fxc7TKSNHHQ1slQXMtfZcPkrKvwXkDHwUlbcGLTIeHCmJyVNQo29NfOyuXtrGRn01RRsxIW7uH1yykKFh78SCvX3JmL6q7lvbFH2Pw3MBVYURFB/fUKfE2eUVrc79Fo/EGhVTOwK5y+v0rIwGVowP8IN2f+C/zVbubh5lbl9tCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844228; c=relaxed/simple;
	bh=NC79Ns2N2ySLhetXKEXFaUAKgj/DzADY0vZnv8VEY94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gxFE5oJhOgPdLqTyD9xcE4zj+5+VaaWodqWnFnc3V/5fApukcM7O2MwHHURTQerdHlCthxIKlVU9BzYZPiSqPeNGpQuyMJTsf7EVYSh77pL9WGyuCxUO5klxf25ha7VSawZtGBr27bvsyNQ7fZHuH42Wjw0lDxLbFl17h5Vz69I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q67r0nJi; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgDZE0+Gr7PJ2X/6rNcH7KM660bu4hFt1BfLNMDkRkH0tWOMkvJ8wLlu0zTEYQue59XxEO+tQIycvB7NxnPYcG7N4ewyGBBxuAG6tXJn1lSs9+qsATfme+L4rMzCcSxSeigLv2C69wBccxL4v0u4nsr5cXh36dN2iGYoDFo3ISwSoh+wqoocgJ/N62///bpYCRd3emHKET+dk5LL0xA4AeE0jJ0udvZBO3gx2GReZUkGjVZMvpL8xbcebfAk5ExzJP+0pEZT4HJ/iHgbOE5dBbIP0khvR9vp5/zBCV4GTPC4wNfQBdwWGZTLI04zaZAWgxw/gVbtssHqnQRe/NThHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXB62v8t9XKkYzzTW1Dt3ndvg48Q9sTwWYp4CbGgAKc=;
 b=uuEG2QcFCH4ay250aMl1wvEMiKk0V/tf33uvXNyPmZmh6V2Msj9FFcVh3HduqECqKtJUXpPSFpSbdyQdcwQszBKnII+sbEs1Uz13yTt7pNPWQxk298tDhnsKUoYV+p4Vna7NxVlKoQWhxO6JoyhAfboV3TIx8xpI5sC3WfjeXyXFIaH8EjW+xrwwXAsfvP3U9Kc67SKTlAYut0XAhaybfsB0C6Vxi1qwmHqsFQOXInfor4h+DA7sLhqTwA1PvXC/Uw6+EMlo+6kCfzP/Ec07FbOLk+jWvtF4RhZs5uPQ82uzJJmw6/slITNtMdsRh2gVd9oN89xlblKqkw5GY3TPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXB62v8t9XKkYzzTW1Dt3ndvg48Q9sTwWYp4CbGgAKc=;
 b=q67r0nJiCLmrZkbTmOntWNtg9snUKGqa/v/1Slf3uF5Sqv++0IwzolCFbYADejUso4Sm+Vu6F74ggudg4wNtl69unVmhrFUEDqxpEULmOP6Q/qslndspcIsKwiSH+tA1Y7Ut/l7ItYAMdAcr06R6MwlR1iRFCwpYJmngIYvY/8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 17:10:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 17:10:21 +0000
Message-ID: <34829993-a888-4f7c-a2c6-e87723644c3c@amd.com>
Date: Thu, 30 Oct 2025 18:10:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: replace use of system_wq with
 system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20251030161011.282924-1-marco.crivellari@suse.com>
 <20251030161011.282924-3-marco.crivellari@suse.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251030161011.282924-3-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b4b468-51e4-4de1-bf5f-08de17d73517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUdXSHExUFA4RzczZ2l0ZmMyOVlIM2paaS8yZzBIRWI5YjNOeUFpaTJkT2E3?=
 =?utf-8?B?S3VBQS80amlQTnJMbVdqTFNGWWhJVFpURWllRmtsVjJQSWFDNmhxYUIvWkxE?=
 =?utf-8?B?Uko4VzBHeGM4WmRFc1U3aHZDY2lwY3N1ZkpwU3ZtY21BNG13OFErUkNWK3hV?=
 =?utf-8?B?WVI4NzRHaFhGWncyWkxMZTNPbER0Tk45TWJScjNiWENQTmdmb0YyMVlDbzZG?=
 =?utf-8?B?eU1WZTlkbEIvdERvY2dEM2VmbEpMRWZVZE5EUDY3ZG1nQUIyZ1RtN0tYd3hQ?=
 =?utf-8?B?OGJpbk9SNHlkeUN0cU1SK2lrRjVISUd3amZFVEdNNnQ2N0ZmMUFPbE02ckNL?=
 =?utf-8?B?Skw2c2tNaHZheXcvdzMwd3NHZzZIdzRaRkttZVFKY2YvaDJvUjl4QWZHZlV3?=
 =?utf-8?B?eUJ3UEthRFlFMGxwck1RNzVCZFlMemoya1Y3bXIzcXdYSW1GbElDeEFxZUJQ?=
 =?utf-8?B?MVRjVkhpUGc2UWNRM1dXWGpJNTE4cUd1YVBjaklFVzZLempNb0JyM3EwOGwv?=
 =?utf-8?B?cFJiRUt0Z1YvSnRhZTdUUmlRWEc0YjR0NXVYSFJJN2VoTXNYR1dJVG1oMVVF?=
 =?utf-8?B?eUhPalRSdjJoNnBWMzNCYWw2S1FEaTFqUHo4c0hkZElNRm9oRlJZbHFJM01V?=
 =?utf-8?B?NnFpT2cwVk5ZSFlPZ0tieDlNcVh6SkU3L1pldWN1UEJYUUFHWS9LUnpybEx2?=
 =?utf-8?B?Y1p3OWMzeU5CUmYyV3FVTmkxVUdqS2pQWUdlL1daMDlnaHgybXMrUS9vNjgy?=
 =?utf-8?B?eFJrZTdsZ2V6Ym45YWdvaXBmVjVUMXo2UFNpZ0l5ZVFGV0wyczBwNzlhMTA5?=
 =?utf-8?B?SUZYaFVZc3RZMFVxNFRQZFB6aDh3RWNwNHhBYXBoSTYzY3FVcDFiZzVCcXNY?=
 =?utf-8?B?b3J5ZUdwbjBTbzE1ZUNuL2RpZDJHODFncUZFYU9ZaXQ4NmN1Z0RFRlFmT1h2?=
 =?utf-8?B?VDA3SHNvV25BZlgwbFNSSFREeTFGdXNpQktLYlF5VFFqMUpRNlR1RnFkUUFZ?=
 =?utf-8?B?bGdxeGx6a0RhYzNCQmIxZmpHejc4NFUwMlI2TmVud3REbEMyMFljZXdkZXpp?=
 =?utf-8?B?WXJLN0ZTMEp6U1pKT0NyMnM0YStod3d2LzM2bnBQOUdGZ3l6dnp6VWpuUkRs?=
 =?utf-8?B?Qk50SEVEV3hIaHgrcnIvTFRWaTJ1bWsvNXdsVUh3MG91OTE4eDBOZ2ovYTRV?=
 =?utf-8?B?Z3dwczFrOWxqNlU3QkQzQ3N2VXBMenFrcGVCaHI2Tm04Yit2WUc0b0FnYlVn?=
 =?utf-8?B?ME5HNUo3QkdrOGo3SHpXam56cU56NGhvL091aXJRM2VkaG1nRU5Wd2tkdlVF?=
 =?utf-8?B?T3VqSFEwcmxWT3o4VFp2cUd5eWY4SVFhc0hqeGJYemMvVS8zM3hCdXdEVTFW?=
 =?utf-8?B?ZC83QjlFcGROZzlJdmduU0RDV2tkc0cxdGlSa1l0QnRYQStLUVZ1MFZGR3Mz?=
 =?utf-8?B?OFcyYWNaUmIrUVJ5WTlLTkpxNWkwWXpEREdZSUJWUXB4b2ljMVhsV2ZSSVM0?=
 =?utf-8?B?bzRyYUIwVk02OGlIYmZxdEVUcGJ1UFZiZXRSdlJ2REtEejhNMnBkbjZOR05Z?=
 =?utf-8?B?bzZiU3VPR0I2KzlMRFh6Q0pVWGxaQVUxWUhhNjlHL0o4ODM0cVBqMUYrS3Jl?=
 =?utf-8?B?SDNQOC9kdVI2Q1NQOWM0cUp6NGp4V2VseEg4ZkJHN0tIMS9McFpVZ3FaTWRI?=
 =?utf-8?B?NDNwcUUzeHdzV1FlR0ExeldlVTZ6VTJRTng5MFpmSCttU2VTelA1Kzc4MUJF?=
 =?utf-8?B?RWo5YUlyQm9oaHVYdzljMzhYMFBqM1RKWWhKeXpCcjhKTHI5WFlwalpNTStK?=
 =?utf-8?B?QXZ6bmpFL0ovYnNYNUJJazBVbWFDOHVXVjlwUjdMVzZQdWY5RVpwOEQva3BT?=
 =?utf-8?B?NksxVGtjYjQ2NkljSkIzZytmMHZpYWpZNjUvMDAwRklUcmwrRTR4T1Q1M3pE?=
 =?utf-8?Q?l0Uwtv6rnRnBq8i6Mx1VovJ+seXgeMuW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHR0N013WkRBL3FqREd3SmZMbjkrR1JucWEyamtQRjkwZWYxMWs2OEJGWnVk?=
 =?utf-8?B?bGEvNStXbGFWMDlZUi9BUHdOb0wvSnpEWlBvRGRiYTdFTDE2ZytpU2xIK3J6?=
 =?utf-8?B?VnZTenJhNTU4S2xwRVMyYmNtSHI2REpCaDJjUVY1QVB6S2ROTUR5elRzaVly?=
 =?utf-8?B?TTc2S0xyTVhUMm1sdzNDWTNwWi9FQTN3TXdEaGttUStnWDFGVllTRW1hZTJR?=
 =?utf-8?B?ZWRWUjJQdzZjZWJWOTZJRTBzbXdYbk9NaVJ5bytWWlFUV2VDeWk3Z2RHeWR4?=
 =?utf-8?B?U0ZyWUZ5LzYxOU1HbTMvTmhrWEVYSXdEaVJLNzh0MGRTZXo2VVI4Q3JpSi8r?=
 =?utf-8?B?SFd0S0hDbkJOSXM3Q3BtWlZxT3NKaFI0L2ZpTHJCYmNOK2prNVR4R2FXTnRJ?=
 =?utf-8?B?QjYzZ0RJbkZySHdTMFZhRkF3b2NiQ2Z0M004LzNTYjMySU5yKzUwNEY3eHVu?=
 =?utf-8?B?dHFLRXk2QWJsekQzdFJpbnBRZDAxN0g0VUNzYlJyMnp4S0xKajZPNk93ZWM3?=
 =?utf-8?B?MXZOeGpVcE1nZTIrTFpyNC90L3JjdTJsYU51L0J1MmVGWkdlZTVIcHBvaEFu?=
 =?utf-8?B?bnhSS3JtSkJTdkVucUNadlVnNmNsRXFXM2wxSlllVG9WdnMyV2NoVS9aZTlS?=
 =?utf-8?B?Yzg1UGF6a1hOZW5VVjNmeWZKTzhVd1lGZHFWejBMa3IwamRiTU9keHZmSEdr?=
 =?utf-8?B?djdCUmpCUytCNUVRNzhzT2tSOVFoRmdSUXVEVVJpRmxYWFhZQzZSWklZWElS?=
 =?utf-8?B?R1lOM0x1bUZtVnU5K3pCTUpVMlRqZnBCbm91SEZBb0cwWGFUdFM4amdJblBS?=
 =?utf-8?B?eERxVTRqRGN3azFldmN5Q1ZVbk1MV1NPUDNKcDhCcTczYVorWlN6TjV6eWEr?=
 =?utf-8?B?bVlMYjZGYStvYkhsUTlvKzhTdXBmUEhlT2Rwc1F1c0d0SmV3OHFYOGdwNTlQ?=
 =?utf-8?B?cTVsa2pPOXZTNUNNbmRzb0dpSmlkYUhITWMrOCtXbWcxMXBpdXJURGVialJB?=
 =?utf-8?B?dVExM1NRU0kzUWNyR3NJbjFHcjJtMFRPZ3FGWEs2M2ZiMlowTkZod1lHQ2Er?=
 =?utf-8?B?UjQyQ3p4aGV3eHVOemUyTmUrUlhOU2F3S29Ib1YzWEpxalJMUGpXK1VyVnZk?=
 =?utf-8?B?a0V5WDlEb2NPWHV0dS93eDliUG03ZllIV3NWTUpxbG5sUE1UQVFDU05hc2Z6?=
 =?utf-8?B?NVF4bG1ENE9nZ1FkTWJpQ3lwVDdVYlZOOWZrdGNIRVZER2NhU0ZsbkVQellj?=
 =?utf-8?B?dzdoTHRpMkZxaU5lMGVoa0JBZzRmcUprZUhkaXYxR2pITElMdUU5VmNibmJa?=
 =?utf-8?B?U2JEVlo3SG1QZ2hCZUpsOXJWQmRNNjc1K1ZqTmgvR3BSc3FvekNkM0NzS1ZL?=
 =?utf-8?B?UTNMZGtRMHNqZVJoVEF0b0dGUG43bWxmdiszV081ZWpaRUtlU2R1N2kvMHY5?=
 =?utf-8?B?WlROaDFvYTZjUHRhYUFIYzdHdUxtdkllLzlOeFJBL2lUSkFlV2VpRkIvSnZO?=
 =?utf-8?B?Zzljb292cUthNW9SenNVVGsyazl5K29ZanR1VEszbENKZmQwS3VLRlhhRnp4?=
 =?utf-8?B?aXBxcFF3VGRqeXE1UUwrMUVPMG41UE1vVnlvd3N4WmtkdHMzQ2tWZmtVLzRE?=
 =?utf-8?B?VTF1a0E2NlBwVldSWGUvM2hpNFRUSFFQZTJoYUI3SWRyRmFWaXgrTHZjWTR6?=
 =?utf-8?B?QWI0ajh2WEJINW8yY3UvRWplcTZtaU9EdUM2MjFCNGhMT1BON1pPKzVtaGJB?=
 =?utf-8?B?Nmg1bGpJSFFvWEdrR21jVW9DNjZFM0tWWjY5WG1wc1MyRGRmVW9HVnVVZXAr?=
 =?utf-8?B?TDdRRnpoSjM1ZlRpR0VCQlROR2xmOUNoZDZ3OE40YVEyKzlQR3QvOEx3S1V5?=
 =?utf-8?B?SUpBcXNwalhod3R0S09PRFM0SmFjOGY2SzY2dUVVRzNEV0NVQmFRbjNjNkR2?=
 =?utf-8?B?NWllRG93YXNWeDlRRkVoRmtYYjhpRklGU053WWFVNC9lNDRLZk0rZzN1ZDNT?=
 =?utf-8?B?YXVKbVJIT29URlpGVHNNYzgyT3hFU3BKTis3Q3BWVUkxTGxTUXhlekxsR2pn?=
 =?utf-8?B?Z2I3ajUxODdoZmZIQ2xVNjFFK3RIblFUQ2lQUmZUMEQ3dXlYdVdNdE1pUFRS?=
 =?utf-8?Q?d3QZSDFLfWqr0F2ZuJ2WzHjHu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b4b468-51e4-4de1-bf5f-08de17d73517
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:10:21.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDddzk2eb0lckWephLlpm1H8+yt1FqJn346QIWEQR1yRKGOq3KfL4GzawawpXglg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922

On 10/30/25 17:10, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> system_wq should be the per-cpu workqueue, yet in this name nothing makes
> that clear, so replace system_wq with system_percpu_wq.
> 
> The old wq (system_wq) will be kept for a few release cycles.

Oh, good point!

> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8c4d79f6c14f..2f8160702f9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4798,7 +4798,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		}
>  		/* must succeed. */
>  		amdgpu_ras_resume(adev);
> -		queue_delayed_work(system_wq, &adev->delayed_init_work,
> +		queue_delayed_work(system_percpu_wq, &adev->delayed_init_work,
>  				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>  	}
>  
> @@ -5328,7 +5328,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  	if (r)
>  		goto exit;
>  
> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
> +	queue_delayed_work(system_percpu_wq, &adev->delayed_init_work,
>  			   msecs_to_jiffies(AMDGPU_RESUME_MS));

In this particular use case we actually don't want the percpu wq.

This can execute on any CPU except for the current one.

Regards,
Christian.

>  exit:
>  	if (amdgpu_sriov_vf(adev)) {


