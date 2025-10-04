Return-Path: <linux-kernel+bounces-841961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD86BB89FA
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 08:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84BE734619E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 06:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E17A224234;
	Sat,  4 Oct 2025 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsQcbSYu"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9A224891
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759558814; cv=none; b=CJEnCPxbzl3IJBW/CSMAtDD8SI0M/ntM6NgsHYuEPs3U0bDQ2+npZl6vJ1yG1bOf8jhl9TiR24oThn7CyEgFDwMV1qgDSfWuM3xevb6gpDPavpB9mIYI9w/V9awERsUOlK9JXD+mXAYiU+j7OzsqnR8DFy0qavO//xMxQx8RX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759558814; c=relaxed/simple;
	bh=cwvKQypMKJEPIzEUZe5Z66F8rm5W3HyDor7r3ulkwlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txfXrPr9W8E97IMR+jPkYD0hXOLthzNSas9CAla/iBknW/nZIyaggnydIa4ec17Du7AFBg0s5JlThbocHaiEIgOYglb9nO9gcQ1I9u5k6c7QdbKYEbpT6VgFROzIrdBI8415k035ulJzDIco6BeE29wbL2J+/MHeI7JD1f9sGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsQcbSYu; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6395172532fso2471319a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 23:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759558811; x=1760163611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwvKQypMKJEPIzEUZe5Z66F8rm5W3HyDor7r3ulkwlk=;
        b=DsQcbSYu7jmoi7Q+Gcs1dSwmcralfjQOtn1b6DBQVTC3YSVMap/XHeQwkyBd9WSBFh
         XWifW1fyvtxhjcZsr3aOUsKcmBfqJWyGXKhp/DMzh4bm8PBEsQsnvsuwTPw1Cd5AwzcZ
         WxQGNSw2WMwh9m/O/voAbmsI0qN2BD6bLQb+oMRLinb4TpospDam6X6UeX/q59hDOPkj
         gh0oMvZaiTVHDeoXQ0LOYUGevdKfPhJr9M8FZOP4kPHfRPy6oy83t+GX2v4Lk27cje94
         ZVQwmayvGF0J6ieKo1sOmgf+QwlaWSPx7ZcK9PkLe7zuFHMpLamrj6C07soPihS7I+h+
         e1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759558811; x=1760163611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwvKQypMKJEPIzEUZe5Z66F8rm5W3HyDor7r3ulkwlk=;
        b=d3aMN4HE90azV/6iEJL+pjCBSPQDGKIObhehxBQg9rVMP5bmuy2D2Dh4FWGucsk2NE
         9Czc7nTbrSi1vUilTcQCtKtFjoaocOejuj1GOq/TPjKI1zE0J8WvQTBtWTl94h8UeuPG
         3Ao6+mqLLx28uT97v5Ky16QZ8svjC8wqkDslsGegx1tDSXw1iG/bWX6mMz4106tjp5Sj
         bbQZB+yAk/R/iRU1Rgd0M+tn+HpVDWHIQq3OMjLWcVj4nv9TjfnJ33DTUxRQc8V7H+RD
         BINPolxzbssYSadLiXyys2phSU6Vgu5N10oW0Z5gF7SvvaqP98LX3KxV8PStfVmt1gI5
         wgpA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Ah2S3GqpmPHv6XAVz68SO6NnKS4NGVX+chJ/FAiqeI3e3gXwzwmpDZNWf3OtPJ5Ot+gj21ewlNi9lEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGIbrsw60td7a3bf1Tm49q/B35HG0SPezNsr+3ibTYntsfepEX
	MfBEbprQlIW3S23RvMYx218/sOCSBA9jJ5flZvQZblIMI6IlkQGKFO0WoUdpI8Naj3MyPNX6AV7
	EuIcM/Sv4oMQAUksZ8PytE+8HXN+iags=
X-Gm-Gg: ASbGncvCvJFbfl7UPR9UrVwnmB2bqwWvNC5bx1iINN3MK5W3mo0uRPDZXXd1mU79Sgl
	hoOUHy+WSroFj1/BfT2akGBNoyIkiZn4IJ/KVUqYHklnHgatx9dYoAZm2VLJ+dhoL0dlViizLaJ
	/YJQaiCEn68BNyfgWXSE/bXYjkRuRF2rQyNTjd1Hfg5mhrOkgVIXxOjC/PhZ18BoNgtVgxPvFjF
	ySAojidKhN8lde9EcgK+hWXInKNoJE4e4/3T1mbjg==
X-Google-Smtp-Source: AGHT+IHvC6Z7Roar6Te7hGz1HgNqfK/9bJzycQ+JL4engfzt5VbPcx2Bzy1MDjmUK9nyex0/tG8Inr/iSP65hfRQ6uc=
X-Received: by 2002:a17:906:c14c:b0:b47:de64:df1d with SMTP id
 a640c23a62f3a-b49c1a76234mr684527466b.13.1759558810901; Fri, 03 Oct 2025
 23:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
 <20251004015623.7019-2-raskar.shree97@gmail.com> <21b1dc10-acad-43b9-a9c6-24abb2886856@gmail.com>
In-Reply-To: <21b1dc10-acad-43b9-a9c6-24abb2886856@gmail.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Sat, 4 Oct 2025 11:49:59 +0530
X-Gm-Features: AS18NWDFYveno3GXr5tGCM5q0b7CRS7Tq77mFhLV_Q5_pds9PsSNUL9CCHseVRU
Message-ID: <CAHc1_P67arWxOeBJZGGREQvBwVG6VaJkRu6_RawWDqRunBdzow@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 8:52=E2=80=AFAM Bhanu Seshu Kumar Valluri
<bhanuseshukumar@gmail.com> wrote:
>
> On 04/10/25 07:26, Shrikant Raskar wrote:
> > The MAX30100 sensor supports multiple LED pulse widths (200us, 400us,
> > 800us, 1600us). These settings affect measurement resolution and power
> > consumption. Until now, the driver always defaulted to 1600us.
> >
> > Introduce a new device tree property `maxim,pulse-width` that allows
> > users to select the desired pulse width in microseconds from device
> > tree.
> >
> > Valid values are: 200, 400, 800, 1600.
> >
> > This prepares for driver changes that read this property and configure
> > the SPO2 register accordingly.
> >
> > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
>
> The subject prefix [PATCH 1/2] says it's a two part patch series. But I t=
hink
> you send all changes in a single patch. If single patch use [PATCH] inste=
ad
> of [PATCH 1/2].
>
>
Thanks for your feedback.
I have shared 2 patches, one for device tree property update and
respective driver update in
MAX30100 driver. Can you please check the patch with subject ' iio:
health: max30100: Add pulse-width configuration via DT' ?

