Return-Path: <linux-kernel+bounces-898202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B51C548F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB0C34E155C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58CD2D978B;
	Wed, 12 Nov 2025 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YeR5ll6S"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E101B3925
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981846; cv=none; b=Zq0bE5B6xR3m3mpZcf1wm0/2FnSBAYShtZw2uR3nlqcQPtre0w+X+sA/XZnwh4J3eCVMgGgjgqc2M92KX7w5yPDQjuigL3HGPJWZAn2xyi0DbzHxPYlOy5ZcKIQukFlv+XK3aWQo0OaCaObyw14QOreqkCSXbEJl396v0txtxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981846; c=relaxed/simple;
	bh=I8yWvUDt4A3dEz/J5OYEnnjS5M64kRFtMhNMygQol1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3CHZP0YgEy2s9afHrwhVZ11w9A++OucNipgAGelITOMZHI5CUW5WOs34/4kk/KjRrzCk9nhq/RBqe92U2SMv8OYP4GaWkcyz0JPmEntU0Bw088DdbHb983vIk2y3J21779JMYFI/CyCqf3cA5YXfTTue6RjAnl5Z57Z/OyJuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YeR5ll6S; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4774f41628bso6718465e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762981843; x=1763586643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DDrMbaaU9PabHLcVqZAGr/eV1J38DiT/yMa7iNIk8lg=;
        b=YeR5ll6SoQE74b9HnM88FsFx533WdaX5DmEPDtMLapOaJ3HyYRghMgWwnsBS1jn5At
         6yimXw+jHuN7Xcfbd4RjNUsHIK8ynBiFl9Nd4Xb7TNYINLnecyIU4dw06L0C/KHR3G4/
         X0oqASkNfZ98rGIhySF0Og7g/zazT74SHs9C5qKD8nRiY1QuU2SU4VhU8CuO4HnWF6Of
         RJ6JuVyRuxs+mwGavSwhlu+SxqAhx3CIehg7qDTbur6ZZPbwtpO01nsjArkV8tpriyiC
         9thD0FO3sLClaOPuhP4O76vCRRnA0+aGBphZGjAclIFoODbSCANPZglvBUu4zvCe6F4t
         Ppsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981843; x=1763586643;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDrMbaaU9PabHLcVqZAGr/eV1J38DiT/yMa7iNIk8lg=;
        b=jGCtpfcad7nCrj+uUuxt6uVB6dWDPtAPyEREZvhitpeuww3PL/Z7C4JLaQF328TKIU
         1woNnqwwXCpKWYh+qzn4BSDfgUCxyXBwsBLQq+b3QjQErjep2UpKTwX5j1Ez8VUVn2Ap
         sGGOCjcn3tz8J7mF59UIBMep/X4rWR1Nq8mtN7YDY5PKsftAn1UIUA2Zk1flmM+8rzva
         M0DpRMhtKm3swOgPItj+MbMrUzKThKXFOdRFl/fBdI1FC0eIPh9v+Zv6aWuwKUZlExV4
         GOdNSRXyRgtzQkEFU2EBC5oEE4DKwDNnUOSqHjjKQp462VFsy/pFst5vGl2lNpFiSkso
         mTPg==
X-Forwarded-Encrypted: i=1; AJvYcCXllTBd8PG1+u3PUGIilxeO95CZ+ug4apFqezTJuMHQNVN/UEMgonsuWQtbOhdo+hagmcSljYwfRYhLJPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6QxG0fJ7KQXqXmLkIwF7heC3leivD+uKW8PpGluSNry3QL96
	V7zMX42LeRdcpIlQ8IErxh0BAqxuLCK73HH3TJANOy9g4RtJ9OHQ1j9uaJqpXUvLjC4=
