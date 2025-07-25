Return-Path: <linux-kernel+bounces-746389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FA6B12615
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCADA54807B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105CA25DB07;
	Fri, 25 Jul 2025 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a+Wo6/o4"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A91F4CB6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753478208; cv=none; b=ahqXtVEIFkNqgQuSXxl0jrSwxWqXvgYNAr0F1Gw81lY+T9ecyfceiaMcElZARdKSLKe8Xg4SYgLwH5fC/VekEB1ZB26AAXKM33Imx3X+y3Doi6gzeu6tyhwg3kygqUzEQEEmTU8Dgi0vzdP1f+NVmnDuDepP7Pd58WFDSGIJlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753478208; c=relaxed/simple;
	bh=1fJ2MfilOVqJQrqzhISXTxGQxYhflr7VZ6mmtFSxeeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9mk5vOqg3NEdvdxU8gLCIm9CbKQZCrB/xMlXoFIADd6f/UuzXvE0TFkr6XvCYKGAWvlNgFAkNbVivinEGqQ7D98IGMJtEltqLLukJT8rMHjg44fk6KIDAhtaVo3HJT9l0+nJpmwwz2osxBF+lkt0S60JMF6Ww9oMrTmMgS3n0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a+Wo6/o4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167b30so24441515ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753478201; x=1754083001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7cqUBtmisnuPeRZVUL+pQK8RmL59JAS5kkk6fLd2w4=;
        b=a+Wo6/o446cr7ywXvKFIbGaTYlIiiEB4Ozni4o4dmqheaAaRNoOLXFWe4eAYbLwDDY
         Ecfju6RZ+OpD7ZZKWDDfnsz+8Lslx4w/u9eV1cTA3N8BLloArsIcU7ssSiHuLDMeqe7e
         oFOUP7NVJr9bDIlh1xp84w30hQPaMJwSa+Z5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753478201; x=1754083001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7cqUBtmisnuPeRZVUL+pQK8RmL59JAS5kkk6fLd2w4=;
        b=Top10HytxxZA1Gm/kY8FHo83spaOFJf1fn1jfuY/ZsZ4lL1Q1cP+uOTxufA1g3sbGT
         7EXYg8aNbpdSgmu9pWpsU/5geWp5aaYMEUjDueX/k9P8gb6T2VHxsqQh+j6HYeH745GB
         kbZ0LZkC28W6BitHC8v8SwyVSG1FoP0TgLbTwTcnVxsocrtdU2VukoZQKBS/75Xx31sU
         IPP5XHLwxPvsGNUO4pLdCGEHBnq1/YiKSMn/HReyCAa7loaoTndg9LZbdRFlfZc6bTnO
         YMhLl1ixN2usnZfh0+bRNCA+x/uRkG5Uhut2Xnu5imuC1FpHumvfDFgYCviD8QiHgCWd
         GEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVs3UVG4ZEmxDDcYGqbNLwjqAl5JvXCJTO8lmVcrpBp+p5tMh8r7H8M+wUbY6PFcLpaMFVEWQlNtLvC5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXkJBDLL8dtV7aP+hkpX2odopEx3DOT6cE25f/l6f0XeBQ3h9
	qMTud3F2CFXMlxt+ZWetpw5nq9jGr9yNAxzSRZHrMfBgZLfxie91gg4IHhvauCklJmxp8wkALKT
	wmnU=
X-Gm-Gg: ASbGncu1442rw/NpN3wn4wEw4OMVHZOjOUzeA2Azwdg9pH2qrkaR3KUNTes5ALdliHN
	ovtDNjw5iZ3+rMl5LNYC7Pe7MwezD1IlfDv2iUdz9tkbuDndn5oNRZwAMXEsbhBeTt+3XDmtOVu
	075uDcz3AFVqeAVLVqS3sXwPUgRgZ/lkzEdelJuT+dqO3kZffVJr/DhRTtcdilM6KkhMC45vEdv
	KXReQ1DTRDftRJedq5VaWjO/15tRklnLwBdoM1X6pJKCzcLiiGUu88T/Sdd5antksvR4825jb31
	Kgie9lBtilmGXPzvrrHw4nlt9sq45ErfiLLinJyCretEARP7Jiuz9R9Nbgdmqxrp/EI29YVYnzk
	bMe7zmvA2iFsbKeba0aOT0jfuuAGiQVh/MnZdFrjoT8Vxiyn/ti2u2NF/HJBjTg==
X-Google-Smtp-Source: AGHT+IGOoimKTRtpUB6v9YbOujZyQiTuh/5pneqIUWMrU2+CESOYF3w01xFYI/Vi2XO7l/MNJ5OG8A==
X-Received: by 2002:a17:902:d487:b0:23f:af68:ae38 with SMTP id d9443c01a7336-23fb30b3006mr45821845ad.31.1753478201360;
        Fri, 25 Jul 2025 14:16:41 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30fe57sm4242065ad.8.2025.07.25.14.16.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 14:16:39 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so2174796a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:16:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKuOXjAMs8VNwyIlhwdoJlUXsMa9Jk8oeYKpZCU+0tMhi/Jr/SEbg9vdfNVzlHA4/cK2p3+clqVM61P8o=@vger.kernel.org
X-Received: by 2002:a17:90b:53cc:b0:315:c77b:37d6 with SMTP id
 98e67ed59e1d1-31e779fcfb2mr4543990a91.23.1753478198547; Fri, 25 Jul 2025
 14:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724202338.648499-1-me@brighamcampbell.com> <20250724202338.648499-2-me@brighamcampbell.com>
In-Reply-To: <20250724202338.648499-2-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Jul 2025 14:16:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZqzWd+Ke2sU-z86jnhKhUo8v0ChyKYnGpmx+s7n0stQ@mail.gmail.com>
X-Gm-Features: Ac12FXwuy3K1ITZUFyK7_VvNz0LpuHmryqPozv35YYsEjO_5SuA5IxC-IXYo5jQ
Message-ID: <CAD=FV=UZqzWd+Ke2sU-z86jnhKhUo8v0ChyKYnGpmx+s7n0stQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: Create mipi_dsi_dcs_read_multi()
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 24, 2025 at 1:23=E2=80=AFPM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> +void mipi_dsi_dcs_read_multi(struct mipi_dsi_multi_context *ctx, u8 cmd,
> +                            void *data, size_t len)
> +{
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       struct device *dev =3D &dsi->dev;
> +       struct mipi_dsi_msg msg =3D {
> +               .channel =3D dsi->channel,
> +               .type =3D MIPI_DSI_DCS_READ,
> +               .tx_buf =3D &cmd,
> +               .tx_len =3D 1,
> +               .rx_buf =3D data,
> +               .rx_len =3D len
> +       };
> +       ssize_t ret;
> +
> +       if (ctx->accum_err)
> +               return;
> +
> +       ret =3D mipi_dsi_device_transfer(dsi, &msg);
> +       if (ret < 0) {
> +               ctx->accum_err =3D ret;
> +               dev_err(dev, "transferring dcs message %xh failed: %d\n",=
 cmd,

Format code "%xh" is probably not exactly what you want. If the error
code is 0x10 it will print 10h, which is not very standard. You
probably copied it from the write routine which uses "%*ph". There the
"h" means something. See Documentation/core-api/printk-formats.rst.
Probably you want "%#x".

I'd probably also say "dcs read with cmd" rather than "transferring
dcs message".

