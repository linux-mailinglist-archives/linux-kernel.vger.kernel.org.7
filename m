Return-Path: <linux-kernel+bounces-762195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9134B2033D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798973A5175
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974842DCF63;
	Mon, 11 Aug 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wDTP8Tc/"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BF2798FA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904320; cv=none; b=UkLUahF4DQ/+b65jXrMoZAtnK9U5Y3QJ0S+Pj2sbFQoWZxUmz+ws8CTxdJnCJB3euP9zjdYWE4YPzjRZezaoQnIEVbyKUhcD9mwULDEVqouf8z9psoS3Ff9ifrN0aowmcUjcZtuHOUOOG4a2Yg7VxIHfjhqCWNR8dF2v94DG/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904320; c=relaxed/simple;
	bh=C1qeDwfEftv9Qtc9NbKtJwR0I8PI7F8FTKOgTziQCs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAx3uv/6SqCWFtlqtinNTmP2BNWDQbX0TdGE2dK1wjhV/LUDE5me3pp7BnHP0s70tIp4InvOkBQPUpmAICPGMRoGQwPnPWU/9I+R59qBhaKYfE04Nx83q0Uz7BWa3eaAvmclif3ZvkU1Da8nshlxJ3gjvBOthkHWI2mKQaLupI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wDTP8Tc/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54b10594812so4841086e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754904317; x=1755509117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1qeDwfEftv9Qtc9NbKtJwR0I8PI7F8FTKOgTziQCs4=;
        b=wDTP8Tc/xSAcV3FGVSEZUXpg513zrACzLoc6f0idkbwpC/MlqlPzktfUIDkz6raifg
         /zLdKEEMCgEA2tzqk2srcKx+gDeSeEZKev1tkQRqW4KT/KMUasctixOSzCEiqkyHbPT0
         NommpQ7GKeyyuKeRd+HtEGmx/sBGmV/4V0HSshZsTVgzDjJjzt5PqEZrggIxNJ7tdcr0
         bRwZCo70bADHyJIT0orxARooOvhJ+WlyWo/SMVdLUhoQCc52GPUHd12FeXrXEQevtbqM
         MsEu0q8JxYKDT/wv2v2NOSgwURR+WPsTvaVCX1Vdg+A8RzQkUlcgA1HhJ+j0lDB0Bi/3
         PZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904317; x=1755509117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1qeDwfEftv9Qtc9NbKtJwR0I8PI7F8FTKOgTziQCs4=;
        b=uQROr/VG4cgEE1ialxu+FF9zmWK5qICpTj2qQ5R3KmN9fo1zF8pGEmEMWDBI+dbNeb
         /WIo5FbTFUJ9QDu1bHeTKOahb9nBTNbeAlQZqO0tZ+idP3+cwrp7FdLjdxns4lWemJuZ
         FZ5MJ9IMk1JIpGdGgGTHJbOJZfaIrebmwNhBeRLeXe2ufIFupeqtHXbHOFyXX+D/n7W3
         cAGjH+Hmf4ipOUQRW9YckRdXcY7LJUvy9a5abqVqO25Sn7ueKszhQ8YtFIKeS5xuaLrH
         6htq+glSujKWklZd0UDWPDu5t7lm+hKP2Pk04/HtHVAD8X+73ZdmNP30Dvd0iDI4wsg+
         JIcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpsSyRq37kVzU1UWzbwBQOrfAC2uhPAUdV8FgD+e0HrypheI7uaZ8sBzZcFr2N/fAz+Yq6kk2NiCn/UVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQFnx4S2VrbNKrool1uoco873xczEZJYpnTM+STNaBUsbPbdS
	qDXE/GQTAitb68GOCbpIOp4TNkSRFsBmh9WTS1dnqcyJy8ZOQeTJlL2hbdPqTBAqhrscqtq3AO5
	jU2VZ9iCGLrudCEobTd4czPlU/3f/ZmkQ2IHAuEKrqVoODpH6zGf1
X-Gm-Gg: ASbGnctBqt07leEeHKK3jxpPR+JRDrQjkq1iST2i7/thAHkHF69GKNuVNpemHwrRXKA
	Czxq5nyymzM1mvsmL/APP9S2nSVYr/F4q2oGjutG8cRx04odac10FzOh+/xHsR/qna9hQWOZEnb
	SHzkWnoEaWKQRkMb0tTKWtOdypCwlum55qe5Y6XuOuGhYgc+/835zXy1kLM4al94hImAs9eUzAI
	yS5MwXklzn1o2ODCnYKw/uIf3qq3Cy3HUEyC6E=
X-Google-Smtp-Source: AGHT+IFEJ8Kr/7UZFUl5DP8ogOjUFv7USaGLp1Up0YSuMufZWuE20hE2f9lNt4hFnaJMoKk5CyywiZa15bQxtX2o7xc=
X-Received: by 2002:a05:6512:1582:b0:55c:cbf0:9f2 with SMTP id
 2adb3069b0e04-55ccbf00abemr1611941e87.39.1754904316634; Mon, 11 Aug 2025
 02:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
In-Reply-To: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Aug 2025 11:25:05 +0200
X-Gm-Features: Ac12FXyxTrtG2C5wrpdI0tEHXQwjM85EraScv-lGtxmCx_tl-04aa508XaY2bDg
Message-ID: <CAMRc=Me54AmqRJ3pZFfP3L=Ua5qqk2z_ZwR6FRfafOoTCxmy2g@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:00=E2=80=AFAM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> This is the eighth version of this series. I just added a missing header
> file in gpio-aggregator driver to fix a build warning reported by a kerne=
l
> test robot [1].
>
> [1] https://lore.kernel.org/oe-kbuild-all/202506092324.XqSwWl1z-lkp@intel=
.com/
>
> Best Regards,
>
> Thomas
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---

Thomas,

Can you please rebase on top of v6.17-rc1 and resend? I will pick up
patches 1-9 and provide an immutable branch for Linus to take the
pinctrl patch.

Bart

