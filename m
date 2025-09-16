Return-Path: <linux-kernel+bounces-818109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A7B58CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DE41714A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB7425F98B;
	Tue, 16 Sep 2025 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkoXujtB"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0922A4E5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757996483; cv=none; b=oaWxxCB5BQKjdreZMW0ZLuVV2gQHSb5NP94fCzU3yFP6QunjTNuUgJaAZ7WI44NSvfn6Z09je6R4GOBYQwYIEFMfH5J4HikCS2xyfj0cxHszTtSgshQv2IA2ET/BT/xv624leVSQCOYmxl0Lbub+8QlxQM4Z1SzWHIB4HiSZOt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757996483; c=relaxed/simple;
	bh=bogLoMlflI6VbNNnCzsFDXRtZ6mT7yFBE69/g4NDZeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcyxcqsaJzMlGONGMVBd+sgcUuFVilak+y8qhyTDC+IzHnYT+7AADnBgxoh1scnvvqKJ4zhV/d9PPM0yGZZA2MRea8H2wHDQ4KOeRX1m7rPZ+h0CEcIAis7NCaF0Q/v+5ZY9GC4/MS772yYVlPEsaq/ejU9MpsNRGB95uVMXjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkoXujtB; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so2980744276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757996481; x=1758601281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bogLoMlflI6VbNNnCzsFDXRtZ6mT7yFBE69/g4NDZeI=;
        b=AkoXujtBVXk8PIvwVLotmv5GEugFnrh1u/RM5TBaCU3dtErI5lXwEbjr0NykiBtUAZ
         PgDAo9ztRKfFO2I4zsoje3kgeRU/fxZOeabsk9dbZORpQS96mye+Tnw2GlPblp0hf+Yt
         NPZ/6QlRLvXq4KLBgMb7JEjgYMQACgWk0eVnzziEoy1L/Ms4lqhSEzrhnMg3/JaEdNYW
         CcCNWocVuWecxO3A0eNSHwQKJ9LEunD1sMrlosQEOVfSYtn77+vAB5SDLfH2CrSGiwkZ
         5PxTYgI087Ze0eYgEsDVTqTYm+/tqn3EBqXPRwsYVDfmM+pEBGbXzsTvx30hpCF3U1Rk
         mD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757996481; x=1758601281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bogLoMlflI6VbNNnCzsFDXRtZ6mT7yFBE69/g4NDZeI=;
        b=LSQ/pf5sDGpACGkmI2PkZnQNj8Trd+/enQ26PMt13kw/uzNKJtr6OnZIwTSGAakju3
         NbyI4Zul5k2CTi52Vh6/mGEUeZpfSQnwoB/rAgLnjybF2MA1ibCQj0Zf+z1VCng78dsu
         kKfxMMOK6o/oVGS15oQDaMhOSOfaTKB2+UEI6/ceV5UeDnkJABYTchhETCaNCGY1rUGy
         v/AqeYU63lpPR/RMKZ4un3HFrGHIZcmglbmofP9GN7Qu2zg6VhKJ6XlQB18jVwUt9WZQ
         YNXUdKByQHWNRnNqyJ8CI9NRKd7vg1qf8BnIp6Ufo3i1UZF3UvZ3lfFmFhdTzUOKv7b7
         3M3w==
X-Forwarded-Encrypted: i=1; AJvYcCVC6TA8QBWPqlHHZTcZ5td7H24kunviMz/d6psQeMTviM+7/9cA4JGwVrJAEPf84fR0MnEW5r5oyRd4mZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8OOfzg4ypEdcxbPSPa8oZQU0tMId7hMEDuDIJYxRy5WyjyNJ
	hWpI8vq6Ow8qbflP2zzU8nxIR/wyDaQMeuhSy840kuyE3gEOniQkcXyZ3+NuygAmFwlcSLbhwpr
	KKXkDaiKSpGLb6GoWtEgUHQigHGqJxyg=
X-Gm-Gg: ASbGncsJlFUAR16Q2aRcyhlkFi7amniKHmtrXLPVjSlMYg5T4aPlWUk/t8d47xN8BNM
	luxqvyh0ccVdHGh915Bb5FdnWFdy6ZoyYE/IoiSKYdeqZerNS7WAylE0cOVpuXC+z9+7qBHcDs6
	RuvaDxBbDa8i/SxXXEtwu8wXE8b+dDbXXx3EVdJNwFrXqa8EZAuJIgpwPSQf0OivPuEykuB8NSI
	2D4I6NGgO61fbwCy6a82tfTVkvwDhIPiEczp8fyoBU78MhZOXzz7sU0+q9PYujKN3sTLIZT
X-Google-Smtp-Source: AGHT+IFyzGXqLS7HgTpLjfWR0n2UfIRuua03WSClBxtb3ipLLNlXWlUaTN5qUbRS4LtdFGTOHy1hA97gOm1mTGj9g3c=
X-Received: by 2002:a05:690c:60c1:b0:72a:78ee:f265 with SMTP id
 00721157ae682-730623e29f3mr107076077b3.6.1757996481126; Mon, 15 Sep 2025
 21:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913002155.1163908-1-olvaffe@gmail.com> <20250913002155.1163908-2-olvaffe@gmail.com>
 <20250915-numerate-makeshift-c076500aaec3@spud> <20250915-deodorize-proxy-b18e41fa8668@spud>
In-Reply-To: <20250915-deodorize-proxy-b18e41fa8668@spud>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Mon, 15 Sep 2025 21:21:10 -0700
X-Gm-Features: AS18NWDfiAtyEiAampVSnuFJXyQ57PVn2PUsFhR83kG6F0bRG1fbgCjLT-SJhR4
Message-ID: <CAPaKu7TEjG3sWamy3k_YLig=208oXLPhMmbCvPOf96iEL0-uig@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall-csf: add MediaTek
 MT8196 compatible
To: Conor Dooley <conor@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:52=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Mon, Sep 15, 2025 at 06:51:16PM +0100, Conor Dooley wrote:
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Hmm, actually there seems to be a more complete binding proposed here:
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250912-m=
t8196-gpufreq-v2-1-779a8a3729d9@collabora.com/
Right. I tried to add the compatible to the binding (this patch)
before adding it to the driver (next patch).

If this patch is not a prerequisite for the driver change, I can drop
this. Or perhaps there is a better way?

