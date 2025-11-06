Return-Path: <linux-kernel+bounces-888859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CF7C3C15D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E95E1B225FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92692989B4;
	Thu,  6 Nov 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0bqnzHR"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1ED2BE059
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443093; cv=none; b=bUUCTlQYRAHN0hNfq2CoG/O63/wlyx2+Cn4Yt5mPYB00z3vwd7vCCdhQVaPvLckizN+SkPps7odRQvYzDm7cfVZ43NrHbWVxSKGjiG/1OUIpm9TqEugNJVrdptzLsZdzvCWPvZc6AXz99NDlbC0oThWghXi5pNCQ+dxin8Kyokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443093; c=relaxed/simple;
	bh=UE+pihzotstkYlFsNc8iO52Sgmt7WNjO/kMHQY9T6D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN4/YaoGqFbnH6oy+8v0ZSVb12gwgB5QEcbnbRyL0SQ51ohwszapwa9h3p8L/JO9Dh6O8sakjrl7CKnusS8ysWRgkoFviP39VXYnk6YsY+ADBs+m7jlzdoIOzY5aJxb6IlN8B7J5Wwi0lLGoQWNsUAvDjiL8vBv5GCRLtsikRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0bqnzHR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so1505309b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762443090; x=1763047890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/49Sfwl13xTW+WWM56Tz99oC1h/uUZN64TXr10K+MxQ=;
        b=O0bqnzHRjBlvOmfNVeGfl8mnNymOPCloC06kG71Ecuna08lwoODcd8R6k/+fG/RrSX
         +HLhFbT6kc1Pr4pz+RYaxU21nHIGZ9iSgfX8VuOOLBVz1zneVIEEhLAnbi5biQiqoHc5
         MPVMRCbnGqYso/z51O6aIfo2kFcTiSD8EhxHuVjInZVDpEErJnqWbU43ioJ3SWpPA8j+
         UpoFtDelemsSNiCgMJyY58nmfjv/2M2j7BQBXWdJcwWkaVqTKwvGqctbz2qxwhok2sob
         JCnddXEzQ+64QpQeXtLjaFH43WWYV6nmKLA5HQpcrqopUSTAXdsxetUqxhp09+cCbq6V
         reBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443090; x=1763047890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/49Sfwl13xTW+WWM56Tz99oC1h/uUZN64TXr10K+MxQ=;
        b=lQIbcCaZ+fCJcSRtHcC1Iojs/0vRcuZVEn7q9eQI3BVu6ScS1mHDPgvcc4s4vSTwp8
         rANJw/ArfHpuYVt861b2F39kLOS3Uqagl/CdObsfy+MtGbdn2y1aiLsM+cwx5ffnLEdY
         bsm+mq3EGO0drJDKIDLwDomj4PvQeSpGK5axbDp3mIrj8Wt1PfnaDMYmCv+dLJUKW1sX
         k3t44PrrFrq2rhFPy6p9taEeBbyE8g5godmyM6k5yxMFFggT8IMel4vj9muN7swoOCbV
         tkY0CqrVPMUeEtjXgJIK7o8t+yydTgg7ry0IqDsBN6n+0/XSxzAe3rNbgZZ8l9TtbhLg
         mKDQ==
X-Gm-Message-State: AOJu0YyCVbwxaCzdSAp7edFTB35B1H4vTo9t6ahdFrGHM1sPuOa71zof
	HhI13bi3wZXenTA3/shGke28M8qXhA1dAllu7Y+h6az0kRd96UCgWkqk
X-Gm-Gg: ASbGnctkDdj/2jUdzfp5G6TpcBhbzPStvpK1SjXZNq0eTVng8QWopt3uH+GkfSxiIBO
	X/K51pRTTv8Z223yisoljG7cnHnYnrKd3qEdDwirBNOtc6oz2EBvJR7VPtQQsWkHXCvExku1hGq
	B7GT98fgSkJJGFQ0HLZaKed1aR9rZMZ25BZ0XewTGzT60LJxBB3H0KDadI/YKPII3DEMCJ3VWWg
	rqqaRuCfWtGQaQtfyO7YvGpeWUq9KpJMaBCQ0EHaTIzqJ81Xrfy2LCzThuvjY457vi+IQQGwZ8+
	tJ+AxPoOiSbvARoS1rXRvc2siXLCXYxJi8WZuUz0m1TeIgIqxYQq1vAnOTTy6AXC91OUUcvRSGE
	eZmFmOo+Xm4+1JVHaDB1I9z+mbAyTVcigtg+agdI//pUb2QhjwlApw5laLzv2nE/gmKxfEDFNH5
	AB2sR2eK3aOjq5r46IOyotyoRRB/w8novO1PsjEKU2zhc=
X-Google-Smtp-Source: AGHT+IE+lGiphJYSqDcTBLXpyitqbsqLUskgU4j9r+fhahutH0rKPEP+LS3TiGdmHY2j9RyrvHXlTA==
X-Received: by 2002:a05:6a00:816:b0:7ab:6fdb:1d3a with SMTP id d2e1a72fcca58-7ae1f294128mr9689068b3a.16.1762443089822;
        Thu, 06 Nov 2025 07:31:29 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd599e7sm3175835b3a.25.2025.11.06.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:29 -0800 (PST)
Date: Thu, 6 Nov 2025 07:31:26 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-kernel@vger.kernel.org, Kieran Bingham <kbingham@kernel.org>
Subject: Re: GDB causing OOPS on insmod
Message-ID: <aQy_TikwHgkb9iNA@fedora>
References: <aQvdFfIhcMBpJdmJ@fedora>
 <b2019235-3fa5-4e38-8a2e-2c3ed955de06@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2019235-3fa5-4e38-8a2e-2c3ed955de06@siemens.com>

