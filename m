Return-Path: <linux-kernel+bounces-841145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45707BB6595
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494C019C52E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC728A3F2;
	Fri,  3 Oct 2025 09:13:20 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6F2820A3
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482800; cv=none; b=uTOCRZ4bTZ7BVgXMp0u+EHpVyUV5G4TwIriy6v3BnGMMleK4FEuOeCjuPrHgqdhLSXvJDo+Xhi/B5jiJ+yrgzT5E0NvRoz/ObEATjkw/WhxAHoi1Uk/c5kis1OIgffkibfTBNvQda0m2S3ndh/cQnmdafsGbS7CUBf0/K6+Rikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482800; c=relaxed/simple;
	bh=P2nOlS0Y74Q7dC0TnxSj3mSINW7kWFoeFOiy8qc/6LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=islRCeilULu04Y6bbBdm2jvSveLxXtM5xYsTXWK/MAJREz65V9rvBIaqBaliNhfEBLMfQ98emWQhp67f5J+WH9qRwg6DTi2ySFQkqZV0+k98eNAv8qyO90R/JmOlHYjlO7vfvwR5ZsUqjh8QofZHaNqqQiw5oBT4lQf+5PEY3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54a786ed57cso1529705e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482796; x=1760087596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDTd/A+GqnR1lLNB4+wupiD6xOJyJNrk+TkPyuTsiUw=;
        b=Fh+602FWcAWTC/wj+8OWk9wQTk5heI+PUqJ4tG1QhC9Px9ec/BioYm6kls+1kIWl0S
         dhQjGFRceV/oGD8mY71+g3mn9zIn253uVQOueTD2+XPG9sJyX7rWcRuNCaVHzw89rcdr
         20UQumKq0N/ldMXbVZeMgSkfVVVhUlVh1b/vmyRxORkgnAP3mEM16ybl8AffFVwif4ir
         RvFKVXXVKlXti+jYbOUe0S860nclHQcj9j1o31efgdeT+YTM9/TEuYePDulRt6jvUc1I
         hX4KskUuB2p9z8xcb2DbW9m+jesHr3xtLV88+m2axDoZXi7yzM7c0duPDRmKknQh0IEN
         641g==
X-Forwarded-Encrypted: i=1; AJvYcCWw8A3lPtgqWBpQBhHLsoZRzH7+6UZD1r1PX5gc2ZuK5eOKuL4efpr9xA1kuN08Fe9tvsK3r6e/Bt3xeRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUNxOHbp0rj43dzCVLtNM9eaLnCjdDtsgowa4Jsz1KptfOSsUF
	MA/Hi2nE3sASDoOh9nAzaQ1kjPj6YwAPMTW6pPY4Rt6LLcThbpi16qdHx3DkWDo88NE=
X-Gm-Gg: ASbGnctmU/v4iqdksWClusr4cCzu+olMbySE4ZMPjKtZA7Y2DTSzELmtlHCiDfaiyo0
	4OBqBt4UWkCz3OVcDZxcedM2kXA/yO0g+PpGvoutdoaMZvLzUGPcPzbSuBQp0ccdldbxHsWhmhG
	YpIJ5MhGnf6dy6hdFGSmA4clRT6h/LjsgYilDumL+1hMNRDaSNWShd96RAUS8hiDRl2DI3HjauJ
	FP3fXiz1hd1RW5+bIPnkcAQZOgn1pr43ZKBBk8IkvrON8a2bDel5u+RauQrZRCsgowXiok6PjYg
	8bjQcI1nTrknDPPsZqyh8fAtSJIkr6s/hMAEIhFRRddWEf2a7jbjNWalVlxGdWiWxG1PsC0jYkZ
	ck54dPE8WGrHMUCl5EXrG1OJxrzvWN5LlzhdUvMqZ7vPGmFmQfphtZwcGUGFxUeu95RBW4GQdU+
	IUowW6gN86
X-Google-Smtp-Source: AGHT+IE4B2Z5b2lns6s7OwEWMOCUTWdOaTNqvKYt2/Xd5X951a4DN/XD1XsdP+d9QYk7wyce95qN6Q==
X-Received: by 2002:a05:6122:8293:b0:540:68c4:81a2 with SMTP id 71dfb90a1353d-5524ea9e945mr852451e0c.14.1759482796387;
        Fri, 03 Oct 2025 02:13:16 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf96587sm1040798e0c.25.2025.10.03.02.13.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 02:13:15 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5d42137abc2so367778137.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:13:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6h3gt0enmAGcA05cTQDp+1nYIlfx5QyyBDpM/77Tit2bjubtSVZzN3fpcv3OzOtLk/gPKNpRGNKm2pWw=@vger.kernel.org
X-Received: by 2002:a05:6102:1620:b0:5ae:f88:23eb with SMTP id
 ada2fe7eead31-5d41d1331aamr771897137.30.1759482795490; Fri, 03 Oct 2025
 02:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
In-Reply-To: <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Oct 2025 11:13:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWeR-LPLia_r3aYDNWBkQeUGUTp4rKmvc35P7SkmVuKwQ@mail.gmail.com>
X-Gm-Features: AS18NWBr-QYOaZF12vXWDi_gQ7JHEjluG3qUhyDxrhS1mgMAlr_QVRVkANhOWnc
Message-ID: <CAMuHMdWeR-LPLia_r3aYDNWBkQeUGUTp4rKmvc35P7SkmVuKwQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 22:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, 30 Sept 2025 at 21:06, Dave Airlie <airlied@gmail.com> wrote:
> > As usual, let me know if there are any problems.
>
> You are still corrupting indentation in your explanations.
>
> I don't know *what* you are doing wrong, but it's wrong. You seem to
> have lost all indentation.

Pasting TAB-indented lists into the Gmail web interface?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

