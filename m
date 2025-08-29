Return-Path: <linux-kernel+bounces-791212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B5B3B383
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2425A580A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6358C239E8B;
	Fri, 29 Aug 2025 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MggyJDd8"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C0252292
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449313; cv=none; b=jhR5WPL6yRSTv2+a1MyhFbJV3B9EQEdktF1wAnSkH1EZ1fJj16MQ6+9mfZES4jyfPMK0xRiOCvDw1KAp4rwfhdEgUPPUUgug57iXwsnLif3O8p5j0rBpNg6D3P0arvO6bbedjiwTPC2PIKn7JNYGikAQmvJPWdtECN7sFGVqotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449313; c=relaxed/simple;
	bh=5sIFv6d3Ovxxl8dEbL/7wcbDfp/2rY01WvvPCFLzh/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUsCiNMeeiFnM8gESQwScBeilJMktOJoQNCV3XWJVzE4RMQPJVW5UY0b5DLCfIWK72KT+AcyfiCJdI9+VcHC4d23dabjO2P2+eftOOr09hf9Z++vFXB/DdTMHry6JgRcFeBsiWuA3iUPrhw8PXwAViZegLVbs/qIQTvM5AFg61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MggyJDd8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso11028925e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756449309; x=1757054109; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PKJThTEkC/K/3A2oXMbgKnbFIb8hibCNJ9hAKsX7lVQ=;
        b=MggyJDd89qDfhpkiDCbsyzUEXYenbrcf1IRj0yDtEGqEoD6TbAKlvfGdWkknvPme8S
         JJVde076Q9x+CwSjQo5RN+6NvySqsGOxPYZNpIDhMxpnk2zaMvWfQwt+5QbeVUkmVZS2
         gMMN7ArOBXifyCO0vpdjK3scWJOcunmITrZi9CJ7tr700mw1zUTimijKZMD2XWn9HYlw
         zaCrapjK5a+Qbrh81roDSsGH25KkEVlg9QT+NOHj94yWfwFt/twHnNtyhAUm6oH5nN2V
         dSKwjjjeWXWv/5eihDLatuYKaMYtW4VCj+m78fe6YumH4/gDmGxSPAQHcGFIYiEshSuG
         TG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756449309; x=1757054109;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKJThTEkC/K/3A2oXMbgKnbFIb8hibCNJ9hAKsX7lVQ=;
        b=kDKVXEGWack2SnPvoIlnnaufQVMaGS3f6QCTwHMWUPt8Ae8WmkKkPr1ZiQS0cZsjHg
         4T9TR7eLCq5nGwrqwfwbOhtYXWsTRNIf5lYp57MkiLqy5Nb+mX4HHeA3Zt+gLA77ANoz
         B45d8pHTugwmkzU0DloKk6AxPmNmfcy5OJJdVUv5fWAHzY3BhWnhNFME1EL6OMdYJWFX
         cofL3rdpl6BCbpXyIYPffqoDYXEXRsSYQQEyYma5EZEGCqeQwneHYdyVd3gmWzM5hNQQ
         VX9i8cmz/Tol5wQBgN0Hfiyd2XDVIw9elcNkxfkQlOzXl3NLxVu/67S93sClXRdT9wa6
         vUZA==
X-Forwarded-Encrypted: i=1; AJvYcCU5281lwkI/6WPY+aO1zM84bUCsw+fgUK4IHUV3B4Zl5f5b7rak2OeYeklRjBYprHlZXQZ6wylfs46eMzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwF6p6QcVO/9ap5WObQysa7RA8q8SvwCjLcYXJXdAOE1U7pdpC
	QL3GLoMBZULkUMyaN6dKmiU8yGb4EqELmVIsj92y5RtbS12zZ4tYOt33fD6WilRO6zQ=
X-Gm-Gg: ASbGnctX58D/Zzrg/SZLwWebITxnyeDt8q44gor0bxT6/zVNIJ+HbqtCD9veLtl1amF
	BatltaI4J4aowswXaUhGgwYUTvnSD2s48NuSr4bv6RHHDU5z6rMoTMRQTzEUhgeD5MJEeW708Fh
	ifvPYHxhdUkJLXQbJJNopdy60bkCsR/ZqzhvQ5pzc3Gbkrz8JAnndtXNsubPQDaoR7rXCy6O8c5
	DKiUxKpTceRFBnJ9U00622uGUpfcsbnM6inzRR62ATEelYnLU2FSYLDh12QZn0JDBs8CUX6no8N
	E1We2kGzxM3YqcZ0hTeNhiHH7mN+gMmXomsb4kWh2XdiXS1n7PnSB8krL+G6WHAWs/vzYCZVTi5
	Bcc5qLXIJcTTd/kuXYXl0DNMculAlJkYIqd5LptsiRv02VA==
