Return-Path: <linux-kernel+bounces-850577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D5BD333C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B8618909D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E6A3064B5;
	Mon, 13 Oct 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay5yZrVZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45B30649B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362068; cv=none; b=uRpkCt3X3WqTYqUL3H2LPOE9BWzIavTSrnolZCtqLa3gT9TzA3W2J/nkAlTVrzss4CNc15DNeNsC5gWMoT8Fdb5WS9+Gg35fDaArE/BGVLqjqWMo8lCRBtIIe3ZKnXDdjYhh1bRVOp1ZI7WHEuKJYNP5WHeboBiXAcuNIuVYTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362068; c=relaxed/simple;
	bh=wrdqLnC05j1x7ph05UBOW3Wm+5/W3I7v8Zfg3PuKTmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGureN+CWTHltIncjdfHFEzdD9a8JSxyJ18Kc1OnWo/tRryogPA3VEOFhCKjEp+xkfM8lf9nsaDJLreZnmWDh0NF5waJpBsIHaqlIiK65Q7/d20KoB8tPclNg+jx1OL9k3WjqzRfi1VgTySgPRS2qoQnQ21M1/uS1v+gvR9LRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay5yZrVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EC1C4CEE7;
	Mon, 13 Oct 2025 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760362068;
	bh=wrdqLnC05j1x7ph05UBOW3Wm+5/W3I7v8Zfg3PuKTmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ay5yZrVZ17pYzi5JCPBzgE4zGddAFlOK9HalSNb1b7caWk8F8nOyplD6dzGjnL3vL
	 oWY/bSFJb+Pr0iUctvpfIS2+rSzjIA1mRNJlBvTpkPUnwotpz09ipE0b4eLpJfhIey
	 gamLJa0Wf+htUBncpiVUhTxP4iMQqok3vzv7natnnleykm+8P4HMiQCzA3vUjnECi+
	 0QHAcKP0al7Jyjtbt9v/oc4L9JbI7KladetskhHab2QrvznTG/y2rxeBA+e2+12Hvh
	 6++G+vymRmLmy4nEbcus/z1Sz7uOsX2pFBzFdGbfz0wNh3RTGTJOUlQ2QdqRyEuCC5
	 qnJep3U1B0iLQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8IaX-0000000069g-41hH;
	Mon, 13 Oct 2025 15:27:46 +0200
Date: Mon, 13 Oct 2025 15:27:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 07/11] irqchip/renesas-rzg2l: Fix section mismatch
Message-ID: <aOz-UYvm2sxlVwmE@hovoldconsulting.com>
References: <20251013094611.11745-1-johan@kernel.org>
 <20251013094611.11745-8-johan@kernel.org>
 <CAMuHMdUUdCMa=J+b-V5HAj4PO4n5omQrBCnDvn50Tq9k51ms7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUdCMa=J+b-V5HAj4PO4n5omQrBCnDvn50Tq9k51ms7w@mail.gmail.com>

Hi Geert,

On Mon, Oct 13, 2025 at 03:19:46PM +0200, Geert Uytterhoeven wrote:

> > Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")'
> 
> Unmatched trailing quote?
> This tag points to the wrong commit, the correct one is:
> 
>     Fixes: d011c022efe27579 ("irqchip/renesas-rzg2l: Add support for
> RZ/Five SoC")

Indeed, thanks for catching that.

> > Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> For the actual change:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Johan

