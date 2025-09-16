Return-Path: <linux-kernel+bounces-819449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AACEB5A0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030DD3203AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51382D73B9;
	Tue, 16 Sep 2025 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XvtEeKPK"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9492D248F;
	Tue, 16 Sep 2025 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048779; cv=fail; b=J0jvr4toP+P3EPeAxfHHqhGOaeX69W4a02KwjS5tU2rx/bv0FZo9TJYrImG955HzGjJWzxmgb78rI6ARikVBg9e9B9dNLE3AajviaDOpAw5WFAL8m8+eMD5dPTyj7vV93vyXGpYOR9RwWvHG06YemXniuUFkoMh+BgXfgfjcJxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048779; c=relaxed/simple;
	bh=0KcCDjgBBtGUlhqDgD8/QYcERIs9ClIDeUJG1ZgYH3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H80SzHuC8E/VrLpzgL0+ldEnFVRZPusX1LbMHk3m86sp9PKWdAs5ScUMwOoJRVVyaYwCPZOqhHoOQ+c9xaoP+DuV+Xms68s3j0QfAL0LsztMtqvppuuDHIrn9ivOq/mNjdJY8hfEpNAtYtb5j63iqenEFC1jZTHsiFRPNDQ+BUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XvtEeKPK; arc=fail smtp.client-ip=40.93.198.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jU/fej9+z8pkJH+X3AOStAMeC6zVGP4JFs8+p1iA6wWZ15WKxH/WEXu9yXXg9fEJxP6UzquJsJAE0RSnqkGq569e9gxmQJTexe0MD9rlWKuBsQSRK6qUFZlP4K8KI4zu1HPZ37xPaeAEmTrGB4uhLArUGI7+sel/RHN6VHun92bTiR5L2cZU8rCwhFUbKqcJzOTAhMuOLnlxYAw6WwmZC3r5/TcB0FtrUl6GIqhdEX0JQ/sLsihJcjzCbvDcAtUIv+O9P8dd9QuK6QtAL0q3QGxVbOAujkqliLqujD2RcKBtWKmN7+8A9AFxXxMpZu6AOXv5KSB1hq1dWRgn4d9tbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx2SwSJ++bN2Z4qVzs8L/P/gL6wmX9jxCfkJMNjr4ew=;
 b=RvZzOFdU/Sl1EquNyD9FdYMM5CXZNxEl5AuETEsTebzJjpODx/EZLczsRiIiPK/rO3RIpynbw3LO4rehMJFq+eE8wkrkAh7cK9sDjb9A/6RWMjj2yIyjfGNl4Z4aw1y/PJmidrbmJDobZPF3N4BDlIFYxObvzhvcUJzykTRG58GuEJ2WcNFk+8lwpc8G8TSFOa058loP2gXx25pZCa5taY2ciFORCOuF+DvSxVxiGMzRDfOb9GWz/hz00FmfTbV3vQPVD8N6BhHNkcG27Pj8TtysH/WL8JRfahVt9CrvQ2Oj0D0vFtjX1kPYbeq0ShMWVYVQBx+FwTw73NrjrU7Svw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx2SwSJ++bN2Z4qVzs8L/P/gL6wmX9jxCfkJMNjr4ew=;
 b=XvtEeKPK8KCkdPFEiXSKpvOkgqFOr9qivatwgpbpPD+kOfbW/quTIjNgEi7WRLWKcZuV43Mp/eusywtFeBYvtWBGkxxknF3r2/vFwdWgM5KxO1moqEKVUCue1PWSC4On6bEo+BRVqZi9mHVwhDQS4ONTCNcvC7NaKU1gWgybV+tFoBYTqDwZvq2LHleU0ez9j1AqGDmbtnuyVTTMdbbbZJwgTc/DnJXrEfaAOVAb6Fohs7MdAKhElyJbZN35EyXGBlHZumD/md5rrzIhYFoHFq0Ajw3zqxu9/DqullFEO7JD7w/2kxb0MeRFCAeoc3LrFf55xhCINnF/ST4g67mGFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 18:52:55 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 18:52:55 +0000
