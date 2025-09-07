Return-Path: <linux-kernel+bounces-804680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DD6B47B82
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6057B200AD4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F375273816;
	Sun,  7 Sep 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="Xa1Qe31i"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125A29A2;
	Sun,  7 Sep 2025 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757250770; cv=none; b=GQvLbql9m5CGYkCPgSXtTKfibwKjOPWr/q8lJ+OW0R8WFLoX6XXamjvhBWFlCDnDSclp1Nm3kRi+E/IsSflJEKcJqJeaZIPZ03UqUtaRIRp8fKH3sIA9nnmjdJKjagwfbnc9AQxnNrUWWVLeF8HUfxwG5o4wmR9qhiNxOxvC/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757250770; c=relaxed/simple;
	bh=nG5wetaJQPoFOgX2jI1XYan+GC+3MW+xi5ekXTnU0OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLwJu8O/DQtXUSwx4vdUuaiepVSQSORok3kh2jC7XsHXkXUXqaA096TmJVd6Lpy8C7rl6aaGVn0JRmRozlqBas3RUGdGuJPcs7TlZUmKRHFLnL0NXuJy0wKzHsOtcnHek6c/HlbMiIL+mNaebLwULIU0rZhVrwm3Aki1IJ5URMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=Xa1Qe31i; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Sun, 7 Sep 2025 09:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1757250755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c6m2JvKKQLislbG/lLsCQpWLwDoRY8Pnbo43WEoeMe4=;
	b=Xa1Qe31ib2MbCn8EA7bchWhfdlA69tFg5z35UwJQfmd/Y+tD/PnIaII2ok+/cGbmnaygXG
	cnw0y5r7Lms2YbuHpkXTnZCsUwBRzmNUq0k2vkecwSzbffFAP5DJB/cgPz2kYUDhWVQydd
	MxpBtCD9cBLbhBTqvlClPvOT+OV0rOM3rCofbu3hXvPlLJDNFiPdeWMyrU+CCuBkmMtoaw
	Gtga+xNV4nk42xOEzsnqV6FeJAZ86ROd+Y12UL15xy8xQYr4FlA62dk47mPE1AdKArv3Ag
	aSPKmGr8VWm5B50+e1c/3HddNFZeSixDBFM38iHoz+QSwegkhGRdJDD4gc2PDQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Anne Rosenzweig <alyssa@rosenzweig.io>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 18/22] phy: apple: Add Apple Type-C PHY
Message-ID: <aL2EvQojjEv7z_y-@fedora>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-18-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906-atcphy-6-17-v2-18-52c348623ef6@kernel.org>
X-Migadu-Flow: FLOW_OUT

Looks a lot nicer than the initial version I looked at a few months ago,
nice work Sven :-)

If we're going to define all those mask32/clear32/etc convenience
helpers, there are a couple more we should probably add and use too:

1.
    void cond_set32(void __iomem *reg, bool cond, u32 mask) {
        if (cond) {
            set32(reg, mask);
        } else {
            clear32(reg, mask);
        }
    }

Not sure on the name but this shows up a bunch of places and turns
messy sequences into straight-line code at least.

2.
   #define bit_to_OV(reg, bit) \
        clear32(reg, bit); \
        set32(reg, bit ## _OV); \

Also not sure on the name, but this would make a bunch of sequences
more compact. For example

> clear32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_POST);
> set32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_POST_OV);
> clear32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_POST_2R);
> set32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_POST_2R_OV);
> clear32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_POST_4R);
> set32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_POST_4R_OV);
> clear32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_PRE);
> set32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_PRE_OV);
> clear32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_PRE_2R);
> set32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_PRE_2R_OV);
> clear32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_PRE_4R);
> set32(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_PRE_4R_OV);

turns into

> bit_to_OV(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_POST);
> bit_to_OV(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_POST_2R);
> bit_to_OV(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_POST_4R);
> bit_to_OV(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_PRE);
> bit_to_OV(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_PRE_2R);
> bit_to_OV(tx_shm + LN_AUSPMA_TX_SHM_TXA_IMP_REG3, LN_TXA_MARGIN_PRE_4R);

3. static inline const struct atcphy_mode_configuration
*get_mode_cfg(struct apple_atcphy *atcphy, enum atcphy_mode) {
	if (atcphy->swap_lanes)
		return &atcphy_modes[mode].swapped;
	else
		return &atcphy_modes[mode].normal;
   }

This only shows up two places but both would be improved by its use.

---

With those cleanups (or an explanation why they're silly), ttbomk this
is r-b me, thank you!

