Return-Path: <linux-kernel+bounces-892534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B434FC454C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F7513467E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975BC2EAB61;
	Mon, 10 Nov 2025 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNwblf9k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962E233149;
	Mon, 10 Nov 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761862; cv=none; b=MbHcS6c8Ro4tG8s/tVS80i66L861fiB0uqIAIvtYa2KNUJHX7j7QA7mDzWrATdpPs9HtRh3BXCcbPq43PkC4L+ddzjCG2aWKuaaw+0qYSg1aQRNmqYGsl8k42hhvF8rLds2tbBWLLlGyeC6RvzW2Krqcrl7pHFi/mPwrMtIV6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761862; c=relaxed/simple;
	bh=sm7lKsYQSj240hLyDGyoHHmqQuPH13OZrQ0UGfTRIdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxCEeU5o+sMvzoPGdye9gbJVVlxFwsapHr6n/PO+BYUnL9C8azFyz3tGVejOCEhKVTdXX+E5psZGwd5G/LUJe0IcHag5HZefKqNaZZERwSZ3Uv57NRxjQJcRtN+uXxtXq8hzpLVtp72r3RJbGTWHo40FPPPz8YuVf294J3j5tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNwblf9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEC4C4CEF5;
	Mon, 10 Nov 2025 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762761861;
	bh=sm7lKsYQSj240hLyDGyoHHmqQuPH13OZrQ0UGfTRIdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNwblf9ktrEm5AF/sXmoCAMsfIZgK9ar0GmxMyEBA+gnYrwDgOuoo4MWpZOSOq1oe
	 Vocp91SIN7OGMcj42Xukbrky2AHLBhe9GWzLZ9hvmQeF4+ns4LNkqAynGjRDBgHuGu
	 TZFY0EHeFxfUmpqaLnL/47KMYzktVnPAu3vVc7IkH4w5ALmOB1n/ancBENQ1EAZR8I
	 7yON1OpwGGE9qAG+MjjRyFobSkeXz2rpFR9lka3+nYjBx4JkmJ4YMQ319RQnfLiD+K
	 sajtGat6eFHsqMnBbuWQ+W4R6ggcGjtWElH0HdqUuW84+r2vvrRgh1hVCzUjg0DT37
	 ptD+3X3zhz3vw==
Date: Mon, 10 Nov 2025 09:04:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] riscv: dts: spacemit: add Gigabit Ethernet and PDMA
 to OrangePi R2S
Message-ID: <20251110-brilliant-spiritual-hound-048ced@kuoka>
References: <20251109222858.3085488-1-michael.opdenacker@rootcommit.com>
 <20251109222858.3085488-4-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251109222858.3085488-4-michael.opdenacker@rootcommit.com>

On Sun, Nov 09, 2025 at 10:30:09PM +0000, michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> The OrangePi R2S board includes two RGMII ethernet ports
> supporting Gigabit Ethernet operation.
> 
> They have an external Motorcomm YT8531C PHY attached,
> the PHY uses GPIO for reset pin control. Their description
> was reused from the DTS from the OrangePi RV2 board.
> 
> Enable PDMA for the SpacemiT K1-based SoC.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> ---
> 

Squash the patch. You just added this board. Adding board is one commit.
Why adding incomplete or even buggy code just to fix it immediately?

Best regards,
Krzysztof

Best regards,
Krzysztof