On Thu, Nov 06, 2025 at 07:07:28AM +0100, Jan Kiszka wrote:
> On 06.11.25 00:26, Vishal Moola (Oracle) wrote:
> > I'm on a x86 defconfig + GDB_SCRIPTS + DEBUG_VM + PAGE_OWNER kernel. Running 
> > 'lx-symbols' in gdb Before loading modules causes the kernel to OOPS on
> > module load:
> > 
> > [   13.627373] BUG: kernel NULL pointer dereference, address: 0000000000000900
> > [   13.627376] #PF: supervisor write access in kernel mode
> > [   13.627377] #PF: error_code(0x0002) - not-present page
> > [   13.627378] PGD 0 P4D 0 
> > [   13.627379] Oops: Oops: 0002 [#1] SMP PTI
> > [   13.627383] CPU: 0 UID: 0 PID: 279 Comm: insmod Not tainted 6.18.0-rc3+ #163 PREEMPT(voluntary) 
> > [   13.627384] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-6.fc43 04/01/2014
> > [   13.627385] RIP: 0010:__kernel_read+0x210/0x2f0
> > [   13.627390] Code: 00 40 0f 84 bd 00 00 00 48 3b 7f 18 0f 84 c3 00 00 00 48 89 f2 b9 02 00 00 00 44 89 d6 e8 78 6c 06 00 4d 01 ac 24 f0 08 00 00 <49> 83 84 24 00 09 00 00 01 48 8b 45 e0 65 48 2b 05 53 38 c7 01 0f
> > [   13.627391] RSP: 0018:ffffc900002f7c68 EFLAGS: 00010246
> > [   13.627393] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > [   13.627393] RDX: 0000000000000000 RSI: 0000000000000246 RDI: ffffffff82d47e70
> > [   13.627394] RBP: 00000000002f7cf8 R08: 0000000000000000 R09: 0000000000000000
> > [   13.627394] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> > [   13.627395] R13: 0000000000000000 R14: ffffc900002f7d10 R15: ffffc900002f7d10
> > [   13.627399] FS:  00007f704851c740(0000) GS:ffff8880bba45000(0000) knlGS:0000000000000000
> > [   13.627401] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   13.627402] CR2: 0000000000000900 CR3: 00000000095f2000 CR4: 00000000000006f0
> > [   13.627406] Call Trace:
> > [   13.627407]  <TASK>
> > [   13.627409]  ? init_module_from_file+0x92/0xd0
> > [   13.627412]  ? init_module_from_file+0x92/0xd0
> > [   13.627414]  ? idempotent_init_module+0x109/0x2f0
> > [   13.627416]  ? __x64_sys_finit_module+0x60/0xb0
> > [   13.627418]  ? x64_sys_call+0x1a74/0x1da0
> > [   13.627421]  ? do_syscall_64+0xa4/0x290
> > [   13.627429]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [   13.627431]  </TASK>
> > [   13.627431] Modules linked in: test_xarray
> > [   13.627433] CR2: 0000000000000900
> > [   13.627434] ---[ end trace 0000000000000000 ]---
> > [   13.627435] RIP: 0010:__kernel_read+0x210/0x2f0
> > [   13.627437] Code: 00 40 0f 84 bd 00 00 00 48 3b 7f 18 0f 84 c3 00 00 00 48 89 f2 b9 02 00 00 00 44 89 d6 e8 78 6c 06 00 4d 01 ac 24 f0 08 00 00 <49> 83 84 24 00 09 00 00 01 48 8b 45 e0 65 48 2b 05 53 38 c7 01 0f
> > [   13.627438] RSP: 0018:ffffc900002f7c68 EFLAGS: 00010246
> > [   13.627439] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > [   13.627439] RDX: 0000000000000000 RSI: 0000000000000246 RDI: ffffffff82d47e70
> > [   13.627440] RBP: 00000000002f7cf8 R08: 0000000000000000 R09: 0000000000000000
> > [   13.627440] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> > [   13.627440] R13: 0000000000000000 R14: ffffc900002f7d10 R15: ffffc900002f7d10
> > [   13.627442] FS:  00007f704851c740(0000) GS:ffff8880bba45000(0000) knlGS:0000000000000000
> > [   13.627444] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   13.627445] CR2: 0000000000000900 CR3: 00000000095f2000 CR4: 00000000000006f0
> > 
> > I used module test_xarray for the purpose of demonstration, but this does
> > happen with all modules.
> > 
> > I have no clue what patch caused this, or when this bug was introduced.
> > I played around with the scripts a bit and found the diff below eliminates
> > this issue entirely:
> > 
> > diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> > index 6edb99221675..8b507907e044 100644
> > --- a/scripts/gdb/linux/symbols.py
> > +++ b/scripts/gdb/linux/symbols.py
> > @@ -44,8 +44,7 @@ if hasattr(gdb, 'Breakpoint'):
> >                                "'{0}'\n".format(module_name))
> >                      cmd.load_all_symbols()
> >                  else:
> > -                    cmd.load_module_symbols(module)
> > -
> > +                    cmd.load_all_symbols()
> >              return False
> > 
> > Does anyone know what's going on here? And is this the fix we should upstream?
> 
> Are you using kvm or tcg with qemu? Is the issue gone when switching the
> accelerator mode?

I'm using kvm. Switching to tcg works, I hadn't thought to do that :)

kvm is definitely faster though, so support for that is my preferred
option.

> And when do you attach to the kernel here? System booted, idle, attach,
> continue, load (another) module?

I've tried attaching at all those mentioned points, it always Kills
whatever module I attmept to load after attachting gdb and running
lx-symbols. Aka I do not run into this if I never run gdb, or detach gdb
before loading a module.

