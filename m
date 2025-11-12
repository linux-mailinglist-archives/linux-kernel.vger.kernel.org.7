Return-Path: <linux-kernel+bounces-898196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 773BDC548B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57A734E1061
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1152D8393;
	Wed, 12 Nov 2025 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Up1JNdmi"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A2299A84
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981662; cv=none; b=ijpI90Y4xHjPf+KyR9XL2WhW+PPsWgU4lWV6emn4TlokelbTIpQpE3720CvcDVU9vWn4gSIUKpkPqQMGigvgnP+/N9qTRap37tuOG4KlkxGJFqMfDA4PJedAgxExUoAgAFmRqCEoZa3h/i9Has7MFyYmPKafNnXpfKRv8Fg3Wog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981662; c=relaxed/simple;
	bh=zO1tn0kzmFWbDQVibNc9JCshb0yeiQ/8QxyO7P2LQ/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdiAi6D23pZnNSYl4Np4wpNFsf9OWBySWEpWjpx3HWNd1vBzXQHtvaoruLHHtDkcGW4rshj+7UD9llxY8qb4iSbDwJOePxh26iFUVmqaKPnkPm41D/n5O5lW9gqw2Fmc4Vz/auU8T+lUOkd2bQkFirpt6hKaA5NqPxW0mr/W4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Up1JNdmi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so794650f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762981658; x=1763586458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pffp4YJmgEPVehQhCQRpQbir/4Kf8MhgjOlBoJD1oA4=;
        b=Up1JNdmirOvyD4YhMfjZdEkl46/RcVydq7wDZlx41/sj3aPOPeUtQvPZviHJNPx1rn
         oLDjPAmn+aZNXJaGL2iRzyZiba+xScTawopaSeH4yTRcQPBNUHqcVe6kwVpqeQLliRCX
         FOia5/RLzs/KK8IGyknPh7tGU5obd1trUDZ96qLrHZkiT+hVZH9gUpprENSpR5+ont21
         RFBuaJfFZcz5flTBbWXCfJcsBHpu1jMNtKxUIVFZHWlpcUck+7YiU/FkRin1vfpeT1OQ
         glNiVYNk4ESQ3aUufWhC5a5Y59nSEJ+kEJO2xUazHqO8vS1Zq/Z5JtQmdBLNwDefM7hX
         8ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981658; x=1763586458;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pffp4YJmgEPVehQhCQRpQbir/4Kf8MhgjOlBoJD1oA4=;
        b=FWJemd8bqh++bJA2aqTyiAr9gQ5mYT0kOZVZXN5+RVmmsWQeop+UXTqVysgWdOCkDZ
         A6cMue+ZmBFb7FlPZjeH407Y8n9VY0rZPsO1+RWqS5AHvbmQrVg4fwwnaPybUHM4wUWx
         WtTLm5S+aKM1njx8LmGonHEmieVjVs0tMjV1hZQXhYrC8Yxvbr81h1ac1l4ONCjokCWj
         w+Win3KHBKASIr6r5JokfC6QuSIDIKdX2MlSkqE7SuN6ieYcIekMrc7+AznfeRVLI7My
         1kg5rZULyTVwPOBzOML7VMwXUNcvC/ZDc50T+DkwIF585cT4ycJ4f48vY8gfAuMOtE9t
         CyDA==
X-Forwarded-Encrypted: i=1; AJvYcCWN1YpT5iLhberAJ0LDwT3IOZBYWn7U9N3/jOlNOHTLSKy+jBQzm8mcCJ/2ex5vGD4sq5mrLX/I/FhDFKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwg+kd81xy94+FM8cWzIlAxN+Mr1gbl9E6zYaf0ZXxQdhs1AAH
	sDiLYr6A6SJs5TN8/GlAcwpsng5RTBGVvU9iJK1q29/tVjJdNbpa6GXpxwlev+oTZ34=