Date: Tue, 16 Sep 2025 14:52:53 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: Printing with overflow checks can cause modpost errors
Message-ID: <20250916185253.GA1765622@joelbox2>
References: <20250911213157.GA1039411@joelbox2>
 <aMNo7qRCp_yprUAW@my-computer>
 <20250912025343.GA1376629@joelbox2>
 <4940aa5a-18d0-4bcd-9125-80f5a9920627@gmail.com>
 <20250916103252.GA1660986@joelbox2>
 <20250916104851.GA1679817@joelbox2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916104851.GA1679817@joelbox2>
X-ClientProxiedBy: BL0PR02CA0090.namprd02.prod.outlook.com
 (2603:10b6:208:51::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e26b20a-4eaf-494a-791c-08ddf5523f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CiZjIpuTMlbbw9WICT3EaEpCJ8Pp+Rj+rEAb3u1lz0DAXwPROmdHSv7ddqlj?=
 =?us-ascii?Q?51G4IJMLbocaorHezDck1K9Rm5z12MZza7g5Fs7UbGpK6lTAlxwnr4f96ZqX?=
 =?us-ascii?Q?q2xkjAWzgjtqLjU6Bgy30PKjprqzAFy0Ag8wIIfAJYWM5HA0ToHzDePH3Y37?=
 =?us-ascii?Q?RZJn+0gZeApYk+fwEu3/NNK2ShQI9qKfUePILskzBDsyqqc6iVsLfRS03zOc?=
 =?us-ascii?Q?aqeefhAWfnGKEVRt0PW3x0kDKpavuLyygC/Gh/wNHeYw9ZKzUKbTLCl05stw?=
 =?us-ascii?Q?QZOBOnYug+tplQR/27ZHw8LfKJF8cwV8zokMHojrLnT5jH44pyTmXXMYnoUO?=
 =?us-ascii?Q?oqcbV1P9fv0VRCv1aALcSBZLmzbNfDYbiCu64RzQBlyYBnNfKyTe0V/aRKWN?=
 =?us-ascii?Q?jp2Qz3vy0V0nddsMVOhfG1OJSlHLJiNB0N5dn+rS8o1bCDLZbB8B+YY38sYr?=
 =?us-ascii?Q?VGUBxT17CuSWUSStp1VOxQnBQ+WPo9b9qWMcrsFZu5Fv4sVujGDpEx/orZ2+?=
 =?us-ascii?Q?Viu5GCrlgHVSZtkGUkDAmuN0/4+CtSeVYJpEh8m4KKWpy2RxnVabrqXs0KkV?=
 =?us-ascii?Q?s2H1HMyF4gq8hTjCzinvJN8YQotIXrJgvM0oSNtOVYp/0aYtBHyhnu/LW5fi?=
 =?us-ascii?Q?bfOfG9zre+64u7+C9EO1HKvIqROsDhbfCpkhBaJ36Kl1yvzs8DoOWuUaABIs?=
 =?us-ascii?Q?2CQPXnX+DcMAJpL2fZkM+mjzEXWoRzWZu/+/LM3CDxRphtogirz0DSjqEg9B?=
 =?us-ascii?Q?MT2k00nP1EDlB4vHCBmzAhkdbYt8uQSmriiXeuQD2frJZug2cGbKRA6pr3xQ?=
 =?us-ascii?Q?DXC4ThwXdCAsm7seS70GXFWc0awXMxSY4pNz9LGBzs5ytrCxoxcDXDQ5SSuo?=
 =?us-ascii?Q?9Gmk40ULOM+xnm6Nn/2a4c8lySsDN50wc6misuSCWeBYhUt3K2QvGz8VzE2E?=
 =?us-ascii?Q?yDUoh6qB0EfKWcLKp711LU4Cd/Gi2iXJMXAtjH7JavJUJcC6VAfr+RogYxHq?=
 =?us-ascii?Q?YIIi7I7aA8qxqqDKy/5rJr8hZ11L4DrbO3qO32FfYUZ4q8Gl+BXiIhGQP60F?=
 =?us-ascii?Q?zThu6Z3qH/XxbxLSy19TO4r+NBKLDpNSxPgDmEbWxxTQmCNXn2fNDvCyFiQ9?=
 =?us-ascii?Q?fbtD02f/WpzVh/q0sbYyx8bbZaZbKlUJG0UEOA5GompAdHivXX+yI/gZKebG?=
 =?us-ascii?Q?N2Pbu6fYCngNMy5MpzLRHHMMyCh/FU0yHY2ukwZhVtmnV4WPYKPVJQArjvQL?=
 =?us-ascii?Q?2F3xmusGRmUBr3gvu6ITg61B1g9ruZSA17LgUmbeAqLvjla2fAK1K4OwbGqQ?=
 =?us-ascii?Q?f22B/PLQjiW8p4bZYC9B0W+vbCtMm/Iv9izDqOwgNI2A1B2zX6HngMlqLj0a?=
 =?us-ascii?Q?SCdS++8cWHmKrUp+54BWBeOzFffNuCOvTxLnN+ZU/pCvGZUTkblTCPy+fzo0?=
 =?us-ascii?Q?UtfMGfLVm60=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T3oY/O2JP0oBwBZPxMpl7r7AoKVFFtTadOd6tyBH8cb4eW1J1wI5xCs5zTLL?=
 =?us-ascii?Q?6oONWTdMyxRYuFwQbOrgJQiISGQPlFMgD0YmyBtPuKDVggkjEaBlOxEEQcxV?=
 =?us-ascii?Q?RSaKPhZ/UXne64Q5D4+zrjGFEDC2jQzf1ewDIfbJ+XM4XGxkO5a1e5VqJcnJ?=
 =?us-ascii?Q?ZQOUT6ieNsH4yLSVGyLs3vfJYrj7wm+WUThZCZVUyNlaHYs+dcssuSOwfI0J?=
 =?us-ascii?Q?/Um+gJJsg09NyH9+MiK0ejDT8l8J5GOAoQGwHnN0DAL4hS6I5tPuM/1KoG+p?=
 =?us-ascii?Q?wip+wxpzLtXQuxL6tufRyPMO8hoFSukwEg9Prt24aNPbwmrlGnXaNcwlBRmk?=
 =?us-ascii?Q?B8vjJTT3Ns8nBSMYTu6TMG7T/JG3S/U6teZPntNxH87ghB0jUVbEHv3WYhxI?=
 =?us-ascii?Q?3DshiXDFUAOcsd0WPSC2L6FPNUC36GsSQSFX1SuB6viaMztJgs4x1n8Rwq44?=
 =?us-ascii?Q?hKrDrwznnSgnbna4a/B0bVkmYdaO6ouABhJez8jMX9mQpmiV8+N4UEnckbqd?=
 =?us-ascii?Q?M93vXwcpy5fJKv6K+vuw+rpUugioHq0Zi5ejjS1bWlmkNrQNfLg4GGflGiqM?=
 =?us-ascii?Q?cJJYjYvnNTQureBKEA/4LedaQW+XUz8Ql4vOx2WIkOr7P8cBLDUE8MqiThzG?=
 =?us-ascii?Q?BrM4iMZF/cwIAQrnz5wy2AwBJpd5Ni1zR6uKVBFweeev6cppE5cG3Llj/e2r?=
 =?us-ascii?Q?4vVy30llgODaqzc9skUHa9C/R/1YCir7dzbksmDeRMi/kL6GKiPCvoYFjJyl?=
 =?us-ascii?Q?MVWavMxmmW40pTuHH8VjX9YvNVbTP8/7GzZGRPRutfSiBP0YZ56iwiNs/bDv?=
 =?us-ascii?Q?TJFoev9ybvPGtdsuMIjonOCLZ0/uOP6g0h7ISAT3IdemIBPhxzTu0lWNs/Ye?=
 =?us-ascii?Q?Qq1EBbB+nVAvsaAvy3XqlnNSOfxlsRIcA1SNinZeA5Az4o2jKZTWjkQ5UPVJ?=
 =?us-ascii?Q?iU87TP0/cIh4Hs3XLpX51Vcytyb45GTS/A47kwbn4N7FrKFLA183KfNiZIwb?=
 =?us-ascii?Q?CPchu0BEbFbsZPEAsWO5LhbNLgpS/+GQPmt6uLCZF5hiLOwNpZCmZ7KHVI49?=
 =?us-ascii?Q?LgJjs+ZAAmfs5fntJt5vdP+gLuKZyrgsVmsnJqbNAIbLQDr4aPI8P6RqH06f?=
 =?us-ascii?Q?4qR+gAwMbqiJAlKBqjFu7WNdFMhp9S2SgJoftlfg7k+KrHano52eplHBXmLI?=
 =?us-ascii?Q?4QDS2vfor2zhKxPbDVc50wvGFF42q5QYWWGHFEsBlAMR7r6AfbEx2kzAzcHf?=
 =?us-ascii?Q?Kesmg4yDlsyeoPSngmcoJeU0VS8oHdVh1dAhO5QJh2gjCgbm2s5K9R7QAEP2?=
 =?us-ascii?Q?eNSBZklP9ihXd8dnjkarCyflhT90MVV+dKrnXWPM4XaegZJ/xml8V0hQVrcY?=
 =?us-ascii?Q?ccEbrFrwohnVXEp3CjzZHpym8vJdH88q+AAG+f78DN3NtWv+yALL/yA+D1bN?=
 =?us-ascii?Q?ALwr6KkI5uaxXNc+I1L/4zS6de8rYm8Tm9kEHMIVK2mVOrpn65Ny7HBTiYuo?=
 =?us-ascii?Q?9MHbAWrzzCXj1Sex7tCI3Jw21gP43AqogXHwxBgn5i0U+XFxVcoDlatnm+7u?=
 =?us-ascii?Q?AQJEQxPiGE7larzd+s2bW3z94lSOssYLAbEDaPKR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e26b20a-4eaf-494a-791c-08ddf5523f0e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 18:52:55.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMtSUenCbRgtrV1NZFeQAnHYar87o905Z2DEf0cmK625/MtHkn3kV2UX/IMlj35Fqkvn/o/N4l9g6O1RGt00MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174

On Tue, Sep 16, 2025 at 06:48:51AM -0400, Joel Fernandes wrote:
> On Tue, Sep 16, 2025 at 06:32:52AM -0400, Joel Fernandes wrote:
> > On Thu, Sep 11, 2025 at 11:08:17PM -0500, Andrew Ballance wrote:
> > > On 9/11/25 9:53 PM, Joel Fernandes wrote:
> > > > On Thu, Sep 11, 2025 at 07:27:26PM -0500, Andrew Ballance wrote:
> > > > > On Thu, Sep 11, 2025 at 05:31:57PM -0400, Joel Fernandes wrote:
> > > > > > Hello,
> > > > > > Recently some of have been running into modpost errors more frequently. Ahead
> > > > > > of Kangrejos, I am trying to study them, the one I looked at today is truly
> > > > > > weird, below are more details.
> > > > > > 
> > > > > > I narrowed it down to the print statement and specifically the FFI call to
> > > > > > printk bindings. This was first reported by Timur Tabi on CC.
> > > > > > 
> > > > > > With CONFIG_RUST_OVERFLOW_CHECKS=y and CONFIG_RUST_BUILD_ASSERT_ALLOW=y, the
> > > > > > following patch when applied to nova-core will fail to build with following
> > > > > > errors. The question is why does the overflow checking fail since the
> > > > > > arithmetic is valid, and why only during printing (and say not during the
> > > > > > call to write32).
> > > > > > 
> > > > > >    MODPOST Module.symvers
> > > > > > ERROR: modpost: "rust_build_error" [drivers/gpu/nova-core/nova_core.ko] undefined!
> > > > > > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > > > > > make[1]: *** [/home/joelaf/repo/linux-nova-rm-call/Makefile:1961: modpost] Error 2
> > > > > > make: *** [Makefile:248: __sub-make] Error 2
> > > > > > 
> > > > > > Any comments or thoughts?
> > > > > > 
> > > > > 
> > > > > Io::write32 tries to do a bounds check at compile time and if it cannot
> > > > > be done it causes a build error. it looks like because a pointer to
> > > > > offset is passed across a ffi boundary, rustc makes no assumptions about
> > > > > the value of offset. so it cannot do the bounds check at compile time
> > > > > and causes a build error.
> > > > 
> > > > Are you saying this issue is related to iowrite32? I don't think so because
> > > > the issue does not happen if you comment out the pr_err in my example and
> > > > leave the write32 as it is. So it is something with the call to printk (FFI).
> > > > 
> > > > Why can't it assume the value of offset? All the values to compute it are
> > > > available at compile time right?
> > > > 
> > > > thanks,
> > > > 
> > > >   - Joel
> > > > 
> > > 
> > > This is a resend because I forgot to cc the mailing list.
> > > 
> > > it has to do with the FFI call. The value of offset can be found out at
> > > compile time, but because a pointer is passed through, the c side could
> > > theoretically change the value before write32 is called.
> > > The pointer passed is const so rustc should assume that the c side does
> > > not change offset, but looks like rustc does not do that.
> > > 
> > > as a test i created a version where a copy of offset is passed to printk
> > > instead of offset and it compiles.
> > > e.g:
> > > // SNIP
> > > let offset = <B as kernel::io::register::RegisterBase<$base>>::BASE
> > >     + Self::OFFSET
> > >     + (idx * Self::STRIDE);
> > > let offset_copy = offset;
> > > 
> > > pr_err!("{}", offset_copy);
> > > io.write32(self.0, offset);
> > > // SNIP
> > 
> > Andrew,
> > Thanks, I came to the same conclusion. After the first FFI call, the compiler
> > has to redo the overflow checking and cannot optimize it away. The issue does
> > not happen if either drop the print, or the io.write32, so it is their
> > combination that causes the issue.
> > 
> > So I guess how do we fix it? One crude way could be for the print macro to
> > alias its arguments automatically. But that does not fix the general problem
> > as it could occur with other FFI calls as well, not just printing.
> 
> I even see it with the following simple example, just using same variable
> between safe and unsafe code, here offset is not even going to the C side
> (there's no print):
> 
>   let mut offset = 0;
>   unsafe {
>     offset = 5;
>   }
>   io.write32(self.0, offset);
> 
> So maybe the issue is that the FFI related to print involves unsafe { },
> hence it causes the same issue there too?
> 

For the print usecase, if I move the match statement into a closure, the
issue disappears. Below is a patch, I can/will send it as a proper patch but
any initial thoughts? (Fair warning: Only lightly tested).

---8<-----------------------

From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] rust: print: Fix issue with rust_build_error

When printing just before calling io.write32(), modpost fails. The issue
seems to be that, the printk arguments are used in an unsafe block, thus Rust
cannot trust its value. This can be fixed by simply creating a variable alias
for each variable.

Fix it in an even simpler way by just call printk in a closure. Rust captures
the arguments into the closure's arguments thus breaking the dependencies.
Tested with the following snippet and it builds with patch:

  let offset = 0;
  pr_err!("{}", offset);
  io.write32(base, offset);

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 rust/kernel/print.rs | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 2d743d78d220..d6ef31464102 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -143,27 +143,30 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
 #[expect(clippy::crate_in_macro_def)]
 macro_rules! print_macro (
     // The non-continuation cases (most of them, e.g. `INFO`).
-    ($format_string:path, false, $($arg:tt)+) => (
+    ($format_string:path, false, $($arg:tt)+) => ({
         // To remain sound, `arg`s must be expanded outside the `unsafe` block.
         // Typically one would use a `let` binding for that; however, `format_args!`
         // takes borrows on the arguments, but does not extend the scope of temporaries.
         // Therefore, a `match` expression is used to keep them around, since
         // the scrutinee is kept until the end of the `match`.
-        match $crate::prelude::fmt!($($arg)+) {
-            // SAFETY: This hidden macro should only be called by the documented
-            // printing macros which ensure the format string is one of the fixed
-            // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
-            // by the `module!` proc macro or fixed values defined in a kernel
-            // crate.
-            args => unsafe {
-                $crate::print::call_printk(
-                    &$format_string,
-                    crate::__LOG_PREFIX,
-                    args,
-                );
+        let print_fn = || {
+            match $crate::prelude::fmt!($($arg)+) {
+                // SAFETY: This hidden macro should only be called by the documented
+                // printing macros which ensure the format string is one of the fixed
+                // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
+                // by the `module!` proc macro or fixed values defined in a kernel
+                // crate.
+                args => unsafe {
+                    $crate::print::call_printk(
+                        &$format_string,
+                        crate::__LOG_PREFIX,
+                        args,
+                    );
+                }
             }
-        }
-    );
+        };
+        print_fn();
+    });
 
     // The `CONT` case.
     ($format_string:path, true, $($arg:tt)+) => (
-- 
2.34.1