X-Gm-Gg: ASbGncu7s/y4dGv+rjnD44/D4zRgYDK7arosZECxZiQt8qu10UcjJAFKIQ/vJT7maZi
	yN4ds+bbo7SWoznN0GMx5pf9CwHXA/y7ydxYLyKIasDSmdH2pEWPlVvkFjyu+3VR2sZRrkWbQSj
	J/SdC0NZ6QMQuegPZ2dzRDKIoQsNefMy8CpvWdqX/RtnXvOc/uZfPzVyHDou/6uDmRPzntN9LU/
	b54Ky64vbgEphYQ69NH6aTa6HQZLyANl2SNGeChe9QxlJqc8YfW/CXAa85LER/ADFKjxxpDNUt9
	SEZOH7RCFhr4CWsZkOgfPmpp/JMUzvyWjl235d/4AXVyE3JcRGXqe5I3vgMUhoJpo99bxOLkX9H
	8p6QwtPavmAB76yXxaE+OqoOGuFWuU2ZLIgp5uUMWIaFDItFQV0vVGeevuKu4ItG58pSNHbBVRS
	zXbWgOEZAW0n5jE2KpnCyuHzWzycsT
X-Google-Smtp-Source: AGHT+IHrxxzHJhr4ISp0yA/GeQrr9mRQHfaDegBZaI2pxIAYApYHrA0LLhq+Pp23ZJo0mFldilITxw==
X-Received: by 2002:a05:6000:1785:b0:42b:47ef:1d7a with SMTP id ffacd0b85a97d-42b52821620mr562120f8f.20.1762981842810;
        Wed, 12 Nov 2025 13:10:42 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37507fc7bsm20525a12.23.2025.11.12.13.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:10:42 -0800 (PST)
Message-ID: <aa8f8100-3a68-4e48-b5da-b0749bce06d7@suse.com>
Date: Thu, 13 Nov 2025 07:40:35 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] btrfs: disable various operations on encrypted
 inodes
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-2-neelx@suse.com>
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
In-Reply-To: <20251112193611.2536093-2-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/13 06:06, Daniel Vacek 写道:
> From: Omar Sandoval <osandov@osandov.com>
> 
> Initially, only normal data extents will be encrypted. This change
> forbids various other bits:
> - allows reflinking only if both inodes have the same encryption status
> - disable inline data on encrypted inodes

I'm wondering how will this affect other users of inlined data. 
Especially for symbol links.

Symbol links always store they link source inside an inline data file 
extent. Does such content also get encrypted?

Thanks,
Qu

> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> v5 was 'Reviewed-by: Boris Burkov <boris@bur.io>' [1] but the rebase
> changed the code a bit so dropping.
> 
> [1] https://lore.kernel.org/linux-btrfs/20240124195303.GC1789919@zen.localdomain/
> ---
>   fs/btrfs/inode.c   | 4 ++++
>   fs/btrfs/reflink.c | 7 +++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8737914e8552..b810e831fc23 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -592,6 +592,10 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
>   	if (size < i_size_read(&inode->vfs_inode))
>   		return false;
>   
> +	/* Encrypted file cannot be inlined. */
> +	if (IS_ENCRYPTED(&inode->vfs_inode))
> +		return false;
> +
>   	return true;
>   }
>   
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 775a32a7953a..3c9c570d6493 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
>   #include <linux/blkdev.h>
> +#include <linux/fscrypt.h>
>   #include <linux/iversion.h>
>   #include "ctree.h"
>   #include "fs.h"
> @@ -789,6 +790,12 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>   		ASSERT(inode_in->vfs_inode.i_sb == inode_out->vfs_inode.i_sb);
>   	}
>   
> +	/*
> +	 * Can only reflink encrypted files if both files are encrypted.
> +	 */
> +	if (IS_ENCRYPTED(&inode_in->vfs_inode) != IS_ENCRYPTED(&inode_out->vfs_inode))
> +		return -EINVAL;
> +
>   	/* Don't make the dst file partly checksummed */
>   	if ((inode_in->flags & BTRFS_INODE_NODATASUM) !=
>   	    (inode_out->flags & BTRFS_INODE_NODATASUM)) {


