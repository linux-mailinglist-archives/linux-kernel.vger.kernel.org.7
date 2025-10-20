Return-Path: <linux-kernel+bounces-859933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8FABEEFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC781896DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463A21C84DF;
	Mon, 20 Oct 2025 01:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LEY9PXGF"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8EC548EE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760923074; cv=none; b=ASt/lldB7qJMw42Rr/bDfsGF7O9BlgWVmdp4LQPb33ZjhzhjCQ8g6wpRH0+2O48HdnKdUJTa3ZpHij6BTofeAW3+qxH+4Ovr0zIwGqMr3rdy8v7WADLXyIMF5zRoujjtKmU93DsQ/2Ihk9VX8B5mCol2q//2Wf4x8sXx14sY7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760923074; c=relaxed/simple;
	bh=mJD/bzm7fcLRKMP580ak2gEd90LFfkcxfajSZFUvHnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uwo3Cvltf8cUGv9ulcbVbJpjT0K/yeKex/hUoR42K4JF2w1BHo+f32iZIfYGn3NKdZBRO0TzdbRFbmc8B+xOFi+a+DP4Hkiiz1vGBZkmuH4iIbZez8JRi73W+z5LpZprXVzvJZHB1iHpb5taV0smPozRVb9PpRjGU0mi80kVKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LEY9PXGF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b50645ecfbbso757886266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760923070; x=1761527870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LsNoL0sS86ArEXrUpcTMrn2Yzq8PGH8khZpMEn48fww=;
        b=LEY9PXGFT0Ejr9gXfl7GXunZshFS9jpB7tVygzNh5qcS+2kQ3dfwok1gTV8KuBrRxv
         X0ZWgpaCufO0WbgptVNt5jcP1XAHGo/+Lxhrmjyj6IcN9OVBglULRRyPVBbVWRA3mET5
         Yj33zvrpCz25gj0vEC5WymmWgSFwVCvZxDeOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760923070; x=1761527870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsNoL0sS86ArEXrUpcTMrn2Yzq8PGH8khZpMEn48fww=;
        b=IWpIBao4K+G/gGK/wD9b/sF0zTe/IbOrLFJYKvyOsYbpIzRnAYZsGkrrr7dOqY4Rl7
         tk2DGVxFAAj5HE39UB3aKS0+Vw8G2wT80piQop/xNbC2bKz7GNWZyJTQ6PIuR+zNJIHw
         M2nOX74T1KNKNUrd+g6hkO/VyXcpR7mErT97k4X3AciEj3dJ4IIWiP0jhMS2SUXORR5n
         0ml2tYRPhEqtC8yyqUdRCWYDJnkPb4vgj7rJ/0uOlgejbAHFcKTEY3Jr4HqT+fkhcGKu
         Bh1k+8JB2mU+CVgEXfrgeyx4rKQbIGgrBNdtTVqNz6og3Iau9ZuCM6xcXlYLHfjdAgON
         eMUA==
X-Forwarded-Encrypted: i=1; AJvYcCX4ER3C80RoDdJVcMoeFJJJ0lE+PrjsoKj0JW7DEvxdmQSB+CRnChTgpVUVLg13goSxYMvMEG6e/OIAPE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxIld+4CxH+cXU0LIL8vLlCWvxAWdbavymZy4CZp3HNDCiK2h
	Wlz6VQgfSxQZM5uMnyBpCuHmNqhOF8uOTcfXE0yEN5SYD28jlnuKZHmFSoZaZw8uOp0W44OXNkB
	8BWSvLQM=
X-Gm-Gg: ASbGnctvX/hroZP8kkDQUpKAfnCHqVqjcO/puikRlj++PC8dXpMl2/iboQ8XN1HPxIe
	aC3d0x7S1D0KxQXSUWVGkBCu08t0hSYRFBm2RQjohpmr5Hk+sWXQdUvbK1PtnPO5l/J+vWuPaLG
	1p0o+MihN5d8sFaqNpZjlNru2SomrJsH05NMl+5Zp9I6HoLanmWXL+/gMR1huoQCyl/CSkWcczv
	a5yE9W7fZiQt4vuGuQGw+bdaA/IzE2RU2LkeetBUSIuefzlQoVEJ6tHIEI5ETgWGEcKqboNByVb
	eQmBhXs4DJXfI2EGw45KtVz1ja3GphFT9FyzPSkfefSrz4ZZoOEYk5WWRiO2uHsaiwxZLWgQEt3
	7vtZ2xnpAdegr6HufWgPtrpn7zy7Gjfr0VA6rIhmZJHsxnjnNj+t+6mSj6058+WIvB04f23EP6N
	f6TzkScKgGv1u91Xp8MmZpDddy2mT7qqcRXaspEetXjgfAlyguyb/1AyLOhDoE
X-Google-Smtp-Source: AGHT+IFASc5pCGiW5exELY+Jm4ELDS0ZSCN0DP4K+r7FKQo8Xo5sGNWue5LgO32JjhSTtpWNYSyDFg==
X-Received: by 2002:a17:907:968b:b0:b41:c602:c746 with SMTP id a640c23a62f3a-b6473143cfbmr1263894966b.20.1760923070379;
        Sun, 19 Oct 2025 18:17:50 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c7267319esm2594929a12.36.2025.10.19.18.17.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 18:17:49 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4f323cf89bso817051766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:17:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2YF7i3TYZ4Vv9UejS0yFoqyRi9PVk9zWfaFEI0SIoiRKTFTdzWMYtUtj/Q3aJVtFIoblHNdmpdh8z9Ek=@vger.kernel.org
X-Received: by 2002:a17:907:268a:b0:b47:de64:df1e with SMTP id
 a640c23a62f3a-b6472b5fb81mr1333514866b.4.1760923069016; Sun, 19 Oct 2025
 18:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760633129.git.dsterba@suse.com> <CAHk-=wiiysgAErOobR02zECiniaM69AacAHjTOSKsv3yDF2R+A@mail.gmail.com>
 <87plaieexu.fsf@prevas.dk>
In-Reply-To: <87plaieexu.fsf@prevas.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Oct 2025 15:17:32 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com>
X-Gm-Features: AS18NWD9HyRh8jNCcR5HaCwAUJwoqAFhf2DlmK3heg9hwTylB5TMwhLlL0ysbmY
Message-ID: <CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.18-rc2
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Oct 2025 at 11:53, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> I think this has come up before [*]. Doesn't -fms-extensions allow one
> to do

I clearly have some goldfish genes, because I had completely forgotten
about that whole similar conversation.

Yeah, so now we've had at least two use-cases for that thing, although
from that older discussion we'd apparently need both

  -fms-extensions

and

  -Wno-microsoft-anon-tag

to also make clang happy about it.

But yeah, if all versions of gcc and clang that we support do accept
this thing, maybe we should just bite the bullet and do it, because
it's just universally useful to be able to define a common helper
structure and then use it in other structures without naming it. Kind
of standard "inheritance" syntax, and very useful for that "I have two
or more parts to this object".

Want to take that up and see if the btrfs people like the end result?


            Linus

