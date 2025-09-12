Return-Path: <linux-kernel+bounces-814760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCDFB55856
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8115C30EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E762925F7A7;
	Fri, 12 Sep 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q5P37S8D"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293822256B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712441; cv=none; b=SO47RoqtDFWOsK/plNlM5atppmIwGmven8JtOS/QR/IFvpdVc17Eg0A9lD111LSutdyluR8JDInvRe9yd10/mwEOFTLd4drvaVEju0dmkieu7eFZUbn43ovBR/Kr0vjfTRBTzU+9saV2O+wVy3huJPqykB2bZ2sYa5RHWxWVztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712441; c=relaxed/simple;
	bh=eIu1Qi+KLg7MjIF/lKyRFYPROFh40t7hDxlDmFVmdMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFX6L2kaLjISdCkkhZaUgBbkoRQHVFatuY19rGDESBXeBT9XDgPmyFuCTicBhZBL+47u7Ahcid8hEyOxwkaA3gTzbachbUDHlkqtDPXfBMNlC2t9CyPyxgpTVsZJrsw6CNj6/eVan7z77oXpXvkmCJWL+w7xSDyCjdfBmAf9gUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q5P37S8D; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24c7848519bso22209105ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757712434; x=1758317234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUw0RSeecD2zLIJbgNY9ciVUY1nz8HUWc231yjxf71A=;
        b=Q5P37S8D5Dp4YbMS5YzFQDRhWUdCK59iQDSPgXbT3Wrs1o6jt9psu1AEGhPdU+bPTp
         N2/+XMLBUlmPMrXlL2u2gp0WDQDhUHUz9ilOJ+ZDaAK3VLS7jotaBDp+GlP8n07VqGdP
         vyL/qYA1nIUouOO/Q4k3T90+Og54Atjm1UAu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757712434; x=1758317234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUw0RSeecD2zLIJbgNY9ciVUY1nz8HUWc231yjxf71A=;
        b=L8ActCILjl4SEgweqs0dxseXYEXPQtLVg1I8spJFSucSpd8NWWkeDB9/a69mMM0QBj
         fHNqPvpoa0e6cQ7kw9088eaTEV/lCPTJj/1JnvTePkQJTwYpCNivb1KQNHtNeYmFx4bM
         U9RKY/Xl0AYwEbzIp2IHgYlj/V285X4ViDpW5Xe5nah3Fa6yLztOzMI+FSXLVl5bF/U+
         pfMVQ0s/+Ir3B8Rnxoi+k8b0zVjRYdEJTCxynWdRbOjol4ewj6vTsonMKDv0iaxkxBw5
         Fx3uv4wf6++nTqvOevAQBTh7fLgm6QPIEp9PQ705WasaghGHmGxt01sW7a8W+ct4urHd
         T+1g==
X-Forwarded-Encrypted: i=1; AJvYcCUxyDOyA+01JHVf8jHiSxQgoeeu4fI9uHaD96jCU0LMUo8GhD1GPyiU1unHbRkYiqc69ZCvpthCaW1Qve8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyed3/i0yhx7zvhf3XiDAymMuxAOrOjIA72RVW6s4qcI2MgusCC
	a5GZLohBpp08olqwsxcSkQ/aaVpweG36u5XwpfHkzXMtcu98SlKyCxn8DQ1hDvT47angXHMrkMH
	Jx/s=
X-Gm-Gg: ASbGncsKUHbWvSzbsjOUV9piu40yQ1nZNzSDE/nyzIRitJHralpDPewDJB9AjMLa8Km
	+ZY/084lGsP8eHkIm/fZnhSa8Il6b/3a50UVZGS/hpr/MlmwlVzpHDHt1D0u+GS/BuoorLZDtwW
	aAz7DoSBGGcZWa2/H1MRTcQStXLQZDRzm3zoTDxtsuh4cjWLzBzqXIwjdSoxwM0kKssVdMoKLoF
	wBGhV8RB9kJkrVnOgs5D0bKmc8a8ohVLf2AC4GdFk01Ncw6F70QLjzGyM9ArhahesRBMMDofUTm
	g7B/lZxMxGdnkrM2KkIi8jMf0+iMLogHxcIZXD/Cql5djQ4OczQB1kWs7esv+hj/fL5rA066OP4
	cIfaPOvYTdhQWJ3epyIuXl1vb11l3dK+8G7yRZ9tHBoshENUf714vtDbbXciYnh8RwQ==
