Return-Path: <linux-kernel+bounces-863667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA69BF8C12
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218F43B7A23
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B827FD51;
	Tue, 21 Oct 2025 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrHfJ5Gi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D727815E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079413; cv=none; b=OmbVyNLIKnaNNV7Jqb40umam2dmyLQpR7x/pT/vQRe6RV1PhB6Bb1LjgiVu+YPQnL1jBfRjTbfnc533kURhzgT2OvNQULXCuq/IPHqCxKpbwaUGsD1yqUZvMUnBPzlC9vjN5yAmIErAgVnn03+6TLYPIp6iBjzihTuwabJ4zAn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079413; c=relaxed/simple;
	bh=eF1fACVfV6HLT5roiTx6wO7WHbA4YryGuaxzvCrw3KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evxmudfH8D/IK1U0WztlbxfOhr/mtRIOMSEitlY/rGchgxxAVq8KKuJXY6X52xoPXjUFX1fKAZ74cN2p7D/yQxs6WvWpS6juF507kWx+1GbixEzNW/ov4KHyIdVQRkQ1uIqiPQqzvjnYARCjJY9bhRrS3XPrK/K1ulqdbiXd71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrHfJ5Gi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761079411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jca+iAluyvXYfcIcNG0HUymCKJQKka+3ZoKebkZZYlk=;
	b=MrHfJ5GiBUFm7KqFFr2U/9vMbz2qElSDeLF+RaXNERDjErmUR2olNmw2RDARgVli9n1AZB
	mh/Q74ssMqGfKUX8HL73OgTJhA7XLYaGsfzZtlsfqBB3eCFWeyq7L/phWaSNf7ombSaV5M
	3W4kKJjQHUMd30Eb2HGa4BuPWa/gL/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-aweGORK2N16VCq-NfHw8Hg-1; Tue, 21 Oct 2025 16:43:28 -0400
X-MC-Unique: aweGORK2N16VCq-NfHw8Hg-1
X-Mimecast-MFC-AGG-ID: aweGORK2N16VCq-NfHw8Hg_1761079407
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4710c04a403so62416405e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079407; x=1761684207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jca+iAluyvXYfcIcNG0HUymCKJQKka+3ZoKebkZZYlk=;
        b=wCLhaf+2NGEeTxd0dd7GV/dUaxAwNOzHusVJWcJ7QXQZomV0Q6xDIKAxFCRE8wZIj1
         pwP6hDH0HLif0MCnKDQ8wokyh/t/+v7mPuQpsCWV1YCko8x/1sf3bsFEkqhfIS+mnpAH
         yWj5W65zGr0dyzxdsRlAzoucMQoJqYsManNA9FQRNmnQjBVvFBiZdQ5lNX9XY0WmmPr/
         r1YWd4eJc5joAQpgEJJQGiv3xBw9QIOP/eUZg7qYY3+G4P3qYR5esZNiP2TIJk32LLUy
         Xhf2djM0tcmE/7uYFjDvRr/jGe70JXlceL+hz33+088wCATvgK/m8Yh/YzqDW3NgT3V5
         6NYA==
X-Gm-Message-State: AOJu0YyiyYaQKxICVQ3hwU4Ms6I03uHeXHaLQ0iRnBiCcwMdYz5W4r4g
	QJYhY94Bz6WimXEOPe+8tZhYnLrNTeebQQkn/pRs76W9yxIr9wrXjMT/edRIjerP5AMzWOt4SQk
	QfDI9Ylo7EVaRG12LwccI/dPoUjmpsyOoV8Y5GnXBm/ry9TCYYCT5xpl2xvuKwsNnFg==
X-Gm-Gg: ASbGnctL/ocylPnydbtaNRUKsSVp63fuabEUXrEwlOSPgumKjL36BWLjsvwsM1Rl+ga
	0rL5P9nGczG12mPyj9TkINc0uqUB14pW/qppRHGIVM3GVDc5zeW6tEdyRPJVH1Z+8oDCz7Hx16X
	Rvuk/oUkIAqm9EPKGdQRRDHkxuojQeKm6ZF8VdOigBaJnzpGGDj8ZBKKz9IYytxguQs1DhBUsM0
	zQ7IjiQgxE2a/JmuCYs+W5TP9zxY2XInY3Fidsnyyo6yZ5yCrx+eZByFLUAmeaAPZwHLhe8QSaT
	2VDkxtvoNY9XHPcCqbXjiKAUl317MENBbZXXPxj1rTjOnSxgYikA4Dc+LGsBSaj/Lv19
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4711791c5dfmr155489115e9.30.1761079407237;
        Tue, 21 Oct 2025 13:43:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3tqHiyIT27d9/w9pV3Cihx1kc1ZDJQnIJKiIuWuTpURVwED00bfMi5FBVB40yx0uQLffj0A==
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4711791c5dfmr155488865e9.30.1761079406669;
        Tue, 21 Oct 2025 13:43:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c429e82dsm9612815e9.11.2025.10.21.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:43:26 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:43:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 03/23] powerpc/pseries/cmm: remove
 cmm_balloon_compaction_init()
Message-ID: <20251021164220-mutt-send-email-mst@kernel.org>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021125929.377194-4-david@redhat.com>

On Tue, Oct 21, 2025 at 02:59:08PM +0200, David Hildenbrand wrote:
> Now that there is not a lot of logic left, let's just inline setting up
> the migration function.
> 
> To avoid #ifdef in the caller we can instead use IS_ENABLED() and make
> the compiler happy by only providing the function declaration.
> 
> Now that the function is gone, drop the "out_balloon_compaction" label.
> Note that before commit 68f2736a8583 ("mm: Convert all PageMovable users
> to movable_operations"), now not anymore.

What does this sentence mean?

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/pseries/cmm.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 310dab4bc8679..67c7309c36147 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -548,15 +548,9 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>  
>  	return 0;
>  }
> -
> -static void cmm_balloon_compaction_init(void)
> -{
> -	b_dev_info.migratepage = cmm_migratepage;
> -}
>  #else /* CONFIG_BALLOON_COMPACTION */
> -static void cmm_balloon_compaction_init(void)
> -{
> -}
> +int cmm_migratepage(struct balloon_dev_info *b_dev_info, struct page *newpage,
> +		    struct page *page, enum migrate_mode mode);
>  #endif /* CONFIG_BALLOON_COMPACTION */
>  
>  /**
> @@ -573,11 +567,12 @@ static int cmm_init(void)
>  		return -EOPNOTSUPP;
>  
>  	balloon_devinfo_init(&b_dev_info);
> -	cmm_balloon_compaction_init();
> +	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
> +		b_dev_info.migratepage = cmm_migratepage;
>  
>  	rc = register_oom_notifier(&cmm_oom_nb);
>  	if (rc < 0)
> -		goto out_balloon_compaction;
> +		return rc;
>  
>  	if ((rc = register_reboot_notifier(&cmm_reboot_nb)))
>  		goto out_oom_notifier;
> @@ -606,7 +601,6 @@ static int cmm_init(void)
>  	unregister_reboot_notifier(&cmm_reboot_nb);
>  out_oom_notifier:
>  	unregister_oom_notifier(&cmm_oom_nb);
> -out_balloon_compaction:
>  	return rc;
>  }
>  
> -- 
> 2.51.0


