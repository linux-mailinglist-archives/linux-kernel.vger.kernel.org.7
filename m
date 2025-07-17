Return-Path: <linux-kernel+bounces-734526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498CB082C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C04A7AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526981DF759;
	Thu, 17 Jul 2025 02:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C8qSUifp"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10691B983F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752718324; cv=none; b=TZiYKjMBy8NNhlbQOaTonozaUFp4X/HpB/mD9Egjm9lLbixRd/Ylym2sfERAMUhYG3cOzSJOZkKJserUFMbsdzCh0ySdSeRPvT1RraoxIdUCWR3goIW4yxqkBJYiMafLOXMphekTMOgBVbBT62YW/AxL8kqgIYTV61vIFQxGdxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752718324; c=relaxed/simple;
	bh=b+dsztBU/r5KZ5oBd4fLVEt5uMjqjDnr7oo/Ji9YG2A=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=JjU3636Gf4TwvHZHx6WuHqf0cvFOPdFPWJU7SqVMIiboIgBTJIabe4x7GQoOQnCg2iNUvW+BeVodWJsJbVf3m8Ro1do79uxGvpvzosJPmH3bJ9kh/MVhHN0CdmiWcYdCKmQeN4N0HOFR30MWnt/eo3daqpghJVkjzbZ+OJDhf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C8qSUifp; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e34493ecb4so50014885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752718321; x=1753323121; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ut1Oz5cd4mrEHQ1G48QmwzT5AxIKSMflR+AU1YWamE=;
        b=C8qSUifpcGHb8plW4ItZQ65sjSTRw6E0bS9xEcmiI55WSN9lZuD0o23ohTIG8/v0/4
         9CYW16W0n4fkYyIRiK1xpfTkyVLYizEnaZWz85UAO+AtZHj7RYb+XjS+Wp3g/6KdNll7
         yAEHAqALOLTZbLGmv2Ec6ssSgR4XOElfRiulEN+zV15fnmpk2UAgJ9yljLaXlb5/d7f0
         Ia8PrpzWLQtJDBObVFj2G41aMqMCLzxH1jbtTpV0jzwelcq0O0HCi3FHOQ5kgh92mTBC
         l3P0VL6R20eG/0U7bv6pmyrLdAcLvS0p1rxahakCfLoUD53gXhKfSWL6s9vdaNobydId
         taXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752718321; x=1753323121;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Ut1Oz5cd4mrEHQ1G48QmwzT5AxIKSMflR+AU1YWamE=;
        b=RvC7kqFM/6qK/rA0Tajzs8fNwf7GixVAp8ehYN1810HSUEKyIFEzI1lmyxK6RO2zci
         ja7Oai7IIB4FVKKKzdX5oDWrbc2vaxGpz+3N73+R6rTMK/reIISV7qlvNXP47PtpsaEa
         ZleWbemEndBVf9SzpR75qV9DjDyJgt0ZzZ6OkAmFhgopFMtgEQQq1FHoNg0VxlcsdK0I
         UCznQzdqISIyMH/pHz/SXsCWEv6iREoKvYP2dA8xJhMBXIWKoX3IewWC811fI4dN705O
         ifbruo4uagrv0ECz7KDezaxeOIMeK9wZi8WWSpKrAiNRLtVYrTHvXs4roanDjaAvZ9SB
         nk0w==
X-Forwarded-Encrypted: i=1; AJvYcCWOvt0oGAjodfoYpmyUS/V4RK+s48IoB/+Gf0JXP8QRzwpceR3hehHmBltCUGBN/NrDGmwNZfdp/R6qaZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyenhnEEpk38drVI/Ow5gxQ2seqQvXCB+d2JIdAYu9dTXqQ/iYP
	J+EpP1f1XaqNA7oYexXJbNK/cmhLE6FiRwIKlBZ5s2YlGBRQEmaVqCqXlpS5WNW3QA==
