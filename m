Return-Path: <linux-kernel+bounces-834600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC62BA50D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788C33835B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D011270EAB;
	Fri, 26 Sep 2025 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/WnWIdF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36971F5433;
	Fri, 26 Sep 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918000; cv=none; b=RU7Oc5PxEd0AY/yeRepT3WDK0qbCWh5lDVmQg7dz8SiRcMPhFZffWlvXHEmvi1Baxe7zUAz9o52s63aKl5f1m7v2qMIpoI8tPKuf26vOVZl+sVBuQHNfFqukig4HUPW3cbxZ7InhJ9thqH5eY25YXojBcpUDlTR9IWDWwsJAiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918000; c=relaxed/simple;
	bh=OgHQpnso+b9N7DZ57inny7a13zia9q3Gs6Rqhh9Tz+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3zOwhWGVYYOV3NFHoLYqlg7i5T8dsAs2xq2xBwAy0Jg3GKTQ9+EIQB4c4Rt1ABWUELyM/aQ9nw84RmT6ST6tHPpOwIoRoy5369iuZIn69xgTzIB3k5WM4H/JhL52jalNtL4WuqIuXIQmhsOFpDW032JWPhheR2EpTJ1NDD5HFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/WnWIdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E9EC4CEF4;
	Fri, 26 Sep 2025 20:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758918000;
	bh=OgHQpnso+b9N7DZ57inny7a13zia9q3Gs6Rqhh9Tz+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/WnWIdFTtD8iGjz6FIeLdR58df23/QtVuSHlupYKKeyiPXkB7ubQPau+PeuCJsV2
	 jd8W0fZa9J6UPMfEV6BxhS72z5ZjKaO6VkOxOee/02zXawuBI9JxJrvVumtnCK5gH7
	 aO1jvVizBwtjTfD4zZSFzmwKNoVs26jyiKQDe09eSMW9937KwAQULf6UJ2VbuerFyi
	 JA/LRFp7HFzZ7yfcB2sgb9dGc1pfw/vCrrmNNcdIfFpUz+Np469yoacNw/gqu1TNI/
	 dPcyZmGr7UdBYVZfWPs53yFkMVSq7Gyek3912/wHWeqCKzeYnbgwUNIU2rtNECzG6J
	 lgwrBSdrP1K+w==
Date: Fri, 26 Sep 2025 15:19:57 -0500
From: Rob Herring <robh@kernel.org>
To: Markus Heidelberg <m.heidelberg@cab.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Spelling and typo fixes in devicetree documentation
Message-ID: <20250926201957.GA1425792-robh@kernel.org>
References: <20250926105749.209674-1-m.heidelberg@cab.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926105749.209674-1-m.heidelberg@cab.de>

On Fri, Sep 26, 2025 at 12:57:46PM +0200, Markus Heidelberg wrote:
> Markus Heidelberg (3):
>   docs: dt: fix grammar and spelling
>   dt-bindings: fix spelling, typos, grammar, duplicated words
>   scripts: dt_to_config: fix grammar and a typo in --help text

Applied, thanks.

Rob

