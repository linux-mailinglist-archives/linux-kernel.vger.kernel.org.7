Return-Path: <linux-kernel+bounces-827199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D844B9121B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19B53BCBA7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9F6306B39;
	Mon, 22 Sep 2025 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzLJhyfL"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B78306B32
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544183; cv=none; b=DBCy+MfgtggyFrrdhqv5GGyPByZjuDoKYZpS5n67uo7aGbi0TljQWpTxMXv55Y9k9SMYt48hWOxlxqe11nkGq4rc4x6gyvZDu3tozg8ZX1E3GotpQLPa+2k6dnrucupvvgwcmKH58ivkQu8ne1BlPfet3BqOblYQFGdL5xoHVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544183; c=relaxed/simple;
	bh=XqUdLGQWUaLEwKpZPel0kn3r/WxfPjtD/uu9HJp4bWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7dQj4qiGkux8lZNgk3bMfWqhkztg/K0mupzlteZ6A9/cnooL1b7h5sCNdEeH4utvwMJFi4zCIEtQBWzfhfyCc8SqgzS+AlzvBnWOJ5iCT5gbX8YgiuLg3GoL0SSGoxDCYpTyCCFVGWfJWg1echHmFuowvABduEiZbG0tqr2gpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzLJhyfL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323266d6f57so4441039a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758544181; x=1759148981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kkGbbFXja5HoNsE8aPiHdoJDOGmZAghS1T8bfUgIDo=;
        b=dzLJhyfL/5nv8e/dFv5t1Ua4n1CBlL90Loebr1ibgSwMH8xvBhGtJOLeQpmPlJd5Il
         9pBndXjVPaI9H1a8gnU5FKwrZY0ow5AgSWry5BNw3xmPOSZYI+VlKVph79b4hXUT0akK
         rSe41cOlCbZQstrq0Q8Kt5sPTZGkBzKrf+Ge73WjGMtIGwGqoHx3xzID9rBzQ3vPL4p9
         BDLkLBSa75kZs7l3BLOr93Fpl+IvtNYY7RIoYs/+SOTsRsuHIIDXgzqZ1qnZneRwoEtI
         8WDewrzcJcN0a6SRDWLloMhURjTZqnjimhONTR/xcig/iFpAQ9WHtIVrp1v95XGbHm1w
         JRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544181; x=1759148981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kkGbbFXja5HoNsE8aPiHdoJDOGmZAghS1T8bfUgIDo=;
        b=V1cjuZTT1KpoQeExgodTPxg3bMksaLNSrBxDR0MN/Bf6qKeFw3IlRjkE/aM5KCenvh
         fJiJAXC7VyM22SdQ3qrOwa0pZMAMWExWJFbkujSsFuEJU4C12Q0kEZVfb169qHgW3cCc
         OorEyQGZepjQtb1vjjpqJz/F1Lc27LNTXdglPlehch29wkMOaRGSQQvTO/laakQiUY06
         Qns2d5/ocNAeCo8dAJOWqOrvOrV9OrrObOfCLauL9fE0CMO4YxUpO35lMjYlTG316x3s
         AQB/5dBZP8uHDGJ8Y3DNvohnZPbk+GRFfTUDAq6U+ta0hQkHttJBZUJ3DMg9NYx4eoXb
         CGUA==
X-Gm-Message-State: AOJu0YzVHrwN0PIuOi95GpmeKJzS/RmGWWGxaRFzj3GXRUKda6PyupmJ
	5/NUyS90sUgN9PLRL+SROByLBgBHVBTwUnb8trjIQdRAbOPmjMAHDK2msQ+ZmeQcVnGY1hE96cb
	dLsVCPC4xdPVXuSZ1ztENVqleMnO8R7ypTw==
