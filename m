Return-Path: <linux-kernel+bounces-856322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFFFBE3DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F1A188B134
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B381D54FE;
	Thu, 16 Oct 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dwCRqlcK"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E219F111
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624253; cv=none; b=IfkOCiG6e8AziZp/o+4yw9vzmAMtCcnT6YiK99XXV+z+RiiagXREsrZ6oQufhusOPvKLR3f2Q2jSA3wLF0nf+8byTaCLMSZJ1SOGsngQpzOXM9pJE2hWVxmEvi8uVYuZD001gFu+y5XihgyWBnzkF733s37GWuC4lWeTY/1BbV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624253; c=relaxed/simple;
	bh=MjX01ygQ/3tk/sGwgwk/36ebQMdAkveFRCJrUinD/Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhiJ5ns/YGC4Wt9FZ0HJzn4DlN9IXLL7BB05pA1bwjVOisKXFrnVLJLvFigM/usXukWsqeJeB9CbvmGPyiejklTkF7u4YgrCxRyjh9WJMvyuOqrRhuuEyp/0ogJ9lYbidFq3PS030+FCS7VOdJ6mqExESO3rZFvD+JwQB+Bh+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dwCRqlcK; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87c1a760df5so11184256d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760624251; x=1761229051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDx8+7T+MYrCmWnRteKVa1iC6/sCWZvHc99T+OB8RqU=;
        b=dwCRqlcKPsDQVOHquk4yaz5Cv4fPtBLRWee5G2rzxUKcdtZMxVfMRjn0mDOxVrewwz
         KhG5boJn1F0EHcgdAzDtOfdzxeKOTi86FsXlAOWzMrmH+qmHPIjPHnnbJKnBial5NN2b
         4s7Z9es5jhpxKD0kAxJ8BkzNr5E/4oEnPzEGRDR69OAByvk0p7UU3lTzxrx7vGBSf9Z3
         oFPf1jGc9s4O18ef3Jiycd7b1+QVMzmqQadgc3U4egLfYhQRJcWQGXsUfbZhQjhFupIc
         gADI612o9/2HT+1Ux5P4OzN0RB9D9sj32O8DTRenmNW2We4+C8H08EuCwSxwVtoUYDcS
         l0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760624251; x=1761229051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDx8+7T+MYrCmWnRteKVa1iC6/sCWZvHc99T+OB8RqU=;
        b=Q1EaquPVC2Sg14ifE5ugqiXQVZSaM0i9YXW+0GV28dE9OPPVpO0lDB4VAjoIvaqhR9
         7memV2rW9CEap1CJRNm/dDmWVZnYejIzcKvomH+bhdEPbkI0ToQiv6ksHQso71A+OgrW
         hK8Rr3PnJByQ1mQW4zkzOCi0UQ2hDUKE9uSVwE0WhgBhmaS//YafE30me6n7GckHcQ54
         6dT9xFoVTC9hWJnKUMwprsWm6ucpKf8U0wdMSx6z4dc55t4Kfnxggjn1m8Si8fnHf2jM
         Di+cvrR0ng42ioZYfBGJPzKYYJMLqP512t9l6UMBRd3fv++JjsVdWo/VPtoMEbuFrqCn
         8Diw==
X-Forwarded-Encrypted: i=1; AJvYcCVoZNqaDLBkDH4hLLSiIBD9Sob4Gt9EMqFu+4nMYPl0VgVJLT5QVJHtl40LiM+XzVNlklTXS/llGt8UryY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxjcCXlY6ZsIbBp6ViynenA2SnAJ1R79vlYzrmAN2No+mjRa9m
	saqEZxGaiH1yB6rCz33ktaPO2Ta2AhWaTC5jDg5dACM0PSM3GykjZ4ZmT9jiJ2Eh9Ws=
X-Gm-Gg: ASbGncs8+twC5tp9+quCU0MY0EeJnPTtiSud8ud96VdaEPX2uNmAL6LBWphII8xI1EO
	SMkM0mXJdn1/oqFJ+WcrFiyFakXEwYv45xlEQBNNacJ20pLglWUc5W5JU1ZS2o2yq/8l95AhQ5g
	HN/KwlmHfMX+hz2WGEqCHOjV94u0S7dVFhUQzqs2rgCxaPDoGPT5BLPnKskUjL0TUGCKjNKQsE8
	CxNOrxmMDHFmVG9fIk9THD7mAhcxUOYXOSRDcV84Ozzsbyckc8hoDD0H/1RkW3KRl2OtCmjssB+
	2o5TACh3CiHaY/ipatXvuqCpJ4N75KA5250gGfW4vgtiSs9AWu1vQt++j1twSx42i/DRw4n+5xN
	Ous1TnSWLRxH+izV6q80if2r3L9arFEX7WYkWGGr0ysCEfjsrNQ2BJbrA88zRUnZtM7i0QY2R2t
	ZGcvC7BE2cPKb1t9ZFrH0mi3SCIMJqRhmi0kSXeZ92zbKwnLuSIOGQQOntD5cIF/LFENvfzg==
