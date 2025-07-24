Return-Path: <linux-kernel+bounces-744431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B05B10CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89ED73A8AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38302C327B;
	Thu, 24 Jul 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHa/bb48"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A272625
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366179; cv=none; b=IFDtH86H1y4COQaVTRaQwYnLyNdyZkRpbniGJF6dUTyndsVnHFJRH92SrewwKnCoC/PZHcOF1C655Bplois6J1tgDL/qHwOwTL6edT3/O3XZAmrlE14ONPO9T6MzP2sx1AMSe5QSeKOAtehVI77wG6Q0a/WQCdJ30HOClbFiT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366179; c=relaxed/simple;
	bh=mqxujfPMXOMqPImVeJOKbPVRVun15is6k/auoQTdogw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYcUCEwdMCIgxXQUxWL/zEJcWfeR3sdIfNxnMG31huzOnvmdCAP+nA5mLV4VaA3WunxIuj06JLvVpdr9GlgdDaPlmMuh39GyNqB7MAnsOAbCiCVRcLeE2ibJOVIZPl+5QOZDIAS5co5H7xlTVFHWRDyEtYUKdC/MDsn7uT2w6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AHa/bb48; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fac7147cb8so14280076d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753366176; x=1753970976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kI2DQQXCIIwX47gBWMT7lpZ+yA28bBKAj+N03xB3U1A=;
        b=AHa/bb484JyAF4N/8Ba6Lqp6WPjCuIRZtE04Gl1sjcILkiOJpbnys2j3HjO3qCLgbB
         fTN1SQ9spohqn92ZjXnaDDXLQJr50/csRj1ue0Ad8vhUTX0X06vkBXN2b/5m0YRyuEKv
         c6f2FkKuOiqHB31alI2C0LTNeePFbb4NqYlJ5KnW+pDHhSqnQubrZE3WDrH3/oaZrN7B
         aM3dkBznFvbLtMIdEvXYQAs8WZSmCNh1vWQkz+sd6u97h4EWTXLiyK/8PXpSvBwGs5eN
         TBw3DCB26Obcwirayq7QwTP86AzuK+MOZauZ+AUC7SD9ssTuBZxXX2uAF0r8KTTXcaGk
         Kdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753366176; x=1753970976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kI2DQQXCIIwX47gBWMT7lpZ+yA28bBKAj+N03xB3U1A=;
        b=ZqCwTM9myug7kuKmGcoVuAmORDbtr6SD024MgW5kjy/OZYFnLZi9Oi5C+EjK4Wry60
         N0Yf2VRU/l2T5elrx9drH1B2pUDGDmr9y3fogmwO+U/pBVyu62p/dunt+44rfzVk32gR
         nNVtwWUwL3kNu7Ru48f9qpGOx64QmR5TTx3G9hx1DiLWrYkK8HCPT7PhwJraUGzPTSRW
         JIvfno2Xsm8dPwa0VG/c7IXIWu6uCspM4jbPI9gbY5VDU49SYE/aRR/NxyiBLJ0s464C
         d2o1YZyCStrdUILkDtAQ1ABHzxNj+C8JT1CJlpTO4fP9qKuKjAH07TkOVkM0LQmWUB9T
         4AQg==
X-Forwarded-Encrypted: i=1; AJvYcCWaSACFEtHBONGHwXLwsSzzBLqd4ykf4ABfcQdZspuZ3UnWWkq2P5zmGqfLoW7HORVyGynPlM+/7aEK+zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx06SkZSSjOi9TZ0B0LQzArnZqxZkhH7oBkW8FuncxJM7blOBm
	lL/u1IRvqn65b5mbob/VVsBXzRVSH5fZPZskdsoSHaC1jozjWY4QWGJk+GFvaui1MZyJYHHKBvi
	mqv2+TCVg3RoTNb7tBxZLRi+eJBXl6gbN4O0v8wpl
X-Gm-Gg: ASbGncuIleb9JmIYV8XpO0mj9pbBP80/p4yx7Vz9HMGYXI3SdOjxHfF7Z97cT/UAA71
	Y+uCjRGJ7TauLFwaVdCSDSl+OT6RPG2YEwZ+LzrksHA+Q07z7dObzFCvh2AMANClFSYPT9ym0g3
	ge6Q1NT1OO3lgn1u3kk2njZwdIjRnyYiNHAaX3hJFQlwKrhshG640r0H2rejGk5nOGYuYWPAguX
	hsxi3PUv8SvQtmWeJ37TWvZiWbFjMrFvLsYzQ==
X-Google-Smtp-Source: AGHT+IFS93qS/EyttjvMCb+kr4LbAePjRP74pKE3/2WrflzzZzY5xDcZndRb1DRoC87vvmKLg3uIXeRUlu138v0qV4I=
X-Received: by 2002:a05:6214:c22:b0:706:ea6d:e161 with SMTP id
 6a1803df08f44-707007167e0mr87858626d6.32.1753366175902; Thu, 24 Jul 2025
 07:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626134158.3385080-1-glider@google.com> <20250626134158.3385080-5-glider@google.com>
 <CACT4Y+aqcDyxkBE5JaFFNGP_UjBfwwx-Wj3EONnHdhadTGYdDw@mail.gmail.com>
In-Reply-To: <CACT4Y+aqcDyxkBE5JaFFNGP_UjBfwwx-Wj3EONnHdhadTGYdDw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 24 Jul 2025 16:08:58 +0200
X-Gm-Features: Ac12FXwxdn9n_fsgy-sBaQApTVNHpsQuZ09bYLlik0nb09t323N91TFtaqoJ4HA
Message-ID: <CAG_fn=VBdzEAUHDSOfV4rTKrw6+fdtrAz-mxQwpYxdicUzGoVQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] kcov: factor out struct kcov_state
To: Dmitry Vyukov <dvyukov@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

> > -       /* Buffer for coverage collection: */
> > -       void                            *kcov_area;
> > +       /* kcov buffer state for this task. */
>
> For consistency: s/kcov/KCOV/
Ack


> >         if (data->saved_kcov) {
> > -               kcov_start(t, data->saved_kcov, data->saved_size,
> > -                          data->saved_area, data->saved_mode,
> > -                          data->saved_sequence);
> > -               data->saved_mode = 0;
> > -               data->saved_size = 0;
> > -               data->saved_area = NULL;
> > -               data->saved_sequence = 0;
> > +               kcov_start(t, data->saved_kcov, t->kcov_mode,
>
> We used to pass data->saved_mode, now we pass t->kcov_mode.
> Are they the same here? This makes me a bit nervous.

Thanks for noticing! I'll fix this one in v3.



> > -       kcov_start(t, kcov, size, area, mode, sequence);
> > +       kcov_start(t, kcov, t->kcov_mode, &state);
>
> We used to pass kcov->mode here, now it's t->kcov_mode.
> Are they the same here? I would prefer to restore the current version,
> if there is no specific reason to change it.

Ditto.

