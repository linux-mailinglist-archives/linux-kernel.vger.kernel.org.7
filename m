Return-Path: <linux-kernel+bounces-876316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D253C1B324
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9C21A65416
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497B31A2C25;
	Wed, 29 Oct 2025 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMx5+jUn"
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2AC126BF7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746994; cv=none; b=d8kQ4jRXi0SADvIc9rV7KpFXXBO6TDf2TwR1W3WijEUE+e3poB1o9AtMOob0MLUC+4PFMcuQ+E+kut73+dZW831w2DsYgMW2bMxGMNN61mGOxLdAw+5sECRGNKgIKjm9dOP/gq6bXjs7fj0mZvf6FSJ1DM6JlvCWUIgjvUpO2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746994; c=relaxed/simple;
	bh=t8Je67MYz78CSeDapeZWXFbw8UTnijHwDfsQ0oJzpBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYQrkA5WyqAZcW0kkM6E64LQKR4Z2irj3jIuUr7fJvvABcsjZBcFarpWk4HGXI7yRCyx668/TN8x4HIGzmtPLcoo+hN89ysuKPcUer56nJMScMjG6AY+oRgBV6o+uzNuwoeenYwshK9Negf4EWJ+j8FGkWo6MqfQ7ksvG9VjA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMx5+jUn; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-63d0692136bso8547126d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761746991; x=1762351791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycwR5keqCwJzvgHRE2PU/x6zSUHdoe+fklvAVma4ZAo=;
        b=JMx5+jUntRlcJQLqr27dNA+ixkWY0WcL3QE4C6TlU95MlE9ivCX/UHo1gba0ho5nrY
         mRL8BMdRbegHhnja22M47l9YmSUUG4mExAaHz2q9X09/LMKT6wYbedeQGpKeLfREenEL
         RRLDGbSAjc+PVCDfeBjfiuWVHXBvRYDjTbGMp+23Vb/taj4QtkbNxVQmDnY6e+LUZ+lx
         VQ7FnD9x3qdcxLt3aliZwhxvaMtub+o8d3d0FXSA07CNvcImsgdeqtaUvhRjnEUDczTM
         NoI1OZeKCvM4qC++6c7xW5EbYWMRJWlOuDPFk/QvB7Kj9aAd6dZEVdeCRKY3bmAhvkaS
         DWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746991; x=1762351791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycwR5keqCwJzvgHRE2PU/x6zSUHdoe+fklvAVma4ZAo=;
        b=eaR6DrqRp2spg2CWWbg2FFO2/NPwxMHFtDGzx+qTNY+bn3Q0EuG5MPgxymJF5XbHjA
         lkge3E75K+Dkvxdc/fB9qmrnwJYHuP82C0JbVW4CBPf0NfZT+990V90FbOUc0J2eMEAs
         jp1lpYJ/n4NJRsURqlTfPVZrC/m+qc0grmQ0gY/1A5UyatclXjyPUu3F5qAlMWwQKLJq
         ltokBNz6mTBVXycOo6gI+c2jwuX6l0bh07/4q6lanIcJAzXGKEMIZ/WqxtBeAG9aMtO2
         14hA20SdRySAVh9zhGDG1/yS5u1iRoKVCM+6j5aotOVpZsUGOGtL6eIcs5JK4RGNaTBJ
         8lVg==
X-Forwarded-Encrypted: i=1; AJvYcCXCNTepM/LmyleBROHFWHgOjppqfuGAarFvk8KvqAscyZuHSylv7pV3sW6SqBmoGexg/cm5BX9ZT91RveQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsG+3J8/fsdWMYx7RBeGXhsasqk/9RxByizlJlN5M3SsdJi8yl
	fjY5bXrhGaCCzwuRxKkL843TOhSahtHYyTWqilKg7ONOSv5KxXdHE+nX6n9aRuK28DEMsYM49fx
	LH3Momm+a41q0DENIKljbBLDXhiQ8389uMFHi8MsnJQ==
