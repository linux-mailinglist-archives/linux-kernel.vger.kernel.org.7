Return-Path: <linux-kernel+bounces-750171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750D2B15817
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D07817FBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6491DC9A3;
	Wed, 30 Jul 2025 04:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PW4ffQOA"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E6198E9B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753849302; cv=none; b=rNSx2Mb5KmCCz5P8dn5/obvNpnefkdCJcbrmROs/hXueOyPu1knj4dn0cVxRFROrW1KENnR3xkEDEqOFHUbh2Z7ICetXkFeN7d0CWM/Ca3tJVJseqii3E8VxrDMOEfN9/tZj3++KtrSa/q0aKysHS29PcFigSYedIMdbtXzsE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753849302; c=relaxed/simple;
	bh=+yVIEwWI/pytYe+qFiWwkZsx+4eYlSH05Mm/XDATRc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWX0C+C6p9eI/HtEAURGvMxmNzzx0wu7OgNwdxjxfC/K2K7odtgASQM6Az0A1dp7jvCd9F2lmUF+Pcn/F5hXw6kjSXNJwvmwAiVeV6IDvtHIJNiLMorg1B6el9gGhWEkT4I75K7BHFEFSqm867T/t963m3ccDPEs3kVXUc2vLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PW4ffQOA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb5ec407b1so1051751366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753849298; x=1754454098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6M9EqKm5huN0PkmwCjBhaBvdR1Q+MeBLJNqjDIEMaY=;
        b=PW4ffQOA31E41A1bTvqoVopQdHlQXuCj3j+jvy+lKrKX8LTdLKVYMxnhANqxZegi7g
         RUbNUDnAgl6lDnaBlW49qQxtKYu+TEJ4r6nbLlkfXHSd+7OCElG3zCjfa151NrkHYyG2
         8yk562dTkHtMvJiH0+9NoMcep/Ek8NufeyDg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753849298; x=1754454098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6M9EqKm5huN0PkmwCjBhaBvdR1Q+MeBLJNqjDIEMaY=;
        b=w5QSoMYOFdvq7SQFgiXD2sOlFsMKAaOmt8IfT4ig+KqJ02P/aLob+gTYsQAljh29tv
         PQunyouMn3ZXrBDynvYq7pGxK3zId7jTE2rqAlr5ZRexjEqs5HZusYze/0gN7X6QtBWC
         zHCkyV5hVZtRY8dK3gjR6f1jOM+ObqiOpxQYIO/1B5zW0UUEpYzfjUKtyA/XgRJBDML8
         /qU+0B6AcaKycZhw4MIArpsX1pYUu+XnCfVrwK/DjuNwHtUB10e85fjJQSw8ucbIH3ek
         hLxHfjidIBAkCblBC6CL33BOn7fEJnPPrZszP7iKYBeCo2FPdXrCe9LxO/iyaWhUi2Gz
         La8w==
X-Forwarded-Encrypted: i=1; AJvYcCUw98GOh4IGbMQDrskrMd7XG2AWYRRgX2EzbJmjVEeyThhTEH53WF5rCIJOxrUCvPMl4FAGlfXuj7EIZWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJyXXJkZ1sRPH+QuZ1vH+HxbQZLF3B7/RLK2TCyInM4RZc4mec
	9/aLlrAKCNj00WzozDBjIBDPb5jWZw2c3b3jfu9OlTSa4Q4FvJ7rrZmdo3YYlXOisCRMTC4nd+B
	3Dk9oCuA=
