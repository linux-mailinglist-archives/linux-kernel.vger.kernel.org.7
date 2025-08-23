Return-Path: <linux-kernel+bounces-783057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7EFB328D9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A72189D5B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78541E520B;
	Sat, 23 Aug 2025 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VLopo18q"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805E81A9F82;
	Sat, 23 Aug 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956869; cv=fail; b=XgPMIBXyEG+QORaugM/CepFjD+Lpz3IdW7uilyd5KUo2A+Si73nisWirEHdgum+PV4Cen+8dONP2DQ/rAcXs02D9KP7DqHLBWztrUtFo0wqReG8wkYdnYHyNWSvmTFuAKANA2CA8rHF/hTRlWc+RMt6+Y6MYWjexTajGaGVKCw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956869; c=relaxed/simple;
	bh=3E43DWUqTV6PRCeDS4M0pPC0Ws7nqifGui159qQX+B8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GhGCo/M+aExZixWdTtKI/vhpF8wHImse2E5U3IhzevSl/7jYennDS5BY2hUd4ZzV2YKmlCwWp3NZuuyuIvJn5O1OxZ3gHsQlF/lxe6eMpXa7AqNmGM2oGpDTkJYluPfEZmfufvo5m9XzTRvKTdDXe/zzvrFtqcG4yCuOsnkmFcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VLopo18q; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdsY+EYZqFdzinPq2hbfB19XKFSkiYq+z3bc68jc6Vj7Z0yBz2suWfvUQx73DSfPmY4MJfJt20FdQQK628sYp4JVJnyaL6VdxcPbSoy/SyFjuSIQZ/BTUXfKIoExCvgq/qiMjNDdrQMtmDa5EKN8prOtwZNqAZnhhP5gf5XUTq5b0MJdAzSnECC4riYtNSiDCAayAxRTSd17lvZkuQeJVYYTxGJvcxI9aN2O8SA4/Pq8FZB+GmcIcrYU9PIgW0evfogr8l1n1vBrvRGWByG/fQEzrHv3pFB8TpIMbHQ6vplyrjmQ+MNn6Lx5L7IXG+qufW3A0dl1WJArg+3Dyt/Z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E43DWUqTV6PRCeDS4M0pPC0Ws7nqifGui159qQX+B8=;
 b=NOB6P7dL0ChljRjxGYdbUeQMXHMMH8+9MOHQX3sHWjWac28aGzoiY9HQmqcq7PyVjwqwhz9eIkVjRe3jXUQ5te1ZlqhEkYq+cpWMgtBGEWRp7AQ6YzWIMN3UCh2Fap5sYPCAUKZNxwyEBAb8sq6h5bAVYtSWywTYBC4R7ckh4Wp4pi1vaF0en77LxBbbY9vGEJjj6DZhv6RA5zMfAFzU0MtbYC6pu8G5oaq+tyCs16hiJfJFR31kSL+WliHAjCFEGtyrRshvHX4Q+RGRosljF2xWshBFmjOaxgLVcu909HmaPpK9ZcavuDfuB7YKxPAom8ieeEXgrs3tNLz8muQUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E43DWUqTV6PRCeDS4M0pPC0Ws7nqifGui159qQX+B8=;
 b=VLopo18qYXXP4iYxlx5IYnKyq7A1dbNtgoY8zh/cvD3u6Ry7w4e6bXANmyg6vlHmFkOIkvtBXdQB0f06r8Rvp4uxRhKpz3Is/d9m6maya1GtSA0SKttzVcXdULhz7lVQybhZjiN7PpJAq4Ugc7BYLOxwpUMa9m1pcQ2iUAZmKFxpjLtVFrO56KoQrP6xFuYp7JnhIm+z/I0wyr5tXaQbfayweJh3v17xk4KLQ+j8c1BlKcnEQZ2OKD04ro8ywpX+YvM9+tmvg0KTnI8VyGDinhHsMCvA2Ymf7Ke7dr/gmHXRNm4uii4/mi9oRPzcYpFKGkr+Yu0gP2bA0qLQ0GPrgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Sat, 23 Aug
 2025 13:47:41 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 13:47:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 22:47:37 +0900
