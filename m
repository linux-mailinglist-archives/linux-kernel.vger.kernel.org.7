Return-Path: <linux-kernel+bounces-728334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB87EB026E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4371CC061A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1662622129E;
	Fri, 11 Jul 2025 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqC2iKLJ"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416E19995E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272443; cv=none; b=DFjmRSW7c7si/xDpQjf4K3q0Or9HekaC6xR/Y1v+vTxeXq7/5vY8LNYMmKoMALcn0276H8D52y8W9aZhK3E5VJpuQqsuUdACkw18KxApf5GUpTP6FH/L9OVLbWXtXJgULrOT36cnT0QC+tWGkes74fnBv3zUWg1czYGt7mdmtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272443; c=relaxed/simple;
	bh=aiLl+m3pXvCqa+RbnYWzSIUUoFfQ4c+N74lmpBr/U80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG8pIhfI0UaDU6C7zwwNsOFwfSIV5vaSQyOhaU+9xhjIjs5kNC+Fsywpw3DANEffsOgyXrhN+fdRRfm1hWHTLXWt2+Q0hgUsQUTi6PPZoylrlJapY9jbK1cP+AhOeeicGBngcZXOS18mlgr4eyrRAq4/6ZtkaL4GVaWQXTbglMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqC2iKLJ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab3802455eso10460031cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752272441; x=1752877241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vOhnnbR9J+UeKp0wLMqRexLagkueLaWGi8qXJivDnk=;
        b=JqC2iKLJ5UpRj1H6ViqhVMek6z3AyI/ZaqVbEgDcFrggTD+M/ibU/l8wNckNqbx8vD
         +2z2fylK+MO7e3oDu4caGQgTl9juDIbMlgY+FzLSAcQubb7c2RBC1eYg58WPvJ7aNyJK
         0APpuV/IlsNE+aLf8ul4uzTiKkCi2Bf+GaEDuB0JGEq97Q6M1VLVyGBJ8TLEVstbRIcU
         AFIwWGARjPCwH4WACDmPkLgPVAiovOWP3Zje5KV5NHtNTEkal2wxikAVvERxVLJWW33J
         VhhZNa2ckITL6q9U2V/8fsqS9KOs1gfMNxovtqvd2KwOJ/WaRx+Jc5BPq/jmGMkOcBHz
         U6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752272441; x=1752877241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vOhnnbR9J+UeKp0wLMqRexLagkueLaWGi8qXJivDnk=;
        b=SCVBi1r8ZwUFQPWl7CsnaT/DmaxdOuthLPDQYchlRxsXOgT2d4RLEpBmHJjJzEWreX
         4ZEHeRw441z+4YM9wBx9fnLlTX4WG9Wlo22CaMkCEbpN97kESzSwPtvv15p8shJs36a0
         rw6jmRrTeJ/3losuLJGU1YzgpeVcMJzr2TY3lIGkED/Qwe0eKa6PJgaSNGHhtG32kIr+
         evD7GjX5yiQRFTH9HYIBhgOXoKp2yNdfORfAz8o8AznoRMaslcvXMEGpC6atLZV1CqoD
         wDCly1i6FG52FK/d0jssoedxzoaFXm8MczcGWb2zYjbIsQuVMZ5ooSzkGMaIHOt6s4nU
         u54Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv6yGpzcyzUluY20MSY23UYCcW8/3HNYQyVuQNXdJo17emBEzUAKhfbC7uod0z8VKP7QOM9o7l/+XROsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx296oqNJBfvWzil5PMPYTZh1HCSj3JgoXnwAQm6/eWB4WsNbe4
	pSk5WfW9/a3hh1DyibpuBg5R3q8r26CWTUnt2DdGh9rr0yDholVqibLjCholhQ==
X-Gm-Gg: ASbGncvTnuNrY5mgdQDOL6VmSUnwZ/pOUByjQSf5rvDIPxzAyhjujO/za3V800803qY
	hZ3ebylg4y168MTsTxEv7ZDsnLqrgTFhT6pmkFd1s9r2YuRbZ1wTpu8lkCkJWlFHmOLP/ifQ7nQ
	rK44kYgBxN5uwkstOafVy0cmrzmz/UrsRMn+r95g5uK33iQR8Zpz1QI/ZgLV2GQJ/YiPAV+54wA
	xjBkm+wTQ1eYyZC/tiasqHCVn7xBmC2r2k+0vbpsAMNNePoUpcAc490wYINhtKaVw/WyuOsMPYO
	potlbQz0oVRiL9nJ5h/o2UR2kijvpoLM3vlyhwceNtPr2bR0LKN1EbE5l4DsH67mwgY1z0maIni
	nP7UGmjWl6QGGB5z9NOvtB2nVovK9LjBEfcDJLhC39R1gC8E27znMBaZoQsfY7MCqMUqUSRYAEF
	nwgDyGO36+v5S+