X-Google-Smtp-Source: AGHT+IEHT1NMmoY4pU7WHB6OvM7tblCqhkM2QmZQiiKMEbpHEaOpRn1Gxai7EWytNncyjzMh1NHamQ==
X-Received: by 2002:a17:902:ea0d:b0:24c:f15c:a692 with SMTP id d9443c01a7336-25d27c21b85mr55380835ad.42.1757712434554;
        Fri, 12 Sep 2025 14:27:14 -0700 (PDT)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com. [209.85.210.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304ce8sm59626215ad.128.2025.09.12.14.27.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 14:27:13 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso2431005b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:27:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqse0T/i2hZtpQqiQ7Ez9ZjqCYLyzVa3+aa72nOxhZEBjsGsUF726a1LZYmsyjZbETR+Kuk6ZMEfom2z0=@vger.kernel.org
X-Received: by 2002:a05:6a20:3c8e:b0:243:a525:7701 with SMTP id
 adf61e73a8af0-2602c71d56amr5497919637.60.1757712432247; Fri, 12 Sep 2025
 14:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912192457.2067602-1-john.ripple@keysight.com> <20250912210805.2910936-1-john.ripple@keysight.com>
In-Reply-To: <20250912210805.2910936-1-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 12 Sep 2025 14:27:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WVuCNMcPKZjaefAvLXi4Lxxw01HQQc+mEBX1nk8ot-WQ@mail.gmail.com>
X-Gm-Features: Ac12FXwx2NSAgRWKlv3w_UTmvEXFowVCuHvSB09H2KBQpce9XrDYtw6c8t5JqHc
Message-ID: <CAD=FV=WVuCNMcPKZjaefAvLXi4Lxxw01HQQc+mEBX1nk8ot-WQ@mail.gmail.com>
Subject: Re: [PATCH V5] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
 mode with HPD
To: John Ripple <john.ripple@keysight.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
	andrzej.hajda@intel.com, blake.vermeer@keysight.com, 
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	matt_laubhan@keysight.com, mripard@kernel.org, neil.armstrong@linaro.org, 
	rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 12, 2025 at 2:08=E2=80=AFPM John Ripple <john.ripple@keysight.c=
om> wrote:
>
> @@ -413,6 +446,13 @@ static int __maybe_unused ti_sn65dsi86_resume(struct=
 device *dev)
>         if (pdata->refclk)
>                 ti_sn65dsi86_enable_comms(pdata, NULL);
>
> +       if (client->irq) {
> +               ret =3D regmap_update_bits(pdata->regmap, SN_IRQ_EN_REG, =
IRQ_EN,
> +                                        IRQ_EN);
> +               if (ret)
> +                       pr_err("Failed to enable IRQ events: %d\n", ret);

Shoot, I should have noticed it before. Sorry! :(

Probably most of the "pr_" calls in your patch should be "dev_" calls.
"struct ti_sn65dsi86" should have a dev pointer in it. That's probably
worth spinning the patch. It's really close now, though!


> @@ -1309,6 +1372,41 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_s=
n65dsi86 *pdata)
>         return 0;
>  }
>
> +static irqreturn_t ti_sn_bridge_interrupt(int irq, void *private)
> +{
> +       struct ti_sn65dsi86 *pdata =3D private;
> +       struct drm_device *dev =3D pdata->bridge.dev;
> +       u8 status;
> +       int ret;
> +       bool hpd_event;
> +
> +       ret =3D ti_sn65dsi86_read_u8(pdata, SN_IRQ_STATUS_REG, &status);
> +       if (ret) {
> +               pr_err("Failed to read IRQ status: %d\n", ret);
> +               return IRQ_NONE;
> +       }
> +
> +       hpd_event =3D status & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS=
);
> +
> +       if (!status)
> +               return IRQ_NONE;

It wouldn't have been worth spinning just for this, but if we're
spinning anyway I'd probably put the "if (!status)" check down below
right before you grab the mutex, just to keep all the HPD processing
together.


> @@ -1931,6 +2029,8 @@ static int ti_sn65dsi86_probe(struct i2c_client *cl=
ient)
>         dev_set_drvdata(dev, pdata);
>         pdata->dev =3D dev;
>
> +       mutex_init(&pdata->hpd_mutex);
> +
>         mutex_init(&pdata->comms_mutex);

Again, it wouldn't be worth spinning on its own, but if you happened
to want to get rid of the blank line between the two I wouldn't
object. ;-)


> @@ -1971,6 +2071,18 @@ static int ti_sn65dsi86_probe(struct i2c_client *c=
lient)
>         if (strncmp(id_buf, "68ISD   ", ARRAY_SIZE(id_buf)))
>                 return dev_err_probe(dev, -EOPNOTSUPP, "unsupported devic=
e id\n");
>
> +       if (client->irq) {
> +               ret =3D devm_request_threaded_irq(pdata->dev, client->irq=
, NULL,
> +                                               ti_sn_bridge_interrupt,
> +                                               IRQF_ONESHOT,
> +                                               dev_name(pdata->dev), pda=
ta);
> +
> +               if (ret) {
> +                       return dev_err_probe(dev, ret,
> +                                            "failed to request interrupt=
\n");
> +               }

Another tiny nitpick if you happen to want to fix up when you're
spinning. Officially the above "if" statement probably shouldn't have
braces. I think checkpatch won't yell since it's kinda two lines, but
it's really just one statement... You could even make it one line
since the 80-column rule has been relaxed a bit in the last few
years...


Sorry, I should have noticed the "pr_" stuff on the last review. Sorry
for making you spin again. Hopefully the last one? I think the patch
looks a lot nicer now FWIW! :-)

-Doug

