Return-Path: <linux-kernel+bounces-728518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F85B0295C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 06:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F261C276F8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 04:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE81EFF8D;
	Sat, 12 Jul 2025 04:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wrc+g1LP"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7013AA53
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752294058; cv=none; b=WQxGEfthkSwVCh8VQ/VqxypY3USRRZDR3ZOLqZwN/4ihfutaiJVvrwvTkJP8Y8/zbqHhRTzZPvWNHkuBFcahpwOG968Gcsi/N0POjHKtZRMDopHTPjXn8B6Hm+xSS/j+aK5WlMNIw3DNJYxfGknmZ/dNvmdiqWbd28q+jCyDYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752294058; c=relaxed/simple;
	bh=orzODwnyMNWicgG1Odnk2vva2UgZus8iMgrmc+UgAMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRxKpYy4JfSRIK599u58cdOjrW6v5vJRZI/NRGeP/nl5+98LsC1kGk+j412PIRAOeQkKTsHK8Y8mi9A2Wg5EhCcz7xBiHKqM9IgjK3x197alzt6zUnZI2gD9Pbtk0oAvIaBOTlbKSCtA0HCma8dwLttJ3kHf08fcn/fYu78/l+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wrc+g1LP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58e0b26c4so42112301cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 21:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752294056; x=1752898856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3JFnN6HCpmRGnd2JHlzm7Prke+vht9Sbq9L+iVUMkg=;
        b=Wrc+g1LPlJSKyvMeKalLQNtGNViR5/tNB7ESSAVFkvi0QjCTJiYmp3PJk4lHFXvjkR
         iHATtC/sM2RU6jHci0p9pDgALcD2SPgpABl4simaPFNEd2EAm3zAWeyrlWWt0625OrOK
         6Iaq+v3cf8AWrrw6Rk9kRY14tiY731e6L7lqw2FgOMTbaLcRCqNm3aRZoVNKXIYpVXnj
         BBstgH7HjBEfdAAol7T6qhuL7WgSrudlwraUn7qRFllOJqd9/g9eQEOQXoWv7Zglr1ID
         pYqKiRXp8/Vt6ehfRjSuIV8jF1+EfbyQBoCiJG0b2rRIy2M3aj804c9xRiVdc2WuHiKu
         8C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752294056; x=1752898856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3JFnN6HCpmRGnd2JHlzm7Prke+vht9Sbq9L+iVUMkg=;
        b=uAy6iM7OzTa3B7tq5ilqaHjknOUPERTHL7XEI4yUDxemiFnO/U1pSG3tHOvPXgqzOR
         dfgXfWLTxW8V2s1zG3VUBwOCYtNQMgrOvnvc/ln0x++JL3onDhCxwylpyP5MDo4jpA/b
         L6dgughrQz4AbWxsLT9Ow/9UCmRm+3ZWFmBeX2E86slapO0Kl3kXZOn+hcdScuZRX5gJ
         f0+QbStrHUOUbLHm4UJa3/G5rQlLXNLADiZOGjZXcahrka7iwgIZRRH88jsPoUh4zi9J
         9CnzfuA4gXen08pFv0omPLol+sn+ZNZb/aqVOpZP2r5uZrlAfZOaXgKSdwNU20T31+0U
         BTKw==
X-Forwarded-Encrypted: i=1; AJvYcCVj+oyyTVFOXPfamrOFK9/DP/HSbrQi9OMtJmKEbvRdtDXOVFW02e8JpChoGSJvOAbk50KW5xnJ/Z2NOCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQieQGrLnhXEvFySK4W7a6jkS4cXFsHn+YYrskGRKvM+PUdbHh
	WtPMrGA6O0M9isOE+/wlozimAXK8XYgVrxGrsBWV5/QIywDiDXDn1mzl
X-Gm-Gg: ASbGncuHJ+Di7OOklbLjkNv3Q2MH4+czIeXtHwAKS0ZoECcXoQNqR4fa1E8OYiQmB8e
	pa9xVpSEQGzq56hSnONuuDitKXbvMLCJ/UHzA7xtulhcqYqMaUkkf1v6rGQOoW+PUNbHhCQfVxP
	NP3eWiou5ONZMPIamwpovbPZrSXG92uz1o/ddQo6TOC6duoaw2FEYgpHzIswF3fLvWxvF5whRyE
	QfKCfNdnaoYqHnsPHN6J1SivpBU7ZNHfK/OLr8dPh/IE3GDMzrSuFfS85MoIEu2O/73HWl8BHWH
	hPYQfHvFmHZAttgE5QXSr2NRyzlxuvryi5J4a/5iZB0ctXF9h9mUBirnk2dTapDzR42xe4CxglU
	OzPTl/KQiooWh7PXmmcbbuSU9mEV2oTxW256XbkYMyAwndHH2+1OkZWBNu4hVR36vhq9SqhHfuK
	noOAbzycaWe6IDkQsd3a9cSyQ=
