Return-Path: <linux-kernel+bounces-793548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06809B3D508
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E44E44E0EEF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E5A1FF1B4;
	Sun, 31 Aug 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUVUYnFQ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A721CAA4
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756669741; cv=none; b=Xz4F74Vs5w/uH9KrAnNZfr7DuxirhWOadKFYBdvVVE/bjyA4SS851Kv0r5P+JLW7WqH+NlgVEB4hR9StnB5NTlDQm5v07bwxbfA4rA3tUmtz5mkVDrV5Z5oaqhGd9jsVO+cKx47Bib9Z8zEgOh58LeFrKFs2mZVqCjjjmEUuWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756669741; c=relaxed/simple;
	bh=AoQgcBbEVxyLf7vnZ/XJPMp1toRWq1aXmp8hntCclMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euYq6msj06oeO/SuXE1pDt3eRjoQCFIucQm2a8gw6J83FWka9Tx3y6Ao7LyNwSNVjOGuGetIV7c6W3XTr6RrqRR15j7OUhpPSSrguDexzlgkcvMYe3iBJWYSCUyUSoLpehCepJscyv0fYh79K0tAWGiX5yP+w8QbuvI1f6FvNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUVUYnFQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b89147cfbso6662525e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756669737; x=1757274537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/uS8XQoltVZTTde0T8QO8uNExPfeZjyr7V7lSQkQi0=;
        b=IUVUYnFQiR7+k3j9eT2Hkqsx/N9KYbhbo5N6Q0htVaiTi5crv7HcRGTR9HV7F8x4u2
         KOe2sHCyOK2emHd5swlYwFyD7O1/R7rHBkqjIb28RRtdTv4JdeimKi5LndnLAnePS4/o
         rf3vrFu/0uKUnXhQfYGpfgcbjflq/fFXO/Cl9sV77YqbuVRturUeqo60YjbHMqKpjA+L
         QFac9VIuwlD3RA11wlZr4oIi3xPR96k4ebACcbvXh1Aa3gfjzxQvK/U+ekoJRgnEj/tH
         Pv8mQkMsicbb8v1f0uMG+JRRDHmBPhp7K73CPYBpdWIJGaepdngTgSv5xB86fbLZ0sJz
         wxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756669737; x=1757274537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/uS8XQoltVZTTde0T8QO8uNExPfeZjyr7V7lSQkQi0=;
        b=EKBGJUUpdtRDTJwKuIhCm3l4QqYb0UM/FOFZ/7n6ACaahMA1zJQ82yXtCljAd/9NGM
         YasyL2vDX0rmhUY/wc+aYAAukqYXPi6IZDuZz33/EFNbKLXhn40SDI5/EujATkd/YOjU
         A5p7I4I0xduUj4/vftZOf1mPbR8aiS3qfL/oW6dQOlb2iJsAANVKb0rrm+ZOhrc3TkWm
         KKDgFYfKWV1XPruJ8zDV0fF23OOs2YLBDZ5HZ98GwGaokH1bPSbvAa5qXggy1g0TFTPf
         QMxYUNt+5WlVxIU1Dk1AAlp9zPdORq6OyMp0GuOhaLxfKqbmQCduR4Xe7W82DnN14Cww
         cBHw==
X-Forwarded-Encrypted: i=1; AJvYcCVPROFHnurSkzIiRpmug1yS5Vy+djgwTBDNV20DpSYcMElFU+v+zMPTDlwrnCBft/tZUQZfYphqRIUnXFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1s65XAs83fiIllh1OaK9bjwklNKxtNi+2CbRpVXgWgRyXn08v
	3O7OIL4WAcUKVjs9Y9nUJT62s0uEkd8jId+UEzxW6Dj44kIjO0S2OR0A
X-Gm-Gg: ASbGncsU5Pu9t8qE9YLycWpAWlD9b5pD8PBIL69nFPlHim0LFbihxO3mpt0r5ebjR2z
	D6dMBJkDxyyTeQs/QzjGNRwdQnHwCQidUgGCgmqVAx7OGbXX9bMNy4lUxedVP1/tCGnYuEhkol6
	K7D4or7ZiN/6HIQywUOQ8br8mR8ENpVHPlQ86xpJZdd+Qv4f+6+zotMmjR43PbcBcdWo0n6c8iL
	L2HLPbKaYTkbcx+oS/Yy1s974XcRoJLfNLd5jGYmy7yp2YaGRHeJyhCbUomMnLfX6yk1TUbiWn+
	M1qEP/9VQIfRjjjEdM9tanfuL2MOuww5IGUx+QsSgpqrAn3SHaYUfWUWIbjJuw7vRy9P3qqHFPJ
	xCYyWs153UQPejj5JMA0IgvPYG+nGSSS7PG9NCsNUFCuZY/ZeCR9aRmqMWNK5VlUXWUXmN6hHEy
	o=
