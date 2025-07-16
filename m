Return-Path: <linux-kernel+bounces-733549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97754B07615
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15D53B5D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821472264DC;
	Wed, 16 Jul 2025 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMise5/c"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4BF341AA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670030; cv=none; b=Ril8Deu9V27b8Xlm24Wze4t6m/8ueb5EiiifuUCN6eVTh1BCVXIDOih9gM8tJrmMl8LY87qdLqeFf/el2s5oJRMLw8Ranhwrhlabj3tM/v9epkggcfK2pxx0AKlYsRssMha33xyw6T1CcQVab3iu4Lscb4zwbWsy9prjnWjuk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670030; c=relaxed/simple;
	bh=v+NeI4oPDFcDXRLGoGYINFchF4i+6dwoVmcAAxulswU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VA7La1yunAbMzevSot69N8pQmVUspCsUmuWxUoYB85C26S3CRgm8ZuxF7J1Vu6Ts0E4uWooz6t6msbSbUmbiYYgha2SFl2EsqXpXWBB/wkjrf1btyoSPHfChfaRhNIneI/2jzhd62yW1KcPXYnjkDqWibMXI291TXCKsX7eA7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JMise5/c; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8bb626b20cso1844226276.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752670028; x=1753274828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v+NeI4oPDFcDXRLGoGYINFchF4i+6dwoVmcAAxulswU=;
        b=JMise5/cmiz5XWn5PazZ9Nhl3BjliiOnUpMs2oNBYK/z3W4kUwHON4jvgMbcS4LJ3u
         YYtbmCqgYk/pMeXQDZDLM896DKVWB5pjX0nIPwBSxkOJylnTodEiXsT/NrM0z2Wiqm1t
         E0PY1479UyA2p28bSl1Rxfvwk6i5+4xLCLrIsV7GdqJbALrdmefKtD/vKvtH1VCTBt6G
         QY/vVDp0pMndaOhhY/sUqyCksvNmzaU58442N8t75KClpVe4ffGIAQ1NSCqf0xi5RhF0
         lUg0/wX4n3+bOQFyTeLFtNVj7eUyuMq386lKziLGQtdwfKgoCs8+bC56kDDviP+mCxOL
         9ymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752670028; x=1753274828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+NeI4oPDFcDXRLGoGYINFchF4i+6dwoVmcAAxulswU=;
        b=DlRvTgKBTaF662RZk1tyCHbEoPryeltFelCzKT/GL4OR/NOiyjeNWWZ2abcQ/RnOfQ
         ZARqg/Sf5XFbiGO31oiOX8Zo0wJ1k0JmlQ0dP4A53XmjeAfXB+PMCOgPvH6p3cRJICiB
         5flEq5ypK34k/U9ldbjeaZLaDdZZBJ5qJ0Qp1524Q5jPTt9Dbh6O4sW+8c8UVbPke29v
         bekpTPy2zcVzSn0PS4J83GLyV/O2jjSiGnnD9Nix6wk2gMolgeE76E4A5jWNDSpgHO79
         tgEsSvdDOl1C/KMRxN5mJRNPqyExOJTHHlLIG4QmuubXHzhdRUl5c0OubChNEtKckE33
         E04A==
X-Forwarded-Encrypted: i=1; AJvYcCUCBXBZmO0bD0s0NAckQXwT1ymQTqs+KK6nA3u4NdYds3zWEAday1yPL2U7HUGXd4OaLw+gBPB/S31UJO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3d4F8CjfYjg3s8AOcAQ0EiqcN5KXzLP4CPZykPr/BLhNJyLYM
	nPDcXiXhWu6nYp510b1+nnCzYLNCC1EJqyOdqU1tZP65berSZLpmcmuAH0ssRdJWTjRCebPSmHA
	P4Y7fxg+q+t/vPGQkjsHe3EBU7DA3vgZrYaBJGmGCUA==
X-Gm-Gg: ASbGncsOA4AS2Rg+BLdX/ChRuc4DzUMKjs2I/mUx9Dkjsr1n/27NWZ3dzPt64wkfjZO
	g3W3uG7lbh/vTIiiPU2xAdpmL9/8YymEyWfdr8hgMFay1hzM8p+yhdOzZZZEqc2Nv4/qzzrCTcv
	Ud2plYavgABxFg2Di00G31BLWd6ecTzd0RbF3KBwnbfsNO2qYoiS023Y44e6IFH78q0n7r4XjUO
	kVk2jIp
X-Google-Smtp-Source: AGHT+IFnmV7tqHnKAAZin05zl23pu/BOmTcDrsz6MJtyOoKAjZsusep8borKW7RWSkgBxZIsdcr3u8g53bJV87ZlM/s=
X-Received: by 2002:a05:690c:6504:b0:70f:6ec6:62b3 with SMTP id
 00721157ae682-7183515bbd1mr45195087b3.26.1752670028190; Wed, 16 Jul 2025
 05:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com> <DBCI05B4Y2ZX.VM9KNB61PGU2@kernel.org>
In-Reply-To: <DBCI05B4Y2ZX.VM9KNB61PGU2@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 Jul 2025 14:46:30 +0200
X-Gm-Features: Ac12FXzurDUmM43xe6kzQuLOxwsQlwsDpzV3_U4qJupNwsd3iX_y9_VZPsZolOc
Message-ID: <CAPDyKFqUHmMi6tBOJyA2YAOYLX-c_kDMskyRTC1Q+c9B4q_g8w@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Danilo Krummrich <dakr@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 10:50, Danilo Krummrich <dakr@kernel.org> wrote:
>
> Hi Ulf,
>
> On Wed Jul 9, 2025 at 1:30 PM CEST, Ulf Hansson wrote:
> > I decided it was time to give this a try, so I have queued this up for
> > v6.17 via the next branch at my pmdomain tree.
> >
> > If you encounter any issues, please let me know so I can help to fix them.
>
> Can you please address my concern in patch 17 ("driver core: Export
> get_dev_from_fwnode()")?
>
> Since this has been applied already, a subsequent patch would be perfectly fine.

Hi Danilo,

As Greg and Saravana were happy, I didn't want to hold back the whole
series only because of a minor comment on some missing documentation.

But, yes, let me look into it. It may take a while though, as vacation
is getting closer. If you want to send a patch yourself, please, feel
free to do it.

Note that, while at it, we should probably also add some documentation
of device_set_node() (next to get_dev_from_fwnode()) as it also lacks
it.

Kind regards
Uffe

