Return-Path: <linux-kernel+bounces-842903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF3BBBDEEE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76DC44E1654
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A65275AFA;
	Mon,  6 Oct 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="uGBW4ypu"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801D275845
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751781; cv=none; b=iqAjtYvdBSndD6dj4ny4d4zyrTbv5ayDwewdWpaIFt5DSdVcgn/8gWMvidPz4Lq8W3hOb53ron51oKdLJ8NSC/MX1qA4nD8stznwnQAe6L4gzD6o1hqLUlPXuCIEvI8wWivBpy1Zprgedg9eZ3H5JfuBqWEbj1kzVrit0lt+3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751781; c=relaxed/simple;
	bh=wrbHTVgjTq2O8XParlMCWpyu37Ui/UVjk417+ozSffY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R7SCDYLMcCRSglfaHNla0Qm2/GNjHnsIdWPEmHmd3QiHZRXC9dGi9NCK4UQh1iywaQy/ly9IS8aDyB69VYXAXIFEWZtwLz/ijql2k9ijJMRiPAvSSWN0+AwoXLIV1wBpjIkE0OL8axLhepbTunN5IUUairyxB8L3XL2rRj69/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=uGBW4ypu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so4297222f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1759751778; x=1760356578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nbV5f3XstJLy0t8dFU+ULrkXIa5z+4WHcRiH+hJ6r0=;
        b=uGBW4ypu9qZztNYMii3UQuwE6a8QChNiNYr86UHjoMvm9hoC0pgON4tfxCntCnF4PF
         HV7gVw6Up3Nlg/4L0svu3+ze8WuDMrNaeXq57U43WEQ22fwYs891nXmSHDulDo42mL2P
         umOGqqolU17vBjRjUAv0qdh9toWXT1zEndmpqgJvq9PJEiq6MrCLLadxa1ZVCkj5WLB2
         S62MLKel7VtDYwaCpT36f63D1pOSM+eow4ov0ZMjIBvPJxwX5H+04LH7/2Gd2ieUzmGD
         5RUSKsSuM/61y3hzqAR8wfOvjh+s8opK80s1OtD73Kg8Fp+DYSuxTVviOvHlQnSJUOlr
         8HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759751778; x=1760356578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nbV5f3XstJLy0t8dFU+ULrkXIa5z+4WHcRiH+hJ6r0=;
        b=sBLgZRBxYpDJto2gy+z3U1LO9krAfxj1od50l0kCNi8gvLQHZrK2kTzVna3aCzSA6r
         fbBLF2Ao1puGAmxfekXbyKih4FfvePrQCx73+22xc8sSlnbPoVoqYbR1+Xwnn1Ax0Qhc
         YGadI+Tul5FmxqKKGyUd7yB3MFm8NBYC5E2uqRRHyYj8oFEB28r+AB5ipMNOsk3QLDR/
         Yi7HCXPYgitIVznncNzW/lCZLxXig5eQE8lW6MEkE4rbLMy0kGDxESe3xDx7OngWgKqa
         GbY/NU9nn4fEl+4V6C6WLmQHN2mm8XEBqMEcoAltQuYlE3NaOfDCspcldID7gMydry6H
         VLFw==
X-Forwarded-Encrypted: i=1; AJvYcCVXaCSA2chQwezBc1BFoYJ++7Mzjgdu6JakU+iEFEdhgItOfZZB5wVJgc4fHcppK+Ig5ydSzwg9h0kMuOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGIpiSgLCTA9qqYhWtEOwnWgYBmgYwUf6ekgyYX7cgBaylcUk
	hcQI+Nbfip8KpjfuejGfvQ71E1ybVlm6YofTDbwI7Q3XoRtCOx/irruJfb9go7RprQU=
X-Gm-Gg: ASbGncuJ0HCPIIL5lpqn2OKiWLkx7aDbDGJdl3/hSUfIBwa0/0gKh9DiC/LQBEzM+d3
	QmS/YXozwnkV1gZBpTSynRM9/S0URpjuhwrhmjm1IXO6rJ8OR8D+vOFlu3q/h+LM+53INWLbreM
	j6P3AzTWMmdzVFPCHjepRctFtSc6xaKmmiLxsKz4iDBKXKg8rcF6XV31dBBEdk+bDsCcM7pnz/e
	m6Q4+QhOMtJ/JO7s7D+fV0MLbIqA2azDorLtB0b7DqAM4ZFqBovqHS/KSAswKo9daP8iS1HbR8C
	89uu62NQDBz8pvIDmjsaTjg18ucmZbn46wN9MzRgwyaKqPG9qwkb0Iq4Qlv3X2Lv+65zAz4z6Kz
	ujeqn7RD1ZY2Ekyy/c+YX/igpToThpy+OA9Jwr/P23l02oCVOcVpEvQAInQ==
