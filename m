Return-Path: <linux-kernel+bounces-786471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64554B35A39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC78E3A584C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5430504F;
	Tue, 26 Aug 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM3nF4Yt"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9376E286D57;
	Tue, 26 Aug 2025 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205048; cv=none; b=cYi77qp/8K+j+g8lA76Lid9CdEdHsfqFNPIR8Pd+05/8jc5MmM8RiXou8T0HCqhFGQLeLw7npiMwON8QXUK/tdDxBo0zjAhhWIonNgSFWHK55wLGrYsUIwy+hwA5f4hdmysf+ZE2ZZppO8W3A8fUv+wCyh8Vqn1H0woILYOWbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205048; c=relaxed/simple;
	bh=D1QmYKNOgsbM1GNzSgrjlJRmNpkG0RThJJ8r/8uG4lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5ysZcEGsa9fJmvwc8lkAFfSxvrCjopdG9x0nZSIDckLXsYPm2b8qywXYTq80ZSAqMbUzztvfwkTlKufqddJzX1y3w3+bmQ6qcKngbWpKrs8rnCOZh78/Qz8WCOej8XLgOo+A4jP7lNysQosaDFT/1PhJ2z+Dv0RB3xoqJzHxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM3nF4Yt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4c27bdc259so258165a12.2;
        Tue, 26 Aug 2025 03:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756205046; x=1756809846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDKS+KolO/eydDQPsO0aMd3COpPar50Oa0wPAykDNNk=;
        b=EM3nF4Ytoaudk6nVgfSKSYzZMBgPfTSWF33oBQLLYEt3/6lY/n7TXHvNcBn31d5va/
         1FkLKrp808ECO3ghEDpGTLggTw2sfyoelESewceU6zI74VULgRS76HKhLF62GkdCVuQZ
         pMA3bZRxyJVo5tdifvYPWf4IBOpz/qC6IR37ilnt8fJK8SH/HIwq6X1Q5CJu2e/OO5vA
         xCMjg8pDgPbXoepiXfRKoPx9DV2zjtNiDjqGOIp0x/9CCM8YpGIatAIJvNkv4ITXjNOM
         /W5atKzJZhvXL4tjXwugAPpVJakEfE4Wnc8PkSaTMxzbBTjzGjTwn7fmRyuLGkgAqcil
         O5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756205046; x=1756809846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDKS+KolO/eydDQPsO0aMd3COpPar50Oa0wPAykDNNk=;
        b=uAeoTzlpE5ajwcFsq2SP9p7hfn/C6tDreGrs5X+BSQwTW+gUPJlQ3VC0oMb5X9HAUM
         6t3Uf2o+FiToj2OfCRxalLznGxT2Io3CoAHM0IdOwJd2K4HQ4a8Qc6ZfiBERMy9OZHvV
         tB9DoGIu7L5w9/Dhuw5qADsL8KEqCT0M7zsnKFbF6/AnCQtHwy6AkCeH2kjegchkU1H7
         mq2oTYclTuW/9WVs4peOyCHQsFESYvc2B+IuysdWXn/JTW13iK3+Sh06CtVlRgcThUvp
         VjpT8+Hhha6Mgs3RDN3MtefugwulP20cvnMtibDz+73MFHIDH33ZbvxoTVUoDQ26lSW3
         UHrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXF1kJmD/5TIjR4wuBhmXNaATQ8bHenUErlPwL/37nbBowujmeDBb9gqUdV5CuEEMzx4GnaK63PGOZpAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQolt1Ww5LIdiPC05VjvbvfDUd3SIUOx6sllMYS5EwlXn9rLw
	9tVGpgq9yGGNthGjkECVCer4ZOns4IuoHYGK1oecGG6OEUK9LRslt7nqy/VAN7r6LcR04kNO35t
	fbQAc0u+qlwtZ4e1tswDsbYq+oYFDowM=
X-Gm-Gg: ASbGncti4XT0qIz2pxCm6ctd1lj1XDEbIJJze1CqR9G5YmvhYxFmm4fAuwhR4bJfWUa
	GdVPyhu9KFHUY+n723WQ/wydoCi3ky9lTlMxERFqPgBD9TsPWK1SvVGCipiPUGovE1DXtGST5C5
	S83ZSAwy6Cu/rJEpQMSCNezsHtxhciJs9X+6zuAMkPCYN5/Nc1UhrZTY2Qkmfyru5Q7Uf6586XF
	V8fT1mqOKIy7boGutzByERE4Xb7X2umHCtXniz/ywrsDZKCH1Np8VuX/ZQZFd+maBnlgKDLgvRY
	DU0s71Ygg0vvVCzomVV7ONSODA==
X-Google-Smtp-Source: AGHT+IHy/EFT4NAQTm/VDalLdL9wyv7Nfx5A+2q25XWbuNpKH+YzA8fCrpu4i2ytIGN/IJVVqj62gC1+2NW2EOHuzos=
X-Received: by 2002:a17:902:d506:b0:246:b1cf:fec2 with SMTP id
 d9443c01a7336-246b1d002d1mr61475435ad.4.1756205045763; Tue, 26 Aug 2025
 03:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250823130420.867133-1-vitaly.wool@konsulko.se>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Aug 2025 12:43:51 +0200
X-Gm-Features: Ac12FXwcIt7AKSolN3DwtlXw09gRC9vffEcEHqjr33ENcT1V7Bz1nEJE6ebXjz8
Message-ID: <CANiq72kQv9nJYyiuHvTdaJs2SvZ_bFAnexoEBgjb0CDzPjBTYQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] rust: zpool: add abstraction for zpool drivers
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 3:04=E2=80=AFPM Vitaly Wool <vitaly.wool@konsulko.s=
e> wrote:
>
> This patch provides the interface to use Zpool in Rust kernel code,
> thus enabling Rust implementations of Zpool allocators for Zswap.

In v1 the usual use case question was asked -- could we get some more
details in the cover letter or ideally in the patch itself?

>  bindings/bindings_helper.h |    1
>  helpers/helpers.c          |    1
>  helpers/zpool.c            |    6 +
>  kernel/alloc.rs            |    5
>  kernel/lib.rs              |    2
>  kernel/zpool.rs            |  338 ++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++

Should a `MAINTAINERS` change be added? Was maintenance in general discusse=
d?

By the way, the diffstat here in the cover letter seems to be
generated w.r.t. `rust/` for some reason.

Thanks!

Cheers,
Miguel

