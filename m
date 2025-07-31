Return-Path: <linux-kernel+bounces-751434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1F9B16998
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5EB3B6982
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5750D376;
	Thu, 31 Jul 2025 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGSSxuxi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362110E5;
	Thu, 31 Jul 2025 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753921155; cv=none; b=jAMf4vQIuY4os6f4fvzwO1xwnIpI2Yk9XYQZOiwHscH5yl5c9n3QDcwuapBfMMOmZJpusXxqYlN5oiD10NhsunbkNPprEqhZPLl63MfcJ+0b1/hLaIQIXqsnP0RaQhnPFoNdgK2PcNO9/X1Jp1uHk1r+BzAQEhX9+INJKbm9nvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753921155; c=relaxed/simple;
	bh=gN8wjcfs91bNdmMm2grqpp8HwY8u5Tv+8PzPy21WnWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+H1yjlvznVs4VxUIW8MZuXeJQwEUNvyAGj7COn6/33ef7UitVQyCY/7xXmiFBHuLPEdQkmPxPLlrjImiMeC/2K0MI3jPqYQr418wS1DayhV3b4TGqoUhnUjJiJSXeqKEDdWrWaQOifGCb3akmNRXWRmX+yt4vLMaXyOyKhJyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGSSxuxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18779C4CEE3;
	Thu, 31 Jul 2025 00:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753921155;
	bh=gN8wjcfs91bNdmMm2grqpp8HwY8u5Tv+8PzPy21WnWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGSSxuxiCVtMT4VSFmwr+bMDudIXQ26ymcdf/iS8mD3oZKBrJq7ys41l5f3Gu8NUX
	 WdJj0psuuTSmlgxj50tKDIY4Fzc+OsbMGLD9c7yDoBPV1yDuWLX+IVPfuK5Fvdj3N+
	 xA9iOLLn9sP7oYjd53w710s2FpjsyrbXPwNBcMGvXssyxGrXDzQYCkJMzPDrxwYCD/
	 zuOjTdty3G5vuZDCsPlkSigZYOEFGIBqcbKchYAxpJPdELZmeo7ncBFBXbWggVS2ao
	 Z2Jqs1WwjTL2dJ1DcXBSyb0HoDP45l9wPcvKT4ieOQkIaQV6pEB5C5GfJuVxd9xoMr
	 xd8PwSdioHFUA==
Date: Wed, 30 Jul 2025 19:19:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
	lee@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: qnap,ts433-mcu: add qnap,ts233-mcu
 compatible
Message-ID: <175392115402.1943858.14811377799918112041.robh@kernel.org>
References: <20250730173423.1878599-1-heiko@sntech.de>
 <20250730173423.1878599-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730173423.1878599-2-heiko@sntech.de>


On Wed, 30 Jul 2025 19:34:22 +0200, Heiko Stuebner wrote:
> The same MCU is used on other devices of the series with a slightly
> different set of features, like the number of LEDs.
> 
> Add a compatible for the MCU used in the TS233 variant.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


