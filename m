Return-Path: <linux-kernel+bounces-775265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4776FB2BD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657F65E59B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4831B105;
	Tue, 19 Aug 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6uz+sn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5DC26F2AE;
	Tue, 19 Aug 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595374; cv=none; b=m42olYvxsnxUMlYCX/n4eybkBtq1E3d31DtTIXDyIdB9uVLaqyTMnOinGE4Eq9ovbArUgFBRs/xy0OoC5W+y3pMcu9OKgLV6zDfwP2XWpMzl+wTzVMQbwtpTg4NltNOJc3fJsZmQDl7FBS5YI8qZFR298VuSPyRbnKobzfiGeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595374; c=relaxed/simple;
	bh=GwxaXs1snl1eG08Ft0orNQnn2SIr7D3X7ues51yX8I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjQq+NnhNimBMutu3MkpA5CuQLTBmF4Y1l/Nkdp0ZqIXmEjbDxMmZLjx/PES5VUHxfB2P9sb2oMKrAYild1op2+SdUT+vlBzweaOWRTcY8iijVR3cuDjxjC+pmV2Qut5jzvHnrFuqWVKAZqH/LWCaaANqAsUpNhqFPQ0PyR1OA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6uz+sn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9FBC4CEF1;
	Tue, 19 Aug 2025 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755595374;
	bh=GwxaXs1snl1eG08Ft0orNQnn2SIr7D3X7ues51yX8I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6uz+sn3R6IfzY+4WcFUMaOQr9sI7mvl9Ett0iZO1TwWy75EpcDfp5AEQK9j9cfYm
	 3WibzBd+k+3rFcnhcuO6d1Ru5HiLbegmeHCY2U+mDwtuu0kBsXMC2gAvxqE81L0Jjl
	 IzbL9OAWQ/WaCe/D8d9Llkmb/VqmX/zLlRFf3pYbSR2rWXLyjJbkSUQK8ML8GVG1Vk
	 R/ScYpHNeoM/FvYMoL7RIBWLc98uIe+RCKBaoxoSwUKtOX0Ki8/r8PfMGgRtbDlGlZ
	 mnKeTkZfqYCepz/AlOaU/tNaTVOTooID2XNuDm/RlZTWwbWxDxf9+5AfN83BcK38te
	 hWBNpTo5F0cFg==
Date: Tue, 19 Aug 2025 11:22:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Richard Leitner <richard.leitner@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: usb251xb: make reg optional for
 no I2C ctrl use case
Message-ID: <20250819-eminent-cobra-from-venus-d891b6@kuoka>
References: <20250819002217.30249-1-jszhang@kernel.org>
 <20250819002217.30249-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819002217.30249-2-jszhang@kernel.org>

On Tue, Aug 19, 2025 at 08:22:15AM +0800, Jisheng Zhang wrote:
> Make "reg" optional to allow the driver to be used to manage GPIO
> based control of the device.

I don't understand how optional reg allows or disallows anything for the
driver. It's really not relevant to GPIO at all.

Also feels wrong, but maybe you just lack proper, reasonable
justification. Just explain carefully the hardware, not drivers.

Best regards,
Krzysztof


