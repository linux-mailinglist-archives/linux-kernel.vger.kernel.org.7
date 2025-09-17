Return-Path: <linux-kernel+bounces-821671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D85B81EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E925E1C2459F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7E52749CE;
	Wed, 17 Sep 2025 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqI2B8QU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CF231A30;
	Wed, 17 Sep 2025 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143970; cv=none; b=IbGSyutq5D12QI111LwIMZQyXHgAQK+vRVMYsEG1bS+TJbJS7gyFRX/5dFgX0JD9yFOfYfbq7U8dLatn48jV/IG49rT9NG9iaBSEtGN33Mini3/hO7kmMVRlX4QJtUEqIErTpGpD7kYwqmlPkodJZQ1wmz8XePbD2wHpoMdv+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143970; c=relaxed/simple;
	bh=asW8GYOBjhzECuwX0DtjiJp0DUTBe9PS/F4aRokBJHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLLKvFC19Tdui63pDQJrIjrOqBlTxoCGlAPCGXvn/jKkFfn9eQOhCD1u//nZmV0OeAYxe4SsqyNmyDtbi63QzMWelLTGOX7WNFe4C+6sdZfD07KxkrpmW0lIZkbZdhtTOXzYQLiBaFWjIveFMYNmGtWJp4uo3HoasGoVKa7fTUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqI2B8QU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E23FC4CEE7;
	Wed, 17 Sep 2025 21:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758143969;
	bh=asW8GYOBjhzECuwX0DtjiJp0DUTBe9PS/F4aRokBJHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqI2B8QU7FMAxD0o0mSOwAPHszub11os4+k96o5g665gFYlI7mTbKaEcxtYA+nhnX
	 0aRoVWrOWKcEpKGvAcKh8/xYC++M/SrUA5FiB2CRw5jEW6uE3F7NLlNPxw7JBebEIy
	 oIOXQxYTeUST9RFKedri3vVUJxdGYKSZMOiqnFZLRidMl+72RODmzZhLPFsAHccvYN
	 fHx09BRTEG7yvJeeP9AhjjoYGqKCoKDm8HuMaRn/wtGPCpb6AijoldC+Hw2450E5oq
	 462I2NVtsjCrVJ+77pLeksgrF/az9ScnCpkA1q6ZoAAyaRgQlnH/YBZT1cLRxFhkCg
	 Qq2XUB7NZ9c1g==
Received: by pali.im (Postfix)
	id 7888F846; Wed, 17 Sep 2025 23:19:25 +0200 (CEST)
Date: Wed, 17 Sep 2025 23:19:25 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] hwmon: (dell-smm) Add support for automatic fan mode
Message-ID: <20250917211925.dhzocprqgo4tkpte@pali>
References: <20250917181036.10972-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917181036.10972-1-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716

On Wednesday 17 September 2025 20:10:32 Armin Wolf wrote:
> This patch series adds support for individually enabling and disabling
> automatic fan control for each fan on most Dell machines. This works
> by using fan state 3 that does not act like an ordinary fan state on
> most devices. Instead of increasing the speed, said fan state usually
> enables automatic fan control for the associated fan.
> 
> The first patch removes the custom config data for the Precision 490
> that turned out to be incorrect, see the link inside the patch
> description for details.
> 
> The second patch enables i8k_set_fan() to accept fan states larger
> than i8k_fan_max to prepare for the following patch.
> 
> The third patch finally adds support for this special fan state. It
> should be noted that after applying this patch, the "pwmX" and
> "fanX_target" sysfs attributes will return -ENODATA when automatic fan
> control has been enabled for fan X using the special fan state.
> 
> The last patch adds the OptiPlex 7040 to the device whitelist so that
> the driver automatically loads on those machine.
> 
> All patches have been tested on a Dell Inspiron 3505 and appear to
> work.
> 
> Armin Wolf (4):
>   hwmon: (dell-smm) Remove Dell Precision 490 custom config data
>   hwmon: (dell-smm) Move clamping of fan speed out of i8k_set_fan()
>   hwmon: (dell-smm) Add support for automatic fan mode
>   hwmon: (dell-smm) Add support for Dell OptiPlex 7040
> 
>  Documentation/hwmon/dell-smm-hwmon.rst | 56 +++++++++------
>  drivers/hwmon/dell-smm-hwmon.c         | 99 ++++++++++++++++++--------
>  include/uapi/linux/i8k.h               |  2 +
>  3 files changed, 108 insertions(+), 49 deletions(-)
> 
> -- 
> 2.39.5
> 

This patch series looks good to me.
Acked-by: Pali Rohár <pali@kernel.org>