X-Gm-Gg: ASbGnct3fVP+KlkkNmQoCg3dctduJkB13WOTR8xvCZbCM1tsBMNdoJZ6HbXujZ7mqso
	Hc+jes3p3zS6z1lkdL+mYGiLgaMncbgNDXbg7BYTkqOGTBI09cLBPzXx0uQxq+hDKl5Y2yPlCsH
	A91AM7mCyIjm7uvBR5G8TKudsuTVyeWHo7fuSsEILYjkOqTLrniv05YMEMhPAqVzpb30v4eQs3o
	BNeOF4+9x22AoPIoQ==
X-Google-Smtp-Source: AGHT+IGy5aeH7qgy9czqZ5/M905p2u1onS9dkeMikoIA8DbBlGZQierb85A/08SjKDghYR8IuXnI3vEtS7pZDZpl6ps=
X-Received: by 2002:a17:90b:1d8a:b0:32e:6858:b503 with SMTP id
 98e67ed59e1d1-3309836b19amr16205104a91.29.1758544181522; Mon, 22 Sep 2025
 05:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5JFqSMGSg5KEYd40JhLkgUo6g0uykDkXdKW3q5F1JtjQ@mail.gmail.com>
 <20250920075018.631959-1-zhanghongru@xiaomi.com>
In-Reply-To: <20250920075018.631959-1-zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Sep 2025 08:29:30 -0400
X-Gm-Features: AS18NWAxU6UFV7vm6gn38Vy_4Hwhdd_fzc_Vx7jcwj1EFPNG5vr21PNixBQM4Tc
Message-ID: <CAEjxPJ41d8WcEh8QYp9E63+tCO2ukE5UWvCJ-hoXgN_Sx=P_-Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 3:50=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
>
> > > Implementation of Muladd:
> > > static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
> > > {
> > >         return (ssid * 0x9E3779B9 + tsid * 0x85EBCA77 + tclass * 0xC2=
B2AE35) & (avc_cache_slots - 1);
> > > }
> >
> > Can you cite the source of this hash function? Is it public domain or
> > otherwise GPLv2-compatible?
>
> Based on my input, the AI proposed this algorithm and provided an explana=
tion
> for why it fits. The AI also stated that using these constants does not c=
ause
> GPLv2 license compatibility issues. If needed, I'll check with the compan=
y's
> legal department.
>
> Hash constant explaination:
> * 0x9E3779B9 (2654435769)
>         * Origin: Golden ratio phi =3D (square(5) - 1) / 2 ~=3D 0.6180339=
887...
>         * Calculation: 2^32 * phi ~=3D 2654435769 =3D 0x9E3779B9
>         * Properties:
>                 * This is the classic constant for Knuth's multiplicative=
 hashing
>                 * Excellent bit diffusion characteristics
>                 * Coprime with powers of 2, ensuring uniform distribution
> * 0x85EBCA77 (2246822519)
>         * Origin: Popular quality constant used in modern hash algorithms=
 like MurmurHash
>         * Properties:
>                 * Contains good alternating patterns of 1s and 0s in bina=
ry representation
>                 * Shows excellent difference from other constants in bitw=
ise perspective
>                 * Tested and verified for superior avalanche effect
> * 0xC2B2AE35 (3266489917)
>         * Origin: Also from modern hash algorithms (e.g., MurmurHash3)
>         * Properties:
>                 * Large prime-like properties
>                 * Complex distribution of 1s in binary representation
>                 * Complementary to the first two constants
>
> Advantages of this design:
> * Minimized collisions: Different inputs won't produce similar contributi=
ons
> * Bit diffusion: Each constant effectively scrambles input bits
> * Mathematical guarantee: These constants are theoretically analyzed and =
empirically validated
> * Complementarity: Three constants complement each other at the binary le=
vel

Given that the constants are from well known, public sources (which
you should document in the patch description and possibly as comments
in the code) and the combining function is trivial, I assume this is
fine to use, but at the end of the day, it is Paul's call. I would
recommend #define's for each constant with its source noted as a
comment.

