Return-Path: <linux-kernel+bounces-843681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6144BBFFCE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76BEB4ED43B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580BC1F1505;
	Tue,  7 Oct 2025 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJt/MF/Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22813B5A9;
	Tue,  7 Oct 2025 01:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759801908; cv=none; b=WwlM0zPU33uK7V+bGsMEmr6o92TM06TjtHjlCYJM3XrM+aS4ZlxiMzzl6xm22OkcDqqAyMDpRHdYBW/ebYDCSBz+zxXid1l51M0LxgH2Aw1rARyrCcdjPl9D4fRGDJPH3k8009otQe0eQA3FN6yBbPJW7oMheR5gHDtHiAG78wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759801908; c=relaxed/simple;
	bh=ZhzrSS76cP/Bt6KAG66f5XN/rsJ2jfCJqOJq/nxXLeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4pvvpXH/ILHRXWanImms4W2V3EVc6tiwV0I1wguaos10MYXBWz5Tk6UJM3w3TSEcceCZ1vfLgq+d67MQK0glL7OLiPcuvPJ92pHINkU23gH1J74KqdSM9SZT50UjI41UIT6fDFg28JoiQ/rg8gJ3o778GOa4tR48PP9gTRk+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJt/MF/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A0BC4CEF5;
	Tue,  7 Oct 2025 01:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759801908;
	bh=ZhzrSS76cP/Bt6KAG66f5XN/rsJ2jfCJqOJq/nxXLeM=;
	h=From:To:Cc:Subject:Date:From;
	b=bJt/MF/QaFZkahrhFa23i1R1YO/Nhx7zZEnz3dtu+W2effq1k2ICQolYisHwTbEnL
	 xrdHcen6uhZE3qPAWSXseHpoXKSvMMIpGXjBOgUavnPMF9AZMogkbqgAhIX9Z573oH
	 H8wmo/JbvUcZa785nbLiP9ggPyVinqVNf65qvWRGNjz0GRAEghCRclwPYkXv1TKQ/L
	 uGnrr5FjcKx2RH65SNuIBnhbKIr4qtAg1y0+UY/2Eh5q3IKa+n8/ry4J3s9MtjjjTv
	 IxuyKD8f54KJ5dYFWJ7967bWo1xzgLDvWmhStx0vxxHghHIXsDAfvwVP3Us8+EGh1+
	 YudQQLX3MgK5w==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCHSET sched_ext/for-6.19] sched_ext: Misc changes with some prep patches for sub-sched support
Date: Mon,  6 Oct 2025 15:51:43 -1000
Message-ID: <20251007015147.2496026-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patchset contains misc changes and some prep patches for future
sub-scheduler support.

0001-tools-sched_ext-Strip-compatibility-macros-for-cgrou.patch
0002-sched_ext-Add-scx_bpf_task_set_slice-and-scx_bpf_tas.patch
0003-sched_ext-Wrap-kfunc-args-in-struct-to-prepare-for-a.patch
0004-sched_ext-Make-scx_bpf_dsq_insert-return-bool.patch

The patches are based on sched_ext/for-6.19 (7e926e30bfec) +
"sched_ext: Mark scx_bpf_dsq_move_set_[slice|vtime]() with KF_RCU"
(http://lkml.kernel.org/r/aORuaIXJftQDMBIA@slm.duckdns.org).

The following git tree also contains the patchset:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-sched-misc-prep2

 kernel/sched/ext.c                       | 147 ++++++++++++++++++-----
 kernel/sched/ext_idle.c                  |  43 ++++++-
 tools/sched_ext/include/scx/common.bpf.h |   9 +-
 tools/sched_ext/include/scx/compat.bpf.h | 199 +++++++++++++++----------------
 tools/sched_ext/scx_flatcg.bpf.c         |  10 +-
 tools/sched_ext/scx_qmap.bpf.c           |  14 +--
 6 files changed, 265 insertions(+), 157 deletions(-)

--
tejun

