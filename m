Return-Path: <linux-kernel+bounces-795304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A18B3EFA4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A4164810
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086A926F2BD;
	Mon,  1 Sep 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOrMtuok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686F26C3A7;
	Mon,  1 Sep 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758557; cv=none; b=ONyhICKIkbZCzfir1qQbH0d9Bs4uh2QEy03Y8FHnceIHubiUDXg91myXVd5INcg5mu8PMEA8ECXmIrZ4F9LRGVGUA2uWKOTwFt7rTvJjO9uMAnzozfFm5OCDpIz/j4gNmLGXCGm0rGLHoEUbXYiVOrZkUFz3l1SpgFyn6PseRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758557; c=relaxed/simple;
	bh=xIsLH653UR9bpg6VTzgFv8umlPBg//nOtGBqWRExVFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9yA+QeFvD1tTIXOjPAFqsoUyRHxsxo33JMzf860H6NBJu8rniQ1j+6gYdOZzmCMZaA3Cmu5B5pSi8xb8kxjiidSzlOTRvTme78Z69NJ9edNccVRcEqNlbfWphlJyISs8urw05D/Nsi/M4go0cI2MeXTyV+n4Um4wRJRyqjNUhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOrMtuok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E475C4CEF0;
	Mon,  1 Sep 2025 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758554;
	bh=xIsLH653UR9bpg6VTzgFv8umlPBg//nOtGBqWRExVFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOrMtuokVlRFxgVNtMVpHJEVW3oVaxoEgCPwPi9LEN42ziu6Zc5t3rAmOk0Vo91T7
	 kHG+sVCbL2AIGFI9nAY+DYtZR5qXGISaie+hM3SkCzexv3az3cWCpM4scLm9dWFcj5
	 +8gymTMSRrS5kelGB9ECeoZjR1+bJ+ewRjaqF707tQ7RR6ZHmeaMrGDvqwOm0vnBQf
	 4sTNv4KGmHnJ8Z6oM8FWTKdlhJ1iC0YaqLhjpFM4T1nxS74gBOr8Kz4JR3aoJMSODc
	 TCJC0o7piMc4+GUfBl6/DWNtubQBAaF5VlTAN5NFd6/Lenf8/HTyxgpknXugarlCJO
	 7oh15BkrIBkbA==
Date: Mon, 1 Sep 2025 15:29:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: [PATCH v2 3/4] dt-bindings: interrupt-controller: aspeed: Add
 AST2700 SCU IC compatibles
Message-ID: <175675855315.287526.6300698694684294700.robh@kernel.org>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831021438.976893-4-ryan_chen@aspeedtech.com>


On Sun, 31 Aug 2025 10:14:37 +0800, Ryan Chen wrote:
> Add compatible strings for the four SCU interrupt controller instances
> on the AST2700 SoC (scu-ic0 to 3), following the multi-instance model used
> on AST2600.
> 
> Also define interrupt indices in the binding header.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2500-scu-ic.yaml                     |  6 +++++-
>  .../interrupt-controller/aspeed-scu-ic.h           | 14 ++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


