Return-Path: <linux-kernel+bounces-764547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA10BB22458
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110224200EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CD12EBB94;
	Tue, 12 Aug 2025 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="DtpD1KnN"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551862EAD18
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993624; cv=none; b=lm/kpq672hkuyParsZgXvXOECQTW4vXxmuOtAa3dgvRO+5LVsTBygaenODjt0jioFbPvcKviZmTUojC+VT5+IQCOsBb2UzlZjTn7iUssHbCB13e4uw3IREGGV0m4uB3yhzqaAPjm6anaeSKe1/XMftsLVQa6C+bWJkQhAX8HE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993624; c=relaxed/simple;
	bh=BUfIlbd5/UkD2wVzHyZHd6/3DmqElGGDfku/aZ/JPzU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mf0INUz1XOwaBNeKx07wcc4TKbQUrcegUhxLnQWK41f6MxCnOhdslWVabWUnxzia8PPYDqjrdUsYkRpiq9nyeeHgMv8s1DYwljRmLU+lubuAI/ANoFgV4eRB4gSXl+Btu6MLq0H0jV8Mn3z8xgb4OLEWYwsUFIOTR8MiSJYGlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=DtpD1KnN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af93150f7c2so803124966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754993621; x=1755598421; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFxusUULII2JCz6cFWedFdJO93eFdX6UtIqw/uCfDBk=;
        b=DtpD1KnNeqMhJH76tZWp/JAkq/8BQn/FcoTLPjHVOQglkBCuyjBRFXflS4gB/q23Wh
         0sj4smO7AuHu0SXW1y1QH7k6l+lUfXdtuvO+JmRWxsNe56NYb5Cz57Gig2lf3qudpS6D
         DgDSCZ7x4g5p7zX1xPXOcqFZ/3yFQIOMiZaGAJ84N99AP4QhtdDIUb9f1Pz7cLFy5sai
         xwoOxc1ST/p9/l9dM6kmtwYe4DLeYRjCoWAmRRAGF0Fnak6RqYQja1hB5EvQBgc9WFFz
         dyaTvmMouqJR5KzuCuvNPYCHdledrHaZ08CNlUM6vpr07eFKHeGku6Fx51wKMIbdoGOF
         c8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993621; x=1755598421;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mFxusUULII2JCz6cFWedFdJO93eFdX6UtIqw/uCfDBk=;
        b=tqUJHfUOmYAbN42yUnALGnUJjtRBw4tmL8M5+hryOG8nmq4AWzoLm1PNN0Qygjz7xd
         qbj5A/dVaC5MqDQKdyf8d8oxN0SkDXz4GqiQrPzMs4/ljF5mQu8noHwhFVSX5mCTJKAX
         bCFUXM5BTNR+0nnXbR/Bgs3oVnAwReQZExTqJRopNbbFmmjJOMjb21tzPf+4DavOhnhu
         Yg1VKJk/PVUNq8TKkw3V4NwOPv8PW/7tdsCKobLG3gcEjidcUvu13Q3Lko1nId+xGbvG
         FwKh9pEsQvti45S//QIQVZBldhKvDcyj4gYsgVK5lrnfzNaXN6pIn41hdNnPjYxiSCac
         HZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWYzYzbXJnzcwAjIFusTHhoAWwmJfD5kkgcdXCKCRFMHEmc8E1lsJ8aGZZiX1cirzgdhbNO2WWSTrzlaXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUs+eui8vKcodLuCEiZWyXYV4N3M183y52T8+WN01KoeqYUvJ
	Cu4X4IrWQEeqmGWMtGdi5aNSQbN/WBQhkcYNRDlmRubFHRKLJphqQ3gAtTRrLsFxoTg=
X-Gm-Gg: ASbGncu/YpbbAaihfv5VhxbNosmvUmfZ77eskds9TtNzmQCOEz7869pW7vQarnPnUVW
	XAMlvaAZPWu+IqTdd+ON5Pk1vzxvxuSVDr4q7+/q+HhakFhcC+qFSee6hw6R879ITaK7iq4K90X
	60CNzFnhSGOz+IlI6H65JqAFWR8gJFdcRgWUgom6j/W+vRdH2U/gHuSNlc617oE5F0hXXvc5j5Y
	pQVgSq12gIaTReTbd1BJ+wgafrtBrk+qYi0fkNuaXhwK1Fe5drZieJyJLr0+pgmNp4efUe2dhpj
	PF7ZDjFlFEAISqi0Z8dO/9inlxUbqlOFcejBPskKvfP4mIzb/fnXdS+tlYEanB6ZgLKARPyfAGV
	jdRwxQ+hJKiwNr9wXYm7RhT06THFIjQ==
X-Google-Smtp-Source: AGHT+IG4ua34nZK6YcSnAqJDbTdQgxSKRc/Mui8zRSNQj1FuZgDFYh3if8GQtcr/adYrVmTV/vsBYA==
X-Received: by 2002:a17:907:7fa8:b0:ae9:ca8f:9642 with SMTP id a640c23a62f3a-afa1e04122bmr244712166b.15.1754993620573;
        Tue, 12 Aug 2025 03:13:40 -0700 (PDT)
Received: from localhost ([2a05:2d01:2025:1908:e499:6dcf:1e86:8748])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23ffc3sm2177082666b.124.2025.08.12.03.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 12:13:39 +0200
Message-Id: <DC0DBER6477Q.143SU9KXEI6FN@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: qualcomm: phy-qcom-eusb2-repeater: fix override
 properties
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Pengyu Luo" <mitltlatltl@gmail.com>, "Vinod Koul" <vkoul@kernel.org>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>, "Abel Vesa" <abel.vesa@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250812093957.32235-1-mitltlatltl@gmail.com>
In-Reply-To: <20250812093957.32235-1-mitltlatltl@gmail.com>

On Tue Aug 12, 2025 at 11:39 AM CEST, Pengyu Luo wrote:
> property "qcom,tune-usb2-preem" is for EUSB2_TUNE_USB2_PREEM
> property "qcom,tune-usb2-amplitude" is for EUSB2_TUNE_IUSB2
>
> The downstream correspondence is as follows:
> EUSB2_TUNE_USB2_PREEM: Tx pre-emphasis tuning
> EUSB2_TUNE_IUSB2: HS trasmit amplitude
> EUSB2_TUNE_SQUELCH_U: Squelch detection threshold
> EUSB2_TUNE_HSDISC: HS disconnect threshold
> EUSB2_TUNE_EUSB_SLEW: slew rate
>
> Fixes: 31bc94de7602 ("phy: qualcomm: phy-qcom-eusb2-repeater: Don't zero-=
out registers")

Oh, not sure how this happened. Thanks for catching this, I do see the
problem in my original commit.

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

Regards
Luca

> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy=
/qualcomm/phy-qcom-eusb2-repeater.c
> index d7493c229..3709fba42 100644
> --- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> +++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> @@ -127,13 +127,13 @@ static int eusb2_repeater_init(struct phy *phy)
>  			     rptr->cfg->init_tbl[i].value);
> =20
>  	/* Override registers from devicetree values */
> -	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &val))
> +	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
>  		regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, val);
> =20
>  	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &val))
>  		regmap_write(regmap, base + EUSB2_TUNE_HSDISC, val);
> =20
> -	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
> +	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &val))
>  		regmap_write(regmap, base + EUSB2_TUNE_IUSB2, val);
> =20
>  	/* Wait for status OK */


