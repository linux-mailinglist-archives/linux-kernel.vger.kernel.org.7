Return-Path: <linux-kernel+bounces-825947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F7CB8D2EC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 02:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9486C2A22DC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 00:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8767261B;
	Sun, 21 Sep 2025 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QVX+a6D4"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DA2AE6A;
	Sun, 21 Sep 2025 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758416035; cv=fail; b=eZfBT2nVx9tuHyZhFSUEfYW7FN6+TFakdkFlJq4uxjfU3DU0tZwt57PzN+v3WvhQRZxqeHp7rBK+NLNIhvdkkBaTQDAIZXVxBfmoiQuZpxveMzA6HBpLcfZlbFRA9rIKow2a8ZNzZavhBYU04n96rbYNz+a8sRrbcfUXRtghPsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758416035; c=relaxed/simple;
	bh=ahLq6yFC4NyddQNZPrGy+vOxhHk73JEQkpkl+os4r/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FGwpRtMr2sZTfq/2ceWr0yZiFawxaR/KuX0wYrk6bz/+y4aVObVsDHRGN//nmblSZXdXKiCXoOhv3+cxgiCtM0AsV2YUmwee0b1BOZ+p5qCdS/SiSuNTWH1b8EuBM/4vu0uZRDoEMxuFZFb6/kmiII31P66ntR7VnQ7JqWkOvUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QVX+a6D4; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgnElhDcKuka94n+IDZbaWxnOfmiqrqS4wpWjzlM2wiazPqXJclE7ft4xVI1uXMafAFAVTyMoJ7mtyYiq1zbcKnKdKDIlvJcxZDNgmqh8KofgfTi8QRLxuz+rNz68sKIh8hUiyFP+BFGSZBXn7AWoEuedUwpO8x2wxElHFQiOd0K0+2mdJottdtVunHBjLX7UKA4yA/O6QmbZylvz1fQZaQ4vN5qot63O2BK0xOxX0eG5AFFTG2PZQl6xUBFHoCyNg4yZJ1fknioLwJtRgmroggVDx0iIziHDPFcy5fvJ+5sQRXe2EId/jMdF8njT0Ruhj6eFU4BFwwprv5Snv5Lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEUo8C/MEqz5bOyAyEFQHKKLx5aj4sA+fyZNzEH+6Lw=;
 b=kSmNjpgi4ojN3hkjIELvUznlqR2262pePuWlqAOVCYYJ7bqWinZFFDrycK03/uK3WzZgEwH4lhytN3t4L8k9B2TYLc1QAt0xDq8u44+HBVahXfAYkKwwODh2DcPvaE2XZBdEHC0aC66hkgxhLO1jRdECCIR5O9GtuAuj9rHEA5W5uyU8KLdSCV/XHNGhad8EGxSw39LPvksKuzG9MZBJAX7L2Mdq34X38JYRco274MzWQWf4UELyekMw3Z9gR/wZ2YVszlJYi35x2AGF3dy/lvYhybLwXdMY1RBxOJ6al+Z3C139zEmwj0VDAKD8JMcSMdzc65oYgKWOF/QjXocOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEUo8C/MEqz5bOyAyEFQHKKLx5aj4sA+fyZNzEH+6Lw=;
 b=QVX+a6D49HNOhFB1ONCrpv7Hw9fovgLo2izFURRWYvMM6SlwJJsfss7WYIDMCh5U0cB1/lclWjVMnTXgkfMoITGJ0/SfytPH0daIZUTAOVK3fcDNLoQANFQ+eivok9sr+uVHbZj9HHQuTfArprWdKcz9BnQW6Y/yFkLK94iz7UXRXqUq8ZsWar50bL1EjzL3dhNithXFcJn50L93BSeiZUnioyY1VQLd00EuZ57Br4AiYGO2KjDL+U2NURn53JlUfYFtbQBOZ1U3I0b7UUj76M0craq7MqV2g6eaKIUBqYBentN341PEWMySrXjDQvxjGxbqxYOJiGmuIQcR/mwQrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Sun, 21 Sep
 2025 00:53:47 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9137.018; Sun, 21 Sep 2025
 00:53:47 +0000
