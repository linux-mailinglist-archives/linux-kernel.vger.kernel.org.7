Return-Path: <linux-kernel+bounces-732325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB9B06519
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409EB3A7FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E961285079;
	Tue, 15 Jul 2025 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WsobGYc/"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31672C2EF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600422; cv=none; b=Ri1BSLie5/fiA+5g8z174hIQKv5kVsiGrHdkEKMIUSJCKyKkrz9zTD0wlIUt5srRzZzy16maV6ESyZWZpXPzHhuektaceLeBN60UM4KEsuM5WzkOIaTbbQVbtX4kQECwa+xWYNMFWL0f+j+4WF8V2n5yWIa9Qgj8z1IBh55kezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600422; c=relaxed/simple;
	bh=isF8Gtau3GCw3cMblNO5v7kplTfbtpgalIiR8BIoNZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3OhhWJKGuDvODwVjrs8kbkW9u6hRYCp+rCfICQ/MM+wkEtC3wEkyv22iH1/Z16ixvWH5ume1gpS/WfvpIwQJol+v7K3I/88tEc0re5aDLrEK5yip6wF/7bZO8kyDRcuYDpFbeWPtWykEb3OYJ1HvhdT//XltRVX/fkSyyiOJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WsobGYc/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747c2cc3419so4677312b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752600415; x=1753205215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6MhRN6ppxrCnCAXp4O8kzdMF4x4FAEbIn2zSZ0Cd/A=;
        b=WsobGYc/MFTKtq8p8D83P0tH4hQ1XxJ+jeJgqa5A+j98CkHlMzwEwfD5v5dMs/XNhs
         D/cuSZcLgcj8r9sOv/LaYWN+p0Yl7C0HaBh4o7KzhsHzuKDWpdPioHl78VBusK+kzQ9a
         CcJKA3egHshkyheADfeq4PVyaZzCe3OXZ351E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600415; x=1753205215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6MhRN6ppxrCnCAXp4O8kzdMF4x4FAEbIn2zSZ0Cd/A=;
        b=lX2ZQpzG71tPU5ndPLUFN7/hNCHOFDRuyFYq33kJw/bwKlXLr4JGbL/NqjcYgjL0Sc
         XjnOlYYeOKAe7ROz2Gi0sB4oEHA0IWR+ZmX1t/BFWBUpsaUpq6Iu7qN5l7fJbcAhBwU5
         m5PX/NJ19FGJ9C9T3N6nkkBaQ0z/Uvad/RSliW+hQk5BVPJILLj4WK4sjPs7v4yo6Pk5
         bBIlaqyswrZ7LHfboiSH11ErHKAPdmExndlJ/VJJB0PhMyctKxmXX/UnMoDrHa1Ct0pf
         /szA+S0p/I6ruVIbySeUvAakuXlYOXtqgqe1CI7yLJGoPJqR5obkBheJIjnZP7UXhrxz
         rvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNKhUhQxKR0ZYRFGMtaoO/2yFePYQrIPOLYM5JhwmT74vZZFMPeZdz+vrkVGXxskg8ZmBQePQJgO3EvzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7/6RuWoobw4w6Nog+PC11GmM/CDwuQa8FikNrC649LXKHTKo
	sTZAfE8XP+gMHm/eTJC/42vaDeBfIUxGhMl+73Kol28dQqisdLtig5Ehl1YJkJZcLXgoTTwyKGi
	Q338=
