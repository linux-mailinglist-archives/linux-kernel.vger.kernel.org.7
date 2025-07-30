Return-Path: <linux-kernel+bounces-750635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FB5B15F08
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D48116230F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5B8296161;
	Wed, 30 Jul 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBIxWF2e"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3633A208CA;
	Wed, 30 Jul 2025 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873314; cv=none; b=gTjnZleLsNFOvzuMumbP4e2ENzv0WLPL03sUtsx2kZEjBSzGTLXV598/quTOBBLbNWvkuyxumSruTzeDbfgs5RyjhsTRnrbrZsdrOaODJO1ScnV1fErY/g0nmJAoQgQgAAEXNc81mYOu+9IwEZdzZqlilmx4Vb3rZ/Mk29UWncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873314; c=relaxed/simple;
	bh=AswIdtvJxUluZ7da+hgSOdHCTLNeM79Q45Q6XlIz4QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SK2qWvltuvWbfhBrIMOQe+RU4laoKyiz3WPOEVCvcfT2GInWToiaEpOsdMpWeu2HdlK5XhHC6MNX/q6nVrdEbphWofxJqtN6rHBR/Y1sla8mQGvMC7kUPR64do01B7axxYVCXWZl6ROPH+t5fdcytllBLTFiITYNxWgzQmiwNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBIxWF2e; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2400b3008e8so3870425ad.3;
        Wed, 30 Jul 2025 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753873312; x=1754478112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AswIdtvJxUluZ7da+hgSOdHCTLNeM79Q45Q6XlIz4QU=;
        b=jBIxWF2ezA7/XOYvYhx2FR+2xUTxnf5v65i1TjCXv5lam0N2hlh7Qru6MaH0h8p631
         NjeQFHmRIpLA2jsMHB6G9JBqwpecGYBwVAECEZ9JzkjpQCEIdq4kuqzncml00HFvEp60
         em6H4mZyoyfegn09BEZkjesaky1wTNpNfaqDnlx2NDWf+LsBRFHSV2bMzFROKzfXiE3d
         b3gamVPqxltkKEIatCkemgwQJoOxbRELwG0PFKE+FWgmsY6COcBNoE90Zuoqu4wcIDna
         aBRhRxr4sH7QNLrcsbyaacabLKU1NLFCEm3rS0kuNX3IgU4YHl5NcSQ/qCvwthwE1YnA
         GTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753873312; x=1754478112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AswIdtvJxUluZ7da+hgSOdHCTLNeM79Q45Q6XlIz4QU=;
        b=onqx9PMraHvXwAIwg0QwopwWNUaYVfB5JqraC3GK2hu+fwaZlqFNbvotUB1CQtowG7
         CUsujmLz2jC701Y3ykjLrY5v5QGch9/aPjBmp7x8NHyqUhW4U96eZaoJ3tLu4hzVSdH3
         x8+V8Oz1I++Ec6VOxAfssPfaoIKBurX/wNua5OKJdYTgaAgNb1mWvLIW/ZzeNeGL2gm0
         bUFBRnc81IHaXH6dSlPHKwih+0tgPExiGHuLrrNujvPznAhOd5SfLYF6u/mLPkjcPT1y
         rZmSsdtwOEGt9KK84kg+XMWJ2GJcCxfYgkuz/4Kh0seSRYW0CC9uXlCn8evDRRkL9+3s
         4HiA==
X-Forwarded-Encrypted: i=1; AJvYcCXY+9F2/jUFcNR4/j1i0LGQ+nyvawUaXfD2gayvNK5QsbbEVFM/Dte4wWkUOwIak4Gx/IdQymvO8YukWiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVzehYXNxS3OUAmgxk/qk3ziTH6OhpJA0MSdHVio52w1r3vy/p
	UO33tQQdRh4nN3rByWB5vUgcAxHnUy9LqhUTU27jIVUrhm9zfoTC5Pg1067rJA4kh4VrVvhJKRC
	z5RG3Tit16CxUZikvH/ODHB7ijuu+lcc=
X-Gm-Gg: ASbGncsMXy/fwulr5S9BS5L1KbNXYuJY01cotO6Jw5IVU7LwL+yb1drrGydRLByAGK4
	IqXIZ6iBiUffa3PLzhYz0U8WjlkXT9YyQrO/ariNZ6Cvh1OUmNBCUKLuroYS9XhHF/HXHaZty8U
	JiR61QHqw5FAQRfVSPirKiekV4rFCYb2kW9ZMqLCj3eoSchYGX4F/VN7cwCqimOyK9V42ePBU0Z
	wgcyd9E
X-Google-Smtp-Source: AGHT+IFcXkHZcOOJk+vlHnVT6J0/9laJ0SyHq/VnDphD/gEXxFATsIM0KCrAn8izb6DdrUnY4kzwFlHrmaJr7alDUE0=
X-Received: by 2002:a17:902:ab8f:b0:240:711f:2068 with SMTP id
 d9443c01a7336-24096b0c975mr13303255ad.7.1753873312332; Wed, 30 Jul 2025
 04:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729143600.5305-1-work@onurozkan.dev> <CANiq72=L_ov+Dc5S=adPdson9gq6wGp4xp=iCZLBnz+YC1_vgw@mail.gmail.com>
 <20250730130030.12d03ca6@nimda.home>
In-Reply-To: <20250730130030.12d03ca6@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Jul 2025 13:01:40 +0200
X-Gm-Features: Ac12FXxEHE3aLm23pbqneQjcrKIrfKzuo0xdHTtigtpN1HeEtXGB-YGeMohuWi4
Message-ID: <CANiq72=xCYA7z7_rxpzzKkkhJs6m7L_xEaLMuArVn3ZAcyeHdA@mail.gmail.com>
Subject: Re: [PATCH v1] rust: update `error.rs` documentation
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, me@kloenk.dev, felipe_life@live.com, 
	abdiel.janulgue@gmail.com, dirk.behme@de.bosch.com, daniel@sedlak.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 12:00=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
>
> I thought with that approach the documentation can become outdated
> again at some point, but I can still do it and send over v2 if you
> would prefer.

That is fine -- documentation is never perfect, but it is all about
the chance of being outdated/wrong vs. the benefits.

In this case, I think the files getting renamed and this line not
getting updated is low (and it would be still clear), and we can
eventually check if the files exist on generation.

Cheers,
Miguel

