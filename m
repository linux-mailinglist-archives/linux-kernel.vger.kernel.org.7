Return-Path: <linux-kernel+bounces-846342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE4BC79E6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBCAA4F3952
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA95E2D0610;
	Thu,  9 Oct 2025 07:11:24 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4CD296BB7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993884; cv=none; b=TzM+38GaY+58O4p4HnAmt2H8O+tFUd88tYowaBnal3dx053LcxQcB7f2TGKihZNQ5AjaL7Nbey6MMC9iQFVs0+gpi1oWjrq2TMi6pzqN3zL4I9SX8d8VpfsYx1QhZ53p8PsRNQUQzVsItJqTGv6KjEfaBOtcoU3aQcXTaqB81YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993884; c=relaxed/simple;
	bh=vHsLC2ZZf3R3Cazh2jOIeRCeKj5FEq8IfCJ5bB8jxzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tc4OSd39toJ3X3/uPnNC7I/LksB7RrCjsccnytk4mur6ewZnoWF7MJLkYtDZOCaLyR9th+Pw/hmFWbl3iW1XpuXsfa5vG9/ly9QgthRLZLhWkwH8oTviAixkoyM+IQxpv/z7rOApGKMGOjTWKc3/QjwuoZO2PsM2tldjYhUuxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54bbf3329c1so633285e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759993880; x=1760598680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLfLe9mIdxe47Pj3LvR4pabCTnZl5QqVr+O+If4CSm8=;
        b=YMyikcOAZ5gk411iq4b7sGGLnYjUgl6/snadwg0Oj4iaDP6cUnKFImkn8W4uvrOTFf
         vKmkV6U2hjC//HJguv814u0TbCx6z4n+iNid8oI7vsSfGSun2IouvqKb3dqrLN1XIuT7
         AGY00dmNa3uClq8REjHr0NLeno+wAqLXh6JmXOHNfz/uzmZ5seZZIt2AX8VUVr7B7ef5
         Q0BgRkNSNqBjwqjQd71LM0WpZi5UgFDLC0b0BZzPpUfSYSovuhT86HQHtdAlEt4JJen9
         MFFNwREa1J1T5ew1xvHJEx+hSE8tx0jmf5kDlB5UNV80kMe40c1w1MftSlEEQnPbfJjG
         82qg==
X-Forwarded-Encrypted: i=1; AJvYcCXzctUMKzlgFjlsxA7x9RPXzgK3UkSDWWOIgJ4qwAeQouqMUzm1qBzwZeeULpXjUW1wvHjq3M5LTXDBE0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXq0pAgLR1iz0AHs0fjwPsZ8ZyMCX/SxpLKCAtzmN0XqSJDM4
	LaDD7gpgoOHc4aoSSKCpP0hjCU0/RK8+BCFsy/ERPLgeM52xcw2UJ3PGpFDdLV2a
X-Gm-Gg: ASbGncttOCOhXiDfQus8dPhYCmBFHDvVkCwaD6DwtwoxEXRNH+caMXqQbiklD9SaZR4
	HEyCg1zJDcnAzOUcwa9tZnVJsNe1dDaZl8sHHO8XJtlRhDrVFkIYK1p6WpbCZfHAb2RcJnELW/P
	OMHXnvTR30J7fNreJ5oBXlVGeBS3JJFvE5/gosxE0qu8oUYjutOFR0VdneO8dVeJXEWXu9mebLN
	K23ZJSbpkiAjwZppxvoke/kahSL5izHcqA3SOoKiFY1BzDlRaWH3Edx7nx7jzZBvG6k5vq16Rmd
	+d/7juTX/+pej1CgY2tEZekrQDPNZG+VLU0P7Q75rxfTyKr3nyEdnufVR9dp2nu0XRV1CEmaJUY
	FHZ8VOBh1hMhZwmYrxrv6qxQ3jS8EoBkhdezwRxlF2jsI0Oiy4hTFXbyWXKbaMLMmdTHKZufFJC
	LIABVTksm2kz+PdUtnlJ63fSg=
X-Google-Smtp-Source: AGHT+IEGhYjfRNnouliZ0qKB/kZ89I+8D3aPtEvXVoj7qqH05+5BfbuwxyPLMEZnNs35asOOU1Qm7w==
X-Received: by 2002:a05:6122:3296:b0:541:80ff:31a5 with SMTP id 71dfb90a1353d-554b93b1b43mr2315205e0c.3.1759993879970;
        Thu, 09 Oct 2025 00:11:19 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4ede9e8sm4443436241.15.2025.10.09.00.11.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 00:11:19 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54b21395093so498034e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:11:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbSdnUQkKW2oor/T1fWzfZy+8PTNh0W60UdvGMyVVdJvghV0ojv0lMT/F0T1UeMSd15LParHJ2i2xOvm8=@vger.kernel.org
X-Received: by 2002:a05:6122:a0e:b0:552:361e:25fd with SMTP id
 71dfb90a1353d-554b9193d05mr2881875e0c.2.1759993878614; Thu, 09 Oct 2025
 00:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
 <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> <CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
 <inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp>
 <20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org>
 <b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org> <56784853-b653-4587-b850-b03359306366@linux.dev>
 <693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org> <23b67f9d-20ff-4302-810c-bf2d77c52c63@linux.dev>
 <2bd2c4a8-456e-426a-aece-6d21afe80643@linux.dev> <ba00388c-1d5b-4d95-054d-a6f09af41e7b@linux-m68k.org>
 <3fa8182f-0195-43ee-b163-f908a9e2cba3@linux.dev> <ad7cb710-0d5a-93b1-fa4d-efb236760495@linux-m68k.org>
 <3e0b7551-698f-4ef6-919b-ff4cbe3aa11c@linux.dev> <20251008210453.71ba81a635fc99ce9262be7e@linux-foundation.org>
In-Reply-To: <20251008210453.71ba81a635fc99ce9262be7e@linux-foundation.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Oct 2025 09:11:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5o0mA50yeEfG9cH-YUZspEd-OVSDJP-q+H+bxbqm-KQ@mail.gmail.com>
X-Gm-Features: AS18NWCQgTe_ntCJBOH_V5jiAjzJoJEeK5wkQ-O8aRmmail08XldJV7y3wHkl-Q
Message-ID: <CAMuHMdV5o0mA50yeEfG9cH-YUZspEd-OVSDJP-q+H+bxbqm-KQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock pointers
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>, Eero Tamminen <oak@helsinkinet.fi>, 
	Kent Overstreet <kent.overstreet@linux.dev>, amaindex@outlook.com, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, ioworker0@gmail.com, joel.granados@kernel.org, 
	jstultz@google.com, leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, 
	mingo@redhat.com, mingzhe.yang@ly.com, peterz@infradead.org, 
	rostedt@goodmis.org, Finn Thain <fthain@linux-m68k.org>, senozhatsky@chromium.org, 
	tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Thu, 9 Oct 2025 at 06:04, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 9 Oct 2025 10:01:18 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> > I think we fundamentally disagree on whether this fix for known
> > false-positive warnings is needed for -stable.
>
> Having the kernel send scary warnings to our users is really bad
> behavior.  And if we don't fix it, people will keep reporting it.

As the issue is present in v6.16 and v6.17, I think that warrants -stable.

> And removing a WARN_ON is a perfectly good way of fixing it.  The
> kernel has 19,000 WARNs, probably seven of which are useful :(

Right. And there is panic_on_warn...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

