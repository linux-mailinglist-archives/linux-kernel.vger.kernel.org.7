Return-Path: <linux-kernel+bounces-899133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD86DC56DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEB144E3A87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6A2331A7A;
	Thu, 13 Nov 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tSNZuhly"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECB2331A4A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029939; cv=none; b=TDgYqEcAk1qwMmXkuIQ19SrRx139E6bJvc6ATSkCqpL5aGR0BdDYcqYv/68lzkiyqoWUSk0Lj9ztndOjmPGAgIGXsMd77Ltfuht9N9RbkVRT1J/kZHMQX1a0RJZNRyPIhUtZnrm4XSK0DGDYUcxzdiGmOedMU26lusXgQH9C9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029939; c=relaxed/simple;
	bh=/ez4viGQxwKl6xh/PPq/TWsOWmDT70HNbDNx4QUOYcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQCfcuuLUTrq9O4xmxsMo+PlvO/dHsuupTySPbVEs4cXCYn8tpZ2TAjxk9S9OfpjpzoowTmVWOx6cAS8/v/2GBlOqtICCBaBBQE/36IcZiqtak+2YtE1iGy9XjimSj5Lskry8o1YqEJsbjmwwcuzDL8duAwXuR2+ImUPaLpFEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tSNZuhly; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297e239baecso16354425ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1763029935; x=1763634735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QURbCPhZLgDFuDO50oTy4YxAU/M/cxLF0F1zsVf26eM=;
        b=tSNZuhlyAsQdCBROny1W2LKQ+njhOt2F7hJrDAVykMsiBZA2MsD9NPFanFer8ixnfI
         sdkBrAmS0uqU6umEqeHqPVbTAle0GYtByJLkmItLMttKPO8XRDP73qkQbC6Fk/Juwqd1
         shoafwuSzT7epdC6vUtw6oapaYnkQHyTNmWSRjPCqiEXdnAjgW6Z0qCiCt54EKdDGzRE
         pJp7ktXn2HGrXD+4hBvWl7fl6rjgS8nluU/PbinBDE7EejqbotPO8fLloqqISnl6HC23
         kq69ahcD1dtQNS+fzxbMp8d7RWVFJAwOohDH7u01gS0lzSvXcx7xY14NndQNP7hqGl34
         wiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763029935; x=1763634735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QURbCPhZLgDFuDO50oTy4YxAU/M/cxLF0F1zsVf26eM=;
        b=adEm9AzDwp4QhnkVjUou91MpFMNTKtzEWYq3EcZKqQRqb0XB6w+n9BcZAEZW4U9QEy
         C5jtghasj/sEbKmJap0e0pPIevRhCpAzfGFp3dUeRz4TdNU0SazUeTXd6nB1NqwnSd2K
         k9ouNi8FFOln1iPkYh9H2dK7CewJTC3D8wZ6nUW5Uyvud0EQFw97oZTJ9THHr7Q7zPfn
         RsSTOZsmX5n4MpC72Zwp7r2P6H5aUakWqKcA8GGQzHDo+qnNldOVSXClwaXOdb0N7H6B
         d+tCz+IoENdOx9VxDzLhlYfs7GjtHCtLZpEJKtT6T+C61hRZQwWOdaXesAyikxf4o+HB
         2ZyA==
X-Forwarded-Encrypted: i=1; AJvYcCUZuEnrHbK4JjH8ZmrqJ+Uwb68v3SDf6/t6tS3S1hPe/6dY/xytPX6Mvi49N3z9Rr5OFuSLVySuzi1Bgu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHpphmBfeF7vyqxSdl1JYkfDiZpD0Cr0Gz94lP1jl0Is/2jjR
	JQiSXlOKudR+LqAmfSUD5lwySNRquH3adX15fYsvVhMAAat2mFv2yq0G3roNc7M73XE=
X-Gm-Gg: ASbGncs6RCT70IYmHxkX8WuDB8a9Giy3lxSQF/CEqnmPQzR0B+kTBpq4gQzKekw4Z6J
	4j3HoRfVQZOuxU5yKcwsQDustSyztW/f37WhSLeJLB1kTs2xFWuCfZHkcEACs8iIVWqKVcV2Pm+
	s+6SvC4JVvO6vKPFNOF8awmlkLOV8+WuWjBIrYUZGaY3jY8aNKKDRnx/v+AhC7KvdKUc1D/wNLP
	Md6UrkXVo4jaVkphvzMJQD1J2iC4BF5kYGlMD4GozG6967VH6Rz1JbABUv6x0GwSSclV4Q/2J4w
	TyIe8duPQv3qi9kei1gF6HpBBK1OoI6+pxvDnf3tLttomM8TjanHB6L9B6HOUExHUsYYNwtW3xT
	fo5w4tfPXLF4blwrdUWjdzs8qJ4sFiHtYwROxOx9HecQoVGjeajBei9euOGKE78wgUURrZJ3/MW
	r3uUE+GZr+NAexpfOMiwo/McxH0qSF9aGxb6UAQo8QN/ckTQ7oXb0=
X-Google-Smtp-Source: AGHT+IHZRVqKk3Xf4AoXPh3RQ9USehQ1ClsNRN+oJOsjTDjAvAY9LII/LH2yTXr91VjJoLaVXeTfMQ==
X-Received: by 2002:a17:903:1af0:b0:267:912b:2b36 with SMTP id d9443c01a7336-2985a51863emr28237365ad.23.1763029934984;
        Thu, 13 Nov 2025 02:32:14 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm20457965ad.65.2025.11.13.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:32:14 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vJUcd-0000000ADSS-414B;
	Thu, 13 Nov 2025 21:32:11 +1100
Date: Thu, 13 Nov 2025 21:32:11 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	john.g.garry@oracle.com, tytso@mit.edu, willy@infradead.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
	nilay@linux.ibm.com, martin.petersen@oracle.com,
	rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aRWzq_LpoJHwfYli@dread.disaster.area>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <aRUCqA_UpRftbgce@dread.disaster.area>
 <20251113052337.GA28533@lst.de>
 <87frai8p46.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frai8p46.ritesh.list@gmail.com>

On Thu, Nov 13, 2025 at 11:12:49AM +0530, Ritesh Harjani wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > On Thu, Nov 13, 2025 at 08:56:56AM +1100, Dave Chinner wrote:
> >> On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
> >> > This patch adds support to perform single block RWF_ATOMIC writes for
> >> > iomap xfs buffered IO. This builds upon the inital RFC shared by John
> >> > Garry last year [1]. Most of the details are present in the respective 
> >> > commit messages but I'd mention some of the design points below:
> >> 
> >> What is the use case for this functionality? i.e. what is the
> >> reason for adding all this complexity?
> >
> > Seconded.  The atomic code has a lot of complexity, and further mixing
> > it with buffered I/O makes this even worse.  We'd need a really important
> > use case to even consider it.
> 
> I agree this should have been in the cover letter itself. 
> 
> I believe the reason for adding this functionality was also discussed at
> LSFMM too...  
> 
> For e.g. https://lwn.net/Articles/974578/ goes in depth and talks about
> Postgres folks looking for this, since PostgreSQL databases uses
> buffered I/O for their database writes.

Pointing at a discussion about how "this application has some ideas
on how it can maybe use it someday in the future" isn't a
particularly good justification. This still sounds more like a
research project than something a production system needs right now.

Why didn't you use the existing COW buffered write IO path to
implement atomic semantics for buffered writes? The XFS
functionality is already all there, and it doesn't require any
changes to the page cache or iomap to support...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

