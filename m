Return-Path: <linux-kernel+bounces-733330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA902B0733A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEC13B37B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4F2F2716;
	Wed, 16 Jul 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGmWOLFf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E742F363D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661176; cv=none; b=a5L8CsKJFRKGDRyVginrvVUelUviAvlccVPu2wuTD5G4arDvJQrrmLtEBS4/Tw1ITp9pq07/iNfNnaFtMT4WHVr6KhPlWY0/j5q0wl5ug4SpuiH+Thf18qGXNw0wY30qBr/9WNNN8xoPWzefDM4M1lnDD9Tr3hsY87O6kQwWhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661176; c=relaxed/simple;
	bh=5YbaRy/hZTd6VLCq7d5l7gZw1OlQvy1DURJPQGs9Wr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1O8LpKDJZQMr+EwaMXfaB3WLU5ZeOwGud2COmNV73oDuFZK6y44t4JWIeJQnlqa1a+KRQDDmeNr1bGe2sjYWSDPs53jbJnTY8B/G5gKVgwy6jupsok0qLmHpKUVGK44XwYcQq4+NaycSrTk884JutlD9nTnEfEM/Idv9dGebSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGmWOLFf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752661173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RD+mibk5Ud3TFOH/RD4uYn7uTOHZQQh3UhohlOST2QQ=;
	b=NGmWOLFff8o56UUeLuieVGMyqRAZZaLXalwiRnAqTY8/gDxW2V2msjHH5WNqMki8jRpzXu
	lvcSWvvnn2Ih0IoWMl7Mk8qJdQtxOniDXToxZrnMvD1eNXSNBQMMrB4Z+J0a9wgpW715Wc
	RJKmw0kHKuLUX/J7jfx9fK382JJ9jvY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-4p9HpNylNF-MJXZhUCN0Ug-1; Wed, 16 Jul 2025 06:19:32 -0400
X-MC-Unique: 4p9HpNylNF-MJXZhUCN0Ug-1
X-Mimecast-MFC-AGG-ID: 4p9HpNylNF-MJXZhUCN0Ug_1752661171
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so2567613f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661171; x=1753265971;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RD+mibk5Ud3TFOH/RD4uYn7uTOHZQQh3UhohlOST2QQ=;
        b=J48u0n/txCDcwEgKbZC7pDe8qxl57I6aKxeKuxJtM80fKehYjtLPw+JKn8Dvq7MO45
         pDc/ujh7nK50z264NR03LN0v2cp+1VJKfxQGNtguCzSWyZewA3dqREL3SbL2XuwL35j4
         JdN5yjotv4FpD3mTx4u6H4Jy5eYHDtM272JBW4c2tS7Azp6M2swJlMIcMNFSZgG5w/rq
         EY1sBBRJzK8Z3WLFI+DsfEhRzK9806DaTPe7TAoF7hKSQWQHhfgMPXoKw4x8BqX3INTW
         DqzOkeh9a78+F9QUdZ4zzQpKW2pN7W4UXtySIAOX5lwn1BRsbKEZh5cl6V/N5ZL2EiyN
         dnAQ==
X-Gm-Message-State: AOJu0YwsbA1rM0SBLU3gtwiDcqQBXIerAwRCC5m3o5Wm9FfbiZGUH+1c
	Y2XXpLsGJDr5j8ZwZ11rg8ljU1ziuNJqoVl5zyzzNlVx+GKn/4DnfBYwCDl1WmR6OmS75wYDdGp
	i/mS7K/If/tVRXe3KOAmxbIFkBfzV+8/+wZcCHPomYvDw+HM7jPsMAdVSI+3Q6sqfhA==
X-Gm-Gg: ASbGnctYwcZj8CLev91YD0y0r27//y7CgN3o8321I5I1wBULjmAVDCeepOWM2VroTlO
	9ndvWl97LQVAo9zG2zQjHaz68KgCsS9b7F/tdb/sJ2Ubb3+wbLUb6Q7RoZLcqzTnK3fK4hW2+BD
	t6LwrWll4Z8mJ/yGEbHO/rRBDP9T6rbK1v5IEHOWqSTFvOhwYVxh2bt3fmJkaWOME2cFWSmWY8K
	DWXM9v8nSUIbX9LXxb90CUNIp8+DitwZP3ZSYoGY2WC6stBTwb8MbLq8BZAys96CuFqfGTGOAtC
	PMaY8yYeoPkGV2gxJZthGws2de7Yg0kF2MYy3/phzCc6loDo4ZDm3LBhrCSHUJEofB0f7J9uvia
	rjrQiajWIRYPQps3stDmiLAS86E35tBAAHgE0dnAOL7zcmjsFTuNh805e8J5WTqoEC18=
X-Received: by 2002:a05:6000:2489:b0:3b6:c88:7b74 with SMTP id ffacd0b85a97d-3b60dd918b1mr2056089f8f.59.1752661170822;
        Wed, 16 Jul 2025 03:19:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOdP5/JIvUYKpIbxJNQWhLOoknuYzXxGRBz627SKnreGxi2a7RCGFHQrxfPOEEndJscLarPw==
X-Received: by 2002:a05:6000:2489:b0:3b6:c88:7b74 with SMTP id ffacd0b85a97d-3b60dd918b1mr2056062f8f.59.1752661170412;
        Wed, 16 Jul 2025 03:19:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5f32ed100sm14506640f8f.0.2025.07.16.03.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:19:29 -0700 (PDT)
Message-ID: <eb05e517-033d-4059-aaa4-05e996594182@redhat.com>
Date: Wed, 16 Jul 2025 12:19:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] fs: stable_page_flags(): use snapshot_page()
To: Luiz Capitulino <luizcap@redhat.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org, harry.yoo@oracle.com
References: <cover.1752499009.git.luizcap@redhat.com>
 <52c16c0f00995a812a55980c2f26848a999a34ab.1752499009.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <52c16c0f00995a812a55980c2f26848a999a34ab.1752499009.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 15:16, Luiz Capitulino wrote:
> A race condition is possible in stable_page_flags() where user-space is
> reading /proc/kpageflags concurrently to a folio split. This may lead to
> oopses or BUG_ON()s being triggered.
> 
> To fix this, this commit uses snapshot_page() in stable_page_flags() so
> that stable_page_flags() works with a stable page and folio snapshots
> instead.
> 
> Note that stable_page_flags() makes use of some functions that require
> the original page or folio pointer to work properly (eg.
> is_free_budy_page() and folio_test_idle()). Since those functions can't
> be used on the page snapshot, we replace their usage with flags that
> were set by snapshot_page() for this purpose.
> 
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>   fs/proc/page.c | 29 +++++++++++++----------------
>   1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 936f8bbe5a6f..52e4f49c0638 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -147,6 +147,7 @@ static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
>   u64 stable_page_flags(const struct page *page)
>   {
>   	const struct folio *folio;
> +	struct page_snapshot ps;
>   	unsigned long k;
>   	unsigned long mapping;
>   	bool is_anon;
> @@ -158,7 +159,9 @@ u64 stable_page_flags(const struct page *page)
>   	 */
>   	if (!page)
>   		return 1 << KPF_NOPAGE;
> -	folio = page_folio(page);
> +
> +	snapshot_page(&ps, page);
> +	folio = &ps.folio_snapshot;

Not sure what to do here if the snapshot is not faithful. Fortunately, 
it shouldn't happen often :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


