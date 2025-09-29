Return-Path: <linux-kernel+bounces-836531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E4CBA9EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870DB1C6306
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77012EAB66;
	Mon, 29 Sep 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KU88oRo4"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9F1B87C0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161814; cv=none; b=J7jKZC4P4iIHOWSL+JscEmltD+gx7HQO9JUWej6YVjcK7WK7OWJN6EkUTMzuvzOn89hiEl+2GEDfzD5zAheCRAROEUyUyYKBwpZJznxDV8wI8pli6pS0dspivNA9pCCYBczCU41f59uAiquw6V8OcwtnPNTe4gG7ilQUOtLXUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161814; c=relaxed/simple;
	bh=KIPVkgzPt0+w78o3IWlb8IhBUW6IlF++X3K2RDXLjBA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qqxxe21iEDC1RFd6Nza7QP8PHvQuSEm3q9wN+DmD6MSEiZmLW/VpdFdmzalP7Bhgc3NYtw2MHzZU4gLWhfIn+9Rd2dVBMANl7k1/JZzt07nIWBh7gzKwkvzBEoc/xnDUTURJ3qBo3ZVLJAH/JhRa0uJaQZznSMBHq0Z1mVjmzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KU88oRo4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8AE741A0F7A;
	Mon, 29 Sep 2025 16:03:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61195606AE;
	Mon, 29 Sep 2025 16:03:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D69F102F1892;
	Mon, 29 Sep 2025 18:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759161809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tk1eZV5jzVZvv4lv795Qh576K4MgQIfXrsJ1ER9BklY=;
	b=KU88oRo48SOjQw8HL39BM8Jw3frtT7XIBLMjNW8pXg5WB6qmZ/HTDO27NhxE07Ae8g7K7Z
	So5jC/XrVEmIbCuTZ/rdWsdexRXKgsn25Vctc+aYcY9bSjr/Zb964TrUuTSgWa1kQBVLj0
	/y7j4ldcM/c1IwSvEYZrwKeni7NFkXIgVjIo65N0574ovq1h6JAPppOG0epLc3SOjvfvCi
	Me7vycgfT+V7f2NmFAbV8YVSddFq7NWgPTMZESJy8QB4NICkB/qZ6AyE5zV/nCsgsaE04N
	MnQUA076ZO6dSLOWw+i33RG2uMxb/Y4/c2lxGXh9q3F6HMyww/O6GP+0UvnGgA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Johan Hovold <johan@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250922153107.16381-1-johan@kernel.org>
References: <20250922153107.16381-1-johan@kernel.org>
Subject: Re: [PATCH 0/8] mtd: drop unused module aliases
Message-Id: <175916179659.52129.17423940507748789517.b4-ty@bootlin.com>
Date: Mon, 29 Sep 2025 18:03:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 22 Sep 2025 17:30:59 +0200, Johan Hovold wrote:
> When fixing a device leak in the omap2 rawnand driver I noticed it had
> a no longer used platform module alias.
> 
> This series drops unused module aliases from mtd drivers that never
> supported anything but OF probing or that no longer do.
> 
> Johan
> 
> [...]

Applied to mtd/next, thanks!

[1/8] mtd: hyperbus: hbmc-am654: drop unused module alias
      commit: 192f981c14bfad4241446544cf0d27b9fa11a7bd
[2/8] mtd: onenand: omap2: drop unused module alias
      commit: cc74c3f8e4bc01ecf9849a2b22706ba96a29f749
[3/8] mtd: rawnand: atmel: drop unused module alias
      commit: 7a3f3c5bdecfe3cf6cdd35073c2729a46894a34d
[4/8] mtd: rawnand: omap2: drop unused module alias
      commit: b1a5c6de97b4c861c1ad1e7ad3818ebd32be190e
[5/8] mtd: rawnand: pl353: drop unused module alias
      commit: 1f7005d382f567b25cfb96d9f201f5448cf67f9a
[6/8] mtd: rawnand: rockchip: drop unused module alias
      commit: 61163e7373f678c453a4505865e0f8b27e506de8
[7/8] mtd: rawnand: stm32_fmc2: drop unused module alias
      commit: 2f05c108664056f91e5f9171169c685f517ac568
[8/8] mtd: rawnand: sunxi: drop unused module alias
      commit: 362f84c89e136539b8c3edb47f42fb06ce37bacf

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


