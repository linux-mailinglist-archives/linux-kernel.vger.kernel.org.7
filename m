Return-Path: <linux-kernel+bounces-856750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20750BE4F60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407E35E3719
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C587E23EAA8;
	Thu, 16 Oct 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eaSWTO8C"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971512253EF
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637548; cv=none; b=djQ0V/YKhCtkhnAIVWpcWrUwMJuypFMOKuykHD+i18zOf4WjyHaJSUXBNf48gbeu9WKIMvlccyBO08Wzej2sNphSPx92wKf64SIP68CpDtefheFuIfpvgqaQmREx/TCci5xY0/itYnDmPwqvq2XYz5j3dq0O3hgcet7GvDscAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637548; c=relaxed/simple;
	bh=vZiHA8Y6AfsK9IF3c2KBtymTA2sTHdPbid5+P3xm/ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=arMSAI5EdVaQQpe2GfSXKmvrYzVHk/Yzzq9P5Kff8p0wSUX3CWxOgZfyd0dP3kmesD/avGBwkXXyD1EVaEtiSWOP0qdBnOLpq7tQixQUO2WDKTsQviREJ5qMNR8aXAlIoRTFjEtitYHzyUXCRHhpNV1pGtY+ZybP0Arw+S4eLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eaSWTO8C; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so11910555e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760637544; x=1761242344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VBbCb5Q+IqNb5arOkvExMS59Z+aWDiwCrWUaHKJ2ko=;
        b=eaSWTO8ClQkn216SzgahyyuszyhLkuApsf8WAp6tjIAmN0tz4tVom4qJB3NXATdOgB
         axiF/5N73KKWZmbs5xvdbpk0biAjbQU5A2rem9wH5YBKGRxi5VehOH2mDOSZAD1MwvXX
         r7tXKBz23BhyuOiVXhazcaGFrbvBfvHUZK3g/9FoU5AHZ5VcrrMss7XrwrzjntJOLD9v
         zUMs6jo7vwZS+NhTEqtHyibPRXgilP6llZsjgln3vdQrXJd7Mz8j0XhgeEEhc2s3Z8ad
         1Ubctegn0J03TmcxHV6T8LmJbir+06s2MJOFR441Z63jh3mycg+Pz2DFPiRPlaMF0DLB
         YIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637544; x=1761242344;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VBbCb5Q+IqNb5arOkvExMS59Z+aWDiwCrWUaHKJ2ko=;
        b=HuY9rCCiTemFKVZkY/x6gw1ll1m7qbRhSKpW5SujIBSR4ZQQdJ3nKSyFmq2zT/kKWF
         IjJn7IA9R80+pAsPmSF6qecD/m7XZOKhkq8992b+FRH9OeHa4Aw7iygHJR4DIuIl668A
         B7Tc34tEN8KVT/dRCj0LchM8L2Tx5rzyGBtETemcRCwJwd4urPfWC+81Ie81zcKpGiHp
         Jp2QW5mx7Iutx0MJvmf9fGxxLYThwIe3Di2SrTh9cuppG4yYHCc8ctD/WXafiBWy8TRF
         LAJgKK/CGUppzqIDiJHIe8ovazp2sCMINu+eMui/kNPG4aY7X3NtpcsrA64xPbJynoL+
         u7VA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9nQByci50uDxGnNAYr8OZmWFZS1RZl96CC/3DsB25SwMyt8dEK5SOt5QH2IGl3QYRRy/on/KtQSa/HU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Dz57D1zt6Kb14kzT8nC1fUfxxT1MJT6CC7vR9u9kokvfSSPF
	iYbUoU5p5FAryifnBLf2sPwIwZIcttuyXONTKtrUARzdP3NLa14hjHPRy+T1+tyviFN0ka5Z1ic
	VfXj4
X-Gm-Gg: ASbGncsWrzTbEF9OWk0oJESB3XVqkf3ixvcX8XB7Y5vkYtAgkdhZ6uAVdBtRMhTxVEl
	0FCzhzg5z323PuG6vdm51o2fXHkXzk2ESRwBsXw8eH+jdjpTK+0ag7NcJ9S/5XmUCTD3h4DB76U
	8pXa9BSUDkHjSuDukzpGZiH+gOJ/4wzRPckgKls0N4QvjZcL0FWZ7966jmMIHXyhoKmK8MNposR
	dZWyjK91TBUk08e5todNgjybthLTp0OSbGBoWvvPB8uxmH2QSDDdN85emKDzqMEU9q3VZYo3/Da
	zcBz2vDGdrliPWVzj05n1EaTD2rAJAphjtitBFmYjPBgITT7GwVMWhco6MKm1uDcAdRIMtFZyaC
	JWY6sWDrEo7ol7jUwoj36iS9jf54k/4Dfoz1DFVVKW1lfjdfaxpuzT71XszK9uwu+fQzyYZdas6
	mXYwYeaCH+VxnoVS4/wLF2YmC/nts=
X-Google-Smtp-Source: AGHT+IGNC4j+STHgH8JMZXaAiTHwQ+buEodAeaVzalRybmL2VUhCMjzU9+Zk9Y0sAYL9ikB7GrJ2sw==
X-Received: by 2002:a05:600c:4507:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-4711787276dmr7996365e9.4.1760637543660;
        Thu, 16 Oct 2025 10:59:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471144239f4sm40779015e9.2.2025.10.16.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:59:03 -0700 (PDT)
Date: Thu, 16 Oct 2025 20:58:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	kartikey406@gmail.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: Forwarded: [PATCH] ntfs3: add debug warnings for run_lock
 initialization
Message-ID: <202510170051.yMGKcZjz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ee38b5.050a0220.ac43.00fd.GAE@google.com>


