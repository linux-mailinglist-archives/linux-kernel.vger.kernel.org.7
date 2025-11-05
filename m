Return-Path: <linux-kernel+bounces-885640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F6C3392D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D283A7AB3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6BE2417C6;
	Wed,  5 Nov 2025 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ns7F3xD6"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728081C5F10;
	Wed,  5 Nov 2025 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304378; cv=fail; b=TUDVPUB0gC2yaSwuH+7XITUw/xWYbWVKi1NojjwC7z9hrbi3G+Mwcx+anN0Rsa+bi1JxkkV+0kLH0GskmnB6jxvrqZYqx9077PxznYg9YPAG5O2MH0ldHPg+NQdMn/fkz0+wo0/pzFHiEZslXzs5JhRk2NNkUKjA/leb0z1B1tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304378; c=relaxed/simple;
	bh=JWDPrH1zLqPNxeaQEh+ZvkNik6GeW+0txp7+QM7BsBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kPKiTTwHoo1kRo/oOzNMXjtdB76zJqcCAuJQJyYPdMpOvbSs1wCisfqP+ezjc6W2tln4E2jSutzPZFN59gijthrbgdnJiWSIO/kJEp/Tr8hnU1YalAxyfHFVBkfJh4mVW0It6cv806DHuwUh9Mg5fYrI7Jmd1f13lNSSNcXvUFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ns7F3xD6; arc=fail smtp.client-ip=52.101.53.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vt9PonjpUfHdEQ8Ip03j6lXb6o3qvbKK6PlNxrJSC9F4AwUZQFyZDzA8ns1q3OTWlwV5RlDN3jNsuRoTvSM+HOm8WvpSorirr394Dg0TrgAuaeBUrYpXoP3l0f3OfhgiX5dKuM4LIPLobEtyfAbCmqxEsXGKKug581c4jJxsipsS+AHVDyEXDgOBLpzShk/5Hy+O3R/bfSmEqAsV5dFene+avezhmTfQL/wiFrzRa2VWDqDzTpDwIxh+KpirN+XkdLOMRlS1rFDIFORJaY+bSB1tO0xY2oH3AjMV3w2DUB8NH/zs9cdXS6kCSqt5xR1SXZH8Bkifp+ytXNFOznLWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be9JBMNeTWXERLXe5Aq2ExsJudX+ZHmVOSYRJ4P5U0U=;
 b=isYMLFQyYW92uz0r1w7e2FCNiohQ95NbLM6kxXsdV3LARo0AJx8qAtnX00CsZR9WPFqmXgOsBrSzoj6vfCkicxHpd+O58Gfe84V51pVf+sSchbunSwg9Gj7nlZXD/SmyIOGxrUyPZHempUJxGdMwYNtxN1Cn9B++qyIX483Qy0//+RaCMQZk2gAjA06daAuFwmtFHJ1fTHVY8sPkpHzvDHQrCei3vMGUtGbDwFs6YYCkvJ1xtcJwedy9BrnmtOL/Hivv1WX4AoF4aOmwI7Hf46NEP9hNSGZ09SlYXkCbRkX3ZGZihAt3keQ3WVbot8BESXjQ0uZWpSUiC7zvtYLWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be9JBMNeTWXERLXe5Aq2ExsJudX+ZHmVOSYRJ4P5U0U=;
 b=ns7F3xD6COhCKaTp5PDgRbf6yapgS02CLRTZTguIy7JeVWFUqlWSjMnI02HrEqtvh++86aJ7Nr7uCZImJkAB3V771pHftN8NyzhmNG/WJ0B1yEtjJtyrN7g2JF4nEjKHjzqXE2Fi4FzcWrx7OtuVNlL1snmo8TfOduozh1Hdfl+Sp6/dC3Uaa8zhNlXOfjTZl6HdwvpkiHBUoBcyoCJrl+HNoK1f0NHzPf/7rSfO9TEaFVCPyc/AXEzi7pYO6aD3TMs96rPjVHtdAo3AueLW95n/qQvkS6vTGFIIbFQzvaAZlBYb/qfW3Y3c+j0CvhMPFax1nxJ3cIWrv0kKQvHxdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 00:59:33 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 00:59:33 +0000
