Return-Path: <linux-kernel+bounces-797479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABCEB410EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059357AF631
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD322E9ED8;
	Tue,  2 Sep 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG1SPomn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1742E92D6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856902; cv=none; b=L45OahE3EhpJpnM1NP52yqvV7YkCF/K468w5okt3P3xRIP2KExXQyaWBBAGDLhUYf0UInGcTF4/lWWyhdcsjj0IFRyFBDYxD1pmIlqkQiYxs56arKKRa4VaNG2N+zDil0mfuTmALkguiiJ0Nvky4+uFa304Tlpvn5GCAe6g6Z+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856902; c=relaxed/simple;
	bh=JyMz0m/nwsrpT+wtpR/GJsBC4+zUDGRcANTc/UgZvpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwtvQgmQsYUuWSvFWgqVzRyys8HBZBZQmNTYuIkoFwgg71OMZQhkgMtftyO01Dc3A4tvE2KI0kBenGUl7qbGK2KGulay41KWcOXb9MmJj3IbxT257Jni60XuD+5HMlQNzDlFTqO7wsQnA2vfp/8Mb3iBrUYDY693ZSkDgf1Ogww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG1SPomn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11763C4CEED;
	Tue,  2 Sep 2025 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756856901;
	bh=JyMz0m/nwsrpT+wtpR/GJsBC4+zUDGRcANTc/UgZvpE=;
	h=From:To:Cc:Subject:Date:From;
	b=PG1SPomnRRjv9mgqaxXKhkRn4euRptgkaGA+3IR9PsbBeLgztNUVsdDer4b52BVLD
	 Y1GK7YWUNjxkxrXXg8YEZo2qPv14SyUwfk1uCNtLp07PdUiRq2f1tdqWeKeFlDATin
	 fQ3EkzviKLj8nztqbYT1uwCfXX9iwHs31vhOmrBGKBdS01OKCNYeKoJuYyb+WHMllK
	 4e5XiX/tYlQUjj3ofkkvJH8nl3xu4XFRwHP4heJvm0aALsATAlJeOEIxS6R+dWjSqi
	 +eCltdS9+82iSPMTEY7CdWt2+g47sxZl8JC2x5YWpBl1ollE8PEioc6HJ1/RnkZhHc
	 IuUr5by7WCB5Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@meta.com
Subject: [PATCHSET sched_ext/for-6.18] sched_ext: Misc changes
Date: Tue,  2 Sep 2025 13:48:02 -1000
Message-ID: <20250902234817.279206-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A collection of four misc patches.

- Make scx_task_iter a bit easier to use.

- Keep bypass on between enable failure and disable.

- Move types and accessors into ext_internal.h.

- Wrap event percpu allocation in a struct to ease adding more percpu
  fields.

 0001-sched_ext-Make-explicit-scx_task_iter_relock-calls-u.patch
 0002-sched_ext-Keep-bypass-on-between-enable-failure-and-.patch
 0003-sched_ext-Move-internal-type-and-accessor-definition.patch
 0004-sched_ext-Put-event_stats_cpu-in-struct-scx_sched_pc.patch

 kernel/sched/build_policy.c |    1
 kernel/sched/ext.c          | 1097 +-----------------------------------------------------------------
 kernel/sched/ext.h          |   23 -
 kernel/sched/ext_internal.h | 1064 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1098 insertions(+), 1087 deletions(-)

--
tejun


