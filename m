Return-Path: <linux-kernel+bounces-723191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C64EAFE437
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868BA5817FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B58A286436;
	Wed,  9 Jul 2025 09:36:54 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06888286405;
	Wed,  9 Jul 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053813; cv=none; b=cHW7kblCioieGb5nE2Sxpqy+/s8jsfU0/l+lVkc1GDbHytW0gLqt98Sn85NwS7NwZYNjXpBnjmQE8bAMwEbS6dep7VT8zVujo9xB7l0r7c3U2+9A0GETcZ7Zj1f2Tx+ozt9lvlh+m7aObPIHJylzMM5329tUY5j8eY0MVJppK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053813; c=relaxed/simple;
	bh=UVfrPcSoIl1n37Ti0M6ZveSUOms+C/d2luOe2kFGwvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asc02PmXb2kTGn2zLfwujdLrd3ZGcW5QkR0xa2zG0M6MBPK3nNxrhRQGlPuTREWHfhQ2pO2S3muegtmyKuuyQEOMx1r/NZYA8aj53RGIAX5BsUb/6JsZ363+fIq6fV5n67yFtjLXI2HFd9LsYuadEzv09DpcKwg8nOBvjpAJyrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-611e455116aso3500097eaf.1;
        Wed, 09 Jul 2025 02:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752053811; x=1752658611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaYo87+BQlxJo8nXT672UZ6lIq0mJ1Uoyr7Ysb9T/Bc=;
        b=vC8q8a6gURzyrhK3aR2cTa3kBsHwGusIUuW7jI4u3vjaob6gZJIfy2kNm0ZusI6fFM
         ZAZThbv4ake7CF4myvjexPHeB156oYTfqpvZjx9NbrFGh7q6O1PW1vTUA2lGloicHPQO
         8uJjYCe2B1z1i+NRtRCI+7b1hxo8J6/8kmZIwxdS3H+U3mmIJXOziw6Hi3MWaSQD2OQ6
         jd87s57q0YNJJmV4rUZlNYoAfmQ6yMl+j69wll2Yz3bpz8vnMxJQlHLIVFhm/qcbcjwp
         rfEB7EG3WzwR7Bu/8KP8uMED7KvYP+J/7hRnpuLWDwXUa49HMwJK0M7HLRfzKWScciVT
         DSuA==
X-Forwarded-Encrypted: i=1; AJvYcCWEnF5bcPaSINWKDAqw5SSkdOT5YsPgNXvT9ea9Zu+URJ8uWm3Mr8q/RqSmSZDKMtxXd2NhgL4KerpsL+I=@vger.kernel.org, AJvYcCWXHFtwg88vYOn/2h/+wOUhNKU1cYw1EDdE7n6j7i4hD7i/qPxpNjI/Am0gOaI8JMmIgffyYWW/eNt5nYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzLRvAZFe05e93wAqM9YLT2m5v+3DOu5gZP17LbbKX2BY+MBz
	Lg4SMLHN/FVN2V7bzsdTzYgF49g0dDg78sTGtlnJuZu8E/LkImhAjbeG6oaAfvOt
X-Gm-Gg: ASbGncuv0wE7OVaxc4TGLJHMm0Oqd7abt3giZs2cYWgTCIPtZnueAPvQpuxMTvJKn60
	Gez3C2OFjMYodFcwTXf99NMcQwQPKTi0LA9iQ8pITSP88lXskZt3865l/g97MrCjTOFZJ9g/Q/v
	7h5gx/c03ET+AUd8M0u7H5RmAhzG3yWcoYkRP3DOis3ENCuOtBHuoMdHmjFC0vqGJuF73GFcDwu
	ESvg2MR3yOt4z90orapuHT7zb9UmIoumQAt0kf2+bXXsKt4qzRIJ3KK1qEJHLspVpgXDBk6SQE2
	KLLK4p5vzy+XHylqdsn8MJxFhbg7Y5H6UUSECOacsve+ytrBn4gleUHe5tNK6GDT5ycwPElkYwz
	1SUIG8+4V/nxcCS0jfRuu2CcGcu+NqS+nHIg=
X-Google-Smtp-Source: AGHT+IHdtsW9wbUxeyfgLdI3F5GPtFVxKyfiSo964PBvJ+7HLzXSb4lhgqrothwJdTt3erjykfQ6/Q==
X-Received: by 2002:a05:6808:1707:b0:3fa:82f6:f74d with SMTP id 5614622812f47-412bc34a2b0mr1320787b6e.23.1752053810571;
        Wed, 09 Jul 2025 02:36:50 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40d02a43f8bsm1953629b6e.12.2025.07.09.02.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 02:36:50 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-73cddf31c47so886507a34.2;
        Wed, 09 Jul 2025 02:36:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2RmssMGuv77ExwaSWsZslscX3ZXEPJOZfu0jyAI1NBW2DMAFdz8/QiY252lwVhRIDi5W7eRv6xHPaC3U=@vger.kernel.org, AJvYcCVH7XvZJ+eS3FTfAXwmS1ai8GWPxSqeXMa0sPf+h5lUtj2wRnESZRfJp8mQjyp4bUDZooxUGBVAjUy4QFw=@vger.kernel.org
X-Received: by 2002:a05:6102:5091:b0:4e9:d847:edb8 with SMTP id
 ada2fe7eead31-4f541524375mr852293137.7.1752053378478; Wed, 09 Jul 2025
 02:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0886d3eb81bffbc1d48e701cae21c42cad29fefe.1751988704.git.geert+renesas@glider.be>
 <20250708-jubilant-abruptly-8ff77f7986ca@spud>
In-Reply-To: <20250708-jubilant-abruptly-8ff77f7986ca@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Jul 2025 11:29:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwbHoEbjC2y4kpJuhx7CYsRxO9Y+eCUhJkKogk=zDs8w@mail.gmail.com>
X-Gm-Features: Ac12FXyZ7GDlpV2Gr-dl8LZKLuryF3iTrUZA8bGhHzGqftY4PGwLQkXHpr-fgIY
Message-ID: <CAMuHMdVwbHoEbjC2y4kpJuhx7CYsRxO9Y+eCUhJkKogk=zDs8w@mail.gmail.com>
Subject: Re: [PATCH] riscv: defconfig: Remove CONFIG_SND_SOC_STARFIVE=m
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hal Feng <hal.feng@starfivetech.com>, 
	Xingyu Wu <xingyu.wu@starfivetech.com>, Walker Chen <walker.chen@starfivetech.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Conor Dooley <conor.dooley@microchip.com>, 
	linux-riscv@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Conor,

On Tue, 8 Jul 2025 at 18:49, Conor Dooley <conor@kernel.org> wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> On Tue, 08 Jul 2025 17:36:48 +0200, Geert Uytterhoeven wrote:
> > The SND_SOC_STARFIVE Kconfig symbol was removed, but it is still enabled
> > in the RISC-V defconfig.  Just remove it, as it is no longer needed.
>
> As I mentioned to Palmer a few mins ago, I'll grab this along with a
> couple other soc-related defconfig patches I have. (Apologies if this
> goes out twice, I got a warning last time about a timeout, so ending again)
>
> [1/1] riscv: defconfig: Remove CONFIG_SND_SOC_STARFIVE=m
>       https://git.kernel.org/conor/c/493e9b085299

Sorry, I forgot to mention that the commit my patch fixes is only in
the sound tree.  One other patch in the original series did include a
defconfig update for a  MIPS platform, so it may be more appropriate
for Mark to include it. Or just wait for v6.17 ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

