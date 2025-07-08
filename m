Return-Path: <linux-kernel+bounces-721581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22B3AFCB48
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAF73A54E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F228137E;
	Tue,  8 Jul 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QXTJyVzd"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED0214A9E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979787; cv=none; b=nSTHXK1R3nvdLRzAiAVRqZoBBAW1drRFAmUWAc3GTqRT1FZkUi5T5G1iOkd/71tW67YrGwYLMZ8nmgMaLLoZ+iwRjAXHmzA2mdNMFrDsPb3u/zDcGPmR1ORJNSwgpRVo+n2p+8ntszAkI9AnAb/am3ByM2bHems/VQV4Roxhkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979787; c=relaxed/simple;
	bh=Y3ssvtVdT6GjWAm8mQjmaHBVjpYwMBCiiVf9vi3pxuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4gRPj3WK4gjVdNVqB7Fi7twwI0u/MicKZsAiMf7ZqJNWbeJDi2OV2x74UGhQsUBkRcqKLiqeJftgdDvOUWq5Am3MXL1LjhE9sU1f1QAe5crjj8Y6LixmLKE4f2uH7aQWL3cb1wij8+zFRcXiYVpgaoyI0rwhbzCBjRH9c2IWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QXTJyVzd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so25711205e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751979784; x=1752584584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBNKDiLRChysupmqvHKYT2mfcl/4n2UVzs+2m0NT2FQ=;
        b=QXTJyVzdueIRU0o9g/i9oqv+5txIZIlJkNbHBbgkqmzy/thsWqAT3kwYEnLTrHM1oi
         D7V4x4KjWXmC8YUTfzCUZOfpruFp0y3SKADlUrcD9ymfZ/xz6NqQmmp14+SON2LpaZ9Q
         S7NEmfS4u6wVRBgo+IhsPrYbN67Czj6gfJLhFpW9i3s1rb0KdCGdEoMO1eLjNbXCAHOo
         GbIiipQVjtdpv+ysL72zUvD5UtsR5Rvyp4phzAgc+VX7Bg8UfuI9NyVxEpBWf4wuojWz
         H4PP4EMfFhHxXNLvFUGaoIIWmAB2AlTpcl+SOx4fRfC2d39zO1fvTrBaFvrAiM/I48uo
         EhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751979784; x=1752584584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBNKDiLRChysupmqvHKYT2mfcl/4n2UVzs+2m0NT2FQ=;
        b=wEseXRBFGkmcjZC45BVUXkNJ3e/mCgosPpifzkgGCUd2ILCFkkMkZuFYfvVR8UvYsw
         gGQ5eYrLGi97c+D0y3DSDPFgoHf+YzpoaYMCdyKIvSuK7+owS8t52A5RNrJhBEA2Npc2
         hSlLwy9lrZiqigx6BdplAFBlizVyOpWObC+2fxKgxFwOgiFmqnYR8rBkqRpQ5a3lLRE8
         Ibe8lpPdVJJiUjpuHgJppE68/BBlxbqa1vwoDiFvVLXPp5ydUvm1j9++c1AkekzhFN1z
         p5cJ6bJ5WEv2eRy4V3iHrZYbW1wMYuCfYRIE9jxk+PBA2rfR5oSuRJiFCdJ1Hwl/KfNt
         gjsw==
X-Forwarded-Encrypted: i=1; AJvYcCXR50AGHo8YThA0OMvQfbLnQbNhUONbxx9xT4YCNp1BI9Hhp7kE7clXFVs/YHNT2V5/DuIlb994xwLgoW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mwwRdQjK8hjG0gRFMBy9OqkptIyZHK41ZZzEQPfKPcScmoqE
	3qOp/3QeFcgOJVkOkkfflg28TsHubMaxSLgCVnd/9I9tbm55hX8Hhd5OvWxd1mYkC7E=
X-Gm-Gg: ASbGncsKh127QauRWcNPPc+sfgdxQqG+zmzuHH1Osm8GwtlHu609W/qpQj3PoJGwCfl
	auZok+pQvp3pNM07ZIvprOJD98DyzPiHTTf9M+udE9mtxs59LX9jWpl1OWy9JgbqaFCuilNvS3J
	XWNtxPs14pO9vSdTz6U59Opz9qVyiuwrIKB+7jZ5+fIIXwgCRChzeOt9xEPYHBmHljDiJA464j2
	qGwcysyVWSFmzFNCVeDXvhrQSYi8RjTNaZJX927L45RI8QGKghINQl1w9EDXzqpNGfbgKQfh65m
	xC+JNY+mM589gBGowE49a5rTpCtx+fKt4aDAPLvmXDPZ7HY0//oYV4eX7kFEyuck6g==
X-Google-Smtp-Source: AGHT+IHMi4WXnVkZEVqB8NLtkDRu4v1G03GHPDZ2k6n5a8/P6IJD/eLFHdZsgcA96vMaGQOq9oe5XQ==
X-Received: by 2002:a05:6000:386:b0:3a4:f024:6717 with SMTP id ffacd0b85a97d-3b4964ebe27mr14567959f8f.53.1751979783397;
        Tue, 08 Jul 2025 06:03:03 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0941sm12821553f8f.26.2025.07.08.06.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:03:03 -0700 (PDT)
Message-ID: <20c5feae-25c0-4c8a-a40a-b35cece6c166@suse.com>
Date: Tue, 8 Jul 2025 15:03:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] module: Restrict module namespace access to in-tree
 modules
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthias Maennich <maennich@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, Peter Zijlstra
 <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 Shivank Garg <shivankg@amd.com>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
 <20250708-export_modules-v1-1-fbf7a282d23f@suse.cz>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250708-export_modules-v1-1-fbf7a282d23f@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 9:28 AM, Vlastimil Babka wrote:
> The module namespace support has been introduced to allow restricting
> exports to specific modules only, and intended for in-tree modules such
> as kvm. Make this intention explicit by disallowing out of tree modules
> both for the module loader and modpost.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> [...]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 413ac6ea37021bc8ae260f624ca2745ed85333fc..ec7d8daa0347e3b65713396d6b6d14c2cb0270d3 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1157,7 +1157,8 @@ static int verify_namespace_is_imported(const struct load_info *info,
>  	namespace = kernel_symbol_namespace(sym);
>  	if (namespace && namespace[0]) {
>  
> -		if (verify_module_namespace(namespace, mod->name))
> +		if (get_modinfo(info, "intree") &&
> +		    verify_module_namespace(namespace, mod->name))
>  			return 0;
>  
>  		for_each_modinfo_entry(imported_namespace, info, "import_ns") {

I'd rather avoid another walk of the modinfo data in
verify_namespace_is_imported(). I suggest checking whether mod->taints
has TAINT_OOT_MODULE set instead, which should provide the same
information. The symbol resolution already relies on the taint flags, so
this is consistent with the rest of the code.

-- 
Thanks,
Petr

