Return-Path: <linux-kernel+bounces-889888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5AEC3EC41
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AA194E0627
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F53830BBA5;
	Fri,  7 Nov 2025 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuRf2HUU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81EB30ACEA;
	Fri,  7 Nov 2025 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500949; cv=none; b=AhqROGR2grzpKumYr9HMDWj5hGa37M7TejN4W0YxURLg+HKjTDkwv7lykPvGkL6nL/e4ac2L4n+BpBmCsc9TaZ/MDBfrEG3PHGYuGtub3wGN4VgzD6tDIM3dSF34rX59MyMz5juTDUG/ph7zi6F9i4HEjTO0LyLxtFYbiZQoqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500949; c=relaxed/simple;
	bh=S+9jgR0gLcX7zeS2sNqAiZSSiCFj0wAjTaZG4yrgN2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrUgqCYYzw4fJvsMVZ5ggPbA2cZyFU4exYg0iyJUR1II9RVOr2aZk6mqWMyRcpNVgZZJ4kRQGlGKkZHyXCnpKhLIxm/F4vUPsEb9v30S+q8zzKA9nQ77Jm9QRkUUnDa6PwYwX1WXhPHk0CnMCdlAx3hv0JqhQukjYh2Z1glE6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuRf2HUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA0EC116B1;
	Fri,  7 Nov 2025 07:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762500948;
	bh=S+9jgR0gLcX7zeS2sNqAiZSSiCFj0wAjTaZG4yrgN2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZuRf2HUUBXRVyF7nxDv2yk7pgRD0vS3lVOXJxOU0r3VU9sUfdvptmu7EDHG99pk33
	 cgvfBlQuQ1ryzT8bVTApAgLD2FOWPeG28FesBdtyvHaJ4+Fsmf499+ROCA7RRCavLw
	 NyhG7T3UD0DF3qvpQLUTYU2MLPwjmt4lYsKMOeZp6b9Jc6e/k8hSZrqYkwkCkmZNIM
	 cKU7Zn99O/DgIR+kE2QLoIchKLHlyda5IwHk1dD6+a4zY+5njuCa2QvPs1pRnoZsiw
	 umQmXE0zgYZinQ3n26TXbhj17UPCJuKRRTZpNgwqBpLyk9gVZcMZVhXzvVDGDbg5Wr
	 2MPsLHc9zBz4g==
Date: Fri, 7 Nov 2025 08:35:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mahesh Rao <mahesh.rao@altera.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Message-ID: <20251107-enthusiastic-mouflon-of-experience-5aea2f@kuoka>
References: <cover.1762387665.git.khairul.anuar.romli@altera.com>
 <dc40029c970d33b433e763202e6622a0a2f12d72.1762387665.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc40029c970d33b433e763202e6622a0a2f12d72.1762387665.git.khairul.anuar.romli@altera.com>

On Fri, Nov 07, 2025 at 07:35:25AM +0800, Khairul Anuar Romli wrote:
> In Agilex5, the TBU (Translation Buffer Unit) can now operate in non-secure
> mode, enabling Linux to utilize it through the IOMMU framework. This allows
> improved memory management capabilities in non-secure environments. With
> Agilex5 lifting this restriction, we are now extending the device tree
> bindings to support IOMMU for the Agilex5 SVC.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


