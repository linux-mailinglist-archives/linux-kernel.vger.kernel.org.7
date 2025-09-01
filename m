Return-Path: <linux-kernel+bounces-795303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 120A9B3EF9D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8C17A59EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656A26D4CE;
	Mon,  1 Sep 2025 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpaO8Y7r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6B4207A;
	Mon,  1 Sep 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758534; cv=none; b=D0jed1X26vnqHoDCdjH/Q7gPQxfT7u38SPSVyNKTs4AOIoX7FvXls+kHCtEY541f0nvRYd6l4Vt/eH6jGheOEB0kztcaQZmYStUimjoZdyHKYpiYkU4Flj2AF7M9xHKwqqIZCZGMJ5qK+pe6VOQB9jpHJPUHbUEl9A2FNqO7JVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758534; c=relaxed/simple;
	bh=7SiV0tTtklgBoJZ9EHxvqC7tkNgTkPNI3eeQVyIYD7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPBhpq89K+vDyo7/BbZcwKTLPGzZYNRPxu3yf1wJK/x+BRae+/mTiUmqx3WPRq/jFr5P9PExQ5hbI22KNickcut2spNXr0mfIRzvRY0sILXB8x17fhGInXWnE/nHXc8pmvTYXgAgO84bZnZzFOB9HY+0fbf/9uA+ePdtu80z+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpaO8Y7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C1BC4CEF0;
	Mon,  1 Sep 2025 20:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758534;
	bh=7SiV0tTtklgBoJZ9EHxvqC7tkNgTkPNI3eeQVyIYD7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpaO8Y7r/l2VpKEAiBebCAMBitJO8bHZBiPh7MnlkhZjhDdpEo6qcWS2ih6fA9COa
	 T8BTXcARrPB64lBZyYp6tYd8q9wlS9KUMU2d6M+T5Km2wTnUUHKCgmsMQ5OYeaWJT0
	 ccM8t3mcujTClSNG+d9WA3SO5lPVLQpzhNvkDbVm4YZIARDg15XfXDeRQfbCoyXKDA
	 yIjHSs68+I1ys36G5ZKwGm2+0J8z6hRDDw8JWm1ECVXJfp5DYdv7KRgtCIL4uXMa0b
	 nct7Q6Twa7Rk4fAS4wS7q0nYKiUrU8q2c+ErKtkKShrfL+UNuC6RM5INg594m+B32t
	 faR+1xtMYTCKg==
Date: Mon, 1 Sep 2025 15:28:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-aspeed@lists.ozlabs.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: mfd: aspeed: Add AST2700 SCU
 compatibles
Message-ID: <175675853255.286945.13351927869745277477.robh@kernel.org>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-3-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831021438.976893-3-ryan_chen@aspeedtech.com>


On Sun, 31 Aug 2025 10:14:36 +0800, Ryan Chen wrote:
> Add SCU interrupt controller compatible strings for the AST2700 SoC:
> scu-ic0 to 3. This extends the MFD binding to support AST2700-based
> platforms.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


