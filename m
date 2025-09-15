Return-Path: <linux-kernel+bounces-816946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE443B57B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525B17AB975
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5C2305E20;
	Mon, 15 Sep 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BA16kbce"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239A302165;
	Mon, 15 Sep 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939558; cv=none; b=cHw/vTI2S1hZqylFmNVWPug+8ajXkH/s55OA80gxxK3Id6KpW0q9bsR71Z4pz/bSwKzMMMBb5kRDTc6spo3nHNr7AYo/JkDYXf5mGvB7ZkR6w7dtONS1AHfW9WYjs8uPmGAwJbO1hcFtBgoVsnjjjOM3g6UOv3nLpZFAIxCsDHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939558; c=relaxed/simple;
	bh=UZfLIPH4/0jRHdCSdFZOCufY+XBIUShCWlGVuq3GmcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqNci1LT1xIx7KiX8EoQjfAJSxP/nEvXv7Lu2RZdo+GqbQVejjwAYZodG3zmWOY1rWshb5V4u78RXCil+T8ODC3jkfbli5wkM6qdScK0gWSU8sJ1f47mC5hNVGjRC7E7PwlDWFgGSlVuhpftybXPmpPgXNqjCwoamWVChyuBRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BA16kbce; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L+qwPhZJSfWWFHa/0JQ9FLyPYdavHmaBAX9ONZmEHB4=; b=BA16kbceQ0CW2l1BGcmB7I60Ya
	QnN81//wbpw8quKuMH6/dnUkOgJEKiQRUZqo2vg5uMwODqj2BFBbDfb6tacvlyba3eyRndm4qgcmz
	m3umrb5pHfC90FqVjq/If662ZML4vhaE6WCfO5tab3MsZReSECjUY8H6hDgUxpR7uSZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uy8NQ-008RD7-1w; Mon, 15 Sep 2025 14:32:12 +0200
Date: Mon, 15 Sep 2025 14:32:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Donald Shannon <donalds@nvidia.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, etanous@nvidia.com
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA VR144NVL board
Message-ID: <6b50e9fb-ce59-406b-bab6-6cfa4eb44e3e@lunn.ch>
References: <20250822203818.4062595-1-donalds@nvidia.com>
 <20250822203818.4062595-3-donalds@nvidia.com>
 <f9cd6015c47d390eef9c689d2cb4fcd301c4d123.camel@codeconstruct.com.au>
 <fcd64668-4232-4d7b-98ec-5326d40d19d7@nvidia.com>
 <f0b75151-d355-4d03-a356-dfbfb7a9e803@nvidia.com>
 <ae46aa8e57d01208deb56a8fd01f26a9a0bf359b.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae46aa8e57d01208deb56a8fd01f26a9a0bf359b.camel@codeconstruct.com.au>

> > 
> > Our board phy implements tx and rx delay, so -id would be the appropriate one to use if we
> > decide to use it.

I'm curious. How do you achieve this? Have you hacked the bootloader?

> Right, so long as there's no delay configured for the MAC in the SCU
> (see SCU340-35C) and networking functions for your board then I think
> it's fine to keep the node and specify `phy-mode = "rgmii-id";`.

Yes, this is how it is supposed to work. But please add a comment to
the commit message about how this actually works, e.g. if you have a
hacked bootloader, please make that clear, in case somebody wants to
run the mainline version on this hardware.

	Andrew

