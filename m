Return-Path: <linux-kernel+bounces-783707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E213B33179
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9833C189C337
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3421ABAE;
	Sun, 24 Aug 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wCKPFHAx"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2762620D2
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756053435; cv=none; b=Uk7W3VrD9EgGW2d1bm+7YQzSC0jdeS/093Ub+P2ylWENlxghKUkojRfdUw3PwLTQjnjFJcHoZUf5QqDUgBdmlvk5FhiEvqUwdUO1onP8j47Z1ZlBDUjVLD387NR/lcU/VpW1cVTfG1Zz8iIt0nrzvbafCjSkRYqoPTnNBGkB0gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756053435; c=relaxed/simple;
	bh=TOR07+op99gmkoh5m1rzWNu2UhjxorgYof+Hvu4K3U0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JpsLlxuRBZas7dQgUsjJEQMuUGwWVuqdF7LLfOCl2eziOXJxVezdguFuIac2FfXGKCG/c+kTpxPqqYEoeP0zBhN3WVytAGFdBI4hK55p35wmrkO7hRnU67KqK3MHKwsn0mW+yU4PPlBx7PwyEtW0h/NmavBLkhSV5TAvycm5Nbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wCKPFHAx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 76A5E4E40C29
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 16:37:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36330605F1;
	Sun, 24 Aug 2025 16:37:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D72F51C22C8F8;
	Sun, 24 Aug 2025 18:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756053429; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TOR07+op99gmkoh5m1rzWNu2UhjxorgYof+Hvu4K3U0=;
	b=wCKPFHAx7htZXHXz/fcGIsvaB2kaberm9QlWFxxhy3wx399PtyZFP4lV/9+YrZ9BxEuDr2
	WM+wkQJTvqw+ZnZj/IpEKvWZTmtdR18LT2B3OfVLRtfxcT3L25+6eufB92kB0XX52N2N8o
	OOAxX1vwb98iGvavgcEfk8uay9aHYRTdzcD373lHM7YMHXtZ+dH+Zl4SuWHMQSedKS6A5H
	dOUqxpW9W1pVoHnR8o1G9kzDmfZnmRm9sVLF4vO8l7RJ+Q4YOO+vhM7idW6xt1SOoV0UKY
	1NcBgvFPH63jKE45/ngiR5eVe8CSgor2zK+8tbmzbPqXMoKlQffMLj+Wp27coQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Eggers <ceggers@arri.de>
Cc: Richard Weinberger <richard@nod.at>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: mtd: rawnand: Inconsistent parameter page on Foresee FSNS8A002G ?
In-Reply-To: <3542795.LZWGnKmheA@n9w6sw14> (Christian Eggers's message of
	"Mon, 18 Aug 2025 19:02:49 +0200")
References: <3542795.LZWGnKmheA@n9w6sw14>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 18:37:06 +0200
Message-ID: <87tt1whe19.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Christian,

On 18/08/2025 at 19:02:49 +02, Christian Eggers <ceggers@arri.de> wrote:

> I try to use a Foresee FSNS8A002G SLC flash chip on an i.MX6 GPMI control=
ler:
>
> https://www.lcsc.com/datasheet/C5126835.pdf
>
> The kernel output looks promising, but one line looks suspicious:
>
> ...
> nand: device found, Manufacturer ID: 0xcd, Chip ID: 0xda
> nand: Foresee FSNS8A002G
> nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> nand: SDR timing mode 4 not acknowledged by the NAND chip
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Bad block table found at page 131008, version 0x01
> Bad block table found at page 130944, version 0x01
> 3 fixed-partitions partitions found on MTD device gpmi-nand
> ...
>
> According to the documentation of "Read Parameter Page", byte 129-130,=20
> SDR modes 0 to 5 should be supported (page 19 on the data sheet).
> But the documentation of the GET_FEATURE/SET_FEATURE operation misses
> the "Timing mode" register (data sheet, page 24).
>
> I saw that there is a quirk for some Macronix chips which also seem
> not to support getting/setting the timing mode (but declaring them
> in the parameter page).

Unfortunately, it happens that sometimes flash vendor mess up parameter
pages, so either the flash supports mode 5 and it is lying to you (you
can test it and add a quirk) or the flash does not because this batch
could not stand a faster rate (?).

> My main question is whether this is "normal variation within the flash
> market" or a serious issue. In contrast to another device I currently
> use, the Foresee chip also doesn't support "cached" operations. Is there
> much value writing a fix for Timing Mode issue, or should I better
> use another flash device?

I cannot tell for sure, I hope it is rare enough but we've already seen
variations between identical devices with the same ID... So it is up to
you to talk to your NAND vendor in order to know whether there's been a
change in their line or if this chip is special and decide what's
best. If you think a quirk is relevant, don't hesitate to submit that
(and yes, the Macronix NAND flash driver gives you an example of how to
do that).

Thanks,
Miqu=C3=A8l

