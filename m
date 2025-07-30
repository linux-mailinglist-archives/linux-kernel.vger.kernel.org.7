Return-Path: <linux-kernel+bounces-751418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF6B16954
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C137B4EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFCB239E88;
	Wed, 30 Jul 2025 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mxbHuJwB"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F532367AB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918849; cv=none; b=I1bj27IduqSqydG9UnEMBukmcLjDqSPxyBsRj/db8erJV5B5lVOjd+qQXrKFrDMsJt8aquQsqMjqUzjH81sOiGk8qEe7oFS2mL0GP/HG0Wkpjo7K9Q3B881g+AJaI9it9w0OM/AUAD4Dj7QiUu3pHHBKPPrjrQmfzWG0+1kywDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918849; c=relaxed/simple;
	bh=xQ1ekwyaAny+xsaD4PFLtl5nwzzTN8WV69sYffvh/HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4y0Wn7WhKmVC9pDRmc/FiNCPcRBpwzgt5ynJDrXbANYX/Ln+j4ZcuRVER2dXBvCEHn3z9hRw7LexT2anXGnqTKFmhFRUBQD8dFcigTNgDWm1ReE+m3C76R1AC9f9I9oHAnI5SpdpHp+n1W7OOS97TsHpJ4oVmRCQ5CEBmoRYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mxbHuJwB; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8645E1F68D;
	Wed, 30 Jul 2025 23:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753918845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bR3JGxpKyku1jgrheb1S4khIcDg46stmRh2K5BKlf64=;
	b=mxbHuJwBJf35OEJAIbOS6ZMU31IlF1Ipvs1fwvwHElAXPFfEHFQUN784gGTIxTgiWjL1M1
	N2V7GVNv0J3cK9ZKjq2LKYUobssHWdw3G2bH0NuvAna61l0BtMBg9qOXDow8Lqaz67d+Aj
	NAQN+fdIZPgZZRylKyglX56srZRe80MEIB/Yfp5QDMY5VjSzQhdZ/iWAI3LUSPbevxQWGb
	X5r+dTn7PeSsWaDvdmut/AVTUT+3/v/nsVays72/a/9RKNL/8fU8t/XO2nmJMXI+w5Jmdv
	J1/4ADzgqaLzacHCKPDS7uUEgBhhEHwJGJXS21MI3o1PRSPBO2FmNTovAkQMSw==
Date: Thu, 31 Jul 2025 01:40:43 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: frank.li@nxp.com, miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org,
	Stanley Chu <stanley.chuys@gmail.com>
Cc: linux-kernel@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v3] i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
Message-ID: <175391871301.1768453.9271887329370264388.b4-ty@bootlin.com>
References: <20250730003719.1825593-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730003719.1825593-1-yschu@nuvoton.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelledvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieejfefhffekjeeuheevueevjedvleevjeetudffheeutdffudefjeduffeuvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmedvugemieefjedtmeduvgeffeemfhelvdelmeehvggskeemuddugeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvugemieefjedtmeduvgeffeemfhelvdelmeehvggskeemuddugeefpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepfhhrrghnkhdrlhhisehngihprdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhsthhsrdhin
 hhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhtrghnlhgvhidrtghhuhihshesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmvghrrdhmrghimhhonhesnhhuvhhothhonhdrtghomhdprhgtphhtthhopehkfihlihhusehnuhhvohhtohhnrdgtohhmpdhrtghpthhtohephihstghhuhesnhhuvhhothhonhdrtghomh
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 30 Jul 2025 08:37:19 +0800, Stanley Chu wrote:
> In a private write transfer, the driver pre-fills the FIFO to work around
> the FIFO_EMPTY quirk. However, if an IBIWON event occurs, the hardware
> emits a NACK and the driver initiates a retry. During the retry, driver
> attempts to pre-fill the FIFO again if there is remaining data, but since
> the FIFO is already full, this leads to data loss.
> 
> Check available space in FIFO to prevent overflow.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
      https://git.kernel.org/abelloni/c/bc4a09d8e79c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

