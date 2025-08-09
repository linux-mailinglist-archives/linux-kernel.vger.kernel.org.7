Return-Path: <linux-kernel+bounces-761100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5343B1F463
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F6518C7AB6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5FA24BCF5;
	Sat,  9 Aug 2025 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="FZrI6E53"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E32264D5
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754739353; cv=none; b=TZI99FRovgkH3Xic2rs4u1XZitGJejPKendmA7i+I/68Pg1idnJ4E36p63fzIX+4MYv+B/Fqv6+/lgM5o2m7DDErGetEdqrGqDc6F7UEVNUfLp/y2AcouARvr3QsGR9BJqzKQuMWoE1NVBqVAzFef361akFTY/6u6c97tPQEw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754739353; c=relaxed/simple;
	bh=hAW3jk3SWv/zmMCXhSe/RBviflJa+nWWURh0pkDB97c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XryYNYE3sHbfxpzXQovsv8Kb/z0MEN3ryW5LqhNQ/S2O3AdMubgygoreWHfjbz2+JTzd0OzWO27TMZVN4Lee59ILBpLabXINOqVR3I90114UvFxTw93b8dZJ6sNMz+HLrKNJqZC+T7MU/tEXI0Akz4yEEVpORMcDJQf2bfBCqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=FZrI6E53; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23fd91f2f8bso21558075ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1754739350; x=1755344150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b++fcpyw+GzzUicUnmSZ84AlEFMozk230O+V6jAR5z0=;
        b=FZrI6E53fgc/dOd0DVVkhyPnEXCQNdc1obOnXMGn2/SMJNuGHYBumUSbx/JoM0c/QV
         UTNhcXmkEwP2oMe8sN9nbL0ZQP4KAKYUlPqH66Mnkre7FCNCa+aqU3t87QfJ+8tbYn0d
         axepyoNBCLzqI5lpoaHoL9ZBbRQyESnjsep1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754739350; x=1755344150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b++fcpyw+GzzUicUnmSZ84AlEFMozk230O+V6jAR5z0=;
        b=adH/QcHobwNHQPJZJX+pmOyXJY2iDNT5hdQdFGYfb06Hf1AnfdrB0Cgl9+rPcEBF3v
         1/UfWxKXDgsoe0fL0SZg4q+0wJTsrSHKnBfpTodLuNhg6JwZRcFm2ev8wGnZNpXCxAmG
         bNziCHsWsb66UEQpwqcimasE6DmhjAi7ShXJNadb0YmrZA3XoYgTOhWnNcGXsvZY0z1C
         CvpP41EMgQ+Euq46ByAJXRrtWMUYb4tS9/qDPBc8L12wpNcix2gw6LxB157OAACD5DcS
         i0vsV/n0on2tJZCxkR6FEYiSPNkrB/qWxOghYr5fkVVsx9CuFTcmc1IhL1I1G+CrNG+H
         wpyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkBVqMKPE5QeN8aaQkr194uwGAN7tmLBN/fMuJM/DYKMe9yubFAE8VMjnZjZFDmPcOLY7XeFrwiOdLSfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUNnasIIU8KQn6AhPQDxDNp08fEkXpbUIOmqjFVaARiSTlMnW
	znVfB7BCmAk1UI2wNF1xiFlvbQU+fLsSFV3auLK1HCekueWJ3Pe3VjkvguUHwGq27QnVm5jW33x
	4nJkp27ATzmOvJeROs2gF72WevPsL0GAtWjrC903idQ==
X-Gm-Gg: ASbGncupJpl1pKnGaeYyHaZAY2WzX6dlwXrcGKZrlye2Nty2rxcCsF7BZ+ogBdI1WLw
	je0MkkThQHMuAS+o3d6EUqGD03H/7ABP62MDg3rj3IPXoyB4TXBSEoT2MdPZ7oevtm/DN0mifDw
	aykgBbLcFbZP8vymaWJeVq3FYdZNvZ4uHZkTDch27knvI9ZFA8YMQmb5tbyfLs2Fxzrjzgy8GGz
	c6WXFo0L8jAoneK2A==
X-Google-Smtp-Source: AGHT+IGzRREk87eDFcaLlUsWZ9PxrWx1XRhbvbi/whttddVLyL+oWWmB0vbEIcGyw1gXOa9CcuXauxBv6QV2toNDEmo=
X-Received: by 2002:a17:903:2a8e:b0:242:d721:b019 with SMTP id
 d9443c01a7336-242d721b6ffmr23012465ad.38.1754739350354; Sat, 09 Aug 2025
 04:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250809015529.373693-1-daniel@0x0f.com> <5dd0a031-dd7b-4078-b1a8-6b760248390b@t-8ch.de>
In-Reply-To: <5dd0a031-dd7b-4078-b1a8-6b760248390b@t-8ch.de>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 9 Aug 2025 20:35:39 +0900
X-Gm-Features: Ac12FXyKQaB-GamrPXjfDcjF8C4k1jrBhNp0iG68VhCNHX61waIkdj35RjCx0g8
Message-ID: <CAFr9PXmF-AOL8yj9FntHw+b1A8HWKNeAHU=rx7Dk7pfi1N_4fA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Add target for lz4 compressed vmlinux
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sat, 9 Aug 2025 at 16:50, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> w=
rote:
> Splitting the vmlinux.tmp creation into a dedicated target would make
> all the compressor targets simpler. It will need a bit more disk space,
> but there are a bunch of vmlinux copies already in any case.
>

That's true. I think a target for vmlinux.stripped and then use that
in the compressed image targets.

How about this?:

vmlinux.stripped: vmlinux
       cp $< $@
       $(STRIP) $@

vmlinux.gz: vmlinux.stripped

ifndef CONFIG_KGDB
       $(KGZIP) -9c vmlinux.stripped >vmlinux.gz
else
       $(KGZIP) -9c vmlinux >vmlinux.gz
endif

<snip>

> > +
> >  CLEAN_FILES +=3D vmlinux.gz vmlinux.bz2
>
> CLEAN_FILES also needs to be updated.

Noted. Will fix for v2.

Thanks,

Daniel

