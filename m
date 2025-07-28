Return-Path: <linux-kernel+bounces-748368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127DFB14049
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D57417DD18
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A6273D65;
	Mon, 28 Jul 2025 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bgBh8iwy"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A71A254E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720132; cv=none; b=CayZ5LnyNaOp+ESdEkqMZSKcLoq9/wbcI01R8Q7z5n1nv4IbsulLA3LSpKyEVgn8/zTJnxLlBqZCENOXJcVq+hhrCB34aCSW3QQxaPc6kPlcGC5RW+Xp2RDMkULWXfdEa6iAIp/uEDgnbZhq2z1w2aZBmwVCEiKN0ofZR9lPsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720132; c=relaxed/simple;
	bh=R/IIShAD2JsVpX6JjpWNgQSgana1xyTa7Vr5q3oPYEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEyzHUtfbqG0qJ62NTIZqfODFiJyMMciMahXr2kmKLTAYfaYzD6oSwu3UZnYDP3ZY9axV3rtpzobtmpE7NNsWn2QrX4wxJ4idyCi3ednHa7IHd5WAkZAe6D9an31W8edKpnzCBTtRlaxA1fLGmr1tEHIwjTmk5NMagomT5Kl7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bgBh8iwy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748fe69a7baso4163932b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753720129; x=1754324929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bV8/1zB02ycKvjRRdDk/ZYTjyldvrl4N9o7GiFyOOg=;
        b=bgBh8iwyfnzlhwKFoq+tOFmMmKp9gzv5lknGqfcelUB7FNvemKFpZfBiRwHRye0UZG
         6eBbI+zsgjwHkcTkdWRgei4cjZTLMXK3nFgElZFsEhTkKIwXMJCvRz6E6uriqT1JiSE4
         3HORhKDn7WrUVsYZbyJ1RnSh7T2BBbgWYS3Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753720129; x=1754324929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bV8/1zB02ycKvjRRdDk/ZYTjyldvrl4N9o7GiFyOOg=;
        b=LPmG48oQwHLr7ozxK4HMRJSPOE6xRnYdRXdHgnTjCdcZiXz4ZLKv/1z1ve+dK8ePIf
         KT3vOaFo2mit3vYOl5LToJ3aQsiZLn/uOsIlgZjg2UQvUCyhZTedjYjVMtPkyPOuZYz+
         xYkdT3soCpFROuaB6+XprolH9RC7aXu44EBPkH0/TQsy0yMw3BacT7x64+8LQTJdQ0IQ
         ogg7WVQz9LqDY+OxbMErByQjIS9TtMLDcxgKQJAlvLWUsTPSIV6tJ8O7fZGo72ai8m5L
         s7tQHu2gUSAdgg6ffoG6l1fVKFF+fgLc8kLl70YQd6at6ZY+fpLRVWB7sH3uIfG+J0Lf
         5/zg==
X-Forwarded-Encrypted: i=1; AJvYcCVqMzK7UzIo1Y+AJPcPV02Hr/TwXZhLinPqdsXZ5kbXk5giMBVqOhH32f4L6VF9mgo9In+t+dhaLgjxpXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMAucHqInHoLavLMZ3GgBiil1imTImlkOxzcDJbXa+j2fZHwt
	xMlRTO6RL/fJoBU0q8Q0Knh8woZtIH92OEBB7qdByVAog4C714MuLIH65uKGiJKrqxp45XZwLQu
	01as=
X-Gm-Gg: ASbGncttW6XIhdinEN1L6qaqx8btKgswsjcEAy40F+gj7Q6JKm0R9o7VD0KuiorNs2X
	b1Bd3+ryt8T1p/cmnIX/jrA0SyQ6YOCCOqxdQ+nMEsHV4FFLS1v07HxMuN/6xv9qQAwZqZ9ajlC
	+LDIdZ+vy4JEVFwnSuSg0PGMsDmJAnHFjN3tYEBQyTjhmH8uXUWpv+Bj2+oVuVuIJuNdUaMEDMo
	kyLC7IMMANN5DFaSGWsr8vJ2hGlUIv5bUpA2fSug5OX9Ptm5dVNLNTHIlQu1J0oyL7a8HUywkij
	AcTa3hmi672GrKtB1cTtNTNmvYCwLX5Yt58NCW1USdO4Q70dG05687Fll7q7yRysriEDDHozkLL
	u5CDIBx0yWXzr9QuYFBnNixhfXD8GKcaL9U3vLYMbE57xPg13o4SFClyGSSh4ozBQVqLS6oKg
