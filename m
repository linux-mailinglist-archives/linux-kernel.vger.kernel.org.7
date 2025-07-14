Return-Path: <linux-kernel+bounces-730761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A34B04978
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633C84E15F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824AC238C0C;
	Mon, 14 Jul 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJGgQ2hm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F02265CC0;
	Mon, 14 Jul 2025 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528173; cv=none; b=Fq+SZbBPNKc5xbRMS3KDiHC+3S9rDDIOPbzlUGWDRI+A7pXqGUSVZ1Rj+WKhvw06jygTdV8uNqqxCOHlThcxYLVUC9m65/IIMxA8TX/QQ0z56s/eUiGyl/VszkIVZMJAZmbGA++PT9qoZaMnDlAcKNeC7KmCVtX74CLRxaaY8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528173; c=relaxed/simple;
	bh=Arah0/igKiTwn9B+rMSNQSwyOp9kHNkBlJp5nDEnsXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caEAw7UIZirX+Ex07RbqcuwFBD0czNPBEPWbpH/WSODbUriyjC3ENudwEXsMYBtVAkPZqKoIVYj1X/3Ufc4Ij14AtTDUyhirZoRxNptw4hLevLejnWlQwf6SGEa34Da0gEN4wr7We1xrMcT/lIsbwI/sBdsiLVzqG2UseYoEAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJGgQ2hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2CBC4CEED;
	Mon, 14 Jul 2025 21:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752528173;
	bh=Arah0/igKiTwn9B+rMSNQSwyOp9kHNkBlJp5nDEnsXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJGgQ2hmWqbO+iyfLZ6JeROwg8FK5X6NGPom9OqBgvMAN2yImVbj5lNooJPbmPqrf
	 XRK/sfIrjcMQYTdC05Do/HuGtcULhu9A36CGY/GvfGkEsMz6d/zI+5QEQhprMOcN3f
	 URAM7fIVsvMP2HjW3k/vkpayqlkXc0Nuyd6oLdKLXGwoJRemIsRUsyTNTTKHxQWXYa
	 nIQg0i6bqYmtjJ79nQoiezW1RWu670Am7Hy21E6ifIZwABpNcakxruwDpwdiwTxuPw
	 htW0LwoCk+xjCCU4E0XfE7i6zpNt1auk/o5tegadBO7RFnkS7hyBqa7dTY86tF8Sd2
	 KvMEiaBbsU0Ow==
Date: Mon, 14 Jul 2025 16:22:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] docs: dt: writing-bindings: Document discouraged
 instance IDs
Message-ID: <175252817175.3191046.3650617245959733728.robh@kernel.org>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
 <20250713-dt-bindings-docs-v2-3-672c898054ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-dt-bindings-docs-v2-3-672c898054ae@linaro.org>


On Sun, 13 Jul 2025 14:46:38 +0200, Krzysztof Kozlowski wrote:
> Document established Devicetree bindings maintainers review practice:
> instance indexes, either as properties or as custom new OF alias, are
> not accepted.  Recommended way is to use, depending on the
> situation/hardware: different compatible, cell arguments or syscon
> phandle arguments.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/writing-bindings.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks!


