Return-Path: <linux-kernel+bounces-835604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04FBA7901
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 00:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184783B41DA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 22:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F7257848;
	Sun, 28 Sep 2025 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dg6dNamV"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC61FB3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097986; cv=none; b=DYCNaYmOV77EmEJM7TfTd80hBQynaUh8peKnkhWeJsKZUHJvVJ6I5TCnj+mzmz2zGisRopKPlACpyKvsI+wi4NKm+o/uROPODCf8PK+UrUzomD3OlzzbKxqFdV42jsv5VA60y9YtFOuie32179K4XgW2Rk1x5UCeDGJFXGE7Dy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097986; c=relaxed/simple;
	bh=4G4fkpFJdaYItTNjqcIuIQiRZdd7DVjFmGq46Xqdvno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyXAHscIu8HztRwnaveXkyk725pQZSaWZb1lT+09hhohkLWaLaO+/AmA1mknXJmqxJL2c7D08JYIHLrQmQns2dqYsESS482D3IV4lBlY2BBsSzGUv4RFparBacsMkK8/sPon44Y9MWPgn616D+AczvZv9PCZTBotyY6XbcvspNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dg6dNamV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CE2FF4E40E4D;
	Sun, 28 Sep 2025 22:19:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CC906066E;
	Sun, 28 Sep 2025 22:19:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 621D5102F182C;
	Mon, 29 Sep 2025 00:19:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759097972; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=VpzD/pt9+kySB/WAKqTwz6rECss/zhOyWoiCwpxEYVI=;
	b=Dg6dNamVTWtGrmmCOIEzpa0PXlOEZDcayuurVRsf2j7Vjbh4ajdt9n9VdTd/nTaKw0QfhB
	xWaaEi/lbozx/PJ9Ur6+S+KqQzDmTJ+ryh91/WILqh9gT6aoO1IM2ItHIGCvnAIcPgziFp
	PtjynRgo64DzJccLEifmyUdFxZ9gz5KtiskD4btuvBwUyS+DwUEH/Wht1MVMggByUtVaXs
	Y8GcFfj71vGGRZbwXg8JKWpfqKhshviguedrfVSMdA8fNfztl7Y/U7cvpHTOO+bHJdswUx
	7CBEyfsFxHBw0N+m8qjY8+Ze90HiDkKh+tt5AFPoV2y6IhOfbn2rRTGschk3nw==
Date: Mon, 29 Sep 2025 00:19:18 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jorge Marques <jorge.marques@analog.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Message-ID: <175909785772.1659314.16007344807551348138.b4-ty@bootlin.com>
References: <20250924201837.3691486-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924201837.3691486-1-arnd@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 24 Sep 2025 22:18:33 +0200, Arnd Bergmann wrote:
> Short MMIO transfers that are not a multiple of four bytes in size need
> a special case for the final bytes, however the existing implementation
> is not endian-safe and introduces an incorrect byteswap on big-endian
> kernels.
> 
> This usually does not cause problems because most systems are
> little-endian and most transfers are multiple of four bytes long, but
> still needs to be fixed to avoid the extra byteswap.
> 
> [...]

Applied, thanks!

[1/1] i3c: fix big-endian FIFO transfers
      https://git.kernel.org/i3c/c/d6ddd9beb1a5

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

