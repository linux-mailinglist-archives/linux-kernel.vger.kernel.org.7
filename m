Return-Path: <linux-kernel+bounces-730616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB85B046FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136C14A7CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6359326A0B0;
	Mon, 14 Jul 2025 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AJOVWf6h"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A217B50A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515958; cv=none; b=qnm8kfV1Tch0x5QSnPu+zwBdbyPOuYRdKdpaJWS7gzvkfLv7KaxinRJC1zzoirwkV04DXOZohlz5tscTSwcZZ0ZY32LpBHhx/V3N+/frxZSV3q9nmNeo97KBPQ/cK+dU6Nwyng7hDe492n0iqacTcZ26RhMcvgsIOS2Cymqp1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515958; c=relaxed/simple;
	bh=pWsqG8O4gteQp++J/AH4LAtg1DHLTeRe8fGwJhBLVDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpOrSS8T/nQiakf3V1DH3Uo2Fohhcbn5d7dsetTEx6A51a/Q8CmC1t2X48th3aeQeMMkoa0WysOytUU1LK4aU7JYG1+jjibWGVaQS0lt6/SVauOj2sxBQcoLK4PUW6uoTIB3zL/Xqw7ktlf3bOnOzL9kiM2rGMDXzX0T64+JCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AJOVWf6h; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74b52bf417cso2989061b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752515954; x=1753120754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OG3AY/r+5jGyweejzWZqU76oacNUXzplqvD2s/v/W0c=;
        b=AJOVWf6hBiHxt9Cyyy/sJq6iUfVRdrF8AUV6HL8TUc1y9Bgltju1U1pjN8ouisE/L5
         4KDo3HUg609rOdSBa8Pjkqwpvh0oMlmNrtrVuBPMa3gxxDNBTR0TJJp9wNDnAVfkGZgH
         mcYnmGEN8FVG6vgH3dHoitEeqp6ml5vk9cI2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752515954; x=1753120754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OG3AY/r+5jGyweejzWZqU76oacNUXzplqvD2s/v/W0c=;
        b=RtoD8enSXrXaLCq29IM0zqO0MsyEJiXcUUW2qh2CMruBAmDa03i67hwdQH8oY2Z/tX
         LDfK037o0+ZJErOlSdCD6jSYFTt4SdYpk64jFsuPnBMffesFs1NZM3pZItb/AQHsgn9/
         mBDtgECXrD3xjkrWIerrUtHy5ffBxRRuJGAy8q3D87zqeHUSmGgRxx+99T2FHfjyDYth
         vXrS9ak/6gjiiVurXNe0D0toQGI9i7DtpO0Bec9lmc8l+1/Ei9EZlY3Vt+9sUopXBOHC
         fXU9OIT5VKk8RSpknU8oaea4pGYIvIAvAS/KYe6aJ8Cg//04fY44BAbIrHCgm6MS1Khh
         u6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVBoK8/LI6eM6SKhw0Va5HF8wS+FS6vlltskugsxeJBRJhhhW08YG/EBnI6veFAZfnZxt2fQFHaGEu1zZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgV3dlmjz9isX7zT3uy/RnaEpn48KogKkKyHi51wtlUkD912/+
	v8mi7dIQi5VDQGkmw25fSHgebe0NEGL+dnV88K9HVL6tuxm8q0EKd33sD8fulw9HAjoevPMffAk
	Ia/s=
X-Gm-Gg: ASbGncvIG5jzkMqoVmVidtk1+oJjzEPLWULK0+eyYEGIWUhZEd5cuA8lZUk4aEkAqRE
	wXagpqx/qr8xhhtMZLmJzUUCbCjG+ry5tNGdnrujNM7vhXi28AECKmcpMWxmZg17ZYEEP7srTfB
	btyGVH8xG3AYkgd1qEL1Y6Vb9A5tCqB6tT6gPg8OyRS0IN28RHXrcxbZ/UhP3P4CDRgdH1axE2X
	W+NXVHr4mz6NQlQ/4zK66Kw2Ee8WgNcVcZ0eX++UH4gXcyCD9ld23Mbp0vZnkS6dXZM5hjje+If
	MGgWRdx5Ze+Nh5lr3PAnYPNcKE0KYKKvcKigLn2b5IS3C3zHWCe9mN15Q9QaYF0l14wDI2YCk50
	VR2enKx00IsABD53FaKxYxVFJF05t9syS1ZsiWgSfaJdgtmXsrHFlYr6YGj+k4tei9gKuYGfu
X-Google-Smtp-Source: AGHT+IGGqd9vZNTUGs8sQvz7ModLirIbB3mmyIhuBV3OWFJmAhrn1FdmNyJWO6sztfOL8bQApWRy0Q==
X-Received: by 2002:a05:6a00:3e09:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-74ee3045152mr18251659b3a.16.1752515954236;
        Mon, 14 Jul 2025 10:59:14 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e05a2bsm10888029b3a.39.2025.07.14.10.59.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 10:59:11 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31c38e75dafso3887102a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:59:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQtXDdkiD5BshhbaWpnvE/88YoqTGbaJGHhU/N8iKHbRBoWIPqqr7BuPf3EvgOvwFeWmf3mTzuq/TG/5Y=@vger.kernel.org
X-Received: by 2002:a17:90b:6cb:b0:311:c5d9:2c79 with SMTP id
 98e67ed59e1d1-31c4ccdd5c0mr20464043a91.21.1752515950671; Mon, 14 Jul 2025
 10:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706205723.9790-2-val@packett.cool> <20250706205723.9790-7-val@packett.cool>
In-Reply-To: <20250706205723.9790-7-val@packett.cool>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Jul 2025 10:58:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7HckYJn6Lrh8deipcX=_T3s_B=oXeVSQuxt1a01dwEg@mail.gmail.com>
X-Gm-Features: Ac12FXw7OXhFtZwKbLQwLc4HMDijZPxZ1TH2maNwjg4oUlQ_nk5JprebZ5XShwY
Message-ID: <CAD=FV=V7HckYJn6Lrh8deipcX=_T3s_B=oXeVSQuxt1a01dwEg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] drm/panel-edp: Add BOE NE14QDM panel for Dell
 Latitude 7455
To: Val Packett <val@packett.cool>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 6, 2025 at 1:59=E2=80=AFPM Val Packett <val@packett.cool> wrote=
:
>
> Cannot confirm which variant exactly it is, as the EDID alphanumeric data
> contains '0RGNR' <0x80> 'NE14QDM' and ends there; but it's 60 Hz and with
> touch.
>
> I do not have access to datasheets for these panels, so the timing is
> a guess that was tested to work fine on this laptop.
>
> Raw EDID dump:
>
> 00 ff ff ff ff ff ff 00 09 e5 1e 0b 00 00 00 00
> 10 20 01 04 a5 1e 13 78 07 fd 85 a7 53 4c 9b 25
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 a7 6d 00 a0 a0 40 78 60 30 20
> 36 00 2e bc 10 00 00 1a b9 57 00 a0 a0 40 78 60
> 30 20 36 00 2e bc 10 00 00 1a 00 00 00 fe 00 30
> 52 47 4e 52 80 4e 45 31 34 51 44 4d 00 00 00 00
> 00 02 41 31 a8 00 01 00 00 1a 41 0a 20 20 00 8f
>
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[5/5] drm/panel-edp: Add BOE NE14QDM panel for Dell Latitude 7455
      commit: 1a304a2f8f7dbe25f555721f502227f9197145ed

