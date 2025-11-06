Return-Path: <linux-kernel+bounces-889085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4F3C3CB03
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1943B4E8C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D0833F8BE;
	Thu,  6 Nov 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTI5nTcL"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB83002B7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448331; cv=none; b=XGp+r54f9MDTdKQaX2Irm2WDbpDCo5qZWlxK4QhLEfzC6heMvoj3asfqWuFtW5/+sls+S/Hg4t8EKyAdBe3E5WPBiEXhy/93HYg8ODddBfnu6zaocf4xlz8q7xk95nYlRHvhaTtIqy63rKxKx3MUGjJWVTb8lajCcNObxwjM3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448331; c=relaxed/simple;
	bh=BOt4fX3vP7Dk8HqITO4nB06oLQzIotDeNqs6n2sz1vU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ACsLzfP7hlo9jJOtIfyTdLaxWWnOPxL2AVVT+nU9ZhI4fNmbT/0goqGiIZpBuSJgn+LAJ4AXRzZEbSmAxXYSZXJkTyLgKrSbzUwk2laIw2pFS7KZZr5aKVVxNCza6oNOYi6ISP0c4dzM7WaGZYGhKJDmT9+svtZqS/lhFttyXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTI5nTcL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b9ab6cdf64bso988045a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448329; x=1763053129; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mwdpEtZUkKLd4HieJ0n4xeeNKNrAgrCllkk+QdYNeo=;
        b=fTI5nTcLRGsCSJPGLp+EyTKKBKp85BaumdKq5rsTqimzubzlRRKU8LyQjeYrcAEDMG
         POIzO7r2ls/oyVEQz986aocRRUrmLB/aza+qhqPRdj7MV5U+f9Xj7FtFSE0UsVkTGx/j
         W6e4HmPUQYCUsap0gjZupz4+rLp1j9Gh9dLYsFYJMzxrouIx7QYnWRfiurmaf0OjMzLi
         G9p/1esJC38VzBxBeT98oYYYqatFSdyNRJ+CgO6y1IUeQX/OsGNK+kShZoTmqor+JGij
         nIfinDBaAM4uyYd8sMqR5ZkeKWLit+onELd2rsAhsTM12CEjZyPxycatV0cKHT5KgNhY
         yMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448329; x=1763053129;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mwdpEtZUkKLd4HieJ0n4xeeNKNrAgrCllkk+QdYNeo=;
        b=Scw4dgRBp+PhRDgXyXKLvdepSWvVAyMy559sxRcPAiy5yicpOoCWsXdnCuHVP8p5Cg
         4HMzLV6Qg6Am9T0IxfJOC5hh6R10mQftkk2l17EyPfZBYJEoqZg8gJtkwM2u1VzJJhbE
         0ECXNqD4IJOItlqoHjVuiQzxS/xZL5YdLDMBOdvX8ssZqtfeZYnda2fSUSaR1dXXfsRq
         j+DXX4PDyw6Z8xeTTqz5ag19jD1s50PieMH7sMxuyHXMOnwAAktJLnBAPcnWPnRwGDf3
         hWtgfTsTPGHi56q+wMUhGlqx16Eeq9ULpsoNq3RyVJXJ3HFj/izLi4TSlgum3YBTNWye
         r/rA==
X-Forwarded-Encrypted: i=1; AJvYcCWbGjnVtQlCX0wg04SQon4UZ4zIXvppcyHRzjR23F66lcqNJNqnmhxWaV4VaoLvBVUEc4glbSTvLktzikc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYKqbmGRgEgs9M7XG1QdVtFrgSpRzBzuTcvrgCiO0NfGLPjTL
	xvVCn6KscPNOeMn8ceDBSEnOT3OcT8KWQGP61wKp7E/T0gsy4zonHADv
