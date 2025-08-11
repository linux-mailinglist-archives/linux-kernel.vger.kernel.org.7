Return-Path: <linux-kernel+bounces-763626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBCB217C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E0D460C63
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0302E425C;
	Mon, 11 Aug 2025 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQ5x6wrb"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8C2E3AEF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949433; cv=fail; b=eq4975iX8gLW9DZ6L2nUBScsW7kV2F029K0XPWlwT39NY7+i+YgAiCLKS5DiWhITieSHPY9pbHa2mzPo1yfeRnKL5NNV9bF5MSaiYOLev4sWqvz1BvRD8NODzEVd4tLmlW9tFPAvs3+aIOdFKoT3LVmjdcGUeKbEHDmOvA/zDuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949433; c=relaxed/simple;
	bh=EbwZ172iXkjc5xL60u5koX6LvzhZw7lMI02ER+a0o/M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HI9UTBWZ0yktd4xD23qvOsJjvh99u/0yq89AnLjKA1ixodc3JTrTOclBc2M5teSPFZ+h10HHRUYnwQIPwjY1NLjW/vmNFo8ze7G1W+bAwx3idWw3rlGUeiER+UEh555U6zMse09093LZxazX7d9Syl4u7pP9GTIdCRXejwi6U5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lQ5x6wrb; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlarNrgR+iD+D23qeiZP8pGjVJ8e5Robtk7DvBByH5P9Y9Wb3HB2l2KGNNCYEWtFuk09av5B7bw0d5qV9GeKpFx3vgi0RSV5x46MUfszACxOWkMAsC8s0Q+aD5qeBBesvhAz0apKb5E8p7egiepPEYhdEgPuj8Pp37T//SiFo/Y7ktPaY8uGw8wd0IBON6LJl/EhlguBlBAco65TSTuHbOuPa6S0fls0T2Fu+b+RjCK4RNQiD5Jp6qnBoCdgyIWlxAuOjumqJdb6bfUWZWOsWpOreP7Irpg3Rt6D9/PLix3bxU1nj+x0oA+dQ8+yD3koG/cZ1v8wrnV2mObovPi6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0s1T8Xthf5HcXFxnozQCZ9uT6HMfWI1+YDvBYUf2Bs=;
 b=mT3SyGrwk1vZOyyS3fnj371ZEmQ7yy9OJttcnh+znKi+kZtyEbv6vgrOSDKwdvK3pdG8Ms4KKJpALFFjeKSulsjHliXlLxBVbWXgautQ44OpiTbQB6B+qQF1Ifjn9A9ZxszgCTwb65gV5T35HFAPu624RJowmN3+C/73Zjern7staFNShog2CK78PZ8pmnkJbNWhFPhLOQJl7VpUe3kWtv3pwYzE+vwdYV8Y6QdNZc3RGfU2lgJ6BpBDqTfMUSOLZce7ajdMEDveqlINJQWXA0ddK6LmK5IUhfpSE5xAddFzg55TsaEVdfZMdcCCjqlEt7h2J+aORxDAeIOdPrZ3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0s1T8Xthf5HcXFxnozQCZ9uT6HMfWI1+YDvBYUf2Bs=;
 b=lQ5x6wrbjbBEHiNMXwQiz4lN+QxzJRRNT8JPSiKanJzAKJgPWyzSCCPbOR/rq2yTdY3eEVTaBoxN3di5tvYxFoFgGlxbVz2b5rhT+SYRNiERJEZLB1XMWL/c0XrLXl9+Fm8rW/EPInvusjNZRtldYpMfldDcD0SClGKXlKtPMgfDPIPADpKNPUqg08dudA9J/TeW8eV0oGBvuYeliNrZzTFvAL7jZUpvGMYfrEI4bdMmPTDp1QwNVs15Tj6FeBv9IdOLm8QmQbXCgfK8bl0w9pdU0CtgIpHS7etImZkXqSMobmzDan2KPSDaRLFV+dHdgcW0OTgOOzfhJN0n8XRG5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 21:57:07 +0000
