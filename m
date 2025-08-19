Return-Path: <linux-kernel+bounces-775867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717A2B2C5E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AE63B1608
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF393375CF;
	Tue, 19 Aug 2025 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPkryIrq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468493043C3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610655; cv=none; b=Z5ymchbaS+2GhB7d/xBKIdIDaJd+C0iwAqaLxzqZFowNiV1JkMAVLXTTfe0CguBEe28pfOvokz9D6jU0yY9QpC/zem/j1HthnYQjiT67qdHX5qm+iHKHlfuTPW9GG2OmgyYVwZ5pfUipfnkxTo8PXyKSHeO4xohgbG8Ogj3HLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610655; c=relaxed/simple;
	bh=VJN8sCq3yWI1c/4665GcphrvF6K+D+HHfT0qHO2ZB3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWE51KejQRDpl9IIfK0UyHW1ly10v7G8ADBcNMk7tio3Z8eKaowLEEY0V8SoG2EjYzipIje6k6bmSpjX2KkeEhNjC2/s9LE4jaokUp6ichpOmxupx8say559u8lzspBWD5lI3j9F6x8InHjwKDMrIqgdcYGbDMqxHkaaYvQceSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPkryIrq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445813f6d1so8642235ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755610652; x=1756215452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEWylejTfyoFIl/6mWqtkY4bMU4DjpXi3DO9RKDyQas=;
        b=UPkryIrqMlreTMHr2f+GqNVZ5aMyreZPUZ7LuAOWFdzy/vUXjANFGbKw3Hf0+Ru91U
         8ZQNnORvXZxhyZhqrFzp1iFZd5bSCErPIXt3H8OSniAuKnv4CpoATBcOAbuDJ8PyWNFO
         LWAaISsfWQBRU96GaJAjJcTm0pFhJesB6XYSmleDPUtLJk+93WZvUtD6HdbmdLy7ckAB
         UmEPVBFWjpj9KUncN0+Z7hbahcdWNBl786tSJaAMqUcFvEtswil49rF5fSdbsEpM7GRS
         prA60rtkiT731aJAdZe4o0U1O7F77XqpuBgHPhmGR65TMeTfJLACKP759O7BOJ3/7K04
         augw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610652; x=1756215452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEWylejTfyoFIl/6mWqtkY4bMU4DjpXi3DO9RKDyQas=;
        b=VB1Y4Szq2tlpnmtUeLizzqJKWBb6EspyyjK2UQgoB6Td5ez57/5ejSLv+sQhcsdmC0
         qpp7Ryp+woqeGBKCZeJZRmfxiuORS+WRIkv5UyEeH4U2ApJXornM5IBOq/ubOI2BuJ8q
         AsXBU8dCOB0e3KidTh+V8x6UWpbvmmIPFVDRHl2PkbVeupTzfMf7CEn0PELpIvZsmyB/
         oTiXV1HKxw9zsvKP8Auz1vL++Lpyqf0mY0aKuT7ipPAeNz48wnnojPUiwBiPqTg6QNbF
         iyrzgHiyXiQbP3HtkUC3DnAkXToaJNrZFOVGTmSye38UGr3icGqSm7jLhJLumTIRITu2
         xmMw==
X-Forwarded-Encrypted: i=1; AJvYcCWwvB1SVsrgt53/13n38uAhOPXcQ0Qa8CD+XtCU4b925Y+8+/1jHSdUWSA46xB4MFArQehUDb14uYiX0os=@vger.kernel.org
X-Gm-Message-State: AOJu0YwElJ3np8+OHbap+KJcJJi+VDEA5vEqY9/EQ6G4N0BlFzu37WH5
	dEuvqa4RzAWYgBtOfS2aryIRuTBxiLj0B+LQaDSb3eF+53epGBAya+uzaUCA23/iFZYOeE+4Kqs
	57fKX/6/59c9kCm3Zx9w2Q1Rx3hxBN28bV+OSfmI=
X-Gm-Gg: ASbGnctvnTxbEKVXzD43VPY6uji9D0jXCl3b1S2ishvTLa3eyHGRslFZ0z+eVGhTWeY
	GJ94EGSvW1MY5JkjSC9YfTQyujIXaUtP5RoYjwzJkh5lyMHAazpvuzPPUn82kHbQWP324QRnY2a
	0t6IrGXaIbyRyHlclbbe3w1GQJrcBm65/QWMzPbAImaOI1PgFn39l+wmfrUl3BUJDYW7+/vqfon
	ZsgfMSAOm/+MobR0EU=
X-Google-Smtp-Source: AGHT+IHJOpOXDBBx/VloKT/n+f83WDVGL36MHgqjWtbLOklQMJaPl9qFQ+0e1b06z7AdNtt8zLX3ksapZ1+AxuNYiFQ=
X-Received: by 2002:a17:902:f295:b0:23f:fd0e:e5c0 with SMTP id
 d9443c01a7336-245e059a1f8mr11648175ad.9.1755610652379; Tue, 19 Aug 2025
 06:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819131330.153128-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250819131330.153128-1-liaoyuanhong@vivo.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 Aug 2025 15:37:20 +0200
X-Gm-Features: Ac12FXyKe_fZuPVJm6A-hGDSWmFdFMqwpfPJkHV9L4YUetLo9-gM_PiV4yLmIio
Message-ID: <CANiq72nNnz5esQpGFsENUm4cgGOAkkkqCuHyNxfEPHUrFvaH8g@mail.gmail.com>
Subject: Re: [PATCH] lib/vsprintf: remove redundant header files
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>, 
	Sergio Perez Gonzalez <sperezglz@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 3:13=E2=80=AFPM Liao Yuanhong <liaoyuanhong@vivo.co=
m> wrote:
>
> The header file <linux/stdarg.h> is already included on line 6. Remove th=
e
> redundant include.
>
> Fixes: 0dec7201788b9 ("sprintf.h requires stdarg.h")

I don't think this fixes that commit -- `stdarg.h` was not there back then.

Instead, this commit

    be06b53d3af0 ("lib/vsprintf: include stdarg.h from sprintf.h to
provide va_list")

also added the line, and I assume Stephen only needs to drop one of
the lines in this merge resolution next time:

    3f413b9a3770 ("Merge branch 'next' of
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git")

Thanks!

Cheers,
Miguel

