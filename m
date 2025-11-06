Return-Path: <linux-kernel+bounces-888123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C35C39E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897821898B22
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19EF2DA74D;
	Thu,  6 Nov 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ny3+BYeL"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06614E2E2;
	Thu,  6 Nov 2025 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422412; cv=fail; b=Ld5M4R1inBL8pXF/votO7d/OjP6qfjA+dcB1teKymCAjSbltPFwOhLt0Z8vtOwZZ3smUe5LyPXZE3qOVfZafhN0FHfA+DzjDrnT1rocB8OhSw9vAzsNDozHztWXsbxyPiatRK5aq0WWmUuReHN626XS+btryIJry9IDc1O5pHZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422412; c=relaxed/simple;
	bh=Wrl91l/qsWhzLW8XozMwdHJFjf7R4VFySyeIcaYV3bI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmMAxWvnVoHlHijikTf0zVeAG+jdP+47esgXdUwXp6Hp5x6K14wYz563qIcvp9v+HN3waURrs2ihysk5Nj8IoPXZWIC+sXNsnS1VdwkqzRyueuT9eSw2VuO1+yjRetWTFO/yzlcjxWM8xkorifwxsH/OFhG6qmXoEr/pRlflmlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ny3+BYeL; arc=fail smtp.client-ip=40.93.195.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCroHxxxFu3bRBleHtlZkIOHRvlaffreFkx6jJjypK/Z76y3UoNpheCRud+3LBPFS9+gDpN6+sGj0oCv55DpG3koYmFww3keNjhGKoBzkAqgR/d8yMz7/+HAzYYg1udTc3c5PoVeQINSel4Y+4ef+8/MltBlFuT9FjniYRrwYLmJdNO9tjLuYmVQizSIKUYcNp1FfDWUToFE0KIjnlww7nqQrAIBjiFXNOAC9WrYmUgsNUESnC/auoKPy43C0oIOe/+Lx7fApVu9NQ8KZ0nqQj5xkFKzNN0bJRLmQPKQbqHZPlBLX7h/7cax0NNCCpM4XQF++Hy1TkWKtS6fdWdgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0m7IwJGSWmbPch9n/8OO0fY5kKjGECOFAck645UaLw=;
 b=TBOMe0+SxoYGDgDjUBfstMUnvFoKzYzQ5NJ6yr0JxqILBBAmLc0MlriPF6hLgVwMqcRTZRjhVot+LQXjU/Ow6XZZzYq9bq8ps4OvpQBS+jBJ1zZ51dmXBCgDw5q0jX3sd8YZ/1UAqtfkJhjO2wZLs4FVt1kDaTY1DTMq6s/ndzoUKygZ3UMing3aAo69/XuyW1iMSUjQTKOjxRZDrq1SpKrOANCP5D6F2lkYCpyQVYSuvbAbDmGNznjkigEcxwHRE/EcMq6s8iNMhhWwdv+vZ2piBGiWpKtn5n+FfNenCYiNCNOvZCFrtafoxT7vg7HPJy0hHA/3FmalSeA0BBw5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0m7IwJGSWmbPch9n/8OO0fY5kKjGECOFAck645UaLw=;
 b=Ny3+BYeLqK8smuWo7gLsOFGYoFXK1bKr+C4SmmYokR5ucqZt3Y3zeZyBZuNRIeCBAAD+zPfHkfiNTBv3/ndAmd2hhRFHgenV3DN8eLHCNJri+EBczK2+RHAlT+zJDyGZiRiFzPkvY1sBk/RN9BwpoF7K5Kuf7OjZ60zhaRTERbtcq3fet4h8igwS4VNBlEhg92wO0glE0dZi/xfb9CiaU+YEGKYQYtxh3JZftY/tM8Eop84bY3NxzwquABtZcHxsauxbwNkKe55ssI/Mu9XUVDYM9fzxbcRBtJoGDw2JUTEK88wHdvPT6lKsMQ3zupCLD3LouZ9YDznPwG4U0WiAeg==
