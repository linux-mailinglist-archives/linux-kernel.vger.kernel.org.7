Return-Path: <linux-kernel+bounces-843159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E8BBE870
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14A004F02DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1512D879B;
	Mon,  6 Oct 2025 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DUJ9mxgd"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839862D877F;
	Mon,  6 Oct 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765438; cv=none; b=VZ7aBaqBi08s8CvtGlTAvKYXAjegkT7jXhu4li74l+WSVf/WzwctwPMhM6UhL7km5mNlGlyxTRYgK/Z4nOGVpx4JfJiowtv9W54NdS8fxEr9y0Umf+pM3eEF+Q8SIzkrs4uxCCPPvmhCoX2ECZv9a5ctZkJKilusVJRvpk003ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765438; c=relaxed/simple;
	bh=p9YuerllexJf5L7/+ezExpNFZn7dJhZXDuCz5Tf46zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqs+62Hke90sNkhBA6rsc1i4wlILSr7gH6C753yGYx6MRTi+yzuxEWFL9f8z2KH6rkSwoTvMKaK4JNhdIpz/CaFiA1/sGe5gCCHACQs4c8bv3J5dUHqVho9QADUAxwrWDDXJFcuFo8d4QdF0fgDfO4jYx+t4J1V0gf1SaRP2LK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DUJ9mxgd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5lizV0k8IvCTAEiYWCtHMTokoOjYS99KwY/En0ypzY4=; b=DU
	J9mxgdICTXHVmXLXd/h2dC36s8rbQWQZwud+V5Py7qhz4LGMYIo0W+pZ81un18cjeEkCf4a2cKClj
	ydermpj2SPzI1QPUzMs9WVL1LtDY1FPyTYui2JelvlPMRGQXOPPqwuGF3e537Pv9zkhzVqKVQCFmH
	P9jxMvkJaUh0bbk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v5nN8-00AIxf-9q; Mon, 06 Oct 2025 17:43:34 +0200
Date: Mon, 6 Oct 2025 17:43:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: jjm2473 <jjm2473@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
Message-ID: <6a5b9e68-4f23-49b9-b744-e84fc28a96b0@lunn.ch>
References: <20250929065714.27741-1-jjm2473@gmail.com>
 <20250929065714.27741-3-jjm2473@gmail.com>
 <5700676.tIAgqjz4sF@phil>
 <CAP_9mL6e8ekL14xycSfPmVSkL7pANLeyewWd=rjxbtMgMQXxxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_9mL6e8ekL14xycSfPmVSkL7pANLeyewWd=rjxbtMgMQXxxw@mail.gmail.com>

On Tue, Sep 30, 2025 at 02:20:57AM +0800, jjm2473 wrote:
> Heiko Stuebner <heiko@sntech.de> 于2025年9月29日周一 20:28写道：
> >
> > Am Montag, 29. September 2025, 08:57:13 Mitteleuropäische Sommerzeit schrieb Liangbin Lian:
> > > LinkEase EasePi R1 is a high-performance mini router based on RK3568.
> > >
> > > Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
> >
> > In v1 this patch received an
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> >
> >
> 
> In the next version, I will add 'Acked-by' to the commit message
> and then run `git format-patch` to avoid missing it.

Please consider using b4. It will automagically collect all these
reviewed-by, acked-by tags and all them to the patches for you.

	     Andrew