X-Gm-Gg: ASbGnctPKSXPAT2pwrxSCC+Aeabice1X531mIoPKipLJT1cGKxV40ONeWLJGQn5QMQM
	uwOsptdqXsJoW3YaD3zsBqpft4SgxpvBMGzI09n78xv5OscCpoAT/AI1iRtnfc9t+87KQRj4+U+
	EcLFrJ9rj/sVfFP3Z7j0102TcB65QcsWGcNfPyOEDiz+v4rlyc8e50I1eQywny23Z75/HeZtydK
	x9XDiQKmeRR1Cj6kOpYL/+nXWQKl7NkNs7QD3sSfafW9I6/Te007SxP6+mzsS7e+KF67Fqywivn
	5B+qkhAvWCk8qXZSSvaGXvMvRwCC2s3Gvu6IJQepgSW6k+pO26b7IPWDQP6/Wgiwd98lFtNghcd
	MI4zGWW94+9B1WbkQOogQrZKxy578cH2wKNuqyUA4EHS0vdoX7rMERH9Db8P/ZIVMiQRNDcvX1F
	UNjQIGcUs+Ar4y1P/wXgRqwx65F8rL
X-Google-Smtp-Source: AGHT+IFLR/PY6esgcwfjs4A9FCu/jTJNK1jUYqNqnAfA53Hlv7rJfDhMGwHeBPiUNwQ6IqLyeKwhHA==
X-Received: by 2002:a05:6000:2911:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-42b52821778mr809980f8f.23.1762981658086;
        Wed, 12 Nov 2025 13:07:38 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2376f6sm972395ad.21.2025.11.12.13.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:07:37 -0800 (PST)
Message-ID: <56d545ff-3b72-430b-86e9-fd630dbac942@suse.com>
Date: Thu, 13 Nov 2025 07:37:33 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] btrfs: add orig_logical to btrfs_bio
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-5-neelx@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20251112193611.2536093-5-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/13 06:06, Daniel Vacek 写道:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> When checksumming the encrypted bio on writes we need to know which
> logical address this checksum is for.  At the point where we get the
> encrypted bio the bi_sector is the physical location on the target disk,
> so we need to save the original logical offset in the btrfs_bio.  Then
> we can use this when csum'ing the bio instead of the
> bio->iter.bi_sector.

We have already btrfs_bio::csum_saved_iter, we can just reuse it to grab 
logical bytenr by csum_saved_iter->bi_iter.bi_sector.

Although that member is only for data writes with data checksum, it's 
not hard to adapt it for encryption.

But in that case, we may want to rename that member to something more 
generic, maybe like write_saved_iter?

Thanks,
Qu

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> No code changes other than context since v5.
> ---
>   fs/btrfs/bio.c       | 10 ++++++++++
>   fs/btrfs/bio.h       |  2 ++
>   fs/btrfs/file-item.c |  2 +-
>   3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index a69174b2b6b6..aba452dd9904 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -94,6 +94,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>   	if (bbio_has_ordered_extent(bbio)) {
>   		refcount_inc(&orig_bbio->ordered->refs);
>   		bbio->ordered = orig_bbio->ordered;
> +		bbio->orig_logical = orig_bbio->orig_logical;
> +		orig_bbio->orig_logical += map_length;
>   	}
>   	bbio->csum_search_commit_root = orig_bbio->csum_search_commit_root;
>   	atomic_inc(&orig_bbio->pending_ios);
> @@ -726,6 +728,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   		goto end_bbio;
>   	}
>   
> +	/*
> +	 * For fscrypt writes we will get the encrypted bio after we've
> +	 * remapped our bio to the physical disk location, so we need to
> +	 * save the original bytenr so we know what we're checksumming.
> +	 */
> +	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
> +		bbio->orig_logical = logical;
> +
>   	map_length = min(map_length, length);
>   	if (use_append)
>   		map_length = btrfs_append_map_length(bbio, map_length);
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index c5a6c66d51a0..5015e327dbd9 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -52,6 +52,7 @@ struct btrfs_bio {
>   		 * - pointer to the checksums for this bio
>   		 * - original physical address from the allocator
>   		 *   (for zone append only)
> +		 * - original logical address, used for checksumming fscrypt bios.
>   		 */
>   		struct {
>   			struct btrfs_ordered_extent *ordered;
> @@ -61,6 +62,7 @@ struct btrfs_bio {
>   			struct bio *csum_bio;
>   			struct bvec_iter csum_saved_iter;
>   			u64 orig_physical;
> +			u64 orig_logical;
>   		};
>   
>   		/* For metadata reads: parentness verification. */
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 474949074da8..d2ecd26727ac 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -812,7 +812,7 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool async)
>   	if (!sums)
>   		return -ENOMEM;
>   
> -	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +	sums->logical = bbio->orig_logical;
>   	sums->len = bio->bi_iter.bi_size;
>   	INIT_LIST_HEAD(&sums->list);
>   	bbio->sums = sums;


