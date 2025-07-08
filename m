Return-Path: <linux-kernel+bounces-722153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6530AFD5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFBC1BC699B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711722AE75;
	Tue,  8 Jul 2025 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KfUtlM4U"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7227B21B9DA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997925; cv=fail; b=E53sgFCyC6CjdG+TpXPxke9etgK7rUae2hH83InfLJB0ZdNQ3Ccu3txalGs+1XyEAZxm+CCz4Z1huwoGmcG2BocnqivN2oosqSQGtMoGZqshzr/VZfV/zKJgmfNZCRrhvBB7zVQliDVhsB2/Ul76THuHP9kbWvV6ZkxrHkYJvbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997925; c=relaxed/simple;
	bh=gpb6TGYpS+6qW0FNRgUwaT6sSvi8xMGH1Buw1bUqFC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhlcLDNt2mFb+3X0dO8fpeDGM9Sqyhaw8uVKaRDPO++/rvlefcN1oHS3F1DqqhV48AtywS0UU42kmwMrSh+j5wW+SBpOPEwzEjU3KxlpOKXzI/MW1iYu+9wa4xRW8l4LV+sFhZzS3UPkO4pyVwHPc0094dK8SbFLyylIWo8BKSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KfUtlM4U; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYMwhwiNbisUjAo7VV9u/IZnYILMUnyDeNe1cA9GBdeFutSwXQ/FhqN2SdU/Re9Y3K9Xxa3G3sIGy8MsJZ+ZgRR6yOJLzN67dtnLVApRBAGIGqjuyA2A8CNRMonIbgsCviQapfgExLJR7Z+rYlqV1Dk4oWXA3VY3VM4NAQTynX3VYWK386f3FE2Bav1/846IGu/sGKQdkzvuqQsYLG3aXNwAwFCDJt+Pf4Gg/9EYi4xFT0644N5WGh2yhYDOqCxHsT3uDX8rSUAxZ3eOeUtviBYwGUqbIQbhDsOMdzcfQ5LGT6HU/ZzCXbGxWdlby8cBP8GKSydwiy/ONPuLIFY+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01I4AGEzsmBdZobQU54i93/3kXBhOE2W397pywnIj9Y=;
 b=uiZWO7UQcqc0UkPv4tNsbwTquJ6OoE32QSuXVUj1KBSw3imlXHyJIWi7GA70P5/+uzo5Pyo+eGrOmzCp4L8SuEb2nbyF5ZluJ5PTOzA1IfORuvjpbYxogG31XaMn2yXXKACHTDwyAhKscfGT4Bfkp0ZuyMS1+HZBUTpeLx0bK7UZM4NCyHZWEJpGCj0dhBvOHBOdanw6pZJJoGPxmqlraOUsHxduLulsOFNCmJWYdfdWArSGxCfSIE96JyzjP48lqP73bVZo7kzM7DPMw3yaEWg5iJ04Nv4uFjqZKo18wnFK6D/Knvct6PUhRJTjZi24bI2rJU3e03YdrZLTRUlczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01I4AGEzsmBdZobQU54i93/3kXBhOE2W397pywnIj9Y=;
 b=KfUtlM4U8fBmh9ZvNnYF1L/ekoeIFHSRSP6HMJG7L33lMMrDI8rijxBvffdY5tWCC4dwh7q1M0zNnP99e1cLW05KdAVcsQB4l7+AobSlfbdBazj6C75ljkMQWdY/J3xndjmAwVnAzbh2GmR3FBK7kqJn+TLj+c96HRhYEVu5mufTmkB7eTu6gHsEuvUkgjlBXY5Bie2a5Abn2WMjquzDR7vFWnwQ3dfPyRQt32V3KL9mnI9Tq2HEAelw5sSfAm8U7epXx7BPCPImlkbxzOcaKBf/Vfui/PX69G3vyvWL2ZjLTYSs7ElvGiIDmxH4gbw4/IyrKKlZShTDzWgw/lsFJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Tue, 8 Jul 2025 18:05:15 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 18:05:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: syzbot <syzbot+3a24467a5470194c4175@syzkaller.appspotmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com,
 david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
 rakie.kim@sk.com, syzkaller-bugs@googlegroups.com,
 ying.huang@linux.alibaba.com
