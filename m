Return-Path: <linux-kernel+bounces-751063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4549DB164D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45051AA2DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E44F2DEA99;
	Wed, 30 Jul 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nASWSufm"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075817CA17;
	Wed, 30 Jul 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893542; cv=none; b=uienYu8PY8L+0IVPUgbnuflNQwrZSCuRRu4SETb1yY9vdPi1r5YpfMbyrPgy10Lsqq9GPqZaFpXg2iJ/lYzIH+dUJE2e2H2eTbsSEml183knQTxE1KLmiCM1i1xslaWISak5Rfk4b4+ijzMnDb40LuH4mUuh3fEoOUffLNb+e6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893542; c=relaxed/simple;
	bh=RC9xFI8XopPgr8+zR7FWv7fql5HY3Ezhn4V1VGJnTl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwuIa26hrJT6r4JrVZii9A45OWsfxsr4zq1ld4o+BB/30mAfdhVD3A9RAmarkwTRI+4ZYs3f9mwgnBbtNVKRfIHkbCCvPXVYItg/8wv+rBZmRbdslTxbosvYxaiD729mDXSjAPNaYu63+6i0qeRvoMnnWP+JOvHLp77en9nMUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nASWSufm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23fd901c4d2so114285ad.0;
        Wed, 30 Jul 2025 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753893541; x=1754498341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC9xFI8XopPgr8+zR7FWv7fql5HY3Ezhn4V1VGJnTl8=;
        b=nASWSufmXF2XsPGGSddxyhhGfgBlYLg3uA8BvNcq1rcdrbWE1BMfvirN6mlPzVDoJH
         giauZQOstwrn6yY0AWbMg3u+p3mWrSvpvCxm80pvOVtFes/lImlixvknB+SYw4juqM6e
         sB1yWzoeX1AIcR6RAOc4SmR67HkHeZ0w8m7ttLf3ZWa9bUtNwKkr9pRWoCpB3SO+fX2g
         GtYZdhBS352llVlJyJgHxZ5hUG/P6BVBzVCn7OiFg6cXJ/ESPi3TVRulVTTIMeZEcMng
         ZqekEdxSCDL+zEweuw59T5CZdMc3EELDwYg/wA/owQC+HmzzIcV69yGqoQrfC+TTYgZd
         eU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893541; x=1754498341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC9xFI8XopPgr8+zR7FWv7fql5HY3Ezhn4V1VGJnTl8=;
        b=gY2scnrbVcmBCiJLqC6TO3rlT3u2JKIKXU/cD4/BG7v9zBBXeoS9EhTien9yirhYen
         p+CZXOZTtjOZ8TgRLkItWfJmyhlzWHeFN7sd8gplTfNblWmfU0Pk5Uyro6ZXCoMraEK+
         jznE+G6vhEyf+WE2IfVjTxbm/hVafqvKzZhJSfmAv0TCe1Fj6gTiCGzO724tfC8aGzgW
         6ts/ZfeMBFmvOj067d8a8atKqw2TlGeXXeI6whvNlVG8ry9Hs2YcpCe8a5IIgPmRvWAC
         lgWm0qtPZbIvVdxfwP/YqOeilkcYKKlIiZ6k/JOGZEPCCCbyKo0fpVpvfmGJcRJuiLp3
         L9aw==
X-Forwarded-Encrypted: i=1; AJvYcCX3J9LVowYXAxpAkqQpMS25cIOxzd+3pLhnmdQ/eWtIIkJ1HuB5JNDo4MJfAcg4RB+6kp4W/IcsWvmZpCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFvFwJ+PBfMZY2ASSBc8WEDS5cMz1IfoCrogdq9LoisICS6R6
	1hIYzWfd5NRwd2GS5R/6rJ3I9ttDL8aMidZLQMcplFf4z/wnUm6HhXfVNfANBOCCDjixzNWb7Kn
	9u87WoadSBQfwhVBYhp1ta5/B2cuplRg=
X-Gm-Gg: ASbGncvtQMgyOuRSGlVDOW03Im2Ww2UmAxzdfXyWbisTng1BUwtp1xO3GqLUFW5tT7+
	dlxWm1OYDZjDtIqttkEGpocbswFAMIkkP8ClIfR6YACN9I8tV9I35UNU6ToAzCwku3VNT2FiKJK
	9dSSNy2eXslNGInG3x8bu6OETTa+yNQsfKbFcsleZnokDbKfZ5JArsy4u03dFc0Eugiph0LhE4T
	ca6NBPW
X-Google-Smtp-Source: AGHT+IG+O29qwdh1a5SD7QYz6J9Zm1C/HF6QJcj3Zzc4n0osQsqpemTwgfOKeA19rPcVr+oTkTKYamKH/bXNHF0pm+s=
X-Received: by 2002:a17:902:9f90:b0:23f:fd0e:e5c0 with SMTP id
 d9443c01a7336-24096b31fbcmr18626705ad.9.1753893540567; Wed, 30 Jul 2025
 09:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730163439.50753-1-boqun.feng@gmail.com>
In-Reply-To: <20250730163439.50753-1-boqun.feng@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Jul 2025 18:38:46 +0200
X-Gm-Features: Ac12FXxPPYGdC01qZY8eirhybN4tcPE72DrHd87TACpl_mHGDNq_8_7DEVzTmH0
Message-ID: <CANiq72ntUsB-a3Btf+PwmezqN919FmL_P3g589mVJm+-_h2CcA@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: workqueue: Add an example for try_spawn()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Alban Kurti <kurti@invicto.ai>, 
	Joel Fernandes <joelagnelf@nvidia.com>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 6:34=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Miguel, Alice and Tejun, while I'm at it, should we also rename the
> function to `spawn()` because of the motivation mentioned here [1]?

Sounds good to me.

Cheers,
Miguel

