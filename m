Return-Path: <linux-kernel+bounces-814790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94BB558CA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0A91C87DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385A82773F4;
	Fri, 12 Sep 2025 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="LOsddw8U"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59D274B44
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757714562; cv=none; b=d3MNk6ygCnRnK0smiuiwHU/iUL52hU/JpIRon3S+RuFKEOMeIpwP9G4BM/JnLZqlgvRitUwXP+DE93I5iKRwcMP3l1IlERZpd+Jna61fHD6pBAtfv4fJHVsomlvHUNvoRvWJ04Cgc8vs3j7FI2wEMWs0n37YpU4iNj27H/HxgBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757714562; c=relaxed/simple;
	bh=migYwaWcEFkXceb2jECsqJx9G0HoIYJqzR5emfUWiaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEFzbqeMbOTQWOhrPT9pdCJYdBwEKNHK4T70yJoPjlo1Jd6dPAx7KR4zRE381yk6UMrbvQKK4L/chSy01n6B85j6oVIzf4kbOI4Nrh6ki7EQv4Y9rk+VjM7zewxpvC3CR/c1hhligbJEzSG9d9UBf7hrrlttzwuXJzVfTvs03iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=LOsddw8U; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=VVaK
	ksK86+6l/now4jDnqJzPYXz3j497f5eBLemjxh4=; b=LOsddw8UblcV+2BcFY7K
	C6pwglAK4IU5mARj0LqB/qM0rYFAzymBL3+nBDSNXMINkzuZ8LyXyshghs4lbPFa
	3BQxPFsePOXS1J8ZOwqLlgY3O16rZTUnivjCCeKCLrQPg89N7za/6ULgBiWZbK60
	VzxBFy9nvB0M7Cfaxu3HehYPNaXzpyAJpzlkW2WS6J3j0DzfaM4wkz/T9ehAGo5n
	b+dGKK1PWojvovLGDQ6EVMscBCLJ+XssKYLEwfPzDH3Vt70Hn8J0ycX4YGiMVohc
	pPt9KrYw1jeeyomkBB/wh2z05g+h/sLmC9Q3+qnik8yzxhbpeJ3gW8OBnm23V3wc
	MQ==
Received: (qmail 1498791 invoked from network); 13 Sep 2025 00:02:38 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Sep 2025 00:02:38 +0200
X-UD-Smtp-Session: l3s3148p1@eVTez6E+apsgAQnoAHJ8AC93OVDMgFWg
Date: Sat, 13 Sep 2025 00:02:38 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 7/8] dt-bindings: i2c: exynos5: Add exynos990-hsi2c
 compatible
Message-ID: <aMSYft5jCQe5iYdo@shikoro>
References: <20250907-perics-add-usinodes-v2-0-58f41796d2d3@gmail.com>
 <20250907-perics-add-usinodes-v2-7-58f41796d2d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907-perics-add-usinodes-v2-7-58f41796d2d3@gmail.com>

On Sun, Sep 07, 2025 at 10:13:38PM +0000, Denzeel Oliva wrote:
> Add samsung,exynos990-hsi2c dedicated compatible for
> representing I2C of Exynos990 SoC.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>

Applied to for-next, thanks!


