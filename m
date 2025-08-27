Return-Path: <linux-kernel+bounces-787521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD1FB37770
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF9D3A9196
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393FD1E008B;
	Wed, 27 Aug 2025 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0WJrdMh6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8833E184540
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259717; cv=none; b=VwFRStma1aH/okLuTOjyQBrthEokiV3OdatFJsEJPxsExc1hasl2bY1LPOAXrJvNqfLy558U4wpp74tTVsm5ccQMUSXncaVlfGpmQIbZLUTjunhGKaAxgtZlPzlYXn54R0/vdkWWaRSX99SQhwKBMty2JMzSgZO/WzbUjfXl6HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259717; c=relaxed/simple;
	bh=8kSO502PchRJBtbzZNCGUNI1RhzLxJ8K0FrAi8MjFDQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hnNl10HfHf25/mHtjY+uqVldlubs/myNET5RAh4Z92wtiYvzzb0rPNcEHBye5C1tCLHYDhP4zwl3jN2qHz9ZN3/niHSnpLuz3f0a80ySIu6GNUd3EJSTfN0bQ/PDimWkI2xpjDoh6YBZiik7T4c042tBPuEaoPbvBwmtwTFfHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0WJrdMh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7AAC4CEF1;
	Wed, 27 Aug 2025 01:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756259717;
	bh=8kSO502PchRJBtbzZNCGUNI1RhzLxJ8K0FrAi8MjFDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0WJrdMh68pL6xIEhKiLT42vG+Nm7djlhAg7FUFOKgps1Y3YH2sGxdDBujOgJugdtq
	 HTWD5+P6LV7lpdfWMggnwyypB7eugBmlIUAIwODOX48olsgeGvU2/xbboXaC0Uniaw
	 4/NgIFbYByD6+CmmSHvSpaRntHMnh1Fi4KI6ebqQ=
Date: Tue, 26 Aug 2025 18:55:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] huge_mm.h: is_huge_zero_folio(NULL) should return
 false
Message-Id: <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
In-Reply-To: <20250826231626.218675-1-max.kellermann@ionos.com>
References: <20250826231626.218675-1-max.kellermann@ionos.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 01:16:24 +0200 Max Kellermann <max.kellermann@ionos.com> wrote:

> Calling is_huge_zero_folio(NULL) should not be legal - it makes no
> sense, and a different (theoretical) implementation may dereference
> the pointer.  But currently, lacking any explicit documentation, this
> call is legal.
> 
> But if somebody really passes NULL, the function should not return
> true - this isn't the huge zero folio after all!  However, if the
> `huge_zero_folio` hasn't been allocated yet, it's NULL, and
> is_huge_zero_folio(NULL) just happens to return true, which is a lie.

Isn't it a bug to call is_huge_zero_folio() before the huge_zero_folio
has been created?

Being a simple soul, I'm thinking

	VM_BUG_ON(!huge_zero_folio);
	VM_BUG_ON(!folio);

or similar will settle matters?

> I believe this is a negligible corner case and I don't want to add any
> overhead for this; but in debugging kernels, it may be helpful to add
> this check, therefore I put it inside an `#ifdef CONFIG_DEBUG_VM`.
> 
> This weird side effect prevented me from reproducing a kernel crash
> that occurred when the elements of a folio_batch were NULL - since
> folios_put_refs() skips huge zero folios, this sometimes causes a
> crash, but sometimes does not.  For debugging, it is better to reveal
> such bugs reliably and not hide them behind random preconditions like
> "has the huge zero folio already been created?"
> 
> ...
>
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -479,7 +479,12 @@ extern unsigned long huge_zero_pfn;
>  
>  static inline bool is_huge_zero_folio(const struct folio *folio)
>  {
> -	return READ_ONCE(huge_zero_folio) == folio;
> +	const struct folio *hzf = READ_ONCE(huge_zero_folio);
> +#ifdef CONFIG_DEBUG_VM
> +	if (hzf == NULL)
> +		return false;
> +#endif
> +	return hzf == folio;
>  }
>  

Yeah, this all seems rather ... complicated.

