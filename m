Return-Path: <linux-kernel+bounces-828129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F4B94006
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172A418A5917
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE76B26A0BD;
	Tue, 23 Sep 2025 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adXGa5+C"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77EB1CAB3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594545; cv=none; b=sFJulQsKOOF5EFK2yxkKzFOBGmeithy1n5+AdJk206tynmLLkT0YVaibA9R2u3Rcpce/+mqbh94QFFO0E29DaKHRufS/KqZkOmFiqHbuvB8rcjI0AQo2YKDNSQZqZlCRKVW/F5IUHnMh48405qsX+iljG4/IXyhSqp/q+Ndki9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594545; c=relaxed/simple;
	bh=QwwqmZNZOyX2bK6+W+0pGizSNfpwdAJV/geF5Gpep5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr8pAW2+bXJfsuwafekFUeJKcC8HeTXtmEP4zzQMFRuHwXmO/oABlIJQJ3jxCUGSUFBgnEJ/4h9qYaI9sxMUv163HD1MGbX0HKerVXcxld/2uwvN+FEk6ZW2a7QkgobbQVAGHmniMesOEjkjyj2gSAtiX2BTNQCyN6qIVe4pedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adXGa5+C; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0787fdb137so772955266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758594542; x=1759199342; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBqHLoQEf/Npt09p7CWAiUjG43kXXR8Q43uV99bdbew=;
        b=adXGa5+C05ueWgc0pzXMR48oB80Tf+dfRvwu8NucQAJ+2VNmAINuiq1ad1g6o72GSS
         s1g6suFzAj6YQO4ScdCgAtYu4faKUhMxQCtFS+3GGx+H+YoGrg7ke0S8AF7i5UqonqnB
         wiKM2ubCipWku/FMvEhKz6JRS/9/T3+2B8p6oZNmSdDBn96dQ3AWDOObrTQCniX728dO
         AC9za+C+CJ3tyE88mnQUbVGlT5XUOSR213zeFIK5bpZDBOhk/BuSK+Y76Cj6GqY1FjZ/
         ivFor1VZ+bStDpdChlpqPNRj+eXKauHkrBxnbu7ig0wsP95H+LuEouhImW/lYzYZGB8B
         5EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758594542; x=1759199342;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBqHLoQEf/Npt09p7CWAiUjG43kXXR8Q43uV99bdbew=;
        b=DYvjZIndF2JvFCn1Me3Ye6yBCH64fF5CxzskRJjBBUwTQtP3L9WnxSxIZLQMYxdlVq
         ujU0ldhZTsGj+cdt9pt7TU4YW72mpIIKX4SJd99Cdc6jACMwypHyzXIVW79LZYW63NeR
         AA51o8HD8WF4+WwcKN1dvhdQj9mWJGdrMnDN3tjin9ZxcJZXb6h3BbOGHfwKvf+EDCML
         Akt4Qpya6N4AyLPvUZedXQ72XmnEglghJQ9ix1a7/yTkqxVMOKrmNAHaAqphvtzwrYC+
         XBfvKg120nmVYXVBVzaFcbpCDHY5WlLNj9a297mk8pA9jJ6ssCM5VDr4eRcNXTJh0QGl
         hl8g==
X-Forwarded-Encrypted: i=1; AJvYcCXn2Gub/Z4Nkpx7L3Agzn2i5v2uNao9Q2yFaBQ8RosvDRmJuhhzlw3utQ5ZJdGj64+uutXnQDsk9uCqcBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKWn2NlNpqht3rG2MDIGQf4OK9NgHCvgcJBxI6pujKstp/HsUV
	mTqKeUpyjkvtNogq5rDhju/p0K2n3qa6Cd264+Lf5EEHl3CkyFBq7qDw
X-Gm-Gg: ASbGncsGCQoE5QoIYW2jVSfqyosLl32V6rzoLJiTKv9YoODBI10ipp20KEJI+p7pRBN
	lDVCqf3NLROAk4I+92bNufF/AUGpnDqkAxQ0QbEXcGfSirDE1vcUVRElpkfJdIEV7vvBK6B0Xum
	m6qHafNDAwiaefwlOZtwQHcd/RJ8KpSavgOozFa19LIv3d5adrdaLlNM9dVTJaBLTx5OYbUXFbW
	TPGoxzya8DWHAxZP5ItkozuM6TYy3R8rtB+TVHy4+sck1mjrZXuK36bzsvU2CkKgmEeBey7xn4y
	fn8ps/N0wS26Ift+aH8LZJIKwyhXbjepyVErzBRRPEVYALqck9Jng3d09xPlKQB66x8gl3i+MgW
	hpHNsYrO25KzfhODAorxgq0AbgX6K0ZL9
X-Google-Smtp-Source: AGHT+IEIHMVCIffPBe/9Z5NBuOjCfg4C5FU/n65GHAiYlD0hvBLo36yOCIQ6ZXcmw0EH50gdL1sw8A==
X-Received: by 2002:a17:907:6d16:b0:b0c:fdb7:4df2 with SMTP id a640c23a62f3a-b302705e540mr73287066b.21.1758594541891;
        Mon, 22 Sep 2025 19:29:01 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b29e6597caesm580894566b.73.2025.09.22.19.29.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Sep 2025 19:29:01 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:29:01 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
	kirill@shutemov.name, hughd@google.com, mpenttil@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH mm-new v2 1/2] mm: make is_guard_pte_marker() available
 for hugepage collapse
Message-ID: <20250923022901.mzjqkrkdrwn2r7n2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-2-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918050431.36855-2-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Sep 18, 2025 at 01:04:30PM +0800, Lance Yang wrote:
>From: Lance Yang <lance.yang@linux.dev>
>
>The hugepage collapsing code needs is_guard_pte_marker() to correctly
>handle PTE guard markers. Move the helper to a shared header and expose
>it.
>
>While at it, simplify the implementation. The current code is redundant
>as it effectively expands to:
>
>  is_swap_pte(pte) &&
>  is_pte_marker_entry(...) && // from is_pte_marker()
>  is_pte_marker_entry(...)    // from is_guard_swp_entry()
>
>While a modern compiler could likely optimize this away, let's have clean
>code and not rely on it.
>
>Cc: Kairui Song <kasong@tencent.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Signed-off-by: Lance Yang <lance.yang@linux.dev>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

