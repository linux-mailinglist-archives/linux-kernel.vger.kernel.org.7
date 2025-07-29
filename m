Return-Path: <linux-kernel+bounces-749508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D23B14F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2BA543D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471FC149C4D;
	Tue, 29 Jul 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PtviqQ/7"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF94746E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799423; cv=fail; b=R7RVqFV4Wk5wQ5ix2zlHDhDQjYGh98zDNrf7GHI8na+L7l7e6ePLBNI1PhkV7vTiyJF9S11aPs4suKJNqBboQ0QeQm03Or7fxnGEUpo5W/E0r4fLdJxG2JRpGdPIh/LSSX3gGQ5KLXERrKsXJjlX7pG/6j4bmGHiGX6QSgMWYQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799423; c=relaxed/simple;
	bh=LUx/FSlie2J/T/okeX1vxAwvDNAyhUjR+YCqQTQm6ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uumfJ7ENa2f/3z6DKCTrEPUs6cl2ym9MY8TgHgyc9X8rFRPyNcj/z0nAJuUrNgbsAJYxhhG59GylAGnzAGGU2L19xzWV+ZZQ+0tQqubm77lCEN6fNPoi07SHsaaHwRKqLk9ebDIcIOnmp4PCA2p/hnwQWdGngqcSwGAVD0/LxRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PtviqQ/7; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4PW6Wa5fVciBGyLoWXamdWdBjb4T7Rk5j4hIPm3jtDmYZj7lKK5n2me7zE3f06Yr7xYUsspK7YD+IAepjxiO29CYOvnj3yGnv0J/mz/wPUqv+uVmbXGwiCOZJ7ZbwLvSXF8Wl37oGa9482eIxtRrGyN00zYX6WQjduG8MiCvSBEcXsVY46hkX4gDAycxJPNFYl3xMgjtHhb1rbkLLCABFvlPfKDfNu8EKxJ66WCzXYCRP7k6KlGNacOd9EpgzQ97wQKh9zQOlsuPbT7+7QzM1vxLN8lAsyOTtkEf0q89DiriYGz4jjWXrIUQhn1f5Qtm+Yt8N9fXvCcdw6XceHE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLx39eyTHOGatk/I49xFk1qBTIYABp35LFDVBx8byoo=;
 b=qKA0BcJj4fhc1weTxbrWfcipJ/khadty617H85leEKoVGcv6Uv88hn4WgS5yC3JF2YhSrMq/mwz/tC62jz0GiW0fXW4NaEag0grtgkxkFjCOl3T8JiblSMHfZO0fWhRPQvw4j7c/0dPwUMzwlIwe6/l2Cbvs278aCPw6RlgDdDCeIkR0e8AYYI+N6kMPbCkb+17h6AnSOOXG4n+l4E52qmRZyGporaFJhpxhwzytP6x3oPPHpBphJfYhjPpOxcn7gLoZ95DX6R+TyyFfzweuGNF6SQm1jkfxZQpNEGS2KjNPmoGZbvfT6d6plGj3yn0dyIufCImkHHXmjDRkx+mWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLx39eyTHOGatk/I49xFk1qBTIYABp35LFDVBx8byoo=;
 b=PtviqQ/75aw85AXkKNj6qFt9k/kVsk76lqBWPs2OhONWpfQuigCrzO72WPiHV3yHWCn2RjTM017/Bcj0zzfee5qxfmyCM1aQR6DRDMZYeToTlmeKzNLM+ugAfIqvVAmAJFSC7p8/bncs/r3+EhDPNMeJsmNAm3xFIXBZPS+pmerssvxKOoideV6aFJ9wcDyvlbhs8CqsGxVo8rCL6HxTWfwE4UJdekba0DrvbU5OCMi7UjZhpZCoPo7sHj3TuvLOA4/pkd7H9QDQcz3Qf0rAwWEitdtr4ZJFGbLalB76WQm3vqvtbSrVyyWZX8kQGX6bxzIs23xdczha8uCIFzEP9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 14:30:14 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 14:30:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm: add get_and_clear_ptes() and clear_ptes()
