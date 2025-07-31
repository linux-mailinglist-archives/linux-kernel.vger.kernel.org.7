Return-Path: <linux-kernel+bounces-752046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D6B170C6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA6016DB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0322C08BB;
	Thu, 31 Jul 2025 11:55:51 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071292367C5;
	Thu, 31 Jul 2025 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962950; cv=none; b=Zb3z65xVvPgZHV48sd+jiqI2xn673xBXeby4SZWzhHSEONwodoHSKqSSKMee7A8aBUnQX2t0ce2kxrW0wNvmQfbeDms0LouCQBJIPN7iiZU1m6/1NZ5nbYHmDjXwjY9bs/eSphJ/gw+t1uYb/0AKj0T+6I6eYtPMENp3UlZiK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962950; c=relaxed/simple;
	bh=TMRgIfVaPaMmqSgwxb2UXWi+J4AjACdcEmoH57tphH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIvE3DQesn0YaZumTs8yf3MvXTV6GB7Ek4gJzw95sWHFsvAd6bfKaXu4QuDWIwgs2FTBMR3ycUinmpWn/rmy99ig/hEYleWq82umv/6Lj9wJQJ8ff+f0vJc6A4Me+qrum2z2GZVubD70qfPiNKa8pLfgyRDUsVJ57TAL2gWXIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-539329de448so592947e0c.1;
        Thu, 31 Jul 2025 04:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962948; x=1754567748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgBCsFkQyJsREYZM7w6ELsHHNFNHMwhO0bNKPMndJnk=;
        b=QAXYlftHOkYiUpZ4LuH8GuamIohnOTeDD4A6gwZ3Q37GS3Ze3Wdc9R6hgSNuSFiyj4
         tw7AZwlGt7kL7pa+/WVWwW3oWlwgDTfviXhn5+zvmY08xRRWrw8G53seddIZFHCP/hoL
         tWfefW+2gH7c1hl1gcmqT/x55oPWpmO7L5bLe7WFm29DGlmWyrsV560gabx5GWK2yt6Z
         G0bKJ3Nj1rjY5cqndhp00wzoqWHBkLj/YGWoxfSqdsTkbSMe4DkZGqFpdp84sBijPmC3
         ZdjEgAm/eZ18SphArShN8k9rhvH6oMzKm1N0UrylwQoMdD7ABg0rgubkhk4etyh9OiwV
         as9w==
X-Forwarded-Encrypted: i=1; AJvYcCUBxls41QNgKt4m3SAZ8+KgeNQg0VYrHrks7rIeQ329UzrkGfCvxllW1xDofMKr5ofGxOV9jF2dqRYv@vger.kernel.org, AJvYcCWtFXjdIJPgOLF2o1cUDLo7QOMeLKlW3CCCkVCreE11DONWLXXMM/PSQAaewAw1sAb1a7TKetxs1pe5av8j@vger.kernel.org, AJvYcCXQjfIi939J4PMl1NBrEdcFRLgdU93x6EauDomfefdQJKC34rw6laKmhlmA2TblbWTiM6/RWz+XNMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZFpfLNjwljfa1mHOpDo/CLpwRM+szHXtdx//fBXavBUrq4IXc
	Jxmv7YsWEmfD+TSA8PdGtJnLL0aT2J/PGiVcbZMnHNQXnFN7FKcYU1JjP0oogcS+
