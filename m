Return-Path: <linux-kernel+bounces-762061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5102B201BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D6716EB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BF2DC34E;
	Mon, 11 Aug 2025 08:22:52 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2262DC345;
	Mon, 11 Aug 2025 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900571; cv=none; b=bzjmX/oNf8bRYne4M0iz02ch2QjG/DuBmKuMYKkaDimedbHJ3hsdqjcrDyTzyYQ+9FLNZjVZnh9e/HmzYuSkxn3gQVybeWKgMrEEigqBCDUwhVldOWGUgAH54Oa1L+LfI24sISwBdISGY0tKF26ov65TUoPn7DbrVwze2NQbVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900571; c=relaxed/simple;
	bh=13ZSHRJPpFz7R1WvuHXgNGlRZ7vRrMywvXSWi7KcRTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lrgx3SErkGHxD+hbnnxj4LZD6wtHOcdWT1kiosPFKLU0ziCYPA+vDIq1Qso2eST2MhA6tm2ttgMQfxGVev+nTym2E2a3SYphJs2iMWPfLrCmHYo8ZQPo8J5PEGmN/2hGFt7BlJruWjmaTUC8WfsYZI6EED/1OXz3iXoSb6UbOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4fc1a5e600aso1492338137.1;
        Mon, 11 Aug 2025 01:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754900566; x=1755505366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIuRB3iP/akNqCi3078AVLirx7QO0LT0m7U0z4UnuBM=;
        b=WVmC9QtN5z/l2lHwVXiBmVtiZS366exw/c8j4tNHHsPCfc3fbBWRQityjXvF0WmR3X
         VXkvbTYEz7cRBHPcwpcluwEi8yKQJSRYqjiln0FGN1G2WEOJvxFArd/9xcdfeqoYSiuS
         v+m9D8smKHAYCQoLOkwO9jN0zidVNeVR4avsfWcIEid2YuMvEoFITSM0v8UdpU3nfgSz
         Bhm0yxp0op5XLN/Ily5HI0NPItNzCVfCI+vjIaDVDJYDTiYmikKBy1hDdoSHP0BahNAL
         8+dJkgAqqPxTsQ8x7pKE7RY2NOCTfUJj0gkMWKs1Fc1UTLgEr1fJCtj9JEpupPeq94wW
         kvBA==
X-Forwarded-Encrypted: i=1; AJvYcCVOPvJMdgHQ5jVmYZMG3NbJOwk/EKUo1e5ojau8x4n+lqbBgdmTnpx5IgnTHaolknRBxzzftKGaJRFC@vger.kernel.org, AJvYcCVVrmxtWEsZSUlIr3hZ0j18vlZVZWbOGaoaK0VMgvvASLl9QLxlngxE9eHRyLLRXuGrmxb9FniDqn4=@vger.kernel.org, AJvYcCVyEAaC3BFpUW/XDFLqm5vmnwlt28PCT2OSVb3xwMpW9jf1imkDefJDD3W41RRox7V58bMqFNGfqP+Gs2Mb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyafr1gzndhtziRjTROP55jK9zwriZuxvPTkSvRHQyk/5uGX7Re
	4+4PURc87s/ZDfotB7exX8hOFcbMzBHeRJAq6ctIt8aj163feA5J2WADPTRjrrz8
X-Gm-Gg: ASbGnctDRFOXEKE2KR/bVbSUl2JOCix/irVNXcaBxQPBdwOJLr7K3DfsJbh5bm7xUfH
	4ttst9irTnOKJT2OW2xbkTpo1NGFGimBtL3Mr2wrnVTBfTeR+RrVTKZcQk9FahzUQglSH3SLgUH
	41ycCQEGAJFN2HfkF1hdkN11phWa9SLJtvRQ8KncxZqHU4NIf1TrSY5YZNQ9p6b1DNk2dTfPzES
	ohdEJ9iSZq/w39MbzkhnvIdjVQw/3At3v8ixsmNtQfPLdtxiSTugg58Gs2wudVyrpkl1k6CnDJf
	ZnT1fgsZ/EYZ0objSakiUMMtzlLP58edfKEv+kEd6SV+OfQE+C4Q7AHTEfdHn5xBfCstocCbUD/
	cRpylqV1j4bGdMYgorBdtZpybvSYG4kbTU07gqworBwfCINKxQt8tdthUeVOU