Received: from SN7PR12MB6691.namprd12.prod.outlook.com
 ([fe80::d15a:729a:9a36:4376]) by SN7PR12MB6691.namprd12.prod.outlook.com
 ([fe80::d15a:729a:9a36:4376%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 21:57:06 +0000
From: James Jones <jajones@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	James Jones <jajones@nvidia.com>
Subject: [PATCH 0/3] drm/nouveau: Advertise correct modifiers on GB20x
Date: Mon, 11 Aug 2025 15:00:14 -0700
Message-ID: <20250811220017.1337-1-jajones@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::25) To SN7PR12MB6691.namprd12.prod.outlook.com
 (2603:10b6:806:271::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6691:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ade4019-ee34-457a-3535-08ddd9220331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BEKX+mK3QDJafkR7ga+BdRKmJY2TJxJCKn+o7ABduBctItj0Jj49OoIHrsBb?=
 =?us-ascii?Q?0/LTidhXmZywHJO4BvV7/KsABqLRS2ZlM2jEwQq3RXkKWeu3zR2OK7w87YDa?=
 =?us-ascii?Q?AnXECUm7WdupG0Hu1ALsOcYaBQOgzrq3rUw4od3JTw7EGVc8MA8zQDfw1ghV?=
 =?us-ascii?Q?uyvzshibDCmidwx364buO0Gmcn/HT9ZnCY4Cd4F8VJ4xyG8IRsU0TnIXg29L?=
 =?us-ascii?Q?QVO8Efy8Xo73uqb+gBJcO14degBU7NZ4Pj+bhSZaA9xFBxvfGgjXhYkrjks7?=
 =?us-ascii?Q?QWoUQisFnFQarrs6Tz9U95jIBlqYFY5YlWMshPGTfNQ7T4mmAZaz8eKhryCA?=
 =?us-ascii?Q?wG1rBbBafvgRC5WHLfXfgXho2dtkhh82+Y7+fKKWIx80bcnoQF5KuTANl88n?=
 =?us-ascii?Q?NCu/TR4+XBv8wiLtBycHfgOJrAdaUxM1MlYovW5XjXjA5wNGDaiHXdS4VvEx?=
 =?us-ascii?Q?YdkMGJmvJKI6toCq2mq2AwUJWlG8eqNwNwwqV158QyYwm67JYPOwcf6v/fQ6?=
 =?us-ascii?Q?IaHI6RLdHtdmgS794n8sAsClltDjhOZ1oRS+RGK7CgaBbjMwHJ74hpHLvrOD?=
 =?us-ascii?Q?W6WL/pJd7kSLt3W/Q6s4bb8M4VBqtbHDEFUY5eAiYjRWJNvpRED9AotWd8pY?=
 =?us-ascii?Q?iSmruF7rifB/0/vzJhdJyNob7xvkdH+Mnh6XrsVrzk26Qsxi+w11KjaPpwfb?=
 =?us-ascii?Q?5x5tTeJ28bVdeiDx+S2A9ZoTxKbp5mdJYZImUdwGkgQXQQKD6rZyf6XmigHy?=
 =?us-ascii?Q?NWxsLqwrjbyENpt751xO1IVOyygFYf/k3MCSDXQGa3kZ8Joxd5Dt2ZV27jfF?=
 =?us-ascii?Q?dbyXJGNyJRgborlgbYW94USD47BqWSdq0p1ZvwoM+OPulbxv5Jz1Jxl7LV0o?=
 =?us-ascii?Q?nSjgA2Pl7wucWZ4i9HXuFsvm6vhJP0kNQbX3breahgLtvkkwOtIMeoFh6zDB?=
 =?us-ascii?Q?q3QMkSXqN4LVVViuHgP7vcrdWLgYdRFr3oqF+LSD6qHeCYIG9BP5Hl6FaXTH?=
 =?us-ascii?Q?lf04EqukRQ7paUSsdtLwqzO5AjhQ2qJZLe4ivIrX4cWfiEsvwh6FwSnLPpGN?=
 =?us-ascii?Q?tN0H6SDukYqnoRFpzT13tCSDCtGkYPEP8+Ltj0IByeTkpw8S7Fs8/92dX4xw?=
 =?us-ascii?Q?1oEoDDCBJExTga+sTcVI8gK1l+9b+4DX7nzmjemfey6ddouMw2C0eI6GEnv1?=
 =?us-ascii?Q?pv9AHE1weD4v8woEqIjhNJTDwPKhH9tt5MkxcEI9hLw5GBIrJ5HSAWfoe/qa?=
 =?us-ascii?Q?HSBuS67lWpT9XW33LLBAgZ6klA2adR2IcIS1t4vSkPifVROdMPUVbAhIl0UJ?=
 =?us-ascii?Q?qTNBvRhqgnnsSJkYRUVk1Cr3vcAM9OicCOu/2TjKHYtkqGiEp94w1fd7Fvxo?=
 =?us-ascii?Q?oNjDiHxs43BwatUhyqkx6grJ9XIUoSG6DLujEASeHp4VAtgVuiCkQ+rCBbh+?=
 =?us-ascii?Q?yNF8nmS8ZQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cx/5EKndEd0dSONOUBtUVB1rgCEGWaeO6WsB5LYWa65No+Z6w/YJ8/yAPEbo?=
 =?us-ascii?Q?wwsbQHfYycZD+LY36mabINDcsINf9/TR0dgq3B1DbIJ7Bl1lURSBjOcUTSIN?=
 =?us-ascii?Q?4yrP+Gz/WjxRzCYGsBvB7tW7173+17csS8YjefuxFOmHcnGyPrjF+55L8Bkc?=
 =?us-ascii?Q?ExLjimgVAw0U/H8xwGpZek0O4C2W9yJ7y837ZM2FioM4wFkPJ59HyjQOS3VB?=
 =?us-ascii?Q?frD5e1wyxbgVp1f/glrtqfoSMLMRzi8fgkN9NaCC5Nw+TG6TprqnX4kXwJB2?=
 =?us-ascii?Q?GAbWwAlmpoYayafbOvIMstyQhccEzmpgLnDXD+zlk7C4kGI6aMropEd30GNk?=
 =?us-ascii?Q?Z5Z5unczY8/u0JkKDH5pqTRmuWNZV6bao4Zv4YiZS77rlnWi6g9cyCT9E006?=
 =?us-ascii?Q?2ozWGMagBt3kYPxNx1cDUNqu27Xx4w5iAtyMdBcOl/05jAmh9Im0N4D3z41E?=
 =?us-ascii?Q?U3NfaZTjvXRlblvVQc9zX0E0eeFdNp4WhpkxvxPizEHngUGVJLZw7OfwhFCB?=
 =?us-ascii?Q?97y89TGudknXrmYyfoDeanRa9uSpStYyIZb+m7Na+rmllpPugVJpVYvcDgnF?=
 =?us-ascii?Q?9i8qqrfsbevUlKghoQTVQlQQRgwme+vlsZh9eLnPBdPHkHpPTGMAyc4mb1cg?=
 =?us-ascii?Q?xONlMQ4wcHR5DqhBmUS7qnoC6LIC+YZHy677AGFN0srneFJsQMLciVXETSZH?=
 =?us-ascii?Q?n4j1vSLNV5rssQFonVvx8Gc6nHBTdpaq2oH/WshHwS+UBWEJypSmPKO+MFdT?=
 =?us-ascii?Q?5Yf6Xen3LvPJK0Nd3qYdSxYHAUbGKc0gbDkBxArJZdxjxMBCxNb3Bq2BFazh?=
 =?us-ascii?Q?fEv/eUUMDljlQkJXmX2/jQpRW3SPwoxmDPNRgJj07GC9rZ8sKa4Bc9ss6KrT?=
 =?us-ascii?Q?IatnBgket3TFn8wjjr6APPPZeetn/gqesscqEYBYBcrVsZsetBaKm9BHVy6Y?=
 =?us-ascii?Q?CHE7P6H+2rIESxRiZPwVhhPOB+jHuN5X/cYSDAsKpyywhRRFee6Al8j5Zh3R?=
 =?us-ascii?Q?wvUdUmR54a/AEiL7wJovs1wEDPb+JZrbmUQQpYm1YZPNYYc9HUkNRGX9e0Vx?=
 =?us-ascii?Q?bEJQwNErhyp67OhWDsKDkjAPOQokakEQ3iOsipyyyALM2+bXoFeQU3o0WN7F?=
 =?us-ascii?Q?1IJwDj2M1JRAOvuyOpFOhN5wik6E+lB+yFhNn7JeyGdFLK4EK8j0P6LJkgnA?=
 =?us-ascii?Q?kaERqMBA4EGK4OnD2jom0GpI/VD4CChJd4lk4KJf7+1lQI+J4W06J/ZiHw1C?=
 =?us-ascii?Q?rls95oDMZDyZSgqBLOZLMDKydpybvuXL4V4TzXNAZtT22hhnRDmDNlaj2O3z?=
 =?us-ascii?Q?gbZXnNMnmPUYw4XJBi5Pm9onjfidAbDtULn5zP9MfMjBtIXq7SjlgSxECGpJ?=
 =?us-ascii?Q?tKMB3B4goX4ItPJTjf8950NH1+mznOD/8YukD6ZyuyurJ9F01UotmHP3BZuA?=
 =?us-ascii?Q?QnKd7KMALqxecS35dlYxy0LSfIHNIusGWbeBkMpFQCzJmmk/IGaKVw38l43P?=
 =?us-ascii?Q?BXUgO0Pj1Mm2mMscwR3p6M3m13Jr1e2h8gYUZreQhc07ijcoU801q/I/fKNq?=
 =?us-ascii?Q?23FJHj++OC/RZF+7QP+RM4Ki79IZLKa6xPM10gMp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ade4019-ee34-457a-3535-08ddd9220331
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:57:06.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZJTdb5AFdicOsBZwaBOJ2+L2RSFdFGUo7P6jxWoiezjOBtdzedwxZXqwJDs5ngXXw9AIOx/UdSe0of3kCQdUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207

This series adds new format modifiers for 8 and 16-bit formats on GB20x
GPUs, preventing them from mistakenly sharing block-linear surfaces
using these formats with prior GPUs that use a different layout.

There are a few ways the parameteric format modifier definition
could have been altered to handle the new layouts:

-The GOB Height and Page Kind field has a reserved value that could
 have been used. However, the GOB height and page kind enums did
 not change relative to prior chips, so this is sort of a lie.
 However, this is the least-invasive change.

-An entirely new field could have been added. This seems
 inappropriate given the presence of an existing appropriate field.
 The advantage here is it avoids splitting the sector layout field
 across two bitfields.

The chosen approach is the logically consistent one, but has the
downside of being the most complex, and that it causes the
DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D() macro to evaluate its 's'
parameter twice. However, utilizing simple helper functions in
client code when accessing the parameteric format modifier fields
easily addresses the complexity, and I have audited the relevant code
and do not believe the double evaluation should cause any problems in
practice.

Tested on GB20x and TU10x cards using the following:

-kmscube w/NVK+Zink built with these patches applied:

   https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36336

 with various manually specified formats
 and both manually specified and automatically
 selected modifiers.

-drmfmtmods, a tiny test program that lists modifiers:

   https://github.com/cubanismo/drmfmtmods

Changes since the RFC version here:

  https://lore.kernel.org/nouveau/20250703223658.1457-1-jajones@nvidia.com/

-Dropped the helper macros & static inlines in
 drm_fourcc.h as requested by Faith Ekstrand,
 who noted these aren't helpful for UMD code,
 which is all written in rust now. I may re-
 introduce some of these in a subsequent series,
 but we both agreed we do not want to delay
 progress on the modifiers themselves while we
 debate the details of those cometic details.

-Reserved an extra bit for future sector
 layouts.

-Fixed handling of linear modifiers on GB20x
 and NV5x/G8x/G9x/GT2xx chips.

James Jones (3):
  drm: define NVIDIA DRM format modifiers for GB20x
  drm/nouveau/disp: Always accept linear modifier
  drm/nouveau: Advertise correct modifiers on GB20x

 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  3 ++
 drivers/gpu/drm/nouveau/dispnv50/disp.h     |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.c     | 25 ++++++++++++++--
 drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c | 33 +++++++++++++++++++++
 include/uapi/drm/drm_fourcc.h               | 25 ++++++++++------
 5 files changed, 76 insertions(+), 11 deletions(-)

-- 
2.50.1


