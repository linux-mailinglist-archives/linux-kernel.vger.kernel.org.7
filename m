Return-Path: <linux-kernel+bounces-716653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156BBAF896D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 09:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8857BCCAE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9329B285C97;
	Fri,  4 Jul 2025 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P0PNB0eT"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C22857F6;
	Fri,  4 Jul 2025 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751613955; cv=fail; b=YBWzFEIZFzNmOy2SIfFQ+mL2a8JetvpxsAI/V1a1ltWMokcUxrKoKiPie43A8xz4vWKTeGXN/zGOjkF8CKUVxmlVINeJ3qkVjhw3URHgK6ZAJrJ4RPR1hp6BepAd1kVUa2emlOTxIg2UAJhhhniUfEui5PCeM0Bo5rDCvHW2Jy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751613955; c=relaxed/simple;
	bh=N7j7Jo5F0QNM4MLy7IL1ZLY6FGlrQTnEd6AxhyqMkQE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BJ1eQcuSCj+LgF5l4uuLQkCuivVAfJnLighmjD73LpvRI6XibB33oh5QWqpku+2RZIf4ydG8DCNfMxn7RK/V1PVJ/JDNSEcgptVDtm1fBj0xUXcYCbEIWXIvcKlfFA+X6+QadRiovXkfS/YzSiZPKPLAQgLP/Y8AX/T9xAOGHyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P0PNB0eT; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffd9RgQvFhh9GIQ/XW5gulkwagW2VGf2OPb8VQwI84wpRnfyy8ofLS/uCni6eF3kx8up6eCmD7BSWZk9D2JtPO4w3GNiCmggRjeIyyBzQid7tfcQs26mdwaMNZ1LG4AA+gJ4btExdh5UMpD/KWnGsZOZnCihAqRKbzi2xoSqQ4z9X/U7K4qTfiQXmajyezQL9lONw8zezrjayx7Bd0iY5q/eh6VoLvt0XstPj3O58uAl+MmztlLk7RbnGaj1KYzc8dpn6iXXSNg5cX+hE8fh4++U1BAAK/8G++0FxPM+qubP4Blc4Rwi8Utps267cWC+hxfg6UmRZ0j2hQMVBWA4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ENSC2UvzRL96E1n8jjcyWaZrEByVDLMeK/OijhzFkw=;
 b=fndjda9Y7RgBpYJTOTX/a5haUm4yjzxK8SFOOwVk5cQ0fqkgXiejQy479vIdixGoAXJhXrCoT7xgQojuMjpNZpovusY4+ozbUiLjrJtlorg6JtULXBiScb63+wcXIEmaUMaL7rSsnOpbwI4mnSjn5ksZt1kEqDkWmJrkVj96qomhpmU0RLdDwaISIbMA/CoexAkSOlrHrIclgqHjmh019fPbrKDkvfeHlUVfqCU4nIB9j635qyZktfo1mX8lFVroflLfhfVfI03IrBNjrDv9lkb1z88MhNF+yNMesZ11E0lxEqWMLvguzOiCo43yPEN/Pdu528sHPSYwlRvtZEo2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ENSC2UvzRL96E1n8jjcyWaZrEByVDLMeK/OijhzFkw=;
 b=P0PNB0eT662jr1k+B/v8lrQwtiS1chMWO9DXZtktiTr5HYlJhsdCdWSw2QdHpcp5pUhE2kZRSGI5/2Y+2nfy2/O0oAwSXmLBr2BWajt69H0QSXm/1N+3DzOhxUdeJ2NpOYFGGsblekTDZxGbyrSf8h0Hi0gxxihWVufr380lnCh+l1+40suqfj/2oBjQxB0arRVPPbZ1u+W2Gno8vCDUhrP6Jip8JqzbQnmChSOWseFFb812T02d8j0w2Nfv5hR0S2DkhaHFROtukWqPOK+mJWyrX9Bx0BpAYlpozPm2dgI4N7vD5fwjXi9tG3R7I2r8ep6FF56tq6IWMWHRRraeeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 07:25:50 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 07:25:50 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 04 Jul 2025 16:25:09 +0900
Subject: [PATCH 08/18] gpu: nova-core: register: add missing doccomments
 for fixed registers I/O accessors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-nova-regs-v1-8-f88d028781a4@nvidia.com>