X-Google-Smtp-Source: AGHT+IErBI8CzFJTVC9rYlAFE8cZgYydQymAdzTfOultotHPmJhfvRBlxklxY2dA/kAgjXwv9S7B8A==
X-Received: by 2002:a05:6a00:bd81:b0:748:de30:d01 with SMTP id d2e1a72fcca58-76332c4b295mr13660474b3a.10.1753720128550;
        Mon, 28 Jul 2025 09:28:48 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f568efbsm5277339a12.7.2025.07.28.09.28.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 09:28:47 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso72070a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:28:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzDbF3KZphG+rWrBybkqrHFXCx6OSqRhltIp8/6R6b+qdTs8OfXJRIHETGWA6WxJIH4758OfKc2T3vKig=@vger.kernel.org
X-Received: by 2002:a17:90b:3b4c:b0:313:db0b:75db with SMTP id
 98e67ed59e1d1-31e77a24b41mr18438779a91.33.1753720126253; Mon, 28 Jul 2025
 09:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724202338.648499-1-me@brighamcampbell.com>
 <20250724202338.648499-3-me@brighamcampbell.com> <CAD=FV=UGNN68Fu4kJQQ8jO+fYP4qVJYmL0quxa_=Y5GEtS-jMQ@mail.gmail.com>
 <DBNGMHS14LUB.3PDFCB3DI1789@brighamcampbell.com>
In-Reply-To: <DBNGMHS14LUB.3PDFCB3DI1789@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Jul 2025 09:28:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wg_JrwGx91Pek2SC=JH6ksugjFEpDmW5z3qXCUKyiu9g@mail.gmail.com>
X-Gm-Features: Ac12FXyy9q8f7qx9W8K4Oe1nvu_PYnS7rPks79aLouknOlrzwPZQDQBc90Gh8fI
Message-ID: <CAD=FV=Wg_JrwGx91Pek2SC=JH6ksugjFEpDmW5z3qXCUKyiu9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: novatek-nt35560: Fix bug and clean up
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 27, 2025 at 11:04=E2=80=AFPM Brigham Campbell
<me@brighamcampbell.com> wrote:
>
> >> Using mipi_dsi_dcs_write_{seq,buffer}_multi() in place of
> >> mipi_dsi_dcs_write() gives the added benefit that kmalloc() isn't used
> >> to write mipi commands.
> >
> > Ah, this makes sense. We've seen this before, but I keep forgetting
> > about it. Thanks for mentioning it. I wonder if it makes sense to have
> > variants of mipi_dsi_generic_write_seq_multi() and
> > mipi_dsi_dcs_write_seq_multi() that take non-const data. The only
> > difference would be that the array they declare on the stack would be
> > a "const" array instead of a "static const" array...
>
> Ok, I've thought about this one for a while. The problem with my patch
> as it is now is that it uses a u8 array, mipi_buf_out, to construct MIPI
> messages and send them out. My patch reuses mipi_buf_out because it
> happens to be the right size for both messages which need to be
> constructed at runtime. Not a super clean solution, perhaps.
>
> The Novatek NT35950 has a better solution. See the following function
> from drivers/gpu/drm/panel/panel-novatek-nt35950.c:107:
>
> static void nt35950_set_cmd2_page(struct mipi_dsi_multi_context *dsi_ctx,
>                                   struct nt35950 *nt, u8 page)
> {
>         const u8 mauc_cmd2_page[] =3D { MCS_CMD_MAUCCTR, 0x55, 0xaa, 0x52=
,
>                                       0x08, page };
>
>         mipi_dsi_dcs_write_buffer_multi(dsi_ctx, mauc_cmd2_page,
>                                         ARRAY_SIZE(mauc_cmd2_page));
>         if (!dsi_ctx->accum_err)
>                 nt->last_page =3D page;
> }
>
> The driver has a couple different functions like this and they're all
> for the express purpose of writing out a single MIPI buffer which is
> constructed at runtime.
>
> Arguably, a more readable solution would involve the definition of a new
> non-static macro like you suggest. The macro's `do {} while 0;` block
> would achieve effectively the exact same effect as the functions in the
> NT35950 driver, causing the buffer to be popped off the stack as soon as
> the code inside the macro completed.
>
> We could call it mipi_dsi_dcs_write_var_seq_multi(), perhaps. Or
> mipi_dsi_dcs_write_sequence_of_bytes_determined_at_runtime_multi()? ...
> (Help! I genuinely don't know what I would call it...)
>
> Please let me know if you'd prefer that in v2 I adopt the approach that
> the NT35950 driver uses or that I instead introduce a new macro for
> non-static data.

The absolute best would be if one function could somehow magically do
the right thing. It's something that would be better if the caller
didn't need to think about it. It might be possible to construct some
ugly snarl of macro using __builtin_constant_p() (maybe requiring
__VA_OPT__?), but I don't see anything super clean for it
unfortunately.

IMO adding something like mipi_dsi_dcs_write_var_seq_multi() would be
the best. The name is a little unwieldy, but I can't think of better
options and I suspect this will come in handy for over drivers as
well...

-Doug

