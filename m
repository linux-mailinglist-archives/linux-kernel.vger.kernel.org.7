Return-Path: <linux-kernel+bounces-751569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72DBB16AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE2B3BC0A6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863022F770;
	Thu, 31 Jul 2025 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="haHHm++p"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204638F40
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933958; cv=none; b=fDFzH68AHxvKr0JZhU33glYs84qkXzcBllfQAO8rC8yUJdOoP+Y9x6KdFBp8+Y2g9bc1W+F8Y3C8ISSGE7wrDO/JmqCE9P8Cttim5E7/vrg7U3u1r2H8iKtnpeyF/sBYyKYz6KZwZznca77EDhgRWO6e9kcQNxVKS8/hNVyokR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933958; c=relaxed/simple;
	bh=3ZlfgxCfrA36ocBvnv+d7aosTF/zNm+rlwv6wjkwMv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qr3Jd/eYRspE8RGZAED5Uq4ZlaXQVLB6IMOEFlHZGn4sK9A1vnVDNpY4sg/UbT8BxJjsr6jcFuwuQd6ZT9pvpFmtbRjSx+7JcvtwTGThOBNhld+9ea8kRqnrukXI1T3aB/0/QQu4zFFw5pEOun5HzUY3iFb3lrlxnwOrXJyLR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=haHHm++p; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0e0271d82so80842666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753933954; x=1754538754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGNWExXll/J0aYsizYZXNM2okZjvNKQEHFu2OQuymMM=;
        b=haHHm++p3i3riIbJhF65N0c80tDkvZIWHgvnuT2eslbiIv8dPfWavoYomyh/mL7Caw
         DsWvvffB0lL2fNRfgiqe6iM0wg92hjexaRzAOETodOkxfrzSJS4g4Ud0bJG/1SJd07dK
         SGEy2mwr6DW10JTLo+DudabWBfaD6STrCHTfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753933954; x=1754538754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGNWExXll/J0aYsizYZXNM2okZjvNKQEHFu2OQuymMM=;
        b=J9TKGL4mEMeA8EdwemXXZWWZRK91XleQdkdjUqaDGOxGXe3L64bmxEuCzeY/ntGfHu
         nVREpRhkgeqq7vlbrWF6RJWj7V1zs1sGJLw03s9UxndBVZT8B8ukEEIvITIgx68LdNkB
         Bf+WR/qbfyZ3QJoKzXBod3Pj29hd32Ngd8ZPfZodmgSlE/hzYi4/9QQh7JvCnFgINy54
         RvyWHD97cdrCB7DKkQtUxXEAADYVfJWC0bGAm9FKfvFcjkF7VdBwBLz9rxXoRAgVa3ry
         f5av3I9ehmFraJ5K0yn8m8wDp0qZrSxc4ZX+oaVyg8LuwjJeM9sIqYreS7EUQ2OxMzTS
         0Fjw==
X-Forwarded-Encrypted: i=1; AJvYcCWVXdbovyAvgKLbixCnDH61w3XagbS0ZKobcrcO7PzxZPYvXbxTlnPjG6ZaddoB9UVIjU1UcxT5Dp2dCXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pk7b3v054HuAVPDN4ECC7KV2h/LcEq0BCI78T1qMbsq7inuj
	kvBV/W9+yw/q4GbUSPfYKFPYqJxbKb9S0vFu9MbnJL3DNknUlwlHiBS2xjlOI/EnUx2Gi7Zn+qU
	C5nB38CM=
X-Gm-Gg: ASbGncvmxQ3f04tV1IQRaWGw8zbcDPLDnnE0wpNU80dev98CVIP+DU9CXK5qiQeYXSI
	CaljAC+v8uD2XBWR6BAs932ztayEinLr5YNKClxAxXDmwVdlcpkixjTrj0+m5xyS8mSuEIwLJyN
	8gLcklNdvRE7xLf/RirnqR0l9QpjXeN6NfaCKCcCPFKZzk0Ky1QJrVh/rxdaAdeICNPmsUMF9I+
	DytT5f02FB8jrUhvJR/CZdF/LLVu4LTDsqiXe1tdhSF/wW/BYGco/n7wKPlS29jlR3JtXTebIQH
	4jK7SQABFgAXqCrX3tXMxc2TdJB5zAhoVqT4XyHnGW5tdFw1uH/TE6rP+EjeVrZuVTuUfytWSFU
	TqTdskS0kxJx+BV3lErOcVG8o9q0G9g5yEEut90u4BumM53+6fVHWFCHUw3KgnKAy15Gjr7QO
X-Google-Smtp-Source: AGHT+IH0x7jemX4VSzQOSSVxrgGDeOtVNI9Qyl3fUwoev345ro1+RuCy5H7wV2mJ92cKM+6cy/gBYw==
X-Received: by 2002:a17:907:9494:b0:ade:867f:1e9b with SMTP id a640c23a62f3a-af8fd69aea3mr524696366b.9.1753933954146;
        Wed, 30 Jul 2025 20:52:34 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8365sm40651666b.76.2025.07.30.20.52.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 20:52:33 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so700157a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:52:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbfkv+67JEXg/oudZc9GlWvwojOILfBJo/tJb+11A0FnxbMyKXu6FSy7mdKR41H2ixoc9EIKFh/xBu0Jw=@vger.kernel.org
X-Received: by 2002:a05:6402:1506:b0:60c:4521:aa54 with SMTP id
 4fb4d7f45d1cf-615870b422bmr5699057a12.17.1753933953132; Wed, 30 Jul 2025
 20:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com> <CAPM=9tze2EcWTyi7VZxEY6Ys+YSrep4U15TtizZghFSD6eWjsQ@mail.gmail.com>
In-Reply-To: <CAPM=9tze2EcWTyi7VZxEY6Ys+YSrep4U15TtizZghFSD6eWjsQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 20:52:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimp=a1zH4goKuXjXGMKUsuQDtB-TVNM+JRzk1ht6+c9Q@mail.gmail.com>
X-Gm-Features: Ac12FXz8hE3dOTilhZGKs-EhjAf6PWZR_3hmZLP6VtUZeZKi2A2bT3LmLcgkVT4
Message-ID: <CAHk-=wimp=a1zH4goKuXjXGMKUsuQDtB-TVNM+JRzk1ht6+c9Q@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 20:47, Dave Airlie <airlied@gmail.com> wrote:
>
> Is that the Polaris card still?

Same old boring Radeon RX 580.

lspci calls it "Ellesmere", don't know about the Polaris codename..

         Linus

