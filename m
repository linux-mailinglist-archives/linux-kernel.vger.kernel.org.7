Return-Path: <linux-kernel+bounces-843389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0D8BBF151
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8603BD90D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118621DF254;
	Mon,  6 Oct 2025 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TE2t7rHO"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C4227563
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778222; cv=none; b=WB0iRm2z53GYyvf/SL581WqS/z4QuDezGKSqKc5ERLw+WR0ZOqOqwNPTmuXOQH+2qIReXWcgoxEvqAb4Wx9AZPJ9ONta7N0VOz66uhdRhIP5yz4fXPjL39IvFWRSRkvZ0FV4c7ef4AKrevbSgdCuAlJ8L0If8N3Uv4RNspnmTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778222; c=relaxed/simple;
	bh=cM60IkBOfzroK8/Hzvuzyt9qlRtbHMsJ/OSo9179Sq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N5rm0GaEYd4Cdt7ed/cCpWGd08UN1/Glfn2z0rSHcfdZrwyu7qzW0nZTfqeyzQqJkzYOAx+rUayHoh0Oa9DYS7TlyHaZR0cEwHDNU4kd5LGgPtXJGkxcVLz5/z7Ydl13UTNNCscnyyvHjRgW6gKEoJAOn9w2iPxqF0g/NKgoBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TE2t7rHO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62b7af4fddso2392956a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759778220; x=1760383020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmP4P4nLLPuVhrMlePaQHRElG0BD9VdigM6MdStk+fU=;
        b=TE2t7rHOVPb0OBN8svNnP6LY+cJXj2jyZBEYy1ljGiQLaiHX/Pt3U2gRJgynz2IFzQ
         3h17ZJp2tLA16kvmUjVSf4pzX+WhuUAe2cgmUQXHiky6URyU+1NgDcPILwALgOjpAB+N
         pB/F9jQBbBkLBPIcVdPuk456KmszUQHeQnybTlMn9Tl9HF2fv+gRFg4ZfR/0PSsIfxGp
         j6v91Fxm3MwFV56dVWkOQ0FP7J7ea2PX8RmkyDQeSABj0IjQSLc/ZCOQxQNhOtMTrI2m
         pPPVrU1lptz63wBFZIBEaAdbsUKbK0td5gscTTxR0HObsDnXgzY3uUK7x+7s/xTtdBSH
         r0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778220; x=1760383020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmP4P4nLLPuVhrMlePaQHRElG0BD9VdigM6MdStk+fU=;
        b=T7mxD41SYTRyTL90dzS6WOA0zGQKZplwL0bT3BG2/AAo9JX2/XG6l9gNZo764Ad6MA
         KRp4BX6dSKMpLL+GJtkwtNMa9WSm1Xk2Pxq+d+L4ZYMjHzWd/a7OL3HUmfZtFVIdrGtc
         PKONJaPCYVAw9Cwcy8l6hdIaRdKzUJZJ/FXvs8pK2dplJCXl/omE1RyRIiF6JjpPm5Pm
         iHQPxypdmm0Jqdx1dlk08g97yk23ZIBih8xbw5eyqWJ5a6hBUtRMQgmxlTyEX37Ie1mc
         tBLt5uabEqJfW6IquswxuMScjSjkhWXciE/pAVb0G76em7PGWpIq6XwiNuQ0zx1aXhjc
         J8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPlwf6BPWrvprAHNFgLvMrq3CWzhEdnn3Duud4crHyHAunxDIZC+iarqDvPYDE61zU3l+GOAEzivKFwTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrVsWz52zoN4bwExlN7qNewjQjVslpQ45SlIf5TPomdGOYraV
	3IgQgcXhzM7Fx12xRopgNKR1RfTF/cC5jHLD/WLdB33VwDuVBCK54piMbTRziMSrqK5WyIII/ug
	13R6DalzYv791fYyU5Dk70RtKFg==
X-Google-Smtp-Source: AGHT+IFyvieDVAJzpWWfH+/pCoaAH28kEGEsXDjiF6l+kpgp/Oi5CGPOiOvnSAUYzLGP6ggwRAbOwNW8BRrqhE15cA==
X-Received: from plau17.prod.google.com ([2002:a17:903:3051:b0:27e:ed03:b5a5])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:11c6:b0:262:79a:93fb with SMTP id d9443c01a7336-28e9a61a8a9mr128039295ad.32.1759778220362;
 Mon, 06 Oct 2025 12:17:00 -0700 (PDT)
Date: Mon, 06 Oct 2025 12:16:58 -0700
In-Reply-To: <20251003232606.4070510-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com> <20251003232606.4070510-2-seanjc@google.com>
Message-ID: <diqzplazet79.fsf@google.com>
Subject: Re: [PATCH v2 01/13] KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Rework the not-yet-released KVM_CAP_GUEST_MEMFD_MMAP into a more generic
> KVM_CAP_GUEST_MEMFD_FLAGS capability so that adding new flags doesn't
> require a new capability, and so that developers aren't tempted to bundle
> multiple flags into a single capability.
>
> Note, kvm_vm_ioctl_check_extension_generic() can only return a 32-bit
> value, but that limitation can be easily circumvented by adding e.g.
> KVM_CAP_GUEST_MEMFD_FLAGS2 in the unlikely event guest_memfd supports more
> than 32 flags.
>

I know you suggested that guest_memfd's HugeTLB sizes shouldn't be
squashed into the flags. Just using that as an example, would those
kinds of flags (since they're using the upper bits, above the lower 32
bits) be awkward to represent in this new model?

In this model, conditionally valid flags are always set, but userspace
won't be able to do a flags check against the returned 32-bit value. Or
do you think when this issue comes up, we'd put the flags in the upper
bits in KVM_CAP_GUEST_MEMFD_FLAGS2 and userspace would then check
against the OR-ed set of flags instead?

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  Documentation/virt/kvm/api.rst                 | 10 +++++++---
>  include/uapi/linux/kvm.h                       |  2 +-
>  tools/testing/selftests/kvm/guest_memfd_test.c | 13 ++++++-------
>  virt/kvm/kvm_main.c                            |  7 +++++--
>  4 files changed, 19 insertions(+), 13 deletions(-)
>
> 
> [...snip...]
> 

