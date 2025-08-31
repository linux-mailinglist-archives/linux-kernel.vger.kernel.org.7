Return-Path: <linux-kernel+bounces-793215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725AB3D098
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 03:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455A27AD949
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 01:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1DC224FA;
	Sun, 31 Aug 2025 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTq2to1u"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33001DF252
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756604714; cv=fail; b=Ylcln6J8CPNKziw4Fsni+MZyDp5XR5CcJFgDw0jtjNyTkXs4M1mvZ7P/Hsb7fAwtqauoU3uDQ+FW+ULdmZvywWD7SD7wex2/dCQCQyHMnRlHDG9b86GikKrpmjxUDx/zZnzwhmyDvXO9a1ZLX9I2NDSS2uIsAud/zDCF0BBh8Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756604714; c=relaxed/simple;
	bh=FMZkIcJf0Fwq5MkFvQnYK8KggMIpaayyY5e3NgGoEt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pmre70OIwAcd0VPA/0ih7idxVmgNGYwc1BncSdnB4oJ0BCsZX18DqDYVArThQYYwsqIwY3KveQL3mQ5byRsoMLwYxJ501N+HtVGHx0mNHb6PKJfVrTypokPbwUFlYtAiHbKfTWBJ8zvw2wLSLr++GPwjguNHDF5A1zQ6HID/Dng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jTq2to1u; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nswj2at2d2IqhCgloTBh/QvPhy5oTjipWFWcJXYUUV0yO7rU2eAPD0Cno+o+OS9UeIBBOAOdDbCtp/U8JhWGE+8O/c7fMAYbSnBcguy357G709jW8RYLJG3z5PZbfy2SYpo4I1PaRmULdXvKDBW3or6DOOtlHxKZG3x35y4yF1M8diGrYQHSrAuFXa6I754Yop37JGhTv1mJbZA9bJQwmV5d52L26H2g2Q7JNAJlZzLRrgoM4V9CcOo0IiW9Gsvd5Pmy03HP1H2hCZ1AkMRYgnCyDzxBzs8VRdfvnsw6AhTLk4awo9DsiF7/7K2dGCFj3JAMlJ8zxxH5Y3w9tC+Hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3AWXbdf6CiFRr4Ir6GqI2yuS2xKDfRZ34z66o+KZ9w=;
 b=CpTzBePinxIkGXohk7T9WR3NwsOjoLloF92Qz/K77nWOhx9NrKzqbNBCDqkDsVjFQnPh2Z3VQASOR4ebDORkAHssZEviNjNwVNYJfpVNREUEQ2jsZjjZJmZLXFBwGUS3cI5TSyssnUPaC6NgoS82N2SttO78weHBmID6UzEx1CMdVpKHGLvpOi5p2keDX7dQAbovtFl/VUNVv73DQThAedZArTGWdEIxHmk3S7/ld7lxJCBJpHWIUIunkT2YLHOuymqhLt6irwsU4m124+portgTe6xWM1NRun86WurfGwu88vtIB5vztpBfaR+GR8VST+MKgYFG2aLtbte1awoh9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3AWXbdf6CiFRr4Ir6GqI2yuS2xKDfRZ34z66o+KZ9w=;
 b=jTq2to1uJn3jbulh9DpD8Bbd6reTKwOybe1qBs2EcMvKnmVZiJwpG3M2dsbEMuwKMZubfxtye0y9qem0UBU11t9YxuUQ+/TftY86Wz0AXHYwMdEEdz+ohpvXA0J5LllnhlLlK6x2HVicO4E/PRc/kDPNSXPOdDwlrYOMiyhbzVPV0K1Lzh3UrTLcWQraBedsHtRM3rXXWAdjK4oAsccALv4RhiDb2wMzD+A213rkSRmlJwXxtQSFXOu8c/OW6RJdlriN9fGFIX/IMSJsiSmSzDaC6wqnyTqFwFbaROPEC2tlE6XO0W00EtRjLvGOlxcgy/jQA/S+VSP+l8exHILLgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.13; Sun, 31 Aug 2025 01:45:08 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9052.019; Sun, 31 Aug 2025
 01:45:08 +0000
From: Zi Yan <ziy@nvidia.com>
To: syzbot <syzbot+2f3c8569e4b7486452ae@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com,
 david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
 rakie.kim@sk.com, syzkaller-bugs@googlegroups.com,
 ying.huang@linux.alibaba.com