X-Gm-Gg: ASbGncs123HMFZ+4ZF8CBDPJ+efJf0rmzhLeE6Ton5ZHmN6an+QbubklOsTtEpZmo4S
	UmLADwbQjY3ab01R24eiw0w5T+Dj/RynoXlMdzT/w8jdcTmlIB/JeQOMLr2AOKkSFmBHgRxBYF8
	BoN1aq6IpieSo2eIO+DSsCiHNw6/QVaz2OOua/ltZEE9Jr+PMqJPmbg1qG8Bc4ISKfMYLkQLcYK
	7x6ZycWBgONZwN+3br7LvDxN3F5aLECUI3cpzQ30abdj4lX8NoiNvDxAUZq5WP26NLqWbyY0858
	PsctExm6OpBQ6lWN0X1pEQwFGAKgftZvKI2Pc4X/cn1Kd6x/9Hc46vRDAR3vaypxFriu2bjykJm
	tr9vVq+0q7nfl7/E9/2v4BDlrdCOKvnhZ5FwkxAK6OXAl7wxuvTiijrCj5WVtvxf3XA==
X-Google-Smtp-Source: AGHT+IHefih7wtIKc6Qe9LtPKVs9vUdwofHe/f/sx01ldMEXsUikpXTkkLFhoVgRkVl9WXuJfo8mLw==
X-Received: by 2002:a05:6a21:3294:b0:237:90ae:82e2 with SMTP id adf61e73a8af0-237d701e86dmr345458637.24.1752600415348;
        Tue, 15 Jul 2025 10:26:55 -0700 (PDT)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com. [209.85.215.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52d38asm12284573a12.9.2025.07.15.10.26.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 10:26:53 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34ab678931so4253700a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:26:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUjLty4Sxgb5rg8q57kCtgo83y9y76+EaYLGtLLTYV1HXRTrqjLetzuCcsOY2Jjqm+0zFH5o5ojxfHBIY=@vger.kernel.org
X-Received: by 2002:a17:90b:5587:b0:313:28e7:af14 with SMTP id
 98e67ed59e1d1-31c9e75a6demr6694a91.19.1752600412930; Tue, 15 Jul 2025
 10:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714173554.14223-1-daleyo@gmail.com> <20250714173554.14223-3-daleyo@gmail.com>
 <175255192501.20738.16784196888105498389.robh@kernel.org>
In-Reply-To: <175255192501.20738.16784196888105498389.robh@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 15 Jul 2025 10:26:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XvHu_NnahFOcfLV4XQm_mQkO5cG3YP+acRgC9AE2m6Jw@mail.gmail.com>
X-Gm-Features: Ac12FXym5rkm10vzDYnC_hB8fozQpKkEtx52Jg_soFGip83valaWRitivphZL1M
Message-ID: <CAD=FV=XvHu_NnahFOcfLV4XQm_mQkO5cG3YP+acRgC9AE2m6Jw@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: display: panel: samsung,atna30dw01:
 document ATNA30DW01
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Dale Whinham <daleyo@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, 
	dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, devicetree@vger.kernel.org, 
	David Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 14, 2025 at 8:58=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Mon, 14 Jul 2025 18:35:38 +0100, Dale Whinham wrote:
> > The Samsung ATNA30DW01 panel is a 13" AMOLED eDP panel. It is similar t=
o
> > the ATNA33XC20 except that it is smaller and has a higher resolution.
> >
> > Tested-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> > Signed-off-by: Dale Whinham <daleyo@gmail.com>
> > ---
> >  .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
> >  1 file changed, 2 insertions(+)
> >
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Pushed to drm-misc-next:

[2/9] dt-bindings: display: panel: samsung,atna30dw01: document ATNA30DW01
      commit: 0bcc0f5e98bebd05e44261df3c33d274084eab60

Given how many of these we're up to now, I'm starting to wonder if we
should come up with a generic compatible like we did with "edp-panel"
and then we can stop having to merge CLs like this. All of these
Samsung OLED eDP panels have the same power up sequence and once we do
that then we can read them via EDID or via DP AUX bus to identify
which specific panel we have and if they need additional tweaking,
just like we do with "edp-panel". Do DT folks have any opinion about
that? Coming up with a name would be a pain since I wouldn't want to
assert that all future Samsung OLED eDP panels will have the same
powerup sequence. Maybe "samsung,amoled-edp-panel-v1" even though that
sounds terrible and there's no known need for a "-v2"?

-Doug