Hi syzbot,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/syzbot/Forwarded-PATCH-ntfs3-add-debug-warnings-for-run_lock-initialization/20251014-195051
base:   v6.18-rc1
patch link:    https://lore.kernel.org/r/68ee38b5.050a0220.ac43.00fd.GAE%40google.com
patch subject: Forwarded: [PATCH] ntfs3: add debug warnings for run_lock initialization
config: i386-randconfig-141-20251015 (https://download.01.org/0day-ci/archive/20251017/202510170051.yMGKcZjz-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510170051.yMGKcZjz-lkp@intel.com/

smatch warnings:
fs/ntfs3/inode.c:590 ntfs_iget5() warn: variable dereferenced before IS_ERR check 'inode' (see line 590)

vim +/inode +590 fs/ntfs3/inode.c

82cae269cfa9530 Konstantin Komarov 2021-08-13  562  struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
82cae269cfa9530 Konstantin Komarov 2021-08-13  563                           const struct cpu_str *name)
82cae269cfa9530 Konstantin Komarov 2021-08-13  564  {
82cae269cfa9530 Konstantin Komarov 2021-08-13  565      struct inode *inode;
9ca11d2cd5f563e syzbot             2025-10-14  566      unsigned long ino = ino_get(ref);
82cae269cfa9530 Konstantin Komarov 2021-08-13  567      
9ca11d2cd5f563e syzbot             2025-10-14  568      if (ino == 25) {
9ca11d2cd5f563e syzbot             2025-10-14  569          printk(KERN_ERR "DEEPANSHU: ntfs_iget5 START for inode 25\n");
9ca11d2cd5f563e syzbot             2025-10-14  570          //dump_stack();
9ca11d2cd5f563e syzbot             2025-10-14  571      }
9ca11d2cd5f563e syzbot             2025-10-14  572      
9ca11d2cd5f563e syzbot             2025-10-14  573      inode = iget5_locked(sb, ino, ntfs_test_inode, ntfs_set_inode,
82cae269cfa9530 Konstantin Komarov 2021-08-13  574                           (void *)ref);
9ca11d2cd5f563e syzbot             2025-10-14  575      
82cae269cfa9530 Konstantin Komarov 2021-08-13  576      if (unlikely(!inode))
82cae269cfa9530 Konstantin Komarov 2021-08-13  577          return ERR_PTR(-ENOMEM);
82cae269cfa9530 Konstantin Komarov 2021-08-13  578      
9ca11d2cd5f563e syzbot             2025-10-14  579      if (inode->i_ino == 25) {
9ca11d2cd5f563e syzbot             2025-10-14  580          printk(KERN_ERR "DEEPANSHU: After iget5_locked for inode 25, I_NEW=%d, i_state=0x%x\n", 
9ca11d2cd5f563e syzbot             2025-10-14  581                 !!(inode->i_state & I_NEW), inode->i_state);
9ca11d2cd5f563e syzbot             2025-10-14  582          //dump_stack();
9ca11d2cd5f563e syzbot             2025-10-14  583      }
9ca11d2cd5f563e syzbot             2025-10-14  584      
82cae269cfa9530 Konstantin Komarov 2021-08-13  585      /* If this is a freshly allocated inode, need to read it now. */
9ca11d2cd5f563e syzbot             2025-10-14  586      if (inode->i_state & I_NEW) {
9ca11d2cd5f563e syzbot             2025-10-14  587          if (inode->i_ino == 25)
9ca11d2cd5f563e syzbot             2025-10-14  588              printk(KERN_ERR "DEEPANSHU: Calling ntfs_read_mft for inode 25\n");
82cae269cfa9530 Konstantin Komarov 2021-08-13  589          inode = ntfs_read_mft(inode, name, ref);
9ca11d2cd5f563e syzbot             2025-10-14 @590          if (inode->i_ino == 25 && IS_ERR(inode))
                                                                ^^^^^^^^^^^^                 ^^^^^
"inode" dereferenced before an IS_ERR() check...

9ca11d2cd5f563e syzbot             2025-10-14  591              printk(KERN_ERR "DEEPANSHU: ntfs_read_mft FAILED for inode 25\n");
9ca11d2cd5f563e syzbot             2025-10-14  592      } else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
9ca11d2cd5f563e syzbot             2025-10-14  593          if (inode->i_ino == 25)
9ca11d2cd5f563e syzbot             2025-10-14  594              printk(KERN_ERR "DEEPANSHU: inode 25 seq mismatch\n");
1fd21919de6de24 Konstantin Komarov 2024-08-22  595          iput(inode);
1fd21919de6de24 Konstantin Komarov 2024-08-22  596          inode = ERR_PTR(-ESTALE);
9ca11d2cd5f563e syzbot             2025-10-14  597      } else if (inode->i_ino == 25) {
9ca11d2cd5f563e syzbot             2025-10-14  598          printk(KERN_ERR "DEEPANSHU: inode 25 found in CACHE, skipping ntfs_read_mft!\n");
9ca11d2cd5f563e syzbot             2025-10-14  599          //dump_stack();
82cae269cfa9530 Konstantin Komarov 2021-08-13  600      }
82cae269cfa9530 Konstantin Komarov 2021-08-13  601  
1fd21919de6de24 Konstantin Komarov 2024-08-22  602      if (IS_ERR(inode))
0e8235d28f3a0e9 Konstantin Komarov 2022-10-10  603          ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
0e8235d28f3a0e9 Konstantin Komarov 2022-10-10  604  
82cae269cfa9530 Konstantin Komarov 2021-08-13  605      return inode;
82cae269cfa9530 Konstantin Komarov 2021-08-13  606  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