X-Google-Smtp-Source: AGHT+IFKPjlrop+IZ4SrTsQaKDX07IHpyQF42ho2R9MpaiqThje25pErI7PSeQMuy4t7L5fD0dDDxQ==
X-Received: by 2002:a05:6214:2465:b0:700:c7e4:cac6 with SMTP id 6a1803df08f44-704a353e245mr93723536d6.8.1752272440479;
        Fri, 11 Jul 2025 15:20:40 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497db4acbsm24056666d6.109.2025.07.11.15.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:20:39 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 92472F40067;
	Fri, 11 Jul 2025 18:20:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 11 Jul 2025 18:20:39 -0400
X-ME-Sender: <xms:N45xaEYBON8zcoCWA7oBVCX4vNeXZb9dFoSwZ09POIunoJDWSmyP3w>
    <xme:N45xaMUsEtDGooGHHtHOtite115jPkLwJhyz_OCIfCTDNl83ntOJQCYI4c-_qQs6t
    6BK6WASx5om16ivKA>
X-ME-Received: <xmr:N45xaKkre3zUBR-BsUA0kUSgSjbcDKLmLqIrpc_NPro6ZXiUW12zwABsMXJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghrii
    esihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdr
    tghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    thhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsohhquhhnsehfihig
    mhgvrdhnrghmvg
X-ME-Proxy: <xmx:N45xaHD7tZ8KlEU11Fb6RVysRw1nPxwGC5Tn0V_-JVNTeU7kV06fLQ>
    <xmx:N45xaJisWky3QcsHIALo1IPXjGq_EPaxnCC8Pd52ZR_CupYbMTLhdw>
    <xmx:N45xaExdj2gANh54Ru-MzAP1ftK6TJ60MK86oDrL9FPt7KFwgkd2TQ>
    <xmx:N45xaK3hoG8Ih6VoC81nRuMEi-3IUHBS68PGnUKeMiSiE7qRzCSj2Q>
    <xmx:N45xaJ9Z26pivY8Ssam4APWbX7xGLAHRVP0G7umKfq8JT2i5nn3ikO8->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 18:20:39 -0400 (EDT)
Date: Fri, 11 Jul 2025 15:20:38 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH] locking/mutex: Add debug code to help catching violation
 of mutex lifetime rule
Message-ID: <aHGONjuRiA3KfH1q@tardis-2.local>
References: <20250709193910.151497-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709193910.151497-1-longman@redhat.com>

On Wed, Jul 09, 2025 at 03:39:10PM -0400, Waiman Long wrote:
> Callers of mutex_lock/unlock() must ensure the validity of the memory
> objects holding mutexes until after the return of all outstanding
> and upcoming mutex_unlock() calls. Add a cond_resched() call in
> __mutex_unlock_slowpath() to help KASAN catch a violation of this
> rule. This will enforce a context switch if another runnable task is
> present and the CPU is not in an atomic context.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Meta question: are we able to construct a case that shows this can help
detect the issue?

Regards,
Boqun

> ---
>  kernel/locking/mutex.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index a39ecccbd106..dd107fb9dad7 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -931,6 +931,17 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  		}
>  	}
>  
> +#if defined(CONFIG_KASAN) && defined(CONFIG_DEBUG_MUTEXES)
> +	/*
> +	 * Mutex users must ensure that the memory object holding the mutex
> +	 * remains valid until after the return of all the outstanding and
> +	 * upcoming mutex_unlock() calls. Enforce a context switch here if
> +	 * another runnable task is present and this CPU is not in an atomic
> +	 * context to increase the chance that KASAN can catch a violation of
> +	 * this rule.
> +	 */
> +	cond_resched();
> +#endif
>  	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  	debug_mutex_unlock(lock);
>  	if (!list_empty(&lock->wait_list)) {
> -- 
> 2.50.0
> 