References: <20250704-nova-regs-v1-0-f88d028781a4@nvidia.com>
In-Reply-To: <20250704-nova-regs-v1-0-f88d028781a4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, 
 Beata Michalska <beata.michalska@arm.com>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYAPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::30) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d5a3b8-53c1-436c-4aaa-08ddbacc0098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjFBUUdKMU13TFkwZFhqS29ISTB2eERBZ1ljQnhkaTdOOTFNNElLSmxNeDdD?=
 =?utf-8?B?Q0lXSUhtMFlkWSt1ZGM0TmpqSmx2TDhxZ0NkWU5Dc1FhNm9Pem1jYzMwZDZD?=
 =?utf-8?B?bWc4V3RPSStDbjh4WmZQOXVoOXNwSjhuQlRCVmhkWlBjd1lKVkZiRzV4ZTF0?=
 =?utf-8?B?RTVOaE1EYTlIZTFMVWlMOEFOZjJjVjdMRG9VV2VKVmdxUTVicHJ4bm4rUnlO?=
 =?utf-8?B?UStSdDZTUjNZNno0Zks3Z0VRbGRidXJlNVhuVkhWajF1ZGJ6d3MzRGpzR0tT?=
 =?utf-8?B?TXltakdvZVgvd0RUL05sWWxkT3R0VGt3MGh3RWRhd3BxMWZqR00xQ0xrNy9P?=
 =?utf-8?B?K1c2RThPUy9jSDBmNlFqdVgxeGxMQjhsTnVWT1ZPZmtmcmovUXN2VGRJdTZF?=
 =?utf-8?B?REJIRnVaNjFFVDI3QnFWRE9oTFA5UHdCdC9YYkZUeG52bndYTEtQRTd1ODJ3?=
 =?utf-8?B?MGFUKzFERmx1dzR3Zjg1MkphbWt0R20xQVh5SVI4eXREL1lQeUNPYllxV0JH?=
 =?utf-8?B?aWM2em1aZlgxSmo0VURFTXcvaDRmS1Y0NFpRbm9jQjd5bVIwcjdpZmxJSE4x?=
 =?utf-8?B?QVd2VWdsN2tBTlpvQzlhbjZlMHhJOVdqeGh6bEdkZVFxUnhFOWw3UXAyQlFR?=
 =?utf-8?B?ZWpPY3hCbjI5VXUyTzQycVc1M0VvMkNoeGZ2SCtNcStCeEtMSmtkYkVjMXRP?=
 =?utf-8?B?RlVFbmFEd2pTY3VnbWhnK0hxbEVzNkcyNWZ1Vnc2ZEtxS3BocjlaMUVjNi9h?=
 =?utf-8?B?ajNCNS8rZjV6Y2dOaXRmaTBwSlFNQTRUSlM0L21LNXk4b0R3YTQxSzJ1dWc4?=
 =?utf-8?B?aXJza1dEQTBYdWxaZE53RzllditTekZNdTFHTlNlZ0hFQjdvWlNJRjJWK3Yy?=
 =?utf-8?B?VTJLV0tWNzNaK3g0bFFMeGRZWEg3NDZHYm9mQTByZS85RWdlYkJBd0c4aHcv?=
 =?utf-8?B?dis2a1Q3NHB1WmNETU1zeEZEd1dtalNkbXBlY0lWTEc5VHptZ1krOTNaa0FJ?=
 =?utf-8?B?Y2VjRVF1RnE5ZjFKc0hqQkF3ZStsc08zS21GTnY1eHhYUkUyUGpuZVJnWThJ?=
 =?utf-8?B?a0I0b3JpbUZuc0g4UHpJWG93MlpXSzN0bzZ5QWtJN255RGRhNTlDdXhHUUsv?=
 =?utf-8?B?UkE2TndxKzB2dkR0T20wUGZoaW1FM2xMTGIwVEN2d3RSNDdvYzZFTmtpZk5B?=
 =?utf-8?B?ZUd4eWRGdUJsSGN3SUY4c0kvblFwa05RNnRqRzZmcnhSSmdmRWs4VWlxdk9p?=
 =?utf-8?B?WWdyck01ZldGOXVieWd0dlRmTlJ0T011RU5YNHluYnQ3b2I1WkoxQklma1V4?=
 =?utf-8?B?MlBBZktuVnFkcnlINmptYU5ycVVLS1NnT3U5UEk1NUlLRzMyMVg5TGNpVHNa?=
 =?utf-8?B?a3NXbStsRjE0WTA3SUo4bEhrTExBWllFaFBaQmNRUE1EUDJPZGdUS2Y0MDhn?=
 =?utf-8?B?Z1lXVU9JQzNrbUNtanQ1eVIvZzFkUHVTWUFYT2Y3RnBMaTRvbys3eldzSHhV?=
 =?utf-8?B?TG5oV0c3R29FVnlyc0RGeWQvZWprNXVaZENFbVNxS3NxQU9BdWJjaUYxUXZy?=
 =?utf-8?B?L2VkZjUwbHU1dXd5NEJweHBhUzQycFJwOWRGWXIvWXhvTkorNFU2eWhOL0V0?=
 =?utf-8?B?VHdPSVZLVXdhenl4YnNqM1grejhGa09KZkxPbU1WYm5mdFFNeFlubjh3RThG?=
 =?utf-8?B?TmlXeTMxQnVsa0hETHBCQVQyTmt5QVIzN2NON2pZaFVjRzMvOWlPNnVHN09H?=
 =?utf-8?B?Vm1DbkFQZHArc2FvbExSb01DM0piSk8yems1a2lxS1YxQjlvd3ZrcW9ZMHFH?=
 =?utf-8?B?M2NVYmFPSmd6Q0Q1RjVIdXl2NDlsTEJwcHBPYVBFUURPcUFIL3ZsdGEvbnZB?=
 =?utf-8?B?ZjFRMkp1Z2Q0Nng2S0dwa0c1WHZhREVSZUMycFN1NjhnSmNNa3lydTdENkxB?=
 =?utf-8?Q?WG75bZOfIP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2FpYmJpMm5FUEpMeVBzVFFac1BJbXRwa3gvNnQ1WDdmL05sSmJQSnhRKzBh?=
 =?utf-8?B?YW5DcDYxckh2cGVQeU9naXRhS2tUeVRGYnpSamhtak9vS3BMbmcxNjZvSFRN?=
 =?utf-8?B?bW5ZSWZ5ak9nYmcxMHdIN1piOFRYdEJDeVhtc0VRMmdFazBBVzlMclhzbk9n?=
 =?utf-8?B?WDRuK1AxZXQ4NVoyZEFSTXYvZFN0REU4Q2RSVVpJUzhKQTFmNzdVR3ZMbjRm?=
 =?utf-8?B?Vm45TG1URDUrbWNVdGZjU09NZUdHMkhJU1B3SWd6OElEVVRhQ2U5a0pTWVYv?=
 =?utf-8?B?Vlc5VnJ1bzh1Nk83cXZtOVFxczdUN09XL1B2K0ljd3JKdHNjYk1mazl3K2hB?=
 =?utf-8?B?bW9mMzFQZWtxc09uMGFnbmVWZThhdkk4ZEtFY2dWVlNMblJNY0VRZDhHOExz?=
 =?utf-8?B?OWVVbVh4RjdvY3VwTlRub0NSZ0NOY2lFMVhVOWo2bXFTSTJXL1hVRGwwMFFN?=
 =?utf-8?B?aHBvb2JhQXZOb0cxMEtWZUN1QXJTLyszQkFnUlNhekorM1ZtYS9uaytGMU53?=
 =?utf-8?B?VldMRnNiK1doN1E0U085MDJNclRvM3VjSXM2eVQzVnpJM2pLTlNjNTZWLzYz?=
 =?utf-8?B?cXhsa1A3cml3NXErMmk5OVBmcDJzaGFBOStGWURuQlAvbFlBNUh5VVM2cDRQ?=
 =?utf-8?B?WG9JRDhOUXpFeWtPb091WkpYOFNrdThPVGN4ZnFrNWFJYzJDRWhPZGVQcW9F?=
 =?utf-8?B?VmxMeGpuK1pFYnJSMGVBU0N3ME9aQ2xOdkpTMnZaeHNac2xpdjRzMm8remhN?=
 =?utf-8?B?M2M5VGxiWU5uZVVrUFR0Zk9hNVFoRk4walBTWEc2dXhCM09hTktHYkwwUUZ5?=
 =?utf-8?B?UUlkTVhKa2tDdVZEekVjYVRLMFE0R2FIcFNRVzVCUi93VjZ2cG5ReFVWb01W?=
 =?utf-8?B?Y1pldnd3SDJnRERGelY5V1I5WmF2R0lEeUFpaXN4TjYrYnoxNzRYTU1UOVc1?=
 =?utf-8?B?WXNjSHk5VTJJajVldmZUNUlWOTBoNXhjWGVXbzBTQXNlMnU2UUErU01YcjFh?=
 =?utf-8?B?MXpNRFhEektCTjFwblliaVR0NnVrQjhJK1ZxajVYS2NUMDd5cGg1bDdLNGsy?=
 =?utf-8?B?L0dJRktaNXB0c0xpL080YXNVZE5jejc5bUVuWFhZL0IyUzB4dmdwSlFrMnpz?=
 =?utf-8?B?NE8zeWFlQUN2NCtXamFnL1BVdGd1a0JLd3pMWnovc3JadjZYRHNBcVR2SHNs?=
 =?utf-8?B?V09GYmVsQnFUalhQNjJnNzZ3U3h4Z3FSczV1RzFaTUFhdnUyYk9oWFZ5ZEZP?=
 =?utf-8?B?MDRCczVzTFExa2VDRytyekc5a2JXK3V5UndzQlU2SWIvaXloWGl6bkgyRUty?=
 =?utf-8?B?Mll2aGJhakFCZFlJZVllRUdRU1R2MWNaUWtDR0x3bkJOVkYyUHlNYWxiNVIz?=
 =?utf-8?B?RVNKN0RRNnJwbUJSLzArbHlCZjA4TFRFUFFjOXRiWjN6UnlCVVFKV3NGU1oy?=
 =?utf-8?B?Sm94L09zbWJFbUVyT0xCbU9xNVA0MzFCbFFzcnNMdVN5T25QK2t5bnRWK3pq?=
 =?utf-8?B?K1Nmc3lUc1o0QTRXekZEQmVpd0g2TThlWTZzdDVZRGRvRmRWNUlMcHdCYW0z?=
 =?utf-8?B?R3RYN281K1UrTFlvNEJDYVI4TTIxODdNbkUrUjN6dmdkdXpwZnR3d25RdlV4?=
 =?utf-8?B?YUdZUnNWYTNHVkRQU1FSMVN2ajhGa0ttVnpiZlIvVmJzUU5SUjNxeG5ESE1T?=
 =?utf-8?B?ait3N0JsUkd2RmxvdThIZnlucHRPOWZQRFlyTEk2Q28wRmtINWY1cWxKcFZ6?=
 =?utf-8?B?YzlCd29tcFBoTjJ6WE9UekhMbXhTekd6Q0pFNGNtZzRwL3Z1SVVZS3hkaWpR?=
 =?utf-8?B?VmdISTdjOUtWelMrT2h4RlQ4SkpIL1JxS2VJa1BRM2ZwWmZpWGNxTXBQWWs4?=
 =?utf-8?B?UTFodFNCYTRlVlMxT08yeFNka2szZHJONDZSRE05WUJvVWM3Qkc5VEF5R3pj?=
 =?utf-8?B?MGVvYzN1b3o3L3k3TWwxei81N1RYUHAvbmtqSk9TTDZuR3RsSVJJYlVNcU9L?=
 =?utf-8?B?aVU0MmtiZWtiRUt1ekJVeUh1MFJGNkFqMTJtU01xcGRXYnkzVU53V1F3cDRy?=
 =?utf-8?B?amx0TitRUFVuT1ZGU2VYcFZKSE0vbVA5RHhqczVINU10YmpOZ3JzYy9FSTdZ?=
 =?utf-8?B?K05wdDI5OU9XK2tkbytKMFVWcHVhU0ZXNHlFQVBvVTl3aVNKdE0wTWZmVkt2?=
 =?utf-8?Q?2S/EZjwzibb/uKx+bxljMz8vn2J40qH2Ff5qSGZy7JEd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d5a3b8-53c1-436c-4aaa-08ddbacc0098
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 07:25:50.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9l7jytMQKWKPr7kSOuVEIIWwrD+taG8pjdXUtE35wm+C6Tn6TAzsWRY26rO+BFtaXnEF0UjyKmkywLnKg0kWJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341

Add the missing doccomments for these accessors, as having a bit of
inline documentation is always helpful.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/regs/macros.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index 73ee72a6c7baa7e9d1032ec0da119940b8f1a3f7..60e5e6a2250a9db453a7a648108af6acaa047342 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -300,6 +300,7 @@ pub(crate) fn [<set_ $field>](mut self, value: $to_type) -> Self {
         impl $name {
             pub(crate) const OFFSET: usize = $offset;
 
+            /// Read the register from its address in `io`.
             #[inline]
             pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
                 T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
@@ -307,6 +308,7 @@ pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
                 Self(io.read32($offset))
             }
 
+            /// Write the value contained in `self` to the register address in `io`.
             #[inline]
             pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
                 T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
@@ -314,6 +316,8 @@ pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
                 io.write32(self.0, $offset)
             }
 
+            /// Read the register from its address in `io` and run `f` on its value to obtain a new
+            /// value to write back.
             #[inline]
             pub(crate) fn alter<const SIZE: usize, T, F>(
                 io: &T,

-- 
2.50.0


