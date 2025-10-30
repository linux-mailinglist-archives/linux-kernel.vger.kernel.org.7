Return-Path: <linux-kernel+bounces-879188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E689C227E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F703AC34A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E92EC09F;
	Thu, 30 Oct 2025 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YW+HpKG9"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2897271467
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861768; cv=none; b=jeq2/CMthbT5CacmA6Z8YmsQVjKVZwcuDIwiGIBBhshcBF/ukEzaBnaNUxzyi77BoAMcgbnpU8b7tynioYurh3T9BJY8EmYK3RTSaXNV8SJR0xILvurf78AN1Hg/EPYrRla11K/Z0XKa9uammp8tEhHdvpYk2/ACgSB/eQ3Ot3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861768; c=relaxed/simple;
	bh=UvRyiZNqMNUKokDlWDsbCD3weBxD2oq5vMb44qnepsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIPqc2QzDuxJ1ZH6zsB8Q3HjM8foCKpk+nNAkP3IyLOWWzogyZ60SHMcn/0XcGi0por0s+QZuxBeqd39b/xq404hpQyNVUUtjnP3BBCoDVJ2JA9bHGqIIew68XCbwZwtOBteYEQ/uCc0cA93OZYEWiVTCUKp7mxH7OZv9bBiFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YW+HpKG9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2698384978dso12830355ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761861766; x=1762466566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e5LA5B446ZeXEQHrU7Ra5D5BiNT5+4vY/ARHOc1M/cs=;
        b=YW+HpKG9ayD6GegW6NezJzkN0SqzwrSxdvOG4apPJFCam0i29cg6u7OEmBHmVMSo2m
         cw5WLbdYG5mbAfwc0d1f5Xy1bwdOlzt4WlWBwP4ITVf8/Ak3y4z9Rraa7vRLhoKSZALd
         0A/nlP1HKNhGW1hdFfr+fXnFb52FUNUNOkEZAi8tMw7ALeCyP5+adoXlVQxLKpFGNpv7
         WBTmq36FHtV9zCeSArzoi+0SqPZflrlyiE20uaF/RMRjoUoHHIBOQAx3M26Ulg+ku69m
         5Zg7PBRph9+HTG/HiDyAYoI2IExdn2859P4c+ueP9MnWc1OmXg109rVGCee5U321jzDd
         tCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861766; x=1762466566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5LA5B446ZeXEQHrU7Ra5D5BiNT5+4vY/ARHOc1M/cs=;
        b=kFG2i+GIiU7DAiQmpwO+oBLQrArE/7GGzyT9F0BRafGQYPRT6l6qIaNAhjmmTjRagk
         3NzqVCy1Jywa9Eqfnx1rRZ6W4VvaQgYGMmtb6ixz0tQKdmQckPgmaAl7GmSkJ55FYsti
         TnBbyDGhX7QUpBlrC4uMbBelqbFf3LZgNS+Keb63Wr2JIFAusNMOIS2X7HjUo04USZPb
         IzxgvJFmmKDapkECuarSweHet8NmOlQwv9b4BWsME1SeT75x5WZk+2KqvSQhaXRPN2AP
         FmvnPOLrb+ILx7ehE9A7hSdQ+Eq0/Nnl641p661KVSkrYTGjkkvpftQcolmOsamfPpc1
         9l2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJkmGbCYcPFgJH9jl+X0ua/umn/KTJqYN1NnU96Y1yn8gg7koqo51ifGU0DYriUaMRKwDTgUKMnZZsxc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPUkvaAmj2umKxf9mLx6OdMk35nRJIl+V4lTiyLmE6bkE2p24
	kJxSjzrATR0HfIIKXohRcFoetiRTnx/edsXsu1+17whHXQvs7gaTQ7QidJQDL4vat7w=
X-Gm-Gg: ASbGncvcczNUDwmnbjK6tFlze0RtgB6GiRl/9u3Ntr12+s5wxoyytWoEUEeGQQIOrMz
	Dcy9ZPSZQJu/ozkko+lwu2jilObIKRGBQenXK4VjOY785LmCeqGNrcsNvTsuUqNQcr8InOpt/Gj
	jSvO/FjPKXnZJiDnqTXvy64KCPWuSPkU4LaUQRl0qG5lcT5N6byju55M+EPDr849Ke6t/G2/kPw
	Yy5HofZd5sbvnZGm1AXAaPeA7+HDe0YTQ5Z60oto4vktEiTgItJHZ2XHI5dcWGBDA4hxxtVUlg5
	MeAutVYplAem1ElaTNThvkmEKHOdziemy40ZhgqhAxT6jW0vaSVEs/6M7Ln8izF7hJg2rFBlt64
	DWxSuRVUw9uD0LrjwgQ4Qeiq2TqSrgGBqk5zllLaDehRQQTOO9DrTFVgK0Kb07azHXhoNIxkbik
	OnSld8jK7CI7nYtE8cFjMCX47k9eIUfVtuE0Jq413dWj8gs7lOyEc=
