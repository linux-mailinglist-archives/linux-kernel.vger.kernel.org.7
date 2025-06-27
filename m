Return-Path: <linux-kernel+bounces-705938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6DCAEAF7B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 09:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C8D4A51A0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 07:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67AC1922DE;
	Fri, 27 Jun 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPlmnBFl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE7BA27;
	Fri, 27 Jun 2025 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007634; cv=none; b=bjjcs8vqOlWfpR3Tc2Q/pQwYdkI2UYvzWo0XDsbhB+U9veQTH3o8IvxZGyJ4sFL0Zg1RPQNDB3srRuBv+8bsTlZFttB6CugtToz0C7uyWUCNWdRYfAPpVbR2lrdBRCaH71Ad0mUBV2DWvphYTmPSeudPNXsxlhEUDzB9tY99ao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007634; c=relaxed/simple;
	bh=2Uk6mPLluwOGTpyaSNA8mE4z75MK59plAzgVuBSAIJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf42wvKnTvpxkTbKC+Mf5M6HD0xdo4sQ2TnW1X/t99MOD5VZRhRZ9z17sSDg42La/5qZzJTVAC3kJxrK3Q7/CnMyGHiH+YUQ52faWaK+bplZdPwepOmE3BFNutOUYvZmrbdzmlMSfA1+MB7IjE4AKDScSD0TsNV766s0UTp2IUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPlmnBFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4F5C4CEE3;
	Fri, 27 Jun 2025 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751007633;
	bh=2Uk6mPLluwOGTpyaSNA8mE4z75MK59plAzgVuBSAIJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPlmnBFlKtkL68K7UTMLDKSF2L3+BrpBxHEC/wc2OKDzTpGBqVXnSnK/TfYEHNsFL
	 ovV7Jj2Me76edKk5EVcbp3YdUDhKxrmksObBMW6m+w8sFWO62FkHxQA6QCXHrtWEhY
	 FR0CQZgCyzgMYXzjnhhuGoc3XsnRjwYZIna9+GDzLtmc13KExsjUldUTh4I4XXV/6d
	 8kUfvWRCv8HpCh0xjXMEs+MqikvpEr58IavaEPEctgOexAckVTsfV0tUERIte3t4IV
	 ZGK6AygZqDueGEwAJ0bZsxTqs3LG9RenKfWXKj13vL5haKXqAMI7RDrODv9ob70UpH
	 rhQM+nWdK1M4Q==
Date: Fri, 27 Jun 2025 09:00:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Leo Wang <leo.jt.wang@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
	Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: clemente: add Meta Clemente BMC
Message-ID: <20250627-banana-falcon-of-jest-c0a8ec@krzk-bin>
References: <20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com>
 <20250627-add-support-for-meta-clemente-bmc-v4-2-ce7ff23460c4@fii-foxconn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627-add-support-for-meta-clemente-bmc-v4-2-ce7ff23460c4@fii-foxconn.com>

On Fri, Jun 27, 2025 at 10:59:03AM +0800, Leo Wang wrote:
> From: Leo Wang <leo.jt.wang@gmail.com>
> 
> Add linux device tree entry for Meta Clemente compute-tray
> BMC using AST2600 SoC.
> 
> Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>

Here as well

Best regards,
Krzysztof