Date: Tue, 29 Jul 2025 10:30:09 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <0B957D2C-130C-448E-B38E-C1E295C275C8@nvidia.com>
In-Reply-To: <20250724052301.23844-2-dev.jain@arm.com>
References: <20250724052301.23844-1-dev.jain@arm.com>
 <20250724052301.23844-2-dev.jain@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::14) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 25636748-3cd2-4683-f380-08ddceac6ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tDIrtbdZB1gv+pz8nH8qX+qyDPXu/ndKYBJkIzJoYFKFDkGTqjd78ECS3KNR?=
 =?us-ascii?Q?d2Z3epzbfhk47oPfFnbRTsV67G5r3dnMG5Ekul8P/dOKsfJ3c4sBkPxc3HCU?=
 =?us-ascii?Q?ZoD4mvibLVMZLAwwWJLMMls1hpHO3Jb1EzxGLsHdNUSHVn5JswZUATEdpWEC?=
 =?us-ascii?Q?Pbd4cl0QVUujWgy+6P/KfbKEiG0FzOO9RJy3+pLqtsvdkaU5KMputTJtvX+r?=
 =?us-ascii?Q?oJcMK7FBpnYy2/wXE7rUmEpxWi3ehsKduJGGIW38uqurWaZ1awYEO/rEpGWe?=
 =?us-ascii?Q?99NlsC4nuCU3qnUlRtL2r7/Fn30WU1TyT1n/2f26tGbDpKEkliISy2TYM+dM?=
 =?us-ascii?Q?3zApfICi8g9CNOMLXF0lTIm4i0mZDmrf9Rpxqf9wdDROFvW2Ksg2F/WuU+hw?=
 =?us-ascii?Q?UozTjdcYPBpm0M8ZiQi67KfzdEcswW8U4QYYQq/Ru/3Zo1UmTmmppnw9h6Gz?=
 =?us-ascii?Q?8Axg7q6Ndy9mD0SA+ntxOevg8vh6uRmFV03Fbv+lia6VKeYjDOoGXODtLRNo?=
 =?us-ascii?Q?zTvvTtXozpA242deL4+B7hPE2AESDuuH0ReEEAj1OaF4ycNXqbenAN5UGfWh?=
 =?us-ascii?Q?xYrncvj5xg8yE/Om8KQuBDjZLZ3kSLK+p0UQlUcsAikg5IP6giHRzdMZJncP?=
 =?us-ascii?Q?L6MJbzKtIlKy4SSHCT5b4wamz2Hi4D7PBgdPhMJfl3TOSf9Bmt5YX7XomECz?=
 =?us-ascii?Q?NOdH84RNCVJurYlpiFtyVwdUtcT63q78fovBwIgatoegjBzQigN6z0t5lMw/?=
 =?us-ascii?Q?aCZnZTtCqTkZeWhZ41lWJCkJDvCKHI2smZBhVUR+Fn1g5dW+ia3WujMZO4pj?=
 =?us-ascii?Q?b3QlIqTpZ2kRss7VPMkfozWFZDHkQYZWz0kKiqwHqIdhtVkncdwB3zfg5WSQ?=
 =?us-ascii?Q?ge7HQ87LwwTSLj+iF98/WmZ3+Mb27t25Dqm+vF3+8boGqrigJXWLgSgOod42?=
 =?us-ascii?Q?A4T9zWv5xj4Sy5py1qZuJbAEL++H48za4fEOhFixGlEQp9ZqS3diDvisbO5h?=
 =?us-ascii?Q?4ObzuOvDT3J/tKBJmOhtjPwDr10LR3Fhv5Uy3U94K28SM3EdP/DF9ma4k8LT?=
 =?us-ascii?Q?tTV+gWxmB/9lVqyYY5meyUFe+OrytCA2+5uR4XOMAJdTx1M4HqEzeGME2/yA?=
 =?us-ascii?Q?gaia1RLbi80OaGqSwNmecFRmQYYk3d+LtGnG6GERdWCCXB8fHkQFiG6fKnH0?=
 =?us-ascii?Q?X32X5t8QWD4Fv10tda+RUvbLXFDGwhBNogE6kwFFqL12RCgyiPRD3rVk4sZh?=
 =?us-ascii?Q?hRREHtjtUHF/Yg8pEezjyMTznJLB+aNZQPI0vyrMGpyJmwKWWcI9o1thFZet?=
 =?us-ascii?Q?BuyS6KoHJh3LqM+Eqiq5lMg17+qBMFuYmoHDOq0OZG0eRTCLbq41CsMm5eCv?=
 =?us-ascii?Q?2DueSGGc4bxnm0S+aKfc8KMVwDMPXzajueZQTtLpIP99FsPp7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8QGuv1o9OBtBEWj348xbEDfwonGExw0iP2y8HQgBnqa2hQLpsEd8z4FA2GoF?=
 =?us-ascii?Q?+0+GDs8eYJ8Tg1g5Jc7wIL1FaReGoIJYVeSd6WrUmsEkGDYuK972775fVeGk?=
 =?us-ascii?Q?Ap+iyBPG4h1q42iG8Lb4o3rz/m6xRsOkGaqFyFVIzffUGny1yb5RlYSm/EgS?=
 =?us-ascii?Q?1jwaMla4QJaiKGyyGncfR9Fx+gInx1JSaaMhwqMz5p1kmJTqpYRhChtQnBK8?=
 =?us-ascii?Q?0todbU2RtpueBLqQgllLV8wHkh24+AQz43OAJKeOgTtEFkV2KPxbulsNWZ7p?=
 =?us-ascii?Q?j2QmQJLQpigawrppb4gK/qCifbpaFiY3pJ9GFzRsNCDXGdWxHG5CE2Q/cqKN?=
 =?us-ascii?Q?/A3k47m5fbR/UnEG0KmfApfcouBIzaA4tUdi8rg51NMNvZTlJU/bghq6e/UG?=
 =?us-ascii?Q?mOgEHmm60WxYAk95pyvLrS/ssHzVauYmqQ1XsdZIAHVMxNoMc9gynitJ9Poh?=
 =?us-ascii?Q?wPAynInF1o7mflTKCsnnQ8mU9j4xzp8OVl+WgAruhGinzINXUiZy/egmNVPP?=
 =?us-ascii?Q?Rzm3c0YWVqebHMw/eHH7Z0Did1vhHhw8ytSC+2+pxQXKCCr3zcIT3l4kDhHz?=
 =?us-ascii?Q?C32WIKHuVmTBch8GzEQ5N0yRe5GUq4wVDqKk5e0fEVnsmuakLq9L9KClmLu0?=
 =?us-ascii?Q?B61AM3FCOQ76KiNr9YzndJnzO5pFb5wrUQIlvzt5mhq1f6K/EfHpjltrRunh?=
 =?us-ascii?Q?k50d61Gxee3oeQAwvkR4M6jr7NO7jjXB5jUTua6eOd/ZIyvXUUqqF248hmQg?=
 =?us-ascii?Q?/TRzkRbY4iKVIWT2YVvo2UpekwOQLDQhgRu6C7aZ6i7vYPeEHAaeqqQgIfwp?=
 =?us-ascii?Q?jnGlTMEVCxi9UAO4U5OC1l9O4PzfntcWSr4hUnuCwxdEKpwxrn4Lyf5122Kk?=
 =?us-ascii?Q?r8OstDerKgXr17vWrp5Lugq5ntMLZcRW3Z999HhOzlqiyUVgmRm5QRVSiOF6?=
 =?us-ascii?Q?aay9b+Fa5LftL/NEGzL9+pbrclJPTc5Vl/vy8NU9dyGesdc0K30G21LbzSnD?=
 =?us-ascii?Q?Hmsz0Q877lnCvgtT3/cod+IyqbiCvyaxrmTRl4//SmoJDl5LgqYqMAmgGpsd?=
 =?us-ascii?Q?2yCjy+4/7LvREBj8Uw8a9Qifgf8zflb6fAc2esUYUnC3h/IWPrx6S+JccvLI?=
 =?us-ascii?Q?BSNPHTyPWZ499L81UvwVNX225JrkUR7wAn2bQjXPRNg0nbkpW7yUtaSUSBRq?=
 =?us-ascii?Q?+K1jS1b9WD1Vr3wJYbDkIlsu2wI1Hg3Y5T/qt/SfEFW76nMTfmCM3Juz6v/x?=
 =?us-ascii?Q?IQaQ9Srg0JGhLGNandPG7E1e7k/LfFwzTmxm6j8b5hT6b+2ctXsAmORWGPIQ?=
 =?us-ascii?Q?RbYa3Y6KiEBhIkDOkmbLRGsF2xHaVYMOgC81l0EMKJ1TPsDflUyMcWVUWQ/G?=
 =?us-ascii?Q?xjptwFwPG28A2UJFRkky9kQpWFR8UHfpxrbaJUxLoiHozRUIgIi2ueAAk5UD?=
 =?us-ascii?Q?8e2mx5sF/NijDKKEMFv41y4lmoxZB3ZrtACQ1Gri6TWJshyXeKKUg8ca6opq?=
 =?us-ascii?Q?wKzslFujeuYRWVJPeLkF1ahpbI0RBDaCPc1gWcBo4bUEzPScC1KajV1GcHcu?=
 =?us-ascii?Q?pBds73yqXEn7M4N9TUA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25636748-3cd2-4683-f380-08ddceac6ebe
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 14:30:14.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIhjbPKwxsqwHMqkk7OZBEW8a63cgUC0HHgauwp3QUTcLqG4CyY4Kk8/LePkVHzb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000

On 24 Jul 2025, at 1:22, Dev Jain wrote:

> From: David Hildenbrand <david@redhat.com>
>
> Let's add variants to be used where "full" does not apply -- which will
> be the majority of cases in the future. "full" really only applies if
> we are about to tear down a full MM.
>
> Use get_and_clear_ptes() in existing code, clear_ptes() users will
> be added next.
>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  arch/arm64/mm/mmu.c     |  2 +-
>  include/linux/pgtable.h | 45 +++++++++++++++++++++++++++++++++++++++++
>  mm/mremap.c             |  2 +-
>  mm/rmap.c               |  2 +-
>  4 files changed, 48 insertions(+), 3 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

