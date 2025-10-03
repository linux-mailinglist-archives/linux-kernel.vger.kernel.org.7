Return-Path: <linux-kernel+bounces-841575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E59BB7B51
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2AA44EE261
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A782DA75A;
	Fri,  3 Oct 2025 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ryLEMopg"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F323AB8B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512179; cv=none; b=lAudNyTMyhmKIbgdbnvd6Bjz9zvtocYK6hzthbMDEyLf4zI+IItMx/4jDBXX3+H6H7KtvH7PryoqksX+6KtHaIqGwtHsHLqh9bw7ggDo8UgVtVrYZYwlCCaBlvXjjEH/TnVem45RwtI7TUfg7OoZt1DopKNyQB3uicg8LAQNCEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512179; c=relaxed/simple;
	bh=nG0ahfV68XEs9AbhYnuX7OiFNRl3Vvk1C7mNKiqb+o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZVjzmNi62+gtRNl6BQVZRXuqysLjluMpPSHZur6SgQCbgFlLpgQG5WwBx/nFbmxi/lDV6Lt0wa7lP6hY8kPVNCLdUOxNXuHnehgGomsTGRVzZDWKf5jFS4Dq3IwyrA58adf4p6jlZ3cPNuWOj/GaHydi2oa0bCg6FUdmDPqbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ryLEMopg; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-635283199a9so2332107d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759512177; x=1760116977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGWR7Op0jGJB/hnyDRBm1VaEtVV6gV3pqYTKcigBXCc=;
        b=ryLEMopgDzpxHODHZ43tFOza6ZmIUOW8c+Kdq97oCHLNzeBZmiWAqyt33mhQDGsrlu
         mzATRdt9RE0qzHRhyC1KRPGA5FZtfwxNDFjQoYCa5jAu0G+muMrhmf2WUFmHzLm0xqa+
         0oy41SRqH+h1WM3GMZJmjDU2pzBbJSX36rT9rE+8J7XEeRQjfwuJYHt0TII+YcTk5aJc
         I3IWrXO0kcT1EnubYjoWzWZHrR4SQ0qZoBhqCV7CQ5ZLIod9Q7qYKHSVDqV6d4wivOKq
         oqA4Av8FZokhGhuC4EqGmvtzt/eTfT3FpykYKdHCoXch80929mRJKLXOV8hpGXT1iczU
         rOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512177; x=1760116977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGWR7Op0jGJB/hnyDRBm1VaEtVV6gV3pqYTKcigBXCc=;
        b=fGEq+tze1nkgAZNSyQtfXKijy0s85PwNVA5iefv+U7g4HjinidSURiLjVJ6vVbwwPn
         QT3sOt+1Zx6inXA+otlpYclkK7Lmq78/5Pto/J8A4z+nESX/aT0ViJ4nHLIbyv+zua1M
         ZsZGoZmXoFD4qYpzQ1ruVuFVO8Nxiy2LS+xpaKksQCJWBV03itu27MiBhRhawx6HcRco
         6sGfmHjHm1Mvb0L3aNvUtpgoqTzsgSSrZO26afnrcr8g6MkBbTSnD+P7jNVrsl7Pg5eK
         Eh9gL3aS8b2YezMDSH6j/a0Kypnd3rV1Z11WSLGfxkDCDcjXYpS1z08JZ54VGpdCOGIL
         N1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW5DLi8UAuLYYYSvaEbetIWRzqhtVdiE36ExlGT5E83iu6kIGYPqofvM785a/nLeRzJRhooY5hjQZ9Kl3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTtlGg9ikHkS8SglVeG4Op9nXg72GN5ZyXNbbGyiucC9b4jNnY
	QwA35qpRNruPgylU8ABVjkm1NVX1k0DgqmY0igfI3RMTB4Ed90WHDpQCGpHyh5/LtNtrxqSUvnL
	Yi4OoSimP1r0gIycJg/IKSyYsPw/Bo6D/A6NNCqLGoQ==
X-Gm-Gg: ASbGncsOBXGzBSX4e6b1kVBlc4P3Gip3ujNfVOwG+5F5UWZagVH0REscJFxiI4rgTLN
	znXOynO/CQwDb6RKGj4T3QZ992/TTtWPncGqF8ISHFvbrH5I8tOv3m3EWjzSzTIQ4n+U/D2j0JX
	HkfRBkrEX/vuZly6Kzsup/Mj1iODxUF9ZUB3imTSpn/EN3tOIkdx0u3LiKiN0XydmVQ06sZTRCS
	qnVpOIu7Wson9v+5nMVMxPu+h4X3ljdo1L14/EQhHWD
