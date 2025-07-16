Return-Path: <linux-kernel+bounces-733546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC8B0760F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC723ADE33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12C145348;
	Wed, 16 Jul 2025 12:46:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B584DDAD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669985; cv=none; b=lqvqipj8iGa+ZjNUCCR+QkkIxgUVVDWuktXRNbDo7a42sAmaeEMT3YySuO8kUL3ASXt/v0LGyhSDcUuG7I3KFDEijLDv5NybL+n5dJaBpCSsDTmn4qvDZ6P6OYgS693tYFbyP2+K91Tazq3ZoNugTi9nUJtgSmljMqDgUXcxdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669985; c=relaxed/simple;
	bh=u7iyt+IhcoAfr3c3y9RphOuKWcHQqznG0F19q4BfRFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igShJ5HPQ7PwRwrwC2u3eYSGT8Ki7pHyfAyr3e0DE4gCNr/Dr9ORccP/re/lo+tANISOxeS8l9HtIbYD1SXgG7YZJL45z7znPl1BIV9qofo9/fAyYomui13BA7HBAWneTAPlxZHx2If12ksrf5Km+ujqHf1lqmD5/Pm1VjjPh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jlu@pengutronix.de>)
	id 1uc1WK-0005Ce-L7; Wed, 16 Jul 2025 14:46:00 +0200
Message-ID: <108904d971200066ce10a461a64eac29cf1cb622.camel@pengutronix.de>
Subject: Re: [PATCH v4 00/10] gpio: sysfs: add a per-chip export/unexport
 attribute pair
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Reply-To: jlu@pengutronix.de
To: Bartosz Golaszewski <brgl@bgdev.pl>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>,  Kent Gibson <warthog618@gmail.com>, Marek Vasut
 <marex@denx.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Linus
 Walleij <linus.walleij@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz
	Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 16 Jul 2025 14:45:59 +0200
In-Reply-To: <CAMRc=Mc7HaVjchDWN_oWUuqgVZbj3ZVYvU-bwiA+ZUH+0gEXSQ@mail.gmail.com>
References: <20250704-gpio-sysfs-chip-export-v4-0-9289d8758243@linaro.org>
	 <CAMRc=Mc7HaVjchDWN_oWUuqgVZbj3ZVYvU-bwiA+ZUH+0gEXSQ@mail.gmail.com>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Sun, 2025-07-13 at 10:48 +0200, Bartosz Golaszewski wrote:
> Alright, so what are we doing about this? Should I queue these patches
> for v6.17? Kent, any additional comments? Geert, Jan: did you have the
> chance to test it?

I've tried it out and didn't find any issues.

Thanks a lot for implementing this!

Regards,
Jan

