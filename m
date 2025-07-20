Return-Path: <linux-kernel+bounces-738379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96D3B0B7AE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CB81781F7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A421B9E7;
	Sun, 20 Jul 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WjD9RDTO"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C81459FA
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036521; cv=none; b=oIxIcFXlVRB4zpcc29KXeyT6xfyH+GjBpXTsaaVPlDNeUme81TYcTI9AQCb6/z8gQ9tSdCcVFStD9ifUSVKpe+uAWYiG9116X09rafTcGc5FeOjwAZ5Qp7jD8Up9/omtIzLbIAy3wJ5UTIoVw8GuLQx4/ZqEwbez2pqcHdLT3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036521; c=relaxed/simple;
	bh=U/QVQM8dTLXGidDGCrrKtECENuwHRbWXXnLOptEQ9YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kY9jkvTnqgxmCtHA6W82LcM3p6Ht6qo2iEjt5/WyAwnFIhO1jEf4n/Jn1VyuaZFLeobxTiWa0X7AtsZsFGKtYA5JLY88ZKMwMGXNtNG4MXtz7cTJ1a1ytL5nXipa1uChIOGw98y4kdN7bRgyoBipdj+ijIm1o1D9AA1Yg5d8FjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WjD9RDTO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso6567335a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753036518; x=1753641318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvjoIAAa9gmmfcY6MWrT+rPvsOUoT+4Z4BzA8w1TkPU=;
        b=WjD9RDTOu2y9fHYv/ditrS3ER9kO+eZIOyuIpf77T9gRFup43Whg+f3s+q5i8LzhfQ
         5tlX4FZKWLkax8y7fBHULLsKDcJI+zDZAWrwsFDXuIsmyofCfnBDmVBjYCf/oP666FYq
         Ka0aiGf4Jk+00Ckpz2sTg+W/vD6PaVtd2+GIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753036518; x=1753641318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvjoIAAa9gmmfcY6MWrT+rPvsOUoT+4Z4BzA8w1TkPU=;
        b=NYaL1dCr75N3zvtS4KVYZVIroAQVaSKmUlhSeLekLX2DO5I9zrvovk8QZPvI9QlhgG
         kiZCAZs/qYkgGfZsQPWldYEqrdnRRZWuVVJV+iFoJZwWdooCY5GPlew+Tz3/DwsvOq/W
         XW9XsbtBaa8vGZpGYA9ExpD4XqIkaiH2FFFbcabafM51bqwhthPBQItWdxk+bcevjM3S
         V+5hBPIeHFJtIIhPSksIhRvCKxc01atloeXsxjCY8uF93480EYPFIv60ypA2l35DUYmZ
         wwN/tKkSYvJ/e6JryNijFtlQShO4VSP2gxD8UsNFKYTRJYnS9c+olIfQhLuhdlDbRDab
         Z+Fw==
X-Gm-Message-State: AOJu0YxgGv6KiVd4UIa5bdwJKyPJ7zscrgaBax54x3GwP6DYrAy2vo2c
	mq5a/u9fxIyWaYcxr0KjRpPaR/vP/HWf8cwgXQMXRy/NNfJ9c8VKgnytYhjhM6ylXbubxIunowG
	R0r2hLlI=
X-Gm-Gg: ASbGncuois+p30kMW7j2kn9x9P6WuhZezFeNg9sa3ljxRHB9MVHRaLz+rdxffj3gChF
	ur2iDV7hBSubH0KJk/Ywd3tstvivW9lOr0pkBrK/VwdBJDcuq8BFh3FkCCa7Jeed4Fo3bxNYL8y
	O0CgICRzn8FPLdVkhB91UQC6BHkXhmhBt4AhNvkpb79ajvy+QJNt2F4ZULf+pCqUBqHKDkQ53A6
	YUbn+WriBNi3GkeOmE8R1An6feaCmMAJcajlVQ5c1VNaBwpLKoyy4YIy2dOyMwsGBNJ31Z5cpj+
	JCzlHcJFtNynC+/zQp/E+Ie4ZOxxy7KEQP2FOsU2L3l91jMipoY96yTVf4JCwzfiz1TA+0kkeTQ
	12rWk+jlt3S6a7W0YTwziC25U6NiB+F4Z4IppAsJsKzviK/5c2I+s2YV25A0KiBHwWVeNtJ6D
X-Google-Smtp-Source: AGHT+IFe+36FSQFB3WEALiYa/IDY43KPyHk5sD7MpJ+lwZcFF3HWyaq7+CA7+CmiWQmjFWtuDBjHQA==
X-Received: by 2002:a17:906:c115:b0:ad5:4806:4f07 with SMTP id a640c23a62f3a-aec6a4934eamr974999966b.2.1753036517631;
        Sun, 20 Jul 2025 11:35:17 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79cd11sm529774566b.16.2025.07.20.11.35.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 11:35:17 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so7750991a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:35:16 -0700 (PDT)
X-Received: by 2002:a05:6402:d08:b0:607:2d3b:4827 with SMTP id
 4fb4d7f45d1cf-612c7410afcmr8922369a12.30.1753036516580; Sun, 20 Jul 2025
 11:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175301303546.263023.1426155806374119244.tglx@xen13> <175301303889.263023.7762556142250207604.tglx@xen13>
In-Reply-To: <175301303889.263023.7762556142250207604.tglx@xen13>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Jul 2025 11:35:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wha6sXik-f0RC91TMbt4snau0jK+dPvQEMezGiVFDpKUQ@mail.gmail.com>
X-Gm-Features: Ac12FXymSxWi00lgmQ6RBDz0q2jb35ThYBBCyYLTcsUE7sYQ5lGwmWgqzCLMMlM
Message-ID: <CAHk-=wha6sXik-f0RC91TMbt4snau0jK+dPvQEMezGiVFDpKUQ@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v6.16-rc7
To: Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Jul 2025 at 05:05, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A single fix for a GCC wreckage, which emits a KCSAN instrumentation call
> in __sev_es_nmi_complete() despite the function being annotated with
> 'noinstr'. As all functions in that source file are noinstr, exclude the
> whole file from KCSAN in the Makefile to cure it.

Hmm. I'm not entirely sure if this counts as a gcc bug.

In particular, look at the *declaration* of __sev_es_nmi_complete() in
<asm/sev.h>, and note the complete lack of 'noinstr':

    extern void __sev_es_nmi_complete(void);

and I wonder if it might be the case that gcc might pick up the lack
of 'noinstr' from the declaration, even if it's there in the
definition..

The fix for this obviously ends up working and is fine regardless, but
it's _possible_ that this is self-inflicted pain rather than an
outright compiler bug. Because having a declaration and a definition
that doesn't match sounds like a bad idea in the first place.

               Linus

