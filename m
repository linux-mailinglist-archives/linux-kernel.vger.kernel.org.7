Return-Path: <linux-kernel+bounces-864597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 916A8BFB250
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9901C35143D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263873126D4;
	Wed, 22 Oct 2025 09:24:05 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AB309EEA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125044; cv=none; b=JStaHzX11FVcGCgy8CBVVw4j0N56XdK+l9Bm9cS4R7FvYNhx04RDf9AZOoQ/sAoW/abSRnW2cPCOP0SptVczmtg21xikFm6FIkc8Zncdshq1VTkvWTeSXxgdWcNLqSGVZJNCaVj8ujSmDCm2/bh7zkf5blztcIRRIk3Yw6yQeGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125044; c=relaxed/simple;
	bh=HUnjO6dtk5AWT9DiSovCBAivfwsSKV6yep5fH+0IyYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gz+38kBDD1uweJ/XOu3Ie2vWCTtKJHLogjisa+R2owh19QlDSY18FgDfA9aDWO/8RivmE0WLG4kF7PiAl3b83KsvVS75riXnghM/eapXAulP+jO0PErI3Jf4mjYkWUJkdrHT1Q6vFJBmog2n0Rapap/U+a1mT/ZJucZm3iQuJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f67ba775aso8595379b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761125042; x=1761729842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jg0fiFle/a5r0E/SHz3YpwUQml9X2EJGFYzOtSP4KZk=;
        b=d+yg17lz1uGBoO6vHQ95F6SU+bqO7UAknHDgexgJKQWfoyKNvo1zfc+1SmwBBR0E/h
         fjX0GDdhB7fLXXAgFfI9flmeWuHP+/Ayxf0B+0B1NlKPnE90V0fladvgP5usFMe4OE/z
         MOWeUhZ82+YYdCQ/zt/pL9bCISmzQSvHbnFfGSe11FzTiHURl3xXyfIjw9OA6gf8R/ma
         gLlGOeZRfTwJvBWJq3BOPH8UMaSG2saaHmmJGIz6iga0yfmQCrKLziBucYMAthN8rq+L
         NhybiBrPal7cWFkfs9qfvxUEMfXz/hq7XlYBDPIFyCoIdClZJLsmdiPM+iEDI4VfAiVS
         /2yQ==
X-Gm-Message-State: AOJu0YxQf1sy0Vyg2cUITrYoNp+3pvkp7Xfcs2Ub6VIxRcFukvLc25M6
	Qfdlqr3WJbeyR3trkhh5T5JMFKwhlQBXZq/DWFirh6TUfxbbJZUSNJfd5fNU1cwY
X-Gm-Gg: ASbGncuneiL4AADKJI01a3U0If3PFNe/e4hHXISHfkH85PhsieemkH9yodWg4V3ZQHy
	fSGm/Z3siYO0rhAVQd3LFMzEngvrzehVI3ZTfAAsyULj/VbHy5/OckIZEgdpPOqoGHq+8d9Fmm7
	ZLuFOKgkMs364uLuZvx1Nx+ZFzNubwkIM8VF6vLk3c2Aj+Q4sV2tIWaaAhFGwD+a9LE77N/AfNi
	Md1W+eexMk5mwlvV2o34Xb4UDOJR8FoWfo9Eanc2+1xZ/CuXX9MMNlwCLDP1EH418oBaa3AgDjt
	tAdaYpPubvSYDCE+Jr/C2HuiIiSHIo3dW66gHfaCCb861DHyTI8aCl1l585m7guu5oNDDAPJtmV
	iGIiCmSInHDRDyMhBIgzLQ0MQcoaehhg4zeFI79no9C18xsLGmTzN9b/Be88ysfplm/6bzhmIoI
	Q2OEsgZYwVOA0v080eS00PKUeSnceeTdsf4ipo42BXAw==
X-Google-Smtp-Source: AGHT+IEyPJimJ54PJPRiDfqdjY9JYhPD2G7HyJ7Bf2hPTmCnaYWRz2SFgPZrUsdOHPMD81Fkj7tBkQ==
X-Received: by 2002:a17:903:1746:b0:28d:190a:1913 with SMTP id d9443c01a7336-290caf8509bmr233019325ad.38.1761125042235;
        Wed, 22 Oct 2025 02:24:02 -0700 (PDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc2b1sm133239535ad.27.2025.10.22.02.24.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:24:01 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a26b04bfc8so333874b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:24:01 -0700 (PDT)
X-Received: by 2002:a05:6102:c48:b0:5d5:f6ae:74b4 with SMTP id
 ada2fe7eead31-5d7dd62a873mr6134044137.40.1761124578028; Wed, 22 Oct 2025
 02:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
In-Reply-To: <20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 11:16:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAbMoQdeM5-F1YYOfEdcPrkTxdbsU8+TAYO=WuMzCqCw@mail.gmail.com>
X-Gm-Features: AS18NWDsxMzaMxqdF62ijuMGcK9XAjP5LOhXCPu3LO_xxxu4TtOf5AC9v2XSFYk
Message-ID: <CAMuHMdWAbMoQdeM5-F1YYOfEdcPrkTxdbsU8+TAYO=WuMzCqCw@mail.gmail.com>
Subject: Re: [PATCH v2] init/main.c: Wrap long kernel cmdline when printing to logs
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Andrew Chant <achant@google.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Brian Gerst <brgerst@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Francesco Valla <francesco@valla.it>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Douglas,

On Wed, 22 Oct 2025 at 02:41, Douglas Anderson <dianders@chromium.org> wrote:
> The kernel cmdline length is allowed to be longer than what printk can
> handle. When this happens the cmdline that's printed to the kernel
> ring buffer at bootup is cutoff and some kernel cmdline options are
> "hidden" from the logs. This undercuts the usefulness of the log
> message.
>
> Specifically, grepping for COMMAND_LINE_SIZE shows that 2048 is common
> and some architectures even define it as 4096. s390 allows a
> CONFIG-based maximum up to 1MB (though it's not expected that anyone
> will go over the default max of 4096 [1]).

Of course (unless the kernel crashes) you can also look at /proc/cmdline
later.  However, that seems to be limited to a single page, too,
as fs/proc/cmdline.c:cmdline_proc_show() uses seq_puts*().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