Date: Sat, 20 Sep 2025 20:53:45 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
Message-ID: <20250921005345.GB2101443@joelbox2>
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
 <aM8BrIT1clk_efE6@tardis.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM8BrIT1clk_efE6@tardis.local>
X-ClientProxiedBy: BN0PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:408:e8::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba64f16-bcfc-4528-57a4-08ddf8a95261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GKdJkAv1QfdKrlgnM55O0v3Y84q0vxx2yGSBujcDMX1C+h+w7DhecpnAg0Ih?=
 =?us-ascii?Q?GxOZPKTacdtC5bFBhCFOmqxmkK4MO5QdX7lLSTRMElJUc3gPNLiiLnmKENRe?=
 =?us-ascii?Q?WyjA7oHe67PgBPz5oZ+voCr65NLk6oCgc6qW3R+75Jqt2HBZdKYCejneuLVC?=
 =?us-ascii?Q?VXgDxl3cryLIk/yK5wmYcgHKfVML3gtiOJCPQSy+I7MpjcbWmyNIhhtYncNK?=
 =?us-ascii?Q?l83H9tRtzLRaJofWUC+wI1Hz2vi+IDonQB4I9DnwfsWpXzqVpn393fbNrRv3?=
 =?us-ascii?Q?7jg/42/uY1mbl9zwRojem4wYfjkUm2RlzYmS4f53yv/o9YjwOVKLftJiDf55?=
 =?us-ascii?Q?WjQAuxhOaxwb5MxVqtjx2o5krCP7WeOLK8Qs5lXrX/q0X3GHM8yNo6rgWQUM?=
 =?us-ascii?Q?//ihMvyNVMPRC549J7IYjOqQafLXuYtgsw5IreJ9TaQZ9Nz/+lUhIubATfu9?=
 =?us-ascii?Q?qiJrfg7ppJewhOdusEhyipEroZpF3DVR0YDwduObeypQLOrOTgPffl+a2zkh?=
 =?us-ascii?Q?o49hogdfV1AU8PBxvZRu6sG/mqwKOEbhca6Ooc8FDzH05M3p3flnd5Laa7fC?=
 =?us-ascii?Q?+rfWEW9lrr1hJFJ4P+9CotVFyBK+t6F1iIhFaJXNkekVAqpycVoebF7THaGK?=
 =?us-ascii?Q?Uo70ZjUeFlHm6sW+z1Vu/Up7cdv1krgt6t50DCZWAg3oEOZhdCo5q0CxzLCo?=
 =?us-ascii?Q?8d3nVgjN5/jTJ3b003yeP6JEQJvkeXJKxUrVSaRSElAYtHDizDX9mW/GZgD5?=
 =?us-ascii?Q?YNWg5Qc6ytkta0cMVEz9azJitW0bQxOtAuDAsk+BJfbBShDDFeGzUo05x5ns?=
 =?us-ascii?Q?GPHEFuEgxrDcLXbIlx0EVDppdVkBuJywDnmH9JvCibPX9d9/UjOFgrczm5CP?=
 =?us-ascii?Q?hrEEHR7GqSSVi12rfZ7dhM36mhY1guTQQ7puWXfJ0WOzLnaPvpRtjai4vmCO?=
 =?us-ascii?Q?vAuNU/5AtJTr7EPUiwd4Ygn8LusiPGh74nlsdnbxE9Du+NUoBfkgcyzVAN3e?=
 =?us-ascii?Q?ppXeijLkPICt5Dlkvg+dNUHP56nRgnCVD9dr+Gmx0rTEE8EPmGNMeK60gLTC?=
 =?us-ascii?Q?z1OQlxDRHOIKiWjvYmICS85IWo88yuG8QI+MT/bgsEnbVcOfrjvg0nBHgueI?=
 =?us-ascii?Q?qyFGXImz5L1Zi2hPdZ+aC52ywD6vGl7vS46+0bxv0cxKV6buVMvRkec+MpxI?=
 =?us-ascii?Q?B6vOWQUMBQJEXBLDMUHdz7pXDkbbov3urm9I7Nm31BZsvaAATyoTlBTb6Dm/?=
 =?us-ascii?Q?ujutRpWnvroTY4XvoABrQDzxTT6Yr+z/u59MrkKcqmTneFkx0DYY95BnP1Di?=
 =?us-ascii?Q?e9vxfRaXC6VYHzuB/Sn9pRABYmQ7SiOudgdS/k2FEXoWcmwIoBswe0ld9c5N?=
 =?us-ascii?Q?6u7BwFALhXwXikySDwXlL52rlm7aKXZW/pmYLqdoj3nChUlNEgJo1KH0sBZ0?=
 =?us-ascii?Q?sXWWHub2niU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fcAjP5dEsfexo2InTP466ZvWojsAh8nOxbAtRZLH0P+pwvFVgWTklWtDXp4k?=
 =?us-ascii?Q?2W5s+7z15fysheIOUG6nUB0O3l9czlV5lfF/NejIb3f2XGkT1zzQfVwR+SHF?=
 =?us-ascii?Q?D1/c7CAYJ5ilkuq3hGXPxNhu45nAUSn7oi/u/MWlhSgRNBL25Ooy64oakpCX?=
 =?us-ascii?Q?KzHIo+glVeq/txn8Tj6+kzG72RD1OsMxRkb9PsURTs/3YKkliRmPKlYlDW9X?=
 =?us-ascii?Q?/EY8H93xqOGi530PmZqGU+7SGFfnh5A39jQlDT5lwoA35xT7hzKFYPdf4SuQ?=
 =?us-ascii?Q?MiLuuIhtmmztyb83Fm7cx1z+alP7KQvFfYp3hKJt7GxPIf+mZoMcaI/Iq+/J?=
 =?us-ascii?Q?0QVR3Tzke1g/UWMwtZIyjGjvPdynF1U2CLEvd4tjks2RA/3b63by8dNWmESu?=
 =?us-ascii?Q?07lFxuucvfb3GAvw2iXnhWc9E6PtX3bOdh4UnOdT5ZQ5TCpmF5wAJLOJBE3F?=
 =?us-ascii?Q?XihgeGB6N9sZCiPF48pErLsXGdN8QOIOMbOrFd/3hmwLWp4Bs4o8taFb8brn?=
 =?us-ascii?Q?t/gukm29vbAxsO2xJT5UMIDPI+bo4XuXrOPdueiMDQwX4je8PsKxmZpeIST7?=
 =?us-ascii?Q?0mBoLdOm+F98nC9Q0fPcWf9Y47QJL514Z8gQ3yV5jkGD4vcIBnIqN4CR+0HU?=
 =?us-ascii?Q?tK7Az8fR5KFjFBCqZjJDdDgVUKb7m16RwTxMPEZ5qemySWJJDBfugBkjaYcp?=
 =?us-ascii?Q?NXSayZ3Z+EBCIk6pLII5mZkH1Kjxec4yx46q4Nl42Xo5Cxqpa1z7uP1wPM19?=
 =?us-ascii?Q?wAjrI7iwYMqjGyoKPSgyEpQI7YH483gD+i7N12d+pLWaS9AhJr15VtqvzAP1?=
 =?us-ascii?Q?Dlodvj0D7VXFnCrcLtS7UW9It9trolmjQPSVm96K8YkJSLYt71BX3c0ZIPq5?=
 =?us-ascii?Q?C3sxTYvGsEcfZfPtqmUYdkCsHnnD7EVY5wEfgpr+mqqtpUCuhIS92CxXLCA7?=
 =?us-ascii?Q?6nkaZCxeBrTt9W9fcPldaVQN0vb+zH9qq160+KDGHDYFTviXEsZSCQopHHHj?=
 =?us-ascii?Q?b1pG9TzmpYeI8eCDhSbDgMRO4qvWpWOTWRYCobh7hrNNs0njhvB2TENrTPfU?=
 =?us-ascii?Q?t4exLPW4z0xjyKE3zv7xR1f5Zgod8mxgZIXFv9Lt8B9IXr4YZ3yDPdMpAfMz?=
 =?us-ascii?Q?gGr0O66dODIDwpFYkWZfAwkdZyYrm+27fdbK0pp6wMNtVO2euxk9YSJO/Q4x?=
 =?us-ascii?Q?JWXmE6treugK04rj1qeCHh01mcZ5zHAIsGdgEOWjeuiGsQe2YmussjRWiE3U?=
 =?us-ascii?Q?QGrBKT5Dpn4giC46DivIAZ1yIi9TCDc/osl1d79kF41q3rBQb21FE7CJIeEP?=
 =?us-ascii?Q?rQ7L/V97yFLxvW/SaP+Jbz8Vx4fNj2mKVb8nh1pJFzZsi5qUk5ZjU8sJAmpL?=
 =?us-ascii?Q?iEP6av/eE3UB4Fvg/7cjDoBoDtM/hq7BrmAA9RGVrpYa5A4B1EE+/yWYI3jS?=
 =?us-ascii?Q?IrBpB6H7s5Tq36NAbK9I4QBcOu+qxs0a5OJU34gLrjEp8IdSUHcZCGNlVS/f?=
 =?us-ascii?Q?DCkn8ZpzGvtO73ury3u3Ta1biEwzsCSjmzcW4BeADhOxe7Yi3a2LSSVu9Rvg?=
 =?us-ascii?Q?T89Ijyw5nB0sTXebMwLLZPWYqhtQJrF/vkvCfT8FRi8V6QQUa73OcwkQ1bGs?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba64f16-bcfc-4528-57a4-08ddf8a95261
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 00:53:47.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgTe8wf+c3PUVXgJ9HVpP0ip4rg2GvMY0WaKfCLZMIn4lpPp6nXO4Nh5Dhm7YsVbUJD1DxzDVAuWkFQLmpUq/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263

