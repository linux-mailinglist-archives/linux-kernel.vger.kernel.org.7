Return-Path: <linux-kernel+bounces-645148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71411AB498E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 04:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA6919E5635
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 02:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4781D6193;
	Tue, 13 May 2025 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YpVbdF6H"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B2189F57;
	Tue, 13 May 2025 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747103881; cv=none; b=XWHYqyKAepFrN1YTfHPVFO3E+VApAJ7t2WPb1j7rnAI2s3BZEiJGvLk11G/9T6HGCwGcjTkg88ODk9whYcdBRIXg+Lc/FGAqqQGFyAoNWT2nB1sITKLEECbLCEv8ShG6H4+uIq/pe4FOCl80cZYkzb/Qy8pseI9Nl9zSNKTAWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747103881; c=relaxed/simple;
	bh=04sUlt7UEnD/nP+0qjHBEGMb91iUpAU7gc7WHGsWIms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFWG2N3wOGr865JfCkhrE04Uevtov1rBlAFEiLslIdsT746uIzrpX8jygcQpF7rhdFIswgpeE2msuwE5EO49czzExdlGzAEao0US216d7L/rw3nLSJutWecbxthrKepnItMGuviFzI7Qcmcjlf3jHxp02h2H8ScP09jwmnRjZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YpVbdF6H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rgcGbGaKyPtbg1A+6vTuVFJps8xC1d4k/ycV/ilPRgI=; b=YpVbdF6HNfHhJd/xv4g2HI9N+F
	58q94fDiqTHbzhi0KEG0Ht5oD3nuKen/Wzn94k71VAYKi+E8qStEg6NbuzyeTbZECKEIcOVnR2xKy
	g94+GwSUfqBpLn6Hz6ju7vwZfp9vembLna5HkxdZB4t+bHYoftEeK1+KcUp6OTC2CWgs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEfWl-00CPFa-Mi; Tue, 13 May 2025 04:37:55 +0200
Date: Tue, 13 May 2025 04:37:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cache: Convert
 marvell,{feroceon,kirkwood}-cache to DT schema
Message-ID: <3ef56602-2fc6-4e78-a749-e604da7b388d@lunn.ch>
References: <20250513015252.1049409-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513015252.1049409-1-robh@kernel.org>

On Mon, May 12, 2025 at 08:52:51PM -0500, Rob Herring (Arm) wrote:
> Convert the Marvell Feroceon/Kirkwood Cache binding to DT schema format.
> 
> Use "marvell,kirkwood-cache" for the filename instead as that's only
> compatible used in a .dts upstream.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

