Return-Path: <linux-kernel+bounces-861657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087BBF344B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9DC4837C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4719D2D130C;
	Mon, 20 Oct 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev4E+hyo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393A244687
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989589; cv=none; b=G4B6RfXndVc3UroY8tRM/tLsxoC4d0COp9UFDfx3iWpl5bJcc5SxhAQ+Jqu4Z5Z4sxeE1DwvCcBd4ay53N7JqslnamUd82gSa95Xzor35UNeHa8HjIPsOfjBdYGBz7SDwLjsLwM/PsK9u3it/MhnEU0qiK/xiPb8c2XsO1gugTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989589; c=relaxed/simple;
	bh=WSFmyw5fnYrjp5xFEMP5/G0Tcgq8vmi2OV0liwZaUTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efNKhUWHg1TiD9wN6h2Sfbz0tzXO1cNI26PshuJ83zHgj+Og1bZQxYk5o566HH2yQQrnWc0b2QeUyNMFZb1DZc+DzfwR/QaBKQI8srnkwLu/rT+GR3aNbs29oXqJrx8DO0KxbImszuZsdFIPkFEJnscaW842p5UtHhLOfeFXOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev4E+hyo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760989586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/nsYu3sxWKw35kclt34jyQDkTPvyZmJq+s80Nd/F8dw=;
	b=Ev4E+hyoTBSe3skUIIRd7p6OZppTM852E6PBhRobE/v+unsiRnqjagkpeT7k1kFF8vdHni
	p38Ny9egth91vlk7x7En5EXAuGB8HVMks42iycVkz8HDjgWMHSIR/aD+qfLsPMbC3PqfDD
	jqN7P3nu2K5X1c/QXPQNNOfmxRP0LxE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-Ade-wHb5Ozeui-vR-oOUYw-1; Mon, 20 Oct 2025 15:46:25 -0400
X-MC-Unique: Ade-wHb5Ozeui-vR-oOUYw-1
X-Mimecast-MFC-AGG-ID: Ade-wHb5Ozeui-vR-oOUYw_1760989584
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso37048325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989584; x=1761594384;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nsYu3sxWKw35kclt34jyQDkTPvyZmJq+s80Nd/F8dw=;
        b=H+zbtjRS3vONCqSsR72aQc3XbKpsFG1kBvXM610Fn8tbx/wCL0hrBkMfr68cGhPLVn
         JOVxyl0EnzqT1MwOY/0oakA3hynjcaL/KXKhN3TJ6USSsDnXzLmY4bUjAlWqcEMVp2FC
         T5BuiKJwDlBgGBkgNlA/sBJ7ekrYjYXZ1tPFAcprmJtcR/eMENvTh870D1PnPR3E78So
         Rl/F3NnMK/KSZAmFvBEslTwrE/1q5B/svS+tEOmsM4JMZ0Z8KKbd8eiOvFKMUYwU1cvA
         iVsEJfLomp8VD2WKjPY7Y/513GzVN+y/jMZAIfEWvGRQ0VyHk50e+NU9cwnnhPPL3/bE
         Q0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw5EvfK75GNO6p6+SavqtA3e/UF3azWhuu97hdDna/YZSb648vesYlaLj/ImNYlPLJgAStLs4MDwq7VEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuOJ19Ekh82ZbnfZVAaiBp/P3aOyokfSpOEamVfird7UuLOyt
	BwDyeXFxvjmd4DWJgwnvgnr8O7pvjLS2aDdOPvyk74/pxfXd8ToJ/x0Ijup3pWdG9uwI9IuL7Ch
	nvxYSPBUYMjZP4TBJ2UvWmPjXrlyK9gW3TJDpQR3DTi+jAxQv/1SEVcFq6FB60gn/lg==