Subject: Re: [syzbot] [mm?] WARNING in new_slab (2)
Date: Sat, 30 Aug 2025 21:45:05 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <BBB1284B-A829-417D-8DD7-83371147F876@nvidia.com>
In-Reply-To: <68b3a799.a00a0220.1337b0.0029.GAE@google.com>
References: <68b3a799.a00a0220.1337b0.0029.GAE@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:408:ec::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e30d00b-022c-491a-adc6-08dde83003eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o2bwPENMayM2bBQMK5Kz2eS4gN0z+gs3BKIJdipIi/+rIP4scHTvvrlxM3Cq?=
 =?us-ascii?Q?fEnwNu9jYn5VfEUQTtyo33HLtTZdPYE0NlDBoJS/mDtE91uBG7483fATloxZ?=
 =?us-ascii?Q?SubEMjGZ4pbKpcWQnQGwEhsBXOMDYpffbStnuzl5IXJL7sHKhHuz+YgApKYe?=
 =?us-ascii?Q?ZuZNnjLAkXSw9OoDcBd6DnD5RRE5FiJ9cGLqfJZTHaWh/omZo8RjZ//BRWL9?=
 =?us-ascii?Q?x3KvbhR59zVq0wy7+fRGwQZpWK6mDJ0DBLe3020oO+cAz7TP/9m/pGKRVsjT?=
 =?us-ascii?Q?IluA4VpxIvDcnyHxCBWxHcIFwSYGLs2yMFHvWKngELhWC+r66q3kFRNC0mSG?=
 =?us-ascii?Q?0yHeXhu4+dNWjHznXwu/XYvd3aXdJiYt0nberwG/Bcd5cHmiCwCV/u8oh8CC?=
 =?us-ascii?Q?bS8Sm/NWmDHHlpuRRJmBWvSOBC1L7AkQduYtZpDFWbJa1uIdTosHKXqnhAFu?=
 =?us-ascii?Q?gAG+zyIsnjubRGJS1/pMprdl7wNBBPeDOVAZ46FZsK79p+PV2TCT8hYQxfzY?=
 =?us-ascii?Q?XWKANYUW+2Ytp7yFETMx5PsvDKfQhiOwtG0U5ehCMPK8EU0jI9XS8nN2lLxC?=
 =?us-ascii?Q?CP2aczxchsDNkN+J/RJTPYXJmVaFo8LXXkkWWrTRdPDzo9JMHF1MQdqH2OqU?=
 =?us-ascii?Q?4+k8B+uBXypPyUCTxqlcpfct4nNjKG+n+YPDv8S9ujDOjAqpfJBJRMFoxxHr?=
 =?us-ascii?Q?hHMoJMAlxJSijbHVFTQ1HWEmHh/CgRZfjnw1lr9c4HOUbwJtbPV6PiIttDwU?=
 =?us-ascii?Q?wZ1gqIpZxNtget5PvM0CECCvJJnC3tDvx1rsLzVU4etPoMv5V6ETF/J/CLwq?=
 =?us-ascii?Q?SpIsvyz8XuSZv/WpfW+HTRo03S0WHw3zE3Vulg0Drzm/V1K6YW3dYKB3Hjet?=
 =?us-ascii?Q?QPJTHx2y5PyP0TIClqwlVYwGqg9kP1FGSywJzkO2uSWYkxpTUXy8Xz4Bx8pl?=
 =?us-ascii?Q?U7rt8tHzidt69KN2K3g2XkYaZTnN9zHPPkp162UjPnMo3SWJ2KkmtHS/Q2FS?=
 =?us-ascii?Q?cEVy3lQVchfdKydE2vSRzYDXvcmA7a3EdxDMXNGITiMrC0t6YFfwcxj7UhIQ?=
 =?us-ascii?Q?V3/s889YmO2KXzAY0ARcpKLMiP5Frw87vl8QgIClB9fCX1ITx92it+XCitix?=
 =?us-ascii?Q?+LulTC/rDK6t8OQfym702ZkMMbXNa0WttkIayMuE2iLxiMNrsDtfHRP9LonG?=
 =?us-ascii?Q?b4+ocfP2bBxgpP7o4hI2JjrqwhtdHAwjmhE/nY8149apZhpqRIfrQQ4OAmKX?=
 =?us-ascii?Q?EQP+BuQSks8F1RpyEpD++UoR2bWnSNviM04tOKVWWn5jS/7gLoYTSodXvJPe?=
 =?us-ascii?Q?yxoChaLALXNcCi2FM5Yw1z6MUhxQksAiwZQcGcB6zx+LWl/CrxEPQYHNB/tD?=
 =?us-ascii?Q?lB/8CnJf7dPRNRyCEZQ/w+gQ9CMQeYen8OKIpwhsYVrLmWse6Ab3t92BWRDw?=
 =?us-ascii?Q?S7kIAgMRxRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FTWwneGfZxCbwZvE9Ost0ZgCOokvH/exJg2BQ1NEPWfRfmwP9z/JgFIqVfzT?=
 =?us-ascii?Q?U7IamaLYgNKdn7JDijH6olqYvJl69hrY5mMg+1WAm9tQj9sZsfy/awgpPVMT?=
 =?us-ascii?Q?S3QOkUUOGxsowsQXghcW0oWW/eVWbfkRDUvzTFB2a9fq5A9/D/EEcKJLxEUJ?=
 =?us-ascii?Q?uj/pd12Oh8nkcYn8xRwALUY+gQoQn9GmcDizcYJu5kwVPRteHHbx09PgM8Cv?=
 =?us-ascii?Q?7sUdfz9/wKxawDCBslkFmqpLpyLz+ZQTh5nzqPjZ5P1jRLMFULkcVN0uRjDH?=
 =?us-ascii?Q?d+MVQWwcJMd7sN33+K9CTlS/KYZyQZhQUVh6ewiONd8IZzqz/JGvQksHE0gN?=
 =?us-ascii?Q?7rw7locyICAFja6k80JpeQl2MXIlWpryf41zw7mQfLlQChBVMtZoPJ2FXyMl?=
 =?us-ascii?Q?VQqXNAWILkx9lztZt3+JSOjgfXeOMxZo5nGPUH/QDpEBcGcZJoYHSJr2gw8/?=
 =?us-ascii?Q?b17qkJehPcDtfBFiD1Jqqh57EAoOw5yYafZkJrnIy8prU5H6lyqqhoGqM2Kr?=
 =?us-ascii?Q?hzDy2oC5LfZP54PKySa4sWfJ2o2pxtIciMHkt4chQoHUYJQrSAT6wxkrJvM7?=
 =?us-ascii?Q?pvk4Ui+lgTt4IzjtljtFW4rBWKBXrlPnVDBR5bKmcdb9dHdAxe871Hh5HXyR?=
 =?us-ascii?Q?l/rD+gmsyJHtH2MBB7lEcG2eM9af11cSXNIf9PVvdw+JGad8ZC1p9dDylXj7?=
 =?us-ascii?Q?CeKj4Nf8ogxxWcrBLynXHXhyJIegw01VALiiY9Y2qrB8bzbxO9krgKTigP1G?=
 =?us-ascii?Q?bRZTURQpIMScjPb+3D2frjlN67sNoWDdi26LQo3M8I2RLomupt1AZiZUGTgI?=
 =?us-ascii?Q?eC15+AGf5HZb1oNCYqbjge9tmsLzWKu7iHWnUctKZtJGl5uAE34BbyJpyytt?=
 =?us-ascii?Q?///F9Ic3g/Dzm8I/5hebksgR9Yxzr5z4fxU3oyj3a1M4EusH0DcNDUZ2go7M?=
 =?us-ascii?Q?17KwCuU9HC2RiP9aDeX2QI1JI34hd88AhJhggUCEmh1rzsgUHNUh3Y9fjOZp?=
 =?us-ascii?Q?J8sKsC+L30F/V5ir9BjHeXFDe7gPU/yOGGDGZq95JRl5LhUJAnFg2eHe0V53?=
 =?us-ascii?Q?bD2z3NjfHyelsjP4cZ7NfoElNCmL839WsOnZ2mCBR9f515vpzJ0HWLWpBmTS?=
 =?us-ascii?Q?tI5FTm9Ib6IcCfJo6mEUkamfuqUSGc8233Kwtqsjf4E4A5stygMcVkW2Lvlt?=
 =?us-ascii?Q?BcnnKWy9Lp9p9/aZyg8ql7B7kJpEqyb4deAkuZLHwQCqyou9OasloArTQpez?=
 =?us-ascii?Q?VEP8RcZ6bwiiyBKKB57yXrCXGfay9js67MMOjcY25lWHcIoi87zjuwN6HRam?=
 =?us-ascii?Q?Vcdt4phWC8n+tO5AEcQRxvtzfNuze3a5ftIH46lNc9c643Nob8mPkfgHey/C?=
 =?us-ascii?Q?RjD9wHbtEh4g3elpQmRSFEQqDWMRcKAvhR1Od0wzLQQS5ymT0j3ih4xi3ZLh?=
 =?us-ascii?Q?7KRbAlgojJ9vE2ofWFIKy5rWU0x40ybGQzCeF6ECAOUD/wl/kzyWnQLpb5/t?=
 =?us-ascii?Q?qPZEUGBDmwZJ/VsIB95Dx7g9MxodCZn1YpklYozyYvUxp/eu7kLS39UqDCD/?=
 =?us-ascii?Q?bvb4stIpAzVFpU1f1CwpCyfWiJWuNa5nU7tybJYw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e30d00b-022c-491a-adc6-08dde83003eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 01:45:07.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mC+wWoNJO5HOpwrRb+mHNONI3FkbDM195L4wYRRgXx8+REtiAVUmexk8hL0j+w6b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765

