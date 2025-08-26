Return-Path: <linux-kernel+bounces-786832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862AFB36C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506142A60E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9533439F;
	Tue, 26 Aug 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WO1bToP9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDB34DCED
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219260; cv=none; b=QHZGae4dysL/eKKCgSUtcf1s8zhhQbFAd/O/0bzcHwYKdFxuyeeqj/rEaHWEewCUyv1wG3hEVKArbyblIbFHT/UGl4kWPCP0OaxcnPsWdL8/U4kW7X0zYZHP5UbtecMcWcaw5PK1H7Hwso5jOca3PVnTiC0ISac+e16ijMQ/X94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219260; c=relaxed/simple;
	bh=UV6QsGJaNRCIjLl6uGJScd++GUZtMzgSHcsM6bVx3c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrcT1z70jTDScypIMij1qOyp/yyArUR444Xg1/FPy9s9dv+qhD7SMxUnrRSLqy9v6UeYsKGsoOUrwqGAEOnIegHg51IrpULV/PtGpSI8FjaY3uEVSE1oKu+3KybX1BglSnsxsKgVlhZBeykRzlYPZ1Z/4dHN1NVaP511T6Ch0D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WO1bToP9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756219258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ihfy3FuhJ2wqfa7u6CNmaEum1YBa2rsl3CeJYStFWI=;
	b=WO1bToP91ispJ69P0K21+rAnZVGMY77+QthH1BIJJgmqAwoOvMY4uB/w8v12ILKfUJBHMZ
	imn1dIOikiNTrqCRxv4OIlTiWgk06bY9LbJ5sYS9qmHGivHesvZfg4voR0yWrmn9owDQjD
	eUimPDVl9wfco+hxlqBI9fOiP/yCVXM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-K_yzqW-xPLSvG_W_N4MUNw-1; Tue, 26 Aug 2025 10:40:56 -0400
X-MC-Unique: K_yzqW-xPLSvG_W_N4MUNw-1
X-Mimecast-MFC-AGG-ID: K_yzqW-xPLSvG_W_N4MUNw_1756219255
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b51411839so28185185e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756219255; x=1756824055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ihfy3FuhJ2wqfa7u6CNmaEum1YBa2rsl3CeJYStFWI=;
        b=eBtXUBL/T12ClRiN5gQ9HBbWd8nYFVU5/g4d/rJuxb6EQ1XMvgq0XSracBEI4p+3EI
         fjhjffTP1lt1cElluNVAUAabLELRjvAKET2m3jhGqHxUzSXGOQcwlwzowYDNs9prG3eK
         YyV+0VqibFfABmmqKXQhPrfB01ocCkN7+LBQKPE14h04dEdwWYwNiNBEutJ783UlNH6g
         mDLKLT+KfzFppwWxqxpvW7epAlfzBNVdOVkMNeNJ9xD4/OXZ4i7Eihzsm44thSebvy/t
         vcqY/76YWTQ87X4PGmhyHXDVkB2CyYJMGdWbQIB3aQDUJnKp2vwxZjttudnqyPuhJXz6
         HvMg==
X-Forwarded-Encrypted: i=1; AJvYcCUdHCVMwwjOwO3E8p2szpKYvgWtfpe5Wfv7Gh4Ecpo05vUzKa7jEc5ReY/lQ10O1vG2HxafdXzEeSkuQZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+Mb1upg4cyeA0dXhSGSgReVyUang6YPXGxZgM5jyDfqaCZQo
	uYZGZTG7jSdsjHGs0ixUYGn84dc+AoYFNGbma3gLqQGnD82NcH8XrBKu9YMhdzTEIn7OahwjEaN
	yKMmmJjFO5I22cJFkOjYO9TziTgSpA98Nm+vGf+S/D7T2lHQsqjHG7qS1sJEmZdjfXw==
X-Gm-Gg: ASbGncsCBuGo5SNsfLTOfCipohOBhuROTfvj1IMqzKNxDCmOzJGVVSApl41E91UpnRn
	HhAn9MBrbQAhsdsy2J4zFpkZUGLz8BrHKArOIMLuuccOJ05XNTHzWqJ1CJSa+k9j58srHvTrjQi
	WekmFGZZ5x+5VPeTy3IANO09ndoh3wYR0LDhjttqrV5T1czBQ1M+2sdIL4BYc7OZfEKcZurfsxv
	eKHcmxsnkSQwxVabnTo0O9Csfhgh1CW6isZRUU76sTxld14k/MQnzgrQWmPVaju4sxS6rQHJmVN
	mvfxSoQQznI/QDDoVFt1Kl6mDf1lzLw=
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr149244005e9.18.1756219254594;
        Tue, 26 Aug 2025 07:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQn6JvvJeT7MlM5vxv7NDmMYfGEo1DRscOYnhsp0L3inuZrfVRfxK+fMUnsbs9Tx6WF6MBXA==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr149243805e9.18.1756219254143;
        Tue, 26 Aug 2025 07:40:54 -0700 (PDT)
