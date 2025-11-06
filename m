Return-Path: <linux-kernel+bounces-889113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8EAC3CC57
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41225660D3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902FB34D918;
	Thu,  6 Nov 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOdGsbOb"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EDF345CBD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448944; cv=none; b=eB1OK81Oi05VXwUprbLqIwb819sj9/jgQxqK/XIRB1ogazNXmGe/jEpKCNXGwUVNnfv4REiwM0wUQv6F77iVxYiZEXrb22D11u3oFlKseOsdoRktDoCKSslLUlmlZ1KWeMltOJSv0lhXAtooVgiVcaGeeZywx2fXl46tghrso2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448944; c=relaxed/simple;
	bh=brTwyt3ALfzwXTTOJDXGAi9yS9jEzrppUFzQdw+ocYk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=PrgHTNJSlAftO/OtCGCFJEiZHYC1o/3qS1g6uIK4cI/8Mel+DistERKL7XWTAVRDrmWzon9wgzH4SpIuUJqkX64pJQMsOsp91MG4MaG7nDvOPlJeGjG+/n5P2UvHT1b4LCj7i21b2fGRluznvTWmo91go46dkf2OoUYS43v5CdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOdGsbOb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1204433b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448943; x=1763053743; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nxXbjl0HhdoITaZBDxLqmLJTjrhCiLD5WEPTG0leRLU=;
        b=VOdGsbObG8XS2cOV/oYGc6509C6pplAtbg3R/s9fYoV/Y7NElk8ISvmQH5MXg0zHRn
         H2VHstJF/sP+ldXVTkrRuSVf5bWaMIUBhg+DsqODrJ2XDvywK/VeWTJPb4TpQK1FnuuN
         gvjpENQYU5sonetuDZTa/Dbeq56zYz5q7NhtomkbwAyYs+h0Jjw6NN1oalLAJEw/2AMm
         OEp5o7ey6EsJCw4mH+HyTihqHEHbja1NnhyMqRRxRYfF8ArU8Lc9yd8EBX/bq7t5qeVv
         wBWDoNRNM2QbpXSl7k922aAWxH51VOj/gzpa9JGoYn6o4XzyjnHXfxDOcIe2srSrsbTn
         N76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448943; x=1763053743;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxXbjl0HhdoITaZBDxLqmLJTjrhCiLD5WEPTG0leRLU=;
        b=boJ3iqMkerFjJ57KtWpsZWVB27i9fmpAquCJAQer8qxEERvhw3GxYHr7y5+sBfsCym
         tD4KhXJJSbq+4cDhjyFwZtibJKM00zNJmdXZdN6/b+rFIrcIzN5n3ZxCjraCXOYsNzQw
         R1mw3v46E8OnSdU93pO4yb6GaSGbadOqPMHtza4+OArGm3KiPVPG/ccNz0ZPlxJ/EvOR
         tOU+rwgyyskXUI2bAD76pppRvgV+9EiS1PfEPQsyutvnwsFusWi/fozhSErLio8mQMe3
         KLJqPrZp3hafYzCi/4AFF4qT/FjT4K/skb6ovp3OBVz0cwyGfmXRJ5UhYiAyuIXPjXyE
         F+xw==
X-Forwarded-Encrypted: i=1; AJvYcCXLniL/kYZiGZxd4MNy0kaStX0Gg0OXo4T7+aYOsmltTR+kHazUBJPeIjX6RfGkd7t+373linkFGv86dZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHiDHGgUMoXB6r2aoq3vEHhF3zOwLrgkFe9DtnTTZ6Ze3J2PXv
	y+emI8uRamaFrUN9HeqqsXVEeAvdaN6Aa4zSsc7+q/vIY+MbrVuD+W+C
X-Gm-Gg: ASbGncsUQPmCYanxm4HL4W/jmd8efqutEYIlClgGdRnJR2A4PlMte65GtM8KYDDoynH
	Z0Z0/vrbLdy2eQWQGDxe+yAz29ocrYp3lE04qAuKb7NXoucbKRGOCf71+1WJ8mHPUKxB8UuYyNa
	6naFqeoqPjHKrYJux2/tzbnqzVbdVqT7pxefc/olAMKlFd9BljLS99jMRmmKmGqg4+OVu9Iu+p9
	F7hvOYY4o55GBv4PNUhdoxLMCjAiQViwQRnX5XxlyvAowN9DcsinhpCUuY67yV+/bhra1lM00yS
	s7Mgmbl6SrX5FNV4uDDecn+0E491Wk6uahFm5xk42Rit2CU6zm2x/7hqrXxqxuC10QLvG4G/X2z
	BSstWLaENVrLpJJnGx8HtK0FsIcBOgoQceFbeKGiq/TwrP6VNshWbu+NtJheHx5idgXKg7Q==
X-Google-Smtp-Source: AGHT+IGcGbtG/gxArci+CopvKuv0vsWkSHD0Cj0H8EsVfNgzuLLOXCCQpVWCS8AAZU2IHguSNAAo3Q==
X-Received: by 2002:aa7:88c2:0:b0:7a9:f465:f25 with SMTP id d2e1a72fcca58-7b0bdb856abmr331762b3a.27.1762448942695;
        Thu, 06 Nov 2025 09:09:02 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c0874bsm68007b3a.16.2025.11.06.09.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:09:02 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, 
	Juergen Gross <jgross@suse.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH v4 07/12] mm: enable lazy_mmu sections to nest
In-Reply-To: <87ikfn3yvs.ritesh.list@gmail.com>
Date: Thu, 06 Nov 2025 22:31:27 +0530
Message-ID: <87h5v73xjs.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-8-kevin.brodsky@arm.com> <87ms5050g0.ritesh.list@gmail.com> <50d1b63a-88d7-4484-82c0-3bde96e3207d-agordeev@linux.ibm.com> <87ikfn3yvs.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> For e.g... 
>   
>     arch_enter_lazy_mmu_mode()
>         hpte_need_flush()
>             get_cpu_var()   // this takes care of preempt_disable() 
>             adds vpns to per-cpu batch[i]
>             put_cpu_var()   // 
>     arch_leave_lazy_mmu_mode()
>

Sorry, here is the more accurate call sequence for previous email.

caller()... 
     arch_enter_lazy_mmu_mode()
     ptep_xxx_()
        pte_update()
             hpte_need_flush()
                get_cpu_var()   // this takes care of preempt_disable() 
                adds vpns to per-cpu batch[i]
                put_cpu_var()   // 
     arch_leave_lazy_mmu_mode()

-ritesh