Date: Tue, 4 Nov 2025 19:59:31 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dakr@kernel.org,
	David Airlie <airlied@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andrea Righi <arighi@nvidia.com>,
	Philipp Stanner <phasta@kernel.org>, nouveau@lists.freedesktop.org,
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Subject: Re: [PATCH RFC 3/4] rust: drm: Add DRM buddy allocator bindings
Message-ID: <20251105005931.GA2278646@joelbox2>
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-4-joelagnelf@nvidia.com>
 <DDX3K8BNA4DW.12U3WTKDD5GCF@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDX3K8BNA4DW.12U3WTKDD5GCF@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b136c0-b7b1-49df-1b13-08de1c0694ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o00BFrEXzsMo9XqaXeJLCShMr/KD5C33BcvBHrFFYR1o9OBTE5PxUsmZr5o8?=
 =?us-ascii?Q?AEPG2xUESE9go1FKlgBnx2cBwocKsfjfDGvzbcW7mCejPRtbgjam+4Fh9QcJ?=
 =?us-ascii?Q?R+omSbxkKGYJa8/80Cd+58OfFnN4oBiUHVYOlsh8fKLTHwchyQ2y31uSpB+T?=
 =?us-ascii?Q?yg0iPKDjK356s30TmOsTa753ea+Z/qcAl+/DBdoUjovXhLD3FK9Gi4bUXnHd?=
 =?us-ascii?Q?uXSHGTZTvuWtWKJHqZZsqAMvcxdVQqIg+gqp43i49NIeP6z65VpxDfknaBoC?=
 =?us-ascii?Q?xQhwV2jbOKJnV4OZXX3aoSC7YCe9FkIK3dLfArUfuyyOIrgfGSqYH8lg5iGf?=
 =?us-ascii?Q?OiD26ko8kOolNhLEqrr9C/JP8sbdrMn9J7OZZm8zKOUzqFpMD6TNVI8571la?=
 =?us-ascii?Q?xHFSr+PjRMI0GDZIP4RN+nGPI0mDPJagHYK2CiD+AbFfK2vE+avU69IWKPiQ?=
 =?us-ascii?Q?xfhvYyBapGGjrEQA0fLlttmmSRwQwoayQPVLaKkdG2BPWnf8S7iVq4uqwonT?=
 =?us-ascii?Q?D8GFb3swg6wY30TM3xGtVAKtoKebXWCNWI1+HRVCiND/k5qbl/0P/208O+oj?=
 =?us-ascii?Q?MWkxDfFk9ydEJqjHAA+hX3U2a6gUsSjxlwYY/aX4+rAyvM95VKQq6TxM4He8?=
 =?us-ascii?Q?4t864/Y+K8p23Zdd6Ul9wR54gAakC9QjDdsuG9GektVnyysVMZgQLyiGcZ1u?=
 =?us-ascii?Q?ermfhIsjh4cRljvxAO8jbBPVeZQQWiuLyNydTM2OvTDKz+TGvGv1wp6G1Oq5?=
 =?us-ascii?Q?gBTzAVt+dem1sO+7VF0e68YO3DxZWv4RFAcTX1Th+L1F/NQOt35VAlNqYOKy?=
 =?us-ascii?Q?SCCpwTz4mk/7+Ru5En55a9x3iJNjtIFp/hk1wucEQ5PCLYTBL+Pq5xg1af6u?=
 =?us-ascii?Q?feDV+23hdEPL13/rWv0rH0a9IXCPhPAdWIpB/KxhmQWdunPou0uEYQ7D5pju?=
 =?us-ascii?Q?aYGXhoD5kJ2OKAEIvrFNyg4b7+gD53N53rywF1g9JeQuqh11/j+RazgSciVC?=
 =?us-ascii?Q?5ckcDTEV6Z7ryW3wEXAxSNirOYRzC9nKP5GuVMbbkoqDtyR0hERPyN7fGl8J?=
 =?us-ascii?Q?8KQf64cRaHcpmKLnKKvyOv4kzgUIeSEre6E6I2zhTwvWeZJ/8Ue2nx1xEYFK?=
 =?us-ascii?Q?QWaEvW9+9+r7sZpQ1llcIARZw5qmMA9gn0qPg3evVBbZt5ecDxnQc2tWuHYZ?=
 =?us-ascii?Q?qusnGZ3nU79//LxKl51SwizHVo91rnbpI5pBLjjiB/6dH7tySbXjzO1neWlI?=
 =?us-ascii?Q?EFWC4JKkiwR3zyQ8By+g6ooKVbptUBNHYGoy1jLJu9ReYDzDU0OzOxwcc1lj?=
 =?us-ascii?Q?4c5OLbYB+DSX15SE4eWaTmFFrV+QZM332PysnkRMJ/Dg9nMZu40TVpKnUXEY?=
 =?us-ascii?Q?27/KFlp1hR2pt+b2WrHJn/C+VTRoO5qsOXnGN29v26jazyy0EsyRhBzkKeh/?=
 =?us-ascii?Q?sv1yRSEFJLY4oduRjB7tfenGHTCQsDfe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/n0Ehoca4+PHULeBR9n3oVZ3tdu2EyUxGT0rINyhE4irFWidokXAK4WpHki6?=
 =?us-ascii?Q?97Rh6GIHqn4lkBCadfyH76aikx83Nkz4Mj1U726jSzJ05HkhOt8kA61ehi5V?=
 =?us-ascii?Q?75TC3KqXnbjsOjSKLF3w9roRuSpFx/GWpQ+pkBv5u9GzpoyjzfZmcfYLILUo?=
 =?us-ascii?Q?HUAao4M5DBkl7Is4uzzsy2aJPddra7ZecgNe2auQICwpZ+l20G8HVTXAzlGw?=
 =?us-ascii?Q?k+xVs8WM0XsPFh9WpwWR4PgXgc4c+MfDzYWugeCbvO4V+tl1r8v+R76Vcd43?=
 =?us-ascii?Q?YPwPI4AJ/bgCAfS1VTQz1p+SXuhEuZGV0yXzVkkYKWSHUX7/JRvlYClrdo/k?=
 =?us-ascii?Q?1oQigvb21Hne81qI+IeQJQ7Y2cXtwAZvWoOPayv5eE1h/73MEZ+2/KPYAJXd?=
 =?us-ascii?Q?Wkzdq2da+c6MZy3+F8EQx1VjkxW6ULLLyI7uWBCF0bfIrePm8JFrUnj+KqYy?=
 =?us-ascii?Q?LM/HzhjML7GOo1SSFKiaoatkA/9c4KLn3JaPmAYbtCpSiJm1SHvSfEZiJAcC?=
 =?us-ascii?Q?mDmnRNJKk4TF8QRjOon/HBT2sjxr+0jmBM01yZwr9Xspf+GfQ+Rn+2s2C92q?=
 =?us-ascii?Q?cPwLUksNTb/i/fmawZpwgcZYFKMZqC6vYe5/aw3x6h9vpDzMUyV6v+ntxmvI?=
 =?us-ascii?Q?s5SqCndy2UL8GbtctI75CPWCgd2bzNkvdIlFv0gBWWzbcifBpXEw1rsZrOxq?=
 =?us-ascii?Q?UXJZIpmHSQ8Yl2LsRwVbFj5hvHsSsKftFhmxp/A9a90eP52ZxjtWzOfKYTdK?=
 =?us-ascii?Q?7MNrdFmvUAMpJJ+poxXQsFdNUqKizVonHno0tpCe8E+3g2gHSDd136uIXvp5?=
 =?us-ascii?Q?KV3tjRn6j+/e2f6Qor+tdCAPLnI1Qb1FheZ+M2WXTfHisBDd/ScMQafqTYf5?=
 =?us-ascii?Q?F/EYdZyEOeCdnSrjhc5xZfS3kyfX1RzOVXbjmD07ba4l4ti2YQkdtq+bHw7O?=
 =?us-ascii?Q?gddgwxy/G1usf4ZKMuRJEQ8IYvVKF21zWFjzO7DwxJxY/fu5HR2FrvBTAZXQ?=
 =?us-ascii?Q?g5dLZjVR/fabDNOvC7ZZ18wj5tvcDPzgZh8Sb0M86Wlh0x5LyAOlgfcZXypw?=
 =?us-ascii?Q?4ZdHjPpGZbyDID5ReFvxBgZFeAugSDsB9JokNI5wOPWQh4fu63jN7d2oe6nu?=
 =?us-ascii?Q?qIPdLp3CzhNc1w37PgRen84voKNVYjkMmVInD/35IgqjQuFsZxEYqwgwhLkz?=
 =?us-ascii?Q?rzwJjHqNkvqYIltHIkWQDpPWeO267jjCt9TTl6r663pKCG5CfAlJScMbkhj0?=
 =?us-ascii?Q?zsN6Glb5TdfSCS6IirIhdHtCtqeiZn3ODh3T3ANsEEdxetLdp33awWQdYV2l?=
 =?us-ascii?Q?e+OtednjixCcKGU6jsupZgDz8fgEfRlebtjgWFAGSbs9hkqpv9Ocof91+CLp?=
 =?us-ascii?Q?tEHlDBGdX7NAyGDx7tKuLNW+DvAJsS9dKnJYfyySyFT+W9x45F1xPImD8eZR?=
 =?us-ascii?Q?vn4ZUlElCMCEPk5/thEYzZZuonvhrh04mFAcSLhHaJQGSfO6MbOUrcF0mxng?=
 =?us-ascii?Q?mXb4Iq2Wk+r++TrrLMAXvbCF2KmkpANqFsgEXQDTLvTJJK0d8Fqs3v0xahrq?=
 =?us-ascii?Q?tahInZrlI8o1BwQK5XpH229Zml7Klr0fArq9LcI2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b136c0-b7b1-49df-1b13-08de1c0694ec
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 00:59:32.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1mFdTirZ9Au4FSUs8/rToSvbxjoEJFIDcKVZ42ggf9reBcwpr+VcyK+LOBbNRnbQRTyY/hhJp7Kj8RAXmjTdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090

