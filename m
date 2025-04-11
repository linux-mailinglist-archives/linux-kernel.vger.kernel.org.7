Return-Path: <linux-kernel+bounces-600924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DACCA8666C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 21:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087864C08B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 19:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F37427EC73;
	Fri, 11 Apr 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzMa0wfy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054221ADBA;
	Fri, 11 Apr 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399887; cv=none; b=BIgs097zaFWzUktV8OssSd5PYfbX9FhyIXvb5R0qUMHotRMeaNnnTwp1Z+XN9ZeoDNX09PsQ4gZhvYX6OMmICB3iiToLgKr0wy5S0naHz/Deyd+gln8Rr9AFaipS1DpsELy0nmt8zinAefKassi/X/hBHvtYMSb9QgNGgFUg0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399887; c=relaxed/simple;
	bh=Knhm3UOFxSkCDXktQI1zceo9S+kIuWW7MBbrlc9K6MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYbAq9McfHc/fHqyb+33Ft1SJ+/lFl8hfcEwiCDihoJPKasbFi8UG9GdnJ/Fsnvgllt2D1iDT11uKsFNxLBnSIvI3LrnNnhMsEbnggtzUsApV4fQPXMTfMxR2omgiEiv/otwLN2VyZmMKXyF5+ajXAR/Pw5VbN17ubazWkuVbxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzMa0wfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACC8C4CEE2;
	Fri, 11 Apr 2025 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744399886;
	bh=Knhm3UOFxSkCDXktQI1zceo9S+kIuWW7MBbrlc9K6MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzMa0wfyWTuInrAvHZymR3+NiuhbGcOL2wGf/MXwSl/XvrGIuMxGfZ6ssEaBGdwsW
	 MaEMzlC3hDqM129HSi2zgqBm/bc0/WVd+QKtRP0xbxx5f7mzxQ613+DnCM2VGTUAx/
	 bsKKZnc8PgaQ2GKtLXPjk28NSyrfXLKL3JHorry2UwQ2+vCb6PdjerEZG0bzAQi9rb
	 TJZNSS//qUu7olFffo5O6SZi+nt2eSNMSWefvm5ESxCuRT+3nw7D5BwPtFnx+VtTwZ
	 H5lAGNxu3HTibP/E7TZm/Gp/6BHV70+kXpil+kHnj1Txg5VAr/Il+6nV6EwOBzrUMD
	 L+J6X0D6m3BvA==
Date: Fri, 11 Apr 2025 14:31:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Patrick Havelange <patrick.havelange@essensium.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: counter: Convert ftm-quaddec.txt to
 yaml format
Message-ID: <174439988214.3766200.11741750771566266668.robh@kernel.org>
References: <20250410222509.3242241-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410222509.3242241-1-Frank.Li@nxp.com>


On Thu, 10 Apr 2025 18:25:05 -0400, Frank Li wrote:
> Convert ftm-quaddec.txt to yaml format.
> 
> Additional changes:
> - Remove "status" at example.
> - Remove label at example.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/counter/fsl,ftm-quaddec.yaml     | 36 +++++++++++++++++++
>  .../bindings/counter/ftm-quaddec.txt          | 18 ----------
>  2 files changed, 36 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/counter/fsl,ftm-quaddec.yaml
>  delete mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> 

Applied, thanks!


