Return-Path: <linux-kernel+bounces-847483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1237BCAF37
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A224C4E8696
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BC7280CE0;
	Thu,  9 Oct 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xRnfeGVe"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E3272813
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045951; cv=none; b=pyGX1upCjuHR27kHeXb2ijxdIIg5rh0d8qVPwEsZzAG7srduxACLhNm9GtCKGzoRnSaljV3Foc9c8cSvtdB/S/qUJJlAxNHqrOSL9fZWSafyT3mKJMwWvJDbWtKjL1onJAIl9vyO1wom653LzXnGbRNJcn3GZ5AlekLa90G3D64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045951; c=relaxed/simple;
	bh=BEzPWEG2tTMKJDi1Ui0rZYJQnidu+uUR6toMxPc1JGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hPLVOjsWVNiA45Vt/LCiFQWMItao0ag+9jaDIUpSQFEzRyoEnaOvucITGWB/mG9iYGbKEU9tjDCNHVcuXLx7pJReSFd38hjgllYhyvg2HxP5YkNbHB5mORfN2ZWEJvmuDdLEEUFGCam9ZpehIdwHwHaamXho84dg9sS8RaY6b2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xRnfeGVe; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b56ae0c8226so1850725a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760045949; x=1760650749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAMGpTBb5JIMylmtnuNcSJ5s50b2UQUcn7vzXw649qs=;
        b=xRnfeGVeGKs4rdXvTTPjusEhdEKSEc3wqFhzLQb/YZmbW4hizineVSg+yUEMt8JkDr
         ox9hsFlh02xpCJP2HUTUkhGfXZ9NgK24sIK8kTSHfExtz8QIP03PrYfybAhRBX6rHWGB
         T0tRRY9n43eHiT0932ZdBzO9DN2fmxuI+9CBMwMfgoliUm7Zr4CDaa9Mx8LxncGslOTR
         do11nZAbBMEnW2MvqeN5tyjNUjXZ0imiTK8ESm2AgNTMAfH2tn49ZQKpTuG96tY4GeyJ
         ZBjZyBIrByHA2FVFg0TZRJBZHkhMdIsFP6TEcEFUS2VuBmpdFMsK/Nof0UMvUJB4ErvP
         7VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045949; x=1760650749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GAMGpTBb5JIMylmtnuNcSJ5s50b2UQUcn7vzXw649qs=;
        b=B2en59stZEehjIOMrZxoDBbCUAYuCrPNeWJerm+0HqZcl1tFZPSIFV48q4UFdgqmaH
         pwfU+ukqKn1N0ndHjr1busyLkzZCJiZbxx7Hfzh6N6WeGr8lhBQSmacNzgcXY3cynMHG
         QTlsQ+MsAALsqKBJgJEtoM7Iri7CP0zuDMfeb6wBfc+BgN9DOOJd4dpS3RNMCjX9aPep
         C8xdoKcmMGkmXfzAGfa61dYYDajbLxr63sszky6CplV5/BigWRQCQ0ESJAlRJfHihSpN
         1OX59dI1Eyiae9Bw6h03NaG8kAlfx7nOzvqBcoiGbBX1IR1cyLmYB/uCeE+GE8NAOt7F
         s4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCURVQPzW7SeRmMXXvhduMoR197PHKNG4ah39GuH8gRWBkJa27l/DANnOipHixeOEPxNhv/PlSMfTHEH0Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw512fCkSFOKNVxcoz3if1hG5jGpYx2R0PtQ+Fdcyr5BkbWQl1
	i29u219Caz8/UoyJ1UOpOpRhT/bx9D7R1L2NkRVb2XWX1Vsf489jp5c3vqiQuKMzJZCjPHNjQDz
	WOiJz8KYslK/hZ7NnZKvp4wnBbw==
X-Google-Smtp-Source: AGHT+IHiLO0Tc7T4efMeJ7arhzRn2QVrxkkt3xAe4o5ah0mgwx2R8IQxbSx0reBo3eWBl5LTjIgto1JJK2FqbDLCmg==
X-Received: from pjbne5.prod.google.com ([2002:a17:90b:3745:b0:330:8b1f:c4e7])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b50:b0:332:250e:eec8 with SMTP id 98e67ed59e1d1-33b51168e20mr13156235a91.15.1760045949059;
 Thu, 09 Oct 2025 14:39:09 -0700 (PDT)
Date: Thu, 09 Oct 2025 14:39:07 -0700
In-Reply-To: <20251007221420.344669-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007221420.344669-1-seanjc@google.com> <20251007221420.344669-5-seanjc@google.com>
Message-ID: <diqztt07hi10.fsf@google.com>
Subject: Re: [PATCH v12 04/12] KVM: guest_memfd: Add slab-allocated inode cache
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> From: Shivank Garg <shivankg@amd.com>
>
> Add a dedicated gmem_inode structure and a slab-allocateda inode cache for
> guest memory backing, similar to how shmem handles inodes.
>
> This adds the necessary allocation/destruction functions and prepares
> for upcoming guest_memfd NUMA policy support changes.  Using a dedicated
> structure will also allow for additional cleanups, e.g. to track flags in
> gmem_inode instead of i_private.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> Tested-by: Ashish Kalra <ashish.kalra@amd.com>
> [sean: s/kvm_gmem_inode_info/gmem_inode, name init_once()]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>

> ---
>  virt/kvm/guest_memfd.c | 77 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
>
> 
> [...snip...]
> 