X-Google-Smtp-Source: AGHT+IFWDcggpQeYc1KDeU2IbOgScnRMvc3QIaZsK3qE0NGh+xCujyzLFlxOx+AIwqk+HDWGdOYJOg==
X-Received: by 2002:a05:6102:2923:b0:4fa:85f:31b8 with SMTP id ada2fe7eead31-5060eed3adcmr3654261137.14.1754900566153;
        Mon, 11 Aug 2025 01:22:46 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e029cd3d4sm1801344241.23.2025.08.11.01.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:22:45 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-88bbfe763ecso861417241.3;
        Mon, 11 Aug 2025 01:22:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsD9r32yRwrKxEuSyJyHlDAMQKoeO5w7C7uPG12cp5ci24zXvVkVSq0lFCXw2lvQO6YaKqpMQXSR4ieLW+@vger.kernel.org, AJvYcCWUkNmODdkTYj3Rk7ccMiPvt0Mc1XEpwerswM8VHHQnv0QAbNpNa/KTSFgPke9LcixfcoVM2yulHcg=@vger.kernel.org, AJvYcCXQtXrNMlHQEhwMY9gqEjyXoTDanyP/0ZoL7L7ZJ0RSNcs69RERDrC2Ak10PE5Xf85z3QQ0sTliFYy3@vger.kernel.org
X-Received: by 2002:a05:6102:418d:b0:4e9:94a3:1a34 with SMTP id
 ada2fe7eead31-5060eed4706mr3996515137.16.1754900565091; Mon, 11 Aug 2025
 01:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250809234008.1540324-1-sashal@kernel.org> <20250809234008.1540324-2-sashal@kernel.org>
In-Reply-To: <20250809234008.1540324-2-sashal@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Aug 2025 10:22:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWaVvAfm6LMxSpPuz3yZ7FDAexbUTOXrg58TqoWbce5ag@mail.gmail.com>
X-Gm-Features: Ac12FXy6CXH9U5loAkdXYwlSYPEgP4IQrmSAM4bQTTcVUXvNK5p10n-HqfSt5x8
Message-ID: <CAMuHMdWaVvAfm6LMxSpPuz3yZ7FDAexbUTOXrg58TqoWbce5ag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] README: restructure with role-based documentation
 and guidelines
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, josh@joshtriplett.org, kees@kernel.org, 
	konstantin@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

On Sun, 10 Aug 2025 at 10:09, Sasha Levin <sashal@kernel.org> wrote:
> Reorganize README to provide targeted documentation paths for different
> user roles including developers, researchers, security experts,
> maintainers, and AI coding assistants. Add quick start section and
> essential docs links.
>
> Include proper attribution requirements for AI-assisted contributions
> using Assisted-by tags with agent details and tools used.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thanks for your patch!

> --- a/README
> +++ b/README

> +Who Are You?
> +============
> +
> +Find your role below:
> +
> +* New Kernel Developer - Getting started with kernel development
> +* Academic Researcher - Studying kernel internals and architecture
> +* Security Expert - Hardening and vulnerability analysis
> +* Backport/Maintenance Engineer - Maintaining stable kernels
> +* System Administrator - Configuring and troubleshooting
> +* Maintainer - Leading subsystems and reviewing patches

Kernel Maintainer?
Driver/Subsystem Maintainer?

> +* Hardware Vendor - Writing drivers for new hardware
> +* Distribution Maintainer - Packaging kernels for distros
> +* Agentic Coding - AI assistants working with kernel code

Given the extensive split, what about normal (existing) kernel
developers?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

