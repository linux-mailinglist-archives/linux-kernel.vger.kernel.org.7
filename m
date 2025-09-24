Return-Path: <linux-kernel+bounces-830542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1828B99F12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64413282D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2152FD7BA;
	Wed, 24 Sep 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzx5ZyJ4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FF2FB98F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718574; cv=none; b=bOIWfmbFEgOv89t9hjlcAWCSEBlPznSnszFQvJ811VtlWYyIkBUWB9MRUYZCo/Nd6tBCCiUo2DjO6M6mnrBJ2JiyyC7Wp/HWftNRysnpPLttGxgtMuNZB7lbP2rk7JFLcF6IYeWbCpV8jthsDkWzSluWWHUW0N6HQVPfJm2TAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718574; c=relaxed/simple;
	bh=YGbqe9ZAFL3N5iLsnVD45Vj6XYPMwC5jXFUrKyVnjHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j++y6svBvfNMmDVL38NMg30RxU69vKDfAoq4UiCFwsv6xEe+eUsvxhpRLT8tTXPQni+eydjT4CgBBlANGxpbSiV1xlUp9UnAwSFJSOtxFpjqcxs1Zw4D5aRfiIzqdd0nDQRDksmJJzmOJCm489lojtf4l2IwJ/nK5ECT1WwEFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fzx5ZyJ4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2699ef1b4e3so10408705ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758718572; x=1759323372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSa1OETJ6PU6Q1MXWxYehsiy6u+If5pzrQWnK+jSTZk=;
        b=Fzx5ZyJ4j+0Rb52nAgFUZjrR66oZzUUt5ttrr98PKRKFfxdQToONtkaVtR4sDJsbp5
         fAqn1vzJWDOb455+D3Xrjrca0i4zofGaMhAlv25ipWLHYllfzZIFkgywzG1OuqPJtqUR
         Myfp+5UxtCXlBngjeB4XkgSYX9YiyRFte9nwMSOx1qSi98sDqShs6EWJCbeyx97LeyUe
         RWVOWdWvtv8WBuFi2QkoYd/ztNvhQosPtxXuXDCoegYc/1N2ic42TlJPzt7+XkvVe3j/
         1eCXu0HKjOiAN00blv6WeIep+a1YfuzVU5rceX/fzU2cutiidZlQ0lAEwaBntQuSr+Y5
         GPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718572; x=1759323372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSa1OETJ6PU6Q1MXWxYehsiy6u+If5pzrQWnK+jSTZk=;
        b=Lu8YkagiNxxLXnYjKdLQfhf48tBzXAGhKENaATksRRm+D+p5UrKbPRVpSoqo5lQ/YA
         saSP8K9rXS2HkyqZz6JtcieHvNzEcZZ0L7B0GDFQchGYpO1AAO+zmAN7fwihE99/FjpR
         6DKxE+XtvP5qopivmL3ceJ6G74GwqYPCyEHXLMafi4sgB1V/CFjw+J9rpqmFuMHglKxd
         bme+t8veU1X+0whZ/stdSVm8yfDthkWabWEL2wyt8HIcu1Z2t6FoiSSeAA77l9KskNHq
         t2B3u133Mxb9x6kgdliE/5mHPPCoAIGWxzk0Czm1hzWOPhdyeL5Q3pesm1wRbKmtjFya
         /3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXNoLl3chpnT3mg0vHx4j4Qfja13czCwYd35t3gkBfF/TLlBxQpJl7eTtrR1eBnVak2QTI8Ias17EiPALc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jQjPHVbIcZ5Ozq/sPuPFkICTBV6DU5kfl2y41FiDZIPBw4Ra
	Mh7DmJ1Jk0ShyzLQSr34TOOOLQinMZzqiajCTRpEVt6fjhNyPU4kv1cahGlfSbeFyrhrJLm/m2c
	SfZnj+QkFwR0FHIJX0/pnJI4r7lVEYm4=
X-Gm-Gg: ASbGncviJ2QUIzl02xzkry/c4yaXegPB6F2e7c+idMsDduK8dThMtLQ+KqbMEq6Ndk0
	SJPonh/G8DmXYu3KbsqW82+YMOuE0nsGPvHitLHQJaJTFPHMSk4QHdIYa5rMqcQVnrnUWdz0hiZ
	gFyZcJZvdLiyWjVNApWSRumPYsSmdEGeZjKZxjEkEbmaOiQjHqtJ9b8rhOXdLWu3xfKk6b4aau7
	7eI/Om7Axvr0RoqaXto/L/htgnnNc1T+96Zh+kO5B0Esv+YxAMqH2pI1aoPv6HX/iuKhz6YJbhE
	+QYsvfg2dPutl0MYmDZm52ZUsPXD23wXvJfv
X-Google-Smtp-Source: AGHT+IH4job3PIEwg+n+ghlTlE1Biqa3K8KrolYDQtT4VmgH5e6Wty81d/Gwhyhag7z/wiwZKWJiEU2jY5ciEvxYfNU=
X-Received: by 2002:a17:902:c404:b0:265:dba2:2315 with SMTP id
 d9443c01a7336-27cc3a152a8mr41930705ad.2.1758718572411; Wed, 24 Sep 2025
 05:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMlfiBynRQrbW3BT@sirena.org.uk>
In-Reply-To: <aMlfiBynRQrbW3BT@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Sep 2025 14:56:00 +0200
X-Gm-Features: AS18NWCSyQ02d8rV2QturoMpZoG3x-M2lkSbgrSGVFu_GwtD7A6datCIzaf4A9E
Message-ID: <CANiq72=5JLSVFFZ9AZyVA+oCLjN5KVtwZVVqRYZL3DhZ39UC-w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the drm-rust tree
To: Mark Brown <broonie@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:01=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> + use crate::util;
> + use crate::vbios::Vbios;

I think these two lines should not be added back; otherwise, we get a warni=
ng:

    error: unused import: `crate::util`
      --> drivers/gpu/nova-core/gpu.rs:11:5
       |
    11 | use crate::util;
       |     ^^^^^^^^^^^
       |
       =3D note: `-D unused-imports` implied by `-D warnings`
       =3D help: to override `-D warnings` add `#[allow(unused_imports)]`

    error: unused import: `crate::vbios::Vbios`
      --> drivers/gpu/nova-core/gpu.rs:12:5
       |
    12 | use crate::vbios::Vbios;
       |     ^^^^^^^^^^^^^^^^^^^

Thanks!

Cheers,
Miguel