Received: from BN0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:e6::21)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 09:46:47 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::26) by BN0PR03CA0016.outlook.office365.com
 (2603:10b6:408:e6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 09:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 09:46:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 01:46:28 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 01:46:28 -0800
Received: from inno-thin-client (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 01:46:23 -0800
Date: Thu, 6 Nov 2025 11:46:22 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: io: cleanup imports and use "kernel vertical"
 style
Message-ID: <20251106114622.18ed7628.zhiw@nvidia.com>
In-Reply-To: <39df4761-d843-4942-9f00-a44fc8436e80@kernel.org>
References: <20251104133301.59402-1-dakr@kernel.org>
	<39df4761-d843-4942-9f00-a44fc8436e80@kernel.org>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 32980ea6-1718-485f-392f-08de1d19671e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r9D7nbyPpbcFrCnMH6yYcD+irJyu7SkrdRCkrADwFN/kPHL39yX3u1oLxSs/?=
 =?us-ascii?Q?adLjJr8I9Y6ISrRS06WS1uarvvlmy1wPqhwDEKujCWDOuzlcZZ6+Usa9IGT6?=
 =?us-ascii?Q?9xq4qLyTJB68f/NistM8yv3BuohyfdQoMMQf/aH9H2YdmSxZ6nok4fbhkEF0?=
 =?us-ascii?Q?baolATwT5A3VlpN8gEZUB5RWY9FglH5XSOkv5v2IMsTumOUtd5EjKRwnNVdb?=
 =?us-ascii?Q?QhkAMx+HSikD01kL1/lrAW+PRX7/bZi/HkM5uS5Q7dV93WfCj9QAxxL1ktcB?=
 =?us-ascii?Q?TXcjsTDf0f54Ma0AHoi1JQKKuwBovLXqjTLc3ZZuIy+6eIIIX1gi7GaRMWeL?=
 =?us-ascii?Q?BzZNs8JHU53jlqsnaDfeTYvNKotq6EV3wkAzEdyiuosuLNuv2z+BGTlLCPXU?=
 =?us-ascii?Q?fu74Xah+/36agR06JcdPLyg5exuZLewGNqsOJIOPxnZ3Cj8w2kZ5npgtxKA8?=
 =?us-ascii?Q?idf0JjoVQ75wtTK47f5ptbFZHeQw+FsxcvYyRL7PkL5I2GlUMUPdLOxzwMNP?=
 =?us-ascii?Q?76tpA0QjQbZRjVJINZOqkBlBlARizmirZfnP/w6hc9Ld7Xu/0U5dk32WOLNy?=
 =?us-ascii?Q?pFrj5dmWpJ1cZWXIVSTzI4FIxhknlWnAVJ3Dz23+cKWZhFyuK4zE5z8fKVMF?=
 =?us-ascii?Q?17jwR9xwT9GX25KRbS/0NkcDEV5bGz/YxVK0jpNdOYF0dSZakhmqixwAYopT?=
 =?us-ascii?Q?Szz1A91LhsqtARYsamG+fdtNBLdYYVJKb0rfah9wcfpAVfajEUhWBDQBCktv?=
 =?us-ascii?Q?a3HWkuCp0Imybic/qOxN+BmmEXdiyuRvIgXCGIu3OsFDYj+v1jcA1ByvZu/r?=
 =?us-ascii?Q?iSBi/kTUM2MPLpfGVoML8m7u/FZsBC68V3YtTbTBcWM4AGDurhqbNU7ZZ8NO?=
 =?us-ascii?Q?PKh+yqukH1RwWKo0rGypbEzWQMDwFs6RDNbkn9PN3qdHRlMg+lmUCVpmVZej?=
 =?us-ascii?Q?7p2/0uNjc9nZHq6tBq/LcAp7wOGjNMFRFDodykOjilw1pSb1wv0OgZVrpcUM?=
 =?us-ascii?Q?ufe94h3UqzK5PzfXQP7e/Miey7iaqCXCER5JAsD380BnUmffB3nsAHsm9YHE?=
 =?us-ascii?Q?afTyGvO6EL9MLSjbhvDGUDw7/MbUsuaB4iqueVMZNDZ9er+wH/3XYO/Cq3yN?=
 =?us-ascii?Q?dKu95UlWeJp9NyOCtyLO1TRvPsAI+5WOgju7qDlXHnF3buT88OM71T+sDe5L?=
 =?us-ascii?Q?fYCCi+nq4IsotsiZ6PYq0IO69X1Q1bpM/7M/JLOuTs3gSRClY6Oh7S3BtK2q?=
 =?us-ascii?Q?fvWjjeyjk0z+/IJYXEE8oFL4kvsaXwcoCf8bNmhOz2S8tTRlSO438Oup1ER7?=
 =?us-ascii?Q?2O2/o7tSC7bHFh+XAIYw8Bo6e9NPB7hDSpku6zS15LeIX0uAeJV93m3sT1Fl?=
 =?us-ascii?Q?GzUJM6gzpnuJgfkiQzRYdH17Envv6U20V2PVtGK8FAI2FbMiIch40oLx4Qf0?=
 =?us-ascii?Q?BYwP23H5Fd2CgvC9cJamhzReMG+wF38NHIxWe08XSHK6bNkrOX7qR6j2fi/D?=
 =?us-ascii?Q?eWCdsN3dqL6uvBGLPJ4rDxF+pczPunmHzZNEJarizWrHgbdq5iBCwuFuSMuk?=
 =?us-ascii?Q?0N3xdoZAnmTURtRGMkQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:46:47.2724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32980ea6-1718-485f-392f-08de1d19671e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445

On Tue, 4 Nov 2025 17:25:11 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> On 11/4/25 2:32 PM, Danilo Krummrich wrote:
> > diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> > index ebc29023d59d..e21ccf98b81a 100644
> > --- a/rust/kernel/io/poll.rs
> > +++ b/rust/kernel/io/poll.rs
> > @@ -5,7 +5,10 @@
> >  //! C header:
> > [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h). 
> >  use crate::{
> > -    error::{code::*, Result},
> > +    error::{
> > +        code::*,
> > +        Result, //
> > +    },
> >      processor::cpu_relax,
> >      task::might_sleep,
> >      time::{
> 
> Should instead be:
> 

LGTM. Tested on the driver-core-testing branch with this extra change.

Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> index ebc29023d59d..b1a2570364f4 100644
> --- a/rust/kernel/io/poll.rs
> +++ b/rust/kernel/io/poll.rs
> @@ -5,7 +5,7 @@
>  //! C header:
> [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
> 
>  use crate::{
> -    error::{code::*, Result},
> +    prelude::*,
>      processor::cpu_relax,
>      task::might_sleep,
>      time::{
> 


