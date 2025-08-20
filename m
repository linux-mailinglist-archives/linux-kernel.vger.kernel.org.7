Return-Path: <linux-kernel+bounces-778343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39444B2E46F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16361BA2D85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E665270ED2;
	Wed, 20 Aug 2025 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1rxqzk95"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD61A9FB4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712497; cv=fail; b=JQLEO7RW1UFrPBduM5319PsR3N0hOmVlcye91WoYtM9g1fKa9t0Jgk9q6sfK58XdwqONR64C1AZ3/gsX44kUg1LvCOBn+xxS4ZshVnl+ZzvVHvPo/hSDGjtUXAi8PfLwuH+mOoeKKeUAEpVf46qLpstlamTEtftf776dDUVfX9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712497; c=relaxed/simple;
	bh=G7m2lXzfWVWXAgtfV7E8U3S6ogd9ufhwAlWks171hb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJ3Z3np5yKAltJElGaYPdGhJ0XFoD+Q9+pzmINCxIFkpkysfg5PN/j645QVD0mVjqyLCqDuwOsY+rZDjNGv8pmusPNAeVn1r9YctRmYmszdNPudZCTUn9Odo2RT09x2c6wo4KyKq18GJifRgNuGHhOp9pN96ibM8L1h/tNSYsy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1rxqzk95; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JA5vdKatI0rvR2zLkULfwmQCMVpSEQO5BRxpTM5VmQO9d4CoQADcZZRuZGf/FJaiXcKiRe7MoGraqoYI9fHhS5AFoUWBsF7FamXozl93/OLYLPKJVw2cbs6MEg14rGz2UFq9Lj1TvgKIpj+i8lbTCiUS3bpXyTm0OII0fPWEAZGdAwxz7Rf1zXd7J6YtT3F8s7+CFQ5t/9BQZ1lkq+OS5/20d+Ew3S4etr6rt6lgLpIQHRWBM49U8NoQ8lLEZy/Gf4Sl08KEm09L4ub/i9FhVLUfBLmVrCGLoe6LQYWcaDebD/rr2jAR/0gwxq8jRMcEPRY4TVK7tb9D3Z35g6gNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7m2lXzfWVWXAgtfV7E8U3S6ogd9ufhwAlWks171hb4=;
 b=DhoWnoOe7UN9AdBtQ003ftik2w02l0zOhd6G5VVCRvMq/uIl0RgH5j1ELb4ZB9j1aCQ0/6/rjMUOgxWjiPLlLU1AAy+GhrsrszsR2PZv5BYo7RuRN1bdcygeksV75nEaqbuORt3aJLNODS3xlocZ37MXRVUx4AeuCziNsHfUE/1TePj2N0i3qE/cD9jnTEt6IbOqVVxLPsJCq8CSLO9lCePhbDz3UJ69N8IEk/vIA9EVqTYsRLWazfM0hbxxmYR+VcZ2tu8OvdeIHTEDVYj+b5CQgha6TTQ6iIL/iHWdVRYBNO0TxeX1DU9OTYYN5WRH/Qq6tv/M1cAKcPdUdmMCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7m2lXzfWVWXAgtfV7E8U3S6ogd9ufhwAlWks171hb4=;
 b=1rxqzk95fJhDRDHjFBSp/0QSN+E+2FoQwE/3j9TCfmggB/Z4uGcCvYsTFpzhWht3E5W9lDeZYnuEGyqpQ9kG/pAvjlst3KO61xbeB7pPkKS3Aoun7vxGIywx8UYFm8is4HcnyhHnbB1pJ9fX/sA9t4HEHBxmgikJOd4eQAPfUZc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 17:54:53 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9009.018; Wed, 20 Aug 2025
 17:54:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Brahmajit Das <listout@listout.xyz>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Lei, Jun"
	<Jun.Lei@amd.com>, "Zhuo, Lillian" <Qingqing.Zhuo@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: clean-up dead code in dml2_mall_phantom
