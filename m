Return-Path: <linux-kernel+bounces-644301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D5AB3A15
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E5A19E0259
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEFF1E3790;
	Mon, 12 May 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="E5zlS4zM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7C1E2602
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058977; cv=none; b=iN/rI+RBT0B1iR4Why41hgAMUZcTydrwCxswJbc/IN9NmENCT+1FV26SPA+hlrVTOHGowRtKasqrOLgu+J/12UHOwdaxScDoL4dUqUZleattMQgwcHNmeJphA1yweWJ3ZgLuiYT1uDoDHgf62PvLJQaWcJVMoD7jBdoFoYL1NMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058977; c=relaxed/simple;
	bh=7XK6JgY+Zequf1Eb4RpAPe8+LKRbtcIi0eB/IHQ1drg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AyQw/5xJSi2HHfRyLFTOgY0wsYHGfC8tigbjAauqYXDk5eh/B1CEhMd9y1TmM9afR5hRRaRCN3dpul3e3wobYYpi3LjHqcnu2n2TswM/KVjlu/BBRnoOWN2K8oeFi0QfDXfQv6Kw+IWrw5zPV4Yj5gojjmRV04C4NsNXf5jfRv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=E5zlS4zM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad221e3e5a2so479516466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1747058973; x=1747663773; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ/6iwA8CFKOFslZ2GtB9HB/9Djjjmbe1UGAQxtuVQM=;
        b=E5zlS4zMguMnX7vsb8aY8y3rUkkCylnbY2uJpBnMn2gSeV869PE2nrRNMWWFqQOTM+
         sdkQNeoMPxY8BkBhYetZESAIKhCEWiNEswzd4jmYxlFdvt0gh/N1wg+V8TBo/41P/dF4
         nTaNLl+po51P27BBhUUEYwDOycAqK+tGHOvPFntJnbiHuExUZtWdyjmsdyzBRfN0ppJe
         3xQagvaRt/VPiRbaidbCF6lIp007xMQXWoA54TKrUqtaWe/luRj10mgSYvCkMmqkF/tp
         TytK/99TzU3wy4arRDMmuEHk3ogLsb+bskyIhIi9gQMJGVfYbjDmE/F0UNXGExCq5CXq
         8DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058973; x=1747663773;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dZ/6iwA8CFKOFslZ2GtB9HB/9Djjjmbe1UGAQxtuVQM=;
        b=NOYH59mCR0EDZK/192AqWo13B6fxJMQs4Nkx2hoIdaV04L3LE2TLMD7pCJFTEuVnxQ
         HH3VEXnoVQjIxFSX6P7crI+wg6fGTRA7twWTGDGlS0curomhQJgFvk8dohMRRf++BIMQ
         WH31HqqlzXJspgJYLXKgc8oED2rq0EMIhROuaNznbESw9IHHIASD7uaWrsZqyzQxOs0v
         nwWYpds2RugVbLQxyUz2KWr9ni1ZSMy8VTHegPOHDrdAZDrj63IhXW2EESdsnpWV2B7n
         5+nb1IFxD0iS0xVt0FQiFdUFvRL2pJDPR7BA8U6lOLdpr16J0rzeAYg3TybTsM3ckixu
         Bi7w==
X-Forwarded-Encrypted: i=1; AJvYcCVQTw6z+Lwci6g7gEEIpEEUAGbVcYuqYZvnG1J+CI6IjeV1vLPw/QIgbHfG1f1yWuLohpNi2tTlpKa1rGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmqn1BfA7gTbQhuhKmHKkgQDTl1u2vbLnk5WTjTsNYivBENT4S
	P+TRKX93QNHW7+A/K4iP/LZ69wVwXu5hwtUeFSJ6036j25RWOR+EWKiKnlVH6Xw=
X-Gm-Gg: ASbGncunYdiinLKnvCqmVFKPoxsST5AMxHOaxzU2xVCFRlgsl61a08ttTwNCKXLA0FF
	5j6VPyVk6uc4y5OoYdQAfwKK1bx0i9t3v1KH34dfzNr9FJbUBF/Y6vgUsDIwKXrTzZPHXXEih5H
	A5f3KOhiP7wE/S+h2LvqT/H+CeIBR/qfEzeCgJcR0/5M0sDF0kEuS8SrjFMp7deAtqYC15zD+wT
	5efQe4E+/87J/WDmtIrnFEaqpDIriFKDoBW+4P1G3PYFBj2z70dBj8vMa9qqkmZivzI6REj6/2d
	oFllgmo9yvVFW51ZRYt7iYiTRo5WKKQLKu07QV87dmnMT8Cx0h9P
X-Google-Smtp-Source: AGHT+IGG5FZn2sqQPs5HV5Ni5h1EziV7iYxDUiiwAQm72o77onMUWKhqMQJHb2DHtLorhV7URjJsDw==
X-Received: by 2002:a17:906:630f:b0:ad2:49df:4446 with SMTP id a640c23a62f3a-ad249df4ac7mr391806966b.60.1747058973286;
        Mon, 12 May 2025 07:09:33 -0700 (PDT)
Received: from localhost ([41.66.98.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad249c66fdasm278196766b.114.2025.05.12.07.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 May 2025 15:09:30 +0100
Message-Id: <D9U8PV79LTVH.38UZBFZD2VB3R@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Mathieu Poirier"
 <mathieu.poirier@linaro.org>, "Luca Weiss" <luca@lucaweiss.eu>,
 <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] remoteproc: qcom_wcnss: Fix on platforms without
 fallback regulators
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
 <linux-arm-msm@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250511234026.94735-1-matti.lehtimaki@gmail.com>
In-Reply-To: <20250511234026.94735-1-matti.lehtimaki@gmail.com>

On Mon May 12, 2025 at 12:40 AM WEST, Matti Lehtim=C3=A4ki wrote:
> Recent change to handle platforms with only single power domain broke
> pronto-v3 which requires power domains and doesn't have fallback voltage
> regulators in case power domains are missing. Add a check to verify
> the number of fallback voltage regulators before using the code which
> handles single power domain situation.

Thanks!

I've tested this on MSM8953/SDM632 Fairphone 3 which is broken on
v6.15-rc5 without this patch! I've also heard of MSM8909 being broken in
v6.15-rc, and msm8976 also uses qcom,pronto-v3-pil.

Hopefully this can still go into the remaining rc's so v6.15 final works.

Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3

Regards
Luca

>
> Fixes: 65991ea8a6d1 ("remoteproc: qcom_wcnss: Handle platforms with only =
single power domain")
> Signed-off-by: Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com>
> ---
>  drivers/remoteproc/qcom_wcnss.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wc=
nss.c
> index 775b056d795a..2c7e519a2254 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -456,7 +456,8 @@ static int wcnss_init_regulators(struct qcom_wcnss *w=
cnss,
>  	if (wcnss->num_pds) {
>  		info +=3D wcnss->num_pds;
>  		/* Handle single power domain case */
> -		num_vregs +=3D num_pd_vregs - wcnss->num_pds;
> +		if (wcnss->num_pds < num_pd_vregs)
> +			num_vregs +=3D num_pd_vregs - wcnss->num_pds;
>  	} else {
>  		num_vregs +=3D num_pd_vregs;
>  	}