X-Gm-Gg: ASbGncvKmcmuEEi5Uba4nRorHw+iirpoW6Al6n9RJMxt/P4ba9hqtzd6WFYWrrwf+yO
	rOVKd8KrbXdSd8vUGXkqvaTijq1R1br5YDov1s0RvK8VQTeYpO7V5O1O1PIF2J6SDJUzi9Fpxt1
	/s/TuP9M3B519u20C87qSoFolNqzxDotRi3cLk2iwef+CD2BrvB1bvm3MJOJu3j+GklnSfZdfn4
	z0xGjK5ImdzG+OFLXYbdFNkuKGl1zmFtpnfagr/zx9PTx14iVRTnGS/bwRyFHd1hQMo4+MY3RT5
	xhhENYV/06O+qTZcySNPEjY5yIZwwWrY+OBWJ3cjcFzaJuKNcRQPgC/tNbU+NKgBTakR2G8YDP0
	WCUy/rV/ntHm4iJp7ZA32VJ93B7izu28lzFKNFJy+qxsVZoZovqnI/ah1CWOZ
X-Google-Smtp-Source: AGHT+IF3QuQc9NWk2cBpOxbjIwUN6+K8HVDbh/wpqudeVaxTDDEc+CJt+0DlGjPVyFaocGAriP3fCw==
X-Received: by 2002:a05:6122:611f:b0:537:c8d2:eca0 with SMTP id 71dfb90a1353d-5393889a4edmr482339e0c.4.1753962947378;
        Thu, 31 Jul 2025 04:55:47 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936b5909asm330191e0c.8.2025.07.31.04.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 04:55:46 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4efbfe9c7a5so1292163137.0;
        Thu, 31 Jul 2025 04:55:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUd6H/L96Qkt44Rcmf1x5Khh9R3u6DeROAmJywPZCOkT+lBg0Ic5htre3Ps9NUMh+e8161YpIUb4Kr4UOVs@vger.kernel.org, AJvYcCWT4bMeUgwGPLVoJAONjY39oF1PHgvmCK+569fwPh2x7+sqgbI5Fyrp4E6XauotdrpbmrqbPqMCpcQ=@vger.kernel.org, AJvYcCXcDCCYLC9M1/8pfVKaVHBNqULwc6jieyVJ+bYJMnSV63/jDNzZ3HP5+kQ6exgl27MLHbLOIaQrmfuM@vger.kernel.org
X-Received: by 2002:a05:6102:6213:20b0:4fa:3f49:a3b4 with SMTP id
 ada2fe7eead31-4fc0fe5912dmr411782137.3.1753962945954; Thu, 31 Jul 2025
 04:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be> <53eb0068-008b-48e6-9b92-d92de2ed4fc9@kernel.org>
In-Reply-To: <53eb0068-008b-48e6-9b92-d92de2ed4fc9@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 31 Jul 2025 13:55:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU2e+5Hf3v=C=sE=+25f_A=2=Zzw5rxvcT=hb75VC=iFQ@mail.gmail.com>
X-Gm-Features: Ac12FXxnc_9pSxwppilSjmsQmBU1O_sD4A7Qq9U2sutpyBkl_2v6bCquVSRwEoU
Message-ID: <CAMuHMdU2e+5Hf3v=C=sE=+25f_A=2=Zzw5rxvcT=hb75VC=iFQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: validate commit tag ordering
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>, dwaipayanray1@gmail.com, 
	lukas.bulwahn@gmail.com, joe@perches.com, corbet@lwn.net, apw@canonical.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Fri, 25 Jul 2025 at 10:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 24/07/2025 09:20, Hendrik Hamerlinck wrote:
> > Modified the checkpatch script to ensure that commit tags (e.g.,
> > Signed-off-by, Reviewed-by, Acked-by, Tested-by, etc.) appear in the
> > correct order according to kernel conventions [1].
>
> These are not the conventions I use for my subsystems and ask others to
> follow, so imposing TIP rules to all maintainers needs broad consensus,
> not (yet) checkpatch.
>
> What's more, I think above TIP rules are contradicting with existing,
> widely used and approved toolset - b4. So no, if you want universal
> tool, please use b4 or whatever b4 defines.

B4 does not follow the proper order:
  1. Multiple Reviewed-by tags may be added in a different order
      than given,
  2. When applying my own patches, b4 adds the given tags before
     instead of after my own SoB.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

