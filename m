Return-Path: <linux-kernel+bounces-829548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863ADB9750F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497B6169B78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735A302CDF;
	Tue, 23 Sep 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Oci7VcRG"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66897464
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655075; cv=none; b=HfVMKNeWhVaDlu/0jsJIDUc2iFObEap2mO8iAbRG82rW5cC5wsamvSBEuPB594hPhWR/F4KaVzp8iikIbu3SmT2+y/wA0PYejlN+C6rnUvWfkogk0O73n8ceYNa8i2vrsW0dwfhTiR/cVIoUd60j9U3MoYtagLIpRj8YtrpVCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655075; c=relaxed/simple;
	bh=KqEM+j4Xq/ieyoDH0zs043KwBCa25kqQpEMLanObMus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4DgdX9V/MBmQUdCxKf6L/ej/bSzOZKxNbnpLw2LVP9KWV0gfjOxk8TMqguOyvDoR0OKFbeG+jKrfhGTTMsgmSjU6a8t2ArXaJVx9R3LdVi2d9UI4TnUaKWqJM5KsWQd+vFfGIzHkHJT76IFhlPaBB0qQjNtZLyrgAO8+tH4eBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Oci7VcRG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=88Uw
	VFjX97MoYSMeOH1SLzVclQVNBNbeyiQaeTS1Kp8=; b=Oci7VcRGSXUwUyja3UuD
	l/XYL38sK95BnOdFtnd02bN0te4x/OoEaN0XhYAZh6OD4j4wrOiAXGnqcf0HjGHG
	JycqJ01dyd4jfNrWqdY5BvZTHNnPBUqYM+wCxzN5kCjjMhZIptbInzO4kOkQC/7K
	uOYnmgag4fQB4L/p5R/46rYNXe1DKngU/JGJWxIsKQiJqnh7i9Rz2eO40/8ljyP0
	aN8Sz+9jzGXGjGJ8aY/4RZc6N9zHBZo4ytPzhMlfQ0lkahv8rs4sC1gylSLNharT
	fCaLosJ8UDvK/GZPd8RYxgkU3hZIvoJK4toj/Xx2g7krN9yLVxsThZpQ0Zm9JfQ3
	Cg==
Received: (qmail 1218384 invoked from network); 23 Sep 2025 21:17:51 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Sep 2025 21:17:51 +0200
X-UD-Smtp-Session: l3s3148p1@z4vSynw/Ztkujnsp
Date: Tue, 23 Sep 2025 21:17:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troymitchell988@gmail.com>,
	Alex Elder <elder@riscstar.com>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: spacemit: extend and validate all
 properties
Message-ID: <aNLyXhmONll14Vj4@shikoro>
References: <20250917-01-k1-i2c-schema-v1-1-bd276b366d9c@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-01-k1-i2c-schema-v1-1-bd276b366d9c@gentoo.org>

On Wed, Sep 17, 2025 at 11:38:13AM +0800, Yixun Lan wrote:
> Extend the K1 I2C properties by including generic i2c-controller schema.
> and this will enable it to do the DT validation check later.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Tested-by: Alex Elder <elder@riscstar.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to for-current, thanks!


