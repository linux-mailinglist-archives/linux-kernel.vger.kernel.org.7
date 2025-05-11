Return-Path: <linux-kernel+bounces-643101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BFBAB2801
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 13:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F857AB56E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188A922D7A5;
	Sun, 11 May 2025 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD7pokei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE31AD58;
	Sun, 11 May 2025 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746963333; cv=none; b=rWki+OMmOCcKObrWZzzHKDtTIZKFaxUJ8OGNnELX8ETKj1vhO5ZigVrDNJs6SNiXvw4xuBePPHo30sJHdAKtiOFEB/8IcRm1yIxavNRN52cqhSgIhMUb6XL2YD6lESM/1Fxq8AZ5S/ekt8oiaypL2Vl1o3LevF7FS9gdpKXqzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746963333; c=relaxed/simple;
	bh=X+K6tacVthxZ0QhLTsQrgzj8hKAcyCblxTZADN9o7tE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jvwdv0k1KYIpechH2caZ5LuUJizTS1CPSgqfdxLBIovn2251WVrSaMLco2y9oX8ppCNDtvZN1JJF/2jEZmpq96W/uSicelFJmguDPYZbnlBTwIskeW08ehOJJmczGGvq4IJst5ukl4MKRhs9lDfk94yTEdC+/CZtoW3L+L+wFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD7pokei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A41CC4CEE9;
	Sun, 11 May 2025 11:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746963332;
	bh=X+K6tacVthxZ0QhLTsQrgzj8hKAcyCblxTZADN9o7tE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dD7pokeiuNoMqhIHe90qnFEnLcQFlVQjLXfmOq1+la0YMdQx5fjp2SwDwG9qpsA5R
	 +ktxFhSQB6iobOuwqZXcooRCYLelM+CPIC3944YOu1g0dBfD9cvLAlUXcUgV0iSqQc
	 6JRQYE6wBih+xdPh4FpFR8Gj2B0zTM5UzbJla+26D+vLdmQFOGTGJFXjHm49xnD2yn
	 MIIniUils0Dng2cMRPEZ17JC31Dt7JF8V/w6gB7app0TE5BfQg4bH1JgYds6TRGJzY
	 lxdJ0FV/9gCOUuIjahT8VvIWOpTtgD3DV+1Mz0SronAwHhkYQHJ0V19gmV3dprEyL4
	 CmVyih7YBBEyA==
Date: Sun, 11 May 2025 12:35:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andrew Ijano <andrew.ijano@gmail.com>, andrew.lopes@alumni.usp.br,
 gustavobastos@usp.br, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, jstephan@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
Message-ID: <20250511123524.3975201d@jic23-huawei>
In-Reply-To: <CAHp75Ve7-hMUxrmXQnkMjynhPUbD6R+K=-j+h0zELvcxZdy5nw@mail.gmail.com>
References: <20250509013931.47524-1-andrew.lopes@alumni.usp.br>
	<CAHp75Ve7-hMUxrmXQnkMjynhPUbD6R+K=-j+h0zELvcxZdy5nw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> ...
> 
> > -                       *val = sign_extend32(be16_to_cpup((__be16 *)st->rx) >>
> > +                       *val = sign_extend32(be16_to_cpu((__be16) ret) >>  
> 
> This doesn't look good, can you define a proper __be16 variable on
> stack and use it instead of ret?

As I mention in v4 quick review, we have spi_w8r16be() to avoid the need
to have this dance at all.

> 

