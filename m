Return-Path: <linux-kernel+bounces-892632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92424C457DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E07B341DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E7238C0D;
	Mon, 10 Nov 2025 09:02:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02F221DB9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765352; cv=none; b=tL1QYQuu5Iu9HWQAvMbEtDSpCgedjb6E1QRgoBHusr5JTqxElKA/l18fCgePCzRem1j2Z7VoC3jh+lyVSOMuLM4xcsuI/H5ujlHxJLn09pMj1DTeHo9Oix49/732hLcAVsfBRMIw+kn74xBgARzqaM64zgYwOuBEIAUgeBT3UD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765352; c=relaxed/simple;
	bh=QrFufJ2w86tkFP9rhjXVQJ64Rz+v5CeknBLF0SvhWU4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d36+yiNmwMeS+uGl3wQ8E2xSNgHM/ENq7hlVknbQtp/jo5sZ2/nxoSfmNiJ1BY/U+A6Da7ddN0CiETtmK/bS93IDC8oratVwdWlItWu9I867uVN6DDlhLh7N/VHKE31kEOCRUzoRLcpj+u4L5VCbTq9/B+0Ws9rw+gGqki/hEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINmu-0001r0-SM; Mon, 10 Nov 2025 10:02:12 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINmu-007zao-01;
	Mon, 10 Nov 2025 10:02:12 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINmt-000000005Cz-3qn7;
	Mon, 10 Nov 2025 10:02:11 +0100
Message-ID: <e0e81310332cfdc075bf13f66d7be712b42964ed.camel@pengutronix.de>
Subject: Re: [PATCH v6 0/8] reset: rework reset-gpios handling
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij	
 <linus.walleij@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus	
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski	 <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Date: Mon, 10 Nov 2025 10:02:11 +0100
In-Reply-To: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2025-11-06 at 15:32 +0100, Bartosz Golaszewski wrote:
> NOTE: I've picked up commit e5d527be7e69 ("gpio: swnode: don't use the
> swnode's name as the key for GPIO lookup") into my fixes branch and will
> send it upstream by the end of this week. It will be part of v6.18-rc5
> which tag will need to be the base for the future immutable branch
> created by Philipp.
>=20
> Software node maintainers: if this versions is good to go, can you leave
> your Acks under patches 1-3 and allow Philipp to take it through the
> reset tree, provided he creates an immutable branch you can pull from
> for v6.19?

Now that -rc5 is out, could I get an Ack to create an immutable branch
with this series on top of v6.18-rc5 (and merge it into reset/next)?

regards
Philipp