#syz dup: [syzbot] [mm?] WARNING in xfs_init_fs_context

Link: https://lore.kernel.org/all/6861c281.a70a0220.3b7e22.0ab8.GAE@googl=
e.com/T/

On 30 Aug 2025, at 21:38, syzbot wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    fab1beda7597 Merge tag 'devicetree-fixes-for-6.17-1' of=
 gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16ad77bc580=
000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfecbb496f75=
d3d61
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2f3c8569e4b74=
86452ae
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/d900f083ada3/non_bootable_disk-fab1beda.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/813fdba24db0/vmli=
nux-fab1beda.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/12a740d2c9a6=
/bzImage-fab1beda.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> Reported-by: syzbot+2f3c8569e4b7486452ae@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 10417 at mm/page_alloc.c:4619 __alloc_pages_slowpa=
th mm/page_alloc.c:4619 [inline]
> WARNING: CPU: 1 PID: 10417 at mm/page_alloc.c:4619 __alloc_frozen_pages=
_noprof+0x1f21/0x23f0 mm/page_alloc.c:5161
> Modules linked in:
> CPU: 1 UID: 0 PID: 10417 Comm: syz.1.1147 Not tainted syzkaller #0 PREE=
MPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:__alloc_pages_slowpath mm/page_alloc.c:4619 [inline]
> RIP: 0010:__alloc_frozen_pages_noprof+0x1f21/0x23f0 mm/page_alloc.c:516=
1
> Code: 90 0f 0b 90 e9 0d f9 ff ff e8 bb d6 0c 00 e9 43 f1 ff ff 4c 89 ff=
 e8 ae d6 0c 00 e9 1e f1 ff ff 90 0f 0b 90 e9 3b fb ff ff 90 <0f> 0b 90 e=
