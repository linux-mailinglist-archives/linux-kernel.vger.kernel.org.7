Return-Path: <linux-kernel+bounces-898150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37309C5474B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 412D03430AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7AC2D131D;
	Wed, 12 Nov 2025 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fKQ/aivs"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C32C15A0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979461; cv=none; b=DiTrVChgfZR20rviRx9Rcw49B/b7b38V3cld9PHz7WVFkOB67+Xbg9OmPx63huiVMHHvJA1uBniSbHNdxsBu+f/EC1cxH54XF5+vL4Ks2moG4Wbr2LMJUXOl6DkUhzqsZUHEQsA9oFaQji3VT7MCi5cE/vTPB8kLWufQl7/Lx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979461; c=relaxed/simple;
	bh=kOM7+BU1YIthguYmgcMSdOiBt9UUIb0U6mtzZrgVI6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b54nQKm/4OsoDBV/EFiHm2fITi7E5vktfXfxbevndGVTQR4fUgqrCbKuubBSbR19K7uSkq1o1Ju1hTs4+/XXBZiicsfU7YzSVH/dhAdm+kBE0oztGEDTS0YXnwMT1lJgEj/B5/jiQykv0kLQityZvSP34HNMNUvRqR7IfF+gvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fKQ/aivs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c82bf86bso55312f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762979458; x=1763584258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AP2d64WqTFzGeOFQ+5qPzI1m1QRdrXsf+Q314tyBbEo=;
        b=fKQ/aivsD69B/2AQG4mPWIR6Ppgt7hSBJ1Fh1Ig9copOOByesNCtzXhnzK7iJmDp2c
         rdnYyVRsMbTlJ5xVOfSao3JNEo0m9cW5mY0V8eFhvKV15uGCrosh1nmeKjKaOl9xhmF/
         Bv4xfYR808KQf3j84OcVXLnuHuHziFvLp/RK4atGuvm0Nq4uiTgTOK+a8B13XHNdGSua
         NDzpZogJGl9hpQSYKkl9mDJ4E0Xx12N0xrqyQYlmp3DkuLKShB0v4t4lSN1jLcJ5Hndy
         cKIOBcTdOj7U2PoAVVEM9t66z19DFSzImJA3duN4KT+bkFmFPqr+h7M7DY5IFXtF/koZ
         yH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762979458; x=1763584258;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AP2d64WqTFzGeOFQ+5qPzI1m1QRdrXsf+Q314tyBbEo=;
        b=pTaQ3CkxoWfPx3WfI1mNVIsRtmZViGs6DAieJOvIj15tmtGz6E43ffGmDW9nSz1iwm
         4m9oLdFMMWPCTuPD8ibX7HL0splfhssckWJAj+iJGo44NSBbqnVFd2sIIgKWMCxw6Fje
         lX3j6C7s99OK13XdNJpbKkoSSZ0C+5HcTpS8X+DG8bGogjKkkV8aRC8PJ++5M2yx5WOP
         fGM7XgGMvIhd2mzFqAdjR3UZxq2D13HqEBk2lK2wcilVkyJs2AxIS9SmMwwm1B2I2OCH
         15PJ5W369Zy1Xghs6f1c7P2j9aZ04QtQ1M8AQzAqJOeXKMiilUxnSB4YsivENeSsMB/U
         Rl3w==
X-Forwarded-Encrypted: i=1; AJvYcCWXnlf6c9dvO4LUhk0+95ZZmQ1Ca4/6QmQMDBaZbQhiLQuGGxU+girtmX2KiKnDOwy/tfYbvakYEpEgspg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxC1FxjIGvXfy4KOrTOP7+JxeyM4yDg7rQJRZDcKLz4nvLuav
	TwGYMf8+VA027Nf6Pz2pAiUuxsYNS5lSOITcP5O5P31wA72VmSx6HUcIv3FufQ5IErU=
