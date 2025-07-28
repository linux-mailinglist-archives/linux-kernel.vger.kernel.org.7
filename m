Return-Path: <linux-kernel+bounces-748538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D692DB14261
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFBF189C94F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79981277CBB;
	Mon, 28 Jul 2025 19:06:52 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B02749DA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729612; cv=none; b=F5sdTnZDPMh5PydREI/eF17lR06eaHrwF5ymPTgHkxFHMQ24BD7K2KL8IsW878eQERDXLpSQAqjBCRO8R6vF05LEkJJODHYkvpWzljv+KZliaPpRJg2GQdHsT5ZEP2eyqm6C8dN/p8Bp5CG7IeVMjbqUPuaNRIZkXG/CQn+GjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729612; c=relaxed/simple;
	bh=Q7RTqCPJHOUAvqgwguUczLoaFEEfzLbq0Mq8USt1i1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrzuPpL97NtsrE4wO9zev0BMjrutGAOAEN4ceEtLeRaaOgVXmo5lZ2/zymVLgGPE76/K7cTx8oopQz/vmWap8aw8NrwtX5FbdimGTcvaGf+lBygB+/LAu5FWvC6jkkA5TA1L7rUOVtPEuWJ3FvqLd1xgJUL634lhVMhnsmyDmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 56SJ6b6E024585;
	Mon, 28 Jul 2025 21:06:37 +0200
Date: Mon, 28 Jul 2025 21:06:37 +0200
From: Willy Tarreau <w@1wt.eu>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: rockchip-otp: Handle internal word_size in main
 reg_read op
Message-ID: <20250728190637.GB24527@1wt.eu>
References: <20250316191900.1858944-1-jonas@kwiboo.se>
 <3635379.iIbC2pHGDl@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3635379.iIbC2pHGDl@diego>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Apr 22, 2025 at 11:37:06AM +0200, Heiko Stübner wrote:
> Am Sonntag, 16. März 2025, 20:18:58 Mitteleuropäische Sommerzeit schrieb Jonas Karlman:
> > Rockchip SoCs RK3576 and RK3588 read data from the OTP using 32-bit
> > words instead of normal 8-bit bytes. Similar RK3506, RK3528, RK3562 and
> > RK3568 will read data from OTP using 16-bit words.
> > 
> > The nvmem core stride and word_size cannot fully be used as cells is not
> > always aligned. Continue to report a stride=1 and word_size=1 in
> > nvmem_config and instead handle use of SoC specific word_size internally
> > in the driver.
> > 
> > Move current SoC specific word_size handling from the RK3588 read_reg
> > operation to the main read_reg operation to help simplify the SoC
> > specific read_reg operation and allow code reuse in a future RK3568
> > reg_read operation.
> > 
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> On both rk3576 and rk3588 compared nvmem content before and after
> the change, so
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>

My understanding is that it's part of the dependency chain needed to
get TSADC to work, and since I could get it to work on my E20C using
Jonas' extra patches, I guess it confirms that it works as well on
RK3528:

Tested-by: Willy Tarreau <w@1wt.eu>

Willy

