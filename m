Return-Path: <linux-kernel+bounces-772570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D34B2944A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AC7168636
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359AC2FE573;
	Sun, 17 Aug 2025 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxrnZHJG"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFA29D26E;
	Sun, 17 Aug 2025 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755449466; cv=none; b=OTVcHcllcyUuydL5dpaX6BavmFP0kbBDoC1fr97eS91SkqOL8FlnQT5UzemcPA8RQt+yJi9keO2f3rOYa0ZjMtQ6OR7Jr6awVWh08cTbChXrg138ZlW7ybDCJ9/i5BYBHUOOA6xWznHe30zHm1V6aoyouHYMtUm7PJidNO4mDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755449466; c=relaxed/simple;
	bh=2Torhm8j/fnoxbwE+NWjhqTB3RZLtvgEDzOeSV7FLLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiCwOlsfo3d1LtFGW3BZDobo5NO3L5DS2u/a4iajwPM4X1d0SvEW9utVs8TysGKkUw0Bi6q+p7MQoJ0KxMxyjTTirT50w/GK0q7Ekftw6dlmtoU7mYkNF9tos6xszHwNipB6CdX41gL3dTZuGy2STkMfmvL4nS9G4YkIS+5vj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxrnZHJG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47173edabaso729702a12.1;
        Sun, 17 Aug 2025 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755449463; x=1756054263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k6KmSFypZBY0dtNH22itZ8Soth98wtIKSS3XFXDnQQ=;
        b=bxrnZHJGDPP/UNA4Z4QPtxJZXgjbRLHkq3x/fnIx2+a8FYHPgm/0jyYF4fkAyWi/jd
         7tMPjsAgjxXc/T3GitACFR1losDPcHorXQOJS9f5WJX2kGo93CZjpiJhFxfMwCeEpMpm
         k1doi7kkL4CIg9VtJd2wOSWRchvssH8wmBBkTJR3rcuoxJ4nIAB9/piYW9K/qdKBRZvn
         16sT6vNt/G+AKI44dmQL6qHWHo/F4/U/HSJLfL59iHi9BxZE8sY9Kc0JeJnzjwWIZjlT
         eT9JzkZkZ4h9clqIRXNvo777w4NSitF/1xXQ0Xc5f9LIrqIX7IjOCxwcFxCuFcth/Ke9
         FmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755449463; x=1756054263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k6KmSFypZBY0dtNH22itZ8Soth98wtIKSS3XFXDnQQ=;
        b=fgEfEPqKhhnK0WLXr3KuZ8rIRvsh6BhD99Q2vvYJkxvy7Y2YLMkNAB44CZPwS9yDJ0
         koluFXtZXja767lX8hilR8ovEHOxZY0ZXifv15sAPU/EMqIPfwdm2PIEzyhCfSGSMS/3
         RPhDCnev5Va1ZU7S/ycWxBhsNTNbFrBqUL4bTGMdYTce+84pVDOtM2oO6xkygspMdNQx
         qPvFumR3X10QRtCSyJRauu7Cfg9jOmANh9QURXdnQdTqbK/adE1IFjIcRIDFsGuMBPiO
         BIOyV8rGtHYQrG4IXUEO3i550PUVtRvzN5uYSDytGYFYvFoeC0cKh2FzuEb0/+AsEmo6
         9rng==
X-Forwarded-Encrypted: i=1; AJvYcCVfahqmaNR0ZJxSWLQ2nUBoPjVQY7ggc5on4UeMWp59pPfVf+thuU5vizBI9X6gDBCkW3qP2cNqupsn8XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFv7Z4Qx5EdKoQTqsCxlNks1qUColLwY0bMIj6A9MWZgBOQa0I
	A2c4uUQ6KAVtcT1xvRbBBKcwRnkXifG/aVw7kHgkOItqOdbDybJlTSACZ1zrlxwbi2DxurkDQQW
	Ryub9NkBbZINNNty2FjL05fKP+QqiHMw=
X-Gm-Gg: ASbGncvsYGiJgmhHxHc81WbWvzgNQ4kd3A8ttkmEUr7+4gpG20UOMmYWlU5lUw2a2D8
	DGRhxqxtv5tFx+Zzz2btEwFoRtQ6ovtva2nSTsuuJ1Tq4iTws8KKWbpExVLJSkzTGch2xGRCDCL
	DdoVnS3agbABtdnJA9/gLp7Xn0jmfDcq4KD9bxdcDwUGLEcQjZbyyqdxGjItR2AcYX3q9+ru4DS
	bsML4Ev
X-Google-Smtp-Source: AGHT+IHvPO86iKSOAT6sEgZ8UuwY5f1lQR549Xduu5efy+Zyn7wz0cQTBTPT2Fcj5wIilQpeTgfbk9tVnrcZdOsMYhk=
X-Received: by 2002:a17:902:c40a:b0:240:764e:afab with SMTP id
 d9443c01a7336-2446d8c5734mr66210215ad.6.1755449462640; Sun, 17 Aug 2025
 09:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720094838.29530-1-work@onurozkan.dev> <20250720094838.29530-2-work@onurozkan.dev>
In-Reply-To: <20250720094838.29530-2-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 17 Aug 2025 18:50:51 +0200
X-Gm-Features: Ac12FXyPxlxZqF2l582qQyry0jz0PDhTOBsNJIRcPGSp62_ToacKTsNnDreLjNg
Message-ID: <CANiq72==r0uDobx4vyRe76W+3R0XmZAqk25PCej7DwyOOXn17A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] rust: make `allocator::aligned_size` a `const fn`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 11:49=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
>
> Makes `allocator::aligned_size` a `const fn` to allow
> compile-time evaluation.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

For future reference: we wouldn't be able to enable it as-is without
the unstable feature anyway (which Danilo noticed when applied his
version of this) -- if it is needed in the future, the patch is at:

    https://lore.kernel.org/all/CANiq72mUXy6AYkwCW_kO3ikjNBc5pLzXw0+fXFGmYu=
m0tGmw1g@mail.gmail.com/

Cheers,
Miguel

