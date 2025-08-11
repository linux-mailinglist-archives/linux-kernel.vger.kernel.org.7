Return-Path: <linux-kernel+bounces-761892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FF3B1FFAF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A51189AFE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916652D8DAF;
	Mon, 11 Aug 2025 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjVqq5E6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3461509AB;
	Mon, 11 Aug 2025 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895412; cv=none; b=FgGKI84RCt6RBvG7sSxUMJvz45TAmHdWFcbmeN7Tf2/ALbYCrdThXs7fMQJHXZuPEOXy2wQlRsmtBD6hmlvhgWgkXBDMYPu+tQuXjYyYVeww8UucgfzTsB1coLUBlHLulaPyJ2TEhCeHk6si4bSSRiEdFbQmruc+TK8sjL2R3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895412; c=relaxed/simple;
	bh=NASEFLahtizz8hYjdKKVVlrTZn03FNi3PX2ZocIcjGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWlESUSxfUT6AiKGiE6jtwBmLrUBKhN0bVU8W61CUIUZOBYMh6DQbDCbeCTUyYW5MgTTrHEOVq/UhrbXfpw9FZdE/m3OCnRipr2s4ObpY+7HY2YmyFByD44NCXZvpU22bnG328pQ73G23LKJACFlNsNLEww+m8aa/CF93eBJVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjVqq5E6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36278C4CEED;
	Mon, 11 Aug 2025 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754895411;
	bh=NASEFLahtizz8hYjdKKVVlrTZn03FNi3PX2ZocIcjGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjVqq5E6Cl28VGfZd3j8GrYFnckBeMgMBOk9BR3eey5plCCslOl05nOE/aMdPK5cM
	 cxq4CcL6bF0yZjLwxPP1X33orcLQlc4eQAN+Lr14r7cdoTpt1D2srZYZdm4WOvuE4m
	 LikZZd4SNBTJyugaPX0aYU0lVv+6fS9hS/dejDuECtEipdDWFwLCrUuX+hqoxU6YrH
	 WbBpIBSsUlwk08EwrENAO1E57EUJTcQrepIADiGU0TmuVD/4TQm+UCpFc0xphBKDYf
	 V3LnVIOHH3HkfcCm0Ih6eCh3/1gBXuknH+oZx0ZsT35RnJ/25H6k6eoM7FFcbO+m9n
	 q2ZUawcMqLzrw==
Date: Mon, 11 Aug 2025 08:56:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org, 
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, broonie@kernel.org, lee@kernel.org, vikash.bansal@nxp.com, 
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
Subject: Re: [PATCH v3 1/2] dt-bindings: i3c: Add NXP P3H2x4x i3c-hub support
Message-ID: <20250811-clever-stingray-of-will-eff27b@kuoka>
References: <20250808132033.3996614-1-aman.kumarpandey@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808132033.3996614-1-aman.kumarpandey@nxp.com>

On Fri, Aug 08, 2025 at 04:20:32PM +0300, Aman Kumar Pandey wrote:
> Add bindings for the NXP P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841)
> multiport I3C hub family. These devices connect to a host via
> I3C/I2C/SMBus and allow communication with multiple downstream
> peripherals.
> 
> Signed-off-by: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
> Signed-off-by: Vikash Bansal <vikash.bansal@nxp.com>
> 
> ---
> V1 -> V2: Cleaned up coding style and addressed review comments

Which ones?

You must be precise here.

> V2 -> V3: Added mfd device support for i3c hub and regulator.

Still not tested, still fails. :/ I will not review this, please reach
to your colleagues in NXP to explain how to test code before sending
upstream.

Best regards,
Krzysztof


