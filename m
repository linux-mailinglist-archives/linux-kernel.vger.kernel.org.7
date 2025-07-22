Return-Path: <linux-kernel+bounces-740952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F252B0DD3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148631C856A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5E12EA15D;
	Tue, 22 Jul 2025 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="johEhZaM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A12C9A;
	Tue, 22 Jul 2025 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193215; cv=fail; b=qAcxUx47yeWiNrsut5FSAUX7oujlO99rFHbgJ7CV1moxtiI61Z4vj/uVxFL+N7VoBHXqmlWh1bdXAXNR0t/l9ZOn3CtgopZRAAbyntU5Ph5tWkw2eAFI4057ndvByJmKfh5KBZwCiojxZICmi/c64imw8ss2qcGUY7rDrTg9/Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193215; c=relaxed/simple;
	bh=e+nVjyY7HB6e20iGZNsyAY18zsltM0ukg0Gxz7Nd3wE=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=edDyayu1Jc1oBEgVDIAfCFKIR4NFApt3lxJbevRO1YBwDK/KFjrToCN7C7Ou4xV/mEMK679/HsFOQQx9FjqAWTDH5W7E6e/pkgsBeHCd85JvdgF4XVRM4asBQKaSdt+bUpcSdjKsdZCPppI7wvxK2jmmuN6/uWPrdnIFoUByHjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=johEhZaM; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBMFpIIqKko7wZGSTfJEbHtIqSXNL75fHVAaTuqa83SIXMznwGY1rc3CPeiaPrkethzTvXC9F/qByQSI/vgvG+do8o5su2plVmx5Q+oW/n+NL+L5GOUxE1Z2f8J31qC4ZssrnfynVWl+llIFiuM3MV66CiUGjuXJNfS0BSwH6IHXWJxqN/YyDaKATCaoN5g/F3WQf1fu7ysfN/stY6zEMOFMsQJOWmmyDJumoyGBeGpC/62DEtaHfcZVFS2XEoLj0MvwqUTXeu44X0xPkXK85o5H4p5N3ehIEZqDc3lu3Dm95tGQKXzgs/Jb1dPAHBscHU5H8105EeJdPIALizB8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP+A3hb/vyWF/WjfDcC32rfS2EHmSyzvmQmow4w448E=;
 b=WpVXFVT8HdWYNM2i5gebjTEDHNv3sIRqsOQeYsrqeKOdu9Q0Fp0xJkvRePqP7gte0PNWMwFSEL9JU83zRdd0tGRbsfRerG3LarFPoj+Xb/0H/pW8keQaTCoydbNV3A3x0VtEiBNiDC/Xm+KkRNilg5L9FRqBGuT8iv3AooqfUx0jjlwNRHyPur90qovRJZ37cDyHV/ON5nciBUS4h1J3zBErRAVbL5GlecmeW6FqpioYup5BXBBmKQTjsYfngsJCtpxbVQwgdJXIZxBI17qVaXQc2xTPeIlWjiEt2deo+vNz1qlSeytCzJkJC8LEHA3LIOzdv1SE0EMi76NCM+2Ktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP+A3hb/vyWF/WjfDcC32rfS2EHmSyzvmQmow4w448E=;
 b=johEhZaMgQXOMRKCncolSJB9TgKXRJqn5TbQP+cN3xj4pYoWNHLUSlskM5ZcOgjFqEfGOmiBM5wPnM87tLJir6tEmRCyuAQCRs64GjmlccHuPNVLgnI7wTnR1bVIcEUVew6mHFziCSU8Qav/Tm18Eid0B6AgcQr2y1a7+ofRQwZnYFQ1kEM+ffJU0Zd360OiXVFHMh3eQ6uNBcb2ezICY4sSsnnNK10whEXrlDj2q8TjTRY50FAuxQu5MCrnWEaF7mmsPT9uf8DDbQ9CB3Yh/bJNM+MH4cEgXi5ix+4z/qVSW6bckZhckdDPBvxAvGWkzSTzk5zG93Q1mO314BIj5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 14:06:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 14:06:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 23:06:41 +0900
Message-Id: <DBIN4DXACVKW.2XJPQV4RNJD70@nvidia.com>
Subject: Re: [PATCH v8] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Christian" <christiansantoslima21@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250624042802.105623-1-christiansantoslima21@gmail.com>
 <DB5KEWX9EJ2Q.3CX5EGS66OVHH@nvidia.com>
 <CABm2a9cfK+HuidwQwcD0Cs_n+dvd9Y71tFn=grz1ahGpbPpurA@mail.gmail.com>