On Sat, Nov 01, 2025 at 02:08:56PM +0900, Alexandre Courbot wrote:
> On Fri Oct 31, 2025 at 4:06 AM JST, Joel Fernandes wrote:
> <snip>
> > +/// DRM buddy allocator instance.
> > +///
> > +/// This structure wraps the C `drm_buddy` allocator.
> > +///
> > +/// # Safety
> > +///
> > +/// Not thread-safe. Concurrent alloc/free operations require external
> > +/// synchronization (e.g., wrapping in `Arc<Mutex<DrmBuddy>>`).
> > +///
> > +/// # Invariants
> > +///
> > +/// - `mm` is initialized via `drm_buddy_init()` and remains valid until Drop.
> > +pub struct DrmBuddy {
> > +    mm: Opaque<bindings::drm_buddy>,
> > +}
> 
> not a big deal, but usually such wrapping structures are defined as
> follows:
> 
> pub struct DrmBuddy(Opaque<bindings::drm_buddy>);

Sure.

> 
> > +
> > +impl DrmBuddy {
> > +    /// Create a new buddy allocator.
> > +    ///
> > +    /// Creates a buddy allocator that manages a contiguous address space of the given
> > +    /// size, with the specified minimum allocation unit (chunk_size must be at least 4KB).
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// See the complete example in the documentation comments for [`AllocatedBlocks`].
> > +    pub fn new(size: usize, chunk_size: usize) -> Result<Self> {
> > +        // Create buddy allocator with zeroed memory.
> > +        let buddy = Self {
> > +            mm: Opaque::zeroed(),
> 
> Isn't `Opaque::uninit` more appropriate here, since `drm_buddy_init`
> below will overwrite the data?

Sure.

> 
> <snip>
> > +// SAFETY: DrmBuddy can be sent between threads. Caller is responsible for
> > +// ensuring thread-safe access if needed (e.g., via Mutex).
> > +unsafe impl Send for DrmBuddy {}
> > +
> > +/// Allocated blocks from the buddy allocator with automatic cleanup.
> > +///
> > +/// This structure owns a list of allocated blocks and ensures they are
> > +/// automatically freed when dropped. Blocks may be iterated over and are
> > +/// read-only after allocation (iteration via [`IntoIterator`] and
> > +/// automatic cleanup via [`Drop`] only). To share across threads, wrap
> > +/// in `Arc<AllocatedBlocks>`. Rust owns the head list head of the
> > +/// allocated blocks; C allocates blocks and links them to the head
> > +/// list head. Clean up of the allocated blocks is handled by C code.
> > +///
> > +/// # Invariants
> > +///
> > +/// - `list_head` is an owned, valid, initialized list_head.
> > +/// - `buddy` points to a valid, initialized [`DrmBuddy`].
> > +pub struct AllocatedBlocks<'a> {
> > +    list_head: KBox<bindings::list_head>,
> > +    buddy: &'a DrmBuddy,
> > +}
> 
> Isn't the lifetime going to severely restrict how this can be used?
> 
> For instance, after allocating a list of blocks I suppose you will want
> to store it somewhere, do some other business, and free it much later in
> a completely different code path. The lifetime is going to make this
> very difficult.
> 
> For instance, try and adapt the unit test in the following patch to
> allocate some driver object on the heap (representing a bound device),
> and store both the `DrmBuddy` and the allocated blocks into it. I don't
> think the borrow checker will let you do that.
> 
> I think this calls for a reference-counted design instead - this will
> move lifetime management to runtime, and solve the issue.
> 

Agreed, I will use refcounting. I am also looking into Alice's suggestion
about doing the same between the individual blocks and the AllocatedBlocks.

> > +
> > +impl Drop for AllocatedBlocks<'_> {
> > +    fn drop(&mut self) {
> > +        // Free all blocks automatically when dropped.
> > +        // SAFETY: list_head is a valid list of blocks per the type's invariants.
> > +        unsafe {
> > +            bindings::drm_buddy_free_list(self.buddy.as_raw(), &mut *self.list_head as *mut _, 0);
> > +        }
> > +    }
> > +}
> > +
> > +impl<'a> AllocatedBlocks<'a> {
> > +    /// Check if the block list is empty.
> > +    pub fn is_empty(&self) -> bool {
> > +        // SAFETY: list_head is a valid list of blocks per the type's invariants.
> > +        unsafe { clist::list_empty(&*self.list_head as *const _) }
> > +    }
> > +
> > +    /// Iterate over allocated blocks.
> > +    pub fn iter(&self) -> clist::ClistIter<'_, Block> {
> > +        // SAFETY: list_head is a valid list of blocks per the type's invariants.
> > +        clist::iter_list_head::<Block>(&*self.list_head)
> > +    }
> > +}
> > +
> > +/// Iteration support for allocated blocks.
> > +///
> > +/// # Examples
> > +///
> > +/// ```ignore
> > +/// for block in &allocated_blocks {
> > +///     // Use block.
> > +/// }
> > +/// ```
> > +impl<'a> IntoIterator for &'a AllocatedBlocks<'_> {
> > +    type Item = Block;
> > +    type IntoIter = clist::ClistIter<'a, Block>;
> > +
> > +    fn into_iter(self) -> Self::IntoIter {
> > +        self.iter()
> > +    }
> > +}
> > +
> > +/// A DRM buddy block.
> > +///
> > +/// Wraps a pointer to a C `drm_buddy_block` structure. This is returned
> > +/// from allocation operations and used to free blocks.
> > +///
> > +/// # Invariants
> > +///
> > +/// `drm_buddy_block_ptr` points to a valid `drm_buddy_block` managed by the buddy allocator.
> > +pub struct Block {
> > +    drm_buddy_block_ptr: NonNull<bindings::drm_buddy_block>,
> > +}
> 
> This also looks like a good change to use a transparent struct with an
> opaque. I guess once you adapt the CList design as suggested it will
> come to this naturally.
> 

Sure, sounds good, thanks!

 - Joel



