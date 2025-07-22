Return-Path: <linux-kernel+bounces-741049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC384B0DF72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE833A5A33
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980D2EB5CC;
	Tue, 22 Jul 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ON5ihzK"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1772EACE3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195509; cv=none; b=nY+HPQEZBUIeT9woP1wzaemq6wIICq3qiR3iNlIDiWxH9M+YjKvz1MATVO8ApMwIQnD1y2avIjnkEBgxydzZoxsBBcbJF23ipW5H5iL8ykwS/FIjYjO0xiK0ENaotO4YDwyld6Dm7W3yfDTL0k4yx3Z1Yv0vpWKgKpXvLJKtUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195509; c=relaxed/simple;
	bh=HVfN2TYraPSfCxVo0AJHXJQLDHAZdY3bb6bzfYt4LeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rtjd/Rr+FH4jFCIKsUf6JBmdPwFFvOplJQJPG9ue5LYJweKFQydYqg1FpL8iAe0TctsxUfjDn0VOk7i6m6hOk0IsszK4bxEtyPMKFBO6ruYOrUODHXa8w7i3WNFmcvXZyKcfDBLNcumbqIQpsWqPzLWrLAh8sSeyyAiqUIMdZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ON5ihzK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b321087b1cdso6369225a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195507; x=1753800307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZgPKLrP/qotO+TNh068TYlpA/4yneLkKMwvnezIBBc=;
        b=0ON5ihzKHu3w+2mvEp1zUZ1v3JNv3S9uPQlKy2+3GwmSOfJFlzYE1IsB4r9pfJAihB
         DOMhSpYLfYWb/iKrac3pyHyTdvnSZ/KF3EY9S29qoZVTiqRqJVKpWktQAAWjU/d4UaMC
         1y6s4GlF5gutBCccizeD3Ytm+5ZQ8iDUZb+NM2jN3oib52ra6KkA7QoMxFQuJn34KiNY
         SzX3v27wdfZ/ABd0i5b/mY3oTsDI1IoUAiZ8Or11TF7H8LJ24KERnQ0ktADNmar0aHCx
         WUcvB33W+xAqJ9EDtq5JVjphoI635Ezixsj+829iVEb6nUNSuEzaOu1h8fVbHZz5NSJS
         nhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195507; x=1753800307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZgPKLrP/qotO+TNh068TYlpA/4yneLkKMwvnezIBBc=;
        b=RrRL0l8XCbLfcge5uJiXZFXMnOQgB8Z24s69UIocc7uYUvN+pMPeTepm6pbWTz1QMq
         HdejSBhSrpnVRJiRv6Z6aia6s1bn4QWvsSNI0KFE05gy+UEvEUfcw1VX2I+Q1DqA5cI8
         34rPVRSBNJRM1n/2REp9Eepc6JnMo1m8M9Llw0/Dvc9hXqHAg+PDJ9S4wyO2F7Ml0o/B
         9EdtNYY8q/4l8pS6gCWub2dCV5zkbW7yGElF5+CtMAguIGotC5m2jFr4gNT/xUCt+wbp
         5f9uBKAjIe8WYj9fXJCwHpo+UKnyL8QIGKJKUu9gakLpjLexxc3CUbsZtm0/0u/AY8EY
         iePg==
X-Forwarded-Encrypted: i=1; AJvYcCWqhlItzgTXhaZJxGZu5beavlequ1exup3Xg/a4bO6msueXfRSoTivYI49uAGKODAsPqW7y9ftNXT0Dxwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+1f/wPYkq3awu7x9SZVoBZhTArMBuOIEWrCE3lap5kJRNrvcu
	J075G06PCBDTDfztScYe7Senx2j2/LFsQRaJqCrcn+ETvMGoHjz/J+MddlEq1w7/dmXWzWlnIJb
	UY3E7iA==
X-Google-Smtp-Source: AGHT+IEye6ryF3i4GwrrW44YhrNpbw96+Sg2XleT9SYl1PadbAW/x1ROmWdG2BYhq8vejYeKBT2EUnzq5Ms=
X-Received: from pgbfm10.prod.google.com ([2002:a05:6a02:498a:b0:b2c:4fcd:fe1b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1508:b0:220:94b1:f1b8
 with SMTP id adf61e73a8af0-2380db8e8d7mr31142351637.0.1753195507419; Tue, 22
 Jul 2025 07:45:07 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:45:05 -0700
In-Reply-To: <bdce1a12-ab73-4de1-892b-f8e849a8ab51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250713174339.13981-2-shivankg@amd.com> <bdce1a12-ab73-4de1-892b-f8e849a8ab51@redhat.com>
Message-ID: <aH-j8bOXMfOKdpHp@google.com>
Subject: Re: [PATCH V9 0/7] Add NUMA mempolicy support for KVM guest-memfd
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shivank Garg <shivankg@amd.com>, vbabka@suse.cz, willy@infradead.org, 
	akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, 
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 22, 2025, David Hildenbrand wrote:
> Just to clarify: this is based on Fuad's stage 1 and should probably still be
> tagged "RFC" until stage-1 is finally upstream.
> 
> (I was hoping stage-1 would go upstream in 6.17, but I am not sure yet if that is
> still feasible looking at the never-ending review)

6.17 is very doable.

