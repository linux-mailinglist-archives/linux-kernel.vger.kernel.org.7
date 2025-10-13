Return-Path: <linux-kernel+bounces-850477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA15BD2EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 497AB34B7DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692526E6E6;
	Mon, 13 Oct 2025 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ospcB8Q8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F88024468D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357682; cv=none; b=OZfmeXtL2/I4gmYvYkqJkRMoWXiBNDWrsUSu++vJinI62K/7uUrNXhWxVEbsthEz9Ro4O72eVAqHbyRrAG5WkIHWXQeI6a7ibwLzWPuf4wuUf8FrOs6tUTm5VRSodktswBvGNVeU3lXlxjmT3TychjGjCxT5LqwcZV/ZmjDOfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357682; c=relaxed/simple;
	bh=1RbHPJlhPLqgjzvb/EDMf7yGfucbDT8iGI9FAg7bwtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1t4vP7UELJQU92nyGrpJDVll0rDfKXMAhUZ8aGUm1RO80Og+7Na4cvirKptKVPlIFb0qL50vsoUUz3YjzUE06krQwu5XRVVqwamLUgEHhGznUTgW8Qnowk3dE+kOY7NBYdu8gpuIjrJ19PBrqEzO3Rr2rcc1MUgM25xRkgWBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ospcB8Q8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W90OhjYoHyhhzA+BV0JTzFuzDM246+EyNiR3TbYO7Hc=; b=ospcB8Q8QJcC36IuI02UtjG+n8
	IqODYJmAzr9SZklqukg5Cf4cBWMVIpJ5/ZhZu4iYPC33GHcWxeaZxG2sMInpBtQtF8mT3zlxznKMF
	HPtZaje+Z9D/1FjLvCF0/w+QLuMbh/ADTbNIEGW8zGhO1PcXneXtTj2hdO1NPxgKivME=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8HRb-00AmdT-OV; Mon, 13 Oct 2025 14:14:27 +0200
Date: Mon, 13 Oct 2025 14:14:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: alex@digriz.org.uk, sebastian.hesselbarth@gmail.com,
	gregory.clement@bootlin.com, linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm: mach-orion5x: ts78xx: simplify support
 configuration with table
Message-ID: <e729b553-98bd-440d-a0e7-bd84448bd9d8@lunn.ch>
References: <20251012235147.325532-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012235147.325532-1-alex.t.tran@gmail.com>

On Sun, Oct 12, 2025 at 04:51:47PM -0700, Alex Tran wrote:
> Replace switch statement based configuration with a lookup table approach.
> The table is iterated through matching the correct configuration instead of
> setting the configuration on a case by case basis.

Is there anything actually wrong with the current code?

How did you test this?  Do you have a tx78xx?

The only changes made to this file in the last decade have been tree
wide changes. So unless you have one of these machines and intend to
add new features, i suggest you just leave this alone, it is just
needles churn to an ancient platform.

	Andrew

