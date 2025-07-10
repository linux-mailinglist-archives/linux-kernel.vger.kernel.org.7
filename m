Return-Path: <linux-kernel+bounces-726304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410FB00B68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F73ABB3C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA552FCFE7;
	Thu, 10 Jul 2025 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F76c913B"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BD2FCFDF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172159; cv=none; b=EcSuNda8DwnT7iAevzIyt9l1rKWwVe1Vuww5q3WM9q//KrXtkJCwhtMRDcPrSG+DiQIpvpuLXTVfGdqWeEfLqdnH6fPh6/NDevI/eFEQBOrfWxHLHijTxlC+kUXBW+g5X9zfAs1nV4oq5JYWAaGP2srEQ1o4aYqJingMFm2ZGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172159; c=relaxed/simple;
	bh=QFBFOa7Bvf2lxinTnhcyOm5vBfrQlJJ3UPMqwnseeII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjHTNPXZcLKfky1nfc4871A8bsKgj0RvH7UaYyIbR1F3RnX86GvqoeRR2pI14Q2H8zStd7Ro1ywYO0QDK7BgRDlnA9Os1OIrIghr3sGkLfv+bythuaL48cw32wSAOUZ702j4xrFiCALMA3P/KJNgq/6NN5zw/4363me8sVgqg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F76c913B; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d6ade159so10865095e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752172155; x=1752776955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOQ3iZcksxoMGIp1RUekI004VukWtY+h7237e+uDHIk=;
        b=F76c913B2XY3P5m34AqGxud04QSu7pGAbPhN1HdVYvFhR2lMqQBGwF8kwF9bHR1jtU
         2rrgiuk1RMoRcEZQgYSvsO/l9CTM+/0mWPM9Jb47QcpA9FLJV74lEeE1Q8Gw3AJkB3IM
         QvT3EhJd116YmgPamWQDB4YLl5mmhgW/hDih1QAPj18Yvg2dvoeFOMxatTPT2q8Yj7dw
         lQfWFykluqj72yzSnQILTDvEhHmPWfFoMXx2XfoRtLTX1ZltnTXh473wpzF0nmLxn2WE
         bmGFApE68vcJBNR54QB5jqYxwqjta8PNM0GDP2zxoSoRHG6FwMtzvIepYnZTT3pjJ7WL
         5mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172155; x=1752776955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOQ3iZcksxoMGIp1RUekI004VukWtY+h7237e+uDHIk=;
        b=Oy/kHYHAsInHtrhNFRcD4WenInu/cSa9WTSkgQuuHPiZMTjcRiTwPm/ZyhfVn++qy0
         wQ43pWwBu3R6ziaOF1UahGq2REhs1Da8T3ex4VCNp0yvyb0PvRLYcFZeC8kia4YXudK5
         GXtwbu0D8mgRZWOcLgGzhZ8yFnOYIrKDpiOWyUxPHfpSleZZSqNeVzFSWR9n0h0tC+IS
         D1U4Yhxig1H2bn4bJpSRhhQ8T/n1Nc9gEq0iVHfE6hWoORMPsLbMRHhMwM2BdbolvsQE
         mEjw9Xx2N9Q4UT3p0PgDOPQpDdi8WwLoD+hR3TurLrW6sbqkv1/4wm/t0FyFNK+i0A8G
         ETaA==
X-Forwarded-Encrypted: i=1; AJvYcCUpK06vcr/E06SMOFk8TEgMyn6XL37IG4JDXsS6h5+t/E9vVfA1Xf9qNR/LHykxJQVdNvuMePgjObEOYYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJPUqgsSGFf8UHC/6hjd6/Mm38qanczvuMwSMvyujwoE6ev60
	rk5yJmuhMP0wa0FZrmqe4FsfBkan7cvWV8j3szVOQzMRQWXqYvYIEmkRZtn+2CViHjU=
X-Gm-Gg: ASbGnctL/Sgh8RiKg3i9kVTtQsw2kkaki7Q+rzjI2ZnK6oshtd6CiJsM2kvtIztpNFk
	PbjdGN2xtJIaor5ninDaQsZ/JCtXUC8OLGWUsYoXFJ/XUqcF+D5jz6EBYdvlbHWkHNJHhjGb1EW
	5GD0vDsjWH8LeSLILdPH9iWYPKrB1xJ8PnU+VLlou7afWG/AocMB5HzhgFbYYcMYZpe0vmpmO+Y
	vYTd0hzdIFoeE64b6u4782SnWa3EFtpgIe94l7d4FcN58NHWkwcxRbqpiKtJxd5Y53GePNa45aT
	Vs1QQ/FtufVvXnjO63MFxhaO9+StX/Dw9rz3O7zMTWI/JfjItmjFc5A69jCB3t+deCsFlLUM6HU
	=
X-Google-Smtp-Source: AGHT+IFBVwASeEDn3Ai/7AinKF7ETDqnwkea50Pc1pCJ6LnJutt1DvaJ67bydIUIiphk7uMr4H5ZiQ==
X-Received: by 2002:a05:600c:4689:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-454dd1c85c4mr46230025e9.4.1752172155380;
        Thu, 10 Jul 2025 11:29:15 -0700 (PDT)
Received: from localhost (109-81-26-204.rct.o2.cz. [109.81.26.204])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454d5032e17sm71179105e9.5.2025.07.10.11.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:29:15 -0700 (PDT)
Date: Thu, 10 Jul 2025 20:29:14 +0200
From: Michal Hocko <mhocko@suse.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm: implement "memory.oops_if_bad_pte=1" boot option
Message-ID: <aHAGeikybkJrPp6Y@tiehlicka>
References: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
 <525a4060-2c8b-40c5-b4bd-b9c47de94f0f@lucifer.local>
 <72956765-39e0-445a-b381-6bbc54046544@p183>
 <5242fca8-4a17-4ff8-a624-08778fc64f19@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5242fca8-4a17-4ff8-a624-08778fc64f19@lucifer.local>

On Thu 10-07-25 18:02:07, Lorenzo Stoakes wrote:
> OK I wasn't clear enough I guess - NAK.

Completely Agreed!
Because....

> This is not upstreamable, nor anything like it.
> 
> On Thu, Jul 10, 2025 at 07:57:00PM +0300, Alexey Dobriyan wrote:
> > On Thu, Jul 10, 2025 at 05:16:52PM +0100, Lorenzo Stoakes wrote:
[...]
> > > You seem to be using BUG_ON() to _maybe_ cause a panic, maybe not, but by
> > > doing this you're inferring that there's unrecoverable system instability,
> > > which isf clearly not the case.

.... of exactly this. I believe we have already/finally established that
BUG_ON (not even VM_BUG_ON) is a sensible debugging tool. In this
particular case it is not even clear when the page table got corrupted
and it could have happened loong before we notice that so crash dumping
right away doesn't really guarantee anything.

So if this really helped in some specific situations and there is hope
it might help in the future then I believe
[...]
> > > Overall I suspect there's one single case you're worried about, that really
> > > you want to put a WARN_ON_ONCE() against - then you can panic_on_warn and
> > > get what you want.

is exactly what you should do. But even then dump_stack should be
dropped to not duplicate the information printed etc.

-- 
Michal Hocko
SUSE Labs

