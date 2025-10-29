Return-Path: <linux-kernel+bounces-875439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E80EC19034
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BF93567F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92F4315786;
	Wed, 29 Oct 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F8K8gPx4"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF58315777
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725719; cv=none; b=Zi5nc9P0WCORQ5iAMt4TFjGT6zIEV8ig2vfWHaXyGcR9cBeel4nvaUqottf7FMTphoJlpvXxAhrlrGg8qwX3N4SEwksOf97bk9dE5bDECXBLLqmVCf2nkuGLq2XpGRml9CAt8AdAkh5L4T0HzUfCYgy5mA2ALcbQKIgaEeodwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725719; c=relaxed/simple;
	bh=+1M862bXRRMW8Iy1QXEl85OmAgnvLzrs17Tviq69IF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ijeS3gdGORI/qz41KjQlN8zNG9yyaOpTkWzyZGP4JdzWQUpMpTR8FsbT69jX9Fn8KDMsIGZgIkdpLTlpWNJDnjC8N8ydopdc5VRzIFi7kEtpbGPQ3Vt0vXnJRzzHN0KkTdIcGo1ran5GcZD4Xtz28J49XmYTNbwP2ENWzNKjGcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=F8K8gPx4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475dae5d473so42161945e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761725715; x=1762330515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+1M862bXRRMW8Iy1QXEl85OmAgnvLzrs17Tviq69IF4=;
        b=F8K8gPx4VgT+t1oxmgCm3JopzICV9+S+J950C9NZ96GeiUWWMo6RB7UcmuSbkUtAVK
         25AlX2vg8KPEvQ4H1/VPZDynV7umF/nVyxQYZSTRc2F9ELj/LArDRo6RIjKVk4OokmQL
         xZjDs5pYevpYvnovs4yGsTjSQZOiB8Vsw5YMauMq7WRNzZTI8OwwqTr1a1YLGtoWWywh
         uFWvr/mLy3diYZw6tqqVAhQ9tDzj8fTyhOAuOttKGvlgTZyUmk4W+r3Et2D+p7gL3XAM
         iF3Q62iS33cNL48vc0HU1hSN8L3L31xn4CxZqPI1yuDs0sPMYaGPXP6Xw2Ss/uYmxcic
         4pTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725715; x=1762330515;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1M862bXRRMW8Iy1QXEl85OmAgnvLzrs17Tviq69IF4=;
        b=mimxkqa13kDTcQkt8yfVoe5rAedKp0aPCRvXxpPTgXRXUzJ8gLbfYfyRp8k9/2EjGN
         KFMYNxtqXCTSdK4/+XMfA1Ba/+rfl0A212eG7ImelGtWelG95yVgIfGXrmdjASWLpc8D
         r9FSaXTq7PUqUUv7E4fIgCzDbcaxaApZnJHjhN8rL0CF/s4qu/gYQCzYG6ZD8dGyk3xH
         lae/GUDMEcR49m7C7QrUHcuQVwLIKaHg9kFgwjknMvS7SwUoZyO1rzIeUnN5X//VaFT7
         7ECoDDbQvVjtZ/1dMzO5gEdQ+TZbPrMK5HzChkrNM/6QSTjR+10nl1AyLeImMtwjF51n
         j4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXOa8+EkmhzrWXWcDlzB+o46fGIXXhqnHrnNUpnMTYol2/Q6pY0oxSLQGZbVZShTIHV28bi33ZOmp14tiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOvnlg1qC6QyWyEu9o5dqg8tIGsYRefSq+LXSuWZeHVCwXxo1
	dyru0dGyG8Osd9HsJqKQMP3vs6I+joURMGygjS3Kggm0rZnrV99GaE2H