X-Google-Smtp-Source: AGHT+IEeEQ2hbkObnxnkQG39yfKnUMI72ypP7uwHeRLeeAnCWW5M4XijwFDwGKMABe2hwYYDl5IayQ==
X-Received: by 2002:a05:600c:4f8f:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45b85550704mr45673845e9.4.1756669736666;
        Sun, 31 Aug 2025 12:48:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab832sm125269075e9.23.2025.08.31.12.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 12:48:56 -0700 (PDT)
Date: Sun, 31 Aug 2025 20:48:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>, Sabyrzhan
 Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH v2] x86: add hintable NOPs emulation
Message-ID: <20250831204855.5e41af1d@pumpkin>
In-Reply-To: <0ffa7c6e-f32f-4966-85df-3ee5f2426e9e@orca.pet>
References: <202508291620.bcfb3924-lkp@intel.com>
	<0ffa7c6e-f32f-4966-85df-3ee5f2426e9e@orca.pet>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Aug 2025 16:34:05 +0200
Marcos Del Sol Vives <marcos@orca.pet> wrote:

> El 30/08/2025 a las 8:56, kernel test robot escribi=C3=B3:
> > [   24.176151][ T2696] BUG: sleeping function called from invalid conte=
xt at include/linux/uaccess.h:162
> > [   24.176703][ T2696] in_atomic(): 0, irqs_disabled(): 1, non_block: 0=
, pid: 2696, name: trinity-c4
> > [   24.177213][ T2696] preempt_count: 0, expected: 0
> > [   24.177492][ T2696] no locks held by trinity-c4/2696.
> > [   24.177788][ T2696] irq event stamp: 335112
> > [ 24.178030][ T2696] hardirqs last enabled at (335111): irqentry_exit (=
kernel/entry/common.c:210)=20
> > [ 24.178521][ T2696] hardirqs last disabled at (335112): irqentry_enter=
 (kernel/entry/common.c:?)=20
> > [ 24.179004][ T2696] softirqs last enabled at (332212): __do_softirq (k=
ernel/softirq.c:614)=20
> > [ 24.179473][ T2696] softirqs last disabled at (332207): __do_softirq (=
kernel/softirq.c:614)=20
> > [   24.179948][ T2696] CPU: 1 UID: 65534 PID: 2696 Comm: trinity-c4 Tai=
nted: G                T   6.17.0-rc2-00017-g09c737e0df5a #1 VOLUNTARY
> > [   24.179952][ T2696] Tainted: [T]=3DRANDSTRUCT
> > [   24.179954][ T2696] Call Trace:
> > [ 24.179956][ T2696] __dump_stack (lib/dump_stack.c:95)=20
> > [ 24.179961][ T2696] dump_stack_lvl (lib/dump_stack.c:123)=20
> > [ 24.179963][ T2696] ? nbcon_get_cpu_emergency_nesting (kernel/printk/n=
bcon.c:1375)=20
> > [ 24.179967][ T2696] dump_stack (lib/dump_stack.c:129)=20
> > [ 24.179969][ T2696] __might_resched (kernel/sched/core.c:8958)=20
> > [ 24.179976][ T2696] __might_sleep (kernel/sched/core.c:8887)=20
> > [ 24.179979][ T2696] __might_fault (mm/memory.c:6957)=20
> > [ 24.179983][ T2696] _copy_from_user (include/linux/uaccess.h:?)=20
> > [ 24.179991][ T2696] insn_fetch_from_user (include/linux/uaccess.h:212 =
arch/x86/lib/insn-eval.c:1516)=20
> > [ 24.179995][ T2696] handle_invalid_op (arch/x86/kernel/traps.c:308)=20
> > [ 24.180010][ T2696] ? exc_overflow (arch/x86/kernel/traps.c:417)=20
> > [ 24.180012][ T2696] exc_invalid_op (arch/x86/kernel/traps.c:432)=20
> > [ 24.180014][ T2696] handle_exception (arch/x86/entry/entry_32.S:1055) =
=20
>=20
> I am familiar with interrupts on microcontrollers and embedded systems,
> but not with Linux's, so unsure how to proceed.
>=20
> I've seen UMIP and IOPL emulation and they both run with interrupts enabl=
ed,
> by means of cond_local_irq_enable, and then fetch from memory using regul=
ar
> insn_fetch_from_user/get_user which may sleep.
>=20
> VC, on the other hand, uses the insn_fetch_from_user_inatomic.
>=20
> Can someone chime in on what should I do for this? Enable IRQs temporarily
> using cond_local_irq_enable or local_irq_enable, or use the inatomic
> version?
>=20

My 2c:
Enabling interrupts might have all sorts of side effects.
In this case it should be ok to use the 'inatomic' read of userspace
that will fail in the very unlikely case where the page got unmapped
between userpace executing the instruction and the trap handler
trying to read it.
If that happens just return back to userspace and re-execute the 'bad'
instruction - it will fault again and hopefully you'll manage to
read it the second time (or eventually).

I guess there might be a problem if the cpu is faulting on the first
few bytes of the instruction and a malicious program has put those
bytes right at the end of a page - and not mapped the following page.
You'd need to differentiate those from the valid:
	for (i =3D 0; i < 256; i++)
		hintable_nop();

	David

