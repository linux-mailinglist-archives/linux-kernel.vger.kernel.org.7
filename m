Return-Path: <linux-kernel+bounces-815921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB1B56CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EEC3BCF03
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B699023A9B3;
	Sun, 14 Sep 2025 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qTU8QY/I"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95B20E6F3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757891935; cv=none; b=O101shi6PSHuwx5CuJEyKYFUB6nox2svS88Ie29XhUsjcYFiwH4xk6El26ahTcp6TuK0zk34Dmj7ioAprEih/dOU2lzwFDeWwji1F/c7a+RrfmcevtevTL1fWqpKA6vkokaPZmJ3TDifos4OjzT38in1Z0IXHYXqzbQa0DD1ACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757891935; c=relaxed/simple;
	bh=qAq6Lc5Iqy1GrNphttxdNVICa5kFfD/Hsy9BGeFvDcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXe6S2hbxsyGZN3nqZ/RFvAys/BrjacSb/TXhcc5/bNgojR4nNkYlA9j4QsV5D8RQeeEzn1Fy4cxu+wYuEvgflcj1I904+R3WyvhnFO49kjc2GO1bppAdqBmWEc4/pGSpldHfdd2VoQzeNz+/x4l4b/n3/TVGh0wHKNP5YTqQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qTU8QY/I; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6E358C6B39E;
	Sun, 14 Sep 2025 23:18:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A762C6063F;
	Sun, 14 Sep 2025 23:18:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41428102F2A84;
	Mon, 15 Sep 2025 01:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757891931; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Kz/TYiAiFScWT9Eog/3uaFprqjRgxDp0fqtkMBbjrK8=;
	b=qTU8QY/IcW9PdJdHfnnSnriw55iAxbvX/V0HYJzDwh9/ccxZMgctDY3iHtACLrEG0uKRSf
	ojX3S7JMYpfZKVXND4tgQ0SSFRVG/ypARvwv8/B36uV2FTCRDOBYED4p+Msp08qcktnH9Z
	em8OKo2BPBenm6uJzIjPI0E+y6mJkWqaoDugILwJjIfjQoPTr34627ybfkL2Ks2RSxBt+1
	ynSQVUJayQm+YuY14kNVSfjnej6KYOJGGyvoiZfPE9Q7DBcbM4tXjw00qsJNvZATeIPRqs
	CwpCsDeGS4koA54fo591RbH3mvLfq+2HJlDecORy/pOaI/WgJdrGKxlEF+QhqQ==
Date: Mon, 15 Sep 2025 01:18:46 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Mark Brown <broonie@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: Re: (subset) [PATCH 17/21] rtc: remove unneeded 'fast_io' parameter
 in regmap_config
Message-ID: <175789183742.411954.10264880654023329075.b4-ty@bootlin.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
 <20250813161517.4746-18-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813161517.4746-18-wsa+renesas@sang-engineering.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 13 Aug 2025 18:15:03 +0200, Wolfram Sang wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> 

Applied, thanks!

[17/21] rtc: remove unneeded 'fast_io' parameter in regmap_config
        https://git.kernel.org/abelloni/c/c90c7ebf8f73

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

