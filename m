Return-Path: <linux-kernel+bounces-793774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DFCB3D808
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53897A1D92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 03:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D433E224AE0;
	Mon,  1 Sep 2025 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEzNEtQO"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28BE21D3E6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756699205; cv=none; b=aIyAp74UIolkol6GHHJ8CCWk6iXsTqHkcBr7WDCSoT0zsTVnWm8jJtfPPEfZInY9eccBcz8XnSVOElnUseGnwofW6tw+C7vTbYpXb9B0NuYL5hEzQ25zFrvTIHLjvbzm73YiZwkBXyVpZ/aM1d5Yjrmea7ypUISZnKsrmb5RpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756699205; c=relaxed/simple;
	bh=qfu/WycKGvAdlE9GdyPfa7NWkhY/PJDpWmk9QSOV8D0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CCk6ZWcfEqCSccVkrc2TzyKG7K85zKUdwIBowpyli7TQmxlmOG+PnyiZEdfde9ww0bHZhXPDrNdyeYZK+TEyPH0tyqvRhbVyAZVQeaPyvc9l7l/neivI+O2qAQ6bvdCnnH2/A0yU9lB3yaH6i05AlCARQdZSqC/AQ+IPsJlgnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEzNEtQO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445806df50so30346205ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 21:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756699203; x=1757304003; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RNN05k0SkEGnYtipDErhvvyExHnexROka07GUDG5ZG8=;
        b=PEzNEtQOxpNRpNBzxda6+CarX60T3LqiwtPQlCIyIkBva6vYc+qikaDt3Z2cNyFKz2
         8dXuTYUWdiCMOZ93iFsHY3Y6E30+54RoAIGcCLAfmGsjRUnxqTBUq/S6I5gfgm7ZeHl4
         GAweAuw42cH5G3qfsQpjZW7S62taGvHzKzRlKu9VzbhU17KGqmGWlQkmK8yprBELVf/E
         rO6/qJu0kPLY5X/Jky0emqt2beOVjCSJl3bidbSo68hx1BEZlqHCdAOVc29OMOzPD72M
         xv89qxQNlWRNBOfSkKVhOGEVSlPkALtHI8/fkLwthmJ4TqBFBoyLbvVHJ1VmreHvQUIN
         l28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756699203; x=1757304003;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNN05k0SkEGnYtipDErhvvyExHnexROka07GUDG5ZG8=;
        b=XPflmUJQnffw6uZZ0XBO3vv2U/h5tC2hEdTx1Xgz6L5KaSE9KPSEJCkb8gSOvViMm9
         GtGxJLI1XUpvPtSMn1Jky4XlWNDY6HMxmEFVF9XW92ET/m3tLKlHU1MSHyC1II+m3Vli
         AtDM8pkgI//Ip1zztQDzPL47A+2pQdY66ob77pMGEzNArwtWnPjXu6Do2oJNO/oUdAF7
         LBSWDhAgFC2rnf7v3oS1sIVe+NdRRn1c1fRkzh6XkP3FlHT6LkooP/bkT6by8r3zarVb
         RCXVyHxv3E5weutoccirVNcEL5C/Rfx5F/VfiHgXT2IWBrb0lX6IwqbQ76GNxwXIk0nG
         w8LQ==
X-Gm-Message-State: AOJu0YzJHwqwsDxWfmk0bqSCjexc4smJmJzPtY3J/AznHFc5Ej48F28l
	10uprk5J+A52Y9Fmb/R+/8m/uUdV8okJl2+bC415L3CEy9HWnuSmXkVk
X-Gm-Gg: ASbGnctqD4ZyIMsziuXmdFsmPyAnNnu3ATkzsp+jNjSMg3gw4LB+9AEC2zN+O/fRYlP
	8m4VlOH+MLVI3MFTceYKgrhIvjBAM+dCZ7wrbvFg6zRKefk6JpFJ8m/bwC79qoAXAKTSggMb9SI
	tnhmfcSPmomYkf6Cd/E9aWG0Dl/y1S8LMPNooOUAnZhyT7L+UzdXouxODrgImr8COalIp5IvEwN
	QMgOsl1aDp+FlYI+k6LeMctkpJyzfdJ2eVbWot6rUr1tNQX+c1m/QTSPupZAnaPfVLcdvyf8tq1
	1yJJj85iXFyR4sA3lENaS5SpulxUhNbD3CTQmxixTrt2F7QCykSRCJD13u1rvlArCU+ByrEUwxQ
	FrW3RJW2skd06x6IFQNx/tz0=
X-Google-Smtp-Source: AGHT+IHrROqEQWLo3tJoOV3keKTK3UQx10WUIKtupLxaoq9MHd/qKW3me+GT+z8VghgqjcA+jQjk9A==
X-Received: by 2002:a17:902:e745:b0:246:e1f3:77b2 with SMTP id d9443c01a7336-24944b65071mr78080455ad.53.1756699202873;
        Sun, 31 Aug 2025 21:00:02 -0700 (PDT)
Received: from dw-tp ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037022d9sm90560065ad.23.2025.08.31.20.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 21:00:02 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 5/7] powerpc: Stop calling page_address() in free_pages()
In-Reply-To: <20250826205617.1032945-6-vishal.moola@gmail.com>
Date: Mon, 01 Sep 2025 09:17:44 +0530
Message-ID: <87plcakf4v.fsf@gmail.com>
References: <20250826205617.1032945-1-vishal.moola@gmail.com> <20250826205617.1032945-6-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Hi Vishal,

"Vishal Moola (Oracle)" <vishal.moola@gmail.com> writes:

> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please also cc the respective subsystem mailing list if the changes span
in their area. In this case that would be linuxppc-dev@lists.ozlabs.org
( I did it this time )


Thanks for doing the cleanup. Yes, it makes no sense to do page_address()
here and then free_pages() doing virt_to_page() internally.. 

The change looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index be523e5fe9c5..73977dbabcf2 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -780,7 +780,7 @@ static void __meminit free_vmemmap_pages(struct page *page,
>  		while (nr_pages--)
>  			free_reserved_page(page++);
>  	} else
> -		free_pages((unsigned long)page_address(page), order);
> +		__free_pages(page, order);
>  }
>  
>  static void __meminit remove_pte_table(pte_t *pte_start, unsigned long addr,
> -- 
> 2.51.0

