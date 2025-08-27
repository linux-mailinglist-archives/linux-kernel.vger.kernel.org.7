Return-Path: <linux-kernel+bounces-788037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5401FB37EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4F7A4228
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287B33EAFC;
	Wed, 27 Aug 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGKvdeIB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F694283FDF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287543; cv=none; b=oQGY01Y4PCl8nALnYKosHBbbuqlRi/C78TodokcHnJ8wI0t+KyAdUKxe8SF2pgXt7aQSx8p2VSY9ptu3AB6MfwwSFB+4qrxMFfib5mnuEc45e9IJ7DPOccG7gakdSjCOoFu/atb6soHNXWXpjTBtqSlRtaDrNc28KdxeeNlhb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287543; c=relaxed/simple;
	bh=Njw6e9/Js+xn22JCoiqtyu77vUHmcJJWB1gGbykgKeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZMdBe2J72B77iR5SH3Ohn/s4xgTKTknYjjJmjAjWXzGq42PvhmiNIXzI2JU7RWcFBuUy4gYjqThKVlxgsqHO7hhmweMChkwopnno6DbZkUePyoHQFf8Advsryg7JVv8xW3yODsoID/9kjdUys6Vo41fzRkC+ybw1cVGZjf8JMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGKvdeIB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756287540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NDareXP0zA0Cp+JZgCavNWq3AWwIIJKps4a4WMg3dr8=;
	b=QGKvdeIBXqPBifyWuSEoQbrfshAuYaWAYFG0dKz0KXlZe5NMExg5EXcUF5V6ngDQRRDjg6
	ozu/6gtMIGaJNtLzRTcLF2JnTsOz/YmhON+RmH3sSzrQnQBu6c0C2aQ1uu+8cZx5BCgQLE
	G1EAPxHhiPvVyzlGBMuqxUetJP51yAE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448--9SaURycOvusgs6umhzyqA-1; Wed, 27 Aug 2025 05:38:58 -0400
X-MC-Unique: -9SaURycOvusgs6umhzyqA-1
X-Mimecast-MFC-AGG-ID: -9SaURycOvusgs6umhzyqA_1756287538
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b28434045aso251586551cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756287538; x=1756892338;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDareXP0zA0Cp+JZgCavNWq3AWwIIJKps4a4WMg3dr8=;
        b=pxbH0zwSMjDj/QUgA5Z0rAAWs373KjeErpiksC62ymWMTomiaofMj2vfE9oUMU8YJY
         SLCbQHr2YCsGPVwPwAZLQEEyGOWIO6fDmebX8OrS4qv4CHyhqBYtEbmi21hg0xTnJG3W
         bd6j/Ngn1iIqt4/3saRjMsZ4rNu9mvHuXfKmzL7OaXkUNkKWGjzElORkEOt5WZcC9ky0
         ONz16p9hIOdrXE6XNXRfznyVBrlh8aJbkwv7rwYnVnZJA7bUgwlfLEgvv6QZ6RM96hPd
         x4w3WLrfJ8ac8evDpGfhTVYnveDO2fOEb5Tpg6RZja9HUSWq86HLxzZSrJ8IIINLQJeM
         P3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCX2IErJHs0D0kHiUjU9xJEqoZLBoN2c5So3UzopfOnw9dWWCxVP6gkfLC1Pp1L1vaHz/6qP4IGkeSJrSyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDktLkPWRYDfwpsuCNsCYVBOa9N8sVEwK/kPGDLFiKZtKncTc
	KtSUTD3oljVtPX3OgOQN7+qI/HuF6ldcQB9VqhVvhmC4lrSWYdpKLsj5JIZVON9Sw334tjKKU+X
	vJX6UncYmq8ykdotKmtjcnHRqr9T1YBYppdLk5xrPDDVl4Jn+6unc8OEGK1SLYxDuqg==
X-Gm-Gg: ASbGncsQr28P4oP51Fr8fsQdxiHue2gMdhfI/uk0AcNEuCpFzDoM+YS+ycMVwxOgvvU
	ZuPvNycWfXWeNQu7DIINTLoTSM5ZuEHFZK8NNFgAiqXYCSUbYm3OyHiBfrLTcoYvyCI1rlnnMBz
	fEgQCUMHZ9DKCzw0Hzp0YT24B3tJoHZK/eZJX0cqhclxd3t2n9huqU8dVkt6h4jbT4iMdIdZuXk
	+hz4R5p0BLXczg+eDxwmqXHLasW/s9UZCwC9FKsAhHGQiS0Pk9JJVvEy0vqpeuXlZihD3PcuVmN
	2IxmlyN9ghl7Z0ORBl1UiITsPP6Sa6Ca8ritmHkwobUJSrt+Xu4RPYQCdhCeZQ==
X-Received: by 2002:a05:622a:4116:b0:4b0:76a8:2d3b with SMTP id d75a77b69052e-4b2aab4b25dmr254349991cf.44.1756287538139;
        Wed, 27 Aug 2025 02:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPbbCdrZwwAN1B8VRcWZtqkCoaZcEbgpK0aDOziyitGNq7xIIbFIW1coG3LuFIn7qTi1Tmkw==
X-Received: by 2002:a05:622a:4116:b0:4b0:76a8:2d3b with SMTP id d75a77b69052e-4b2aab4b25dmr254349661cf.44.1756287537627;
        Wed, 27 Aug 2025 02:38:57 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8de5fdesm85480771cf.31.2025.08.27.02.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 02:38:57 -0700 (PDT)
Message-ID: <66dac672-88f8-4101-9a66-382cd3794756@redhat.com>
Date: Wed, 27 Aug 2025 11:38:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/swap: add BUG_ON(folio==NULL) to folios_put_refs()
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, shikemeng@huaweicloud.com,
 kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, chrisl@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250826231626.218675-1-max.kellermann@ionos.com>
 <20250826231626.218675-2-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250826231626.218675-2-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.25 01:16, Max Kellermann wrote:
> It is not legal to have NULL pointers in a folio_batch.
> 
> However, the Ceph code does exactly this, and a refactoring patch gone
> wrong has exposed this to folios_put_refs(), see
> https://lore.kernel.org/ceph-devel/aK4v548CId5GIKG1@swift.blarg.de/
> 
> I believe this should Oops instead of crashing due to NULL pointer
> reference (guarded by is_huge_zero_folio(), which may silently hide
> the bug).
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   mm/swap.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 3632dd061beb..07ccda00e7ee 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -952,6 +952,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
>   	for (i = 0, j = 0; i < folios->nr; i++) {
>   		struct folio *folio = folios->folios[i];
>   		unsigned int nr_refs = refs ? refs[i] : 1;
> +		BUG_ON(folio == NULL);

We shouldn't be adding such checks into each and every function that 
expects a valid folio.

The is_huge_zero_folio() is special because it does not crash 
immediately when the function is abused.

So we don't want this (and in particular not a BUG_ON).

-- 
Cheers

David / dhildenb


