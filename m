Return-Path: <linux-kernel+bounces-747926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA0B13A56
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E46D3ABCC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA58263C8C;
	Mon, 28 Jul 2025 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KeF9C9Go"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3E21CA16
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705049; cv=none; b=b/QIRvQ1UWr0Q/ZjUSpjdb2SFc5W2HXvUOpHWucKT4ZZma05uCtsp7G+TPVIHk8PS1MVyFsaqHxn0YiuZdoq/HV9TZ+fAVJRnz/LiNQaGd2JIJBDNgGOJqzoIrychUICaRopswLpDWvm1rOwMzUajnAYop91JvSz8JjbF2hSQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705049; c=relaxed/simple;
	bh=BnQwapfJoscpLgxcU/NN1z8/XuKaWSyXgU7dtSWS5Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiBlsWCGW+pgKtcVFAZQFTmaLLH2YV61Gy6gl3cQu1zY9ndPsnuVzdCqyKRWFrtYVomJ9OKiUIOsxnN8dEb0Z7FqovRe/wMJ4mMo51EV+7MNEN/QiwZJLmKHOQ1NCIxRytqS9GBfNh5krXmCqQM3J9asS255Niy/vmKMC3FIxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KeF9C9Go; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so9419022a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753705045; x=1754309845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKwFshXl6708YNUqX8UUs/w8wlLbfeDR+Z4nlVVWrlQ=;
        b=KeF9C9GorUcSXFmMb6RopAHdlrns52gHKv0HMNJhnQQ6e2R9/yCO5MswBeAdW8e7C2
         wnZ56rEHLF9zTB97uj6MvJ9q0DrDy8tBUcmgjM+DzV28cbZVwy43awp/X431K6wV361R
         SBbxPCAUEXSXcMZfRl91wzm5ZJavrc7OVviJiOaBYX08drgN/YYMrnr0FlL0i8KkzW/I
         wfLZ0ElwwHht1qebwQHrCZq8yYStjNuf5y9d63ytxZ3gko9JlQR7tZcGX/BNEY1czkol
         sNp5N+2vjAVystTa89InZTa7DS2i+ct70jMGCXGl4CeXkXGRHh0a77x9DwlWqrZDmqq6
         Xicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753705045; x=1754309845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKwFshXl6708YNUqX8UUs/w8wlLbfeDR+Z4nlVVWrlQ=;
        b=ZKVDo7VsUx+xayieyK5950blRMNbYjfE4/LiuNp6faIKSQKH0CHR9qF1+tKV1rFoV0
         i6aWupbDNmvneFVGB2CFb9mB3y1fHbOksA62LiNbT5f3Hu6BfWDW67h+cDlmp4opq7UQ
         HQeGXpcBY9lSrKURmVgIsd2DN20Ial69zLCAjR3l0wOFXLybntcTWR7WnyxgCbMCJ6Go
         eb4H18CUbaUQfCZfSrL0KGH77ckg+QkO8/w9EzWkc++OfdVb0ffSmjTRi+Q7ieKxWj6r
         C/ny86ixTi79v98hckEEoH8lGaGNk15zXxphEvFNLC7cwAziAi9ISp5j/+nLPn+R4InJ
         OWlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLP5D65wl/oEotN8APRsvcomhm5QR/JW+XrM3Q0zP8iuaOeXtke+FVwYKnW4HzUfbQhd4KoY48qQS7dOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPUc1uF7qkrb3ZVswPZNpY9Haelq4YC0lwM5C29H135nEcM/t
	/L825V4mYA4BJeh7cQD/DknMm/P/smVRIJHc0Thic0t6bDtkv11h+nSI2xMJp3MjM9Q=
X-Gm-Gg: ASbGnctjMfr9lcc89wh79LmZz8JL8WJCJPOb6W96sE8uNuuTjf2GGpdFIgtu7Y9OwYR
	XANP+Kn1xhgiRxE9R65TsHod08xAemb0jdpXDOVFFCQXsxwtvzfrszPK42rx3FMIkgMC2DB9/5L
	pwkvEfHBbqa1naqRCr4CLICWduFOs2fkbc2EpATLdWaCVTTNzOD59SHyT/RttoW74I5EvihbTLw
	wiXwFb2inmLneniT5/CINcr3FZ+Wvkdmy3mbWmzNmkntHxmupnfoomJ9a6u3XMZojdBJHOGKzIu
	mRVR+EzN6810eEpf6wnPr/2Vfxioq/S8trnmW332qFdPu/E48eivPJw531pw6rSzvRxZ9mqHHR1
	lLxu8Wg/XfpTjVLrJUY7tjAiDVjrgzAz6/dg=
X-Google-Smtp-Source: AGHT+IEspdWBkQ2+iy97ADb3/zSC34bCTFsjLQt5CCCoZjDD9JKrJbrhr/jWrpDBsGuoj3FtA9QQOA==
X-Received: by 2002:a50:c00e:0:b0:612:e841:5630 with SMTP id 4fb4d7f45d1cf-614d1b47fd6mr10815474a12.6.1753705045248;
        Mon, 28 Jul 2025 05:17:25 -0700 (PDT)
Received: from localhost (109-81-20-172.rct.o2.cz. [109.81.20.172])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61548bca6acsm817008a12.17.2025.07.28.05.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 05:17:24 -0700 (PDT)
Date: Mon, 28 Jul 2025 14:17:24 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
Message-ID: <aIdqVNCY-XMNICng@tiehlicka>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>

On Mon 28-07-25 11:10:44, David Hildenbrand wrote:
> On 28.07.25 11:04, Michal Hocko wrote:
> > On Mon 28-07-25 10:53:08, David Hildenbrand wrote:
[...]
> > > daxctl wants to online memory itself. We want to keep that memory offline
> > > from a kernel perspective and let daxctl handle it in this case.
> > > 
> > > We have that problem in RHEL where we currently require user space to
> > > disable udev rules so daxctl "can win".
> > 
> > ... this is the result. Those shouldn't really race. If udev is suppose
> > to see the device then only in its entirity so regular memory block
> > based onlining rules shouldn't even see that memory. Or am I completely
> > missing the picture?
> 
> We can't break user space, which relies on individual memory blocks.

We do have userspace which onlines specific memory blocks and we cannot
break that. But do we have any userspace that wants to online CXL like
memory (or in general dax like memory) that would need to operate on
those memory blocks with that kind of granularity?

In other words what would break if we didn't expose CXL memory through
memory blocks in sysfs?

> So udev or $whatever will right now see individual memory blocks. We could
> export the group id to user space if that is of any help, but at least for
> daxctl purposes, it will be sufficient to identify "oh, this was added by
> dax/kmem" (which we can obtain from /proc/iomem) and say "okay, I'll let
> user-space deal with it."
> 
> Having the whole thing exposed as a unit is not really solving any problems
> unless I am missing something important.

If we need to handle that thing as whole we should have an interface
that allows for that. Per block breakdown doesn't really help anything.
It just makes the whole problem much more complex.
-- 
Michal Hocko
SUSE Labs

