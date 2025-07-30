Return-Path: <linux-kernel+bounces-751398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547EEB16922
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54C71888D73
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BDF23183F;
	Wed, 30 Jul 2025 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAeyOpJQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82C4C62;
	Wed, 30 Jul 2025 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753915750; cv=none; b=HObkhSFL8E4GeWtBE0PGZQvafoeDWLPS6ysMXGQsb1GT/oww0CxttWbB0ofaJyNYpbhKEaycT2lYeR3cUdcevxeAhBlFKYYGdC/1UeRDGeFobD63JNzSlDKsLntC+SWyi7tdZ2TV7fg5CgLoQJUPe7hpxdrubX557fej1sW2Z3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753915750; c=relaxed/simple;
	bh=goPTgnhT+cAzzQXJeVfo70TQfAPngs3iiMPdZePS5SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOLBKCiD0EH21JBfXKMGav8gsWt5ii+NpUHDikuW+U949SAadS9bfyVAToAkYu/W/Am382034HRtM9dtMaX6s4jKDLKk9thS0l5cOK4UIYBt4B+7lBMrenVJ65XxJ8ct48FixXTpHTx+7yO0TFFVqgI/S6MJ+wkgbQxXOHfOwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAeyOpJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1105C4CEE3;
	Wed, 30 Jul 2025 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753915749;
	bh=goPTgnhT+cAzzQXJeVfo70TQfAPngs3iiMPdZePS5SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAeyOpJQ+Q2LSBkhxUzPJwd9Qb/ou0T0vMIH0dfefLrsmbRvjrTB3L4kIjzWCAW7C
	 o1e3K9Oh3LcLGPeis6kaq56s2aFJ/0kp2XDYGmSARVEBNKP3kMjcCP0ToZl085Azus
	 29J1TgiUHLw7K6mthTO02S1oNl6UMFQnwSvXSGFjC4DPiO4Ri6wgfpaDP+jovYIIfi
	 apU0kdlFVWx2zGko2B/wKPfkEg70TMp0HIH7pV5qUL+89yfLvNBxpZyQQPrM0GpY4a
	 El29v90unc9+B3CQr5uX8wCWXCvfbrvoTqh5o/m9zVuhziG+sbiNc9oDLQtc8pGomT
	 7R6fdVPQ1Gc1g==
Date: Wed, 30 Jul 2025 17:49:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jilin Yuan <yuanjilin@cdjrlc.com>, wangjianli <wangjianli@cdjrlc.com>,
	Jiang Jian <jiangjian@cdjrlc.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Devicetree <devicetree@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] of: Clarify OF device context in of_match_device()
 comment
Message-ID: <175391574663.1840344.5797485398683125327.robh@kernel.org>
References: <20250730013113.11264-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730013113.11264-1-bagasdotme@gmail.com>


On Wed, 30 Jul 2025 08:31:13 +0700, Bagas Sanjaya wrote:
> Open Firmware abbreviation (OF) in of_match_device() comment is written
> in lowercase instead, which is mistaken for prepositional word "of"
> ([1], [2], [3], [4]) duplicate.
> 
> Clarify the context.
> 
> Link: https://lore.kernel.org/all/CAL_JsqLypcBCOVZ8yYWK0J_xc2Vcr+ANrX_3v4vN55Srp4RknQ@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/all/20220926185852.GA2581083-robh@kernel.org/ [2]
> Link: https://lore.kernel.org/all/CAL_JsqL4GvgFYzGUfhW5pvm4wYGrFaj6gHOYZjnOMuk2zCz67w@mail.gmail.com/ [3]
> Link: https://lore.kernel.org/all/20220627173825.GA2637590-robh@kernel.org/ [4]
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/of/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!


