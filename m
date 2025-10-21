Return-Path: <linux-kernel+bounces-863465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3BABF7E76
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA8189C2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF9F2F39C7;
	Tue, 21 Oct 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9rmBTBF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398115A86D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067727; cv=none; b=feYYJf3Mpu2LwirZx+k/LUQdZxeKz/SnQzr3K6vqC01uhKNf/sxaj9AWFwWOqRQijn66dtuzw9ukzMyBzJb8aYc1sfBWmWa3nZC5ICBgUAFznfBh5/ZgnUJcOEONCwzm/ZOyS0ltCHRY0XbTL/QR848dwywEAQbkkJhm2mVxy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067727; c=relaxed/simple;
	bh=sIvt0VE6pDtBysMBb+7V61rpjoqPHiE6K3Jjom9GL2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAo9iBtXh6nf/Xy2UUDlWMS/z3owN12E1KXJN+mVU/EHep97ES3AIuEylkOnQ8lMpWkF/hb2OeqnikHhhHf6HyPsh+SaUkgQ9p4iQVmNyrq9XuGQ+jnBZCOHTHJLAyMATnn4eFQ7LsFq7MXFkfSbsQVcRNH2WT6l7yPS9PH30dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V9rmBTBF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47117e75258so27352775e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761067723; x=1761672523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIvt0VE6pDtBysMBb+7V61rpjoqPHiE6K3Jjom9GL2o=;
        b=V9rmBTBFgMwOsCzcx6hkbvE2wahV/njmQDiOLRSyhHmv/qf3k1QWTg9n+TfgZzK7zz
         0EM24Nyk7FGkqcwzck1f3KIe23n835LozMEOzjarEAk6oT1BIXKbCpZwhT/5x3O8GX6W
         VbTaVgCquJLUlLYgmwJf3V38kl1/ZbAi1J91Zn9rZG1Up2G7gI5GJHz6T9WNxGFNwKOb
         cVaGPmd+y8r+4hokpMPSmSg51Cgl4Rgad4TihmVc6QO8BbcWz31uyLbyNnVrcUrJbYXf
         gEpqRqplISLivjFYioCGagtzQ3r76PWFIO7PkeyORk6cavR8nbSigJT7iVWjKEpoy16f
         snHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067723; x=1761672523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIvt0VE6pDtBysMBb+7V61rpjoqPHiE6K3Jjom9GL2o=;
        b=Yw+zrFKUzIbpcMu1t93i4DFh9xxdu3Il37pAKvizapPzj+mTZCbrm0kzDptWGMjSTY
         BabPNMKE0DHgHnovxKW8wWwyI0zgGl7zIeMIrFL/wjxW+guGqoedjgnbixOH9pS+QmMB
         P2SVUgp8ZWG9h2vgiY7tIOs0fRBhC2Q8CZMABF4M8wcH+9aXH+bl7XN4oiFXHbYBPAw5
         OgIrdTMaXBXlFuhruLojtIpKXddonZbJdLAHKEYpD6UdAJWiQQkVbI8hQ2N0aQU5Sw3J
         T4wglXNlvxqOuwx08s9xmCOty+Q68w6yFObgsQFxQGXD9gFXYsdOeYJRvQs52Kcx7AkV
         TH7w==
X-Forwarded-Encrypted: i=1; AJvYcCXCIYRKURc0371uNNq2sTW7HXh5h7dWTfsdrYj/UqrChbs6KFoHqBpqQsN/bHN5uqrbuQbgbENaS+fClP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEmVUFwfCsOBLOs41ckQhkFCsz1WEd0XiHOG/jDKONvRTLxZ3
	WMvQSGf+5SNRvo6b7NXjC0I442vspkjO5dJD2PuMG7Sw9R1Hep96ZcCVw9UKr9jLxfguFkEoTb6
	TPJAwniPgZuvl4Ys9xVfHdJlRODtXeBKT4culJy0m
X-Gm-Gg: ASbGncubTstBXHSJvlp2UG2/EHhzCNAVjzuvpBGAxJY4/D7SGYRH3tTB+2A2/4GwIW6
	FXMxQF07NU+wPzgAwyWg/Wm+rWPJAgGmL/nZlFJIUR4wWoeAIS/6R+Od3k9p/+CckSV4d+XJUj2
	mJZ/KEwSHg9oVoBXjAPTObLLxmrcGwL+YBH8ApS9ziTMDzVezt+OvjKEymYPunWIWrJR74+fxm4
	Sza6u3dSeG/yfs+VuFH8u4uW0qJhIox8SvH8cAx8QOv0zz/l0V4CZei2Zt6zJIs+6GfStDnkZJC
	i+v5c9E=
X-Google-Smtp-Source: AGHT+IEL8TSxmx+ByEqq5v/d3QwgwT+yuicIxnSrNoU89up9h0ClDt25qfzL+RROhLL5BGgQE8K9DsiKX1F8eaxX3sU=
X-Received: by 2002:a05:6000:2089:b0:427:608:c660 with SMTP id
 ffacd0b85a97d-4270608c8b7mr11588746f8f.59.1761067723329; Tue, 21 Oct 2025
 10:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021172220.252558-1-lyude@redhat.com>
In-Reply-To: <20251021172220.252558-1-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 21 Oct 2025 19:28:30 +0200
X-Gm-Features: AS18NWDyAysQ4Z6TjDjvO3tfSPAMTRUY6vagZwaabzt8xQyZFFpYe2ktJ7q2CKk
Message-ID: <CAH5fLgjXF2D+498Y2-ayjmNJrQEc3iGDPSQUjinPE6GdWmiWFQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: drm/gem: Remove Object.dev
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Shankari Anand <shankari.ak0208@gmail.com>, Asahi Lina <lina+kernel@asahilina.net>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:22=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> I noticed by chance that there's actually already a pointer to this in
> struct drm_gem_object. So, no use in carrying this around!
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

