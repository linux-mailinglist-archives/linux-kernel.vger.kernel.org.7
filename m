Return-Path: <linux-kernel+bounces-878597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDCDC210E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87690349732
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A1321F48;
	Thu, 30 Oct 2025 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbseZkNa"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C653BBF2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839669; cv=none; b=DzJWHPzBa1L1HmKq+ry3H71PA2BH3RIU7wjU/qlIQmjk+pA+R8ilpsr59uh+7fSA9Do/RkHBGD7StmmD9EbMuT4LKr0Uhh+96MhuxnEdxOv44d9nBMOxoWvYw3gepVusAThiaKtkxZSSnKQskSbD/m42A7chzKfCDO4jGgxtxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839669; c=relaxed/simple;
	bh=gvQ8rMV/nb8TfMKY/OICnkCcrY8IEDx2ni4D9u6xW5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivBsIEk/BGdWF4p7XJwXQ2MiTC/xh3iSEb7SDKTfnmEEEIK5U/VxRyJzDkVhvazWhIfvhCPQ5ufJ4rXb5FKug8hbUoNGvnKwuDqOw41nP7AcRvDiQ9pkjXGt0hlATfQiqvvNdI57R5XdHTLP3SkJ0QmP7uge/+eDiue2//imgNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbseZkNa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so757188f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761839665; x=1762444465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7c6+XrmoyFowwhGbEiLq66X/torWpHDQ+1RsFmcHlWE=;
        b=gbseZkNas6nYIRR27KwsRKMpEMa8WaeNdWDg3JkojUaSd8nVVBfjbHsz0DuYpX/AuU
         AsvW8Y61yY4/7lBlgeGKnE/pEMm1aUF8pY58xg35Dq6xB0ZwRSyuFVu9lW+btzDxzSsj
         9iDDtt7a9IIDSlOOnHhfXc1CWxRfOjFfzWvrsgRfcsEcLTDZbFwouGcw0XH+9gISUgT5
         nESd6QHOMSL7rv60B44HaDlmoI3yHxrbO0OvXwv4jNmuQiId0xaGtIgmoJBiE3qPUfJf
         Vo/YjMKXhhNI7RfwqgowgMjm3XmuNCyNaFstMkW5YZEMN5THi5ytOdoUiHDUfTGEYXqx
         aGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839665; x=1762444465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c6+XrmoyFowwhGbEiLq66X/torWpHDQ+1RsFmcHlWE=;
        b=bJQZa6LbtXq1bNL0I46nEGuDVwJofsh3uwex1pBF96icHqJcd8QfLjKM+mAnvRqXlm
         tbMyZV8ibnN3RitBPqzSP6FIHMLaRi5Yp6I/UGlSEJeV96kxbzxx+a+MPyhScQXN3FsO
         lfRmR7EKVRyfyOJcejVs7/wxcR0h8JhxK3spl5DByBVKg+4FD6/Dn+f78ij4yqikjRIK
         +BxavUMfi/xz8363KntwIYfbvPnprjUxun4gLGENaSFTMnh+ERUuuhf/r1H6YzNGXnGL
         eEEud+V4t9rUUdLNviRVj8+ew6P1XxJpMqx5zq8cK5CCUbeUTjmADoz1I6e+tOpT6Lqx
         kC/g==
X-Forwarded-Encrypted: i=1; AJvYcCV+70Yd6NHFRLcAft7DiSgkloX6c6BA7BCMQSvuWuivPoy4jOZeCDaZB27jloHBa3F1RPLBv7y2veHA/ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnpoJ7ew7B5qAWJcqHLXhuTVrM78YEMFIe4GHBnPPa7B606lan
	6zUIqC4g7k/WG/xdnw1ttRSO6swdToQ9R4SI4S707GFoIMY865EAYfOJm3ch/+BcRg==
X-Gm-Gg: ASbGnct/y9PcYrV6JzW2mUpLn2YjOMUKLW1CQRG7geffZQ+uM5d546MQJIQOkbSVyvF
	pEl78GttVAKzwAvB1uyVeNCA4FeSTd/KgDj32XaKYUIU3pssbKrh8eOgDQ4f9c9qMm3bCDtDMTu
	HvOj3Bxy4Maq6uKk2lFqAsVAItJ3SS70N+aUA32M954uPmfhkI7dcWtMVxxdMXBhHLoIjGkXJM8
	IAeSLZfDFM+6PkOTghStM5C98Usa5n64BV74K1BBLX0Hxhp761Ea02l/dtg3ERTtyvA/IbbpGJd
	7zZupjih6ztn0hOoV+kUDzkhyh2BZFYE01mgCa8HGPFybB2cJtuNlc9FdxLxER8oUSfAwmCGq9m
	QY4wrQKlJFykaibeSH6rynTOAuYsjjXLT+au0CKD5sLAPBoGq/fuCkkZGqD5YehMD8RKmERkDST
	uxfeiYlPG1ASIC/Y8q3yKcRQavKT7f1eYXx5W5OuiYl5GFdCCC6XY=