X-Google-Smtp-Source: AGHT+IEaOvU8KB5Em4L2bWs/Xj/IkcvvxTcqZJWq4PxSiqWi8wXfy+Ft4q6LsFqAEYTMabgdZG5h7FcKPPHNINr43CI=
X-Received: by 2002:a05:690e:1c4:b0:636:d230:7d82 with SMTP id
 956f58d0204a3-63b9a0e08bdmr1960868d50.26.1759512176832; Fri, 03 Oct 2025
 10:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002-gs101-pmu-regmap-tables-v1-0-1f96f0920eb3@linaro.org> <20251002-gs101-pmu-regmap-tables-v1-1-1f96f0920eb3@linaro.org>
In-Reply-To: <20251002-gs101-pmu-regmap-tables-v1-1-1f96f0920eb3@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 3 Oct 2025 12:22:46 -0500
X-Gm-Features: AS18NWBQR2ismkqxDcti8kjrNtnGND89e5O87aRDbFrbCUVqVqwZBLFSImHDwoE
Message-ID: <CAPLW+4=mVbXex9Sxm2oEq0j3RJ0_KtXRq2Ttt5cfQ_dxXTuhSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: samsung: exynos-pmu: allow specifying read &
 write access tables for secure regmap
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 5:33=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@li=
naro.org> wrote:
>
> Accessing non-existent PMU registers causes an SError, halting the
> system.
>
> regmap can help us with that by allowing to pass the list of valid
> registers as part of the config during creation. When this driver
> creates a new regmap itself rather than relying on
> syscon_node_to_regmap(), it's therefore easily possible to hook in
> custom access tables for valid read and write registers.
>
> Specifying access tables avoids SErrors for invalid registers and
> instead the regmap core can just return an error. Outside drivers, this
> is also helpful when using debugfs to access the regmap.
>
> Make it possible for drivers to specify read and write tables to be
> used on creation of the secure regmap.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 3 +++
>  drivers/soc/samsung/exynos-pmu.h | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exyno=
s-pmu.c
> index 22c50ca2aa79bf1945255ee6cc7443d7309b2573..9f416de03610b1727d8cc7761=
6e5c87e2525cc69 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -635,6 +635,9 @@ static int exynos_pmu_probe(struct platform_device *p=
dev)
>                 pmu_regmcfg =3D regmap_smccfg;
>                 pmu_regmcfg.max_register =3D resource_size(res) -
>                                            pmu_regmcfg.reg_stride;
> +               pmu_regmcfg.wr_table =3D pmu_context->pmu_data->wr_table;
> +               pmu_regmcfg.rd_table =3D pmu_context->pmu_data->rd_table;
> +

Seems like pmu_regmcfg declaration can be pulled under this "if" scope
-- just a thought for future.

>                 /* Need physical address for SMC call */
>                 regmap =3D devm_regmap_init(dev, NULL,
>                                           (void *)(uintptr_t)res->start,
> diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exyno=
s-pmu.h
> index 0938bb4fe15f439e2d8bddeec51b6077e79a7e84..113149ed32c88a09b075be820=
50c26970e4c0620 100644
> --- a/drivers/soc/samsung/exynos-pmu.h
> +++ b/drivers/soc/samsung/exynos-pmu.h
> @@ -27,6 +27,10 @@ struct exynos_pmu_data {
>         void (*pmu_init)(void);
>         void (*powerdown_conf)(enum sys_powerdown);
>         void (*powerdown_conf_extra)(enum sys_powerdown);
> +
> +       /* for the pmu_secure case */
> +       const struct regmap_access_table *rd_table;
> +       const struct regmap_access_table *wr_table;

Maybe it's worth to add #include <linux/regmap.h> in this header, or
at least forward declaration struct regmap_access_table?

Also, would be nice to have kernel-doc comment for struct
exynos_pmu_data at this point, but it might be out of scope for this
patch.

Other than those minor nitpicks -- LGTM:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  };
>
>  extern void __iomem *pmu_base_addr;
>
> --
> 2.51.0.618.g983fd99d29-goog
>
>