X-Gm-Gg: ASbGnctD+qfSmt6duTpAGJybu3Aogz/WjXzjAEZHHYoWm/PPIKHmzAek10nBV72vaLF
	QAupxU2dB5JfaTRTtyM9+HiPVECg2rqKS5s5UuSKNnRxbkBXuusBzlEeTD32DFs93prRFRXtQis
	eywWltZ0fNaId+yeKrntXpXrL70ZTmYylkX1swd43kMj8s/nICmizsEqaTDvHfBHeUgYHlg/x0w
	wMmVm3+UxE85naAFjO1Tz439/tJy+x+iVCt16lw4jkO7wMst/7afyFePV6NKxLf
X-Google-Smtp-Source: AGHT+IF+osjOqvoulkw8NO3HUmXRkTZBaKFJ2uh5+H+b3awpIW0yi0ceflqPVNZ93HSbPbOv8l1IEkL2tLogOY1edPQ=
X-Received: by 2002:a05:690c:7241:b0:782:9804:c939 with SMTP id
 00721157ae682-786290a02c5mr29214567b3.67.1761746990928; Wed, 29 Oct 2025
 07:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029021514.25076-1-dongml2@chinatelecom.cn> <20251029100045.1bacc491@gandalf.local.home>
In-Reply-To: <20251029100045.1bacc491@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 29 Oct 2025 22:09:40 +0800
X-Gm-Features: AWmQ_blsBI_DFdiQF48RKMGt-Buyb8d0mgmMYGrEuLR2v4XIcFJRfldKRW4N2B4
Message-ID: <CADxym3YcR+WYjRv-0+SOiE1yoO85FaqffCF2XbLZ9H7+qHet6w@mail.gmail.com>
Subject: Re: [PATCH] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, jolsa@kernel.org, mathieu.desnoyers@efficios.com, 
	jiang.biao@linux.dev, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 29 Oct 2025 10:15:14 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC=
_FTRACE_WITH_REGS)
> > +#define FPROBE_USE_FTRACE
> > +#endif
> > +
> > +#ifdef FPROBE_USE_FTRACE
> >  /* ftrace_ops callback, this processes fprobes which have only entry_h=
andler. */
> >  static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent=
_ip,
> >       struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > @@ -295,7 +299,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
> >
> >  static struct ftrace_ops fprobe_ftrace_ops =3D {
> >       .func   =3D fprobe_ftrace_entry,
> > -     .flags  =3D FTRACE_OPS_FL_SAVE_REGS,
> > +     .flags  =3D FTRACE_OPS_FL_SAVE_ARGS,
>
> If an arch defines DYNAMIC_FTRACE_WITH_REGS but not
> DYNAMIC_FTRACE_WITH_ARGS, then this will fail to build.

Hi, it won't fail here, as FTRACE_OPS_FL_SAVE_ARGS has
following definition:

#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
#define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_R=
EGS
#else
#define FTRACE_OPS_FL_SAVE_ARGS                        0
#endif

Which means it will fallback to FTRACE_OPS_FL_SAVE_REGS if
CONFIG_DYNAMIC_FTRACE_WITH_ARGS not defined.

I have commit a PR to the bpf CI, and all testings passed and no
building error happens:
  https://github.com/kernel-patches/bpf/pull/10110

Thanks!
Menglong Dong

>
> >  };
> >  static int fprobe_ftrace_active;
> >
>
> Perhaps do:
>
> #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> # define FPROBE_FTRACE_TYPE FTRACE_OPS_FL_SAVE_ARGS
> #elif defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
> # define FPROBE_FTRACE_TYPE FTRACE_OPS_FL_SAVE_REGS,
> #endif
>
> #ifdef FPROBE_FTRACE_TYPE
> [..]
> static struct ftrace_ops fprobe_ftrace_ops =3D {
>         .func   =3D fprobe_ftrace_entry,
>         .flags  =3D FTRACE_FTRACE_TYPE,
>
>
> ?
>
> -- Steve