X-Google-Smtp-Source: AGHT+IFcl4Bo2iRnn9SQ4R5pthHC8V2HygnH866pn1+ULEALSY6EUZm9nBo5CT91dKPigulLVZJWlg==
X-Received: by 2002:a05:6000:2485:b0:426:d82f:889e with SMTP id ffacd0b85a97d-429bd67c45dmr79155f8f.14.1761839665373;
        Thu, 30 Oct 2025 08:54:25 -0700 (PDT)
Received: from google.com (218.131.22.34.bc.googleusercontent.com. [34.22.131.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9c6sm33378016f8f.36.2025.10.30.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:54:24 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:54:21 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, qperret@google.com,
	keirf@google.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v3] KVM: arm64: Check range args for pKVM mem transitions
Message-ID: <aQOKLaCKUDcqIZeM@google.com>
References: <20251016164541.3771235-1-vdonnefort@google.com>
 <aQMBG0SUlNWuQQFZ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQMBG0SUlNWuQQFZ@google.com>

On Thu, Oct 30, 2025 at 06:09:31AM +0000, Sebastian Ene wrote:
> On Thu, Oct 16, 2025 at 05:45:41PM +0100, Vincent Donnefort wrote:
> > There's currently no verification for host issued ranges in most of the
> > pKVM memory transitions. The end boundary might therefore be subject to
> > overflow and later checks could be evaded.
> > 
> > Close this loophole with an additional pfn_range_is_valid() check on a
> > per public function basis. Once this check has passed, it is safe to
> > convert pfn and nr_pages into a phys_addr_t and a size.
> > 
> > host_unshare_guest transition is already protected via
> > __check_host_shared_guest(), while assert_host_shared_guest() callers
> > are already ignoring host checks.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > ---
> > 
> > v2 -> v3: 
> >    * Test range against PA-range and make the func phys specific.
> > 
> > v1 -> v2:
> >    * Also check for (nr_pages * PAGE_SIZE) overflow. (Quentin)
> >    * Rename to check_range_args().
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index ddc8beb55eee..49db32f3ddf7 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -367,6 +367,19 @@ static int host_stage2_unmap_dev_all(void)
> >  	return kvm_pgtable_stage2_unmap(pgt, addr, BIT(pgt->ia_bits) - addr);
> >  }
> 
> Hello Vincent,
> 
> >  
> > +/*
> > + * Ensure the PFN range is contained within PA-range.
> > + *
> > + * This check is also robust to overflows and is therefore a requirement before
> > + * using a pfn/nr_pages pair from an untrusted source.
> > + */
> > +static bool pfn_range_is_valid(u64 pfn, u64 nr_pages)
> > +{
> > +	u64 limit = BIT(kvm_phys_shift(&host_mmu.arch.mmu) - PAGE_SHIFT);
> > +
> > +	return pfn < limit && ((limit - pfn) >= nr_pages);
> > +}
> > +
> 
> This newly introduced function is probably fine to be called without the host lock held as long
> as no one modifies the vtcr field from the host.mmu structure. While
> searching I couldn't find a place where this is directly modified so
> this is probably fine. 
> 
> >  struct kvm_mem_range {
> >  	u64 start;
> >  	u64 end;
> > @@ -776,6 +789,9 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
> >  	void *virt = __hyp_va(phys);
> >  	int ret;
> >  
> > +	if (!pfn_range_is_valid(pfn, nr_pages))
> > +		return -EINVAL;
> > +
> >  	host_lock_component();
> >  	hyp_lock_component();
> >  
> > @@ -804,6 +820,9 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
> >  	u64 virt = (u64)__hyp_va(phys);
> >  	int ret;
> >  
> > +	if (!pfn_range_is_valid(pfn, nr_pages))
> > +		return -EINVAL;
> > +
> >  	host_lock_component();
> >  	hyp_lock_component();
> >  
> > @@ -887,6 +906,9 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages)
> >  	u64 size = PAGE_SIZE * nr_pages;
> >  	int ret;
> >  
> > +	if (!pfn_range_is_valid(pfn, nr_pages))
> > +		return -EINVAL;
> > +
> >  	host_lock_component();
> >  	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
> >  	if (!ret)
> > @@ -902,6 +924,9 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
> >  	u64 size = PAGE_SIZE * nr_pages;
> >  	int ret;
> >  
> > +	if (!pfn_range_is_valid(pfn, nr_pages))
> > +		return -EINVAL;
> > +
> >  	host_lock_component();
> >  	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
> >  	if (!ret)
> > @@ -945,6 +970,9 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
> >  	if (prot & ~KVM_PGTABLE_PROT_RWX)
> >  		return -EINVAL;
> >  
> > +	if (!pfn_range_is_valid(pfn, nr_pages))
> > +		return -EINVAL;
> > +
> 
> I think we don't need it here because __pkvm_host_share_guest has the
> __guest_check_transition_size verification in place which limits
> nr_pages.  

__guest_check_transition size will only limit to PMD_SIZE, which can be quite a
big number if you consider > 4KiB pages systems. So I believe this is still a loophole
worth fixing.

> 
> >  	ret = __guest_check_transition_size(phys, ipa, nr_pages, &size);
> >  	if (ret)
> >  		return ret;
> > 
> > base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
> > -- 
> > 2.51.0.869.ge66316f041-goog
> >
> 
> Other than that this looks good, thanks
> Sebastian

Thanks for having a look at the patch.