X-Gm-Gg: ASbGncseHrlbXQpQUplFLLQDmCHn0f5OZ/LYHAi45Y59XqckKvOh3/IWCrKV1mPrcPH
	IEcU+FCYax+QcV/KX+Iw+TVHDSMrqYvtBa25CqcyfCxjiR8Nc2/lBe+CrSciFsIZYLEha6ZQeZh
	rD9/E5+vmMbXZEX872+m7XjVwhKBI3sgldd3QiGGh5NfKRj8eqEgEcu3LJyZlYaSo37tMvzHq1Y
	iITIKxYRlkTs1w+moGnSQRelkaE8cYmc+k6DKLR3V0iR2tWMkDRJXW5oacA4ZDQn19FhOooLmsC
	8X8rp+nX48rllxjnMricd6p0y9xEBak74xd+k7LoJQ9b/MEf9W/XTqpanoYsL7dQL7/OdSVBYJv
	TPQmxqiYY9dnWEuDNQY98OxOjNchAH3v/nQayZ0nXsNyb3MwgTOoCIfTm5w2Y6PVwyvVWXAx9Vm
	YOjMG1YUvBzobZuJygNt0rks+TzPs936bUghBUxyIw7QzF+oC7CO5rBUJ+L20=
X-Google-Smtp-Source: AGHT+IGkUXJD+kvaS6mK1U/QzGKQ0pxRgGgSknEVWnG4pxzAlb+i1DfZBU6CdN5gmtOlBwb1q4PJJw==
X-Received: by 2002:a05:600c:3b15:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-4771e3a88ccmr15799595e9.22.1761725714804;
        Wed, 29 Oct 2025 01:15:14 -0700 (PDT)
Received: from [192.168.1.128] (ip-078-043-029-094.um18.pools.vodafone-ip.de. [78.43.29.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3937b3sm32995295e9.5.2025.10.29.01.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:15:14 -0700 (PDT)
Message-ID: <5465f445fe9e230f1f37cbb22a97ff2b7c9c3d2e.camel@googlemail.com>
Subject: Re: [PATCH] drm/panel: kingdisplay-kd097d04: Disable EoTp
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Sebastian Fleer <dev@dwurp.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang	
 <jesszhan0024@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Wed, 29 Oct 2025 09:15:09 +0100
In-Reply-To: <33e255dc-64f9-4e4f-82eb-6f5e9c1d63d4@dwurp.de>
References: <20251028214045.1944956-1-dev@dwurp.de>
	 <aeee5f47ef2842fde66bc66fc598ee4f007fc1c2.camel@googlemail.com>
	 <33e255dc-64f9-4e4f-82eb-6f5e9c1d63d4@dwurp.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> =C2=A0>> Fixes: d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable =
EoTp=20
> by default")

Nitpick: Your Mailclient messed up quoting.

> =C2=A0>
> =C2=A0> Just to clarify: This is not a fix for that commit, it is a fix f=
or the
> =C2=A0> panel driver itself.
> =C2=A0>
> =C2=A0> EoTp is the default in Linux, a panel driver cannot enable it, on=
ly
> =C2=A0> disable it.
> =C2=A0>
> =C2=A0> Commit d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable E=
oTp by
> =C2=A0> default") fixed a bug in the synopsys dw-mipi-dsi because EoTp wa=
s not
> =C2=A0> enabled there by default.
> =C2=A0>
> =C2=A0> Enabling EoTp in dw-mipi-dsi revealed an underlying issue in pane=
l-
> =C2=A0> kingdisplay-kd097d04.
> =C2=A0>
> =C2=A0> That same issue appears if one would connect this panel to a diff=
erent
> =C2=A0> mipi-dsi core (because there EoTp is also enabled by default).
> =C2=A0>
> thanks for your clarification. You're right, this change is merely a=20
> workaround for the kingdisplay panel.

It's not a workaround, it's the actual fix.

> However, I'm in favor of keeping the "Fixes:" line since using bisect,=
=20
> commit d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable EoTp by
> default") is found as the first commit that shows distorted output for=
=20
> that panel.

Documentation states:

 || A Fixes: tag indicates that the patch fixes a bug in a previous
 || commit

You are quoting the wrong commit in your Fixes: tag.