X-Google-Smtp-Source: AGHT+IEVjV9q+BrTCTtEEXRS0w2MRS8mG4i+fbTbDeYclkKOIY7gU5T2dmUbUsPvgwhkMmRq/cempQ==
X-Received: by 2002:ac8:588f:0:b0:4a7:ff6d:e957 with SMTP id d75a77b69052e-4a9fb9a0e6amr90157071cf.46.1752294055526;
        Fri, 11 Jul 2025 21:20:55 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edefb923sm27736551cf.75.2025.07.11.21.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 21:20:55 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id A358EF40066;
	Sat, 12 Jul 2025 00:20:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 12 Jul 2025 00:20:54 -0400
X-ME-Sender: <xms:puJxaCzRLvDlNFEtWbbOiLod_GcyMHHHDoBh1vvLdE_T_61MfXdl9A>
    <xme:puJxaLNV-eP-cND1sdjxEIZGW2ycYqwciO_jsSB-rY3hgjjw9SpF8CLQfgn4eNRqM
    jhmWIpFI5tEYE3xsQ>
X-ME-Received: <xmr:puJxaP9sFcQbSQvGEOh8oG-vLYAmToQToVnbLsUBakY26qm06VwkvOC0wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeghedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehllhhonhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhrvhgrlhgush
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsohhquhhnsehfihigmhgv
    rdhnrghmvg
X-ME-Proxy: <xmx:puJxaA4RX4LAAGGNs7ICSfkUmth32Mh94p3omdrnZhb720_zhy6BzA>
    <xmx:puJxaN7UbKl-lwZCrKn3urh-9llmmFTvJQz3QJt61p7czyjN7Mphew>
    <xmx:puJxaBpnAS4pN8INP5_buf5QkcSRtN_mPjAaYeGiWpnVLkAKNj8uXA>
    <xmx:puJxaGMi5qOGxk8OQNtiApd_Ib5KVCERy4BsfZx9_sm7NLf2zr76lg>
    <xmx:puJxaB1rQ6DCt0ufJjS_KXXGGkcbyNd2LO-XiM6n-986kBPsygALk8Uk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Jul 2025 00:20:54 -0400 (EDT)
Date: Fri, 11 Jul 2025 21:20:52 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] locking/mutex: Add debug code to help catching violation
 of mutex lifetime rule
Message-ID: <aHHipJuS1yyhhkbT@tardis-2.local>
References: <20250709193910.151497-1-longman@redhat.com>
 <aHGONjuRiA3KfH1q@tardis-2.local>
 <CAHk-=wj4gifTA94-11JXKj5Q5TSieu2LXgOauNDC9gbOQRcZeg@mail.gmail.com>
 <aHGeF7ko_4uXHUgl@tardis-2.local>
 <e88452ed-411b-419e-a41d-0ff98d54a59b@redhat.com>
 <00fdac3e-092d-46f0-bbe7-6067c0f22eeb@redhat.com>
 <aHHHZJ5sKGscTCqo@tardis.local>
 <cad83f32-d1ed-4885-8ed1-c65e5683237e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cad83f32-d1ed-4885-8ed1-c65e5683237e@redhat.com>

On Fri, Jul 11, 2025 at 11:16:43PM -0400, Waiman Long wrote:
> > > > > I think this may also give us a good chance of finding more bugs, one of
> > > > > the reasons is that raw_spin_unlock_irqrestore_wake() has a
> > > > > preempt_enable() at last, which may trigger a context switch.
> > > > > 
> > > > > Regards,
> > > > > Boqun
> > > > I think this is a good idea. We should extend that to add the check in
> > > > rwsem as well. Will a post a patch to do that.
> > > Digging into it some more, I think adding kasan_check_byte() may not be
> > > necessary. If KASAN is enabled, it will instrument the locking code
> > > including __mutex_unlock_slowpath(). I checked the generated assembly code,
> > > it has 2 __kasan_check_read() and 4 __kasan_check_write() calls. Adding an
> > The point is we want to check the memory at the end of
> > __mutex_unlock_slowpath(), so it's an extra checking.
> 
> It is likely that the instrumented kasan_check* calls can be invoked near
> the beginning when the lock is first accessed, as I don't see any
> kasan_check*() around the inlined raw_spin_unlock_irqrestore_wake() call.
> 

