Return-Path: <linux-kernel+bounces-758425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1455B1CEF8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5642C18C653E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A38237165;
	Wed,  6 Aug 2025 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UN2lAX0J"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751121A5B8B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517978; cv=none; b=g58aj2MSpjtONgZQSJ3KlkjvOeffswwZHYjt4h9V5Kg4+W+m9r/7O4svAFFpnyQeNSNqZo2WTPI24JWKJJCdMcaDG3wGYC1FXGxVgsFrwd7ms7QuIcZro9wnVp5/PzEBsncyMjly1cF+oVmjDurmUvpQ7vp07Sq+832shAh4PIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517978; c=relaxed/simple;
	bh=1+1mh2UTW8nha3AlApBzYw9ktnvsRC6MZw3w/Q+Tgrw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=rqYQIBUct/TYF+tP7AJOLvluHSvAyWPB3GF4i6uUQiLYEujZkHBBY/Ltqsp2teMcp1zuR4KBnQezPDjV0D1UMnYEyL1VxWIGTVugctWHx+RClyabZV8dlpmQqe8fdVVE4Rx3iJ3X+wilUdqfIKOM5AJl0thZ5WC4j028YLtsaiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UN2lAX0J; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e2c1dc6567so27686985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754517975; x=1755122775; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqrwiDX753cPr23iwZVrIBxXM8laVdcIlzxoK8+/Djg=;
        b=UN2lAX0JPKYfTsmw6yYvEazlw1xr0dfkYp7DzLKdCpwg8mN+u9KBbeo/cUBoOHbttS
         iJrnGu56gwMS3zn/S5/SMt0GuOoBvJ/h+GeBZtxc7YJUJUxqmoyvcRZv2YnIqSN5Qiv5
         n/PDUmkOCzbs+VVWeSYuM3/2J/vJPbzW//hw/m3nmpG0w/WHLBTYKKIA1jheBm27jy/T
         2wpFlWRb9eTKUZlvMhgat+VIy+EOsoXdeq7z/H2ZG/0mdQQu14uZ8+OugY0UpmzDkz+4
         lDlbxMU1J+zbX2+NnF8DmIioyS7gam9PNkc+p23jI1KvZNqq0rAdKBJj9/R/qs+BFPi4
         NiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517975; x=1755122775;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DqrwiDX753cPr23iwZVrIBxXM8laVdcIlzxoK8+/Djg=;
        b=Tt0tCHZc56uflmc+39/SpekaeidhSAJ3leO6YsmKM+LRJNztQXYIWxuNXVN2QkaMuQ
         NyK52yEmSunCtMQzbR/HQP6bkUsgNbGaoo8HBkGLt0RYd26S0Zx5sh3z7mPCz1L6fw8G
         5GYFA/L2aXjarsAva7nks1sh5NPoAKU3330c+vz6f6hhH7QSzDHu+h2g5cn8buRWp4qX
         VaxT/OSW5c+1DIX2Z/dJltY+hNt3IkNldN+LPH0+z9rUjLSF2yXxt3aX05ecvcA4+MD5
         S28Ur4YgBf+0FwQLRnE9LTdwlu10MmBFIalzjy2o03pxi4Jo/La7VU2W8OTLKSk+vJJ9
         ++vg==
X-Forwarded-Encrypted: i=1; AJvYcCUm1nlqCwKungbvI/pDckj8qqayAtP5f3/H2L3YIUpoi+2gwsWGKPf86FIlYWJhB5Uyd2JYBsIkYt+ogQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBFS/kGN2Z+tQ3sNUbouZCMdYAvobGoURCFlfrqcyFxRiU36B
	Nu2Pjz92oAyOrQOvJW+7VBQhh5TvXkIJrg+ba+OeFm+FzzAOlMcOZ1KQtE0NS+xFOA==
X-Gm-Gg: ASbGncvaUPKR6/pf5SoMHJL3LV5ML2Xd9PkpAHM0wEQV7nj+W0u2+O82ASS92MAdKR9
	M52SSO6nxrdri4kTR4xxgbAX3o8SGF+2PlLRJt6CmjsaTsv9G8UJteyGPoP7pUyoQsU1ZfRNyd5
	ckI0yksYDziPbIXeRuGnTiJPpDqApteQ4F6hGbNlWWbH17xbw+IMhKCfiQxJa46v77denRc83mX
	7/3pD0we8VWl1YbP/nxmTgo7B5QlKWEaIa1Hr1aSkPM2bwWNKjBu1fK1BjN9b8PGRFwG/HcafK9
	yNWrGRW6VkkaRDWaXPCmerlfP93PS2319rfGWAwrBg8Jh9HrCQnkeViPiwYd9S6KBakuzOyFVac
	fynV2R2Y/VhZEDX41dqA0KLgMWvlkRhHVeZZSC5YN6DpjM6sl40d6cwgDkoNtcp5dpkruqcGNWp
	QzBg==