X-Gm-Gg: ASbGnctJdCqP4nasa+JmCfpcOw3M/Nl3EsPGuSEFY8w9/o9oJ+rS/5ahg0+CXEUDssI
	+6P/7SgL+dePp27DmoxGTynnIw3c5SW3sHU+x33+0nILH9ScuHHNKkhLB5D/McgGowsIQY6JSSK
	3C0YTUQEDESgjuP/wf/C1ElBy+ZJFdZkSkC+9Wqcm0Kh8R5PFIqYq/4n0kQ6OsC6WUUJeosdKNv
	ifqKbUWAhYD+cNN0w14V62RBENyL0fty0f+JJhQZ2ejh13yx8LXQHNSA/q9ai1ApcV7cES6OiHT
	Krm8LhD8OmVsjskJPQ9ywiMBbpX8KORBM/8QaUV6M6DScwRzHCWP69YAsaZpJuPNxt/ejCn1Uox
	WvVZtaqxs4vMLe5kVfS3xym/hDX/cGClBeIeYI7bFzoM819YKYqqZhkdTvqNNOnneCJhBHt/cPD
	vJDXoGljdX3nnH2/R82sHPagHB9qfq
X-Google-Smtp-Source: AGHT+IH7qoeEeaDSvivNQBoKbfmaf8s+0DfrcnZwbNGDV0U23zo4yYtXfaWYobPSvm+PX/e3u4SgLQ==
X-Received: by 2002:a05:6000:24c7:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-42b4bb98114mr4420838f8f.14.1762979457689;
        Wed, 12 Nov 2025 12:30:57 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b750e400fdsm4249900b3a.17.2025.11.12.12.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:30:57 -0800 (PST)
Message-ID: <74034783-1715-4020-a22b-45db6cd389be@suse.com>
Date: Thu, 13 Nov 2025 07:00:53 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] btrfs: move kfree out of btrfs_create_qgroup's
 cleanup path
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1762972845.git.foxido@foxido.dev>
 <79f3f83eb5f693ad88b0cad9d37e2db214ba1491.1762972845.git.foxido@foxido.dev>
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
In-Reply-To: <79f3f83eb5f693ad88b0cad9d37e2db214ba1491.1762972845.git.foxido@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/13 05:19, Gladyshev Ilya 写道:
> Relocate kfree() from the generic cleanup path to the specific error
> exit where the allocation could leak. This prepares for future
> simplification by allowing removal of the 'out' label and use of
> mutex_guard for cleaner resource management.
> 
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
>   fs/btrfs/qgroup.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9904bcfd3a60..a8474d0a9c58 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1659,7 +1659,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>   	struct btrfs_root *quota_root;
>   	struct btrfs_qgroup *qgroup;
> -	struct btrfs_qgroup *prealloc = NULL;
> +	struct btrfs_qgroup *prealloc;
>   	int ret = 0;
>   
>   	mutex_lock(&fs_info->qgroup_ioctl_lock);
> @@ -1681,18 +1681,18 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>   	}
>   
>   	ret = add_qgroup_item(trans, quota_root, qgroupid);
> -	if (ret)
> +	if (ret) {
> +		kfree(prealloc);
>   		goto out;
> +	}
>   
>   	spin_lock(&fs_info->qgroup_lock);
>   	qgroup = add_qgroup_rb(fs_info, prealloc, qgroupid);
>   	spin_unlock(&fs_info->qgroup_lock);
> -	prealloc = NULL;
>   
>   	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>   out:
>   	mutex_unlock(&fs_info->qgroup_ioctl_lock);

You're not on the latest for-next branch, which has the following patch 
applied doing the extra sanity checks:

https://lore.kernel.org/linux-btrfs/20251024102143.236665-5-mssola@mssola.com/

With the extra ASSERT()s, the old code makes more sense.

Thanks,
Qu
> -	kfree(prealloc);
>   	return ret;
>   }
>   


