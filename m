Return-Path: <linux-kernel+bounces-763699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E535EB218F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F461907C04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1661240611;
	Mon, 11 Aug 2025 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSHJWR2A"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADF2581
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953875; cv=none; b=sZYLbz3U4jzo9xthGZTqlYqsdtLVziIxr+vSipG3e8c0EA8bRB8BzSji0a2HRYSJd+5J6I9rAueRG6Jfqzd/F0NjEiL53F2eQZN5ZljGkKuSvrv0J3R7nRw2NMnQc8CNxsnEd/Gfi+6Ga21YzCblOLDfAoetfs5UuCKIERPNHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953875; c=relaxed/simple;
	bh=XlKWe7hGY5MiFreFuz3bf4pAkpABAV4Hc9Q8DzXwtQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCRB46L/2AoRZLXnq/fx5CKNqcbe8ML9HM129ceQedIbw6Q+WPdqFaHVej4TBwwQdHbOflYZJWwzALDdiJ0Kx0rCXMIj+6dlhIfSfIUjwwvl9240PdfAGm3KMyoL0DLFMiSyP6tMJz6rVTsiu3D4wDjk48c3GDZ/SZ0Wupj9D3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSHJWR2A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-242d3be6484so31825ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754953873; x=1755558673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1oV7yVKsQ5TCnNZCaQ3AZrRbIoYDq2nQJuy1DeTjIQ=;
        b=YSHJWR2Ak4gKSANGEL3Fqc1ZINt5iFRbA0zVKdnvL0nnrT5J7nx5tQuwEy6fGH1kka
         UcFrLsH6sQOhTkcUt2VHNlaRXkU9eJ1/6gEJexK7A+fBYC5SgmkTbhrR4MBcBoVvyoOu
         xAe7SjKWG6czv3spPAy4dOGwTs0FNxeCXIHWTScr7tItz/DAOpZJXqBfzWYHSHstTI8c
         sF/Y7AffUIuqhEjogcjUewGZ1DURn34f9y3fS9Ai3O6go+qe4mZCoqKRayKPNgF97GcI
         FZw/9GQTxy6T4Hn/S2l4EXMEaSdGc9j7admfGv6LthS+q7Ah1vmimLLWSXXFhPK5yOpN
         RlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754953873; x=1755558673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1oV7yVKsQ5TCnNZCaQ3AZrRbIoYDq2nQJuy1DeTjIQ=;
        b=o2Pdm/RPQssFegA0NAvGc9BSBQbnBPNTpWG/mBMQXzYL1/jU6FEsva9f6wPPZZUxT1
         jAcgGtTHYDphZ4yUytRVUIMU+L9RQTQ5UrAtOefEpcJSqdb+Y6pz87qhBN1nAUWcXR03
         JFu+/Lyf/y9FYO9Po3NFSbmSbTW2kCE7F5+vQaxI1IA4p07Tnpg3u29UoA/rmbilWrsd
         2mliK1HTzzzFg49sxFi+oWhwjTBYVq1Gv1IPjozCFHutc120zrP4lFdCAOoDtm3l2FRN
         Wu+HGvrZJm6pfYVfsW/byp8yiSEAwYezx7p/MoXsX/A7DL+8aX1tQojnBY81Tlr52Voc
         4Ccw==
X-Forwarded-Encrypted: i=1; AJvYcCXpKGZTVD6vcvhJkjUIM+z+OMMAsEwXmWJ5TZHfcGDS/OnjViOxiNNcgkddl948/DDs41RLiLQfFSCTi3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyitKcB2GeZq9XYkd8oSvufD+PRiImNOovM9JNE/QAPJpMyiuNy
	ohfiZZoCWnC9DS6/DJuG9zkamGP1odbUVLKBaDRqRAlfq72gGpHhuQQ+wM1Jv/CG3w==
X-Gm-Gg: ASbGnct/FIabJWZsns+ZiN7aK/a1spKn8HM9l2gzDV3BdX5+oV5O2tZzezZBYsvlIZj
	tUdIV6AkaQH5VF6qGIxbP02gg2wtFKsBGxs2ttAze/TF6Gln7uKVq6jwNuO2Cjg+vuUru6VJVfE
	ESJGwG1w1ZamBQzuPyuxPHdnc+HOlX4mRujmvN7Cv3P/KelG57kAUv9rofVOrq+kt2n5HPQbX6E
	aYAzC8wBB0oKxc96cfmv7hNsnn02P7utkYNt6ViR/vtCK4b3gq7JE/kOCvN7C2KdboZ1w+b+w7L
	2KHvvIeHFCCJ6GzCNNKggtLQ+9el8H9OoskEJVpNlJ8F8ArJBuhRtr/9yVHL1tN9Ilw+1+2wwl0
	8ctHwhtLEuVpi7eHmv0LykrTvLZjjuUHkttQqs17vmASoJpFHiuQFgDi0IEJlJNqadBWZ3g==
X-Google-Smtp-Source: AGHT+IFzyKR/w1E27eWm6IovhDIP1SONsBPcExVJWFEliFhx+rfqf71Fi48caAfu36gGEzgxJL2HPA==
X-Received: by 2002:a17:903:41c5:b0:240:520b:3cbc with SMTP id d9443c01a7336-242fd3660c2mr1826635ad.14.1754953872909;
        Mon, 11 Aug 2025 16:11:12 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm27859139b3a.54.2025.08.11.16.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:11:12 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:11:07 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v3 26/30] mm: shmem: use SHMEM_F_* flags instead of VM_*
 flags
Message-ID: <20250811231107.GA2328988.vipinsh@google.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-27-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-27-pasha.tatashin@soleen.com>

On 2025-08-07 01:44:32, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> @@ -3123,7 +3123,9 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  	spin_lock_init(&info->lock);
>  	atomic_set(&info->stop_eviction, 0);
>  	info->seals = F_SEAL_SEAL;
> -	info->flags = flags & VM_NORESERVE;
> +	info->flags = 0;

This is not needed as the 'info' is being set to 0 just above
spin_lock_init.

> +	if (flags & VM_NORESERVE)
> +		info->flags |= SHMEM_F_NORESERVE;

As info->flags will be 0, this can be just direct assignment '='.

>  	info->i_crtime = inode_get_mtime(inode);
>  	info->fsflags = (dir == NULL) ? 0 :
>  		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
> @@ -5862,8 +5864,10 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  /* common code */
>  
>  static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
> -			loff_t size, unsigned long flags, unsigned int i_flags)
> +				       loff_t size, unsigned long vm_flags,
> +				       unsigned int i_flags)

Nit: Might be just my editor, but this alignment seems off.

>  {
> +	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
>  	struct inode *inode;
>  	struct file *res;
>  
> @@ -5880,7 +5884,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>  		return ERR_PTR(-ENOMEM);
>  
>  	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
> -				S_IFREG | S_IRWXUGO, 0, flags);
> +				S_IFREG | S_IRWXUGO, 0, vm_flags);
>  	if (IS_ERR(inode)) {
>  		shmem_unacct_size(flags, size);
>  		return ERR_CAST(inode);
> -- 
> 2.50.1.565.gc32cd1483b-goog
> 

