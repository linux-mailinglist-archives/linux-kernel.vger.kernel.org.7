Return-Path: <linux-kernel+bounces-750179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18316B15827
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EAD7ABB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E362C1AAE13;
	Wed, 30 Jul 2025 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IJEjVyJg"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4B8BEE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753850757; cv=none; b=ZfoKVWyJcRBj5CghCvuzE7sfjCvZkhnLoTQPfjAu8C6T1K0ID0IKwCsfJfjfnoy74Pjogiv0XDIrIGrebqQM/AUbGQYEqlLyTfexih2rrwbbewpsaX2H/PyTnFlf8RLc/Zaffkz4qItf5UJbsZj4BC7OyPzEjXEkZXZihaluWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753850757; c=relaxed/simple;
	bh=r2YcwgEWCDFSQb6VjKy4RO0x5titOjsLWH/pp1MQXzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6I+hcaLMTM5OzA5eeMeOgu9iYDrbU+jNnwlll4KIWnrH6iGNT1P0FjZ3d+hTt94H3+CRFylXOfjGWnCGn5aDXUwL8yKPGngkqwf+Oh/GjBvTUBMFQ4M7gC/Cb13qY8cSotryRpgS630vwrYBf/AJHb2N969bwv5C6vOh2CduRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IJEjVyJg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so1062198a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753850753; x=1754455553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Re8rgoh679XqX+af6lmKiaB1sX2YuPBP4jLD1O6l/3o=;
        b=IJEjVyJgOaQB3AKKrj8JHqz72tyrtyhU5ftZwgQPOQnQDcVz44GD/x6euTDV3srV+v
         otpSDAwgisg4UNSEYmgK8YbUn/PT5Ny7JF3QD/1+2nlFY/rs+nS6khqg/R6GaIThdWea
         g07YxCkQhMzJbS/igFwONEoYH1+p73BpaTZ00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753850753; x=1754455553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Re8rgoh679XqX+af6lmKiaB1sX2YuPBP4jLD1O6l/3o=;
        b=RnlymOlHds5clFxs6kykj0KmuL4bbIUqwJqmfjaa/usVrqqQmJbRkeRXwBfkju0P4X
         sAogPFGzG+k36JRVvbyIXx6m6unaI+xqyJ9G+KTb7WzOn9lgOTqJiq2NwXslvc+RCIw+
         rfQfxQr0hzfJjcXrRm6yOmmTfTHVXtIYUHuxX0vuYbsmR8TPmMMsaDkYGG5rdIqcMHDa
         dTRujYnp8Qw1rvBHLz29Uclc44r44C7eF7mJy17skRYr1g2VPt9RAbzLAs18W53kNbDO
         /rrtKfrd/hEYtIVrKDiaWy4XPf3ltM4qQ8qcKBrPdvXf5vBY5I4HFfw1cyHo2vFDhNBv
         cVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM94ztfc+Rqi7VX6UFNibTOcurHqQVzB+8L+MZPVKS/bN+YGx13prILGR2zSakl+YfimKhktIpMIM5Fsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZ5CvASS2UglU58Qz//0vo+0IxhX53s1uodIL9EhGJIYsKB8U
	XFZd6njqi+SevIGRLOuxN7FHEYRF3nI9v2HnK6M+6+oc/JWcnBISRhBr8cGt/HlADhnPZw5IhuQ
	yKbOAwTc=
X-Gm-Gg: ASbGncsqGhl2ahSA824eTXmmDw0kyb/JCJEr7e9v1To9lX5sTW6PrnYIip4UyHb9cnX
	PngyUR16MD1VjunR7mfN+Ylx5NkCFITdcCQjVEUWTsEbf6nQWmu5rK+JseQkHUArHX9mz3NhR2T
	MH5ARCCpcoq9Ljy2M6N1Vz6ZepKEiFT0MUCMkcjXj6QPPxAn3MM9DqmWiuL/xiySKq/iPGQzDB+
	vErqhMcdxvC+waMnwQcf6YJUodG5/QFGvbcvhNh6X8VrRXBwXvIB6K1S4uOLjRj7KxN+bldxMp1
	+zHDljOe0o6nl643B+hRRGHvI7eRiQoE+uFZGrOrDZiRBEFz2DGm4HVQv5b/jYvAvkH2jAXY/3P
	JUoF2BOnL+4s4tEIUEBqYD8Uxvlh6Wv+ryp0DydCreRgVtxZJ7lElNuowG8dvakPkLiT186NP
X-Google-Smtp-Source: AGHT+IHaExZk+oYROzJ8sYS3v8/5hulWws/6X93tuj07GEO0i9pxxSXokzV5rsMjZ9CeaVY015k7Vg==
X-Received: by 2002:a05:6402:514:b0:615:4c85:47a0 with SMTP id 4fb4d7f45d1cf-61586ecca24mr1636840a12.7.1753850752939;
        Tue, 29 Jul 2025 21:45:52 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500491e01sm5313189a12.8.2025.07.29.21.45.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 21:45:51 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso109557566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:45:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/J0rG3KY41JiMC/s515eVFGD98NF8enQJVOghenz9WgU3fq8c/86dTmECBVXhyD6xv2Of53lYPR2BnsA=@vger.kernel.org
X-Received: by 2002:a17:907:72d3:b0:af1:69e3:c074 with SMTP id
 a640c23a62f3a-af7b867d9d1mr788671166b.8.1753850751419; Tue, 29 Jul 2025
 21:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ecu4idvc.wl-tiwai@suse.de> <CAHk-=wjj9DvOZtmTkoLtyfHmy5mNKy6q_96d9=4FUEDXre=cww@mail.gmail.com>
In-Reply-To: <CAHk-=wjj9DvOZtmTkoLtyfHmy5mNKy6q_96d9=4FUEDXre=cww@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 Jul 2025 21:45:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvoZuw-Cv2Bx2ip8Kq4j9jw0meLBg0xz8GbxzFmQK7QA@mail.gmail.com>
X-Gm-Features: Ac12FXxDohtxbX0_GRufoIQKu-T8t2bVC8vlOI2K4Vxui2TlmkhvVGE7Q5GOCrk
Message-ID: <CAHk-=whvoZuw-Cv2Bx2ip8Kq4j9jw0meLBg0xz8GbxzFmQK7QA@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 6.17-rc1
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Linux Sound Mailing List <linux-sound@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 21:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think that's realtek, but when I enable it, I get this mess of
> "which realtek", which I have no idea because the ALC3271 that the
> kernel used to print out is not mentioned.

Enabling them all makes the kernel recognize it as a ALC3271 again,
and it appears to have loaded the alc269 one.

But sound is still gone, so there's something else still missing. But
I'm heading off for the night now...

             Linus

