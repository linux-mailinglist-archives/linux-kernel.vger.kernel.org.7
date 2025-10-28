Return-Path: <linux-kernel+bounces-874836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB2C1732B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F2C3A415A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAEB217F53;
	Tue, 28 Oct 2025 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="huJOEh5w"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326AF301716
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690677; cv=none; b=gnGZCO11HpVJxU+pimyKHix1kT9N8XSdVzcDKEmOVSPZqRBjC/BbwLZkYoLeClVocAMk2hAq7IyJrbK8VV4taUpBgfqpTvRFzrN+WFpGbcHyql/vneYDDn5CfRbv5g0O3BkzpPlwMAzx9e2iySpdYdESr88VqskRwyg/1Bcj2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690677; c=relaxed/simple;
	bh=4f/E8wYsA6IVOnqk1n/iSdAEWxxL1oai9Ck3rOXgjDE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUo1cY5AMkwxj2fKY+EBZdn6dHL18nzbrTqhb6XDQPSfb8TYzkWnQdvnEjDEtAbYHuKOUAFUuOYFA0vX3PbJjjolSYn7hQz2TDb/SltnbIgWmWnArhAx7I8hMIA6VPnX9KNDA01YQi8+qiAevL/GMOghxIEEpdn9NyI962PEmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=huJOEh5w; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so6601653f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761690673; x=1762295473; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITM43CPLBwOuYd6o70DQuUBrw0NjrXbprfM503VifJI=;
        b=huJOEh5wbAJC2aZyA7eU0vlLrZgWZ5ysVoxyRjXINj565ENnMZPuzHG2yq1wcVtGwX
         mfYTId4nr2Y53k1sfdlxVlr+hmFzLdtnE8dS41MfwtNA+mszZv47iKnqUMQA1JGIkTj6
         rviSj59H6daCpxEjZmWy32mgKAwR8YbsL+JFUSIDWaZ4e72W0G/h4fbbTjo98xBSpAEU
         pTGffhXVf77j+MDHvu7tlHFRnPjFaPEkK28UaaIwzQwdnhpKC0rb2LyfFtUCTn814hZ+
         qRbxyYpWBx1FuUCNozEn0W0BWfYwGY+Itp58/bNUg7imwl37AHZqQlrBRns9RFq+fweT
         APNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761690673; x=1762295473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITM43CPLBwOuYd6o70DQuUBrw0NjrXbprfM503VifJI=;
        b=NAU8VWPb5IoaQBH5Gownc3rCGvTGxtedLVXT16g7dZZV1pZrObvJdUXsDn/JK1QZzo
         19dcvvS7amw1s9YNVX4kxgXqLALqg+0LFY2nb1lunB92xZEYzOae0OciZFh4Yicm8ilT
         1nMjSnbDJ6aIu1y6k4N3/S2ZiaOkkrztmsTxTDGSHet2CGNUUGs8OZorDOXEvJMxmHkP
         SfsUU1QATbaQWC5vjvLJymdTi3PbbvB/9HjnVUOHBbmBi1PQK/2Sp4QTcqScKOZ31tfF
         e/nMdCH9UNVrZVu+tsS+iZtNC4kxfBcX9MSAVDpg1EGgHMl1ceXBoxs7U7Zt4AnrDMej
         YYXA==
X-Forwarded-Encrypted: i=1; AJvYcCWU/pb4MsIUVsiftsC0ggZnCQbN+mGQWfg5FSOicMQ2CK9fKWSPfZM0paY5eMbefyq+vrTtXfascZSPdvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOlPvvnzyi5H2Y/cJb6KdRSJ0gGDU9MMv0sbFGJqSIVuCPQ7u
	NDqPwWusiZOzXzoXOG4PWpkPjP0jr732oueWGErhBh00oo6+Mt9SPgW1j/EEyC7GQPY=
