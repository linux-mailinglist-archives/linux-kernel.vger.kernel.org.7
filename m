Return-Path: <linux-kernel+bounces-793621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D479B3D630
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E66C174B8A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAA21D5AD4;
	Mon,  1 Sep 2025 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ax2HORdW"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7FF13AD05;
	Mon,  1 Sep 2025 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756687662; cv=none; b=RaG/4gA2HoixuVSt+a1kOvuu1r285jqb5E2YJt71jDvKzVneQCWY4h6D7MZemb6eBL+zi7X50XkD+NPs1BOWj0/l4BncHeY+wMIKK/eSK+SYUZb3Gj5v+2EqhoXKncm1nN+9xSDVVwjjQUUAT2od+R7Mpmc86zG0/S2ZvV6nhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756687662; c=relaxed/simple;
	bh=UXGRob5pv7IL+2i+DC+GTeHaZoz3pkxPeW2ctW2s1lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3Eri2Zkaa7HfbVnU5of5OjOo4Y/7xY3dchi7kqSc1ibGmTzc1EkQtyZPwAUPWyEy7CjYfuQRIy6FJo5dcU1blvKPbPCEHPsHTwBD2/Ru31CfpLxwHTD8VKHwTdzuddLE+mZ9eCY+mLdrKwqCFIVpO82DtBvtYdO59h4CLXtvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ax2HORdW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4yfnTBAHWboiM2neBWAP1Ps57yPG/p2u/x0DsAt5z9Y=; b=Ax2HORdWslwgY5f6VBmuynOf1L
	JbOiW98Umtr8rbLbZpS5mSx2d6DeIIUesyoli1xWKOJp1wArfditVba7ZAXwiclLoz7aCQv/Rznme
	kolJUZZPKkjRMMX+nhO+jsunc2vdnT3lUd/c+c7qr8p+6NkZDX60Gvu64nejJJnCbXzg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1usshd-006i3y-5J; Mon, 01 Sep 2025 02:47:21 +0200
Date: Mon, 1 Sep 2025 02:47:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Erik Beck <xunil@tahomasoft.com>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Message-ID: <ff06c2eb-5124-45bf-b4dc-a43f7558563d@lunn.ch>
References: <021c2e76-cbde-4a2e-a165-a61223cdff93@lunn.ch>
 <5285B176-5178-4F6F-8FB6-B898AC0EC939@tahomasoft.com>
 <20250831104839.7b71f2fc.xunil@tahomasoft.com>
 <6238650e-7a3c-4dd9-adad-cd2a5e925500@lunn.ch>
 <20250831122800.330c9ab3.xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831122800.330c9ab3.xunil@tahomasoft.com>

> Just so I am clear, the units are tenths of nanoseconds? So <0x02> is .2
> nanoseconds?
 
Quoting myself: 
 
> > One problem we have with rx_delay and tx_delay is that they are
> > magic. we have no idea what they mean.

I very much doubt 0x02 is 0.2 nano seconds. If you have an
oscilloscope which can handle the signals, you could measure it and
see how the delay changes with different values. But developers have
done that in the past, with mixed results.

	Andrew

