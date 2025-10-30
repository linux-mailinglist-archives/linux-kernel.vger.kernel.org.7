Return-Path: <linux-kernel+bounces-878506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27789C20D86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F06188289D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EB72EFDA4;
	Thu, 30 Oct 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XSq5F16w"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63701B640
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836919; cv=none; b=fJ/E8tf9F68vDPMrKMhPXpqXep/4Q9IB/bWyTvQsCvTcG4QZAIa61phW/e0Ty8WNQ4nsRPABka0a+rfzAa1M/fzqMiXCEaU459EVGqNkui19gm1FGFmP+XeZsl4Cn+OZ+l/wTVCPOxwwtFK/6dVTY4lX00Ph1Hho5ih8tmuT/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836919; c=relaxed/simple;
	bh=dq0R2qMbL3KJfQwI50VWPIbCi8tcnRoeT8AcdwZ+NtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQvfLa+LhF8XA8DIuRtVQQUoA86P6/s4xczNhuBLMdMZthW238dycmB3N33qgXuE4GveQ1cJScpDmzVzec+Q3URcblJx6mv+mC66IbfpMf4BF2YbEYPWx2WSvMU1Bb397pEEOOFHFqp2ZjZT9y4KR67eGTEwUTe/PjxD77f9z6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XSq5F16w; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so278475466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761836913; x=1762441713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2SjpXgXJt0/pxrphlRH7OZcg37sLfbQRD3739eO0nw=;
        b=XSq5F16wAz17W3nEDQWsfFsk6kH3OBkkiMOCaYaqjVDH7kUZaSbBaMxK72ieSW49zF
         mQ4iP3euYVtbmUP4avi4cxjk36f5zcAljghZG1DoJT4b0nLQcW3pKI6nQho+UGf3V56K
         Hws8e7kTT5I3ntKLVPzAWlF6Q55/V/JEg4m9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761836913; x=1762441713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2SjpXgXJt0/pxrphlRH7OZcg37sLfbQRD3739eO0nw=;
        b=pCJQEt/sbfZxZqDv74lfkJm4bGsPIN5US47Q1RYmsdlpG7wEM8u/z1uUylD37K1T8Y
         5rb4cQZ4CniHZH2FD+nE2q+I0MSKGk7+l810cxoAtAms3np/NN6uE9y3FvODcwJ5d+M/
         pOs1uYjefkQSd5zQC4o8CdWZv3LC2Cs0yIkQn7ssqTOb5FV0cTvXJcla9Vi1N5et7kwV
         7jr6JrMbgXUfClREy/dxDBYL1wMn5h86IRyOP74txl/NRg/8MFdTV5GVAhsU15gNZLjT
         vY6E1mDRNqjIc5e4AF1cs7BIoo/NEYi6eogBFboHQnE8Q9IqBdzY9sGkQll7gWUOZxAT
         3X5w==
X-Gm-Message-State: AOJu0YxCNNXzYkdfD0/WZZ2jiZR02Q/ySy8gzeI2FqbFBkxOh+rkgv5L
	kATTr1hF6fP8e4oLhNnKrCZiHzSIYawYhP9jVpK2xAijJiAxQyfcNs1V3nqIvBXw3W/jPmWMLmu
	vHTslNyF5
X-Gm-Gg: ASbGncvRHTpzyj7SuxFF2ko1zhpvjex2U208mQnoQKy1iSK9/5a3cktL8R7F1aD7sKc
	J9sS73mszUUTI0d+5c3awqXLtQQx55LcyopIu+sMdNyilCZnfKqiA8oVoPHJ2neZpvhiokA786m
	jAPD+YjJmjq/n6JLiAJAfSfASZiFD1Gsg/2BQyOMlOVf/dEeuo+narQQcVtLlwh7zK8vw90lICT
	1NAXheToG0gw2uYXgutOc9Ap67UAAEZmNB6pq6Zb/svjHw8YqYsYRLPM9NGekeEtM3X/IZM2vih
	xrrgM0xre+2IZUNkL0OwLpCItdcM3cp+uEaQWsmM6L0gaACTt8zusHL7LhzDymFfbVyf5wWMtoq
	LndYjpGzD2n9pbwH29HDcmQDj/U06QpoBIrdR6+aHVybXrAR1jB8H50VgchdTYGB9eTJWf/PQ6c
	vvsdqoFSbB23WUMdWWFr4mLvrAF5gmCk4bcobyVno=
X-Google-Smtp-Source: AGHT+IE9j1PFTirRpJoqZ8FbpNPaM+M08n2yPzFJXYTUeHbdOfTDm1ZFBnp+drNJI3JntYz5dF9aPQ==
X-Received: by 2002:a17:907:72ca:b0:b3b:110c:d343 with SMTP id a640c23a62f3a-b703d2e4318mr624376366b.8.1761836913517;
        Thu, 30 Oct 2025 08:08:33 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853e5138sm1778789566b.44.2025.10.30.08.08.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:08:32 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so966282f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:08:32 -0700 (PDT)
X-Received: by 2002:a05:6000:2381:b0:429:7693:884f with SMTP id
 ffacd0b85a97d-429aef75da6mr8131557f8f.5.1761836911796; Thu, 30 Oct 2025
 08:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030094434.1390143-1-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20251030094434.1390143-1-ajye_huang@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Oct 2025 08:08:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V6xV0m4pj=7f2dxDP-0A1AaQuYJP5NAnXNz1_bzH7nSw@mail.gmail.com>
X-Gm-Features: AWmQ_bnEHxdnjsk13FRpIWSB6gHTYcjSmCDcSOhTK1zW9zhzw9_Rl-0piXEINNU
Message-ID: <CAD=FV=V6xV0m4pj=7f2dxDP-0A1AaQuYJP5NAnXNz1_bzH7nSw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/edid: add 6 bpc quirk to the Sharp LQ116M1JW10
To: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 30, 2025 at 2:44=E2=80=AFAM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
>
> The Sharp LQ116M1JW105 reports that it supports 8 bpc modes,
> but it will happen display noise in some videos.
> So, limit it to 6 bpc modes.
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index e2e85345aa9a..a73d37fe7ea1 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -250,6 +250,9 @@ static const struct edid_quirk {
>         EDID_QUIRK('S', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
>         EDID_QUIRK('A', 'U', 'O', 0x1111, BIT(EDID_QUIRK_NON_DESKTOP)),
>
> +       /* LQ116M1JW10 displays noise when 8 bpc, but display fine as 6 b=
pc */
> +       EDID_QUIRK('S', 'H', 'P', 0x154c, EDID_QUIRK_FORCE_6BPC),

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll plan to apply this patch next week unless there are any comments.
Given that it's just adding a quirk, I'm also happy to apply it
soonner (or for someone else to apply it) if people think that's OK.
:-)

NOTE: in general if someone is involved in the discussion of a
previous versoin, it's good to CC them on newer versions. I've added
Jani back to the CC list here.

-Doug

