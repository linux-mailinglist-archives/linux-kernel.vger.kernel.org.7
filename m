Return-Path: <linux-kernel+bounces-749691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CAB151AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2AA18A40B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB9F288C9C;
	Tue, 29 Jul 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yqzfRphf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I48tmce0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yX4hHVFV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XaVHeA8d"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE410215191
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807897; cv=none; b=k/vZ2bITj/UjZyA9F6k1xsiQMSjJecQxgNAuftRWToopZl7Adofr2hSWARI4Dc+HsUWWSStd9BNIanwWxV/l0Y+2rKv6haWNoo3/mE6TryEQSuQGxf/Abm880z1yx2ACmCvvoly4j6JGECRr/M2ocHxOHSfBmJfhbZLiWb0kNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807897; c=relaxed/simple;
	bh=f0mx+kaVduT/v2NM74LW2GyuqbsbRzu4OreGRNaNGSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PztlS9d2+EWg88BzjhXRBJYSdYKo24puxvOajXAj48H3NY0j3+KsPIJVFmJX1hXNwlsXQpkD7RNSM1ksQ+Shh+E9wTF5w3pNxHJ48gS8T8kxBnz92pjhIYUeBiX5SRkfFMPIbSQ0tzd48qVFnUq5j+SpsPC3Z9s/ZwwQm12GF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yqzfRphf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I48tmce0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yX4hHVFV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XaVHeA8d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE6CD1F385;
	Tue, 29 Jul 2025 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753807893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B9zblHd7B1NwjU/h+HwxYaQdPAptYF7/21/a0/VsbEc=;
	b=yqzfRphf9jC5BiFyxz3fXNnbJmByA+v9APZxQGIaP9Krk97OwRCMuTvlnOu4Owe6LcF7k7
	TPHGUohLV7gU24pVyW3INz7OZ6NZ3RblqTlV6AuQpoX+0cLtybzcmXegGXlbeAFzmU4Ywz
	S5li3mLTsZx6JkLwDzK26Pt4ewIuBn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753807893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B9zblHd7B1NwjU/h+HwxYaQdPAptYF7/21/a0/VsbEc=;
	b=I48tmce0ZtJOcexFDq52omqHVzhRrINZ9jfwRmeTrUH+korNd75DytPlNw5mOHQUqlReSg
	DraJ/rWVioA94NCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753807892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B9zblHd7B1NwjU/h+HwxYaQdPAptYF7/21/a0/VsbEc=;
	b=yX4hHVFVhrQY1PQp6QbW6Jdq57HzpoeVRm4yX2IJVThIW0eH+nLYfZtuvTpkjxPZHNOhGG
	UcY0xDGcykFn5DtDNC3qhO/IdFXudAcBALjtQbkR847Tnfu3UXjRSHm9qmka/FTqlNf83m
	m94aIvlPyqheOWUqowyyQAb8yiHZQyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753807892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B9zblHd7B1NwjU/h+HwxYaQdPAptYF7/21/a0/VsbEc=;
	b=XaVHeA8dY0LNEbmrPDrXmHXjJowE68u5ER+L4LkDC2qKC+xyJl8oAtOngCIlh2uV0B2oP1
	9cHSDWMOeys6vgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D477613876;
	Tue, 29 Jul 2025 16:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QTteMhT8iGhnZAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 29 Jul 2025 16:51:32 +0000
Message-ID: <5109febc-21b4-43fb-98a2-14c552c27bfe@suse.cz>
Date: Tue, 29 Jul 2025 18:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: add test for SLAB_TYPESAFE_BY_RCU quarantine
 skipping
Content-Language: en-US
To: Jann Horn <jannh@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250729-kasan-tsbrcu-noquarantine-test-v2-1-d16bd99309c9@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250729-kasan-tsbrcu-noquarantine-test-v2-1-d16bd99309c9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[google.com,gmail.com,arm.com,linux-foundation.org];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 7/29/25 18:49, Jann Horn wrote:
> Verify that KASAN does not quarantine objects in SLAB_TYPESAFE_BY_RCU slabs
> if CONFIG_SLUB_RCU_DEBUG is off.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> changes in v2:
>  - disable migration to ensure that all SLUB operations use the same
>    percpu state (vbabka)
>  - use EXPECT instead of ASSERT for pointer equality check so that
>    expectation failure doesn't terminate the test with migration still
>    disabled
> ---
>  mm/kasan/kasan_test_c.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 5f922dd38ffa..0d50402d492c 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1073,6 +1073,43 @@ static void kmem_cache_rcu_uaf(struct kunit *test)
>  	kmem_cache_destroy(cache);
>  }
>  
> +/*
> + * Check that SLAB_TYPESAFE_BY_RCU objects are immediately reused when
> + * CONFIG_SLUB_RCU_DEBUG is off, and stay at the same address.
> + */
> +static void kmem_cache_rcu_reuse(struct kunit *test)
> +{
> +	char *p, *p2;
> +	struct kmem_cache *cache;
> +
> +	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_SLUB_RCU_DEBUG);
> +
> +	cache = kmem_cache_create("test_cache", 16, 0, SLAB_TYPESAFE_BY_RCU,
> +				  NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> +
> +	migrate_disable();
> +	p = kmem_cache_alloc(cache, GFP_KERNEL);
> +	if (!p) {
> +		kunit_err(test, "Allocation failed: %s\n", __func__);
> +		goto out;
> +	}
> +
> +	kmem_cache_free(cache, p);
> +	p2 = kmem_cache_alloc(cache, GFP_KERNEL);
> +	if (!p2) {
> +		kunit_err(test, "Allocation failed: %s\n", __func__);
> +		goto out;
> +	}
> +	KUNIT_EXPECT_PTR_EQ(test, p, p2);
> +
> +	kmem_cache_free(cache, p2);
> +
> +out:
> +	migrate_enable();
> +	kmem_cache_destroy(cache);
> +}
> +
>  static void kmem_cache_double_destroy(struct kunit *test)
>  {
>  	struct kmem_cache *cache;
> @@ -2098,6 +2135,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kmem_cache_double_free),
>  	KUNIT_CASE(kmem_cache_invalid_free),
>  	KUNIT_CASE(kmem_cache_rcu_uaf),
> +	KUNIT_CASE(kmem_cache_rcu_reuse),
>  	KUNIT_CASE(kmem_cache_double_destroy),
>  	KUNIT_CASE(kmem_cache_accounted),
>  	KUNIT_CASE(kmem_cache_bulk),
> 
> ---
> base-commit: 0df7d6c9705b283d5b71ee0ae86ead05bd3a55a9
> change-id: 20250728-kasan-tsbrcu-noquarantine-test-5c723367e056
> prerequisite-change-id: 20250723-kasan-tsbrcu-noquarantine-e207bb990e24:v1
> prerequisite-patch-id: 4fab9d3a121bfcaacc32a40f606b7c04e0c6fdd0
> 


