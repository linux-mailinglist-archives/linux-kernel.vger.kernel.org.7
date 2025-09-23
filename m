Return-Path: <linux-kernel+bounces-828955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E56B95EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7498C2E6FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74B0324B0B;
	Tue, 23 Sep 2025 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3YgpIsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557630FC3D;
	Tue, 23 Sep 2025 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632663; cv=none; b=iyubNHKnCZH/esjXg7cvsT5Ol/j/K+Atu85J3FJgPKALbvGtAPPp+osqTPuok1e5hBc57cit0laQdN7yQQomksE/7pxnSvW8sCMBhNEnK3s8BReXxtFflrBV67JOTLHqsZaS6/DXGVwl6x+0oh4u9T6SVzp6r+u/L4LJVZUigQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632663; c=relaxed/simple;
	bh=yhOpYhydXFOTnVyJEJ9WLdHPFnfzH5DQIG3kHF9WFQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAl0E6Gjef2NFUtk+zbLFWN2GfeI4l/jq40ea34KT9mMBxnc4h90KkukyYuJoYqa1WX78b5ZvN2fL3a5Wfrd7jrmvrkyIdWuuM/StbFS3cRW0TkuIOcHohrOywtIr9xtbgyk8fZfXPMvYjihVODEYn5Gzuysix73CrOft+iWwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3YgpIsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCB5C4CEF5;
	Tue, 23 Sep 2025 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758632662;
	bh=yhOpYhydXFOTnVyJEJ9WLdHPFnfzH5DQIG3kHF9WFQo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=u3YgpIsSAzRs7gbGciWsT76CbHblYIJASZ1shE1TjqCcWPLyEbA15JGORKPzvEXT+
	 m02RpuKakAHjnfcH68v+foy9qD6o7ptAg8py/aNtIjMJeYSnh1rLlEaRzNorsKffqF
	 4QqXB/lsl6YgLfFSxSpI5wFSiUh6UgsZzHV/XiWgtLvOW3upkjroP9vGaNReaLLSWB
	 Qc5S3Q1Ms27ZRDR3QTqZeBl3Cx7Mcau+bAoMcL9ABVwWRmUyTiFBB3TlQYP3D7Rn2P
	 4lSQxlgGnSePiHsuZj7whbhrZ1uTfqUK0CyXomKCn8eB/Wk7u6Ojze5rlHZyh7tlOi
	 7WcLGSYIY4ORw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 00684CE0E5A; Tue, 23 Sep 2025 06:01:52 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:01:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2025.09.15a 45/45] ERROR: modpost:
 "init_srcu_struct_fast" [kernel/rcu/rcutorture.ko] undefined!
Message-ID: <0e09e4cb-058d-40fb-aa8d-9da68fb86a24@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202509201519.udl3bu3X-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509201519.udl3bu3X-lkp@intel.com>

On Sat, Sep 20, 2025 at 03:10:55PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.09.15a
> head:   f81c21ec3fca688bfcb6fa0abaf70404655765dc
> commit: f81c21ec3fca688bfcb6fa0abaf70404655765dc [45/45] rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
> config: arm-randconfig-003-20250920 (https://download.01.org/0day-ci/archive/20250920/202509201519.udl3bu3X-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509201519.udl3bu3X-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509201519.udl3bu3X-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "init_srcu_struct_fast" [kernel/rcu/rcutorture.ko] undefined!

I believe that this is fixed in current -rcu by the replacement commits
headed by the following commit:

bd3acc50cf8c ("rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()")

Please see below for the diff that should fix the commit in which
you found the failure.

And thank you for your testing efforts!!!

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index c81d5dfaf73753..26de47820c58cd 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -48,7 +48,9 @@ int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lo
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 int init_srcu_struct(struct srcu_struct *ssp);
+#ifndef CONFIG_TINY_SRCU
 int init_srcu_struct_fast(struct srcu_struct *ssp);
+#endif // #ifndef CONFIG_TINY_SRCU
 
 #define __SRCU_DEP_MAP_INIT(srcu_name)
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 4c2f2802393062..92e6ab53398fc0 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -45,9 +45,9 @@ void srcu_drive_gp(struct work_struct *wp);
  */
 #define DEFINE_SRCU(name) \
 	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
-#define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
 #define DEFINE_STATIC_SRCU(name) \
 	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
+#define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
 #define DEFINE_STATIC_SRCU_FAST(name) \
 	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
 
@@ -55,6 +55,9 @@ void srcu_drive_gp(struct work_struct *wp);
 struct srcu_usage { };
 #define __SRCU_USAGE_INIT(name) { }
 #define __init_srcu_struct_fast __init_srcu_struct
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#define init_srcu_struct_fast init_srcu_struct
+#endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
 
 void synchronize_srcu(struct srcu_struct *ssp);
 