X-Google-Smtp-Source: AGHT+IHcu55JZb+QMGkTtdqsOpdfQTS9H0v4wFjgnm088OjhN8myHoA2yHtMbs7aZj1YDYIl3fN4uQ==
X-Received: by 2002:a05:6000:604:b0:424:211a:4141 with SMTP id ffacd0b85a97d-42567165eabmr8187487f8f.27.1759751777806;
        Mon, 06 Oct 2025 04:56:17 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::2e0:b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72343260sm154020345e9.4.2025.10.06.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 04:56:17 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: ext4 writeback performance issue in 6.12
Date: Mon,  6 Oct 2025 12:56:15 +0100
Message-Id: <20251006115615.2289526-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We're seeing writeback take a long time and triggering blocked task
warnings on some of our database nodes, e.g.

  INFO: task kworker/34:2:243325 blocked for more than 225 seconds.
        Tainted: G           O       6.12.41-cloudflare-2025.8.2 #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/34:2    state:D stack:0     pid:243325 tgid:243325 ppid:2      task_flags:0x4208060 flags:0x00004000
  Workqueue: cgroup_destroy css_free_rwork_fn
  Call Trace:
   <TASK>
   __schedule+0x4fb/0xbf0
   schedule+0x27/0xf0
   wb_wait_for_completion+0x5d/0x90
   ? __pfx_autoremove_wake_function+0x10/0x10
   mem_cgroup_css_free+0x19/0xb0
   css_free_rwork_fn+0x4e/0x430
   process_one_work+0x17e/0x330
   worker_thread+0x2ce/0x3f0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xd2/0x100
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x34/0x50
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

A large chunk of system time (4.43%) is being spent in the following
code path:

   ext4_get_group_info+9
   ext4_mb_good_group+41
   ext4_mb_find_good_group_avg_frag_lists+136
   ext4_mb_regular_allocator+2748
   ext4_mb_new_blocks+2373
   ext4_ext_map_blocks+2149
   ext4_map_blocks+294
   ext4_do_writepages+2031
   ext4_writepages+173
   do_writepages+229
   __writeback_single_inode+65
   writeback_sb_inodes+544
   __writeback_inodes_wb+76
   wb_writeback+413
   wb_workfn+196
   process_one_work+382
   worker_thread+718
   kthread+210
   ret_from_fork+52
   ret_from_fork_asm+26

That's the path through the CR_GOAL_LEN_FAST allocator.

The primary reason for all these cycles looks to be that we're spending
a lot of time in ext4_mb_find_good_group_avg_frag_lists(). The fragment
lists seem quite big and the function fails to find a suitable group
pretty much every time it's called either because the frag list is empty
(orders 10-13) or the average size is < 1280 (order 9). I'm assuming it
falls back to a linear scan at that point.

  https://gist.github.com/mfleming/5b16ee4cf598e361faf54f795a98c0a8

$ sudo cat /proc/fs/ext4/md127/mb_structs_summary
optimize_scan: 1
max_free_order_lists:
	list_order_0_groups: 0
	list_order_1_groups: 1
	list_order_2_groups: 6
	list_order_3_groups: 42
	list_order_4_groups: 513
	list_order_5_groups: 62
	list_order_6_groups: 434
	list_order_7_groups: 2602
	list_order_8_groups: 10951
	list_order_9_groups: 44883
	list_order_10_groups: 152357
	list_order_11_groups: 24899
	list_order_12_groups: 30461
	list_order_13_groups: 18756
avg_fragment_size_lists:
	list_order_0_groups: 108
	list_order_1_groups: 411
	list_order_2_groups: 1640
	list_order_3_groups: 5809
	list_order_4_groups: 14909
	list_order_5_groups: 31345
	list_order_6_groups: 54132
	list_order_7_groups: 90294
	list_order_8_groups: 77322
	list_order_9_groups: 10096
	list_order_10_groups: 0
	list_order_11_groups: 0
	list_order_12_groups: 0
	list_order_13_groups: 0

These machines are striped and are using noatime:

$ grep ext4 /proc/mounts
/dev/md127 /state ext4 rw,noatime,stripe=1280 0 0

Is there some tunable or configuration option that I'm missing that
could help here to avoid wasting time in
ext4_mb_find_good_group_avg_frag_lists() when it's most likely going to
fail an order 9 allocation anyway?

I'm happy to provide any more details that might help.

Thanks,
Matt