Subject: Re: [syzbot] [mm?] WARNING in move_to_new_folio (2)
Date: Tue, 08 Jul 2025 14:05:12 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <5698FD73-185C-401E-A1F5-353058FCB946@nvidia.com>
In-Reply-To: <686d5a9f.050a0220.1ffab7.0016.GAE@google.com>
References: <686d5a9f.050a0220.1ffab7.0016.GAE@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:208:15e::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 810d07e2-a42f-44ff-8099-08ddbe49fdb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/zJoZD5uzxdtBEbNIKzgEWQNUyictAQ5nkYvjor+5aFFm3AHlBTyOIOsbV04?=
 =?us-ascii?Q?8rlSFELh/GYLpT/eQy2v4MHqWyfaSJxDhAqh0AUsHfQczA62G1AScFrmEm7I?=
 =?us-ascii?Q?qKlF3hR+caU+qPtR9sodHuUyzNXAiBE63muYk3uVy2ER/chlwjYLZwdtjIde?=
 =?us-ascii?Q?bBOYIj3qtNbEGNrJ9BVEkEXQOyz9RXC6VUMXyg6FBh9c5A6HDSeyQQF3M26D?=
 =?us-ascii?Q?KyVa27HzUv/JYP6oc4rHvQaViwBAUiHc2yHF5W8TpM8k2KM4dv4FwaktTdB/?=
 =?us-ascii?Q?xKLXrZFvJHYvCZnLsdfYHxgrGqWLyrTbmltkvp9URPw5M9STtOPkGtarFMj9?=
 =?us-ascii?Q?vH+F3PA+VR7xzCG8brwlh+thH7uS89FCebyF49u/oLPuumQcGTqdvSNpKSgL?=
 =?us-ascii?Q?DOE3ljZcgbx8woRZ8IIPcKqW9waohiskiO3NPcS6scNk9UIBgWLjI4ARUM42?=
 =?us-ascii?Q?Dw2y35Ax+sgyZH63MUoDchuFD229LO+M1fcZvCEezhLUXqrzRnBDSApwmRfN?=
 =?us-ascii?Q?df8xBm+PuY9fq2qWpKmlX1xElGLSp24Xwlupv93bwbHg0qQCFc+4GHmrxVSs?=
 =?us-ascii?Q?uvQDBaaAToXc07dLeCv1GQrim7SiE+QSBTZRemAbMyNl5NbMJQamWb0P5auq?=
 =?us-ascii?Q?QggCugH6SwkeoVtubhthm8LMGygoKVfwtlqbdnf6lmLGTxlLq25brkeriv5e?=
 =?us-ascii?Q?ErfqCT9XtJfBJLGo5HMtIYYtQjos58JlN4EK8K/dS1uTVKcutRvCQMmg+i/2?=
 =?us-ascii?Q?Pj51Y5TOoVd0VVPUDoZOkeZtX+zfWsH45rqsbXuJvdBb9pwMV+NeSipgQDXE?=
 =?us-ascii?Q?L+F1jeUI4pV6+QEjfgKkbcewUxo7ld9jfMSUk+Fs76fl0rRlc4ZiP9kENS9O?=
 =?us-ascii?Q?fPJu0bHCi56ve1nTjftnxy66GotXhRSIAU7K0sjats8rUnVVx1Dh6rl2V/ki?=
 =?us-ascii?Q?hN7CXdFmioH6VV1Apg2qeRCq99XBFi/bqmowcYQtztY4DvsxR5z8RUOU0rL9?=
 =?us-ascii?Q?8Wnwx+RTVmNaHRSddqWtimZ8plBvxwl9ttKsBaD70JBuA7xOD0bvSB/chuTV?=
 =?us-ascii?Q?8rzPQ3+2u8UmxtHIS0f05MyFiY1b0qM8khbxkKHNR8IfzBb0lAwWIYKCzVpD?=
 =?us-ascii?Q?6MzUMdCTBC4K6cEwJGiBYG986Zy8vm3R/SLuXVN+Eb2nDT4RGo/WTLrsr+Ex?=
 =?us-ascii?Q?dPQR1ZJ2WLAXH08py+BcNAiBSdL/BW0w0V3UF+O6QTk16fCie4V7jE9QzRkO?=
 =?us-ascii?Q?72MdaB71/XwRa85cXdScZ63V/pBQ4y6G8IaUxaCRtI1h+eIjDtKmw57/M2Uw?=
 =?us-ascii?Q?gdWx3j/wGjlRD9jOXj+muokHwAqO1xpv1omMZ0pfTPzIN5GP7LsLi9mUkWH+?=
 =?us-ascii?Q?Ht01BhdWF4Z4roqU1YsyGzyHsXCWt1vIoYAm9POj6ZLZhLUtxnSd7CwSJ2xb?=
 =?us-ascii?Q?F6EOMTMJi+k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y/o8dqui+Ka2LG2wiE6HkFdUlsJih21R8zZ9P728vf3mO7bqn0qHmD8EBrjH?=
 =?us-ascii?Q?5K4TTuTIPs2HbfplM0ngmpWP2XE8/wJUjWcO+u+fmw9vz0pYcjpMPcK9DvWZ?=
 =?us-ascii?Q?MSJaSLGuqVjutR5r9QWyY7KNkjAHNxDaXnPNfuZKG+wuq5TduQGNjOvIJEdo?=
 =?us-ascii?Q?uxnvFSpA0tQ/P1+2NgMjTVbwMndRV+Szq9lyjG17V633wbbR5p0fRhpm6wZX?=
 =?us-ascii?Q?eNFUbJu36Jwzs7roqq4sWnFhDMZfY3vsuhbqSXa1ME9EPKH5dF33hPHEBYLN?=
 =?us-ascii?Q?oRyPvXIA/iiRl2w4ITBWQs/n5Bntjj1MiGancPQhEg9JnFnZlCwfxT1V2dVJ?=
 =?us-ascii?Q?D+4LNei1CB/oczXYASNvCmX3ea5nTmc5fkq2Lba7gxCzfjJozR/3orMNQQWN?=
 =?us-ascii?Q?0kG9bZ5Yp7Dvbtz+AHqAZBAQhEa+0sFZxXDVUkD/LKOMMAkI5iUK4eFcjHRT?=
 =?us-ascii?Q?3UKmSZzXD8PrzJgKlMxSkLD2Hzr1Z9VlvB60zaqcpfm+ncJwB7QLLExcW+3m?=
 =?us-ascii?Q?Gerf48iFRAHfwsGe30lW3anDAQGO+ORHXW2rc/ZV1Bwe8rz2oVMRy02/SXGw?=
 =?us-ascii?Q?0wMKLtS/cLblGIQGChSCy0uIfEVWxTg35xqEShkQNa3oAYTlawqETQZkDdhS?=
 =?us-ascii?Q?K/elVAcZy3IhfTmxCxk4jk1LPoDIuZtKNGW9zQ8TP5BYd8Fnw2oSh9xIhGwG?=
 =?us-ascii?Q?vSOx+gaU3jOGsDcICJBoMtkJsxnEfD4I6pKRO/SBDAOR6WOMXyR9Wv2kNOT9?=
 =?us-ascii?Q?LHYBLMJ14jCUU0K+QuLPIbzeMMYtzEThkOaGtofVQ/BhLS8CuM7TaBcy2vVE?=
 =?us-ascii?Q?DKuwTCSAVuXq515BueKcdr97FsmD8B9PjzlA2eHIXF9qat3OQewCvZE7zF1c?=
 =?us-ascii?Q?YEbAwSSLHKoIpFzUK07e0WWeZkXsuS4oTr6xRwIHDqFsinr3TBmah0WlJg8/?=
 =?us-ascii?Q?HtZu/zKA6nIRPwVUN3ZNBULPDAwXIEltXcDOI/rX2EOg39iZb3z2prE4OK+g?=
 =?us-ascii?Q?h6KqQst+DL8EcUw5jLVmGQb2HxjH99fUyuiy4Fq6/7SkqiMQgSSrnRnJ328B?=
 =?us-ascii?Q?dixrrWpyAZ0rvpLAuMsRTbDnLJMSvd75x91YVNJcDWS1t19X/jt0+XrgAJiR?=
 =?us-ascii?Q?nas989lD6RsfQ0dBHIPmEPk+pg1I8mtjvxwkWs2ogHAwd/vXX6tImwrFILmQ?=
 =?us-ascii?Q?l4B2uJzNJfN6iofZx6zOfJKSO3+AGB7fobCrPvjCNoEB7luYNuQaGw/Q3m4s?=
 =?us-ascii?Q?s7RGoda1xnNLZLup299JkGR7pQPRhyyKLxtlpEyII+ljNGUCEo2DQuQqbvSR?=
 =?us-ascii?Q?TSHW2j6Ml2d5VpDiFkTZwGC++dCpcPkCxkYIWIqQjgWlh3kAJ7nVlCIqTBjF?=
 =?us-ascii?Q?ncXLtnjMS6ZZVQuR48paLEM0E9nt0vkO+02Y9F17F+SSF9IcXCzpLhMWr56C?=
 =?us-ascii?Q?aEh0JNmuC6vWBqLXTw6MCA7hQhRhzhxO7/0Kb13U6idDp0ldBiMyBSlfLa6R?=
 =?us-ascii?Q?mElN6BoSbymSpzkoZHVqK49RD56eAjAcmSKQSyDOrWwGLEXBjNKqGs9sImNo?=
 =?us-ascii?Q?lSxmM6u1E3ltQRQFNblj4fPw58RhoA7LYBYGbJ6d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810d07e2-a42f-44ff-8099-08ddbe49fdb8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 18:05:15.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2okuhtW/z0swf//hnNQSiffdy1eTqXFzWQywHhL4GmbXbt+dEwZJS3Grupxq67L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947

