Return-Path: <linux-kernel+bounces-829574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E593DB9760D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFED16BAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7BA3019B9;
	Tue, 23 Sep 2025 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY2pGtVQ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42DC2FB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656320; cv=none; b=DVI9YqjZM4B4/wZu5G8VRMDX1RYGsieLNbTFr4E5U0xE+n/uurif56xoT84iB6v8P9M1HugCXKX3CLrmzkP32F1FOFrl0azgPK7R/HR7zUPS86Kc+75EqPr7q6XjRtuGlhhlDEBwz10QqKrESl/0yT9w/uvv9xtRv69iW8JWUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656320; c=relaxed/simple;
	bh=38AO549T7PWQHHE0HiAlAe/3HQcOpIFvfQig2l1/cqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qegTclqGjxgigpV8hwsywtgAXmxIvfGpxL7gx3uVXYpNSSrBSF3X/CFWzv2LZx2UMfsoVrlWuNvSv72nYhVeBfnPqf5TcOAKKVZbwZoyTwdOhxzGpD1HIvPO/rLJVYhxKweEmO8MTajULx14H5LSyYysD1CVVo7XvgqkDKMvCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY2pGtVQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso44123095e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656317; x=1759261117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrigS4V5VbaNbsfaDJ84/SAKbiUaeWo7GlHMv+mR6fg=;
        b=cY2pGtVQSb80O60Adww99f+C54voxcX5TRd+V8ObtWEeq8dthV/zfAe3DFzJ1gwoAZ
         l1TUBzwtafr0Qt3VKFfziPEtjNoBcxsE+/1ykeelMjMvFXN+bOdOU9XRk3DZT6N9w70B
         dqXVaxO6TmP/7Xj7DvggrrGlaOHtcV7qBrJEyILEEGFm03wa0QIHzMOO2rpnK14dSvbo
         QYiyrEkg3tI3LWx2HTHK+BR5pKkDO1HdcvBfuaLwl8RXCQIcySR4jHnDPY3camm7CmsK
         aTVEtIp9NbzTABcvRgqbzOinKB6Ur+Mv1YH3mv77pEqO1FIim7v10ZXtXXGS8ckkBeOY
         EXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656317; x=1759261117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrigS4V5VbaNbsfaDJ84/SAKbiUaeWo7GlHMv+mR6fg=;
        b=vXjLYtKbvYWCkXp0YDYOL4Qon6f1QAchyet7bH6GFM4zoB0dFxoMRngzL6XAo5Q9WV
         R+s+kjR2rKe2730GzYsaxXaxFKsn3VtDd/LvF+0dfqx+eCT9EnwUQG84ICWTQfxMvEMV
         8v0USotjsEvh61+Fl8copSPm5dUA3XnaieBzRe5pVlk1fl0DMvYBu7MGEQzuO/BkBEFJ
         hf9SGmUs6g9GYzoZwldyRxLeUtPMPiPzAj3+fwjUHSLrSScoCY+HsEqtle+B+/hc5g0L
         khQMiJClJgD6IGs6zaTSkwzBiZbExiJHlI2xj1KiZyhsz7QLxy5y+Mvq/2FCfsig5zoL
         5OOA==
X-Forwarded-Encrypted: i=1; AJvYcCWjJbVyKP04NBBjSx6Gl9yHZj91T7N7kwAEgjx4Igu60ZjFTz4GYkpPZYMcF+1CUyZHAb+fCCG5obwqSAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDL1HdNBPJHUbd+jbiUXfRoE8HIwiqkHO6m4kuxbglx/HMLYen
	c11g3vnJ2tvei3ukVckoTh22vj3lSQl9Wq9wO3Kk1jWGSaR4Av6HOL/jlGxu2a8yhTWI5+1s84Y
	BqBKclLN8vHdBW6X0MJ38wwjVOglq99sq7Q==
X-Gm-Gg: ASbGncsVDCBhX84zcwIt3SmRP9NZ+VOGuzeDkUyIu05xzVMn+DrxYAm02iliFNOuLoi
	Or/s03EfVflM9tEzt3SPZGctRbLhlSKFdgrdw9n0qthNJ19HEdT125MqjIpg8e/ANa3Tg0zy2HM
	yL1SopbX5KVfPtGprFv8vFwn/MFMyCItfSoHVQ4DLtdW6RnurTvHdi1E/2uV10L+9t9BtPgRoQu
	0MBpjM=
X-Google-Smtp-Source: AGHT+IFcDRB8CWbnWs5IUoPJfnSUY3IA+NMuBGnhQP/uCa5ju117yIdrrx9mhIliG17KJgF/fOhRtzlTEFa/xElEbzE=
X-Received: by 2002:a05:6000:2404:b0:3ea:6680:8fce with SMTP id
 ffacd0b85a97d-405ca95aa8emr3136840f8f.48.1758656317176; Tue, 23 Sep 2025
 12:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-local_lock_internal_fix_shadow-v1-1-14e313c88a46@kernel.org>
In-Reply-To: <20250923-local_lock_internal_fix_shadow-v1-1-14e313c88a46@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 12:38:26 -0700
X-Gm-Features: AS18NWB4yuhQMFz0na4SUv0ezJMebaGYv09-0aocumx6KxXxP1HsL8HSChYn7x0
Message-ID: <CAADnVQK_Dt7Ag9nLQm2LDFoiB_ymorC017YXJ9ZC06VizEHt2A@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: fix shadowing in __local_lock_acquire()
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:02=E2=80=AFAM Vincent Mailhol <mailhol@kernel.org=
> wrote:
>
> The __local_lock_acquire() macro uses a local variable named 'l'. This
> being a common name, there is a risk of shadowing other variables.
>
> For example, it is currently shadowing the parameter 'l' of the:
>
>   class_##_name##_t class_##_name##_constructor(_type *l)
>
> function factory from linux/cleanup.h.
>
> Both sparse (with default options) and GCC (with W=3D2 option) warn
> about this shadowing.
>
> This is a bening warning, but because the issue appears in a header,
> it is spamming whoever is using it. So better to fix to remove some
> noise.
>
> Rename the variable from 'l' to '__lock' (with two underscore prefixes
> as suggested in the Linux kernel coding style [1]) in order to prevent
> the name collision.

lockdep has __lock as a local variable.
So the patch won't really fix the paranoid warning.
I think it's better to fix sparse to silence this warn.

