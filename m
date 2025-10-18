Return-Path: <linux-kernel+bounces-859087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29323BECC11
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661CB5E6562
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2902EBB8A;
	Sat, 18 Oct 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQNVCMjD"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB002848BE
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760778351; cv=none; b=kJLWRTseMmOIdOzTG0aJNkqcyvjXutTVW15lAVQPVWSSv1frOVL8rveah1cTAVPJKEAhtV4AbYfWI37//QIM5evEXZVeQJQKg5Gy8gVlymvHsvgHAGzrdPTRo5uxpTXiJjWYCdvSyG37FP/ZzjpqiHAbCi9H4t7hilujlXUYjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760778351; c=relaxed/simple;
	bh=zMwAxL4eSaShVuEFgCEzSnNitMi745qrXYTua1HCAfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYtk5Te1piuTyxpMaQzGmaRvQuBuaMExdKnk2IcU7528PhErYhajdIIlL/QjT5MH0eSYjiJV3cEVwBBx0uIW9mg638pfYfiWhVEUbyp2FGdlJFP5mMaS4JYUNOQj2SrboXUXD3HmqAFxSFBjL3M8W622M0D70EUug/k6ivjh1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQNVCMjD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso638973a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760778348; x=1761383148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6z6CG4Bzykdg3VlQO62kpKPKIN5Ed0HvWERMlLp9z1M=;
        b=AQNVCMjDhsiMoRIEKbUiUuY5x8HbHETJfFUQFW7ffMMjMMH6J3P8lSaLnq5BMl1KKv
         ZQ4+nEzo4c6k4ZqZOiMlv/Ny1uEu/X9+iMZRP6ty7FkO/zDjxld+kXKsI9uZj2MvKOfO
         HO88bI9cIiSyrh1ID7Aq48qiNvTN+le63qtRpTUDuhrK1eCBMpKiP9Ke+nY4TXSqKB4C
         OxPrQsnEeQaKZ9Tu+ztOOgTqF+/jAZcx6w72uXOJ0eQH45FdR3zcSMiDnXJRtRpnjYK+
         p7P62puVSFz4MMU2y7L3tK1Z/LiVdylPqvF76S9dZL9KLJL0mAyizcyUMEsStEXPRkcb
         c/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760778348; x=1761383148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6z6CG4Bzykdg3VlQO62kpKPKIN5Ed0HvWERMlLp9z1M=;
        b=HOMt7mdbLEGvCrOCe2wa15laLc/fGJJa9jEcrnmRKrdjIpA54BcmEJ79Ys2tOI7HE5
         SImPFkrVTf+WNCElLCFv4zKQfXtiCNp2JxslwYeHYcTDYo4GE4vLf57jkOIy0xT073D0
         BP4+cNIKFTMPK+qJyj3d1BhpSmJ3sbR6qSAI4lsNyygp5rBhfaVIWJibG5lgPCuMWZvX
         VzmrEMdCXAfW0MRgFKOm6MyYxehpzPLJhPZwFhf5Xnz7Q9ZkdybHyxXdw0zBHdHd2QDV
         1i8rVKQ5+1M6ZQ2ZWpdq/XUh2fvvdXRlHLUnGJ/f1k7WBgA0/4LpIXvhVnYkJPbPBr9m
         TDZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWreGFUyRRxx+BVsKLCPwl6B1OkT5Cm+C5Pmc5Ps4Y4nZIttB81b/ktXMPxIsjwgSVcsPYuZIGu+8DkNBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gYhHrK/obqmCsgy4pPa//jlD230QXlOpS5pPqBgX3KE7mzFi
	SpU903U1T0+NGb8MOx0B95feSwgkUzu3pP7QS+fWluSiSvu91ncv7IZriWrEtZ89mH9SQ26g/y7
	nRiOucyHY3HsUqn0HSrypnkVdWoDEHp0=
X-Gm-Gg: ASbGnct2wm3y3jqWiKLO/qc+8sFnaKJJewFBgcWRPyq9e5I9uLz8EHLOsYZR3C+GED2
	x4n7erEhsXoXh0PpdboZrfMClMfzwGpH3Q5Q0Afa0shglhNGsTHe3oJytwybmlQkk9eCuegJ2jA
	QFqUc6svurLWoJeAt/5XoPdJymp5oLrkarGsudLuzf12ZTJhstxBODxNfImFGgq7mJoZMXDl5bQ
	EsmpMZPaRmOczCs8yHMH+I7MkjC3zqdEYIwNel+43rJ4A8kX3jH8gNUUJg=
X-Google-Smtp-Source: AGHT+IEhR89+OlZnqrJ1xToJ35S4hHteVi05MGdBYp0FB9E+H5DwaPu0w+LV/8y6BXwE5xnOmNRU6JE04b6xtGtpRL0=
X-Received: by 2002:a05:6402:4504:b0:63b:f48d:cf4a with SMTP id
 4fb4d7f45d1cf-63c1f578eaamr5362961a12.0.1760778348106; Sat, 18 Oct 2025
 02:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018061127.7352-1-linux.amoon@gmail.com> <071f563c-6d09-46ea-870b-a51e0522bfad@web.de>
In-Reply-To: <071f563c-6d09-46ea-870b-a51e0522bfad@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 18 Oct 2025 14:35:31 +0530
X-Gm-Features: AS18NWDj5t4J8Su9s5gXUOjbXZcv8D1D0shD_oUkWVHtMigAOGJ_VaoJUxZoA-o
Message-ID: <CANAwSgQEqv2a1MGkGtj8CpXSKOXv=_wV3afOgn=iri7uqnj1bw@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Propagate dev_err_probe return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

On Sat, 18 Oct 2025 at 13:09, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Ensure that the return value from dev_err_probe() is consistently assigned
> > back to return in all error paths within rockchip_pcie_init_port()
> > function. This ensures the original error code are propagation for
> > debugging.
>
> I find the change description improvable.
>
Ok, is this ok?

When using the dev_err_probe() helper function in rockchip_pcie_init_port(),
ensure its return value is consistently assigned to the return variable. This
guarantees that the original error code, whether it's a specific error
or -EPROBE_DEFER,
is correctly propagated up the call stack for proper error handling
and debugging.

>
> Would an other source code variant become more desirable?
> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L5031-L5075
>
>         err = dev_err_probe(dev,
>                             reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS, rockchip->core_rsts),
>                             "Couldn't assert Core resets\n");
>         if (err)
>                 goto err_exit_phy;
No, the correct code ensures that dev_err_probe() is only called when
an actual error has
occurred, providing a clear and accurate log entry. For deferred probe
(-EPROBE_DEFER),
it will correctly log at a debug level, as intended for that scenario.
For other errors, it will provide
a standard error message.
>
>
> Regards,
> Markus

Thanks
-Anand

