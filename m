Return-Path: <linux-kernel+bounces-827094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E5B904B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AA13A5DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3833228CF5F;
	Mon, 22 Sep 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JIxMuHoM"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692D24167A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538952; cv=none; b=dDqUAfYLuMcB55FxRzQFNllWy9Sr6On/jhmT1hi3YOEHQ4D/wgebZzSR6vesGD+/pZuESCSIdGvDc4qUWVOyI1KV/MgJmdj7YxCjmt8zOjbdfVpgorLO+q8VTVoga7SeCZfOaD4tqIhZkokkMMwTUGgg0R7s9ejHCoThqsfwh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538952; c=relaxed/simple;
	bh=+li5jZLjno+mrEq1vnQPMSZK9xNs3cFzE65Gz2fSCdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c26A+/3zrqdeTmI88TxRBn4Su3LJs6qKSdcB59fgRyLChpnkJ0K4iBRnzro/WoePhcbY4iCmk0AXSairlkNVzXcmE62EJWevnKc17ekv7Gk+Hyxp2sZDOdrZlG2gvMw+WyQrBEARz+OoNJXpO1Hhniuz3PQ3L2lQ5e8/2lj7K+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JIxMuHoM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24457f581aeso41823845ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758538950; x=1759143750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+li5jZLjno+mrEq1vnQPMSZK9xNs3cFzE65Gz2fSCdQ=;
        b=JIxMuHoMddsnkA1HGxLhdLba+mklvPNgYLRC+BBFSA8TyBjRpqQ0WONpGo6lwPVDWW
         hrwz/ALcbiuObkFbu65rtkB1ivDfSRA7TOvBdhaVHnPHQt4AMqus0ihUGncP7epLjnYl
         4PVvvgSfRFYcpiF8ApwmcTLPiLHcOeYFlObL97B9zn5xYUagOgBPuONQSgn3NrGO8a0m
         wDZACKNByxr7g61kT2ILtcFKBrH/mqO5qCAKEZXaDfCH2RQX1mO60GuQItahtyr8U8wy
         OMbrltcLjguCUXX1kOfamT4wA0neEr66R6PqYE5+e0ZpnrcdAe+uXS7fMZPHHGzwMjrP
         0TYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758538950; x=1759143750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+li5jZLjno+mrEq1vnQPMSZK9xNs3cFzE65Gz2fSCdQ=;
        b=EeFnReeT3UZnv2Jcnl3Jen8JU/F203iaCqlm9yg3FAiaHyZ40g1//twLO9HWTABWeU
         6wweTjSAXbE6au9D7dsBQh5tYnE+TDx5QkkQq5DftZ+oeyVrBqqjgOX88wSUJRSmpn8x
         HxDrlplAMSJ6fE2L3R0h/+89bLs41CC+fgABVYIn4G0D2o2E+EAm9lZKm96uRZ4skUpx
         qpfDBMueiASZ5U20+OzP4tlDvDdln/OTBJ2je2H53VDKiyL0mNW0ASOelUDqJwiUVVM7
         IFUVDVtqttfweSHKxnjf/IFaSIHUAAizFmfZSHpIo4eyWTPJcxOyImL+JaUCWl2dJKBd
         h3sg==
X-Forwarded-Encrypted: i=1; AJvYcCV09cs7mwQJL0QPUJjg/zOQDMh5AYuSei00LrC0+Nta0HwvFGnwLZJWJw9kJTDGSXLmacZqEG8kZ+urw34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkRX9tbRVa6Mi/STmK1Q5XoxDhKsORcL0T2Q2c4mAp8y0Zwhz
	EscD78Z0Rq1ioX94KZhdW1yj3gZFcytjo8chRbLfY0SGP38OpRfgoUZqhbSjEV4M0zqCEKqyrj+
	E4g2kZ8lSyGE2KN4UAU+0ECQjaC2ekOU=
X-Gm-Gg: ASbGncvf/6CkS3VOZwHFbS7CPUmalT6mnSwpkSos5pXAshIfUnzK2d8XRH1jwjFDTnB
	3s1KL8SVRk/ayDLHmpV1zO7XLG4XDvb1R9Ioh/+H6VlGasQbrV96FkBiZPe+iPrawoM1I8SL55K
	cQtnsDpcxltKzT2rsDuE9GQBpIdDgIYsyoBLqSt6NZubCo+SdKUealAYmFRVimMiSMjNYbRTOOZ
	HNfCGRkhHSAqSeGcS4yQzce4sRMdq8bvp1UuyFp
X-Google-Smtp-Source: AGHT+IGmUtMYlpRUtriAGyHEqqhD7tsNW/oErA13JErbQr7Uwk/4xc/l1EjiIRO/SRnBAHwmetXhu5CvO/UV+bZ8Paw=
X-Received: by 2002:a17:903:1c3:b0:275:c2f:1b41 with SMTP id
 d9443c01a7336-2750c3e5feamr49668395ad.53.1758538950329; Mon, 22 Sep 2025
 04:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-meson-clk-cleanup-24-v1-0-e163c9a1fc21@baylibre.com>
 <b88a947c-7074-4fed-8283-c278b573a7ca@sirena.org.uk> <CAFBinCBe3LhN+3beovFVuWPpe3pDF5P1wSt7nPjm=ykRAx4zzQ@mail.gmail.com>
 <1jldm855cd.fsf@starbuckisacylon.baylibre.com> <aNEZcNbSfJlkP7Ra@finisterre.sirena.org.uk>
In-Reply-To: <aNEZcNbSfJlkP7Ra@finisterre.sirena.org.uk>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 22 Sep 2025 13:02:18 +0200
X-Gm-Features: AS18NWBF_8d672goWt-c8mlWPO6qTZjdU-iJtORQkODp_RuBXGukLUDReQvFfGA
Message-ID: <CAFBinCCn-rBNoCiTkgn9__NyujAbPOeEdhLskbWwg_onRh=44w@mail.gmail.com>
Subject: Re: [PATCH 00/26] clk: amlogic: clock controllers clean-up and factorisation
To: Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:40=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Sun, Sep 21, 2025 at 02:59:30PM +0200, Jerome Brunet wrote:
> > On Sun 21 Sep 2025 at 14:21, Martin Blumenstingl <martin.blumenstingl@g=
ooglemail.com> wrote:
>
> > > A few days ago Marek reported problems on an Odroid-N2 and provided a=
 fix: [0]
> > > It's not queued up for -next yet.
> > >
> > > Please give Marek's patch a try
>
> > Being on the A311D as well, it is likely to be the same issue.
> > I suspect you would not see the crash it without earlycon indeed.
>
> > The fix is in clk-next already so linux-next should get it soon.
> > Sorry for the inconvenience and thanks for the report.
>
> If it's supposed to turn up in -next it's probably easier for me to pick
> it up from there given the firmware issues with the board, though there
> may not be one until Thursday.
The mentioned patch just landed in linux-next

