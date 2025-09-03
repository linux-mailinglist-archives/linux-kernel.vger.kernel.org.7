Return-Path: <linux-kernel+bounces-797945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07993B4178B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A921895E08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4904D2E717C;
	Wed,  3 Sep 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xgdlipca"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B92E2F0E;
	Wed,  3 Sep 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886408; cv=none; b=GjwGyCqCmgIXgJAWfE+pMfmpPrNfvBXmCnAplMhIp7Rx2BHoVbCETRM0+JqrZoGW6WSYwWO+ktoD8DQASW0JGd1YTIuuFIyJPIwZQf/bmxUiPDqz6Zn77UO979iMYM3ZcrazVt5nRCbkr5LMhaBIST98CYGsSSxuRN6fm6/hsEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886408; c=relaxed/simple;
	bh=TGZ79sVfgoqErjxaoa5Qj2DbvHGtsptMc8oz3Ay1Ogc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX9UwbD1K4gQI4u3fn2oyayBdZTs1xTonN9K4wy1hSDEo4ucyz3l9xAkiZek4yz4P7FegLj+GlL0CjN5JeVsoRyGcRSYLG2T5ZPuvoTfj6Lagh+o0GzLcaqwGgZJrtA8/14bS3DLEbIp97eWd3XUw0WquHR/pncO4NBsBGJ1ZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xgdlipca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A93C4CEF0;
	Wed,  3 Sep 2025 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756886408;
	bh=TGZ79sVfgoqErjxaoa5Qj2DbvHGtsptMc8oz3Ay1Ogc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgdlipcajUD6Dktfb3WJNpluhHlRfevXthl0RCeNQ5oTtfskHshrr+MRHWHvpf7AL
	 yfSW28X5I0N4TIMtDcOzN50m66kptmCOM91v7kw6Bgv0cLDSWnJvntwg3479n+kBEI
	 3y1nzyyKh2+1zSXlofc7fEqN6mpD0PhQm2AhAsq97vfU9rCwHko6sj733IX3nmvLwU
	 9uRTgieM39J6JyQVj96Mqd/W59PkrkRIeEajsxJIGALqKfR9mexn1ueJubJ8ijtYXZ
	 13PvXG8MEJfv0JuWHZccIvVI7agse3z7UIFGQJNwnNBkEhxUB+N8j3I3/YnWs5jf9E
	 qqZOvPPCl/FDw==
Date: Wed, 3 Sep 2025 10:00:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Johnsodn Huang <kusogame68@gmail.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, sef1548@gmail.com
Subject: Re: [PATCH] dt-bindings: fix typo in documentation Correct a typo in
 the documentation by replacing "abd" with the correct word "and". This
 improves readability and avoids confusion in the description.
Message-ID: <20250903-archetypal-voracious-beagle-fec46a@kuoka>
References: <20250902142749.13724-1-kusogame68@gmail.com>
 <20250903074205.GB2163762@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903074205.GB2163762@google.com>

On Wed, Sep 03, 2025 at 08:42:05AM +0100, Lee Jones wrote:
> Looks like you corrupted the subject line with the commit message.
> 
> Please resubmit.
> 
> > From: Johnson Huang <kusogame68@gmail.com>
> 
> Use `git format-patch` and `git send-email` instead.
> 
> > Co-developed-by: Nick Huang <sef1548@gmail.com>
> > Signed-off-by: Nick Huang <sef1548@gmail.com>
> > Signed-off-by: Johnson Huang <kusogame68@gmail.com>
> 
> It took two of you to correct the word "and"?

And this is so trivial that I would suggest to fix ALL the typos in MFD
bindings at once. For sure there are more...

Best regards,
Krzysztof


