Return-Path: <linux-kernel+bounces-861276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A89C5BF23F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F05D4F7CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAF82798FA;
	Mon, 20 Oct 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YsRfBMJ0"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBCF2773F4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975846; cv=none; b=Tw9vd/JsxNiiTEGyGSH8M+jlPAo/tEKh4CHJ2kj9hNdC/57lQmCdxY64ruMTMc2cEJQpEEBz4jWv2IGz/L+VPNnVB/VGWmbGOcedHWnRW6717Qr09d9tpXL6w4TTcu5j+58+vDLc8RIMWV7SYD1gvR/NUiajoH2kaMvVasI+DZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975846; c=relaxed/simple;
	bh=xwIXqBAmA1dcar7JF/iTlvTwRIlLnoVPBG0aP1bH5Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRySnFtI602zuU//un713uzYjMub9+/XthyQFiAmX5THLyA2+/fuYgSk3r3p6qhvf9tiqOgqSo92ls526jbHSxvp25tnwv71Ipw9cDXG/DBn9fut9cltP26txLsA95LnhO3CmPX4a7Dm/+D7NWmG4XXpe5dEMBl1VejHjwIW6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YsRfBMJ0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32ec291a325so3272120a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760975840; x=1761580640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiJxxZ+vv+k10xTHGoYkcZPi1+rVppR8/mhmbPdSZTY=;
        b=YsRfBMJ0B2Rl0FB6ZjnzlJcL++zChoAqx0jB5a8Ns3FKyM3++9PDqC20OlM0L2tYUS
         BIlq9M0j7hfA33DwKXJKZvwJMkygIomU1sbdweQ+oI4Z91ZqOG2spNfjHsIBRs+4LJDH
         WvNoCt6gk3f+G45xb5dH4QwuHtfg53Pr5dowY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975840; x=1761580640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiJxxZ+vv+k10xTHGoYkcZPi1+rVppR8/mhmbPdSZTY=;
        b=bVERpqabalFlhk05N5AgY9ySLho8//5B62XwcX2jkUzYgW3G3i1mhyLJh7u4xfzekC
         69NryQIXh9Lx93wvAWZ8u0MCJ/I8NNnt5H0yOV7pwbqPGcR36kDL2fzyY/2/M+W0fVUt
         Jbnu+uuVplPx54LRHlwtco50EllVC1jdL95gzGbMbHNmzQlbAz8clzImPW3MSrspUC9T
         XWeWGv1FioyBBsILFxS6lR+8kZtxbs2xQFBvFSMoxW38s7WX8e9w7v1mzZyv86Kot0f0
         wZsvpPqR7EYofYcQb0ep58TVGyxmK0G0TSO6WCXQNQ6fBu+kkZ6EXLdAkSqqbJ6FtddQ
         BmTg==
X-Forwarded-Encrypted: i=1; AJvYcCUpGEqPIr6kC5zcO3cTtf4q2YFG1fd/LctgUEgPWwFr0FaJn/aQHS/5m/MLC2xWkjILriEamgO4L33dJhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqaCbBvCi+ujfF0+qW7BviD55QKv4/fRdP/bUWMR2jSeoRLeE
	feAVLI9+d4LGYfalT1jjdNBknvyLGvOf/jbPt2zSdysrEbD2f24jkmLVenwffvsSZX7zE+N1f3d
	vN5I=
X-Gm-Gg: ASbGncu7hSjW2dkBm1Xur2OUSY8vrDjVI05gXyeQanIhl/58iq8mbFj8V8+Zph1J4S6
	dHZ1sfQ6OcGXSOxzD2P/QhQARPlVvdFlH8JneYMGSgnDUvMxuUNrDeZLzVE3x8UTP+x3OEgmkcq
	/srSkLKYb4rjOSH4bKF5HW6QtArxKIh3iH4CvWYyYUpcjtgi4PuwZSm4JNO2wTThMnSEpbiEjBV
	uCcbW4isIpeFR4LPbcRoYVKksh+H3NX03YrwQCmTSfogoZ9br0wQpGdMneY5RT9PwMKqDjNuHK/
	gGibH04nYE10mWz7uf3DwuDiaW9tkEGB2fubQKrrXyRbGOo/GtbsbvU6rETfW14cfT7eCucZ1Bj
	56BBUWKAnbtD0pGXOn2q8RZoOlkijdt6FvDAqYXe3dPKpf7JIGyL9+JQFIWtTcp6kxgNeGADANa
	EcmlCd7p33mDzzBUx7qYHspPvoSmcGL5iyVBQst2qZMug=
X-Google-Smtp-Source: AGHT+IHDiH1aYdwvv93R7TX7jQIY/IZe3gsarGD9+02i5B0f0v+O222yYc1V77jJKbeOh5gy1Qqq9Q==
X-Received: by 2002:a17:90b:38c7:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-33bcf90e717mr14888354a91.32.1760975840415;
        Mon, 20 Oct 2025 08:57:20 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df5c2e3sm8380748a91.11.2025.10.20.08.57.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:57:18 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290aaff555eso43645015ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:57:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaAJdHjcNY6QfxlmaW4lAgS+9QS+HeEA48sQL9cCwyj+bZnVER9Uzz7gi4L/MMOzEnLdubRd/+F66pQzI=@vger.kernel.org
X-Received: by 2002:a17:902:f70b:b0:283:c950:a76f with SMTP id
 d9443c01a7336-290cc2f91d2mr178675015ad.43.1760975837322; Mon, 20 Oct 2025
 08:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org> <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
 <CAMuHMdVT-_UVAO=1jvTPEjKO0zy7H1rUrQz1ubMfHivF4HWJNA@mail.gmail.com>
In-Reply-To: <CAMuHMdVT-_UVAO=1jvTPEjKO0zy7H1rUrQz1ubMfHivF4HWJNA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 Oct 2025 08:57:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WeXOj_hyA=V9hMLHOJ_m9ui5mP6cRv2DpjXnR62_nd2w@mail.gmail.com>
X-Gm-Features: AS18NWCSPtYpTRxoXhANR_SKtzjhRsw8M96cqtpjZzi7ZfEhFf6fRrC2_iYy5H0
Message-ID: <CAD=FV=WeXOj_hyA=V9hMLHOJ_m9ui5mP6cRv2DpjXnR62_nd2w@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to logs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	Andrew Chant <achant@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 20, 2025 at 8:42=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Doug,
>
> On Mon, 20 Oct 2025 at 17:33, Doug Anderson <dianders@chromium.org> wrote=
:
> > Printing the command line to the kernel log buffer is one of the very
> > rare cases where:
> > * There's a legitimate reason to print a (potentially) very long
> > string to the kernel buffer.
>
> arch/s390/Kconfig:
>
>     config COMMAND_LINE_SIZE
>             int "Maximum size of kernel command line"
>             default 4096
>             range 896 1048576
>
> Yummy...

Wow, what are they expecting to stuff in there? An encoded initramfs
or something? I kinda feel like the 1MB number isn't something anyone
expects but is a number picked to effectively be "unlimited".

Do you have a suggestion of what my code should do if it sees such a
long cmdline? At small numbers (4K, 8K, maybe even 32K) printing the
wrapped cmdline is nice. Above that, maybe it should just print
something like "<cmdline truncated>" or something?

-Doug

 Maybe after 32K or something the code should just give up?

