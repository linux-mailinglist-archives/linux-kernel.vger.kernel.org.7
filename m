Return-Path: <linux-kernel+bounces-773232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868AEB29CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B5D1964459
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F2A30DD03;
	Mon, 18 Aug 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbNiudCN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743F308F00;
	Mon, 18 Aug 2025 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507473; cv=none; b=sEoWLAb2CPXhyogcJfDKX+utUEtFIOUZW5jmj0rdzfHKcMVbIW7jBlCwP2ar7xVv52dKNcCnc8HQu2ctnkXGLLhCnEuXoAm5tCzoHhI281cQdIJkYeWVzurE6edk3LdLaqKATk8QgI5qgEwonFR3T64VBVjee2MNhytruGnsG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507473; c=relaxed/simple;
	bh=D/005ypjlVcxX2OhurCgoBQqPV0eIL40uHPbaa2raI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNJfOmjnLhxWyw576fQTTfuc/7oe6QuWdOsHn4z2YuQtiX7a596HMjdGJlkfOa8K5gXEzdNA5XpfZkvtDU+U4VeNixbifX9lmptYk/EVVNjltgKJbTnnD5w/G5/U5GN9iIQuEAoG9m0hpz93j6lAArNuMolHiPDMPOZsSsDHXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbNiudCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFDCC4CEEB;
	Mon, 18 Aug 2025 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755507471;
	bh=D/005ypjlVcxX2OhurCgoBQqPV0eIL40uHPbaa2raI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbNiudCN+cE/QA8PZ4B7SkirMqUcmLcD4CZMwddkVXZMqdtN/8kTJbwcge0Jgeqp9
	 RSFDQ0d2+fdVKOMuK6KnielTuy43A/TKcEGYAPSiveiocNXhEBD48TYfPc36kIp2A7
	 9eSKtPFX9fr+2/Srr4kpvWwMw+PKEidyGlEN/p8xr8iFNtr9G/Kg1DVbfgSqd1ywam
	 5giRXZ98ixRJjED4QwilpoHEpm7X5sgvM7GSIPgg3gdmjfvupPsdsVxXYWUaIGvf3G
	 0fSwQaGpHO6OlYjWfDCAdjD3cUTNyaOfO0iuKWg/19V78Y4fi4QDaj6AMj61KEr79T
	 zyMA0k/e6Kn3Q==
Date: Mon, 18 Aug 2025 10:57:48 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] of: dynamic: Fix memleak when of_pci_add_properties
 failed
Message-ID: <aKLrDGXJ/pXS/wRk@lpieralisi>
References: <20250813182849.3229140-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813182849.3229140-1-lizhi.hou@amd.com>

On Wed, Aug 13, 2025 at 11:28:49AM -0700, Lizhi Hou wrote:
> When of_pci_add_properties failed, of_changeset_destroy is called to free
> the changeset. And of_changeset_destroy puts device tree node in each entry
> but does not free property in the entry. This leads to memory leak in the
> failure case.
> 
> In of_changeset_add_prop_helper, add the property to the device tree node
> deadprops list. Thus, the property will also be freed along with device
> tree node.

Add brackets to denote functions:

of_changeset_add_prop_helper()

> Fixes: b544fc2b8606 ("of: dynamic: Add interfaces for creating device node dynamically")
> Reported-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Closes: https://lore.kernel.org/all/aJms+YT8TnpzpCY8@lpieralisi/
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/of/dynamic.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 0aba760f7577..dd30b7d8b5e4 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -938,6 +938,9 @@ static int of_changeset_add_prop_helper(struct of_changeset *ocs,
>  	if (ret)
>  		__of_prop_free(new_pp);
>  
> +	new_pp->next = np->deadprops;
> +	np->deadprops = new_pp;
> +
>  	return ret;
>  }
>  
> -- 
> 2.34.1
> 