Message-Id: <DC9UR87GP16E.2K9E9SSTHEBRB@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <akpm@linux-foundation.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <daniel.almeida@collabora.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
In-Reply-To: <20250820165431.170195-4-dakr@kernel.org>
X-ClientProxiedBy: TYAPR01CA0132.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::24) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b745ef-6b93-45fd-2bd4-08dde24ba0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NitZbi9FNHBqTm00Y2VsZWhRRkJWejVINFMzZlNxajFOZHUvNTV4RHdyYlZT?=
 =?utf-8?B?cFVoUU1LRytxaGZRSTUxZFh6MzF4SUhPQUtHS0tlU3BGM0FEcjgvT0c0ek0z?=
 =?utf-8?B?bHZZVmt2czZCN2lMcVNLTWFxVHp0bW81V0pTeStiVmJIdkxPU0dYVkc3aWNE?=
 =?utf-8?B?aTV4eGFLTE53RGlHVDZUT3B1T3dKVk9PVDc3VlZ4Mnp6RkpZR2NVUkVueng4?=
 =?utf-8?B?ZDREblNWeXB4S2VmVXBBUUdrYzJ3U1Y1TUJCSTRkSFNIM21YVktFd1BMaU5Y?=
 =?utf-8?B?b3F2ajU4QVU1TGluaXE2Y211TmY1bVp4Z2tMYVJEMXFLbTBYTlUwZTFJN2F5?=
 =?utf-8?B?N1dYUnRjdEdhYXNFZndPanBWNkNVRlpTRk9lR1Z2cEV0QS8vOGQzN05idzh4?=
 =?utf-8?B?TFpzdFh0ekVtRlVlN2Ftc3FHeklPVjJ1VjBHSVB2bWVKQjhYYWVVeGF3Rity?=
 =?utf-8?B?ZHBkV1podjkxRVJDVFJPY0E3UmlYdEZPd2REOXBQR0pXK2ZEdDQzZE9XSGdT?=
 =?utf-8?B?TlJYSkgyelBVcG5DZnpXTi94ZlhnODZmaEVYbVp3VUhxVkN4ekFlR25oSStn?=
 =?utf-8?B?dC84S1JURmY5WkdVY0ViOXBaYVk3dHVwbHlnYkF2QUtybEtHMkhxUFhxUFBL?=
 =?utf-8?B?OGNDUHh2K0pnbzRrUTYrUkREa0loQXBnOG9aclhUM0szUnBIWVFoeW95ZHhQ?=
 =?utf-8?B?cVlXbENKSU1vVk5jdzM2aXIyVVNNaldpaGRKdFlHTEdjV2UwNHZxdUdiK0wy?=
 =?utf-8?B?aGxCanF1YllmWm95VE5sUDhlaDNqR2hyRlBXYytyY3N4WkovZnRMeXNGR1dW?=
 =?utf-8?B?Wkdtdk1NVXRYSDdEVWZuNWJKcUR6Nk1IMXNlNHhmd0NQV1FVUWFzWUgzRHlx?=
 =?utf-8?B?Y0I0bS9vTWt1cDMvV3FFckwrdnNZKzNEOWRDREtHd3hKSi81UWx3Z0pzeG16?=
 =?utf-8?B?M001bndTNEY5QmJ2ZWo4VW5QQVlxMXh5SnVralJNejBHaXZPRHErUDl5VTdq?=
 =?utf-8?B?NDFlNHRJLzNqWkpEaVNjcnMvQ0lOOE1xTTk0cUg1UFZIUi96RFdvVmk1SnNL?=
 =?utf-8?B?Z3NZUGxqdjcrSSs1RVArelF5Z1dKaDdIa1BzWUF3WkVFUlF1RU1oQ0NCZzlV?=
 =?utf-8?B?Slh3clNaNmpWVzRRbDVLb2FML1ZHQmIwODU0bXh1cEl5STRSNXRBeHQ1RGhQ?=
 =?utf-8?B?RkpFWk1RdCtra1JjRWNsdWFUaXdNSk1NYmh5cTZuYy9aUnM5TThDNER5MXFq?=
 =?utf-8?B?V3ByaGI4eFptWTJST2pLbm9pL1hwblNNM1o0QmsrY3R6blE0M0wvaVNDRWV4?=
 =?utf-8?B?MVRHTWtwbXFKbThzclJ5OVJoOXBsRjNReFFXK0EyVVBnQmswZVl1Ri9WeFFT?=
 =?utf-8?B?NFBzUGVxUXBRSHlLQ20zZlVydlNPd2E2V09iMFM5dlUxMGRDWnZkenJSVGYz?=
 =?utf-8?B?Zm04ZVVtSWtTZjVaKzhEQVEvZ1k1ejJnQjNpU3g0L3I2SEJRS1p2ckt1bU82?=
 =?utf-8?B?eHVkc3RLNW0rWTJpSUV1MWI3VjJETnJFMk9XRVhwdGZBZ3BlaDAySzBpYmdq?=
 =?utf-8?B?WXhlc1dQQ3NPZjN1STZlT1J6cFFTQUVMTVQxTXVVMUlpeFJyZ04xYmxwemNh?=
 =?utf-8?B?dE5kd0Z0aStJczBjbVF5OHR0YkxjaUhWVExpK203dTcxb2JBYi9qL3c1Y2dG?=
 =?utf-8?B?L3B2Wmp3d0I0RWZJNEdUdXFVc2pPVDlJSFNvdytLbDZlQU53VzFDM1Fod0xr?=
 =?utf-8?B?emxWVEdJYTFYQUdsZmV0NFdOSkNwMkxqV3l0N205NThDZjNSbm1LVWowSHAx?=
 =?utf-8?B?K3F3Y1BhdXZQZHJMRW9henU4K0JodGtrazB1dWNFN3BHYTNTRkdaN3JYb0Ji?=
 =?utf-8?B?aXlLUkhVUjhhL3NVQWxYa3NXUS9wZzBHZUcyU0svTGs0UjJDTnExTGlyd1Fw?=
 =?utf-8?B?R0U0Y1liTFJpS0UvczNIdHBuTkoycVZBNk9XQW1rR3RxelAzdm5IcjhTSFQ1?=
 =?utf-8?B?RjdSTFphWVJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNDZHRaakJzNzhPNWxvMStERndYOG1mSkQ2Q28rRjhWa2l5RUZjNWVsNUJF?=
 =?utf-8?B?MWYrUnBtN3pxWk1QYzJLVmFJMk5palkrVndxMjdiZG9BNUdOT29xNUpic3lS?=
 =?utf-8?B?NVhwVG1XcWl5K0VFc1QrL0x4djhJZEpYVVRRMTRIZHROZXJvbjQ1T0VrS3hQ?=
 =?utf-8?B?ci9abXdBMDdYaDdGRVBNOEtXUC9BVUhZeW1WYWtKV2oxZ0E5OG9jRE5Lak9R?=
 =?utf-8?B?VDdUVXZwc2lCRktNWG1vakx0Nm90MlVJQU0yZW9tUndseENYbkJxVkhhUWo2?=
 =?utf-8?B?bzhjYjBFbWFqNVdxVzV0eUZtL21PVTc4dnphTWtRdmR1alJRNksyaDAzWHdv?=
 =?utf-8?B?NjNkV0hwZHQ2Y2ZHOVhGT2pWcVdxRjROVWRIYVM0eEpweVRNN1BhVU4zRit2?=
 =?utf-8?B?VzYzRHM4cU9DQkV0b0RvbjNScWgwd3pZQ2dHenVxaHZKT0ZHY2RBYlNlZndV?=
 =?utf-8?B?ZnFadXJqV3cxNXRzeXBvbmE4N0xmWnBHbVdENk5hNDdWVlQxK2dBdzBSRDBy?=
 =?utf-8?B?Y01CTkhTRjVyRm93cnoxTTlaMTNDeXVOdTBvOWhsZVdJVW42RWQ2b1NVc1Q1?=
 =?utf-8?B?UnNFTVZCcExMZG8rYUVmZHQ2VnRZcFEzSVVwQ0VkRm9VZXJBaEVqZ3pTcGkx?=
 =?utf-8?B?a3dZVHFxK3V5SkIvTWNjNFFCRnRFMVdyLytYWFNWRW1BOWZobUdzNlcrbXFP?=
 =?utf-8?B?T092eGlBdk93ZGVnZkJxTTNxeU1wMEROSnBMemRDQzU3SEpRVGZSaUorb0k5?=
 =?utf-8?B?SEZZZFdWSjVxRmk3WVNCRGNybWlYakRZbkpQV3RaRlRxd2M5RDlxdEJ4THNv?=
 =?utf-8?B?SksyUU5NWVM3eGZhL2NsSFBsMWRCejFyeExFQUs3c0JlblQ4Nm1CQll2QTM3?=
 =?utf-8?B?eFNkQ0ZvQUsrREpEK3Z0d1BIbzFGbTZwNFBxQnNmMmk5ajcwWkVQWGR5OWp2?=
 =?utf-8?B?T3IrUlhrcStrT0NtTXg0dlkxcUhEREh4TWwvNWw1eGEyR2NqZGo3MnpJYkNa?=
 =?utf-8?B?MklhbWZpa25LNUg5bVVwRHordVU2MTVJcUhmZExlbnhHREhlVFIwWDE2ZnJ1?=
 =?utf-8?B?U2NvWDNGVVpkVUhYdXJPdVdDZHpoVUxNSWltVHFpeTJER3RZaXFya1ByM3VO?=
 =?utf-8?B?YlR0ZmFRVm9uTG84ZlFuRmpSUHhsYzE2K09OWGMvUnhoTXdlRW1tckhwOFJW?=
 =?utf-8?B?S1V0R2xRaFdRSEJVaGRZOG51ZHVpdmUxNG1XV2FLNkJmOVRKY3dESzM2bWVr?=
 =?utf-8?B?cEx6MnNHMFA4bHFPMG04dWR6ZzMyeUJCU1pzdXljc1EwczZZSUx2Y080ZzQx?=
 =?utf-8?B?RkY5ajBCVVdGd0FFdnN0a0s2ZTBLZEg5YytwSmxOWTk4VjQ1YjZUZ0dKeEYv?=
 =?utf-8?B?QWZhK1dTcWRoNUFaVGxMWFlweXZUbDIvVVJIUXFnR0M1Q2I2RHEwZ3NmNytY?=
 =?utf-8?B?bytUYU1tays4YkVlNy96ZnFsa2JYWnJpdWVINWJLdnVRNi8wRmNrTDArV1pU?=
 =?utf-8?B?OXk3YUZmMTh0VmxhSFVSZnoxSXV1c3YrcDJucG1Ld25hNTJRci8xQ2Vxczdy?=
 =?utf-8?B?dHRZNzczNjY1Nm1DQm54NTNpVUQwaDRnRWxGbS9ocmRjSFFtY2FYVFpYNW9O?=
 =?utf-8?B?N05tSnF0UzRpbExUOE1RbDNNeDFNR3BUNTBJQUMrMys0OUovVGRRdUJ1VWlo?=
 =?utf-8?B?TDlQNEdRZ2R6MzhVelZ5WDBUZXVLSjU5alpiRkxKQW1OOU4rRXZEaUJlYlI0?=
 =?utf-8?B?Tm1qSnJMM3pRazdPVjBWekxDYkcvT292blBMakJQQ25nZ1lzRmoxVSt2UCs1?=
 =?utf-8?B?clBuN29tUytycllYUW1tZkxxZTFBNVdvRm9CR3M2eUh5c2RRUUtyQmZCeVRy?=
 =?utf-8?B?UnN2VHNPYmFSVitLUkFZTEpHTlZzNjlUZ2hSdUFQMGtpVStuRHh0ajNva0RB?=
 =?utf-8?B?MU03RG8zT0ZudHdWQkpZWjY1Q3lMdDUzVGNuazZLc0FKSUNCK2dlMWdtdDRY?=
 =?utf-8?B?ajE5ei9MbWhjVnZQbnMzamx4Q1JPS2R2ZEpFdDV2OXM3d0pGc2VOZlE1Z2s4?=
 =?utf-8?B?cU1BQ2dMY3BHU21Ib3RnSkpFNXNZbWpac1UvZWozQmJHd3Z0OHIrZTFuczVy?=
 =?utf-8?B?U2FDeDJRSjRGU2gzcGJKZFJ4ZWNLbjVJRkowMVJPM0EwM3dzTkZGVURJanJi?=
 =?utf-8?Q?L0YP+P263mbFiqW3VwJV5VVKviOSXHRZWlpsTOk3Iy8T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b745ef-6b93-45fd-2bd4-08dde24ba0eb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 13:47:40.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOHbntfF0YsUqsIXt2l0epWeMV9hOzDIREZa/Mtk874nXAvaOJGtpzF/x0TkYVXWeRUgC+Layrj4clB4a/5gpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998

Oops, forgot to mention a couple more things:

On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
> Add a safe Rust abstraction for the kernel's scatter-gather list
> facilities (`struct scatterlist` and `struct sg_table`).
>
> This commit introduces `SGTable<T>`, a wrapper that uses a type-state
> pattern to provide compile-time guarantees about ownership and lifetime.

Is this actually a typestate? From my understanding, the typestate
pattern implies transitions from one state to the other (such as
Unmapped -> Mapped), but in this version there are no such transitions
(the previous ones had, though). We are just using a generic parameter,
so mentioning typestate sounds a bit misleading to me.

Another random thought, in the owned case, do we want to provide an
accessor to the provider of the backing pages? Or do we expect the
caller to take dispositions to keep such a reference if they need to
access the backing buffer post-mapping?