X-Gm-Gg: ASbGncuB76RWtgLjiSSaxh52I85yRLUjicu/1dPTQPRuR7Xi5ch0cS7IFutTsfSdqIk
	LPq3GfML7LCLWW8JxNJS3nYAWTryR/XXdyab4qSdmtiGLI+jxU5WFMYasBNBy0BdkZL/YLRFrKC
	M13VM4FCO19s7gkjRafqcXRWfCDV91CgJpJJikASyqFjTVvc9JE4vJOLiyrbWVhUOgK6jOq2b+x
	+B1uNSteYZgYZwegSqw0R+NYFBZnvxKaMwiFAQW++Td80fCqBPVc8yfLMWQRvOPxkOtfmMesIra
	6wqu3JUmb83E0/LVBcD5vMUPxvt7RiDEqO4iBEVhXm/Z9q0mErzumwm9ls0IKX4V5fbwvsuWlzJ
	oOtvn6rEBD4lU434R1lLaHpzZdqm+8BbKJ4UikuDsldvaLqOyocRZjwY3/JthktSnQfmdR243mu
	GaVTwvwp0idQaWq4KSM/oH6+dXXDw5Z0plRkRwkkp/4VhiI4LdKavZnk5M
X-Google-Smtp-Source: AGHT+IF39JXaNKoZtJy/RnakC95kMOdpqIZDZsaP2nRMKdtss4WP+ExeeGb//XMDyt0ZBLq/3VZ/Jg==
X-Received: by 2002:a5d:5f48:0:b0:425:86ca:98c with SMTP id ffacd0b85a97d-429aef86b59mr393337f8f.28.1761690673262;
        Tue, 28 Oct 2025 15:31:13 -0700 (PDT)
Received: from ?IPv6:2a02:8071:7130:82c0:da34:bd1d:ae27:5be6? ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm22707923f8f.38.2025.10.28.15.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 15:31:12 -0700 (PDT)
Message-ID: <aeee5f47ef2842fde66bc66fc598ee4f007fc1c2.camel@googlemail.com>
Subject: Re: [PATCH] drm/panel: kingdisplay-kd097d04: Disable EoTp
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Sebastian Fleer <dev@dwurp.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Tue, 28 Oct 2025 23:31:11 +0100
In-Reply-To: <20251028214045.1944956-1-dev@dwurp.de>
References: <20251028214045.1944956-1-dev@dwurp.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Sebastian

On Tue, 2025-10-28 at 22:38 +0100, Sebastian Fleer wrote:
> Since commit d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable EoT=
p by
> default") panel output on an Acer Chromebook Tab 10 (google-dru) is corru=
pted.
> The tablet I use is equipped with a kingdisplay-kd097d04 panel, disabling=
 EoTp
> restores the correct functionality.
>=20
> Fixes: d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable EoTp by d=
efault")

Just to clarify: This is not a fix for that commit, it is a fix for the
panel driver itself.

EoTp is the default in Linux, a panel driver cannot enable it, only
disable it.

Commit d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable EoTp by
default") fixed a bug in the synopsys dw-mipi-dsi because EoTp was not
enabled there by default.

Enabling EoTp in dw-mipi-dsi revealed an underlying issue in panel-
kingdisplay-kd097d04.

That same issue appears if one would connect this panel to a different
mipi-dsi core (because there EoTp is also enabled by default).

> Signed-off-by: Sebastian Fleer <dev@dwurp.de>
> ---
>  drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers=
/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> index 2fc7b0779b37..893af9b16756 100644
> --- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> +++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> @@ -359,7 +359,7 @@ static int kingdisplay_panel_probe(struct mipi_dsi_de=
vice *dsi)
>  	dsi->lanes =3D 4;
>  	dsi->format =3D MIPI_DSI_FMT_RGB888;
>  	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> -			  MIPI_DSI_MODE_LPM;
> +			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET;
> =20
>  	kingdisplay =3D devm_drm_panel_alloc(&dsi->dev, __typeof(*kingdisplay),=
 base,
>  					   &kingdisplay_panel_funcs,

