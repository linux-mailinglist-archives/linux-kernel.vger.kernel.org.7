Return-Path: <linux-kernel+bounces-833427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF54BA1F13
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6B77B41FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9622F2EDD62;
	Thu, 25 Sep 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVbDYwXa"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3972ECEAC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841977; cv=none; b=RolZ4ejA854n61pPu74+YEENawesY8LZwRmOLw6m3vy2K48Anhrg37+5Q4f4nzlgPgvhAk8ohWpNukKwuqGUYwLTJLA/u/S8mxuFAeOyJX/mxjH6tygP2I7ROjLQCbMvfxAZGXyYtqMB48EHubQ6Cr5qiurQN8kGdz+6x3yQGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841977; c=relaxed/simple;
	bh=s9eeTE4+TFjXly65mL70gO5Nj1aP2Sg3pnQCFQVgq5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gFf9LvLxZnHl0UTJj1IT6XeCiYQ8v0245ad1vwEl0N4WQGkuS4+2QFoLpu2vHgzeFBKH92wlVXztwA7tNtEfrvJbr2FGVpMghL1pmSKAG1lieHsdhAq0ZZNQlhkFNksfgj2Wpg18P48Qw2q3JRdD2vEHjUiw7FnkhgqEXmPTX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVbDYwXa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2681623f927so14656875ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758841976; x=1759446776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGCCSnKnyPGGdnUTp10aKL37FULfLm3dyeD1VoFdI2I=;
        b=sVbDYwXasc2mcrj61avHgC1rB4YS0wPRRtbb4hZag5XVUbPrS7XQbZSXAOeH9jVejv
         Lt9oPzSl/U1GW2nDxx0Umcn/39IAfO2vqIjTuyLV/iNKTF3pjM306hf8KFdMUYd7uK5F
         UmGtT8DDR027cKAPDEEkorjVd2HIwGcJf9hCl/irDGiSLK5wDccG7kUlDD5gEgr2CPZG
         IwAzCrxniJa9Z38PYAkkm2LMqGtuV+jSvkBm4t7N9ryIAvVWkvD5bLByKskb1WvHeuDA
         ikqy2CYzoPapkeA4WyWnowQjrjZ4YOOaRktX3nOFshQHQi6FA9M5SvxyUH7k4HTpUiEJ
         Gz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841976; x=1759446776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGCCSnKnyPGGdnUTp10aKL37FULfLm3dyeD1VoFdI2I=;
        b=EUPHYarSrWiECDYql1UAnq0MR+GgrhFvNlGFJKgxPoGFQSmbG3yZTBm2W56QulJm8i
         j1ua7477dyVwHCCpJqViq1JMcd8019BD6sYK515yGZVwvQ6jcfNf9yla6uVEm8KS1nLP
         5pjRCztxFAncdJGxIV3yfz1nOvS9VEqRf7avERCMJ4T14RQ/eomnb9283incSZjHKKd2
         SgibXRDkg4X5rlpWQLDqTflZ4iHEbtpTEJzPGh/iut9zhn44x3SDiy3p4DOLpTSHdA/C
         nEpedMZPkIemnZBT0mBhvyE9426pSnosjktKZS3bYayDDt0PkERbdSq4sjRGWP6o93X1
         w1wA==
X-Forwarded-Encrypted: i=1; AJvYcCUR6SY2D+0giqSbw7TVCIRzG6Kb/7Yq0wY6KH3zl/fQnmYuRsEZcWxNv4trUH/XnlrHPr6pQhAxzyc9WD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIuXcB8qX3MJd0FDglalbe9n6nTXPmqoAqpII0/xIrVcOv2PxZ
	meGY6Z4JasTNnBRn26t8hbMsEsAKNvIPkXjT2HP5ubLmGiYwjOWSZ34bJ6Jh5OpJvQrnv5cB1RX
	svnrGsw==
X-Google-Smtp-Source: AGHT+IFE8gFtFdnHNmX2p6THQrFO41fYST4gwotcfBj6rGswgxHnE9CG8NuKci3w5GnRskLMvJFI/+Q8X0o=
X-Received: from pjbjz6.prod.google.com ([2002:a17:90b:14c6:b0:330:9af8:3e1d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e883:b0:262:79a:93fb
 with SMTP id d9443c01a7336-27ed4a7ecbdmr51468535ad.32.1758841975402; Thu, 25
 Sep 2025 16:12:55 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:12:53 -0700
In-Reply-To: <20250925230420.GC2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-10-shivankg@amd.com>
 <aNW1l-Wdk6wrigM8@google.com> <20250925230420.GC2617119@nvidia.com>
Message-ID: <aNXMdSZkqDtsGRLm@google.com>
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shivank Garg <shivankg@amd.com>, willy@infradead.org, akpm@linux-foundation.org, 
	david@redhat.com, pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com, 
	xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com, 
	jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	tabba@google.com, ackerleytng@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, 
	vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, 
	michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com, 
	Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	aik@amd.com, kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 25, 2025, Jason Gunthorpe wrote:
> On Thu, Sep 25, 2025 at 02:35:19PM -0700, Sean Christopherson wrote:
> > >  LDLIBS += -ldl
> > > +LDLIBS += -lnuma
> > 
> > Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
> > any of my <too many> systems, and I doubt I'm alone.  Installing the package is
> > trivial, but I'm a little wary of foisting that requirement on all KVM developers
> > and build bots.
> 
> Wouldn't it be great if the kselftest build system used something like
> meson and could work around these little issues without breaking the
> whole build ? :(
> 
> Does anyone else think this?
> 
> Every time I try to build kselftsts I just ignore all the errors the
> fly by because the one bit I wanted did build properly anyhow.

I'm indifferent, as I literally never build all of kselftests, I just build KVM
selftests.  But I'm probably in the minority for the kernel overall.

