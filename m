Return-Path: <linux-kernel+bounces-805645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EECB48BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D2416F57C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE555302741;
	Mon,  8 Sep 2025 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9w507e6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053552FDC44;
	Mon,  8 Sep 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330054; cv=none; b=GtYbxd2GLvhOYmlUPO4AKkBzpmlYMZO2rH52MNZur4SFOW7Q9td5TvQxXzMXuY5/J32EcHwAWakULBoWYh+Sb2ji+ge6Ys7uokDAr2uY/55gvt7TEC5UUhPokyqzM1CRZdnYGOp7JIjfptznSFX2my9zf8Ic8XlKGqLkFIhDVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330054; c=relaxed/simple;
	bh=vMjiWcHUNbfJxreVMyBL4uAcwqDu77zt6UjHnDXiQXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBaiAoidvbMGTGzM23PghMoiQyozck4P0ebgmpVm1nuN1nYXIIJKF7oJqSmRxnR/7CbaVYCp5McLq8tcPEdg6JXtPx7qEXQi+f6ign3jktY6bUtpxYquvCKn0idqugLdHylBJkMPVCLMCu2zPKsAmZgaWXUZJ1N9PKz96HMmZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9w507e6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24c95f20117so11717555ad.3;
        Mon, 08 Sep 2025 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757330052; x=1757934852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMjiWcHUNbfJxreVMyBL4uAcwqDu77zt6UjHnDXiQXc=;
        b=M9w507e68PjF5oAi4eMN5AdPtOAcoxu9o/fxQXQwIYW+OJjn3BbNAN8jz5Ym9s2juq
         EBYldmMwu3S7TlacwrGGP1uQGIJHNZFTyDjpQhMZ12L+wj8lWkae+igdOHxhs8feh7Yn
         rn/MGJF0NMGaHidphl4mfU9x5DwaI+avV5DwviHxSytEPHBwG/zWR1M6iCc7hLHgQ7hJ
         IvK2tk0FDNrYcbKUiYLxTxRizuS3nHCEzyY5HqS9XPgF9zKPJ6Tj39w/8PZaMKHMJP5p
         4Wd3l9VK4lcwrn5Hir1/g+29qWRDsZ6WSfkM4Gx+YH/ZiHQ506wpn05K2eRwKa5sv/28
         o9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757330052; x=1757934852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMjiWcHUNbfJxreVMyBL4uAcwqDu77zt6UjHnDXiQXc=;
        b=g4zu5zr1axw7EP+b0IR1XxGuBvyLARXM9OqKSvSaLjsUJn+0XRkQLOajp/GpWx28Qh
         jcBPu3IkmCRghhR8WfU9lNH0Orb4HkNGRjI4yfpdwxZVgsVrBB2tIzGQQYa7tO8NQHo8
         PPP27ySAs11fysZZyiJnQ/AD8oumdBpgW3cI38SZNfdx/el+Gv611KdqVloB2Paz1mvC
         cdqdXx+UwF8LegFzgDtK96tEGvavLcpesNohA0T7xWX4wGJ6r9e8XfKGIopaS2Mv3/Q9
         hMXneNSBuh6ZWX2S2+RRoa+nyIvH+8kse9EFdUAzREH0cMGG8Umh/A4WYHbgHuzokteZ
         oXwg==
X-Forwarded-Encrypted: i=1; AJvYcCUKuY2Ye8kQ0G53KJtELpWrdXJIpZv7jD2Cs+6Bh42MKg4wuJCnSuJYmEInDvwfJ/n2z6+B542MmY7/W9GzD+8=@vger.kernel.org, AJvYcCXT86mGGAiJyyvyuBSvdg7VHT2zeVL1ZbTHNJhgFa/9oafXo4+9cjswcECeNgI9QFR7LlBtCAKFXiFSF+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2LL8Drk59E5qdIjzVw5x2e5nHJYf5bKZ1ZAZ2Lhm/wbMtPH4
	DM3wbLIMCaGyjyZFhw4Exvzn8jIHkxogG+/JU7HhlaVrlZra7AcemHkk4lqBo6cmfWkINXcNRkC
	2Zd1bkWlikNQ9zysqT2uM1PXZuFczytM=
X-Gm-Gg: ASbGnctxlwHP3bAsOi+1w/Z1H+48U9McE84e/3DaofX4mVgPw2YTMQ9GwhvLp2W3MBv
	GquhfiiNNcHqa+22TvyzY0nEFBZ/jZFS29rDG9LuwGH5wnmCJXcnLNSH6LAZII5BoQEpivYvtFG
	vLndkPKcPPPJjqXwDD/l+NTxgn/5c11KxiUQgZG08Ks8LSQV+vb6NlqPFN/TYAFAIvZlQoidKXI
	N3W4wrMEwmSuovutxoQaZN3xUNp2BEMsc4xfQqsC8vhXRDGjOgzFsceQArQs/LlkMJcfra9kBZJ
	mXunUps/vP1rmieYM1bCRgJykfI4WgcIEO8P
X-Google-Smtp-Source: AGHT+IFQzoTfJOkP2zoOqYl6PEaB35JjktwCO5JvZMpggDA2f5s+cdOsX+9S6nxN0ShdooI9nYkBO68aRsJoUoTkwxw=
X-Received: by 2002:a17:903:24c:b0:24d:f198:7d7a with SMTP id
 d9443c01a7336-25176a22499mr53145375ad.11.1757330052148; Mon, 08 Sep 2025
 04:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com> <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
 <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com> <CAH5fLghyDNd1SSL5uTZpSR-5j3q9=frAa=AgUjvap45b-DuUig@mail.gmail.com>
In-Reply-To: <CAH5fLghyDNd1SSL5uTZpSR-5j3q9=frAa=AgUjvap45b-DuUig@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 13:13:59 +0200
X-Gm-Features: AS18NWAJMKvQYvghiVnRjMpps2Qo6VVcr9cEhKfom_WdgdSBjXoDJM4FM_wyRBU
Message-ID: <CANiq72nRLqNYhph=ZE7B3vH1ufHtQUqkfwu60vwLm-0NGQgW7w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:22=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Do we already have a patch making this refactor for rbtree? I don't
> think I saw one. I can send one if not.

https://lore.kernel.org/rust-for-linux/20250316061429.817126-11-contact@ant=
oniohickey.com/

So Acks or reviews on that would be nice.

(In general, for things we have a "good first issue", it would be best
to get someone new-ish to contribute, perhaps pinging/bumping the
issue if it went unnoticed for a while)

Cheers,
Miguel

