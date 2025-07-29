Return-Path: <linux-kernel+bounces-749913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8AB154B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8A617C98E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A293227E95;
	Tue, 29 Jul 2025 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdT+OcSK"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA71A316E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753824888; cv=none; b=tN9/QMWDvJctJyaMsTW4sNDBCoR80SYCTYDqfXiScfLpOoMCmWu2MJ5UBENqI9eHaKVO9RmyOlcvun8LPggCCl1ynQDuUOREGNvsOmCtH/H8y/EpD2ICx/6vUSZSjUlJ4ijbZ3hNM1uM0wakdphAsY5IkkM9qAeRNB4roTxyaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753824888; c=relaxed/simple;
	bh=asM7fngHyyI3nRO/iTKLn4aH3b2mzIdrwvR8GNXPljw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Db0MtazEs4GSHXXK17pDOmNY7/fDQSDrWH4TtbD4FItQtOh+PKIG7V8YkDO6rVNgD+7nxCZ+iwUIDXgg2+9935G1ypyjxlfePfoFddCW+B3eFB5ojSDfUki/gsV6l7ZRBeoSCQ7HqPNPgDRnC1hFziGjHnJZ7U5nhlfqQMlsmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GdT+OcSK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747e41d5469so6612931b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753824882; x=1754429682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp7eLWjLlPUY2gLZxRm+MGuoAxS9M5bnsTC/FZdxS6c=;
        b=GdT+OcSKxZC8a2D3NJgyCFwL8DG59lDMdHtS1SitrmZqbKnEENNDRTcz4sDvuNBQBO
         TZdjTov9TSurtUf9xWKEGibMrMbH5Qlb0n49f/9ZVj1pPIPBz4ezD4o3Tv+nJluu4oww
         YWQmLF6ZPy0tcIHU8hfUd5UrjoM6gB0nKNsVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753824882; x=1754429682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp7eLWjLlPUY2gLZxRm+MGuoAxS9M5bnsTC/FZdxS6c=;
        b=LTAlKzT+iCtUndfydxdAtdUiv1tJwbCjHt0bqYGPXomz+mQXC4zSVWMFUQD7pAj1Fz
         LPB1VoobRBFI6b4m6+tY/WJMrGPyaXE+b6XnJx4IVR6rC4PoyHMa8xuBiRzEnKqZnr41
         2Sx8xv3wCUBz1zdvsiXYda1Pqf+JDwdkREn42kKPMwpHG+t12MbVxdzlN1xeB3X6v9jz
         ++otH2OFXYe3XesE3784RGUMvOu8a6dppZpFIrHDni/LtGteEH7/XtewW6SWL+apTDk9
         pzvmu6Qw18XKbdP1OWZ8LN3b7/gaPgJyg6Aq0ITuQKvGm7aoX84H+540e4Mm4eLewbQM
         ulzw==
X-Forwarded-Encrypted: i=1; AJvYcCVYiy/9HiSb9xx8yF33M8X1VhGU843WXhvL/5AydX/PQ5grOcyhf2Ho/hgJjsl2f6lV/tfaPnK2CB5wZvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQiSybPI03vWuXqKi5pXgJcK38KXOtGy4SUP3zdrJ42huwfxKW
	TU4twvCV4jk7qZCtfmeEItbdDsmY+BvDhVqAEfF1ChQYnHdw4jXDA00uxDeW1rxE38q5tNEtTbg
	tXN4=
X-Gm-Gg: ASbGncvIpAptnmFiFa+FWNvFNdfzPtrfDTQiwbg9pAjacDGkevPT3eXV8BsPE+84bcg
	Ji7qlxjkBCjsihthWKLzZNF6M8rH/vkRyYvCEfF1BpUrsGPK31u4M6TutrnwsQWyMbKK8uu7ke/
	G7FSRP2tPuiC98Nh/2mXEq/RsNOVnRUw1EIlT8iXvR6x1DBxKJkp0HpqgqgDUf6unyBfoepFakG
	kQeqyOH4KKE8LXFRlFlNwq9kRH/fP5UgCTsUNY1yi4DdXPfEz+OlFKj59qhHMVhRqU/Twzbokws
	jS8qhTfkFAadcD3b+Uq9l4GC33m/LtAs7vVqyoQ0UAhh6z2B0fncVchKVoiOtWTS9n0u8Q72UOp
	FgjXw5AH7/ZA2R3hldwRzMnzSQlR3LWwKcNowhQJs6bqFCuWyCM2rBrinPPELlQ==
