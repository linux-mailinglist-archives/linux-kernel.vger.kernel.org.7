Return-Path: <linux-kernel+bounces-817934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A434DB588F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A13206FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD45F28695;
	Tue, 16 Sep 2025 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhVp9ylA"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999D1096F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981694; cv=none; b=pcGDAKtw7oHrZnvs5W7b3oYfvJ8wlqTyNyPh34FDTAgtqwhyqYwVuwyCASA9OQLqdKXiPl78ewJIwJWWPW2QRt6SRRDbDytlu8PVbuYrCiWIap0x2s/G2rqUWMTxfbNMyQ66UVp7q1SFTMUAWzjA7rfpdPY+zc91dw11GwTl300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981694; c=relaxed/simple;
	bh=OsLjW4akU3BY9HxHKes/Fg5vhJqLQgUMAvjfTlox1sI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=neZteaFqvO6Pe71LWXr/bWAsYjw4xvO5PGAsyxKFyxf8ocCDg12gVY32ScT19PaiFONpNWIZhTb89YPThBmfEt6Wjb1+SnqR/oO0qeBUNwuYlLfFIiksA8WmJepl71dsvCZyyvd0qmLScpBEnvqEnC03mzNpEH4V1DP3GBP37EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhVp9ylA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32e3c3e748dso1379945a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757981692; x=1758586492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgU9Sr+X5atOvzaN9B3C4feqI08CRCY8bdW5NoV8iVM=;
        b=QhVp9ylAWM3NpoowJVl1fHtV/0zvIUq2hgMoKhJE8jemRVPPQovmadLMhcjBQjHFeD
         j60mvZCk42Jt+HeBV3Ijc30lzBZjZb5IxyjPg+YwpVUcOUv2uaYCwYWMuAZRu6NHREul
         kbVXhjTowms3bbnGMJI8lLVwvV7FoiFU1V/dGykO0xoMdnlv4x3hEgvO6oTJ5dtK2NPP
         P5qJdF3UK3spj5hGk/JHZnr/pDOJElOjI5dIciTqcjR9CRsWWylQqJPGSQ63kbtFVAqg
         9oHQJJMjBNCneCzx6zZIV76op37GoWhAiAQPgbklgsahJQUMAG6DaQ5wGBY/ggUh4Fty
         Yb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757981692; x=1758586492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgU9Sr+X5atOvzaN9B3C4feqI08CRCY8bdW5NoV8iVM=;
        b=R/BtRfF+5+hXKc5QpjG2IsijmT2+qYS4COw8gpTB2xZ7zSmS2DEY8Tx0tbJfzJaCV9
         ihsMGJqA69vZe4ReJjq+JZXm2Hw48DZxQTiqhGewZ+IpBIXFev5yWUPgjrH2/5qc6hZL
         GKd6LJQNLFY8Leoj08JS9H3FKoU+TJrjg/JRbD8rkRXNkSTjPWujaneURvTb939q1Wct
         LRuDctlk6oKkcKtFObWenK7Voaij3zlzDBnRsbg7tAoVhaDHFr6Uf3FcBUnBUtpOz8eq
         Apnx4OuM5oA4XAp23R5VrFkIkkucHSAfk2tuDni/5Pkyu3Rn9YhhMtsbMk7Oz+vieN3U
         F2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVPkkVPftwJrgfKZR3RsWwC0M10GeunFYeCkNaYBZyYH3qqOkIuPaMLQ0TJPHCy7yTErtOBdI6iUFSqWho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9Gi6awKFanuDHaYg67hK7G59F1ycMDzcCFtb9dF901zB11nr
	FGFvHTHBkFMzAE9ol4gld7jEQ6uyf+q67NrrSieHTLxXhQjqxG5TSvZctcfcicQmc4844xKVPrW
	X9ksnxw==
X-Google-Smtp-Source: AGHT+IEew5+npo2+KFfx/iV3GURHHosp8EbaGuPuT3orq3HxhycBVJIX/rJ6KysoanrGXrj9mgjO4GOefsU=
X-Received: from pjboh4.prod.google.com ([2002:a17:90b:3a44:b0:327:dc48:1406])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fc6:b0:32e:1ff5:5af4
 with SMTP id 98e67ed59e1d1-32e20049fbcmr10250226a91.35.1757981692221; Mon, 15
 Sep 2025 17:14:52 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:14:50 -0700
In-Reply-To: <aMfMk/x5XJ1bfvzv@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822070305.26427-1-yan.y.zhao@intel.com> <20250822070554.26523-1-yan.y.zhao@intel.com>
 <aL9rCwZGQofDh7C3@google.com> <aMfMk/x5XJ1bfvzv@yzhao56-desk.sh.intel.com>
Message-ID: <aMir-qs5zwmoXU6A@google.com>
Subject: Re: [PATCH v2 3/3] KVM: selftests: Test prefault memory during
 concurrent memslot removal
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 15, 2025, Yan Zhao wrote:
> On Mon, Sep 08, 2025 at 04:47:23PM -0700, Sean Christopherson wrote:
> > On Fri, Aug 22, 2025, Yan Zhao wrote:
> > +		if (!slot_recreated) {
> > +			WRITE_ONCE(data.recreate_slot, true);
> > +			pthread_join(slot_worker, NULL);
> > +			slot_recreated = true;
> > +			continue;
> If delete_slot_worker() invokes vm_mem_region_delete() slowly enough due to
> scheduling delays, the return value from __vcpu_ioctl() could be 0 with
> range.size being 0 at this point.
> 
> What about checking range.size before continuing?
> 
> @@ -120,7 +126,8 @@ static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 base_gpa, u64 offset,
>                         WRITE_ONCE(data.recreate_slot, true);
>                         pthread_join(slot_worker, NULL);
>                         slot_recreated = true;
> -                       continue;
> +                       if (range.size)
> +                               continue;
>                 }
> 
> 
> Otherwise, the next __vcpu_ioctl() would return -1 with errno == EINVAL, which
> will break the assertion below.

Drat, I missed that kvm_vcpu_pre_fault_memory() returns -EINVAL on a size of '0'
(see the wrong comment snippet "Either prefaulting already succeeded, in which
case retrying should also succeed, or retry is needed to get a stable result").

I'll circle back to this tomorrow.  IIRC, there was a reason I didn't want to
check range.size in that path, but for the life of me I can't remember why :-/

