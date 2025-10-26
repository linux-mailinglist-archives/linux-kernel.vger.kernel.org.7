Return-Path: <linux-kernel+bounces-870167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF0CC0A168
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 02:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2BC134B74C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 01:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BCA2264B0;
	Sun, 26 Oct 2025 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWe5OMOe"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E02772D
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761440724; cv=none; b=nPDO3dpopKUBgptMNJQhcFWmG89V3/q4aHvjh9z/dVTx87fk9weG4SZuVODTsko3cu1WGe5s+IIKi5iiXmTiSuecRYQvvQfO3f5QdkZn/36fskDDU0IIXQmXeVbM676iD3M9vaal05X3oARTwKdeTYYjA1NXjK9jxwcPUHJhNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761440724; c=relaxed/simple;
	bh=KLqV75PcvEyUm05RQodatiEG/ugFMUNCSjZ4Fbo2bkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGW1N2Za1Wq108oEOdGmejfbb8pcH0J7lrtIzUkG0+9r5Zh37WsympXSdS38YRAc4h9LRe9iXy6Ex/rR1KWr+ryVYQLe5V3x+yLZ3XooC4iQ3aZcpRsJaZ+0iqhwgcyeqvw1t0hiBJVMn2EkMSqR2CfVm6beBSREYmeEEOII+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWe5OMOe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso3728835b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761440722; x=1762045522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yS34+uhylNdFYNWrvgsPGh1bBy7nTRn8Y42YGAOkzr0=;
        b=MWe5OMOe824Tdw6FcQvWhgeBq0xyEAepk3Q4yOtpcfeHIoNGUzCF1uEh0/FD2ZPudz
         u6luLV2YhOzvd7Sks8zL2aHXJLykn8klOFH5TnXf724gSlLB+QGkJyyTHGLNRpTyBGCX
         L0Qscld6K5t3wYu22El5xRsirPCb0fTf6myS8yr4uqJIyefWFddKxeI2D6BjKamAC0t5
         bOe2yyUqRlX80THK0F6r7+TzO2k/PoKx9rHMkJ7WKPM9oBTVPBb4sgL/Vk3zsE2gdeb5
         CnWqvXnpDN9nWif+3aiBSUy3sZsQBLclDn9w9z+Eweq6mVo3D3iVkUA/++dcreZKwJVV
         VT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761440722; x=1762045522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yS34+uhylNdFYNWrvgsPGh1bBy7nTRn8Y42YGAOkzr0=;
        b=lgc9LeUGTer1G0ueUj93GhMFMQXYewXidaDcp9djlon+HZnnxkwzz5TigOX3CWratV
         /I24So0hLW/SO5Nyn8yns0Z5gFmusKjagNcGRFqR1gDRl3NghTf6O5XoTRfdAp1aNtWB
         9JWZzmHZ0jLln4T2tGGN152Yeq2SbFI5JJFQ3VHDfs6zzNKl2pMhqp3JFStob/gT2Hgj
         O7I/2re+pBX2CG22JLXTbr0GcIbbXHH+B2SjdjS5FUJm9fOQ6ke+11MSQc5REwFYTB9X
         nq5oecpyDy5TO/b+bpvQ5XUzxfghdx6dJZoRpNkmgmQjH9D9HTn0UhoS4YvA7jlEfS/H
         /MOA==
X-Forwarded-Encrypted: i=1; AJvYcCXKPllquCet5FUH3QHZ0hrcBe4S9BWAST/XLE9P63fqLZQzk3C/9kl6+9MIN9miBJpm6ffJWFT9cgfd2iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1kIHmcs2wapNTbwZTW4Lyn+3F0P87LiBUDrtBrn1e63POOEn
	RUGG1KVpBYclJQLy4mZ+cXHZMmhIRZboJrrreHim5/7A1cowH9aRmRDn
