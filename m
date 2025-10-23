Return-Path: <linux-kernel+bounces-866543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC52C000D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76603A2C70
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BF32F6583;
	Thu, 23 Oct 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="i9mBzOfn"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC630146B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209949; cv=none; b=SIs40vtkHLghfN7+NjgemSdMMAwerrwFufTfzUk1nMvtg0grpIXnrbGs26bUUHVt144jqv+gZ9IlbH1Zm8sh/57exXK4eXJ8fqPZgCX56ydm15pzDE3UcA55k8/PVF7ZzYM70rJ8LnI+zl3BC4zPVvBvh2rVFa9LBOJC7f/Ytp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209949; c=relaxed/simple;
	bh=51wPnB22lXPwIwQ4y7aPB1tYrwRaAdmWMQg1fyuLa5E=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=YEmoUKfbEMIUBwj57ijnm1bI0DXUYJMdgln6ia76NjTaVKcClS5Rd+BG16u9g0/8keBSiYPZLsM72UGLf47Pbq16WvA+uYHiFGLFJE4zlhA6GHzUJ5beU5jo5/DKE726yX/AmZWjZO08kAkTEa1X8aX/n4iQFCAx5aAQWfyfdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=i9mBzOfn; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WdLCwMfglx2dxXIMaVQpbo0Sd8kcw8OyPwQ2cch7rP8=;
  b=i9mBzOfnbmcQH2CLbM+o+8kEbRzFKagoWLCZgO6dZfgw9U7ysTo0oL7q
   iF0oUIQHer+9lj2655cy+nPNfqxbS72VhDfXtPzQ+OALi1KhJEzNUMHKk
   ud3CuZm5l8R/IERu7q/RsaPZYX2hx6UqjL+PihWRED0q/aL8YGJj3V9EP
   Q=;
X-CSE-ConnectionGUID: VO+lkm7PTwubYxkqNVE1eQ==
X-CSE-MsgGUID: qnUrElcZRAS4dBDknhml4A==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,249,1754949600"; 
   d="scan'208";a="128944836"
Received: from unknown (HELO hadrien) ([202.51.247.22])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:58:59 +0200
Date: Thu, 23 Oct 2025 16:58:56 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Linux Memory Management List <linux-mm@kvack.org>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
    linux-kernel@vger.kernel.org
Subject: fs/proc/base.c:3279:4-39: opportunity for str_yes_no(mm_flags_test
 ( MMF_VM_MERGE_ANY , mm )) (fwd)
Message-ID: <a6e8f771-3934-61fa-ee3c-585dc6531da@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Thu, 23 Oct 2025 15:29:09 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: fs/proc/base.c:3279:4-39: opportunity for str_yes_no(mm_flags_test (
    MMF_VM_MERGE_ANY , mm ))

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux Memory Management List <linux-mm@kvack.org>
CC: "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi Lorenzo,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c
commit: d14d3f535e13ff0661b9a74133a8d6b9f9950712 mm: convert remaining users to mm_flags_*() accessors
date:   6 weeks ago
:::::: branch date: 6 hours ago
:::::: commit date: 6 weeks ago
config: m68k-randconfig-r063-20251023 (https://download.01.org/0day-ci/archive/20251023/202510231541.uVpbrSce-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202510231541.uVpbrSce-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
   fs/proc/base.c:3286:4-29: opportunity for str_yes_no(ksm_process_mergeable ( mm ))
>> fs/proc/base.c:3279:4-39: opportunity for str_yes_no(mm_flags_test ( MMF_VM_MERGE_ANY , mm ))

vim +3279 fs/proc/base.c

7c23b3300116907 Josh Poimboeuf  2017-02-13  3251
7609385337a4feb xu xin          2022-04-28  3252  #ifdef CONFIG_KSM
7609385337a4feb xu xin          2022-04-28  3253  static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *ns,
7609385337a4feb xu xin          2022-04-28  3254  				struct pid *pid, struct task_struct *task)
7609385337a4feb xu xin          2022-04-28  3255  {
7609385337a4feb xu xin          2022-04-28  3256  	struct mm_struct *mm;
7609385337a4feb xu xin          2022-04-28  3257
7609385337a4feb xu xin          2022-04-28  3258  	mm = get_task_mm(task);
7609385337a4feb xu xin          2022-04-28  3259  	if (mm) {
7609385337a4feb xu xin          2022-04-28  3260  		seq_printf(m, "%lu\n", mm->ksm_merging_pages);
7609385337a4feb xu xin          2022-04-28  3261  		mmput(mm);
7609385337a4feb xu xin          2022-04-28  3262  	}
7609385337a4feb xu xin          2022-04-28  3263
7609385337a4feb xu xin          2022-04-28  3264  	return 0;
7609385337a4feb xu xin          2022-04-28  3265  }
cb4df4cae4f2bd8 xu xin          2022-08-30  3266  static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
cb4df4cae4f2bd8 xu xin          2022-08-30  3267  				struct pid *pid, struct task_struct *task)
cb4df4cae4f2bd8 xu xin          2022-08-30  3268  {
cb4df4cae4f2bd8 xu xin          2022-08-30  3269  	struct mm_struct *mm;
3ab76c767bc783c xu xin          2025-01-10  3270  	int ret = 0;
cb4df4cae4f2bd8 xu xin          2022-08-30  3271
cb4df4cae4f2bd8 xu xin          2022-08-30  3272  	mm = get_task_mm(task);
cb4df4cae4f2bd8 xu xin          2022-08-30  3273  	if (mm) {
cb4df4cae4f2bd8 xu xin          2022-08-30  3274  		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
c2dc78b86e0821e Chengming Zhou  2024-05-28  3275  		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
d21077fbc2fc987 Stefan Roesch   2023-04-17  3276  		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
d21077fbc2fc987 Stefan Roesch   2023-04-17  3277  		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
3ab76c767bc783c xu xin          2025-01-10  3278  		seq_printf(m, "ksm_merge_any: %s\n",
d14d3f535e13ff0 Lorenzo Stoakes 2025-08-12 @3279  				mm_flags_test(MMF_VM_MERGE_ANY, mm) ? "yes" : "no");
3ab76c767bc783c xu xin          2025-01-10  3280  		ret = mmap_read_lock_killable(mm);
3ab76c767bc783c xu xin          2025-01-10  3281  		if (ret) {
3ab76c767bc783c xu xin          2025-01-10  3282  			mmput(mm);
3ab76c767bc783c xu xin          2025-01-10  3283  			return ret;
3ab76c767bc783c xu xin          2025-01-10  3284  		}
3ab76c767bc783c xu xin          2025-01-10  3285  		seq_printf(m, "ksm_mergeable: %s\n",
3ab76c767bc783c xu xin          2025-01-10  3286  				ksm_process_mergeable(mm) ? "yes" : "no");
3ab76c767bc783c xu xin          2025-01-10  3287  		mmap_read_unlock(mm);
cb4df4cae4f2bd8 xu xin          2022-08-30  3288  		mmput(mm);
cb4df4cae4f2bd8 xu xin          2022-08-30  3289  	}
cb4df4cae4f2bd8 xu xin          2022-08-30  3290
cb4df4cae4f2bd8 xu xin          2022-08-30  3291  	return 0;
cb4df4cae4f2bd8 xu xin          2022-08-30  3292  }
7609385337a4feb xu xin          2022-04-28  3293  #endif /* CONFIG_KSM */
7609385337a4feb xu xin          2022-04-28  3294

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