X-Google-Smtp-Source: AGHT+IEUK4VY3vlv2EG4ggLi7rfSvrtgNznZMJVA1McqV5dhVhLohhKpNsIroL+zzWYFGo32TwDWLg==
X-Received: by 2002:a17:903:2312:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-2951a420e44mr15402805ad.6.1761861765826;
        Thu, 30 Oct 2025 15:02:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2951ab8c1dfsm6755835ad.75.2025.10.30.15.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:02:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vEajC-00000004HIE-0S7o;
	Fri, 31 Oct 2025 09:02:42 +1100
Date: Fri, 31 Oct 2025 09:02:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: Geoff Back <geoff@demonlair.co.uk>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <aQPggv2LK4kkXj3L@dread.disaster.area>
References: <20251029071537.1127397-1-hch@lst.de>
 <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <5ac7fb86-07a2-4fc6-959e-524ff54afebf@demonlair.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ac7fb86-07a2-4fc6-959e-524ff54afebf@demonlair.co.uk>

On Thu, Oct 30, 2025 at 12:00:26PM +0000, Geoff Back wrote:
> On 30/10/2025 11:20, Dave Chinner wrote:
> > On Wed, Oct 29, 2025 at 08:15:01AM +0100, Christoph Hellwig wrote:
> >> Hi all,
> >>
> >> we've had a long standing issue that direct I/O to and from devices that
> >> require stable writes can corrupt data because the user memory can be
> >> modified while in flight.  This series tries to address this by falling
> >> back to uncached buffered I/O.  Given that this requires an extra copy it
> >> is usually going to be a slow down, especially for very high bandwith
> >> use cases, so I'm not exactly happy about.
> > How many applications actually have this problem? I've not heard of
> > anyone encoutnering such RAID corruption problems on production
> > XFS filesystems -ever-, so it cannot be a common thing.
> >
> > So, what applications are actually tripping over this, and why can't
> > these rare instances be fixed instead of penalising the vast
> > majority of users who -don't have a problem to begin with-?
> I don't claim to have deep knowledge of what's going on here, but if I
> understand correctly the problem occurs only if the process submitting
> the direct I/O is breaking the semantic "contract" by modifying the page
> after submitting the I/O but before it completes.  Since the page
> referenced by the I/O is supposed to be immutable until the I/O
> completes, what about marking the page read only at time of submission
> and restoring the original page permissions after the I/O completes? 
> Then if the process writes to the page (triggering a fault) make a copy
> of the page that can be mapped back as writeable for the process - i.e.
> normal copy-on-write behaviour

There's nothing new in this world - this is pretty much how the IO
paths in Irix worked back in the mid 1990s. The transparent
zero-copy buffered read and zero-copy network send paths that this
enabled was one of the reasons why Irix was always at the top of the
IO performance charts, even though the CPUs were underpowered
compared to the competition...

> - and write a once-per-process dmesg
> warning that the process broke the direct I/O "contract". 

Yes, there was occasionally an application that tried to re-use
buffers before the kernel was finished with them and triggered the
COW path.  However, these were easily identified and generally fixed
pretty quickly by the application vendors because performance was
the very reason they were deploying IO intensive applications on
SGI/Irix platforms in the first place....

> And maybe tag
> the process with a flag that forces all future "direct I/O" requests
> made by that process to be automatically made buffered?
>
> That way, processes that behave correctly still get direct I/O, and
> those that do break the rules get degraded to buffered I/O.

Why? The cost of the COW for the user page is the same as copying
the data in the first place. However, if COW faults are rare, then
allowing DIO to continue will result in better performance overall.

The other side of this is that falling back to buffered IO for AIO
is an -awful thing to do-. You no longer get AIO behaviour - reads
will block on IO, and writes will block on reads and other writes...

> Unfortunately I don't know enough to know what the performance impact of
> changing the page permissions for every direct I/O would be.

On high performance storage, it will almost certainly be less of an
impact than forcing all IO to be bounce buffered through the page
cache.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