X-Gm-Gg: ASbGnctfh/L+nTQHBBX43VVy7fUNsR9eMjAU+cTuYg/g/wM43PGy3bJ/GSqjkrlg+Vv
	8N5T9QN3FewUgRuRohslmEzNzUYLi0rbfBSFcvbSzu6T2P9syMxddrJc5UDhNo4zBE7jNQt5lZW
	Pp9VjGlskEmEdb+vpPjA2TQICkrhrcIUYp60Vg2rERxI8h1AWspX/yMvynTr8uWPM+CJOOhZVQH
	MnneYmubd2I47Cjr/vQ50WEryJwy3OdfnZAqFC2Ugfcp1n/Reio2dJ2W6YIr7D5+bXBDcIfU20n
	ksLWguXe5Ycf7DujD0szxB3v2YkWbDEGLl+zyia/r+LAtzPfcJ+upxrXwBeZiwnxQL0Tj34ENFX
	HiFAGDPPCgFkMAefw6cD7NwgkrOOe9C/KnKIkvNZ/mQ2cb1s82pmPH2yXzgt0NmHeqIPxUuLnW/
	B0Zw6hxK0/EPi1DGED6M0PZ5p0XM0=
X-Received: by 2002:a05:600d:62b1:b0:46f:b43a:aef4 with SMTP id 5b1f17b1804b1-471b5341411mr35825855e9.38.1760989584104;
        Mon, 20 Oct 2025 12:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG41dKtmg/MhiuPABusf+rU2NYthrO92PlcqVEvTG4DvE2u37hJDq3TNOCRz6ssCTvqSlBdHA==
X-Received: by 2002:a05:600d:62b1:b0:46f:b43a:aef4 with SMTP id 5b1f17b1804b1-471b5341411mr35825745e9.38.1760989583729;
        Mon, 20 Oct 2025 12:46:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm163976505e9.1.2025.10.20.12.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:46:23 -0700 (PDT)
Message-ID: <0d92a675-ab24-4b1c-be71-956f09a9e973@redhat.com>
Date: Mon, 20 Oct 2025 21:46:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
To: Gregory Price <gourry@gourry.net>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org
References: <20251020170615.1000819-1-gourry@gourry.net>
 <487730c6-423a-4a03-a668-9b9ff92a5cfb@redhat.com>
 <aPZ0OKx_VnQ4H_w1@gourry-fedora-PF4VCD3F>
 <609E7E01-33A6-4931-AC89-1F4B2944FB64@nvidia.com>
 <272c425a-b191-4eef-af6e-2bca1db7a940@redhat.com>
 <aPaQNYsN_YPDOwQG@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aPaQNYsN_YPDOwQG@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 21:40, Gregory Price wrote:
> On Mon, Oct 20, 2025 at 09:18:36PM +0200, David Hildenbrand wrote:
>>>
>>> Basically, what is the right way of checking a folio order without lock?
>>> Should we have a standardized helper function for that?
>>
>> As raised, snapshot_page() tries to stabilize the folio best it can.
> 
> is snapshot_page() even worth it if we're already racing on flag checks?

I think it tries to handle what compound_order() cannot easily handle, 
as it will retry in case it detects an obvious race.

> 
> i.e. there's already a race condition between
> 
> 	pfn_range_valid_contig(range) -> compaction(range)

Can you elaborate how compaction comes into play here? I'm missing the 
interaction.

pfn_range_valid_contig() should be only called by alloc_contig_pages() 
and not out of compaction context?

> 
> on some bogus value the worst that happens is either compaction gets
> called when it can't compact, or compaction doesn't get called when it
> could compact - either way, compaction still handles it if called.
> 
> We may just skip some blocks (which is still better than now).
> 
> --
> 
> on compound_order - from mm.h:
> 
> /*
>   * compound_order() can be called without holding a reference, which means
>   * that niceties like page_folio() don't work.  These callers should be
>   * prepared to handle wild return values.  For example, PG_head may be
>   * set before the order is initialised, or this may be a tail page.
>   * See compaction.c for some good examples.
>   */
> 
> Seems like the correct interface given the scenario. I'll poke around.

Yes, avoiding folios altogether is even better. As documented, it can 
result in crazy values due to races that must be handled (like 
compaction, yes).

-- 
Cheers

David / dhildenb


