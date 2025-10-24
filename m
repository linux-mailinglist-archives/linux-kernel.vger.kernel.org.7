Return-Path: <linux-kernel+bounces-868065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C2C0444F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B2A3B6E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD9126560B;
	Fri, 24 Oct 2025 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7bmDer0"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52222333B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276993; cv=none; b=ZAcB/cYs12mANBvTIriNBaYQzPANosAcOEMtWBoeLAqYtH6P+HH8cfKqmL6w2ms7cX/TTtGEpfqwX0nxEXte9fpp/sGXZNit+/cb3P+2VIuoWsuKfaLrpiLxZhQMxGSC7DaO3miwZ9HhXJbT+zU4WyLQHknaBBoNkQgMsaJRcik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276993; c=relaxed/simple;
	bh=BXg+mCHVidA9iZrXn9I516cQrbPXuicvfr+PM6FtK0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdAanR8qeNkfMTaSwb17IG4t3TZxt4GBpjbS6q08qi1Iopgh4AYvzclywJHe/D98IEdXeqPRS6RklXQMJyU8oqw1f/GjZDTIZrg6iwb/mvkoNUh4TjIMdUETHa2G+ILJOTFpbxvhv2M5ruJSOAdzeBJ46AWdHyhEKuuTrX62pnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7bmDer0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bcf228ee4so1521812a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761276991; x=1761881791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlN5DvyH2+GBtNgIhKU58Oi5/dzl5ldvweXQc1JJd8Y=;
        b=d7bmDer0MDSH/y2XqezOCVSCO2++raVRqfBkcc5qYGQouFTD7B81CdRVRJyClwxCcg
         bdIR9UezSc1S0ZFE9OhQBgqXcavCVVfnUfUddviv3lVKiC/Nu654xY+xMY11QUTiW5uc
         O7ewfUDVNnHGEzptij6hDyJ8FDKZILj3fkHT2yrba4FImAn2rBvHyEpeZ4C5vnv6XMVx
         Az/BxMt78k1MmezUUR/EXrudw0BYqzYWN+PzvEb1tH5F6EadHds0sJdE3fKlld8a3Ieq
         6M0jpqq5Lr2T2NIlTQDEmGVCsaTj6jJwd8t8ODbamZwCCPWtKGGV/chhngvaCOCAIfry
         Y1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276991; x=1761881791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlN5DvyH2+GBtNgIhKU58Oi5/dzl5ldvweXQc1JJd8Y=;
        b=hqoUoJCbgP/YuTSnxkH6sw1qNtVtN4tHjmrfN+RydhuJzRujVLEpil5fDFBuOSb7Cc
         sgLeJLhg1ME1rUVNcTu21nOnelTesGJxh8Sqt82W2IyiPpai7yAqb6O6H0LvLMez7j7e
         Ec93EyE+FZ+GeTZ0UL1iRH/2pOdSbHKhw3PNHGPU4TPpsD/rvR3DS/4sHHfECSTM5b92
         MkWyQOdCpHp2ppikqBhehPudJ/3tgr9EvfHuDZt3fcIgQstT4EFponY8mx/KT3wvbf4P
         TV4Ps3JKqbWbTo/lW7MQbtx9AOQe2/CMlEcK9UC89dFd/XXTPhngEaIUNN8thIthfKTA
         Vd0g==
X-Forwarded-Encrypted: i=1; AJvYcCXmV1aoITWAgj4p1YW8d1sK/7P1b20EYd7Crxy6PKdVNeQ8apaM42CBbMFNXVUcNmw+55ZQPx2muFyieoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP1yvSQJqiZ/+nIN8Lpy0F6uLs8NKgWxvWFVQvTDtrN2pJ64Ml
	CbQgT7FikPgDDU3jxUAvpywUSQAs2iQv8vggjI68Z5ae7IOqMZpPvqUF+iOYOyKKvs5MK/up40W
	wkKnbeCczPxvQmOE9yKZ2ueya3URH1jk=
X-Gm-Gg: ASbGncsV4/8MlO8u/6HqtTfyCrFro7cE+ywzN76yCybsllRWYOdufXUCW5FnF0OcspB
	BDDW+wYucjFsFUOlIyOxiWPO8PA9UVUZyKTcCK5qBzz0DZBCL2xFPaGqqNCyW/S0Uxr6rQpiui9
	1X7esYlGslwtk0dWL7XA6bnH4FunIFHTTUuh+cZD5FRvgI9xXaPDIMdYxd3w0eSIomzn07uqu8a
	RV0zpFTNU+QmZW44limTLdR0CnMfMoZlTES/pZTZxhC8eXnbJKvpvTOkMfKRhXWBQEdcP0=
X-Google-Smtp-Source: AGHT+IHmAjQXW6oneD0rQyql9NZfZkZxeQX5ygzBPkzltdafT4YRRH8XN5RuqvianxiGov8Gjv/rIG5Ew31uUO9ltuI=
X-Received: by 2002:a17:90a:e708:b0:330:7f80:bbd9 with SMTP id
 98e67ed59e1d1-33bcf9202abmr28546749a91.31.1761276991065; Thu, 23 Oct 2025
 20:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com> <20251017112025.11997-2-laurentiumihalcea111@gmail.com>
In-Reply-To: <20251017112025.11997-2-laurentiumihalcea111@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 24 Oct 2025 11:36:19 +0800
X-Gm-Features: AS18NWAUWGWX5ZUSW4jhS3wlXEPW7gKSGrcNhdPOEUHBjtb-V-Oq2o2RBvRxgdE
Message-ID: <CAA+D8AN=Q7-b-SxfziJqsk1T-yNxw+VnOPAGsQhXh68e3UpN5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] reset: imx8mp-audiomix: Fix bad mask values
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 7:22=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> As per the i.MX8MP TRM, section 14.2 "AUDIO_BLK_CTRL", table 14.2.3.1.1
> "memory map", the definition of the EARC control register shows that the
> EARC controller software reset is controlled via bit 0, while the EARC PH=
Y
> software reset is controlled via bit 1.
>
> This means that the current definitions of IMX8MP_AUDIOMIX_EARC_RESET_MAS=
K
> and IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK are wrong since their values woul=
d
> imply that the EARC controller software reset is controlled via bit 1 and
> the EARC PHY software reset is controlled via bit 2. Fix them.
>
> Fixes: a83bc87cd30a ("reset: imx8mp-audiomix: Prepare the code for more r=
eset bits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
shengjiu wang
> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-=
imx8mp-audiomix.c
> index 6b357adfe646..eceb37ff5dc5 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -14,8 +14,8 @@
>  #include <linux/reset-controller.h>
>
>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET      0x200
> -#define IMX8MP_AUDIOMIX_EARC_RESET_MASK                BIT(1)
> -#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK    BIT(2)
> +#define IMX8MP_AUDIOMIX_EARC_RESET_MASK                BIT(0)
> +#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK    BIT(1)
>
>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET    0x108
>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK      BIT(5)
> --
> 2.43.0
>
>

