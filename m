Return-Path: <linux-kernel+bounces-837995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F280DBAE314
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7533A60C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876662472A8;
	Tue, 30 Sep 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5bY/3Yz"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F830CD88
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253440; cv=none; b=CJAhBAe4JcBENn+HqEbLCTwpWorBLT2h5elog+O4AYCbEOHKqzxB29qu4FEvlQdXy9kzXOHmOUBZE/tWGfXf400edHbqcZbq1UYqcftQfsT29pzxMdqr0kzJGUgGQLNewZwKyKwCeF6uX9XcqGWwvFOoJ/MSwDQOjgd1HndT+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253440; c=relaxed/simple;
	bh=RAzN02ntU6we7KtqdUsGw1bQvhAKuIdoO3RtEp9cuGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfUvs/RNXcGfr3tquFVR52FnRQTCiZop3nC5btyRWcPYqmOtx4y1urh6hs9rgtMxrkzhfhIJ8aKjiy9UAt5J+2FquGVd/eZFMkEktgamppZObTPInAuNM8Y8E0eJWbQ7G3SrrvvptMuZ7wWCczUzxDW0L+FRkaCQqPjIn+Ml0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5bY/3Yz; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-904d71faab6so4455403241.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759253437; x=1759858237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kjeYVi3BFjPoMUBum1xgGJVhZJDmP8eaKSN0CbIZRQ=;
        b=H5bY/3Yzu6wBD+yxbm9BlzPMjCrvaE2JHyFjmlsq/wXpNkjWrV872YeKU93iQgRaWf
         sDANDUeeQMpVlDVaIN8VCQfEZjHYalC01C4tSm3ybGtgBRiOPV3KQdCF0TsSUn+22JUT
         nt9zn5cUU4lWbIESqjIN8vBkFnSAh9osSmL+qG9pepllejItErkkl6aJL1FVoIRPStqW
         mhT1g2+EMmpNIguFfWzJkuhAR9dUo/UiAuexudN0psPBKvRu3o79qGMTxCGa38pGIdql
         yF7UjE8fCNdDRb1ulDG9Ql+Pw10y8Q6KwYlDTqLBH8U7dzKLcnp/08H7ecAK/qhLla66
         bAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253437; x=1759858237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kjeYVi3BFjPoMUBum1xgGJVhZJDmP8eaKSN0CbIZRQ=;
        b=S5BBAF/1OcikrBtEPBgkEbSa8wOZe5P+7jKOhPmKjCzecEtcLYqLo+cRYhpEBq/Po9
         engOwqkKTF7TADHVgENEOxYV2x1jJNx/vyyejJS8+umpTRZc9NTQ5bXL4u6tyGjYzpQQ
         /9RrtoUjrAP4FCIMgfhs/yIQ1mOq7J1+v2gYg/CKqjnAWsNtCOg4ghrkOJHW/oygR/jB
         frnrb0Af5IlnRpdEfNc91hRt39N6y0Ce2ZBlPHywIfeCnji/nAZv9p1dl15ry21cUpN3
         ExHrh6Z3/x1vASFwDWLWklnQWPSTJGN9W9dTZS9tfBJGNZXRvR8w/dgjzauBrmNGnm92
         9hFA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Dc57aYj8zvVkUF9Q+/vzoJ0G9dgsc8YoqQrXp4DFNwEIIl8UAYg4zKD9YV1OdID3ABZ7N5EMKtq/gsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlu2qw7dqIg/XOadefULkWiruA6X+BdiyLohuqa3GC3PsMY/Nx
	KylA1rW/6mLOKMkZmLVfwxBh6gdAMxbeRNivv2p7wkn9EyMzdwI1CfptAOd3d5m/Rz1pMIRLXf+
	zCOHBEQGs2BT5HWobnr5zRfyFNiMgKXoh/XzT4q8B
X-Gm-Gg: ASbGncvYC+s8wHC3QCvCBNf4tHudQFyAtZ2ev5IqXo/2W/Q29HPe/AeD2ASvHibMZlw
	nJRwxZwlR+wf997J298cjxINLIYHTyjNovC8um3n/w6iRQlkBEVrNNYKcT5T8i/gp9pjE6OBjIN
	jaCn7yuf8GU+Y2PSgDKIBHlcPDpfdTIdwC91NpsJy4YpHOfimCNXCQNPh9GL45EJ7IydH2JMZSU
	v32BIGnm4HNI7TM2WBVMHAWR9eqxvr4TJbQ
X-Google-Smtp-Source: AGHT+IG8jJ95/JjL1D4MG02AWTuWRULg09/UHI6ETn6Cc8YDCJp+TEu0wu9vGpPMKXVhUdNr52Sp/ZXXPPXheG9lrtk=
X-Received: by 2002:a05:6122:251a:b0:54a:992c:8164 with SMTP id
 71dfb90a1353d-5522d37d0c7mr277987e0c.7.1759253434892; Tue, 30 Sep 2025
 10:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930-mmc_pwrseq-v2-1-80a8c6be0fb0@valla.it>
In-Reply-To: <20250930-mmc_pwrseq-v2-1-80a8c6be0fb0@valla.it>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 30 Sep 2025 10:29:58 -0700
X-Gm-Features: AS18NWDhaTb_SHyVdkz3H1aGObXRSKwr83vx52Zf-N7iLwTKT6lcWCzjbd3sNII
Message-ID: <CAGETcx_eDbx1QowXzy1k9r2D-G-gT7nEgFqEfWY7wBbLzfRukQ@mail.gmail.com>
Subject: Re: [PATCH v2] of: property: fw_devlink: Add support for "mmc-pwrseq"
To: Francesco Valla <francesco@valla.it>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:58=E2=80=AFAM Francesco Valla <francesco@valla.it=
> wrote:
>
> Add support for parsing MMC power sequencing (pwrseq) binding so that
> fw_devlink can enforce the dependency.

I took a quick look at the documentation. It's not clear to me that
mmc-pwrseq always points to a supplier. Can someone with more
experience on this confirm that is what it's supposed to point at?

Meaning if A lists B as pwrseq, is it always the case that B needs to
be powered on? The binding documentation doesn't say anything about B
needs to be powered on first. It's just saying A and B have an
ordering requirement.

If the meaning of the binding is _ALWAYS_ B needs to be powered on
first, then yes, this patch is correct and I can give a reviewed-by.

Thanks,
Saravana

>
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20250930-mmc_pwrseq-v1-1-7fd2764f=
5ac1@valla.it
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index c1feb631e3831d7d5ec23c606af31731bfc2f8b8..fcf10c4f02dcf879e1f25e4fa=
97b25152d58bacb 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1377,6 +1377,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-init-=
providers", NULL)
>  DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-co=
ntroller-cells")
>  DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
>  DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
> +DEFINE_SIMPLE_PROP(mmc_pwrseq, "mmc-pwrseq", NULL)
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>
> @@ -1524,6 +1525,7 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>         { .parse_prop =3D parse_msi_parent, },
>         { .parse_prop =3D parse_pses, },
>         { .parse_prop =3D parse_power_supplies, },
> +       { .parse_prop =3D parse_mmc_pwrseq, },
>         { .parse_prop =3D parse_gpio_compat, },
>         { .parse_prop =3D parse_interrupts, },
>         { .parse_prop =3D parse_interrupt_map, },
>
> ---
> base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
> change-id: 20250930-mmc_pwrseq-247089ac9583
>
> Best regards,
> --
> Francesco Valla <francesco@valla.it>
>

