Return-Path: <linux-kernel+bounces-876229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09953C1B0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C05A932F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6322333B6CB;
	Wed, 29 Oct 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ayJJBTnU"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BFF3385BE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744878; cv=none; b=V5SjiGfXg49JwIEwne4zYbTLWFeqxOLB0waZ6jeFt7neQRYWnMFM+9OheEUeHDXAEeb1FfQ8F3MJt0IphY8IK1grXAeIkpnkoxf9Anw3Rguk4Tdy9g8F2nO/gSskkJhNLStBR4lPAW+t33pgTe9lO99KO9o32w0iu/I7q7E6i/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744878; c=relaxed/simple;
	bh=oM5QySZdtAOBCoyNMz4xxycx+fUx6QiRo34fuhCV6ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5T34g4+CuD+Hg5BfEM8t5UVI9KlLg8sWwkjwBsEdmLm81DQmsbpntgmLso/WTHP3Udp6RRMHC3s69QqVRipKLJGfANydpNJoGoMTH39Bx/nEiWI7rTjCuv7UL5513WxfDVaUOgtN93TNr80xH5tTFU1jr+Erw5HHFthLMiYx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ayJJBTnU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eb9fa69fb8so62024771cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761744875; x=1762349675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RgADETiD5u9wqQNfgMacoJuuGaSmA2poVcbRTgfiI8k=;
        b=ayJJBTnUtE7fPGnFkBrdcp5L0ZUTnPAaIcOoeMwanmxXW468ezR0P17/K6FW12BJ9d
         6faXk8ry0n1zHBOjB55fkj3d0KOIBJ6AmE3w41Jat4FSBnKTCZK33Wk8CTwW7Jr2k5A4
         uE3DzDmOixwyHE90GtEGiHY9dhJZnyBhKjOcOhu8fgkZ7AJ4nMST0wezd3Sn0SwkXFHB
         D7WxLPVT3c5eSeudOxI1bOuJbB8M7TrzUiY/Nlw92+RirBBewWC+PuwyTpAgD6cJEFNP
         d+2nszp5w4bwkpXmpE/gLxyJ11bYzjLmsCfokWaWHztHyUmX2Yi9Snryzh6/Niub3TaR
         hwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744875; x=1762349675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgADETiD5u9wqQNfgMacoJuuGaSmA2poVcbRTgfiI8k=;
        b=idpsilAoUwQ5QdGtinA83ldzQtSnbKDJHLtKI7DK1rMRi77yaQ2PfkPQcAAYaI1AJy
         kx1PuQLyMs0gO+jD++davbQgGfVC2CMCzh7/mEr7/59deIH3ROoqVp3AUrBey4AmSjPP
         JJozVi+Dpxw3lLUGsgon8F4SaRH0M558GyqwDMOqGT8XQoylrHXQ7jkmfx07SqoQpC/g
         XkvUXiX63dvezSe+RG6n7SPGDlGEjbftABjub4z2mgo6i9TivBrDhZM6n/pEQDMs8XUQ
         95TgucFTItFHKYmLMN261DN+V0S+FWKZ5eAha8xv0oojmmGgTp5ZMxZwYP9iAj97Iq6Z
         +phQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrbJEh2zrfSl24AxnohZn3xrwmuY3CI9F/QVjL4sQ6p4l9fGW6h2ihxrfpOTyqWCQ2ofzR7O1Fh6vzzDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZO/PwnFkyRTUQgrUL9hULsI8KDNfTbSMhNRI9pmLCmnPWns5
	RXdwk9f+9ddrIjJP4j8nweTBNNg4E3+c8TtfTrQnwvi9Xiog6iL+1voinWPZ1W8uqavufrR+8kw
	gZ58l
X-Gm-Gg: ASbGnctkOHndEzSqQetYTrfChS/JHY8JciV7nalgDjY7JxdtObq0NiaIdnfoShGSqaK
	GoTDs3LCtZVCxTXNdq+n0yOhM6V3X+8lIMbUiFclAjva6lz40k09YOxgUJSgDZihFaRpUxxncCD
	P87bRmGv6sIX8dnitwrn0CF4sNVPoCf7G2nLgZfj04xgAN+eV4jkNikWWk4KLgF94QTbIssHYtZ
	eeYn9oxBgVpGbGzAtVcFZdjRZBxm8pdMntN8QB+BLNIhJhutohcQrvDHuvLfPZb4FF1kWPw8ImX
	fcMBD77cE/RmOlvvLTfpb5ZDpB0uEZJCUvCQkO22fgjKxD14rTBLRapD0OU6vUDhfWMwR8s/njN
	rUi5UCaK4x9pYuYE6+hVIyRgmZCBiY+IiQzbsXx7sX3zaMQEvYM4mRThySIbbKkj/X3tNqXXv0O
	d8JHHKEscl1s42sYDjJ8hZRQh4rILJtY8Wclm54d9VsSCl1zGE36kE2AyK
X-Google-Smtp-Source: AGHT+IFdgVvZSdHjEy8GA0OS5tZk1Dvc3yZ1jqJfpcS1F8qZqGGicMQtvw7HnfgbOqouiYpmJyOhTA==
X-Received: by 2002:a05:622a:91:b0:4ed:698:e3af with SMTP id d75a77b69052e-4ed15b336c0mr38693411cf.13.1761744875380;
        Wed, 29 Oct 2025 06:34:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37d68e9sm93871021cf.8.2025.10.29.06.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:34:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE6Ju-00000004eMm-0ufq;
	Wed, 29 Oct 2025 10:34:34 -0300
Date: Wed, 29 Oct 2025 10:34:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: iommufd: Explicitly check for VM_PFNMAP in
 iommufd_ioas_map
Message-ID: <20251029133434.GL760669@ziepe.ca>
References: <20251029125226.81949-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029125226.81949-1-xueshuai@linux.alibaba.com>

On Wed, Oct 29, 2025 at 08:52:26PM +0800, Shuai Xue wrote:
> The iommufd_ioas_map function currently returns -EFAULT when attempting
> to map VM_PFNMAP VMAs because pin_user_pages_fast() cannot handle such
> mappings. This error code is misleading and does not accurately reflect
> the nature of the failure.

Sure, but why do you care? Userspace should know not to do this based
on how it created the mmaps, not rely on errnos to figure it out after
the fact.

> +static bool iommufd_check_vm_pfnmap(unsigned long vaddr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	bool ret = false;
> +
> +	mmap_read_lock(mm);
> +	vaddr = untagged_addr_remote(mm, vaddr);
> +	vma = vma_lookup(mm, vaddr);
> +	if (vma && vma->vm_flags & VM_PFNMAP)
> +		ret = true;
> +	mmap_read_unlock(mm);

This isn't really sufficient, the range can span multiple VMAs and you
can hit special PTEs in PFNMAPs, or you can hit P2P struct pages in
fully normal VMAs.

I think if you really want this errno distinction it should come from
pin_user_pages() directly as only it knows the reason it didn't work.

Jason

