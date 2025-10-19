Return-Path: <linux-kernel+bounces-859737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6ABEE74B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 920454E5D8F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7BC2EACEF;
	Sun, 19 Oct 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz32l1gj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C72E8B97;
	Sun, 19 Oct 2025 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760884767; cv=none; b=WOSS0VAmp3Uhe4ZwE5KjUyhAIATBwKz586CaNlK5BAiHfP5lC5B4h7WNw19X0sZ5mg1tmxjgDip0ujk2+IdmLzWE44mg1sMeFEDPouwmiIqZDib7SlbqrtwZnHQs6oPfdQxmz4pBLIl1jY1AeCyOUamLlqcGdNVt6xvPVLp+DmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760884767; c=relaxed/simple;
	bh=k8SgdX+4WQZcd/KvW7GuWuY+44AL9e/LFxE4enNPF/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5r+fCZKnYdqWnSFU7d2YiihLj83Mb0iPJnvh/tohaX4y6uz+wd26AxXYARBWtCagDGuzP2FxkhIpMS6tciIdBt580LSnU9uZHNJaCsFNwCLXALMZtL1d5741x/N1QKYxCqHqb2rOTnutOpbfb1aZf+7NONbHhICaJbKf9yg534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz32l1gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E3C4CEE7;
	Sun, 19 Oct 2025 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760884767;
	bh=k8SgdX+4WQZcd/KvW7GuWuY+44AL9e/LFxE4enNPF/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iz32l1gj11nSsLBQQ6ZRYd0G2cr/U8u0H3UMsuBZjZQfqZ/6SID4oii6BPuBUf33y
	 AmpNkzRU/dMurcZvMdZ/4T6x0gGOt7LXucso1P+vngrMBPz9VIhPPXGIyDfmuruU2z
	 iU9gmJnjDSs1bX/sorjSaI2jCbGeQhEKtdn4SRXs/LXRUWTipkQZp9Ewqhtj6s+gJU
	 IMHexoOCnw5EhIQNsGSH1C6fn4EDHtuwzmDeII8B5HSLneMSMmOkxbWWHPocIK6gVh
	 HVICvy5ceiPvxWVjT0OMhywWbSlIX37PdxOHClYzMa2LRJb6n23jTFFgmZpCGyPqXG
	 634858wCFP82Q==
Date: Sun, 19 Oct 2025 17:39:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "longwei (I)" <longwei27@huawei.com>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	"hewenliang (C)" <hewenliang4@huawei.com>
Subject: Re: [PATCH] kho: debugfs: Fix finalize interface documentation
Message-ID: <aPT4GBc8FW8P6kxW@kernel.org>
References: <fe693f4d-80c7-4d1f-9430-3ab9c8165df0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe693f4d-80c7-4d1f-9430-3ab9c8165df0@huawei.com>

On Fri, Oct 17, 2025 at 06:21:49PM +0800, longwei (I) wrote:
> From 91c2b24855d55fef0e8919b2d39216d5c9aad558 Mon Sep 17 00:00:00 2001
> From: Long Wei <longwei27@huawei.com>
> Date: Wed, 15 Oct 2025 19:58:39 +0800
> Subject: [PATCH]kho: debugfs: Fix finalize interface documentation
> 
> Correct the error in the KHO documentation: 
> when removing the KHO finalization phase, it is necessary 
> to execute echo 0 > /sys/kernel/debug/kho/out/finalize
> instead of echo 0 > /sys/kernel/debug/kho/out/active.
> Fix it.
> 
> Signed-off-by: Long Wei <longwei27@huawei.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  Documentation/admin-guide/mm/kho.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
> index 6dc18ed4b..2eda33865 100644
> --- a/Documentation/admin-guide/mm/kho.rst
> +++ b/Documentation/admin-guide/mm/kho.rst
> @@ -57,7 +57,7 @@ Abort a KHO exec
>  
>  You can move the system out of KHO finalization phase again by calling ::
>  
> -  $ echo 0 > /sys/kernel/debug/kho/out/active
> +  $ echo 0 > /sys/kernel/debug/kho/out/finalize
>  
>  After this command, the KHO FDT is no longer available in
>  ``/sys/kernel/debug/kho/out/fdt``.
> -- 
> 2.43.0
> 
> 
> 

-- 
Sincerely yours,
Mike.

