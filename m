Return-Path: <linux-kernel+bounces-799417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9CBB42B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF534866F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8A2E0927;
	Wed,  3 Sep 2025 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jVxM+iSG"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE82E040D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932761; cv=fail; b=sKBv3xvUo42dADosL9DMj+x6ebj2RqMoHYUFGcCkKSuL3uLFXnBY+xJAl8LUMvNgWsk9dIAElr73eIIvXgbaNdJghFxIM6KOKk+LmduVz/WEVbFKzN9olBlHCKlLg2wfVIGcVBI9UPgs96BsI2UNUgt7auzwPM4m2h8SGYpbrVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932761; c=relaxed/simple;
	bh=4/YYaHWzsDiINUE07+jmYi4It13s90cBjGQIpwi4ZGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uaF1FtB2+6mTIki0UQREpLG1bdXVURE3Rnnr13ddSL/k68e/pcC3tIo417gYbNwYd8Z9Hruer0LqDMKzAVEtGK04NG1kFQP9srzntlMFVtgFU3O5krnzmb4hAWqkIMYne8l1lJNLFP3ADIqhQNPQN1S3HOrqhhFhdNaBBv9Bc7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jVxM+iSG; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux+/UuqlsOplhWfV0W6V/dyRNGoj7a6oDE8OnCxrTGZkGFIlc+qYDvjUC7ehkzuDaBATczGMLH9AOBhOQMWU0NoY8leZlo4W40BZm1zFTRlFAD/RE0fkiPyjgZ4BCnJR+uDqXomrOgAiRh06bAD4LwDOD0cPmT8n0SofZ5QPnxQ/1BwU5QHFhYVlhsZ2q+zpi9bYIfHX7bPIM/vA7SAIFclQPPdvg0oD7WUeIyokG2BKejWxfMuQWO0nSOSIorAiB9sD/Gm1V+F+EEiqqs5MGPw/OZINrNtZzJTVOAZf/S7DmLR7iCgXxZcuG4x1R8s8wqUNhzOME/B2HfWncZVbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypkYSFVaDO3NJsQ4FMWGEL7dUzjA8iEoG38/lHJnvcg=;
 b=rx5/piKbua8lXYzt2pAADfiitEflRbVkPP8mrzJSImhYyBt6lYb2ouWRq6iEigvLM8Msstm/Uo1ysyxmSpw2rxVCS56HuZKjaUq97jDEDuWkMzYB0CzmZztp4gWT+wlzlYED6jqXGfKNvg84r3y1e6HnI56rUOmCupaEMvKixKoUAlXPYCNGTczK3Y27jLbn4A/iKGoT3PlpGhmrv4qoX0c3IwAeIljZwW3cgYPV6unorUY4TOY2ogmaiiYniqi8bpUaNGnUDkYJD+/JdMiVtSqvaYMJFJfk0v9GDyhwiW5GRo6ikD/RnC1y9gzOpsvcTcY+Nxc4Qgv6yodRgtMbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypkYSFVaDO3NJsQ4FMWGEL7dUzjA8iEoG38/lHJnvcg=;
 b=jVxM+iSGa3eZ4W7Tm/Eu7X2LnhCI/kwTkR/ggd/YV4Yj1rXjyVXSWEqXc9HolvxmUk4ceWndHyqvzghQvNywtqbWDm7MhV0Apjun3bElZWYWN9K5QkIijUjVZpl7e51tli1jVkcwPwqgSrAqPWf5I9hYRBhogj3fzMvx+dD4dIHqQQCjnvCg/YBHqhDm1WXI8Mr8OGru7OQ4TRfE1iDMHoMRK2VM3m3XI2qd4NE7eXNhF1bupzp7GO6tnQAmJ/zQ27oXO0F1p2EEycaC+futK0KOpWY/kBSgPGYEi2kqTZgGPolZrlZabgdj5aJzPAWWVgmyzY1j5cE0U+48C/crow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 20:52:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 20:52:37 +0000
Date: Wed, 3 Sep 2025 22:52:33 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, multics69@gmail.com, linux-kernel@vger.kernel.org,
	sched-ext@meta.com
Subject: Re: [PATCH 3/4] sched_ext: Move internal type and accessor
 definitions to ext_internal.h
