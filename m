Return-Path: <linux-kernel+bounces-747134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E298B13029
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7351E7A8981
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23121ADB9;
	Sun, 27 Jul 2025 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QBVi0/B3"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C94A33;
	Sun, 27 Jul 2025 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631184; cv=none; b=RYw/mHH7TaMaKEJ4Svy6xG7x9hqRXfMnvFyaVUH8ChfJ7JRRithEewVyLcBdpgtG5M6/liJfMDN3O/5irDGaWHezEA6ppCtjI1Af/mCcZb3O6YUJ5FhT1NSvZB+7oOyONxD4J2aVvJG3NX0lF3TUWld865m6bvEJzsOVEr/UHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631184; c=relaxed/simple;
	bh=jDM2Pyaudn8WIb51k/CHphHn2RTsXtiFU/WVhU2roOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLVDZd9AlKhrQJI8vBZmJM5stwXkFkcAYsLE8eKmuqHmE69WYwkEhk08bQ7xZ/08alVwaLISibVgJrD5TZRAQkWbDeGxohVZdLXvHWpq9xo0ZS8KdINbmcZFDLLnsjRdin1DlSj/GkbxBn3k9FM2NGlTXewlJ5+DCGAhRnGDa9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QBVi0/B3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ea/LVnrickzrKsQYDVPNFYq4HqocG3+kI8GD60vgLes=; b=QBVi0/B33ltuEPuvItV2c342JE
	VhGgUB8pE0M8DhPFgtpP/R0NyKeM5ckeok09OTTsnJ7nKRsFaN2LxdVWS4bu1Ir1Ma8YWCLfb7W68
	XwcuvozrF4T6aKh7FDl7mf5oXsKSz7RSs/QC+PGWcqvrdgFZpND3OkPMsKx9aJURUxpY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ug3ZP-0030lE-Nq; Sun, 27 Jul 2025 17:45:51 +0200
Date: Sun, 27 Jul 2025 17:45:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <9897e0a4-7c70-4e27-8591-09e9d6ef2263@lunn.ch>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
 <aIGGdbIX9HaV4dB/@localhost.localdomain>
 <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>
 <aIMTvUyHGd/ikKY9@localhost.localdomain>
 <aIW/xEfJX/UD1kje@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIW/xEfJX/UD1kje@localhost.localdomain>

> As I'm not 100% sure where the RX clock delay is introduced, I will drop
> mac3 entry in v4.

Many of the hyperscalers, or the supplies to the hyperscalers keep
hitting this. The standard policy at the moment seems to be to drop
Ethernet support. How useful is a BMC without Ethernet?

If you all got together and talked to aspeed, apply a bit of pressure,
it should be possible to get this mess fixed pretty quickly. And then
you could all have working Ethernet....

	Andrew