X-Google-Smtp-Source: AGHT+IGsVnF1wVyfjZ3lyIgQLDA9WU1J7BK9qYu+f8FB++su47ymyZWx7utEti/3VxuxPkPbFW40uQ==
X-Received: by 2002:a05:6a20:430d:b0:234:4776:f418 with SMTP id adf61e73a8af0-23dc0e7c6e5mr1289058637.33.1753824882217;
        Tue, 29 Jul 2025 14:34:42 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com. [209.85.216.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4d15cfsm8895533b3a.119.2025.07.29.14.34.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 14:34:36 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so2489368a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:34:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoxIOECx5DdBve8U41Nmjh/+TmFM/Yb7LwaPBBnUz0UdTopR8QaeTepgaEt3BPBElyQ1ZfXvIOo0lHlFM=@vger.kernel.org
X-Received: by 2002:a17:90b:17d2:b0:31f:12a7:da67 with SMTP id
 98e67ed59e1d1-31f5ea4c8a8mr1070193a91.32.1753824876205; Tue, 29 Jul 2025
 14:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729054435.1209156-1-me@brighamcampbell.com> <20250729054435.1209156-3-me@brighamcampbell.com>
In-Reply-To: <20250729054435.1209156-3-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 Jul 2025 14:34:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLoMenu22F_VeoHyfXwRO7JfXL8peQLEpkqeZ1tDOmEQ@mail.gmail.com>
X-Gm-Features: Ac12FXwuRPQLnCei2aPWgGqgkhJiepLnrrXfiREPquhd3zgNcTNh4R-TaDAM560
Message-ID: <CAD=FV=VLoMenu22F_VeoHyfXwRO7JfXL8peQLEpkqeZ1tDOmEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Add MIPI support function and macros
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 28, 2025 at 10:44=E2=80=AFPM Brigham Campbell
<me@brighamcampbell.com> wrote:
>
> Create mipi_dsi_dcs_read_multi(), which accepts a mipi_dsi_multi_context
> struct for improved error handling and cleaner panel driver code.
>
> Create mipi_dsi_dcs_write_var_seq_multi() and
> mipi_dsi_generic_write_var_seq_multi() macros which allow MIPI panel
> drivers to write non-static data to display controllers.
>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>
> I looked into using __builtin_constant_p() to extend
> mipi_dsi_{generic,dcs}_write_seq_multi() to accept both static and
> non-static sequences of bytes and store them accordingly, it looked
> promising at first, but I found no such solution ultimately. At the very
> least, if we find a solution at some point, my hope is that cocinelle
> could be used to replace each of the new var_seq_multi() usages among
> drivers with an improved seq_multi().
>
>
>  drivers/gpu/drm/drm_mipi_dsi.c | 37 ++++++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     | 35 ++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)

nit: maybe make the subject a bit more specific, like:

drm: Add MIPI _multi reader func and two new write variants


> @@ -415,6 +417,22 @@ void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi=
_multi_context *ctx);
>                 mipi_dsi_generic_write_multi(ctx, d, ARRAY_SIZE(d)); \
>         } while (0)
>
> +/**
> + * mipi_dsi_generic_write_var_seq_multi - transmit non-static data using=
 a
> + * generic write packet

nit: "non-constant", not "non-static"

From the caller's point of view the difference is that the data is
compile-time constant in one case and not compile-time constant in the
other case. It happens that means you can _store_ it in a "static
const" in one case and not in the other case, but that doesn't make
the parameters "static".


Other than nits:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

