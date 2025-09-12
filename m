Return-Path: <linux-kernel+bounces-813381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6097DB5445F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0E51BC2BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A532D46C3;
	Fri, 12 Sep 2025 08:03:46 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918392D062F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664226; cv=none; b=AN5ncneZmMhyXzTYRzJ3P/o2xXmiefHwDm5CXBuwXka3ZFYI/LOEDDeAsTrrFAZ8jdYwjYLbhdJRzJbBTHPBkcDbk6iR5vOuKmop6mWZZazd1hOQ37d/ur1ov1nQIxQzfllX6DAuK5qQ1FmKlsLUDazZqdkSoWjqFNohbQrjemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664226; c=relaxed/simple;
	bh=0dBio94seEy8E+hLMM0zWH0ran1cHBhU/hLk3oSudx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFhodAeV05WIA1MhUSny3m3HNS/1Kuvzi7VzpLR6/pL6qpyfNwzRsy03INLNRrcPtrMpQwqt1gereb1f0qS9H92F62PEPXznE7ppF0ioGqK4oyIIcIglyWDW0TAjiuLLYay+l3bgN3NEiS31P3xJqmaXHdtr3Fh9ZUwODzS/6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-556f7e21432so316355137.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757664223; x=1758269023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0kOd0FgIbQeQ+Oe+2cPl++UuME9YSWct0/1BA9cC0g=;
        b=ohFs+zEV4enrsfMf51rPh69YzQw6NA74umH69oZ5YDetUXgEBjkTIIstRY7OJ18FqG
         lQCWcrIxmhz3h7V8gaNNjfxRgm1Wtw2LflZ5E8MUYXyp+4dVLhWI2/S5gd9S/f0nQcLz
         qZJPnH8oOdk6mmIwfTySGz5oa/8FsoCJafHCW1f3quQl9h0zzrhnHJuayRIVH/pZXxO0
         hY5MktLM6iJCdH+ypfGMJcxBy4WoXZ6PeWtV05EHK/qC4O0wN7/mpHhZfnKz672VNHLx
         z2dWfFrTL4WuXDzQfwgoQBa1nKZT5fEXIrsZ24/K+XxP7XI0k1n7EXFGRmKorYN3ZXTX
         YWmg==
X-Forwarded-Encrypted: i=1; AJvYcCWbBloyiaBon8/TCXowLF6/OMZnNpOrUHTMnwL9OdO8TbqCQL1ynMGAp3P2EurvjddqQlxVcq0TUyMTijM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4QV/LlAPTaCoQ0MdIanI7iybW1VJkYS49LBe55vFDMn1iOVj
	5VCBrnunpHUVNgACzOjxNn70nvMmpDHDyjHce5losWC60H20aW5sRuSaco1118bs
X-Gm-Gg: ASbGncuSBm5qLmEHckLrG4rpW60isMX2OPnzNZ/gExNHa9Te/Il0nSYY087nqLOjoHC
	y9QCwUYkJooj2e6uK//ebc7wxcuieE/MmCMi+lbq5Blym1UkLj4syrtfmQhkvHTEupYRhmXpKqz
	AXW8kkKejV+GN7CIM1W4EbwA2Y0kemnN3NCwnT6nCWXN9YAHcPUpGK9j8PqdzaBH5PNFZtiqr5O
	nl7wm3zP56c5HNpWp8ly/B/Etphv8X5XXrFocHz8CMajcDa/6cZAB9H0TWFOhKSioj6QqrNJMmz
	wB/e38GVJZ0k/1JbPn/P42Tv2BcLsCSK1ZI0tKpakzqqllNFuS061SpaGsagHtFkfeKggsO85k8
	zwPSmexVT5P1VuE4k6wNKHNXjvuwhCbIYh01JUjPTmSqpuQTK/QD8LDOZ4FK5ZTuD7kEYCno=
X-Google-Smtp-Source: AGHT+IHpOGrGAoZpXDZdo7PWF0BLimh13lU8HI9FRgwRXbc/1Rv/YbiHYKor0yQC683TrH5FBGa8hw==
X-Received: by 2002:a05:6102:6884:b0:52d:1b06:5e34 with SMTP id ada2fe7eead31-55609e19fd6mr951558137.10.1757664223424;
        Fri, 12 Sep 2025 01:03:43 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-55374eeac9asm851361137.9.2025.09.12.01.03.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:03:42 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-538e108f6cfso858643137.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:03:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHbnhl8yvpyd34u/2hXn8nG9f+BngyZGj61p+2HhhzD2iA6FfEcJRp6ho5TvC8jgiUj4Fa95d90mVPim4=@vger.kernel.org
X-Received: by 2002:a05:6102:b15:b0:520:ca2b:4591 with SMTP id
 ada2fe7eead31-5560e9c8601mr948772137.20.1757664222098; Fri, 12 Sep 2025
 01:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912083052.399e505e@canb.auug.org.au>
In-Reply-To: <20250912083052.399e505e@canb.auug.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Sep 2025 10:03:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-ceznusoe7zi2bC_3Drx8Z3Dq-UhR8MSp1EAVEUTdGg@mail.gmail.com>
X-Gm-Features: AS18NWBf-eGvN2_4q-VIfWI8lFt2xO03NXlmDvhzO_CyVq3WKsOEqbZM-9Q5UPI
Message-ID: <CAMuHMdX-ceznusoe7zi2bC_3Drx8Z3Dq-UhR8MSp1EAVEUTdGg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the clk-renesas tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yuan CHen <chenyuan@kylinos.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

On Fri, 12 Sept 2025 at 00:31, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> In commit
>
>   380c74a29937 ("clk: renesas: cpg-mssr: Fix memory leak in cpg_mssr_reserved_init()")
>
> Fixes tag
>
>   Fixes: 6aa17547649 ("clk: renesas: cpg-mssr: Ignore all clocks assigned to non-Linux system")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").

Thanks, I saw the warning, but (incorrectly) thought I still had the
"increase to 16 digits"-patch in my local tree, and miscounted the
digits :-(

Fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

