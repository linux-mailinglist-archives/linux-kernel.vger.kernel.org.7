Return-Path: <linux-kernel+bounces-718426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9599AFA10D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jul 2025 19:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FBE1BC74C1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jul 2025 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6EB212FB6;
	Sat,  5 Jul 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyvFut/d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472E1A9B24;
	Sat,  5 Jul 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751737803; cv=none; b=Uchw+s/PSbGE4piSLnlinPZ7UsU+TcaQxaQX6EKb3CGKoTmkZ1omFOAwbb+dJJJH0nJxnaO31v3igOXtYE59s53mxoNqtOb8MwOnj4ivnkzwdXtzNmiOJwFF34rSGOeiTBICBc/u5PxLiTb2YCtwrbqr7OGqbunKTJxjkR14xts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751737803; c=relaxed/simple;
	bh=FFavEtXmOct+593n3zYGlbUqFvgbe6ItOU+9OH3bi3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OkF4gj2o6RMUheRVX8BZW7pAebHgcf/0s3NH32PkNteCKJHVhwzWt0pq1sIYsRqYrscDoOrCwLWeuDZlje5GKTR0T3ZOzkMxAqu4AhrKG2GAj3Gm7AIxIoRRsWG0oqn2kwoBS0QSQIW0yA0DykCL44riaGTKW/9fYupT7LjYit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyvFut/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA3AC4CEE7;
	Sat,  5 Jul 2025 17:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751737803;
	bh=FFavEtXmOct+593n3zYGlbUqFvgbe6ItOU+9OH3bi3k=;
	h=From:To:Cc:Subject:Date:From;
	b=AyvFut/dQHWKRRzrt8eb7Iu2xGp+HFntV6Cwzd1H0OcGZvY0t1A5HGV+5ztDjNhsR
	 9PYRVV0hvjpye810dNL3T+ooeLQwEk5fk3ToCKvio4WT0/aWoWKij6JiwGz/EwMrCi
	 Mn6v2tej+/gELwe4+MYotkGITfdjNujFHx5UN7K5fEnosBI7VY4q3w6S5IvmQxB5BS
	 bbyi5HOzIa6sUC9RJKfnsDKcjFdK10E46nm7z1mx2uue62QaCXkHJTY9YQC6z5raCX
	 K//fKkCcQ4Xm49pPVp3Ls3f6iE5wQiyVnNtXtdESnq2bf9Jf25Hb+rGUtIsdddOXH8
	 F/vKJVQKmODlA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] mm/damon: misc cleanups
Date: Sat,  5 Jul 2025 10:49:54 -0700
Message-Id: <20250705175000.56259-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yet another round of miscellaneous DAMON cleanups.

SeongJae Park (6):
  samples/damon/wsse: rename to have damon_sample_ prefix
  samples/damon/prcl: rename to have damon_sample_ prefix
  samples/damon/mtier: rename to have damon_sample_ prefix
  mm/damon/sysfs: use DAMON core API damon_is_running()
  mm/damon/sysfs: don't hold kdamond_lock in before_terminate()
  Docs/mm/damon/maintainer-profile: update for mm-new tree

 Documentation/mm/damon/maintainer-profile.rst | 35 ++++++++++---------
 include/linux/damon.h                         |  1 +
 mm/damon/core.c                               |  8 ++++-
 mm/damon/sysfs.c                              | 16 ++-------
 samples/damon/mtier.c                         |  5 +++
 samples/damon/prcl.c                          |  5 +++
 samples/damon/wsse.c                          |  5 +++
 7 files changed, 44 insertions(+), 31 deletions(-)


base-commit: 486593f91f44f469c920e73a4ef451d9bbbf400e
-- 
2.39.5

