Return-Path: <linux-kernel+bounces-775576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E91B2C0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F631B662A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227731E10A;
	Tue, 19 Aug 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkRj5Bs8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B227876E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603657; cv=none; b=o9ZT3dCcpg3j/hpkJdm1/aqISlneY+uEor5jn0KKnbmvb0/WBvZc3MSsWzZw6M8dxCdqlK76x2E8XBtOtZyd9PbEtsg4Oniox6XeNJMprhbBi8pIG3M5a6NSqD+tltRPEsDPxJoSL9S8Uv241xI4zqs8sXskFyBw0AnGVdufJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603657; c=relaxed/simple;
	bh=R2IbdOxI5MltuQPgMxr0dsRiqGmQK+hEwie/vWg7Bpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ie9lxgnpwhhcmc4FNcO0gfhHQSr4Q3LhotybxPJfnMHs9CbVsz9HYEpV0MZoeZdjPm4R5vR6oYTmBMN6AMkAXFocyGVHUSagyNZnAIrD850xscmUixBwN5xH5NN0u0+gA8FYto1ZATKyq4wO5E0dcV2BYacNbmk1gUVvikeKA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkRj5Bs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0023BC4CEF1;
	Tue, 19 Aug 2025 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755603657;
	bh=R2IbdOxI5MltuQPgMxr0dsRiqGmQK+hEwie/vWg7Bpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LkRj5Bs8KJonDklbxiuW4QN/QMiDStoazKXclLs6W0CLeS/1tBRQPBPtFica4lnuf
	 aXlDErHDfVP44P+vB9Lntzhh0+B39sInoefPs35DKPjF/MvmLv7AOCQrzqg70v5dRN
	 snSu7Biw21Gf43pNa3iil+HfJAcLZX/FKrUnExWpSj2M2l8SIKXFUGTGDquN+S67Em
	 AdRfahbm2KTMqOaSy5Y6cjNyvzDL6/EnbQtBJyFYK7iPkHJWmzsNjm8c9grjy3jplP
	 Pdsu/or/X4sTSitfR8OeZ3fjeaWpbvtXrusSX65X/9nxw5wWBDJWxr2gMCeVXxVGyX
	 Wh1vO09G0bKBQ==
From: Christian Brauner <brauner@kernel.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	joel.granados@kernel.org,
	lorenzo.stoakes@oracle.com,
	linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>,
	oleg@redhat.com,
	mjguzik@gmail.com,
	Liam.Howlett@Oracle.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Date: Tue, 19 Aug 2025 13:40:49 +0200
Message-ID: <20250819-anbeginn-hinsehen-5cf59e5096d4@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250802022123.3536934-1-gxxa03070307@gmail.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=brauner@kernel.org; h=from:subject:message-id; bh=R2IbdOxI5MltuQPgMxr0dsRiqGmQK+hEwie/vWg7Bpk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsSTp8Jo5lR2C89qnGqzn73FefVbu2Kr87VFJt9wv/o slvysz1OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyxI3hn/XGx2dCdaduunFK bpnxvm0Mui98dOyzMr8tW/wxs0rzJTsjw6f9mbwtkxM6pgcG1PjkxOd9mWLbsqVIfWr8mS2vArN K2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 02 Aug 2025 10:21:23 +0800, Xiang Gao wrote:
> __task_pid_nr_ns
>         ns = task_active_pid_ns(current);
>         pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
>                 if (pid && ns->level <= pid->level) {
> 
> Sometimes null is returned for task_active_pid_ns. Then it will trigger kernel panic in pid_nr_ns.
> 
> [...]

Applied to the vfs-6.18.pidfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.pidfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.pidfs

[1/1] pid: Add a judgment for ns null in pid_nr_ns
      https://git.kernel.org/vfs/vfs/c/006568ab4c5c
[1/4] pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers
      https://git.kernel.org/vfs/vfs/c/abdfd4948e45
[3/4] pid: change bacct_add_tsk() to use task_ppid_nr_ns()
      https://git.kernel.org/vfs/vfs/c/b1afcaddd6c8
[4/4] pid: change task_state() to use task_ppid_nr_ns()
      https://git.kernel.org/vfs/vfs/c/d00f5232851c