Message-ID: <aLiqkQPC09mq7sUu@gpd4>
References: <20250902234817.279206-1-tj@kernel.org>
 <20250902234817.279206-4-tj@kernel.org>
 <aLgZPcwe9UFXw7rb@gpd4>
 <aLh0SAkBdIlGVLTU@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLh0SAkBdIlGVLTU@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: a082a045-e056-4fea-831c-08ddeb2bd07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j54f7nOaw+HOIFVI38LDdS7lYAAzq8Oph3Ixv9D+nzvZq+aQyq7Ld1tArgRO?=
 =?us-ascii?Q?0LCx2aHjdTGK3tfBMQXf4Bv/532WEYuEYLuRheAvNuxrSzevkftCE4jwvl6l?=
 =?us-ascii?Q?ubUlIU6DYA2y/JJ9Ebg1FuOStvXQR87y5X98ywCE4EHrHZW+XBt/fLNzmjbf?=
 =?us-ascii?Q?M9RN+W7DiVYV/MbMKicSqW+/TWiaxngRFx8REJNTy/de+q+FtYcC7mVXm3Ts?=
 =?us-ascii?Q?rUUXSQ0vy91l7Df//00Wdd0mFjgqP70wDiK2I0wVUW7Y7o5NKPu0rqVH5PkS?=
 =?us-ascii?Q?nbL8TVSRTXO2kbRumJqzKc3Ofsq67YfgIMDKmZIV24ypAPq+PhIcNPpt+AUo?=
 =?us-ascii?Q?+EHwPXrxyWcmqyjaEDsgrBbLXOLn0EmDCO9f4ecZ6x0tN0lKTUHhTloH8DBq?=
 =?us-ascii?Q?JxM6TRRXzvRpxaLRglHtrs+nblPqAxsHC+V7g8EGnElsnAX1TG92uw3A5vm5?=
 =?us-ascii?Q?B2Qd67qdCY4jdbon2C2brv78xXMYo0ewFpDD7g6UzBN46jTXr+IEpsjktuk1?=
 =?us-ascii?Q?PsDoLGF948ydD+57CPrWnUUWhd0HY5vqF/3WeO+uHQguFJCuDoSx2AxgvmDX?=
 =?us-ascii?Q?9VSwl7kpcUNIFKSErSruVRRJKAXLePJK4xibtORDCXwqJUIT6KEIEaDrKRld?=
 =?us-ascii?Q?XdYGaGiV9e9L6n57TEomtFJSNeFIVHI12WvPmzo9MDLfOWz0GTfkJPKPwegF?=
 =?us-ascii?Q?OLoqjCwnUPoYn+nBGPW+m0n/+rHOMmdWvy5BL5z5o5W2h7b+CYow8CFSaith?=
 =?us-ascii?Q?OGBTK/9qHxQJpyJn+fgx7up+iljBeQR3/m92G8+n0nPS6R+7Db0ibyTuQbyi?=
 =?us-ascii?Q?yy/dnIUoYvLaPnT6pzd/TgVZsKGAYahBhmRL+OAtVQQYmaZTXzec5Aevuk1e?=
 =?us-ascii?Q?WYJQ9/WSP400CXOtsfJCH8rdQjnoXK9p50L9xDfGvy+S65ut6i97CDfBrVKl?=
 =?us-ascii?Q?LdVoiC7sQEVOhPN2GIqDyzRMT8P+AL9mH8wZRQz8V05bdcB/MoAQCs0ZKpg3?=
 =?us-ascii?Q?PQCXsn8UlLDQCoJMnEDwP0RPgzAXqPM27CWHDuUR8redpBfCLg3huVfA1bm9?=
 =?us-ascii?Q?SvuW0AfFQrEpcCJF1mw4rPfJ3cTJL5/upfcKJ52gE76yxELk3dnTOOaEggtO?=
 =?us-ascii?Q?DyFXr2EtuwyEAbA2jPFj4Q3Fn1Ix+0AKK6aeTJlvZXZzk6SBJmu+SYJw+WZl?=
 =?us-ascii?Q?dKfpzHKe2R579zeyEu/3Fv9tUSiPV+1un+Plkl/V7HLi0vXDSUdsglFb2trL?=
 =?us-ascii?Q?yhID+m9VaWpoT5cfJNT2u2TWy9vQr+A2YcYrsBckvpJOBuqtgeoJMuLrn8e0?=
 =?us-ascii?Q?aaJGVulL3wfZq2a4YdWNZt79VQHcx64HgYLGFlNsRKh9rNJtfLT660QZA0kr?=
 =?us-ascii?Q?FICKtti01Zmsee6SV6MEpr3M3w4fVI6wX8dD9uaqblHOx57w0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W/526eJDhmLoP37W1otUW7zcX2FofMdEQW1ZMCKywkLZSU2+HVdbpX3VF3GW?=
 =?us-ascii?Q?4x9vCljDc9aPshDD/34iDojqiunIq1R0tOwfeRuVffuw9NiT4NUM4h95/nM9?=
 =?us-ascii?Q?CKpaUBB8uLkBv0tbUSKQORX7aksRHgBt6AtS0NatmzLMC+y0SooL+uJ7CHsv?=
 =?us-ascii?Q?HaInNST8TRRfov0AAtpyVuU+J2Pw18ebrdIhwXIpan2DAscLYrSUICnJa6f5?=
 =?us-ascii?Q?lwWQfnp0zQyw4EImdybFPyy8V22/+A33zYunge6tEvNaVR1TKryr7ulcSlCx?=
 =?us-ascii?Q?IumAMScPCxcUYI2T1zmNB7Um16Gt2+mvMshmq2ZOnD1qn6eewJk2NGQTnmUs?=
 =?us-ascii?Q?8Ce++rJ0mTh4xvGjOiu3M6PuzanLo9BKarkmAaei6mljnOWh6nwy41wwPL9C?=
 =?us-ascii?Q?fzRUeOp3E9uj4MMQ2n5R7keG/JlPPuJu2WmrU2pi/73VTCVemgWSRgM/R/xE?=
 =?us-ascii?Q?2HwdvwexCFgYT2XEO9dTklmKzOmaqAPY/BirM8pq0t9gKz3TSfSyxZI1dAkB?=
 =?us-ascii?Q?a0C13SNEVhFwvE+jvO6cKtmP8TZJnsTquzM9QMAQZxTq9jwR0ZVnHjsXNeJz?=
 =?us-ascii?Q?CI8Qb6ayLcqwHmSwLf8nndm+6Bafqs45xohDVaMGHnhaPu6aTJ2KfvkSKsBM?=
 =?us-ascii?Q?cuGNIdyiRMk+n6IvcSOAu4qT4uWDCa2VolP7TKsdrutcf+OzDpasBAnyxUjr?=
 =?us-ascii?Q?MD4EzxnCcIlAfKeFphbsY0gKFg9HvY5obqzGbl/B21TREXJH7C8kteHKqIdf?=
 =?us-ascii?Q?kc/j3FyQ50vaubL+VYMqpN6PhIv0wPrqN1kJ0AWnYA/pdC8nXLq2XMjcMWtg?=
 =?us-ascii?Q?XBl5MzkeLZAbl6xam4RD1PtPqFEduUqtNBAnXaGfS09bB1edxxsuDeFKdfKy?=
 =?us-ascii?Q?fI/4jo1Ya7DtrVWHC5Sf3J+YZk29rnRZLfvTgPc29EyK5TykYUI/b5oc9IXo?=
 =?us-ascii?Q?OcRoaGNSv9UEAeu61KN1upnIc4T20RiDBWY1VdQYwYVaAbktb8n+mzA2h5H8?=
 =?us-ascii?Q?E0N/bVBUlZRib4Ur9suzunjexvPyxHVUQZrNqfCZEpvkLsKWo8E5fgY5X7Kv?=
 =?us-ascii?Q?clna/R/1s1b+5gpZtpooOE8bnQ5TaaYaUHZyGaIi9swVeT6bXp6YfZs+YLdL?=
 =?us-ascii?Q?PXZX33Qsf7ceW51KhYuNLs7Q3mdKghIbQ+++d3l4bKfVhrd2i/CE0pHFk+tD?=
 =?us-ascii?Q?UW32XEo/7XXX2L5RoLAZ39SVyMTAXEuLx2bxettpm8SsKCksZI0kSlKTcJFH?=
 =?us-ascii?Q?D+0KL/o/Y8kRy9ch23aH1QFQ9eKsjvfbFTTeRBA5OKzceMcA+bIrGyx+twe7?=
 =?us-ascii?Q?CCOrEyUFskGCEjXpcTNNuQ+x7TzwGu3GfhbVn3U44R5T1X0INlSk3o9ngddQ?=
 =?us-ascii?Q?8TUvpki1vgjemi+5igNRwYigurM4ALWI5Gw9uwTG3qryERh9Qj1hxM6FMecn?=
 =?us-ascii?Q?3E6lLPh5c4Rdj+EPTHLuPuj1VLR52GpdkLrm9p7k1LrQ1luL5Knb5MjTJeMq?=
 =?us-ascii?Q?G8p0u7rh8IFCvToL9DQVE+IKmxCReD73Qs/MxRNj5vWWaIJ8oJRDjQDl5qN0?=
 =?us-ascii?Q?+ATL+heTKxXricSzBGR52Nj55yTzUsa+4x2KTxor?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a082a045-e056-4fea-831c-08ddeb2bd07d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:52:37.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGSB5Ze+M6j+L/+KKp47FLbEhI8NZ65V/RzzzhTg6AF9aVMAlvn0qKTgZuKQwiprzGzwVopTAa97bwOqrTfBrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192

On Wed, Sep 03, 2025 at 07:00:56AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 03, 2025 at 12:32:29PM +0200, Andrea Righi wrote:
> > On Tue, Sep 02, 2025 at 01:48:05PM -1000, Tejun Heo wrote:
> > > There currently isn't a place to place SCX-internal types and accessors to
> > > be shared between ext.c and ext_idle.c. Create kernel/sched/ext_internal.h
> > > and move internal type and accessor definitions there. This trims ext.c a
> > > bit and makes future additions easier. Pure code reorganization. No
> > > functional changes.
> > 
> > Having sched_ext_ops and scx_*_flags defined in ext_internal.h feels a
> > bit counterintuitive, sched_ext_ops also includes the documentation for all
> > the scx callbacks. How about moving these to ext.h and everything else in
> > ext_internal.h?
> 
> Hmm... so, _internal headers are for things which aren't interesting to
> other subsystems in the kernel. ie. internal to this particular subsystem,
> which is the case here. I understand that _internal may be counter-intuitive
> if the reader isn't working in the kernel tree, but am not sure that's a
> primary concern in naming source files.

Yeah, that's probably fine. As for the documentation, it's easy to find it
anyway, so I think it's not an issue.

Everything else looks good to me, so for the whole patchset:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

