Return-Path: <linux-kernel+bounces-794857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19280B3E823
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AE13AC538
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AAE341673;
	Mon,  1 Sep 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Stosj4/A"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D4321F26
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738975; cv=none; b=HlK+GmsTojVlN7arewYTggh35h5JFDYWfB7TiTM4OG7Ed7lmS/PnXStN+ZhA6g4HagXNV0XW/IZ6dJ0kmWg6U0qJRb/9gtRdOXrFaKNi7CeKvKMlfeoM9B9qisxeLgbtQVkXQfXjIrUARfkx0vmUFkL7GSeZ7grYE2/DqNYfqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738975; c=relaxed/simple;
	bh=VGz5s3CgG5oZbwfB15yu/ysF7dSGyM9kka20nq6+kjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqH3inlJoFHgH+UELLcpwRjr8WrCChdjsuaJ82uy3PpNVHy++5EfcUxjfwi6qCjfkpGBnDb/Fr3d4T0AveL+OJ0MTR+/jjniHUf879UYxnVoTlSNiARfK4uzj8XumuZc4EzWfKYjFD0XF29P9OKjPN9RSMlTkbsnJ4nZkExCgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Stosj4/A; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b042ec947e4so164421666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756738973; x=1757343773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGz5s3CgG5oZbwfB15yu/ysF7dSGyM9kka20nq6+kjg=;
        b=Stosj4/Aq8oxFTo/ihuTjbA+4h14ygVQT2Vf3seTTjcfK1EGSTxLiJycvkGy4ZyMoU
         UuJxeAYE9u8W27b33iGd/Bdg8cFCGz/B5skbr9E/lH5WCRebN+rF243H9EE7OUDgc56j
         0o0z/j9f/kqJVKgLaDDaDw9jlvsUczS6Ncjk9alHAju3nvtIU8LVmgCDxE8jjs6jD/2x
         zXolOkwsMN1k5Mb3l0poWo2hHZxLaVzVU8biozCFy9xcOIfHMwbbep6S5ZTEdxSlUELX
         xpE9+65K/5q3c/ZK8xnWhTROPQoG39E189LT9qFoCkqjF0INIDFTs2Ec/R4UEa0NXk15
         C/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756738973; x=1757343773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGz5s3CgG5oZbwfB15yu/ysF7dSGyM9kka20nq6+kjg=;
        b=mjtCbKyVShJfUxQg7r9f16f+vOdI13kmc/FfsNiuBaatNtxOKwkQYY1w5Om/p1j0dE
         WS2gI/6x37e3TunynBNmMVj5Eq8pJ8HWD0WZrAYreC2iuaOKtCefH/93Rx3X7qDjtdGk
         JEybg88px9M9mr6bKZp0M5t2qNQRUOD5a4oup4R2Ax7M+OPKLXGADlGRl40O9b6TmFJa
         mxMfotZk/JE/sKNMuIk+ypwJ2x9dAoY8ioOsTghHjSZmHMSXOTawfdqh4XFehMIbkTwH
         FOl0P0qNA6DnJ25WW33mwNTQnHgW5WnObf9soX/MPzhR7d7HjxMblef1beaytvL1I/e4
         JcRA==
X-Forwarded-Encrypted: i=1; AJvYcCXf7FIaEFLG3xwHFBj+9xpj15Y86JesTvHO4wfE2nOsYtlxZJbnfxazHl/TWoeNzveJVJxcZx3vfGruPv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIoi/y6mOswvnBwpxTvK6472c8BznGtviyP++i1QpWttujS5aT
	w92KBAx8T5SauaN4Z0uq6P46UzJPnzW3zee6rPTeJjXxBGhhLkeCPsKF+Vk6BEn2d5qqWrXJntB
	2WHv9UTIBNsvXPVOF/779tzeBVmfoWaqT3TuBQWluIg==
X-Gm-Gg: ASbGncv8MVLRiIuz+z4gGvTb0z30ABzc90qQVe7BFGC5I41bBgF07BmnQQranC0n/w2
	YG39sBECzoVU6QTtCinmYXG/tCjYm26TTSxvxfCC9Sd+BFbEqAm0S1kCgCxUZPMlQNveJe0BgHU
	yZulcXevRBKpTOJ90bA1A2Vx9RIWlGlnGsXGZs5zNW+a8AmGy6u3H6hpWtIIENwRBd2mOMcDa8V
	HrEUzDKOkwt5qx5CNY80XRy8cjR3UFYWF8=
X-Google-Smtp-Source: AGHT+IFezK1h8zD4ulbO+LoYFx9UJvceg5e5MjfORD1cX6aK9EX6zhmOpTUVOQiq+Ui4qjbP7WefWWIq7O/4+eTMSZU=
X-Received: by 2002:a17:907:3d42:b0:aff:d39:e350 with SMTP id
 a640c23a62f3a-b01d8a25c91mr803197066b.3.1756738972529; Mon, 01 Sep 2025
 08:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com> <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
In-Reply-To: <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:02:41 +0200
X-Gm-Features: Ac12FXwscizWLWhMN1KX5yHTr-lGd0ZaL5gCF07LzPcgk8nWDqkiCbWTaVe_QQY
Message-ID: <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:54=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> > -int vma_is_stack_for_current(struct vm_area_struct *vma);
> > +int vma_is_stack_for_current(const struct vm_area_struct *vma);
>
> Should this also be *const ?

No. These are function protoypes. A "const" on a parameter value
(pointer address, not pointed-to memory) makes no sense on a
prototype.