Hi Boqun,

On Sat, Sep 20, 2025 at 12:34:04PM -0700, Boqun Feng wrote:
> On Sat, Sep 20, 2025 at 12:19:58PM -0400, Joel Fernandes wrote:
> > When printing just before calling io.write32(), modpost fails due to
> > build_assert's missing rust_build_error symbol. The issue is that, the
> > printk arguments are passed as reference in bindings code, thus Rust
> > cannot trust its value and fails to optimize away the build_assert.
> > 
> 
> I think "cannot trust" is a bit vague and misleading here, for this
> kind of "workaround", we want the reason to be a bit clear. @Gary, could
> you help explain it a bit more?

I dumped the MIR and LLVM IRs here. It appears in the case of calling an
external function, it creates a pointer:

MIR:

bb0: {
    _1 = const 42_i32;           // offset = 42
    _3 = &raw const _1;          // Address is taken causing an escape I think.
    _2 = some_func(move _3);
}

I then dumped the LLVM IR and saw that it is infact reloading the pointer
after some_func is called.

Where as otherwise, you don't see the 'raw const' thing and no reloading
(build check is optimized away).

But I freely admit to be not yet too knowledgeable about the Rust compiler
and I only arrived at this patch with trial and error.

> 
> > The issue can be reproduced with the following simple snippet:
> >   let offset = 0;
> >   pr_err!("{}", offset);
> >   io.write32(base, offset);
> > 
> > Fix it by just using a closure to call printk. Rust captures the
> > arguments into the closure's arguments thus breaking the dependency.
> > This can be fixed by simply creating a variable alias for each variable
> > however the closure is a simple and concise fix.
> > 
> 
> Similar here, "breaking the dependency" and "creating a variable alias"
> can be described more accurately, e.g. the latter can be "creating a new
> binding".