X-Gm-Gg: ASbGncvveiLu/wETC0JSuSPHWdGnkUR5pescX3A694DV9hh7ZD7WoKDDDqH2IUD+Gt9
	xPWNYRpcBmNJigaGRdws5upedxbzlWcVJSawB2msIUAjYuBpUxFqeNzQyNFE1W5P9/MpTi2q4w6
	6bJegsfcHswZXuOJanF/8Wvi4Epi0Yk76fxFmx2lC5CWE952Ja+1fzIRyfACeEKvOTqao8x5EkU
	Ch6i26NgxBkNazOKHHr5YYJyCZTF7o3fsgFh97CaSOE9caeE1/2sZ2jO6K3OrgJN8jTkBbxWDHW
	Zohyf4pUGdveUN77LSN+A6LeSHK4SQAb/mmbHB4Lo5mOT4e+CQ2HjUaIj2/Zzsk/scTPHYMuacm
	IhBz81YZuJVY5f2yYz6mIDOl+CKhaJjk+TinSK8lNMKg1scVZwAyWNtogmCegQFmwL3+IZg==
X-Google-Smtp-Source: AGHT+IEmGC1fJcE4OAtV0Owu2fNKpRqQY3VzTeskRzxNQPbLVeyWOXOzToL4xIfj+nPDKGb1lmA/VA==
X-Received: by 2002:a17:902:ce07:b0:295:50f5:c0e3 with SMTP id d9443c01a7336-297c00b9141mr3517035ad.14.1762448328641;
        Thu, 06 Nov 2025 08:58:48 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8c880c5sm3013244a12.6.2025.11.06.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:58:47 -0800 (PST)
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
In-Reply-To: <50d1b63a-88d7-4484-82c0-3bde96e3207d-agordeev@linux.ibm.com>
Date: Thu, 06 Nov 2025 22:02:39 +0530
Message-ID: <87ikfn3yvs.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-8-kevin.brodsky@arm.com> <87ms5050g0.ritesh.list@gmail.com> <50d1b63a-88d7-4484-82c0-3bde96e3207d-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> On Wed, Nov 05, 2025 at 02:19:03PM +0530, Ritesh Harjani wrote:
>> > + * in_lazy_mmu_mode() can be used to check whether the lazy MMU mode is
>> > + * currently enabled.
>> >   */
>> >  #ifdef CONFIG_ARCH_HAS_LAZY_MMU_MODE
>> >  static inline void lazy_mmu_mode_enable(void)
>> >  {
>> > -	arch_enter_lazy_mmu_mode();
>> > +	struct lazy_mmu_state *state = &current->lazy_mmu_state;
>> > +
>> > +	VM_WARN_ON_ONCE(state->nesting_level == U8_MAX);
>> > +	/* enable() must not be called while paused */
>> > +	VM_WARN_ON(state->nesting_level > 0 && !state->active);
>> > +
>> > +	if (state->nesting_level++ == 0) {
>> > +		state->active = true;
>> > +		arch_enter_lazy_mmu_mode();
>> > +	}
>> >  }
>> 
>> Some architectures disables preemption in their
>> arch_enter_lazy_mmu_mode(). So shouldn't the state->active = true should
>> happen after arch_enter_lazy_mmu_mode() has disabled preemption()? i.e.
>
> Do you have some scenario in mind that could cause an issue?
>
No not really. But that's a deviation from what previous arch hooks were
expecting. Although thinking this through - I don't have any usecase
where this can be a problem. 

But let me re-visit some of the code paths on ppc64 lazy mmu... 

Looking at the arch specific usecase I see we always do get_cpu_var()
for accessing the per-cpu batch array which disables preemption before
accessing the per-cpu structure.. This per-cpu structure is where we
batch pte updates... 

For e.g... 
  
    arch_enter_lazy_mmu_mode()
        hpte_need_flush()
            get_cpu_var()   // this takes care of preempt_disable() 
            adds vpns to per-cpu batch[i]
            put_cpu_var()   // 
    arch_leave_lazy_mmu_mode()

> IOW, what could go wrong if the process is scheduled to another
> CPU before preempt_disable() is called?

So from above - I don't think your sequence to update
   state->active = true 
before calling arch_enter hook should be a problem.
Based on above this looks mostly ok to me.

-ritesh

