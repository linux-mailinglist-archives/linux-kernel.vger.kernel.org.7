Return-Path: <linux-kernel+bounces-807365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B7B4A374
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10E23AEF06
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51E306B17;
	Tue,  9 Sep 2025 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPagon1Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED02E0B42;
	Tue,  9 Sep 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402796; cv=none; b=cXSfBHj1oJ54dmLGdoVePq6NGl6sQ0RfXRgcJXaDZAq9nMxF/oR1TAeTVNzOZtDuWNRBcFJHw8mMt44yLwR/wQIUrwJhvm0s8ehm1qrSeo4BnrIpSd8hPQ58M8FINVd56kP23kzWVANC2t2NkPfGPMxeStVpKH220hVvj0RFFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402796; c=relaxed/simple;
	bh=FMl6MnUPt+s8U0LXr7EhD2Ld5pDpbdU6vJhSdd7wEQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNeX01hgkCl//U2D6YToASdiegxm/urhdTnwS9Z++H5seYwTBk610mg04xkRl4SI6zCofDMJLmLmYeqW1MasnbSQWyhn5/dltovONBQJu/1PTZn0ScLa/ds7etS9cSKcrq9940uABZhWjDZ0quqV75P9d0n6/v27hwNv7HIj/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPagon1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCFFC4CEF4;
	Tue,  9 Sep 2025 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757402796;
	bh=FMl6MnUPt+s8U0LXr7EhD2Ld5pDpbdU6vJhSdd7wEQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPagon1YevxSBPrSalRM7pOIlWc5W3EWrnS40R18g96kVaG5lCE0H8Adxz2oHIl6d
	 kTAQJmaZjMqgwtHfusSPLYwcjLC1v+W28Lya/b+9bDmKflStPzO+ZieQo5sytZQdkk
	 RSj1uEcjDWEY1Gr18yLMyyhWwIlnP0jmVmQSzL4EgQOnXAf6an47qPqqdyfaDOmIC8
	 asPPFuKHk7sPDFrfMZFCgUFJRI7FsWg09ymtph33mwM7lPee/yab1Pall69Ys0Z7Kw
	 YS5MJO12fv7izeLN7jorC5w/+6LZfG3zmnXgVOOff/gpddKdcMMUjYAX5VisOHPvWx
	 fkNvJg7x7XqwQ==
Date: Tue, 9 Sep 2025 09:26:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add MPS mp2925 and mp2929
Message-ID: <20250909-blazing-green-bullfinch-4bd454@kuoka>
References: <20250908105951.1002332-1-wenswang@yeah.net>
 <20250908110128.1002655-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908110128.1002655-1-wenswang@yeah.net>

On Mon, Sep 08, 2025 at 07:01:27PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS mp2925 and mp2929 controller.
> 
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


