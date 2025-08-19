Return-Path: <linux-kernel+bounces-775268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CC9B2BD65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF1A1885293
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E327B31CA79;
	Tue, 19 Aug 2025 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH/U+KZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0831AF15;
	Tue, 19 Aug 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595477; cv=none; b=iYpZnLs2f2YiJajqxkTxMEiXYAmn0KnMx2aSCsnlqic/uXsHSO1p0L7v6ZKcBcpJx5PYxSrgPiifhuauSvMIPU/GiKRCVLahoxCIIhxvzL4ewQljZxHP/HCYKW29ExC1nCDl7sA8mWpG6k+q0jN3nAlkg3lmU4giuj2K1T4xOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595477; c=relaxed/simple;
	bh=6yI+GddpfBo8Px3L/iMitPInlj71gG6GsZHQBAkekaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHBsuT0mrcSDvoBopimEa+0n6sHGZSRXSxIvPY8uUmZ5y+4km92+1lou8Uxcoio4UKoRU/3G6uETC2RtmxUUbMP9Ce06Z2wvxKuoxPx6BgA9/IwAuY7yvevUVnDZgGvwFGglNu8fR0MX6zzqWyjE2epz8BZORDDhe5unFuSB2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH/U+KZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEE8C4CEF1;
	Tue, 19 Aug 2025 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755595476;
	bh=6yI+GddpfBo8Px3L/iMitPInlj71gG6GsZHQBAkekaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vH/U+KZxQLBjH2Ov6fRgbYpEDy3ETcmK3FVa77si8G3uQyhZLbM6d2mhC0hYZOYOk
	 Vt80DqRA+LbkfWvtkEMeAtYBSt4V6ykra09WOGwO+WHR7BTx6D0uh2ykj+1ior3FTj
	 4TdnateEk0pspg4169TJVzEW+OrZgAzBzW79NaWBuLQ9hYrV+YTrXSh4/BOEG4Zd59
	 1CitGxlNJpO6uw6NHW+fjWY0c8LJHpHaM/FcNW9c1dPZtfBi2PoNQhAxIb4z1rMUqt
	 m5NghiBEQW5wXxTfF3XjcAGrTQ58+kLsDr8QrgRcyewrx2KgZTDr2MDtoohQgQO8zw
	 jVRtwy58MjDHQ==
Date: Tue, 19 Aug 2025 11:24:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Richard Leitner <richard.leitner@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: usb251xb: support usage case without I2C
 control
Message-ID: <20250819-shrimp-of-weird-efficiency-39bfef@kuoka>
References: <20250819002217.30249-1-jszhang@kernel.org>
 <20250819002217.30249-4-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819002217.30249-4-jszhang@kernel.org>

On Tue, Aug 19, 2025 at 08:22:17AM +0800, Jisheng Zhang wrote:
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(usb251xb_plat_pm_ops, usb251xb_plat_suspend, usb251xb_plat_resume);
> +
> +static struct platform_driver usb251xb_plat_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = of_match_ptr(usb251xb_of_match),

No, drop of_match_ptr. This is neither correct nor helpful.
Look at existing code.

Best regards,
Krzysztof