X-Google-Smtp-Source: AGHT+IEQrlAQNLT9WdO6VwMIGCaqXQxPGX0ewn8Cl64BGagN9wv8L/9CzddXItLjrvM+oRV/1M94xQ==
X-Received: by 2002:a05:620a:2a0b:b0:7e8:1853:a40f with SMTP id af79cd13be357-7e81853a9eemr473495785a.58.1754517975107;
        Wed, 06 Aug 2025 15:06:15 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f594353sm856626185a.17.2025.08.06.15.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:06:13 -0700 (PDT)
Date: Wed, 06 Aug 2025 18:06:13 -0400
Message-ID: <f7e03785a79a0ac8f034cd38e263b84f@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 2/3] LSM: allocate mnt_opts blobs instead of module  specific data
References: <20250617210105.17479-3-casey@schaufler-ca.com>
In-Reply-To: <20250617210105.17479-3-casey@schaufler-ca.com>

On Jun 17, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace allocations of LSM specific mount data with the
> shared mnt_opts blob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  |  1 +
>  security/security.c        | 12 ++++++++++++
>  security/selinux/hooks.c   | 10 +++++++---
>  security/smack/smack_lsm.c |  4 ++--
>  4 files changed, 22 insertions(+), 5 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 8a4e0f70e49d..ec61fb7e6492 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -904,6 +904,18 @@ void security_sb_free(struct super_block *sb)
>  	sb->s_security = NULL;
>  }
>  
> +/**
> + * lsm_mnt_opts_alloc - allocate a mnt_opts blob
> + * @priority: memory allocation priority
> + *
> + * Returns a newly allocated mnt_opts blob or NULL if
> + * memory isn't available.
> + */
> +void *lsm_mnt_opts_alloc(gfp_t priority)
> +{
> +	return kzalloc(blob_sizes.lbs_mnt_opts, priority);
> +}

It's probably better to use lsm_blob_alloc() here so we have some
allocator consistency.

Also, make this private/static as we should just handle the blob
allocation in the LSM framework (see below) just like everything else,
unless you can explain why the mount options need to be handled
differently?

>  /**
>   * security_free_mnt_opts() - Free memory associated with mount options
>   * @mnt_opts: LSM processed mount options
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 88cd1d56081a..f7eda0cce68f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2808,7 +2808,7 @@ static int selinux_fs_context_submount(struct fs_context *fc,
>  	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
>  		return 0;
>  
> -	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +	opts = lsm_mnt_opts_alloc(GFP_KERNEL);

See above.

>  	if (!opts)
>  		return -ENOMEM;
>  
> @@ -2830,8 +2830,12 @@ static int selinux_fs_context_dup(struct fs_context *fc,
>  	if (!src)
>  		return 0;
>  
> -	fc->security = kmemdup(src, sizeof(*src), GFP_KERNEL);
> -	return fc->security ? 0 : -ENOMEM;
> +	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
> +	if (!fc->security)
> +		return -ENOMEM;

Another case where we should do the allocation in the LSM framework.

> +	memcpy(fc->security, src, sizeof(*src));
> +	return 0;
>  }
>  
>  static const struct fs_parameter_spec selinux_fs_parameters[] = {
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 44bd92410425..1d456df40096 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -622,7 +622,7 @@ static int smack_fs_context_submount(struct fs_context *fc,
>  	struct smack_mnt_opts *ctx;
>  	struct inode_smack *isp;
>  
> -	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	ctx = lsm_mnt_opts_alloc(GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
>  	fc->security = ctx;
> @@ -673,7 +673,7 @@ static int smack_fs_context_dup(struct fs_context *fc,
>  	if (!src)
>  		return 0;
>  
> -	fc->security = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
> +	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
>  	if (!fc->security)
>  		return -ENOMEM;

Same thing in Smack.

--
paul-moore.com

