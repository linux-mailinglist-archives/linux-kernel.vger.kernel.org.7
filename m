Return-Path: <linux-kernel+bounces-898105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 55621C545CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93A2134A982
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28932848B4;
	Wed, 12 Nov 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2bzmwpu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A9A55;
	Wed, 12 Nov 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978077; cv=none; b=WaodOjRUdyqX/MWYCRihW+8eXiXIBNpGZUIw7uDwyoYb1jnEkax1B/oNN8MJBNj7zjc40eOfSanH4Rrd8Eiq2Xah/aaYAl51HBfcwK37g/2CM+aZiluK8BPGeWawz/frYPRepEVbQXTRz8zjolT17c2XSOieZjZ4bobqg93bfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978077; c=relaxed/simple;
	bh=OdEJh6jMrxplRcO6WXw0GHADFcWNOvCQr3BWQP8HOgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADUt9qvsOOJ/IBeVnjdjSalvY3aZDwRAE49LmXp240Hgn4ncw+0srnHqxrja3MXaNaoNpUXIp3tgfQxIq6D6lumusrqZVo34UUEcWvBQiJO7C8FS1+zmAnqk39qtR5KhI7K47BQDjOc2vaoi0baryvpzIqoC1FN3P8VUPtwCoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2bzmwpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE90AC4CEF8;
	Wed, 12 Nov 2025 20:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762978076;
	bh=OdEJh6jMrxplRcO6WXw0GHADFcWNOvCQr3BWQP8HOgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2bzmwpuTCZrsQvG3nXjr1MzE7LiJE4mtJXDLMawS/s8je6J8yqjXnd12SzIzFpF7
	 FCAeNmQXArfLUVcc9AMqDAbm1goT0ZnA7zv2xj3riwfH+G+3wxRxEPcWvuBxC57oDe
	 UVslzKDPRWAOMpvQc8EHMmUiJB3dUcA3yt9k8Gu21nCmQIFvkKbZg3mJLSNTjKkeeE
	 bgr1YtwUgCE4lx+pVA/eM8e4awyXPQ9blRAC3GQ84z897lJ+mnbnYUbCS+4Fk2uJpB
	 PRWbv60bgR7P6cKfb18QtI/472QshOi9Ai8fNOJcGK/GWrgovRxNY76FEeFzP40r+W
	 U6Qoyzr7P5FQg==
Date: Wed, 12 Nov 2025 14:07:55 -0600
From: Rob Herring <robh@kernel.org>
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	James Morse <james.morse@arm.com>,
	Chen Zhou <chenzhou10@huawei.com>, Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] of/address: Remove the incorrect and misleading
 comment
Message-ID: <20251112200755.GA2155854-robh@kernel.org>
References: <20251112143520.233870-1-yuntao.wang@linux.dev>
 <20251112143520.233870-11-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112143520.233870-11-yuntao.wang@linux.dev>

On Wed, Nov 12, 2025 at 10:35:20PM +0800, Yuntao Wang wrote:
> The of_bus_default_match() function appears to have been copied from
> of_bus_default_flags_match() with some modifications.
> 
> However, the comment was left unchanged and still describes the behavior
> of of_bus_default_flags_match(), it is incorrect and misleading, remove it.

There is no reason to put this patch in this series. It is completely 
unrelated.

> 
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
> ---
>  drivers/of/address.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index f0f8f0dd191c..4034d798c55a 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -328,10 +328,6 @@ static int of_bus_default_flags_match(struct device_node *np)
>  
>  static int of_bus_default_match(struct device_node *np)
>  {
> -	/*
> -	 * Check for presence first since of_bus_n_addr_cells() will warn when
> -	 * walking parent nodes.
> -	 */
>  	return of_property_present(np, "#address-cells");
>  }
>  
> -- 
> 2.51.0
> 