X-Google-Smtp-Source: AGHT+IFX1VMtSwtWd9aPVdIjT6LtMQywn/iQC5nfpzx+Y6PnXBMTKM25EOfu9D+PMFUkDvcb1CqAag==
X-Received: by 2002:a05:600c:a09:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45b517c2f63mr218636115e9.24.1756449309472;
        Thu, 28 Aug 2025 23:35:09 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf34491a5asm2006762f8f.55.2025.08.28.23.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 23:35:09 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:35:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Yueyang Pan <pyyjason@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Sourav Panda <souravpanda@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <aLFKHGe2loD657fu@tiehlicka>
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
 <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com>
 <CAJuCfpHJMSd16j3ANrtJGVfLieHdeO_Epq=U9OKty3TV362ckQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHJMSd16j3ANrtJGVfLieHdeO_Epq=U9OKty3TV362ckQ@mail.gmail.com>

On Tue 26-08-25 19:38:03, Suren Baghdasaryan wrote:
> On Tue, Aug 26, 2025 at 7:06 AM Yueyang Pan <pyyjason@gmail.com> wrote:
> >
> > On Thu, Aug 21, 2025 at 12:53:03PM -0700, Shakeel Butt wrote:
> > > On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> > > > On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > > > > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > > > > Right now in the oom_kill_process if the oom is because of the cgroup
> > > > > > limit, we won't get memory allocation infomation. In some cases, we
> > > > > > can have a large cgroup workload running which dominates the machine.
> > > > > > The reason using cgroup is to leave some resource for system. When this
> > > > > > cgroup is killed, we would also like to have some memory allocation
> > > > > > information for the whole server as well. This is reason behind this
> > > > > > mini change. Is it an acceptable thing to do? Will it be too much
> > > > > > information for people? I am happy with any suggestions!
> > > > >
> > > > > For a single patch, it is better to have all the context in the patch
> > > > > and there is no need for cover letter.
> > > >
> > > > Thanks for your suggestion Shakeel! I will change this in the next version.
> > > >
> > > > >
> > > > > What exact information you want on the memcg oom that will be helpful
> > > > > for the users in general? You mentioned memory allocation information,
> > > > > can you please elaborate a bit more.
> > > > >
> > > >
> > > > As in my reply to Suren, I was thinking the system-wide memory usage info
> > > > provided by show_free_pages and memory allocation profiling info can help
> > > > us debug cgoom by comparing them with historical data. What is your take on
> > > > this?
> > > >
> > >
> > > I am not really sure about show_free_areas(). More specifically how the
> > > historical data diff will be useful for a memcg oom. If you have a
> > > concrete example, please give one. For memory allocation profiling, is
> >
> > Sorry for my late reply. I have been trying hard to think about a use case.
> > One specific case I can think about is when there is no workload stacking,
> > when one job is running solely on the machine. For example, memory allocation
> > profiling can tell the memory usage of the network driver, which can make
> > cg allocates memory harder and eventually leads to cgoom. Without this
> > information, it would be hard to reason about what is happening in the kernel
> > given increased oom number.
> >
> > show_free_areas() will give a summary of different types of memory which
> > can possibably lead to increased cgoom in my previous case. Then one looks
> > deeper via the memory allocation profiling as an entrypoint to debug.
> >
> > Does this make sense to you?
> 
> I think if we had per-memcg memory profiling that would make sense.
> Counters would reflect only allocations made by the processes from
> that memcg and you could easily identify the allocation that caused
> memcg to oom. But dumping system-wide profiling information at
> memcg-oom time I think would not help you with this task. It will be
> polluted with allocations from other memcgs, so likely won't help much
> (unless there is some obvious leak or you know that a specific
> allocation is done only by a process from your memcg and no other
> process).

I agree with Suren. It makes very little sense and in many cases it
could be actively misleading to print global memory state on memcg OOMs.
Not to mention that those events, unlike global OOMs, could happen much
more often.
If you are interested in a more information on memcg oom occurance you
can detext OOM events and print whatever information you need.
-- 
Michal Hocko
SUSE Labs

