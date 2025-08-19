Return-Path: <linux-kernel+bounces-775593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92AB2C11C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602611BA6BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BFE33470A;
	Tue, 19 Aug 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5aCQ/Kq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04B32C31C;
	Tue, 19 Aug 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604103; cv=none; b=bABDp2UWyAniaE8Lq9wbI05zbd7jif0SYKOWVMep8Fmz0UZ0ceKjyUuTjzS04VY2QQ83OLqOqiakoyuX81gBZ4VYQqCbqPjBUzMW1KYoOukp6GzJd1JPN6HWjy//y3RCEGjhqcbg8kXrxGuOmlILPVDKQapM7ZqsyvU7pSq7c54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604103; c=relaxed/simple;
	bh=kK494ULd0FaqUhSjJYz7AcYCn5SJUR6HSRFGqIrWw6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ungS9XRLAkIFuxBinXiLkMiaBo5wuq+FWIVdl4R37LnrGGIVnnqUegKrHegiCjkq4WHjNAcZxhqxx8UykCOVNGx2+4EMIhEfG7q8hzk6Zd+JvBsR7M3S+Q8n92S4uG1GqcLqb5skMuWISzaoHTwXgQXZdZ7/k8t/0YSZc73HOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5aCQ/Kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA7CC4CEF1;
	Tue, 19 Aug 2025 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755604103;
	bh=kK494ULd0FaqUhSjJYz7AcYCn5SJUR6HSRFGqIrWw6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5aCQ/KqYRNrdXC8wx8LBSO/6BmDsylC64A39uv+l04MKM77Of6zuuRFMqnJ4jz1K
	 QlIvn+Fz/+A7x+TRdqRFQTPklIQLQAXWZcJqQVuqGotceDheTuj3SkyyjznbVlQSq8
	 7Z2AuiLooffkNLTStoKkVVnADcbQQB5WHISy1U04Srm/6hZfUvTPRbseAGTePd2zIn
	 ZkeyZBNN0ON3E4xC/JXz5xLqKs9z/rZnyDM0JgIW9tX4GIkMQR9yXSej3wQyVJIo7B
	 MI9jJD0aTOYZLG/nzGPtEJKSlEpElPFYMqrJtq+9j/RCoP8glBiGvW0QDCqf2dAhIV
	 GJgXGjrR9wr0A==
Date: Tue, 19 Aug 2025 19:31:08 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: usb251xb: make reg optional for
 no I2C ctrl use case
Message-ID: <aKRgfFpF8thM3vjr@xhacker>
References: <20250819002217.30249-1-jszhang@kernel.org>
 <20250819002217.30249-2-jszhang@kernel.org>
 <20250819-eminent-cobra-from-venus-d891b6@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819-eminent-cobra-from-venus-d891b6@kuoka>

On Tue, Aug 19, 2025 at 11:22:51AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Aug 19, 2025 at 08:22:15AM +0800, Jisheng Zhang wrote:
> > Make "reg" optional to allow the driver to be used to manage GPIO
> > based control of the device.
> 
> I don't understand how optional reg allows or disallows anything for the
> driver. It's really not relevant to GPIO at all.

w/o this patch, then there will be DT check complains for the following
usb251xb usage:

usb-hub {
	compatible = "microchip,usb2512b";
	reset-gpios = <&porta 2 GPIO_ACTIVE_LOW>;
};


> 
> Also feels wrong, but maybe you just lack proper, reasonable
> justification. Just explain carefully the hardware, not drivers.

It's simple, the hub allows usage w/o connecting to any i2c, see above
example for reference. But current dt-binding make the reg required.

Regards.