X-Google-Smtp-Source: AGHT+IEMapVQRI0ck2KCGxvEYuBB3a+08a/2JspNz86EbcND1SGuRInp+B2xwxF3NumJMeFQLVJPkQ==
X-Received: by 2002:ac8:5883:0:b0:4e8:99b0:b35e with SMTP id d75a77b69052e-4e89d263140mr4179321cf.30.1760624250594;
        Thu, 16 Oct 2025 07:17:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8955b07e9sm13309541cf.27.2025.10.16.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:17:29 -0700 (PDT)
Date: Thu, 16 Oct 2025 10:17:25 -0400
From: Gregory Price <gourry@gourry.net>
To: Sean Christopherson <seanjc@google.com>
Cc: Shivank Garg <shivankg@amd.com>, jgowans@amazon.com, mhocko@suse.com,
	jack@suse.cz, kvm@vger.kernel.org, david@redhat.com,
	linux-btrfs@vger.kernel.org, aik@amd.com, papaluri@amd.com,
	kalyazin@amazon.com, peterx@redhat.com, linux-mm@kvack.org,
	clm@fb.com, ddutile@redhat.com, linux-kselftest@vger.kernel.org,
	shdhiman@amd.com, gshan@redhat.com, ying.huang@linux.alibaba.com,
	shuah@kernel.org, roypat@amazon.co.uk, matthew.brost@intel.com,
	linux-coco@lists.linux.dev, zbestahu@gmail.com,
	lorenzo.stoakes@oracle.com, linux-bcachefs@vger.kernel.org,
	ira.weiny@intel.com, dhavale@google.com, jmorris@namei.org,
	willy@infradead.org, hch@infradead.org, chao.gao@intel.com,
	tabba@google.com, ziy@nvidia.com, rientjes@google.com,
	yuzhao@google.com, xiang@kernel.org, nikunj@amd.com,
	serge@hallyn.com, amit@infradead.org, thomas.lendacky@amd.com,
	ashish.kalra@amd.com, chao.p.peng@intel.com, yan.y.zhao@intel.com,
	byungchul@sk.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com,
	michael.roth@amd.com, bfoster@redhat.com, bharata@amd.com,
	josef@toxicpanda.com, Liam.Howlett@oracle.com,
	ackerleytng@google.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
	jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
	dan.j.williams@intel.com, surenb@google.com, vbabka@suse.cz,
	paul@paul-moore.com, joshua.hahnjy@gmail.com, apopple@nvidia.com,
	brauner@kernel.org, quic_eberman@quicinc.com, rakie.kim@sk.com,
	cgzones@googlemail.com, pvorel@suse.cz,
	linux-erofs@lists.ozlabs.org, kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, pankaj.gupta@amd.com,
	linux-security-module@vger.kernel.org, lihongbo22@huawei.com,
	linux-fsdevel@vger.kernel.org, pbonzini@redhat.com,
	akpm@linux-foundation.org, vannapurve@google.com,
	suzuki.poulose@arm.com, rppt@kernel.org, jgg@nvidia.com
Subject: Re: [f2fs-dev] [PATCH kvm-next V11 6/7] KVM: guest_memfd: Enforce
 NUMA mempolicy using shared policy
Message-ID: <aPD-dbl5KWNSHu5R@gourry-fedora-PF4VCD3F>
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-9-shivankg@amd.com>
 <aNVQJqYLX17v-fsf@google.com>
 <aNbrO7A7fSjb4W84@google.com>
 <aPAWFQyFLK4EKWVK@gourry-fedora-PF4VCD3F>
 <aPAkxp67-R9aQ8oN@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPAkxp67-R9aQ8oN@google.com>

On Wed, Oct 15, 2025 at 03:48:38PM -0700, Sean Christopherson wrote:
> On Wed, Oct 15, 2025, Gregory Price wrote:
> > why is __kvm_gmem_get_policy using
> > 	mpol_shared_policy_lookup()
> > instead of
> > 	get_vma_policy()
> 
> With the disclaimer that I haven't followed the gory details of this series super
> closely, my understanding is...
> 
> Because the VMA is a means to an end, and we want the policy to persist even if
> the VMA goes away.
> 

Ah, you know, now that i've taken a close look, I can see that you've
essentially modeled this after ipc/shm.c | mm/shmem.c pattern.

What's had me scratching my chin is that shm/shmem already has a
mempolicy pattern which ends up using folio_alloc_mpol() where the
relationship is

tmpfs: sb_info->mpol = default set by user
  create_file: inode inherits copy of sb_info->mpol
    fault:    mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
             folio = folio_alloc_mpol(gfp, order, mpol, ilx, numa_node_id())

So this inode mempolicy in guest_memfd is really acting more as a the
filesystem-default mempolicy, which you want to survive even if userland
never maps the memory/unmaps the memory.

So the relationship is more like

guest_memfd -> creates fd/inode <- copies task mempolicy (if set)
  vm:  allocates memory via filemap_get_folio_mpol()
  userland mmap(fd):
  	creates new inode<->vma mapping
	vma->mpol = kvm_gmem_get_policy()
	calls to set/get_policy/mbind go through kvm_gmem 

This makes sense, sorry for the noise.  Have been tearing apart
mempolicy lately and I'm disliking the general odor coming off
it as a whole.  I had been poking at adding mempolicy support to
filemap and you got there first.  Overall I think there are still
other problems with mempolicy, but this all looks fine as-is.

~Gregory

