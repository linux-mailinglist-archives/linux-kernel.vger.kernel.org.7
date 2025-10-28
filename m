Return-Path: <linux-kernel+bounces-873758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCD1C14A17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B6567793
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD232E139;
	Tue, 28 Oct 2025 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWW+zGjx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20432B992
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654603; cv=none; b=KPfForXYN3s5HOhKv+aL7j5KHaDXhPRDGWKB5A6rIOxu3IPplNfAwVQ2UF62lGUYByGbaJqHZHyoiSf7DpCtRKN9sT4Vi2jK7YNEpvmxlZoNXxGb05MrLR45efaQLgV9ixo5aofBsF/Gk8o3t9JOaJcRmWNzdd0WCU+cU83bbew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654603; c=relaxed/simple;
	bh=wCicmv7BX39dNksXr1oTPJr0GBVwAai5qBVQk0rdTEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKthOETJwguAf5hyoWvWj/fkdcq/kYwXERSqBK3jsJ9IKL6azuV/055yu57TO8dXwKAfFOBUz2Qjl75h/ZQGHVNXs3of9SMY2xROY6VNPAO7xlGLIYl1cRUQ952yUM9+knhOJWZ5tHEDGHUtyRDjPchDxqUILQvabOzmxq9/bXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWW+zGjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089D6C4CEE7;
	Tue, 28 Oct 2025 12:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761654602;
	bh=wCicmv7BX39dNksXr1oTPJr0GBVwAai5qBVQk0rdTEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWW+zGjxLHgwIjrj5giH0k2xl1dJJvu9U4pDgcsD66QUJwYw15K+JUVFYwpoduZZh
	 4huufU9S6GAjSOeV545APhSaz9kdM0nO7ARQfqEb+hKaou/Y2i/cVE08timIH1Kr9n
	 vcGkKDup1BF57Ytv811tSGsonQs+Y1OWNyx1UO1gDxqKA8Oxu7RyDZUe9RjyomsY0L
	 vP53kaAW9VVWau74qx421Yh0d0JzqPCDp3Zo5wmqIhfquf28ZFKmaz8LgDHoR4zS/V
	 Fp4P0Ku33C1m56MeB0hGiC9svx3binWMfkV7ifAoObHzvPRaJwrTyxw1H+Ny6nXIFW
	 pWJ7YBhCC3fCg==
Date: Tue, 28 Oct 2025 12:30:51 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: naresh.kamboju@linaro.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu, lee@kernel.org,
	jingoohan1@gmail.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] powerpc: Fix backlight include fallout
Message-ID: <aQC3e5sbGwIpanf6@aspen.lan>
References: <20251027140646.227025-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027140646.227025-1-tzimmermann@suse.de>

On Mon, Oct 27, 2025 at 03:05:39PM +0100, Thomas Zimmermann wrote:
> Fix the fallout from a recent cleanup of the backlight header.
>
> Thomas Zimmermann (2):
>   powermac: backlight: Include <linux/of.h>
>   macintosh/via-pmu-backlight: Include <linux/fb.h> and <linux/of.h>
>
>  arch/powerpc/platforms/powermac/backlight.c | 1 +
>  drivers/macintosh/via-pmu-backlight.c       | 2 ++
>  2 files changed, 3 insertions(+)

I noticed that both these directory trees are orphaned.

Anyone have any thoughts about what tree these should be delivered via?

Either way, FWIW:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

