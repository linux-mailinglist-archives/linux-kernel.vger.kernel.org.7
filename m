Return-Path: <linux-kernel+bounces-752395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34518B1750F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB2B1C256BC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7749E21FF4E;
	Thu, 31 Jul 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bexc/KZw"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF1BA33
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979915; cv=none; b=GoI7n1Byp8z6EHmZhVx3fAhJLMH9PnbH37TKvMhClYhkJQsT0zj/t8ugNG6qvEKAcZbR9hjZ/gF5u04wVcxUC3YMZaVKUzLGUF5d9YkSYkWLOspkVK3X8jEJYnVrvtD63HY6MOP1RGBECzdAJ61SFo/68LwXJciK9zj2d43V1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979915; c=relaxed/simple;
	bh=CKgF0jnSG2wdzjoAm/Qe0GY3kcVd0498MqwU1W2jtDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaOS11xKyE6XqoVCiMwxNpOQSAgQP7MsiO3AvR75gtiZ+LkFaZwFOyv4QmgDHv7LB/IIutnjf/SuCyRgDUXOcjLlyc9qbxRK243kz0cDCF8WSI2Sy3blbwGeVFPhTQXYsCl7hPTrPuNz9yPl4jGfkB9zd7NcBqGFMgQR7keYq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bexc/KZw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-768bd0c7b10so1368106b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753979914; x=1754584714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKgF0jnSG2wdzjoAm/Qe0GY3kcVd0498MqwU1W2jtDI=;
        b=bexc/KZwOxye1AWa8AtLA4wf1w6eM/LOZ/AYH6PVq3pIZZrc7ebHcKSppaexPCns5Y
         C892Zru/7hOCiP2G1RicntTksJ53U7MVhk8fgXplOXByI9upkvWI4RiSy3p9TxDYXf87
         PNz8hjPmqnv5pKqI2ei3mbovVctxx6om+tAbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753979914; x=1754584714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKgF0jnSG2wdzjoAm/Qe0GY3kcVd0498MqwU1W2jtDI=;
        b=T9p38WakGg//086n7hHZWD3tyB5/USRXWKlmJBTVuSFyz/d+JOHKeqOx/emPK2lkIv
         W0BlGJyaWB6mb8U7zUVb6UQaFpEZAkiuQq2pNLJpgp4ShpTykCanZ782Ou64NFzJshpv
         Aau0yqYfK5g71I38Nudctl+hyEFD5wRFqBD+Y6eCYCiCa0FL7S8ftWtB5qdUKDS5voSQ
         WpMN/1SWVux+dq8Rm2hDS6uLVdw8WWrTJKM9677oQ8IGj/mCJtc5fg6uiwoDRmU6LrGH
         skFcwsE6E7+fYpbmqKncJh3qtxh4je+6BsCoa/v85vnm460++UuE2qVlre1dt8xiNNZ5
         7CkA==
X-Forwarded-Encrypted: i=1; AJvYcCXyWDLPBytxlwHevWllm63hMH47mwH6NRQTZ8AiZDFo9m0MpLTTPRFXGNc2D+cDcwOKrZwvOX+w6JX28Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zxV7Hs5hYt5Roo4d94whPyVO52EJsJRTUZlo7WxAaLaMzV6W
	qk5U6TdZRqubJdA6ji1yXZbD2dfVDv7cUcLF685s1NZ1tDuK9fqFNgyuoeqceyM8TQ5e7iSHgy9
	8fg8=
X-Gm-Gg: ASbGncstfK77M6W3gj+bxLY2drWpQ7xd0LgI3u948lFPmHOXxrpbQTx2oAy1960Ly5O
	D35BgFYrUqUe76F21ZgFEDxaKelJtvJYsZsfuRyl76tyctQs0ZDBz/dlr2dFrY5mx128Kh8zHMx
	Gg0qgEkuqPM5opOB3Svnr33YvDVuOXVchvXDfjyEXApoL+4URu8YOKGPg31OW2WOn39uyOAYajL
	xrxw1qULobcjxhqJlHjXh9UDvO3tikOORZBMOgEchOVhbJu8Bj2GoaiEyNfHgYdA4Jcm5TIV4Nu
	shmPjK/wPRl9/W6nc/zKF/7YrS7GG79II7n2CA9Rim7GyjZSbu/iNy6J2bIP74CRre8QBNDpwAV
	jvMNmiWZ4RILrDbt9W9Vbp4S5R25mgbb60h3/nS7WiAi0FcYK3oY/ONCEdAQNtA==
X-Google-Smtp-Source: AGHT+IEEwSZaEyuSNmDc2oWYgAJGup9zj+cDoEe/sD2PmpSnNlumNSsGuNm6ALoDo8G+j0gGPoHZHg==
X-Received: by 2002:a05:6a20:4304:b0:23d:d85c:bc0e with SMTP id adf61e73a8af0-23dd85cc046mr4131948637.14.1753979913723;
        Thu, 31 Jul 2025 09:38:33 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd88dbsm2053482b3a.103.2025.07.31.09.38.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 09:38:33 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31329098ae8so963463a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:38:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUGi2hP0HmYvphLUXg+RaohnQb9a7WjFx0hB4SDcUnoZOg9yRQxDSEoWUjERbLcB3QZD395jXI+GhplOo=@vger.kernel.org
X-Received: by 2002:a17:90b:3ec7:b0:31e:a8c4:c188 with SMTP id
 98e67ed59e1d1-320da5e8dc3mr3455804a91.14.1753979912440; Thu, 31 Jul 2025
 09:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731101344.2761757-1-treapking@google.com> <1519a7c3872a59b7b5f12e99529237035499bc26@intel.com>
In-Reply-To: <1519a7c3872a59b7b5f12e99529237035499bc26@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 31 Jul 2025 09:38:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VBhamkffZhVuMEoiwfAoeHRzSORo+=eqMLYVsSBMO-bQ@mail.gmail.com>
X-Gm-Features: Ac12FXxw9dAen_QOos16fn3qCdR3ov_wvt_j4mVYuHYXkV0ba_8K0aSL6du24TY
Message-ID: <CAD=FV=VBhamkffZhVuMEoiwfAoeHRzSORo+=eqMLYVsSBMO-bQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel: Allow powering on panel follower after
 panel is enabled
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Pin-Yen Lin <treapking@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Chen-Yu Tsai <wenst@chromium.org>, Pin-Yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 31, 2025 at 3:31=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Thu, 31 Jul 2025, Pin-Yen Lin <treapking@chromium.org> wrote:
> > Some touch controllers have to be powered on after the panel's backligh=
t
> > is enabled. To support these controllers, introduce after_panel_enabled
> > flag to the panel follower and power on the device after the panel and
> > its backlight are enabled.
>
> I think it's *very* confusing and error prone to call follower hooks at
> different places depending on a flag. The hook names and documentation
> say *when* they get called, and that should not change.
>
> I think the right approach would be to add .panel_enabled and
> .panel_disabling hooks to struct drm_panel_follower_funcs, and have them
> called after panel (and backlight) have been enabled and before panel
> (and backlight) are disabled, respectively.
>
> In i2c-hid-core.c, you'd then have two copies of struct
> drm_panel_follower_funcs, and use one or the other depending on the
> quirk. You can even reuse the functions.
>
> I think overall it'll be be more consistent, more flexible, and probably
> fewer lines of code too.

Yes, exactly what Jani said. We've wanted to do this before, but I
just never got around to it. There's even a (public) bug for it in the
Google bug tracker and I've just assigned it to you. :-P

https://issuetracker.google.com/305780363

-Doug