9 24 fb ff ff 89 b4 24 90 00 00 00 48 89 54 24 50 e8 56
> RSP: 0018:ffffc90003a477f8 EFLAGS: 00010202
> RAX: 0000000000008000 RBX: 0000000000000000 RCX: ffffc90003a4792c
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88803fffd9b8
> RBP: 0000000000048cc0 R08: 0000000000004f8b R09: 00000000000043f1
> R10: 0000000000000000 R11: ffffc90003a47920 R12: ffff88803fffbb80
> R13: 1ffff92000748f14 R14: 0000000000000000 R15: 0000000000000002
> FS:  0000000000000000(0000) GS:ffff8880975c3000(0063) knlGS:00000000f54=
84b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00000000326f2ffc CR3: 0000000070630000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
>  alloc_slab_page mm/slub.c:2487 [inline]
>  allocate_slab mm/slub.c:2663 [inline]
>  new_slab+0x265/0x330 mm/slub.c:2709
>  ___slab_alloc+0xcf2/0x1740 mm/slub.c:3891
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3981
>  __slab_alloc_node mm/slub.c:4056 [inline]
>  slab_alloc_node mm/slub.c:4217 [inline]
>  __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4391
>  kmalloc_noprof include/linux/slab.h:905 [inline]
>  kzalloc_noprof include/linux/slab.h:1039 [inline]
>  xfs_init_fs_context+0x45/0x5e0 fs/xfs/xfs_super.c:2278
>  alloc_fs_context+0x54d/0x9c0 fs/fs_context.c:318
>  do_new_mount fs/namespace.c:3787 [inline]
>  path_mount+0xbdd/0x2000 fs/namespace.c:4123
>  do_mount fs/namespace.c:4136 [inline]
>  __do_sys_mount fs/namespace.c:4347 [inline]
>  __se_sys_mount fs/namespace.c:4324 [inline]
>  __ia32_sys_mount+0x28b/0x310 fs/namespace.c:4324
>  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>  __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf7fa4579
> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00=
 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c=
3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f548455c EFLAGS: 00000296 ORIG_RAX: 0000000000000015
> RAX: ffffffffffffffda RBX: 0000000080000140 RCX: 0000000080000040
> RDX: 0000000080000080 RSI: 0000000002208004 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ----------------
> Code disassembly (best guess), 2 bytes skipped:
>    0:	10 06                	adc    %al,(%rsi)
>    2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>    6:	10 07                	adc    %al,(%rdi)
>    8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>    c:	10 08                	adc    %cl,(%rax)
>    e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
>   1e:	00 51 52             	add    %dl,0x52(%rcx)
>   21:	55                   	push   %rbp
>   22:	89 e5                	mov    %esp,%ebp
>   24:	0f 34                	sysenter
>   26:	cd 80                	int    $0x80
> * 28:	5d                   	pop    %rbp <-- trapping instruction
>   29:	5a                   	pop    %rdx
>   2a:	59                   	pop    %rcx
>   2b:	c3                   	ret
>   2c:	90                   	nop
>   2d:	90                   	nop
>   2e:	90                   	nop
>   2f:	90                   	nop
>   30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>   37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup


--
Best Regards,
Yan, Zi