X-Gm-Gg: ASbGncvlxXXWAyDU0DgZmuWpidKpMEkMS4KoiYu8G5JMqr1MBKX025ABBPPNvIPo/nw
	tywmF8r29I4eAmfJFSssdlHJ8XWMqlFIUBuhqVcJGjZQY2nc4XnlvT44uduFAJPmnArHLYdnUeN
	YjHogf0/7h0OI1+kdVbV/llFAcOCtfQhCXir6svNXxqg+BkuBzs9qEd5CFx8mLgCeQE+T+DxTku
	40XT1nRgb75yt+LyHnPuSTL7MjMpAKSLKD9GWpfbJcLuDTpWmdeaxbbglHBG0NoducNgpIpgj7G
	JsePcSoalOuuArlTobUIG8NLD7seO6jU/8x1O0JDxf0GOOwGNqDaaj7FNc551Nml9VQZViy1FVx
	c8Cv6+0hvl2wlNwfOISR1f5sYNZB4DEtrsPcu0AVsasKuN4XfIPfOJrc5wxZarIhSMAc=
X-Google-Smtp-Source: AGHT+IFuGKGX5Ead/7aQlWXcVtLRDlQcD2Ir2V+fQdBijZ0wUN1PmbDTqZlpVsgTNU2+Tbf1nb3Oew==
X-Received: by 2002:a05:620a:31a0:b0:7df:dea8:6384 with SMTP id af79cd13be357-7e34362a36cmr806543485a.47.1752718320727;
        Wed, 16 Jul 2025 19:12:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e342f14ca0sm178636785a.111.2025.07.16.19.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 19:12:00 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:11:59 -0400
Message-ID: <941986e9f4f295f247e5982002e16fe9@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250716_2146/pstg-lib:20250716_1156/pstg-pwork:20250716_2146
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] lsm,selinux: Add LSM blob support for BPF objects
References: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>

On Jul 15, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This patch introduces LSM blob support for BPF maps, programs, and
> tokens to enable LSM stacking and multiplexing of LSM modules that
> govern BPF objects. Additionally, the existing BPF hooks used by
> SELinux have been updated to utilize the new blob infrastructure,
> removing the assumption of exclusive ownership of the security
> pointer.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  include/linux/lsm_hooks.h         |   3 +
>  security/security.c               | 120 +++++++++++++++++++++++++++++-
>  security/selinux/hooks.c          |  56 +++-----------
>  security/selinux/include/objsec.h |  17 +++++
>  4 files changed, 147 insertions(+), 49 deletions(-)

...

> @@ -835,6 +841,72 @@ static int lsm_bdev_alloc(struct block_device *bdev)
>  	return 0;
>  }
>  
> +/**
> + * lsm_bpf_map_alloc - allocate a composite bpf_map blob
> + * @map: the bpf_map that needs a blob
> + *
> + * Allocate the bpf_map blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_bpf_map_alloc(struct bpf_map *map)
> +{
> +	if (blob_sizes.lbs_bpf_map == 0) {
> +		map->security = NULL;
> +		return 0;
> +	}
> +
> +	map->security = kzalloc(blob_sizes.lbs_bpf_map, GFP_KERNEL);
> +	if (!map->security)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

Casey suggested considering kmem_cache for the different BPF objects,
but my gut feeling is that none ofthe BPF objects are going to be
allocated with either enough frequency, or enough quantity, where a
simple kzalloc() wouldn't be sufficient, at least for now.  Thoughts
on this Blaise?

Assuming we stick with kazlloc() based allocation, please look at using
the lsm_blob_alloc() helper function as Song mentioned  As I'm writing
this I'm realizing there are a few allocatiors that aren't using the
helper, I need to fix those up ...

It's worth mentioning that the allocation scheme is an internal LSM
implementation detail, something we can change at any time with a small
patch, so I wouldn't stress too much about "Getting it Right" at this
point in time.

> @@ -5763,7 +5862,12 @@ int security_bpf_token_capable(const struct bpf_token *token, int cap)
>   */
>  void security_bpf_map_free(struct bpf_map *map)
>  {
> +	if (!map->security)
> +		return;
> +

We don't currently check if map->security is NULL in the current hook,
or the SELinux callback (it's not a common pattern for the LSM blobs),
did you run into a problem where the blob pointer was NULL?

The same comment applies to all three blob types.

>  	call_void_hook(bpf_map_free, map);
> +	kfree(map->security);
> +	map->security = NULL;
>  }
>  
>  /**

--
paul-moore.com