Received: from redhat.com ([185.137.39.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5df6b356sm112346715e9.0.2025.08.26.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:40:53 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:40:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] vhost_task: KVM: Don't wake KVM x86's recovery
 thread if vhost task was killed
Message-ID: <20250826103625-mutt-send-email-mst@kernel.org>
References: <20250826004012.3835150-1-seanjc@google.com>
 <20250826004012.3835150-2-seanjc@google.com>
 <20250826034937-mutt-send-email-mst@kernel.org>
 <aK2-tQLL-WN7Mqpb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK2-tQLL-WN7Mqpb@google.com>

On Tue, Aug 26, 2025 at 07:03:33AM -0700, Sean Christopherson wrote:
> On Tue, Aug 26, 2025, Michael S. Tsirkin wrote:
> > On Mon, Aug 25, 2025 at 05:40:09PM -0700, Sean Christopherson wrote:
> > > Provide an API in vhost task instead of forcing KVM to solve the problem,
> > > as KVM would literally just add an equivalent to VHOST_TASK_FLAGS_KILLED,
> > > along with a new lock to protect said flag.  In general, forcing simple
> > > usage of vhost task to care about signals _and_ take non-trivial action to
> > > do the right thing isn't developer friendly, and is likely to lead to
> > > similar bugs in the future.
> > > 
> > > Debugged-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Link: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com
> > > Link: https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com
> > > Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Fixes: d96c77bd4eeb ("KVM: x86: switch hugepage recovery thread to vhost_task")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > OK but I dislike the API.
> 
> FWIW, I don't love it either.
> 
> > Default APIs should be safe. So vhost_task_wake_safe should be
> > vhost_task_wake
> > 
> > This also reduces the changes to kvm.
> > 
> > 
> > It does not look like we need the "unsafe" variant, so pls drop it.
> 
> vhost_vq_work_queue() calls
> 
>   vhost_worker_queue()
>   |
>   -> worker->ops->wakeup(worker)
>      |
>      -> vhost_task_wakeup()
>         |
>         -> vhost_task_wake()
> 
> while holding RCU and so can't sleep.
> 
> 	rcu_read_lock();
> 	worker = rcu_dereference(vq->worker);
> 	if (worker) {
> 		queued = true;
> 		vhost_worker_queue(worker, work);
> 	}
> 	rcu_read_unlock();
> 
> And the call from __vhost_worker_flush() is done while holding a vhost_worker.mutex.
> That's probably ok?  But there are many paths that lead to __vhost_worker_flush(),
> which makes it difficult to audit all flows.  So even if there is an easy change
> for the RCU conflict, I wouldn't be comfortable adding a mutex_lock() to so many
> flows in a patch that needs to go to stable@.
> 
> > If we do need it, it should be called __vhost_task_wake.
> 
> I initially had that, but didn't like that vhost_task_wake() wouldn't call
> __vhost_task_wake(), i.e. wouldn't follow the semi-standard pattern of the
> no-underscores function being a wrapper for the double-underscores function.

Eh. that's not really a standard. the standard is that __ is an unsafe
variant.

> I'm definitely not opposed to that though (or any other naming options).  Sans
> comments, this was my other idea for names:
> 
> 
> static void ____vhost_task_wake(struct vhost_task *vtsk)

That's way too many __. Just vhost_task_wake_up_process will do.

> {
> 	wake_up_process(vtsk->task);
> }



Pls add docs explaining the usage of __vhost_task_wake
and vhost_task_wake respectively.

> void __vhost_task_wake(struct vhost_task *vtsk)
> {
> 	WARN_ON_ONCE(!vtsk->handle_sigkill);
> 
> 	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)))
> 		return;

Add comments here please explaining why we warn.

> 	____vhost_task_wake(vtsk);
> }
> EXPORT_SYMBOL_GPL(__vhost_task_wake);



> void vhost_task_wake(struct vhost_task *vtsk)


> {
> 	guard(mutex)(&vtsk->exit_mutex);
> 
> 	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)))

Add comments here please explaining why we warn.

> 		return;
> 
> 	if (test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags))
> 		return;
> 
> 	____vhost_task_wake(vtsk);
> }
> EXPORT_SYMBOL_GPL(vhost_task_wake);


