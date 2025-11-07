Return-Path: <linux-kernel+bounces-890972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1E1C417CA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB4A1899907
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3244A334691;
	Fri,  7 Nov 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNOZX5b+"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA992FFF98
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762545540; cv=none; b=qUqcXjhcR7dVUKADHG083FK/6NbgO7SoWCVyxLTofacFEUzIZlM0FJ+xB+TnN2uFSoyhwQ9NCxZrPN5iP5nuEvlyNT90kbLYu9yLa6pG/bJefgs3YOK2aGnK4EJPBIWA620djK+/1sXK0h1OXsHqpcbkYVotjjU6LMn2pbl8Oho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762545540; c=relaxed/simple;
	bh=8140RYwr53yRPEiCsiu7vlVWQb2NelrQ1jo+nFPAA2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYdAdxYe87WpQHt3CHev/RZ25X9pqu7muCLDCv5ZmKrv3WHQF7jr39FHkQY6h7oS1h6zWnOn1iWyvoKz06/xcBMyjQMEzKjQpZb1ZWBI8CZ6J1eoRDZQ/ZLslrJne5DOpbYH5FNkW4TkUsekq7zR0+VbmliVXN5ODL4FU2rpzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNOZX5b+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b679450ecb6so839761a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762545538; x=1763150338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8140RYwr53yRPEiCsiu7vlVWQb2NelrQ1jo+nFPAA2E=;
        b=WNOZX5b++zFYE7WyMLG+aMFHX4rG5d5SzBlTp5spg/Co88luABp1es9iO2APyFls9i
         X9zDjU4Kb5Kcd3RyI7jvphcle6xaRq7cm7wlEhPy9mp1YsEBJz5Jew1XR67DBbzsd9+8
         hRhEaQiRC62iwG4yIjtkJwKmM2Kdj5uroQE8H67HjbwBG4QqFG1JqoJ0Y99YNWZEpcR/
         HVqW9rA2O5bhdIDabHshTr9jzcwHBvxIX0/KrXb6mCVUcmBiQpDMcO2RbrJVCoSUvXV0
         1gJzN9rYd23j2Yw0C8RLpGyXGqOKuppmGPckO1AS9upxs7Hu1dbw9Gbk5YpCdmcdpNjo
         lWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762545538; x=1763150338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8140RYwr53yRPEiCsiu7vlVWQb2NelrQ1jo+nFPAA2E=;
        b=uc2T0twdaeXnHv34wIQjDd+Y1kZP5kloJdHTUhNhOkkYD7LpeGt5gJgHw1tuKwpDAg
         Sg54OCor92tHf4wr7RhBp3o1/ZdDeUzt7SiPSnkHfgBW9wOVrODS835WdNKiHGUAcaPl
         4rnifJFpvpx2xEy4CF0qgiGzdJPbcWeuv126+21yaejSnzmPeUk2vFKpJgSjiT2nFTH1
         zSLt3b92YXQEdkvhVwC/w1Ve1ANSTF6htTss4qQ/Wjp0/nsh6B0PXt5pBLZirld0ospY
         oV/0DJV0Uyx+dhfnuwwjF80TmjqlvjB2VmG2CezXFe3HlU1oX9lVbG1u3gjOTeYKHXdQ
         fjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp7UOfbwix1aRpgbgpAJqLqTMDqke4c4zH+9BLXaQHBndIaxDREri6fNQUrSA9/as/K2XPPwlu97eEOdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5eziKmzmHggW5mSXndiM0Phnh/tLFIMma/zQlPAepI1RdzwJ+
	2g2rCG1V05vThFwWWKRCj1ukprzWGsJDywBfa5N4ONMLiaN7plFBL2gInhua8CI5GoS+8zwnE6o
	DRfx0goqt7Uor9y8jmPruymgg17tgbfY=
X-Gm-Gg: ASbGncv8Dfcesd1XEQayo6BhXBRnsbYtG3+HrbGVq0j3vYCfdvv3FFcFFmEBR14LbIX
	WSYMVekkosmPK6e+6vVaWUILQm3yWzvdWvEE1XTyGzV1DSp8aahLZHQedQRv50o9WY50gC53oGW
	3BGe4IIhTdPEA5p6IdvejbHgYUH0p3FQ2AMtVRqyPzugHunEUIqeEs/6pxS99U4ZqAQZfXSQmgI
	nLcSISmia/THL5Dj33p9NBYr2IeJNj9swNbahM21zAEWRSvkII4cWpWA9/t
X-Google-Smtp-Source: AGHT+IEQzK9Tj8rqC0O27SSQFMzZOXdiURq9N1O01zdIrKR+8IYOucTFhRqrfF8+sbNnXWpxn1Yh08RMY3YuTmKawWc=
X-Received: by 2002:a17:903:244a:b0:295:4d50:aab8 with SMTP id
 d9443c01a7336-297e563cc3amr3896735ad.24.1762545538507; Fri, 07 Nov 2025
 11:58:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>
 <20251107153733.GA1859178@ziepe.ca> <c9c8b90f-4edb-47da-8ad0-94f9e58d71e0@nvidia.com>
 <20251107191736.GC1859178@ziepe.ca>
In-Reply-To: <20251107191736.GC1859178@ziepe.ca>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Sat, 8 Nov 2025 01:28:47 +0530
X-Gm-Features: AWmQ_bk9CAFYBN3_A4DR9N_puVNGatwqzH3T7ZbHwpIBAIwu0HIMFU_j7LV-VQU
Message-ID: <CAL4kbRO+p0f6cKLONf=qqTU32G2YCEtkgQpu6shX=zBeAa1vFA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: Fix uninitialized gid in ib_nl_process_good_ip_rsep()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should I prepare and send a patch that adds the suggested check in
ib_nl_is_good_ip_resp() as Vlad mentioned?

On Sat, Nov 8, 2025 at 12:47=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Nov 07, 2025 at 11:11:40AM -0800, Vlad Dumitrescu wrote:
> > On 11/7/25 07:37, Jason Gunthorpe wrote:
> > > The fix to whatever this is should be in ib_nl_is_good_ip_resp().
> >
> > nla_parse_deprecated returns success if attrs are missing?
> >
> > Other callers also check for their expected attrs to be present in tb,
> > after checking nla_parse_deprecated()'s return code.
>
> That sounds like the trouble then, the check for tb presence should be
> added to the ib_nl_is_good_ip_resp..
>
> Jason

