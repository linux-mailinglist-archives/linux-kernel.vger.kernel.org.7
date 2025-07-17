Return-Path: <linux-kernel+bounces-735137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 127DBB08B44
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A83C18855A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747D2BDC04;
	Thu, 17 Jul 2025 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHmQglIM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4342BD5A3;
	Thu, 17 Jul 2025 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749414; cv=none; b=c/ft8VOPX18nOwvAkxxEghiOsgvo2F6LpbPN1bxw/lap0dtsp+bwHjpPNv0qCN10rddh8TAAW0l1EP7lAAfqdGOiM+Vhejn6vJ0YkjGvaZrCE1tN6dACiMhozEBzfvyXaq7Jt5N2um/KUZ+5Y0vQEe0QGn9CttvCHjQQ1njWhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749414; c=relaxed/simple;
	bh=hDOjBV4YT6b3RAQ8NLSnONEpRqZ2nMDiso747uOSaGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL0YBya8YwxLnHPKpxpoQz+2KQ+TER5Gb9bPd2gDnvyzJFXcsYghY/aDjiEG6gAXB+YB729foq3xcyw6Njn19sV8B7zBHBhwGrnOZuJzUxpwfPzS+/PNzu5BUV9OJK9ikbQPUZR/VMWPRDxmtazVBXY00fLBaRxRkC6MJ3jm9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHmQglIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA402C4CEE3;
	Thu, 17 Jul 2025 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752749413;
	bh=hDOjBV4YT6b3RAQ8NLSnONEpRqZ2nMDiso747uOSaGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHmQglIMgtIFLTii8jKa4YBbEFugy6Cwwolr3lxVU/Nz61Txj8vVVpatZRSmyuC4/
	 bTzmc5uY4MFGAzrD9NmfTM41rQAYlDhyPpQrbmo3AFkQ10QWBs+Muwi5D3c1TsVJaD
	 7oFoF3yceSdlqFL0fvDzUf31HXvJD9lDQ3rHRwxlGQBaBubJ/+87BX9ztKKEjSxIMf
	 xRDhFO8cLQijI0GHMFgMyp6p0pdkqET8Hsqx02pRt6KUsKF80iNy6SkugpKqDK7s84
	 avmoc4IDpzo7sIzWEfJr+1jcooUXobW69IudbTcXIZfFrdwZkF38fsRNterj5rdZcQ
	 dMZfrrJAd7DIw==
Date: Thu, 17 Jul 2025 12:50:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Chen <peter.chen@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, jassisinghbrar@gmail.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cix-kernel-upstream@cixtech.com, maz@kernel.org, sudeep.holla@arm.com, kajetan.puchalski@arm.com, 
	eballetb@redhat.com, Guomin Chen <Guomin.Chen@cixtech.com>, 
	Gary Yang <gary.yang@cixtech.com>
Subject: Re: [PATCH v10 8/9] arm64: dts: cix: Add sky1 base dts initial
 support
Message-ID: <20250717-arcane-didactic-dachshund-db7619@kuoka>
References: <20250717072209.176807-1-peter.chen@cixtech.com>
 <20250717072209.176807-9-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717072209.176807-9-peter.chen@cixtech.com>

On Thu, Jul 17, 2025 at 03:22:08PM +0800, Peter Chen wrote:
> CIX SKY1 SoC is high performance Armv9 SoC designed by Cixtech,
> and Orion O6 is the motherboard launched by Radxa. See below for
> detail:
> https://docs.radxa.com/en/orion/o6/getting-started/introduction
> 
> In this commit, it only adds limited components for running initramfs
> at Orion O6.
> 
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
> Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
> Signed-off-by: Gary Yang <gary.yang@cixtech.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


