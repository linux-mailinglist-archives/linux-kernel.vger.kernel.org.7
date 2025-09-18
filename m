Return-Path: <linux-kernel+bounces-823355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D47B8630B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF83F172FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D7B264A72;
	Thu, 18 Sep 2025 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOxoy+fe"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6025B301
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216011; cv=none; b=EF+WoAFzLaxeraGn4YMX9sP+tAAHUWvkfWviGqXrUQ7L0Wd7acPHsrHExT3WFqenYNr75LdH9E2trfCpUEeGdFamQWjEsEGb0GurWoHshfUBS/KJxh4kTIKq5ctrLs20pWFYkti/XssY9ZwEYdj65TH7Q8xhvIprvzVx/tHe1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216011; c=relaxed/simple;
	bh=nVGCJuiI7kWF9V3S5fkMQr27m9yi9NsvtbuKKTw2jCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ+iwyaLwun8j3QlxwxXC9H6qvEpA0uvqk5slwr0OBQASXZU8Dbtbfa26t4teeYuI+Nqca4E5ChfgCtXBLf9PKGGMGbsPQvrBtqGBnXzJCcb2oj2VoWU0ATXNCGXj2ytKo6VECL2FQeSHJho0DrAAKdyZn1/1WqL3/QtyAR5DXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOxoy+fe; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3515a0bca13so26236551fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758216008; x=1758820808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVGCJuiI7kWF9V3S5fkMQr27m9yi9NsvtbuKKTw2jCw=;
        b=fOxoy+feg4MoTyOy5LVonTifeT6b3V3bfqnweshtJnLhixTwNK2jsWoSmmoAxcm/ac
         Fzj46Tic/BYVSKAf//6yfaRu9KjsEUKMmLB9nEuzy4QwxHRP5CyjFJXUiF1q/PFK5mwJ
         owayB5snqLa3QhLB+ti8Nj7Qgh/W5c7V25f5hsK+t0K+McCccLRtf4n0pI/oTXXBKlm5
         /62z1QtreBNAHUA9ZIeQhq5WV55ph78/hSD3HOBd6D7HrROIdbRyoWcrgvHPpz7qHy3n
         o6bucDCM6GEAa0FplwwPSENUP04FJe9FOL2KEzzWuD1mi4MQBCAcl77vuY7P5hIo65YQ
         Mh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758216008; x=1758820808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVGCJuiI7kWF9V3S5fkMQr27m9yi9NsvtbuKKTw2jCw=;
        b=HWJJA1cEGMbGNvW354EqpMZRpMVGa6sgO+eXlFiRLHxkkHl+S4Ulw3M6P2rzDSZXhe
         33HsDl3eXXcejkymF3QU2tkpRefo7fxXbiRGr0RweobQMu9iaz+i9LkVmjFECAfd/Ee4
         RvDHZ3HKHT7Xx7cnl3PrxpZwXwlZIMfH8zZQ2s+yfe6iBrpppDveOblnuoqrwmImlU+j
         2QqOxX/mlmb1yds570KwJGOg25hsAHnB2EntzDfgZajtAMuieTO8e/5GV2JjKWEVbwNL
         1GeSOPP/GMS/o57LwvbcMbGH5faoTYyLae3MjIeuUdXosLWCUF+KxQ/+aCi22nv2d2bZ
         SgFA==
X-Forwarded-Encrypted: i=1; AJvYcCW5zY+qcvHvNHuIt3hJ+OmrxF1oVSrmHSPNfTfg61Zc7jxV7f+1DqYIi6sLZUJYKjMfMTWmkdAIvk1L84k=@vger.kernel.org
X-Gm-Message-State: AOJu0YytfOwILC4QPuf/5R+vmGMF82rxZu7f45oxBsmMlsbeHVNMKDSi
	xSZGdxqVhHntFCcQIGfdAtVmt7kR8TBgrvNna5nHcbMOC/jFytySrZLGtQOtVg6kGvPyJaHppqC
	q0VFok/XL2KsIg6jR5tJXYN+3xvHjZn8=
X-Gm-Gg: ASbGncvn7hE+jvIdyibArlNa3o3jp+yQckcHm5o1riqS+azjcaILCWEdaT/YWCInm8j
	hFDoOTPSIO0DVqgj6uGe6Nsrq6DeFpHACqgb+tBCGWLKOHcNTV3Z6dgtck4BycoFjZ56KSFojsZ
	PpMwTaXWB3FLi/kywxZhodwD87EkmWGsD6KXQP0pU8eLqdiZItzh1tmaT5xGIYzj0ivYdpxj76F
	W7kSrnm8MC6KYVWtIbNrsGNbQ==
X-Google-Smtp-Source: AGHT+IGsIMA9swyx5/zWtjl/zZOSDGKe0YrS/kNvQp55Iis2DzEKSwclp889Q1ZA6XMNg9nE5KiyMXN2dgIaNVjYHas=
X-Received: by 2002:a05:651c:41d5:b0:342:668:5ca9 with SMTP id
 38308e7fff4ca-3616c674211mr12382181fa.13.1758216007545; Thu, 18 Sep 2025
 10:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-tegra210-speedo-v3-1-73e09e0fbb36@gmail.com> <2334a545-9a06-42d9-8282-674b94fdcb2f@nvidia.com>
In-Reply-To: <2334a545-9a06-42d9-8282-674b94fdcb2f@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 18 Sep 2025 12:19:55 -0500
X-Gm-Features: AS18NWCY1imc6qMzII1HoMutNUeV-pu2L1O1O90Qvl84fUfbKYm-mB0fESR_s5g
Message-ID: <CALHNRZ_gNzCEOzcYBY4o5Hz-efS5b52K4uZqmw5ps5zEfKoOEw@mail.gmail.com>
Subject: Re: [PATCH v3] soc: tegra: fuse: speedo-tegra210: Update speedo ids
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Joseph Lo <josephl@nvidia.com>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 4:45=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 04/09/2025 02:58, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > Existing code only sets cpu and gpu speedo ids 0 and 1. The cpu dvfs
> > code supports 11 ids and nouveau supports 5. This aligns with what the
> > downstream vendor kernel supports. Align skus with the downstream list.
>
> Do you have a reference for the downstream kernel change you are
> referring to? I have found this change [0]. However, this does not quite
> align with what you have in this patch.

This is based on L4T r32.7.6 [0], which builds up the list over
several commits, so I can't link to just one. The first revision only
added sku's that I had specifically verified. Mikko suggested to just
import everything from downstream and to simplify the conditionals.
And that's this revision.

>
> Jon
>
> [0]
> https://nv-tegra.nvidia.com/r/plugins/gitiles/linux-5.10/+/2a8660e3d1e4f7=
5ba4390b72991744174237b025%5E%21/#F0
>
> --
> nvpublic
>

Aaron

[0] https://nv-tegra.nvidia.com/r/plugins/gitiles/linux-4.9/+/refs/tags/teg=
ra-l4t-r32.7.6_good/drivers/soc/tegra/fuse/speedo-tegra210.c#72