X-Gm-Gg: ASbGncvjh2jgD1Q41X0z64J2a/2NepKIz7tQIzCASyIXrrDuhWdoO2lNANJsLwsZlpg
	avVpLSzk59KSkVOG7dKjE7vyL/mYc+jmfgcknKZNS8sq16xm/yJXllIIA4qPtLE8YSp5nFad9Um
	oWcubUb9i+uCGL9E4l6xQNLj5tcF+2UmxUN6G/GM+C9eOwbD7/CjIUe/fVdNtm7jsBePq0Kh1g9
	nsWvy40k3w2kI3Vlm1EEKTSraH/xUSXQnoMPsFsLVhKQdiIY0D3GJwh/g0fqf1dvcaFN9T0G3qm
	vuHNonh6Q6DqJrNnORGn/cb4NIlZ3OdbqS5Tk3K8EySotc3MOedvhgivtkUMhTO7U8iqTdM+aWH
	IyVAEbuP7JwmJeGv2TtnU+SMrvQL9cv2MyVso4tz98wf0TNd44vGkGvld01kwJ88xieosY2ccEz
	pLxAFeBMIjd6Rvyw==
X-Google-Smtp-Source: AGHT+IGqJ3fK980blF3S2OhDDl1kPCFC3PDx3uiV6lRR9MlLGgQ+c3xMg89feF4XpI76Z2y7cP/wYQ==
X-Received: by 2002:a05:6a00:23c2:b0:780:f758:4133 with SMTP id d2e1a72fcca58-7a274ba91d9mr12147230b3a.10.1761440722260;
        Sat, 25 Oct 2025 18:05:22 -0700 (PDT)
Received: from daniel.. ([221.218.137.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404987esm3371597b3a.36.2025.10.25.18.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 18:05:21 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	corbet@lwn.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	axboe@kernel.dk,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	terrelln@fb.com,
	dsterba@suse.com
Cc: muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	zhongjinji@honor.com,
	liulu.liu@honor.com,
	feng.han@honor.com,
	jinji zhong <jinji.z.zhong@gmail.com>
Subject: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Date: Sun, 26 Oct 2025 01:05:07 +0000
Message-ID: <cover.1761439133.git.jinji.z.zhong@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

On Android, different applications have varying tolerance for
decompression latency. Applications with higher tolerance for
decompression latency are better suited for algorithms like ZSTD,
which provides high compression ratio but slower decompression
speed. Conversely, applications with lower tolerance for
decompression latency can use algorithms like LZ4 or LZO that
offer faster decompression but lower compression ratios. For example,
lightweight applications (with few anonymous pages) or applications
without foreground UI typically have higher tolerance for decompression
latency.

Similarly, in memory allocation slow paths or under high CPU
pressure, using algorithms with faster compression speeds might
be more appropriate.

This patch introduces a per-cgroup compression priority mechanism,
where different compression priorities map to different algorithms.
This allows administrators to select appropriate compression
algorithms on a per-cgroup basis.

Currently, this patch is experimental and we would greatly
appreciate community feedback. I'm uncertain whether obtaining
compression priority via get_cgroup_comp_priority in zram is the
best approach. While this implementation is convenient, it seems
somewhat unusual. Perhaps the next step should be to pass
compression priority through page->private.

jinji zhong (3):
  mm/memcontrol: Introduce per-cgroup compression priority
  zram: Zram supports per-cgroup compression priority
  Doc: Update documentation for per-cgroup compression priority

 Documentation/admin-guide/blockdev/zram.rst | 18 +++--
 Documentation/admin-guide/cgroup-v2.rst     |  7 ++
 drivers/block/zram/zram_drv.c               | 74 ++++++++++++++++++---
 drivers/block/zram/zram_drv.h               |  2 +
 include/linux/memcontrol.h                  | 19 ++++++
 mm/memcontrol.c                             | 31 +++++++++
 6 files changed, 139 insertions(+), 12 deletions(-)

-- 
2.48.1


