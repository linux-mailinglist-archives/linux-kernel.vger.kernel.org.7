Return-Path: <linux-kernel+bounces-850584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6A7BD3399
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FE93C46D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDAE306B17;
	Mon, 13 Oct 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csA2cVNw"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0726CE23
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362663; cv=none; b=HWHM7i+KiZrxwWPkCPtBUX58bcV9fm3utIKwJku72lHWnM342llHLWeKnuMe1pRx7u+MWDnGY9uEruBlR7PicyNfJpgnnSaJnRd/54ElqS7055WYTDArW4p01ulQ1QpyIxAua2RtlDgAo3J1mU7+RDdZ3IyhgI5tL2z8B+U7MZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362663; c=relaxed/simple;
	bh=m/8JPrv1GU0Sn50E+9o2TZvS36p92f2A+OpZmKuP5ag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cf/pbWWfBw7oHBrlgJkF37f9pPESteFKWXly2yOsswBL62XRPwyxawh5mCiA1ekpHTf2wy6Ai3KO/FhLosDXHFmWYWxgUUGwTKqyeS3CWCpyJUgOe9sutUCXdsf5Bj0UMTwjQ3uyPnRlceFmW5B9s/YFtQ0MYv4wZ0T4G3jyLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=csA2cVNw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3304def7909so8170130a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760362661; x=1760967461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAIapDEcJAQdge6OOo1guH98KYLzFcU0cXh3Z3W0lLU=;
        b=csA2cVNwwRx5w20TANraLV740Nw0ALFqiFADqS+ajr76Q9WQ7TPd+rQUG/HdzXIUDm
         VBCQlh8Yld+GYpG8XSeHPWqwetWniiRGA+yuLBzEZ6yBHmWj0ciOzx8hI5Sts5FC04eB
         V9YkOkEdjbmtrlSNhFD1US1DzHqubhA8/edr6QTti13lZ3tnN9uMTksekU0YpMElYQM4
         xA6X+HYI3DK4oonVK0J02M83+XnvEaXYCBiCac/dN5UrtvuUe+9IPuh5tp9mN7fjuhfb
         FlmTc8omsDOeaofhE1OWlxtR15pZ9fCQj/rKv9xDQQqiUr3t5POs1aAyw7AeQr1nUOlc
         OJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362661; x=1760967461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAIapDEcJAQdge6OOo1guH98KYLzFcU0cXh3Z3W0lLU=;
        b=qxh/A1JdaK6YfIaF6jNX798tDBjhyO7Cwq1vGp1iSiIPOasdoVtqdIGoSE96vQdzXR
         53G4f2COTi61x0r7QG8aY1unriqTDjWU2wmL//IlJJJRX6FtFqJeIODw7I9lWFFmWipK
         /IkqBGrzCZpZrJCnoX3r39621LJ/kblHM+637HoQGFcWBj/FI9CYR0cduAKDAtQ4NbzR
         Cw0ggzwcKxkzROU0HPmoHYRu4JR0vzPEygy2vxNsSfmpX+1DoroH8qCCtLy7weQps2MY
         yrJkfRqeLUbUcytDgxoCkCfF03RWGLLedZ396nSD7CinWX8rbGbMvIp+j6WR0AGUwxty
         J2ng==
X-Forwarded-Encrypted: i=1; AJvYcCW/EnncV11ffOTLzz41v3TK71NIcAZDP7zvaPvTOPUVdT9dw2q/2MWRqYtUT9gq9ROkX+vUoeoxIacohaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfOUnrz1903neRPGD1LOCBWMtonR+r/KRrcD3sAxSxDSCHnans
	9nC4RGoFyzp+B7TRyINMNxdjin4FoDw2BiJ+yR9GLNjZZ5dFnKmlG0JEuxgfVFQaM6/iRsdWl3B
	Ms6W7OA==
X-Google-Smtp-Source: AGHT+IFqcZRnscdipg5zM+1wti4QMMeWWj6yk/qLziKj1sb0ZivylX9DNDxRexnc7jtnlMobopNTUV2FgMQ=
X-Received: from pjbpi10.prod.google.com ([2002:a17:90b:1e4a:b0:329:7dfc:f4e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a91:b0:32e:2059:ee5a
 with SMTP id 98e67ed59e1d1-33b5114d52fmr31670461a91.8.1760362661067; Mon, 13
 Oct 2025 06:37:41 -0700 (PDT)
Date: Mon, 13 Oct 2025 06:37:38 -0700
In-Reply-To: <68eb180e.a70a0220.b3ac9.0010.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <684196cd.050a0220.2461cf.001e.GAE@google.com> <68eb180e.a70a0220.b3ac9.0010.GAE@google.com>
Message-ID: <aO0AoouTDSGpAPOw@google.com>
Subject: Re: [syzbot] [kvm-x86?] WARNING in kvm_apic_accept_events
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+b1784a9a955885da51cd@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 11, 2025, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 0fe3e8d804fdcc09ef44fbffcad8c39261a03470
> Author: Sean Christopherson <seanjc@google.com>
> Date:   Thu Jun 5 19:50:17 2025 +0000
> 
>     KVM: x86: Move INIT_RECEIVED vs. INIT/SIPI blocked check to KVM_RUN

Doh, I used the wrong Reported-by in the changelog.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1585c9e2580000
> start commit:   64980441d269 Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=26abb92f9ef9d1d0
> dashboard link: https://syzkaller.appspot.com/bug?extid=b1784a9a955885da51cd
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12200c0c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fd31d4580000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: KVM: x86: Move INIT_RECEIVED vs. INIT/SIPI blocked check to KVM_RUN
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: KVM: x86: Move INIT_RECEIVED vs. INIT/SIPI blocked check to KVM_RUN