In-Reply-To: <CABm2a9cfK+HuidwQwcD0Cs_n+dvd9Y71tFn=grz1ahGpbPpurA@mail.gmail.com>
X-ClientProxiedBy: TYAPR01CA0075.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3f56e0-4552-416b-e910-08ddc928fd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXdERUZ4VzY1QVFpZTRqcUN3M3pLUWJCcWZOZ0JCWFM1L2RrYTBFYmptWlZk?=
 =?utf-8?B?OEJHZTVTaWp2T01jQmNpYjhGQkJnU1ZiWG5yY2NLVytJeFhTdEpiQkZKUmJZ?=
 =?utf-8?B?MyttMlJncEd5a0JxNHFPbGEzbXpnS2w0bmlYSFlmV3d1Y0FyR3NUYzNYMUpo?=
 =?utf-8?B?WUsvSzF2eWVQV0pjWGJEQitadTIydDY0THZNbmRDMWQvUTNMOGtBeWpUZWZI?=
 =?utf-8?B?a2hTMmZmdThNS2sxdmdEb0N1bDBWVGxoWjFvaDd0aFY3WnBnbjRzUEdLOVhj?=
 =?utf-8?B?ajEwcmRNcTNQeHBKdkNURmZPMllXYVl4TkRLKzZUMURzTFhVTnFnUXZyckZk?=
 =?utf-8?B?Q29LSUdpdWNEZHVuWFEwK0kwNEFDQzlHZksrYU56UUU3Rk0wN2lzMUIzRWNl?=
 =?utf-8?B?di9DMUdBZlRGOExZdW43NDZYaVB0WFR5Q0dxb0dpWmRKTDNTNVlhdzJydkx3?=
 =?utf-8?B?d0dZUDRPZVBmMWs2eDFTcTVIbGVzSUtXUytIRC9ZY2VOUThiYVZLTmh2QWdP?=
 =?utf-8?B?OTlqYzRlejYvRnQ5bkNBcEdlSzFiaVduMnRHVVZFdWZIYWxzVjgycVN0eVpk?=
 =?utf-8?B?Mk9ubjFjK25GejFienp3c21leFQzM1hPLzBoaitYTDZQY2w0K044clREMW56?=
 =?utf-8?B?ZVR3OFpQMXA2bWE0akVWWkI1UWVjRXY4cExVQTJrK3lJMURPdktXYTlURytx?=
 =?utf-8?B?dUFiU3JUNXFkdFJpN093YzRTU2Ric1pFZzJHY3FsRys5d1hVaEdZM0NYeldo?=
 =?utf-8?B?Z3NuTjVDOFpBUkQ1UC9XYmt3Y2d3Nkt4bUdtbUhiV2FwQ0I4b0NQejdzdGtr?=
 =?utf-8?B?Wm4vZnhwZ0VzWHJ5QnRuV1l6bG9FcURrU0kxbGYyelBWa1JHRVdYS0JJRVBL?=
 =?utf-8?B?Y1JBQmdzcEZsUGZ2Tk9QYVFaRkgvVklPWS95S3NvSTlOM0E0YloyQ3dJc2VO?=
 =?utf-8?B?YVE4UjVnMkZ6alNoZldKbWVMQVllR1FDRDhtNDNHZ28yK2MyVFo4YVNPelFZ?=
 =?utf-8?B?aUlCbkgzOEhzeHV3aE0wdXc0TkxPWG8rK01SZVp5S3RHSnQ2R3BCTE5TcVdT?=
 =?utf-8?B?SFMvWm45Y1VKbk1hR2NIMHhQbkNVajRkSWR2RGN0SzVjUGxEc2o0UGprVG1v?=
 =?utf-8?B?TjdBQlBPaDBKdFd2bXNuWEhzYml3MllZUnp6WmV5OEtzeWtzanllcFI5WXpv?=
 =?utf-8?B?WEs3dEc0Wmk4UVVUL1FEeVFGRjVHUE5xdS9wRFJnM2ZZR295cDhZWWkrVHJM?=
 =?utf-8?B?NDlMRCtENndhUStZdkxhdXZzSjlCS2dDcHN3OW5xN3FESnM2UmZ5aVFJbTZF?=
 =?utf-8?B?bDliYUJxdFJ2VE1UazJRSGtkRkQxMStvNzNyYWJGSmJMT1BiYnlMSkhqQnd3?=
 =?utf-8?B?ZnJzK0lXdEIzT0xDbHFQQlp5N2pQTmNtTkdXUDA2VUVJVktIKzZkWExORGVo?=
 =?utf-8?B?VGh5OFdSbjFHcnN1VjFpYTdVT3dFbVVCUmk5aXBtZFJWUFdWdVptTVBvYWxN?=
 =?utf-8?B?OTlEa0UreGRWU1NMTCtWTXdwRjhLUHZuRVcwNmFrL2tNTVc2cmRDLzFZT2Ry?=
 =?utf-8?B?ZmdxOWdMdXNjcG4rbTlnZ0FGVHdxR3BJaU5rMDdUTDQvZTVkZGYrc2U2Q3BS?=
 =?utf-8?B?R1k2Rk5WQ2d6VXdBN0hsRzU5UjdjNFQrdko2MW05djJmTlNXcUVCU1ZoWkRh?=
 =?utf-8?B?YU13S2I4VXdOb0R0Wm14STVkUXd2K2djK3VJbHgwT2grRWRhZXFXVUFQbTJD?=
 =?utf-8?B?bjI4WlpMd3gzbDRlMnpIdlBzR1ZxeERYbERDYi96eE9xZld2QjFjaUdZRlJT?=
 =?utf-8?B?UlJCZ0l1WHR1OG15RU9icSt5aStRbkQyL1dBWFdjRDZMcVY2bWs0WVlhMGYx?=
 =?utf-8?B?ay9OWnFwYm9oNGxaUVdQZFVRU2p5QitlaXE0TEJsMHMxclE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZERseDhxVXRuTjR4T0sza1ErdXZ2bGdZUERPSXhkYmJ0R2NNaUhQdXFvMkIr?=
 =?utf-8?B?TThQUjhFV24zem9zSUwyT1VpYmovbnZJTHhVSmdZdlVGNVhQVUYxN1pVVHZY?=
 =?utf-8?B?MnJsNTlzZHJaenp3cnVlTmFjaDUzK3Z1S2xpNzN0WUIzR3gyZm9seUw1YlIv?=
 =?utf-8?B?QnhVMldKWmNQSHRQTHpWZDh4UDhaelMwQ0hhUUJReHE1U1pJRnU1cWMvMzZC?=
 =?utf-8?B?RFJxZi9rV0tlSUJVOGJHckJmYjVXY1lGeWplOEdENkxCZy9sYlkxdVk5dGFq?=
 =?utf-8?B?YXhtUkpXMGtoT0pUc05ROG1HTW1jQjdoSGYxQld5ZmpjU3pNL1owODVUYU1D?=
 =?utf-8?B?RXczMERPejEyQ0VzUlpvQmtGSnZpTUJYZi94UWFWQm5BZEFMZ2ZiTG9USFlo?=
 =?utf-8?B?UUt5UENiUktuaFNNV0ZLaHljTmtuQ3Q4a1V2Mm9Gejl3dnczemV6TTczVFNF?=
 =?utf-8?B?NGJybG5DQ0oyL2NGVmt2OEJGZDdjRTJ6QjF4YTQ3ZWgrL2VBNGVOMUl6cjFX?=
 =?utf-8?B?ZlpSRVcwNWtZYVZvU1E0WmdnblI2Ukd0cXJIVHd4TmRKYlk3MnUySGZ2TjJl?=
 =?utf-8?B?a2xVeUhCSHFQUi9ackdHYkMwdUJJTzhLdGxiSDA4RXRjUHFIdWlhVEdqUFpC?=
 =?utf-8?B?ZzdJV3hqdUNtaDRLT2luMUpxU1FCZ1lDUzdIY1YybzBBSWNGZEtzblczMW5Z?=
 =?utf-8?B?YWYyVkJjQXdCZ213Z2M4U3RFdFkyZTNhZmNXWlB6eHdFM3I5cDBSb2pZaXBK?=
 =?utf-8?B?LzV2Q3FOWjRTdWdDSHQvRys1MTRoNTJWT1phWGh2K3ZHTmVGbS9qdzdvNkNM?=
 =?utf-8?B?VXpZTjZ0R1N0bnNPN01MSTRqZW9ndnpQVDQ2RXN4RVRGWnU0bUh3alpvc2Vp?=
 =?utf-8?B?Y3gwS0dFREFYSjhwcEVkRGFnd0FPeVpXd2wxZkdqZVlJS05Fc29QK2Ficnc4?=
 =?utf-8?B?eEtxdFBXUnhHNHlSbm9UcFhCbnJuemJ4QkJKdzFNTk1jbFArOCtGNUI1UHBI?=
 =?utf-8?B?NDBrd1I3N0k0NFNvbFNTL3pFN0lhdXgvclduMUNRemQzQnJXbU9TQnUzSHVz?=
 =?utf-8?B?YmJERUM0VnlGNVZ2Vnpob2crdm9sV1FWT0k3NVpndHgybUNiaUNFUnJab1dh?=
 =?utf-8?B?RVBRK2MyT05udVRxcHZ3TkFYcWwrUXhtbWg3eFZBakNVaVlucXhuTTV0bEc5?=
 =?utf-8?B?RWpRUEt2THpsNnNVbEdEV3huVTh3ZFQxMnNRU2h5a0h1T1Aya2JtTVpySHdS?=
 =?utf-8?B?ZzNNcGd6cUhTc1hKZzFUeWFDOUNndGJzZVh0VllsS3g4Z0lPZklwUW1xRWlY?=
 =?utf-8?B?Y2UwcEZDcXBJR1JJcXdBeVIvWlFXM2N1RWRnV25lM29lTGd5ZXZYSjZVQzZ2?=
 =?utf-8?B?ellybE1GeE04UENIOEFTR0grd2N6NThOM21GaWlIbVRza0NLaFZ3QmsrUjNK?=
 =?utf-8?B?b3BCbkdCYk1jRURHTjdTdVJwZGJlL09xTFE1bTZUd3orQnVRb3c3N293Tlhl?=
 =?utf-8?B?ckJwelhXTXkzY2VYaHlYTi9uSUFxSjhtQVN6ZlVuMjhYTWZkTGhraS91bXg5?=
 =?utf-8?B?OGFXclpqS1pVeWxLY1JWWGxvUW1EektETkVSTTkzdGNHWk9HUmJFUnluUi9t?=
 =?utf-8?B?eHQxN0JuT2ZjWGo3VkhqM0pkMFF3bVdNcVc4RklRVUN6SWRGNWFWS05zOHlm?=
 =?utf-8?B?dEQwR3pKYmdZWmw5K3BaOE03MlRWNmVjSDM5U2lqWHJjV05qWlRQMXlnL2Vk?=
 =?utf-8?B?bWRjaVo5aEZkeXBLUVR4QmdWanhHNXpVZFMreTlHWEFoeXI5QTc4bkQ2OFNU?=
 =?utf-8?B?WHBmdTNIb0hTcUtNU2RGbTFoc2FzaFErRU1paWxBMU9SVmJ1N0xnZ203Wjln?=
 =?utf-8?B?cjJRRGFuUTRPVDNUaTlGU29qUXhWR2ZuRUM4VndFVEtKMVNRQTgvVFdEa2wy?=
 =?utf-8?B?Q2JrMFZJOEJ6Sll1bW5HSWhYcGQwWDVrRjk2eW80UWVUNmpjVk0xTW1UMkZk?=
 =?utf-8?B?MHZsVmJ5RnJwbGhqMGhlM044eHFDTC9sa3RVZ0JSdytnaDhMdEY2Ti9LZ1h4?=
 =?utf-8?B?YmhrVkNZemdlVmJTVEJDQ291VXpxaVJPdURqZnN0NDJHc1FQSmk3SVdPbWJV?=
 =?utf-8?B?M042ZXVBcFBlWG53NEtqMzhMbUFoK3RreElITUpvU1FrcmVyMS81SlN1Vko3?=
 =?utf-8?Q?ui2glXH63mjYwvaRBtg41AtIDQcdMBJ8IV9erC6s0wfK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3f56e0-4552-416b-e910-08ddc928fd58
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:06:44.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGFHIP96vY5PysVyc0SFV5zGGZNPoLSz62gEyCMwEDok04CY4qISea1umbU/metp4LpUylKJ+cg+5s0/K8yarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271

