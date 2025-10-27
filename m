Return-Path: <linux-kernel+bounces-871866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD005C0E80C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8C21883112
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FB3081CD;
	Mon, 27 Oct 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyqW9+SW"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF3279DCC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576112; cv=none; b=cOUhEfZxpoqn7eIBQjotviymez1fP5dLjNRhBEv2oQHWms7YWpt1wwXmir2TqaphFYNi8ip2KPv5K2fKURFw4iSdwNQFKGp3mALJoBQuNWmuHJwpc2n18xAL/a1ifQthIyITZbqGDCPeKLAzFoqqnTWoyotI2odUcxgJ7ppgA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576112; c=relaxed/simple;
	bh=KRdQQb0wh8/jMWv0NcvlejBbk/5bLAuv3/1ZcY/hGSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mC4oNBDJoBC2ZEXdrHAbi1fHM0IN1jCvq6qTchmdUk6UYuyEIEBVPB6VEq3Ce9Av9NXZs1oYWlmIlikvgLCpztTt/bHI408H6aRGs4C6tPgxxR4fHzyaDLmp5GqM6ZbHfE+ba2QHqbU5yiqC7dgA4MMff2tLvXv2Ny95Z529tDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TyqW9+SW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb779733so4108784a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761576110; x=1762180910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fO12TJOmOefM7qypSUNCCkqj7DD82ALlBIv/0Bx+So=;
        b=TyqW9+SW5i8QjfxNRkNrtk/nOOlL0byXgYGNwVKgpj5hAUradfZ4BFwKBjsIqA4/Eg
         R550Av/6YLCl5DgJXyvLM6G03nkXGLZaOjLSkri7cEGQbWZ99YDfunt4mrn6q4btzCxs
         HbOg2OqgUCSU0O9VuPylccwJuZSTadDPPlMBvwgEj+nEh6P4VZzdSdoxnC37bAIK6dqm
         w2HTqJxjVOpqIxkXHXO2novW+UU3TVaMQ8fdu9aGhYMXN+redrvDEwIKuUvmmp4jN52A
         uHiQDh9otqHPz3GZ1YCU/58XOU8f+acOVnNB5Gxog6h5Zld9m0ejIcHl2LHA8a9YKomy
         NGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576110; x=1762180910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fO12TJOmOefM7qypSUNCCkqj7DD82ALlBIv/0Bx+So=;
        b=mHJwPVM0qzFgXlofkD8jgDjvgGTKhIAWXvFAQsh3Tfni5ih+P65oMRnhdoVsO6Ubgo
         rSWe20oiYaeNGXhTkLVefqCgrB/Kn3mWROVDb8wlXGcdOcNrAwtXiZRrWYTDFTi6C/9k
         GiTBEXyWaB/v+t1egPe4NsBCWa+NKYZNmjstGd4B2tEfCSkzRRDaXpjhxPf14iJ9gjxt
         tc1I/kkHhD1dS305sFu7EdUVtgiaCdkloPCY+hgfGJBQAoDQAFDqfDdQjzNkS1fmkd6h
         hk4cGCGNZn7O2qcZ5W9gTgSv5SHUWtO+s2J/sxxHUkpNiQfBF4Uk0qzTKI5gC3w6FBfY
         QZRw==
X-Forwarded-Encrypted: i=1; AJvYcCXJRqQUpcVigME1d95A+jFObbZYlcPE0m7RpOfcGT/SrNJ+5G90ns0HVgcNOYVpYoZqXtvulofTR4o6/hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx6KMsTewna/f4ciwdiG+D0S+lxAhEYmoyerbG0vuVRQ2xEf2L
	/5HRtOAiHN5TMg2bxcguFIX95pKeaK+MrITs/vpolcd5Lgij5cSXX+Uk2Wd/gIdwyrGYvEOwkB5
	cQYcYyQ==
X-Google-Smtp-Source: AGHT+IH+UwqXdEYCE1CocvyH9lqBSvO8TdLxvBs8Mxx9vAQZb1++QLKCMGGhKByvzH6gbci2kJYM9jTLdWI=
X-Received: from pjob8.prod.google.com ([2002:a17:90a:8c88:b0:33b:51fe:1a7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3806:b0:32b:6820:6509
 with SMTP id 98e67ed59e1d1-34027a0741emr78274a91.9.1761576109905; Mon, 27 Oct
 2025 07:41:49 -0700 (PDT)
Date: Mon, 27 Oct 2025 07:41:47 -0700
In-Reply-To: <20251025015852.8771-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <68fb1966.050a0220.346f24.0093.GAE@google.com> <20251025015852.8771-1-hdanton@sina.com>
Message-ID: <aP-Eq4NFAhIscvIf@google.com>
Subject: Re: [syzbot] [kvm?] KASAN: slab-use-after-free Write in kvm_gmem_release
From: Sean Christopherson <seanjc@google.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tabba@google.com, xiaoyao.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 25, 2025, Hillf Danton wrote:
> On Thu, Oct 23, 2025, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit d1e54dd08f163a9021433020d16a8f8f70ddc41c
> > Author: Fuad Tabba <tabba@google.com>
> > Date:   Tue Jul 29 22:54:40 2025 +0000
> > 
> >     KVM: x86: Enable KVM_GUEST_MEMFD for all 64-bit builds
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12a663cd980000
> > start commit:   43e9ad0c55a3 Merge tag 'scsi-fixes' of git://git.kernel.or..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=11a663cd980000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16a663cd980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=67b63a24f3c26fca
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2479e53d0db9b32ae2aa
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173ecd2f980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14bc2be2580000
> 
> Test Sean's fix.
> 
> #syz test linux-next master 

Oh, nice.  Thanks Hillf!

