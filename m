Return-Path: <linux-kernel+bounces-737409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E247B0AC2B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DE85A3D85
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9092222C2;
	Fri, 18 Jul 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drwHisHW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF9221FB8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877679; cv=none; b=KF8FfMluYjJrsK+d4Hd++j6lwJFDqFJxYjV1ZaMbYFknFUEd62FQJZ8KEHHEGSuUtm/tOZKHUjkmNgh3BfL1b+WKD3fuXHQiTsF6U1ONQ36BuZZaBESOarGVW0o63rkP5xdRQSpNJ/p5a5bFz375Di9gBDIn7QYa1mIyfnNYyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877679; c=relaxed/simple;
	bh=E1v55rPKtjz9hx3BK0xpzSGhP6ruk37WnTbWQ+EsvKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6J8k93WAn0XmKb6+Vl6nT00LFThVL7/B1EM4GfzcTamvUA91P/iHVRFRMfcB1k1WcwlKZkyRVKKBWqkAAGB7SzGXD3N6uP6SWp3/gIZfyT+kO4PhV+tldrE+B8jCE6Y2RxMgUziQaye2rkwdWaNljAFbVhoV9ekEgliRQaXr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drwHisHW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2357c61cda7so22355ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752877677; x=1753482477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDZ6HnS0PAr5DvEoQkLOyUrwIZTop7EVRhZ5TEimINQ=;
        b=drwHisHW1W3e0pPFZOvx/KET5mGKYwf+T9TAUZyWqN76JK91bkWJCCdkYWPCEWeffE
         CFEb/k4Nutokdy+s1jN2li+LupWSxyvr0fCsYufIlxbgbfYBFESrIleHBM2Vg1hqgQdT
         Azna/Q0m7GgbfrtWfhjoXGQK3A4+yjiY69b2d7CInE5LI+89o01QiDB4vvgmjUjgvnIi
         eQ/savPknAH92z+ET6trz3e50ENO24e2xsbrDjn6EV4bzRNXjoxJ4s2AcFQVN5oNu//z
         en4pIyLEnUthfXogUixxL9OFYvlGKC9mKGRBkTaxCBzRMmkfeXnM0tFGvqEkwFagpP1B
         l3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752877677; x=1753482477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDZ6HnS0PAr5DvEoQkLOyUrwIZTop7EVRhZ5TEimINQ=;
        b=AEKBu7RzaxsI+djMyXRhCdR+cZ67joW/ZN/Qb2mNldl1VvSNtJOmCMy8LBdnq0oLzL
         Q91eqjGr1Ls3sx9zN+K/UvAjtszIl9bvOhiX9C2NeOfZgdFxcqtANsQaLBTJ33oemEWx
         1oGz5u+SnLn4joPaVJrF1fV7kJeORWJsfegPjSt1qJWBt58TH9crW993m3YpIchXbGS2
         brNQchJMok6XDuJ8nuVWum8stSha/rio5D61QEyn+0/eaGp8g5Yym/v4mf7+iQshDvym
         Cy3OFeMiDSyaWf/QFy/cPgsxBYzf00jwompsE/FwWcYgQ6L0TbZO1mcS1s5bAdhJ2jkm
         JlGw==
X-Forwarded-Encrypted: i=1; AJvYcCVLOMEzCJlWGPxnMHN29t3J7combP3VtIVkgwyFDwnnC4cJlZtIlGVUsLdTutztnZlk4VMc9BZpsW3eqnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKzQMiM5YqLPKG/2310pwtcxaeWAfXnVfV3ez834mzXYQWNIF
	B7pXiRf1Gdmy3Dgy7FqMg8wgaPWV6aVnTaaAi3Ly/hVxnkZjGBRggrLKMMvQ6m9uhvFvezk0k8X
	WIH1mWQZL6UntLPNPnqD/5b6j+Dw8wlZUNFwVnpPP
X-Gm-Gg: ASbGncvYrsPh3GC5XdIy1hj26wEymFTDmZDtZATiXOaZ9cC5qrudBTtvb5wSiFtLy7f
	KkjFhI1duaPpEfxOhPOL+0Ovuygd6GzvOFR7xSlA3Lz3oXghPToUFhrD0fjgUqV/r0hZG4qe+S/
	nkavCJ68cX2S8zlQ+C5Z1Cqw1lOPvhrEZ+THbJ6hgyUOOsUU866KG47btgKcbQHv4TwCm15RdIQ
	q6cB4qKMDZOMqc=
X-Google-Smtp-Source: AGHT+IG7V9XjEMPYRN0HZe1rxyqCjCUOSBNIjCe8hXo8zZDBXQhRHlxGGxTka1A4GvYQ9cx7K/41qHmPAAiVlpIGtM0=
X-Received: by 2002:a17:902:db0d:b0:234:bca7:2934 with SMTP id
 d9443c01a7336-23f71cf787emr1175965ad.6.1752877676690; Fri, 18 Jul 2025
 15:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715225733.3921432-5-samitolvanen@google.com>
 <20250715225733.3921432-7-samitolvanen@google.com> <aHoyjx1xJJVP6Khz@willie-the-truck>
In-Reply-To: <aHoyjx1xJJVP6Khz@willie-the-truck>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 18 Jul 2025 15:27:19 -0700
X-Gm-Features: Ac12FXwwKL0Jg-_s27NPdE4p_SLAtT8QzoI6ZXv0ypXTyBz9FtBzpH3HXpHdavE
Message-ID: <CABCJKueFYAbLNQCZLxZx9rdi_F+Dif45=5afw3uwBd8VaZuxpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 2/3] cfi: Move BPF CFI types and helpers to
 generic code
To: Will Deacon <will@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Maxwell Bland <mbland@motorola.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:40=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Jul 15, 2025 at 10:57:36PM +0000, Sami Tolvanen wrote:
> >
> > +u32 __weak cfi_get_func_hash(void *func)
> > +{
> > +     u32 hash;
> > +
> > +     if (get_kernel_nofault(hash, func - cfi_get_offset()))
> > +             return 0;
> > +
> > +     return hash;
> > +}
>
> Do you really need the '__weak' function definition here, or could you
> use an '#ifndef cfi_get_func_hash' guard, a bit like you're doing for
> cfi_get_offset()?

Good point, it's not really necessary. I'll move this behind a guard instea=
d.

Sami