On 8 Jul 2025, at 13:51, syzbot wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16ff728c580=
000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df6cfc972451=
00778
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3a24467a54701=
94c4175
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6=
049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D132adf705=
80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11ff728c580=
000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/d900f083ada3/non_bootable_disk-d7b8f8e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/88e0e9607487/vmli=
nux-d7b8f8e2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c0e31868d902=
/bzImage-d7b8f8e2.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/02a26963=
f634/mount_0.gz
>   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=3D15=
0e5582580000)
>
> IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> Reported-by: syzbot+3a24467a5470194c4175@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> gfs2_meta_aops does not implement migrate_folio

This warning is intended to make fs (e.g., gfs2) implement migrate_folio(=
)
in their aops. gfs2_meta_aops and gfs2_rgrp_aops need the change.

Should we change syzbot subsystem to fs?

> WARNING: CPU: 0 PID: 30 at mm/migrate.c:944 fallback_migrate_folio mm/m=
igrate.c:942 [inline]
> WARNING: CPU: 0 PID: 30 at mm/migrate.c:944 move_to_new_folio+0x696/0x7=
a0 mm/migrate.c:996
> Modules linked in:
> CPU: 0 UID: 0 PID: 30 Comm: kcompactd1 Not tainted 6.16.0-rc5-syzkaller=
 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:fallback_migrate_folio mm/migrate.c:942 [inline]
