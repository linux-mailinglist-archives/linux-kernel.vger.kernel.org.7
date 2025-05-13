Return-Path: <linux-kernel+bounces-645149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC36BAB4990
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 04:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E2C8C1584
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795331D6193;
	Tue, 13 May 2025 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZQO1FWER"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257023FBA7;
	Tue, 13 May 2025 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747103959; cv=none; b=Tp+dxAaNYThoy1QI4R6NN1B2SwgzuUmdHOC43x5t1a5k+KBZvSmP5dlSzKK0LNQJgrHTiWIHLo/ABLK/7YqHgrgX8hElSDikcYDCB7T+e1vTETeIKAT/fIPrf6ggYm4y8xjooH6pK36DQhhGUNSmwwFpTq26o4TXdj5CoUJXrm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747103959; c=relaxed/simple;
	bh=WXduk0ugGpWqRD31yNyFHETulxE7dHDBVYREFNMzyrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnPjN+pRs6HEwrSawcKo+kg6HUB79jzEfoo2uLaxY0KwChgXi+3H76E9gvtBszSAkBG3UiiXpcGblPIJo4gU/C4uZ9XcohN4xr43oKJGK41sXAaOwAvb+tBXLHl/Fne9zjntXodGucSui01mJNre+rwf3sFlKsEEfLeadqcm9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZQO1FWER; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lBSJhl1yx3AmAEFtBBKymCRalsaZFFwbtUKFw8H5+bw=; b=ZQO1FWERFkqNxdtLIm6+FfBoBz
	yPPw8jJN8C5Nv/Hub9QiqAYy14lDxa7Mtnv0vqpjHAX+F10Q2j+Ps96bFQyrkc6iIA2d/mv5luyA7
	l+E3bI++oqMxy/Rg+1vR2hOkD/F4V/m6iCIJIV7OVF0NWM/nYKcST9Bw2sFRw1QXcUYM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEfY1-00CPGA-UE; Tue, 13 May 2025 04:39:13 +0200
Date: Tue, 13 May 2025 04:39:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cache: Convert marvell,tauros2-cache to DT
 schema
Message-ID: <d8b74932-4b3e-49ac-9d55-cea29ff815b0@lunn.ch>
References: <20250513015302.1049682-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513015302.1049682-1-robh@kernel.org>

On Mon, May 12, 2025 at 08:53:01PM -0500, Rob Herring (Arm) wrote:
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

