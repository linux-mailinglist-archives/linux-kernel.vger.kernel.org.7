Return-Path: <linux-kernel+bounces-746529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2078B127B4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD9E3B04A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6941C261596;
	Fri, 25 Jul 2025 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZhpVy2g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCA23D2B6;
	Fri, 25 Jul 2025 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487782; cv=none; b=HinMj4N7bKG8DP5EhdSAnb6+2NbO0QSKYSzQddUoC8jFFv2wDbqGNSHB5V3Qu1S8cRJu800jlWxKQkE4b0Fz5gk7sAqr/LMRFKYAPmnwY/SblHYMHSmuwcdMVy8mMjA/uLtY5YgKq7Lx/ajvrGbZcDW+VIzXZBK+e3UuuwuyQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487782; c=relaxed/simple;
	bh=DP9W+L+Fgqoe4KHb1QecD3NMuIFB678cOaB0/7nD/6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G8a1ISmuHnDM+QuaBfmuvebFMPzUzG8vwLYU6zq0I7cVVRs5g+roRkzOf50dn6ADliWuQ0XB1ejnsR5UCSXLLRv2iIQy7gqSDyr0nMNcn5cXtX1zjRbPY/BepF1f4hDGGNgXNvSyd5S1kpw5g0pezTK0rOVu7yfdmKc3wzFuflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZhpVy2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E734C4CEE7;
	Fri, 25 Jul 2025 23:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753487782;
	bh=DP9W+L+Fgqoe4KHb1QecD3NMuIFB678cOaB0/7nD/6s=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=EZhpVy2gqHufCKRR67LgoGSvf5whKmtsGv/WPFp6Io6iZ6kIxz7/X91YNMfW6TR7d
	 yj6O455nNPBpok63mgtY9MmZdyjATO8Cugs6oVEO7n60d5FsSqpZBxBsvNbCZbnTz1
	 o0g74KQcx5i68PC0hIYeYglCfg+dqtE6RDbpvXpF5p/nQCnG0/7r1xLChEyZD6ZFuz
	 Hc3B1r5Io8PelhdsFr37i+GghlnfXb8UACeTjDurRD7Rs4cdGrB7lCM0l6p62p/c5M
	 P/U2rUQR3RNXlq7QnGizZqhBIvb6ejMeJpu3AEvxXLvjJQ8NCLCpu1XZXfnzmSSSDj
	 yfakei+cR17vA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 40DEBCE0E5A; Fri, 25 Jul 2025 16:56:22 -0700 (PDT)
Date: Fri, 25 Jul 2025 16:56:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	kernel-team@meta.com, haakon.bugge@oracle.com
Subject: [GIT PULL] LKMM changes for v6.17
Message-ID: <788e1aaa-73f5-4e04-a7f4-bab4f1075c46@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello, Linus,

When the v6.16 merge window opens, please pull this LKMM update from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2025.07.23a
  # HEAD: 88172700423c27c0123fdb05b8c4a62444cfcba2: docs/memory-barriers.txt: Add wait_event_cmd() and wait_event_exclusive_cmd() (2025-07-09 10:08:14 -0700)

----------------------------------------------------------------
lkmm: Update documentation

Changes
-------

* Add wait_event_cmd() and wait_event_exclusive_cmd() to the list of
  wait primitives that provide the needed memory barriers (Håkon Bugge).

----------------------------------------------------------------
Håkon Bugge (1):
      docs/memory-barriers.txt: Add wait_event_cmd() and wait_event_exclusive_cmd()

 Documentation/memory-barriers.txt | 2 ++
 1 file changed, 2 insertions(+)