> RIP: 0010:move_to_new_folio+0x696/0x7a0 mm/migrate.c:996
> Code: 0d 01 90 42 80 7c 3d 00 00 74 0a 48 8b 7c 24 20 e8 3f 53 fe ff 48=
 8b 44 24 20 48 8b 30 48 c7 c7 80 b4 97 8b e8 bb b0 5e ff 90 <0f> 0b 90 9=
0 49 bf 00 00 00 00 00 fc ff df e9 7e fd ff ff e8 62 d0
> RSP: 0018:ffffc900005171d0 EFLAGS: 00010246
> RAX: 07a7b0ed2cfb0500 RBX: ffffea0000fecc00 RCX: ffff888030f20000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: 1ffff1100a4b8921 R08: ffff88801fc24293 R09: 1ffff11003f84852
> R10: dffffc0000000000 R11: ffffed1003f84853 R12: ffffea00012c1a80
> R13: ffff8880525c47e8 R14: ffffea0000fecc08 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff88808d21d000(0000) knlGS:00000000000=
00000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c0000cc000 CR3: 000000003fab7000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  migrate_folio_move mm/migrate.c:1301 [inline]
>  migrate_folios_move mm/migrate.c:1653 [inline]
>  migrate_pages_batch+0x1c34/0x2830 mm/migrate.c:1900
>  migrate_pages_sync mm/migrate.c:1930 [inline]
>  migrate_pages+0x1bcc/0x2930 mm/migrate.c:2039
>  compact_zone+0x23f4/0x4ad0 mm/compaction.c:2683
>  kcompactd_do_work mm/compaction.c:3134 [inline]
>  kcompactd+0x97d/0x1290 mm/compaction.c:3228
>  kthread+0x70e/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing=
=2E
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


Best Regards,
Yan, Zi