Yeah sorry, "breaking the dependency" is indeed vague. I meant there is a
dependency between the external function modifying the data pointed at, and
the code following external function call using the data. Due to this, the
pointer is reloaded. I'll explain it better.

> 
> All in all, we need to establish a wide understanding of the issue and
> agree on a reasonable fix. But anyway, thank Joel for doing this ;-)

Absolutely, please consider this patch as a starting point for an
investigation. Worst case, maybe if I fixed the closure issue, it can be a
temporary workaround to alleviate the pain felt by some real users.

thanks,

 - Joel


> 
> Regards,
> Boqun
> 
> > Another approach with using const-generics for the io.write32 API was
> > investigated, but it cannot work with code that dynamically calculates
> > the write offset.
> > 
> > Disassembly of users of pr_err!() with/without patch shows identical
> > code generation, thus the fix has no difference in the final binary.
> > 
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  rust/kernel/print.rs | 44 ++++++++++++++++++++++++--------------------
> >  1 file changed, 24 insertions(+), 20 deletions(-)
> > 
> > diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
> > index 2d743d78d220..5847942195a7 100644
> > --- a/rust/kernel/print.rs
> > +++ b/rust/kernel/print.rs
> > @@ -143,34 +143,38 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
> >  #[expect(clippy::crate_in_macro_def)]
> >  macro_rules! print_macro (
> >      // The non-continuation cases (most of them, e.g. `INFO`).
> > -    ($format_string:path, false, $($arg:tt)+) => (
> > +    ($format_string:path, false, $($arg:tt)+) => ({
> >          // To remain sound, `arg`s must be expanded outside the `unsafe` block.
> >          // Typically one would use a `let` binding for that; however, `format_args!`
> >          // takes borrows on the arguments, but does not extend the scope of temporaries.
> >          // Therefore, a `match` expression is used to keep them around, since
> >          // the scrutinee is kept until the end of the `match`.
> > -        match $crate::prelude::fmt!($($arg)+) {
> > -            // SAFETY: This hidden macro should only be called by the documented
> > -            // printing macros which ensure the format string is one of the fixed
> > -            // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
> > -            // by the `module!` proc macro or fixed values defined in a kernel
> > -            // crate.
> > -            args => unsafe {
> > -                $crate::print::call_printk(
> > -                    &$format_string,
> > -                    crate::__LOG_PREFIX,
> > -                    args,
> > -                );
> > +        (|| {
> > +            match $crate::prelude::fmt!($($arg)+) {
> > +                // SAFETY: This hidden macro should only be called by the documented
> > +                // printing macros which ensure the format string is one of the fixed
> > +                // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
> > +                // by the `module!` proc macro or fixed values defined in a kernel
> > +                // crate.
> > +                args => unsafe {
> > +                    $crate::print::call_printk(
> > +                        &$format_string,
> > +                        crate::__LOG_PREFIX,
> > +                        args,
> > +                    );
> > +                }
> >              }
> > -        }
> > -    );
> > +        })();
> > +    });
> >  
> >      // The `CONT` case.
> > -    ($format_string:path, true, $($arg:tt)+) => (
> > -        $crate::print::call_printk_cont(
> > -            $crate::prelude::fmt!($($arg)+),
> > -        );
> > -    );
> > +    ($format_string:path, true, $($arg:tt)+) => ({
> > +        (|| {
> > +            $crate::print::call_printk_cont(
> > +                $crate::prelude::fmt!($($arg)+),
> > +            );
> > +        })();
> > +    });
> >  );
> >  
> >  /// Stub for doctests
> > -- 
> > 2.34.1
> > 

