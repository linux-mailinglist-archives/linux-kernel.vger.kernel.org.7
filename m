Return-Path: <linux-kernel+bounces-742337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263EB0F021
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4C53BE06F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214902BCF6A;
	Wed, 23 Jul 2025 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTD+dYWK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BDAB67A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267360; cv=none; b=OaZv2D4rsOh8BbhNhNeLjFXxKGh10wPUFtaIAZOuNFMC85q/n7M4q3vuTv4LFDzWvUcNnwFsla7ribl3Ichw3viGfhKveykeS+sNM3In7kMRYCARHcc0q29Cai+umCWSdL2M1hsaoOFk4sooTXk7CDVakeHOaGBhHJixBfKS54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267360; c=relaxed/simple;
	bh=27geCc4KT1s1vtBdWGdxEDLMgxEVsBCOVqnkSK7/aEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djT15ByYJXlqQ+M0jn/0ejggHNcf9iUH5qtBSASlY0rnTO28Aq439TPUPsk94Ai8+6rK2eQ1Hc+Ogkd1UwuwO562QYKFXBCcLCmleVmsVz6g8/kD5rrl4DgAzDb+4bu3NjmYSwY5tUhvf3imPAt2TsIMVsoMATEoKlwDcN0O0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTD+dYWK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753267355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q5UWNNTGLGmTszxRVUFTgBdkzUSoxVU+yLV4M7VYTtM=;
	b=YTD+dYWK/1Gc4idPCQkuhljG4ZAmeKnvGFeeqSm+PnBIUo4aymSTFrO5RlMDt2uyJrykRy
	ENhoM9LhJmD5JOugzQ8A8VdXN64eqlDfSwXRZrm6bor+UKMG74TtaORBTRhSRsG2yTPxPW
	4xlx9RZW4a+WpdauQm+p5oHoj0jbPzk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-WCga0NCpNE2lXw1HhyZ1jw-1; Wed, 23 Jul 2025 06:42:34 -0400
X-MC-Unique: WCga0NCpNE2lXw1HhyZ1jw-1
X-Mimecast-MFC-AGG-ID: WCga0NCpNE2lXw1HhyZ1jw_1753267353
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so4171324f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267353; x=1753872153;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q5UWNNTGLGmTszxRVUFTgBdkzUSoxVU+yLV4M7VYTtM=;
        b=lRMrv8qZZFLYgdyzmgMsxTb/TfXn2GO8cJLBHd0lhA1dTpH0vnP2CEUf4oj+xGqrW1
         NJxtGoNcj4NLvnScI9/5JtcxMuXYAMu960YTmGWd7WvGPWftp7uIJchuGxryNvgrbD+s
         x53Jn9Z5vKy+Y22wgW5rcoe7GDZ7nWzR3xKRVD/cIf/JiBkpQTbwvframhZv/0dxmSUp
         V4U6DwngckKNNPNcwC5rBLqvHFwnqZvNrOeoTrdSkWTekeO5VOZoqu+Xa4bA8XFp2SCx
         721+UI5aQIaAcW7x6DOuZvY+iSYZTiu9ulOdJlUtQa3J7EgvnA9RhG3tbDbZ5qJ/5xxB
         CcPA==
X-Forwarded-Encrypted: i=1; AJvYcCV8rFnMpYRZrzXmDYDksTfehoU+VQv8NTYEQGPyNb/t3XaUuVEHg9da/jHNUz5q0QdX9e2FxPt3FRtCIGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymVSnjpWmoBWJxeFxiu+zIQxOsFb6wbTGKBstQpHdxAMFeZ0G2
	BGnlSrSHOtxDHMtUTGBqbQokEOAE//4Wm127TjzOc2K9b5S5LlCYxkFWAXDGsp+JGbjLTn9FPcs
	g4iifodN2MXyLNQ+BShMAI+9xm7hnDuVOWRGRP/B28aYg8Kpgb7zb2ZTxo8K8MAu4ro42XO7lNH
	h6
X-Gm-Gg: ASbGncvCh+eOCbgSLw+fES3+J+o16XuKsLgo+q9nFxRqfXzvIilc5B8ZUXxcmai0oNG
	53sv/UGINYOnTRkyVWzORiI1vqE3ljVzNZZVHXDjRX98eWIusJCrK7V+56DXyf1YbFLFdTcccln
	c5BRwhr6bdVL047LhJWNhLkIv0SFuQqWwAk97NidDEZdONnoUP8qgz2Ktey0tYCl2Tsbje8GaZI
	MvpO4IgF9A42IdMEVzVLWnNu+n4dNueQaKJk+2SnXlA8HQnjgtJkEDd3stNK6kGnvBD7hQufTcc
	LQdY/Gtz+YY8Y7F8A84HiK5LrYg7tkXSWvvhtbudnRt8i6laovxBfifYDjEJF6zekCSmP1InEhC
	037iqFyvEykO58Z9HnIlKqRQXmtMIFbY4iGX25VJ462FtHbWihpPja2vsmBnIJ2yYPzs=
X-Received: by 2002:a05:6000:1a85:b0:3a4:dfa9:ce28 with SMTP id ffacd0b85a97d-3b768c9e9c8mr2141928f8f.5.1753267353155;
        Wed, 23 Jul 2025 03:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBt4+93UoX/205gdSVHqW6TkCtkYcBPzB53eQgybG4ryPkzfHwVCMU79xDSUPLge1iyPsKBw==
X-Received: by 2002:a05:6000:1a85:b0:3a4:dfa9:ce28 with SMTP id ffacd0b85a97d-3b768c9e9c8mr2141897f8f.5.1753267352597;
        Wed, 23 Jul 2025 03:42:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a? (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de. [2003:d8:2f00:4000:a438:1541:1da1:723a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d732sm15854726f8f.61.2025.07.23.03.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:42:30 -0700 (PDT)
Message-ID: <da0ef45c-7e31-4e87-a4f5-c320c25bc7d8@redhat.com>
Date: Wed, 23 Jul 2025 12:42:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: add MM MISC section, add missing files to
 MISC and CORE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20250723095823.21940-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250723095823.21940-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> +MEMORY MANAGEMENT - MISC
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +M:	David Hildenbrand <david@redhat.com>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Mike Rapoport <rppt@kernel.org>
> +R:	Suren Baghdasaryan <surenb@google.com>
> +R:	Michal Hocko <mhocko@suse.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +W:	http://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	Documentation/admin-guide/mm/
> +F:	Documentation/mm/
> +F:	include/linux/memory-tiers.h
> +F:	include/linux/mempolicy.h
> +F:	include/linux/mempool.h
> +F:	include/linux/memremap.h
> +F:	include/linux/mmu_notifier.h
> +F:	include/trace/events/ksm.h
> +F:	mm/backing-dev.c
> +F:	mm/cma.c
> +F:	mm/cma_debug.c
> +F:	mm/cma_sysfs.c
> +F:	mm/dmapool.c
> +F:	mm/dmapool_test.c
> +F:	mm/early_ioremap.c
> +F:	mm/fadvise.c
> +F:	mm/io-mapping.c
> +F:	mm/ioremap.c
> +F:	mm/mapping_dirty_helpers.c
> +F:	mm/memory-tiers.c
> +F:	mm/mmu_notifier.c
> +F:	mm/page_idle.c
> +F:	mm/pgalloc-track.h
> +F:	mm/process_vm_access.c
> +F:	mm/ptdump.c

Another thought: mmu_notifier.c and ptdump. have the "core" vibe to them.

-- 
Cheers,

David / dhildenb