On Tue Jul 15, 2025 at 7:16 AM JST, Christian wrote:
> Hi, Alexandre. No problem, take your time.
>
>> Let's elaborate on when it is "possible", i.e. the reference is properly
>> aligned, and the size of the slice is equal to that of `T`. Let's also
>> clarify that `None` is returned in other cases.
>
> I see, thanks for a better explanation, I'll include it in the next patch=
.
>
>> > +    fn from_mut_bytes(bytes: &mut [u8]) -> Option<&mut Self>
>>
>> `from_bytes_mut` sounds like a more idiomatic name for this method.
>
> It is done this way to match the zero copy API. [1]

Mmm I have checked the zerocopy doc and could not find any instance of
either `from_bytes_mut` or `from_mut_bytes`...

>
>> > +    where
>> > +        Self: AsBytes;
>> > +}
>>
>> Note that `samples/rust/rust_dma.rs` will fail to compile due to this
>> change - you must make it derive `FromBytesSized` instead. There may be
>> other implementors of `FromBytes` so please make sure to track and
>> update them to avoid breaking the build.
>
> In this case, if we don't include `AsBytes` the user can add padding
> bytes in the slice. [2]

To clarify, I am not complaining about the `Self: AsBytes` requirement,
I am just pointing out that you will need to update the sample so it
keeps building. :)

>
>> nova-next also adds new implementations of `FromBytes`, and since they
>> are not in mainline yet this will make it harder to adapt them... I see
>> two possible solutions if we want this for the next cycle:
>>
>> - Take this patch into nova-next and update `FromBytes` implementations
>>   in lockstep,
>> - Add temporary default implementations for `from_bytes` and
>>   `from_mut_bytes` that simply return `None` so current implementors
>>   keep building.
>
> I think the first option is better considering the current state.

Sounds good to me as well!


