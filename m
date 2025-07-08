Return-Path: <linux-kernel+bounces-721968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E17AFD02E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F181883D27
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E72E54A0;
	Tue,  8 Jul 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+LJ2Edo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507652E5434;
	Tue,  8 Jul 2025 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990917; cv=none; b=t1zDO4GFUP8XmUdhTVNhUwVf9UTNTwnxuaNZrU1TmsXu39TTBILMWhn0cPCdXgN/0J+0857N8fMpHhDQ66lOq+7RBZpI0cmtEPBcdpbXkn0DelJXT/wHUDOHw3brqee80E/wpOxQtWUoDVz88MTarC0HD8vz6exHSbH7qoqy0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990917; c=relaxed/simple;
	bh=QBTLFLLxhUFAfscAGxdFP/ok+pKAvAu2bYu5mW3qwzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbHbWg6HMvnL5GDZ1Nckiu9QJNy+7ShlJP8xDlo+elMb2oCDwNK/44vprY4pAwAB3Wx+0AJT7MrvagWJeTuJWgxmq0qt8piD8OwghIt56nFLcU8Wc0ZZiS6BL/i9GyU9RQI7oLynLMwzhXTVrjmGvGIAauApr7Netqw4f8JpVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+LJ2Edo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0936C4CEED;
	Tue,  8 Jul 2025 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990916;
	bh=QBTLFLLxhUFAfscAGxdFP/ok+pKAvAu2bYu5mW3qwzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+LJ2EdouAD/4xOTwU7lRUtmWU7zj/FuQ/UtIh3caLTa8r0NTSaz/IdxYyiEnDQPH
	 JBnYcCWY+WbYDzD1EEQIZsEYtT0S4iEE48Kcu/UsfOf96YPHngTfdBrVXdJiUsdRe6
	 GEhJa7CSBA7ZGD4SZaMXXPaX9IJBHDRti5zLE+ezpOUnNw4jdYtce68S3tjFcB9/g5
	 Nb/C7U+X7XMvAqpJ7S8jlPaguPEhiQ6IT/4c3/T0FrOFuAxmsaCsMGfRUkRX32xT6l
	 MeDe9LRoQeg8I11T6VV99XOIp/ZGG0ki/r06uXnUYtP0j6+F2TKzxvWPAzIU/obT1q
	 VO0pNFimGLXlA==
Date: Tue, 8 Jul 2025 11:08:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: marvell,mmp2-usb-phy: Drop status from
 the example
Message-ID: <175199091400.508698.18446134330656414688.robh@kernel.org>
References: <20250701063636.23872-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701063636.23872-2-krzysztof.kozlowski@linaro.org>


On Tue, 01 Jul 2025 08:36:37 +0200, Krzysztof Kozlowski wrote:
> Examples should not have the 'status' property and 'okay' is anyway by
> default.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/marvell,mmp2-usb-phy.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