One thing to notice is that __kasan_check_{read,write}() are the
instrument of atomic operations (because compiler cannot genenarte the
instrument for asm), try_cmpxchg() would instrument two
kasan_check_write()s and atomic_long_read() would instrument one
kasan_check_read(), and we have 2 try_cmpxchg() and 2 atomic_long_read()
in __mutex_unlock_slowpath(), that's why you saw 4 kasan_check_write()
and 2 kasan_check_read().

Compiler intrumentation is using function like:

	__asan_report_store8_noabort()
	__asan_report_load8_noabort()

And I checked the asmebly code of __mutex_unlock_slowpath(), and it
turns out it does instrument the memory operations on stack:

    3b1c: 94000000      bl      0x3b1c <__mutex_unlock_slowpath+0x188>
                0000000000003b1c:  R_AARCH64_CALL26     wake_up_q
    3b20: 52800028      mov     w8, #0x1                // =1
    3b24: f9000be8      str     x8, [sp, #0x10]
    3b28: 38776b08      ldrb    w8, [x24, x23]
    3b2c: 34000068      cbz     w8, 0x3b38 <__mutex_unlock_slowpath+0x1a4>
    3b30: aa1303e0      mov     x0, x19
    3b34: 94000000      bl      0x3b34 <__mutex_unlock_slowpath+0x1a0>
                0000000000003b34:  R_AARCH64_CALL26     __asan_report_store8_noabort
    3b38: f9000ff4      str     x20, [sp, #0x18]

    	^ this is the "head->lastp = &head->first;" in wake_q_init()
	and x19 is sp + 0x18, if you believe me ;-)

> So if we want a check at the end, we may have to manually add one.

But yes, we want to add a conceptually check at the very end, as if "the
mutex must be valid in the whole mutex_unlock() function"

> 
> > 
> > Also since kasan will instrument all memory accesses, what you saw may
> > not be the instrument on "lock" but something else, for example,
> > wake_q_init() in raw_spin_unlock_irqrestore_wake().
> 
> The wake_q memory is from stack which I don't believe the compiler will
> generate kasan_check for that. I also don't see any kasan_check*() call when
> the wake_q is being manipulated.
> 

See above.

> > Actually, I have 3 extension to the idea:
> > 
> > First it occurs to me that we could just put the kasan_check_byte() at
> > the outermost thing, for example, mutex_unlock().
> > 
> > Second I wonder whether kasan has a way to tag a pointer parameter of a
> > function, for example for mutex_unlock():
> > 
> > 	void mutex_unlock(struct mutex * __ref lock)
> > 	{
> > 		...
> > 	}
> > 
> > a kasan_check_byte(lock) will auto generate whenever the function
> > returns.
> > 

I'm more curious whether kasan can support this.

> > I actually tried to use __cleanup to implement __ref, like
> > 
> > 	#define __ref __cleanup(kasan_check_byte)
> > 
> > but seems the "cleanup" attritube doesn't work on function parameters ;(
> > 
> > Third, I went to implement a always_alive():
> > 
> > 	#define always_alive(ptr)                                                              \
> > 	       typeof(ptr) __UNIQUE_ID(always_alive_guard) __cleanup(kasan_check_byte) = ptr;
> > 
> > and you can use in mutex_unlock():
> > 
> > 	void mutex_unlock(struct mutex *lock)
> > 	{
> > 		always_alive(lock);
> > 		...
> > 	}
> > 
> > This also guarantee we emit a kasan_check_byte() at the very end.
> 
> Adding a kasan_check_byte() test at the end of unlock is a locking specific
> problem that we don't have that many instances where a check is needed. So
> it may not be worth the effort to devise a special mechanism just for that.
> Adding a simple macro to abstract it may be enough. Anyway, it is your call.
> 

Well, we do have a lot of cases where a foo() takes a "struct bar *" and
the expectation is the pointer is always valid in foo(), so maybe there
are other usages.

But sure, we can start using always_alive() in lock primitives only at
first.

Regards,
Boqun

> Cheers,
> Longman
> 