X-Gm-Gg: ASbGncuXH5mdXocC/9ezF5xCsGu0SjNWhJyzaPBYPqMS1cTBMEnTjL0Y8ejrsKl2lq2
	ZxE65NbHLD1T8aZTP9tzThyhTl11UI8BnsIKvVTCV8cknZLorBmoI60cin+3+lRJeKn7vkgZOs6
	dfaYUwPzMv5NbJoeDVNBQGHlKuMKWxdo32JKLmmJO6qBBUeUJidINbZ5w9vj2p1/KbEYZCKfnek
	Jpl6x7tW41IEvsWzK+m1rdvY2QqQn5e5HnUKb2/5XOBITgXI5lxHWvepzi7cDiGOaGpgIeMdge0
	htVhLODJjVFcRlj+Fnk6BgFf1q9DMhEz2MwBXNF/7lVMT1WkiG/MsVO6uR8Rsk8tiv4sp7GLh8Z
	kIApLx/aYHtUt2fqM34gpjvZ+gN3DZ9fFiMkMIFBj1zW0pBYPk6XU4Um/aX32c2ZS6PlR5QGCD+
	O0M0HkvcI=
X-Google-Smtp-Source: AGHT+IHIkyddUxVvoVvkxOljVuij5Y4bdoqyX6umj+GxgAg2KmCLiw3bU8h+LBCe6ji1k+7uGwdliw==
X-Received: by 2002:a17:907:3da9:b0:ae0:d9f3:9131 with SMTP id a640c23a62f3a-af8fd691997mr200297166b.6.1753849298204;
        Tue, 29 Jul 2025 21:21:38 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585ff7esm683848866b.4.2025.07.29.21.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 21:21:37 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so10738883a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:21:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNv432gzDeWWnE3mCgucacSJ9JRgsbdACyHyWJ6Hza0P4KtCoHut74mtms/f+TdccaiqS9rS+fTHixtm8=@vger.kernel.org
X-Received: by 2002:a05:6402:1e92:b0:615:4c9f:f7cd with SMTP id
 4fb4d7f45d1cf-61586ec8aa9mr2125416a12.7.1753849297125; Tue, 29 Jul 2025
 21:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ecu4idvc.wl-tiwai@suse.de>
In-Reply-To: <87ecu4idvc.wl-tiwai@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 Jul 2025 21:21:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjj9DvOZtmTkoLtyfHmy5mNKy6q_96d9=4FUEDXre=cww@mail.gmail.com>
X-Gm-Features: Ac12FXzaCg0v1L18IAkSLioNqM5JZfdRDn7g4517txlEqP3wNFRnIiRiJ4NzmgM
Message-ID: <CAHk-=wjj9DvOZtmTkoLtyfHmy5mNKy6q_96d9=4FUEDXre=cww@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 6.17-rc1
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Linux Sound Mailing List <linux-sound@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 06:44, Takashi Iwai <tiwai@suse.de> wrote:
>
> This includes lots of file shuffling due to HD-audio code
> reorganization and many trivial changes, but otherwise there shouldn't
> be much surprise from the functionality POV.

Hmm. I suspect I have been bitten by this on my laptop. I no longer have sound.

I also suspect that it's purely because "make oldconfig" doesn't work,
and probably turned off my old Intel HDA settings. Or something.

Renaming config parameters is *bad*. I've harped on the Kconfig phase
of the kernel build probably being our nastiest point, and a real pain
point to people getting involved with development simply because
building your own kernel can be so daunting with hundreds of fairly
esoteric questions.

And it looks like this pull has basically made it all worse, by making
previous answers to those esoteric questions null and void.

Now, it could be something else - like a real actual bug in the code -
but it does smell a bit like just silly Kconfig noise.

My laptop seems to think I have headphones attached, and there is no
sound. I think it's some generic HDA setup (the kernel messages do say
"autoconfig for Generic").

This is my bog-standard Intel laptop from many years ago (Dell xps13).
I am seeing snd_hda_intel and hda_codec_hdmi, but it *used* to pick
out ALC3271 and apparently that just magically went away

I think that's realtek, but when I enable it, I get this mess of
"which realtek", which I have no idea because the ALC3271 that the
kernel used to print out is not mentioned.

This was _singularly_ unhelpful. If the answer is "just enable
everything because you can't know which codec you have", then why have
the question in the first place?

This whole "ask people questions that they cannot know the answer to"
is a disease. And then the questions then randomly change, that's
*worse*.

             Linus