Thread-Topic: [PATCH] drm/amd/display: clean-up dead code in dml2_mall_phantom
Thread-Index: AQHcEUnJVTo3YtgV9EOcKcIvoAmharRr1DzQ
Date: Wed, 20 Aug 2025 17:54:53 +0000
Message-ID:
 <BL1PR12MB5144269A278EED9AC3CCEE7EF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250819204207.14407-1-listout@listout.xyz>
In-Reply-To: <20250819204207.14407-1-listout@listout.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-20T17:54:06.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV9PR12MB9830:EE_
x-ms-office365-filtering-correlation-id: 784c989f-a940-4ca8-1c68-08dde012aa97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkwyTGdBdXB0RlN6M1UrZ0tUeUNsaTR2Z1pIWXE3MFVheDl6RjFCN1ZvL2Vx?=
 =?utf-8?B?Snl0emVWNE5hRHZGeHNJL0N3Ung4U2dtdnExMmhMcGdZL2ZWVm1HYnUxMmpZ?=
 =?utf-8?B?VFlrQTRqTmtvVDk3QkZUd0lWMEhRWmNQWWdmZTgvZ2E4U3hpcTI3QnJRV2d0?=
 =?utf-8?B?WTRiaTl2Qnk1Z0pRZXd2RE1VeWhGVWo2WXlySitRYm4zQWZ4MWpSekFTQTZS?=
 =?utf-8?B?QWs3bGJWZ3lMY2NVMWlzOWo2ZHNZK2VhNUNLRklwMGdjOSs0eGZtc1dFNG9i?=
 =?utf-8?B?cy9wTkpBazZKSGsxN2ZYVE5RUk5Vd3FYeHN2SlFYY3lpdERWUWE4dHV3WEMv?=
 =?utf-8?B?QXVIL1hHbGpIUG9oeUhNVDQwc0VQN0lVUHZSOEhtTk02RjE1OURHMTNrbTdJ?=
 =?utf-8?B?Y3dsSkFteXdPUDhEa3dtSElEOU96SWRoM1o2TnhFYXg3aW0rZmR0VENQZjVv?=
 =?utf-8?B?czVlaytMTmJhMVRoZ1RYKzVBSStIbVdwbUFMaDBtNHBNc1ZMVTNLZHp2eStT?=
 =?utf-8?B?WnRvMFB5MGZuVG8yQUI2TmRkU3ZMRGhtQ25FRDg4MitBYW1abUlEL3NEeHlt?=
 =?utf-8?B?eWhNazRvcUpvaHpPTFNUeGJ1R0tNdVNrSGhPckZmN0lHWkxTN3NKaGtwRHVQ?=
 =?utf-8?B?MW1pTzNqV1ZvYVJjYTdtRE5RcHZ3UDdZNFlHWmF5ZGxONlBaMVp0NWFKeWo0?=
 =?utf-8?B?SjVtcXREc0Nqa2lUcThJMnloSnNDWWI5VXY1clVyTVNxVklHZFc3eHZXMFNa?=
 =?utf-8?B?eEpoeStFdFVnd1QrRm5taURYTTB1QUFRVmZMVEhwcnY5dEdxaGRmelRNOGNL?=
 =?utf-8?B?VE16TjFDYU9PV0JLZGV2OXA4SC9QcnhQaWp0MjVjWDA4K3htQVJQcDNkR2Uw?=
 =?utf-8?B?QWIvc2dYbUVRODFOWnFxR0ZkTUxsdTBYWlZIckIvOGtSZ00zKy9PMWtLbFNq?=
 =?utf-8?B?Ryt6VlQ0b3pWVWYxOXFLeHF0Njl0U1lCYUp6bXVkOFdiNGFCRzltNVVXb2wr?=
 =?utf-8?B?Y0ZoV3RmRlFQWHRtMXZmaHJyVnJPNm52V2o5anhIMGdlQU9KSGRXaVRSbS96?=
 =?utf-8?B?dXZtL3AzZE5USEVJZVR1bmJnLzAyWWxQWHVvQURhMFNkbU5VTUlaMG5FZnFZ?=
 =?utf-8?B?dDlvb2tNbzhNb3BMbUM2ZURPYnVGems4NXhLV1I2ZjRnemVYa1ZYdHpVL2VL?=
 =?utf-8?B?clA5VUh3bzZpUmNaZk5YcmJLakRxMk1jeTRhQXNkemc5UUt0dllTeVVKWXVK?=
 =?utf-8?B?OGNzSDFOdDZ6ZzBLQmI3TGZza1YrTWxWS2E0NmptUWZXN0pKZFlGaVVRTjZr?=
 =?utf-8?B?UDhwenRCQ29xM0tscFd4NElpNzd1a1RWT3lCaldyNG9NRDQwVEpQOFZGOXo2?=
 =?utf-8?B?ZkZvbXV4a1FsK3JMT1JWU2FKRCtGb0JHVDBMRnhmTzB2ME9FSmtkd0J4QkFT?=
 =?utf-8?B?YTR6TUlQTXlDWFRYSEg5azFJSitzYXN2M29jaCtiTkNoVDRON0FoeXpDanc2?=
 =?utf-8?B?THVQUVJqOVpORUxXaDE4Qm96WUozeEtxbTRGcExTblNVTlFBNjhQUlVFMXRF?=
 =?utf-8?B?Y0RqOFgzTFNHVS9BUUMzNXZTZXdod05qSk5EQkNXZkFYTVVlRmhUeG1ieUhs?=
 =?utf-8?B?YzU1UHJMckJ1NFpjWGpQdGxjU3lIcGlSVXphSkRKeHQxRXp5UUJmc3BzeHgz?=
 =?utf-8?B?aFk3YUhnSzZQOW02cmNqMWlhbUh6dEc5dFpYYmt6TEZQTlJPUDd5bVBxYXBv?=
 =?utf-8?B?aTdnT3k5eU9rZ1c4RG9raWd5bVl2NTZOdk42OVg3RHBsdmY0czYvamhPRFRF?=
 =?utf-8?B?ZHJtWWd6TE1MTE1uQTVvcjFaREhvUUpSQUoramtscDZuaDQycE56VEtzVFI1?=
 =?utf-8?B?WFphNjFpTUxlaWhLQXh5Z1cydnQvNWdDTm4rM24vcnY2R3ozQkkzVm5PaE1h?=
 =?utf-8?B?UlptLy9NZmFkK0VlakdCTzdxeFNXVEQvN21HZmVNcjczdjBsMGZOdVNOMWZP?=
 =?utf-8?Q?gd6QSFRAtx/5+Iwj4HMdXy/xr3HRgI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGZtcGFLc3NDVzhyV2VaT3lzYmJpU1l4MjJXL09aOXZlNmltVklQTXdZbG1D?=
 =?utf-8?B?UlAzdENMTnpxcFBhSVp1NkdHbUFuYVRjbm9ZZndMZGx1M1VTTTdJd0pEdlp0?=
 =?utf-8?B?cElIR0NEZFUvL0psYytpRGhzcCtTTzNkL0N1bEEyZVZzMGNWREduelJvMDRi?=
 =?utf-8?B?d2I2MWs1bHRWenJUcXVIYkNRejFGV3liUkVaY1BTcDJaZVY0SzhQMGkvYVdY?=
 =?utf-8?B?dDc4bnpQU1UyVG5pWFpxQUZOUVZId202Q3Zrd1hOZnY1RU1JRE10SWxMUWkw?=
 =?utf-8?B?bmo0cHdqR2VUc05pMFo1UTN6RzZpY1hOSmZ4cmpiVzBnS20wNTRkRk5iWmVP?=
 =?utf-8?B?eEtIWDIwNFhYMkdZc1pGV013RE8xVjdiN3VSbUdyWm5YYzRxNzgxOEVWK0FU?=
 =?utf-8?B?S25hRzkxb3FaQzNOcEUzb3RkUUJhN0dOZzdxS09VWlNEaG8xRHFDRk42MmU5?=
 =?utf-8?B?OFJNa3JFVi94VC8za3RTU0tsbmVCWVFjb2g4bFdWSExQd2s3MUxXSkRZa3kw?=
 =?utf-8?B?L0VnUjR0NW9EVmExK2NjcTRVd2lZOHFlL20wRUtwTVl1dzJiTE9GQldsWW5F?=
 =?utf-8?B?cHRnV1RVeXg0NmQ4L1pFRGsvWXR2YTN3Z0FYYWtuaDU0cVBVcmNib0tGT0RK?=
 =?utf-8?B?aGYvazFQSXpQZjByU1FyZ2lsUlVLbkZ6M2VLMHBiWTViK2lMc2dLZW8vM0FJ?=
 =?utf-8?B?ejQ5V2pCV3hjUVNMWCtOVEVBd1pEUysxSVRITDJVS2tFUmpySlpEd1oyNGxy?=
 =?utf-8?B?TDVjL1VDdTV0SkdRVmZkME0rOHhyUHExN0E0UzBiUm40cUdaeFF2bStXNUx6?=
 =?utf-8?B?SWJDSkJDODRVR3Q2bEpWa2cyVXlhM1R1dUh4aTgxMlNha01PMnBzMkIzT1pG?=
 =?utf-8?B?TEJpK09UZWZ3VU02aXB3cFgvVFVhSW5HeUNQdXlXQldGMU45NFBIUkVpN3Bj?=
 =?utf-8?B?bkNtbjNuRGdnaDdxUThJZVErMXN6YWhRYVFUQTFmaWwrR0xYaVhmZzhUNUJY?=
 =?utf-8?B?dlVQTmViWSsxd1c0RXdYN2pYelFrSCsyVzRjazNpN2cxOUFFZlA0TjdIbW04?=
 =?utf-8?B?VDg2QnVBRUxJNWFvY0pNcVplbjR2aTk2Z0hQenZqemJlcVVaMjdrbndkUnpo?=
 =?utf-8?B?OTQwK2YranRuZ3EvMXIvamdLb2lkbmRESWkyYUYwRlF4NmtqKzcxK2g0NGFh?=
 =?utf-8?B?dFcyT0h5VEFpYnBnREp2bGFEbFp6R21wMkxKZHhrUXdPeFZBQkpQcVU4eUpN?=
 =?utf-8?B?cTZlMVk2MlVaaWs1c3RXeDVkWHBUZmUzdTlJV3pzWHBqRkxWdWZaNFFuMEYz?=
 =?utf-8?B?YjY4ZWtiQUFHMnl4eFo1Q05TUEx1c3l3bzVnMHVqVEtITWJIeGhWdXQ4ZTVa?=
 =?utf-8?B?YnNrOUNxb2VqMnVIenBqbHl0TUhGSDhxZEk1ekJIdy9wazl1c2lVNzlQcGhU?=
 =?utf-8?B?ZmVoUnJCVDI0eUFQUXhoaTI5czlSRFdHV2RFazVnVEw1WGsvZ2JOUnVKZGVq?=
 =?utf-8?B?VDJsWmlnN0dvMWZweEdQWkoxOC9ZZ2FvU1Vza2tmUmREbnZqYkJuR09YMjl1?=
 =?utf-8?B?UEFOZC82dGp2TE4ycnN6cmJQQXNJME9DbSs1aG1KNFY3RWlTM1J6c1JuNnpa?=
 =?utf-8?B?bnJsVVlJOVd0Z3VlS3NCMTh4SFRiM3RnTnBMMUV4Q3VSc3RXSUsvUUpoOXJi?=
 =?utf-8?B?UEYreHV4cHdFbkpZc2hYREVweG93ZVhRa25RdzU3N2xrVnAwSTVZRVJkNFda?=
 =?utf-8?B?WlRMR0JBVnA4bUg0NHJVZWNtazh1VGxVZmpSOWVPOW5ybld6VkVZN3Q1NDBx?=
 =?utf-8?B?M2ozRWhXMlVmRnRzcHB1L2xNTDJPMkFrOWlnYldSQ083K2l4TytvUDB6NTRa?=
 =?utf-8?B?QnBhWlFMWTI4eG90MlprSlJWK0MvMnlyblZpeFRjOVdNY3JlVGxyQTE4RmY4?=
 =?utf-8?B?bnNPYUllemR2RlNWRzU0bjFZY1Z5SXIyMlJIcTdKVCtxMGZhTGRkVTV4QUcv?=
 =?utf-8?B?YzNsUSt1aXFVN3JMSHc4bi9tVWM5TEs1QkFVdHYxdEJrSTJxWFNUeUVEVldI?=
 =?utf-8?B?OWRyT21acmdjeVJGVW9RLzdqMFRGaVFmZ0d4Ym5KRngxL2lIRUhyNWNKZ1d5?=
 =?utf-8?Q?gFAs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784c989f-a940-4ca8-1c68-08dde012aa97
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 17:54:53.2294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tj762CKOpY9dmWzPvP50US5enVTfvUY2v5T0NkWX1iVafWdKBpyG3ELWpmbGSaUC8SWK5jjxK+wMCAajazaTyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmFobWFq
aXQgRGFzIDxsaXN0b3V0QGxpc3RvdXQueHl6Pg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTks
IDIwMjUgNDo0MiBQTQ0KPiBUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT47IEFsZXggRGV1Y2hlcg0KPiA8YWxleGRldWNoZXJAZ21haWwuY29tPjsgTGVpLCBK
dW4gPEp1bi5MZWlAYW1kLmNvbT47IFpodW8sIExpbGxpYW4NCj4gPFFpbmdxaW5nLlpodW9AYW1k
LmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
Cj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOw0KPiBsaXN0b3V0QGxpc3RvdXQueHl6DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZC9kaXNwbGF5OiBjbGVhbi11cCBkZWFkIGNvZGUgaW4gZG1sMl9tYWxsX3BoYW50b20NCj4N
Cj4gcGlwZV9pZHggaW4gZnVuY3Rpb24gZG1sMl9zdnBfdmFsaWRhdGVfc3RhdGljX3NjaGVkdWxh
YmlsaXQsIGFsdGhvdWdoIHNldCBpcyBuZXZlcg0KPiBhY3R1YWxseSB1c2VkLiBXaGlsZSBidWls
ZGluZyB3aXRoIEdDQyAxNiB0aGlzIGdpdmVzIGENCj4gd2FybmluZzoNCj4NCj4gZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kbWwyL2RtbDJfbWFsbF9waGFudG9tLmM6
IEluIGZ1bmN0aW9uDQo+IOKAmHNldF9waGFudG9tX3N0cmVhbV90aW1pbmfigJk6DQo+IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZG1sMi9kbWwyX21hbGxfcGhhbnRv
bS5jOjY1NzoyNToNCj4gd2FybmluZzogdmFyaWFibGUg4oCYcGlwZV9pZHjigJkgc2V0IGJ1dCBu
b3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZT1dDQo+ICAgNjU3IHwgICAgICAgICB1
bnNpZ25lZCBpbnQgaSwgcGlwZV9pZHg7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgXn5+fn5+fn4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQnJhaG1haml0IERhcyA8bGlzdG91dEBs
aXN0b3V0Lnh5ej4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1s
Mi9kbWwyX21hbGxfcGhhbnRvbS5jIHwgNSArLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RtbDIvZG1sMl9tYWxsX3BoYW50b20uYw0KPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwyL2RtbDJfbWFsbF9waGFudG9tLmMNCj4gaW5kZXgg
YTU2ZTc1Y2RmNzEyLi4xZDBhZjBmOGZmYTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kbWwyL2RtbDJfbWFsbF9waGFudG9tLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbDIvZG1sMl9tYWxsX3BoYW50b20uYw0KPiBAQCAt
NjU0LDE0ICs2NTQsMTMgQEAgc3RhdGljIHZvaWQgc2V0X3BoYW50b21fc3RyZWFtX3RpbWluZyhz
dHJ1Y3QNCj4gZG1sMl9jb250ZXh0ICpjdHgsIHN0cnVjdCBkY19zdGF0ZQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBzdnBfaGVpZ2h0LA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBzdnBfdnN0YXJ0dXAp
DQo+ICB7DQo+IC0gICAgIHVuc2lnbmVkIGludCBpLCBwaXBlX2lkeDsNCj4gICAgICAgZG91Ymxl
IGxpbmVfdGltZSwgZnBfYW5kX3N5bmNfd2lkdGhfdGltZTsNCj4gICAgICAgc3RydWN0IHBpcGVf
Y3R4ICpwaXBlOw0KPiAgICAgICB1aW50MzJfdCBwaGFudG9tX3ZhY3RpdmUsIHBoYW50b21fYnAs
IHBzdGF0ZV93aWR0aF9md19kZWxheV9saW5lczsNCj4gICAgICAgc3RhdGljIGNvbnN0IGRvdWJs
ZSBjdnRfcmJfdmJsYW5rX21heCA9ICgoZG91YmxlKSA0NjAgLyAoMTAwMCAqIDEwMDApKTsNCj4N
Cj4gICAgICAgLy8gRmluZCBETUwgcGlwZSBpbmRleCAocGlwZV9pZHgpIHVzaW5nIGRjX3BpcGVf
aWR4DQo+IC0gICAgIGZvciAoaSA9IDAsIHBpcGVfaWR4ID0gMDsgaSA8IGN0eC0+Y29uZmlnLmRj
bl9waXBlX2NvdW50OyBpKyspIHsNCj4gKyAgICAgZm9yICh1bnNpZ25lZCBpbnQgaSA9IDA7IGkg
PCBjdHgtPmNvbmZpZy5kY25fcGlwZV9jb3VudDsgaSsrKSB7DQoNCkJldHRlciB0byBsZWF2ZSB0
aGlzIGRlY2xhcmF0aW9uIGFib3ZlIG90aGVyd2lzZSBvdGhlciBjb21waWxlcnMgbWF5IGNvbXBs
YWluIGFib3V0IG1peGVkIGNvZGUgYW5kIGRlY2xhcmF0aW9ucy4NCg0KQWxleA0KDQo+ICAgICAg
ICAgICAgICAgcGlwZSA9ICZzdGF0ZS0+cmVzX2N0eC5waXBlX2N0eFtpXTsNCj4NCj4gICAgICAg
ICAgICAgICBpZiAoIXBpcGUtPnN0cmVhbSkNCj4gQEAgLTY2OSw4ICs2NjgsNiBAQCBzdGF0aWMg
dm9pZCBzZXRfcGhhbnRvbV9zdHJlYW1fdGltaW5nKHN0cnVjdA0KPiBkbWwyX2NvbnRleHQgKmN0
eCwgc3RydWN0IGRjX3N0YXRlDQo+DQo+ICAgICAgICAgICAgICAgaWYgKGkgPT0gZGNfcGlwZV9p
ZHgpDQo+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gLQ0KPiAtICAgICAgICAgICAg
IHBpcGVfaWR4Kys7DQo+ICAgICAgIH0NCj4NCj4gICAgICAgLy8gQ2FsY3VsYXRlIGxpbmVzIHJl
cXVpcmVkIGZvciBwc3RhdGUgYWxsb3cgd2lkdGggYW5kIEZXIHByb2Nlc3NpbmcgZGVsYXlzDQo+
IC0tDQo+IDIuNTEuMA0KDQo=

