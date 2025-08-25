Return-Path: <linux-kernel+bounces-784336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB55EB33A10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA38178519
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AA62BF3F3;
	Mon, 25 Aug 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOjQAawR"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA421E0DCB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112464; cv=none; b=AfOvk3eDv5+e4jLzBTButzgTBNKlGCmJEpZJOr0glTaevpqzubeEYp4kFeCP1asyiSFQe1BMe6vcEPKGGSejOzVoaQb6a34mxQWxhxHaSEFpEPP2oPEW4j/4yoSRHU4mrzGc1Z2lSiDiChMt2+1eswp2trZhHyP8R72sMj3/SA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112464; c=relaxed/simple;
	bh=I4y7nVGnepxyTdqc30iBYZsRvjIxQN60EFvbpEBsUB8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNs8FJ7WYWWbrqtB/qQm/T1ravIlsebeHm/BobC7zfsW5Tq9vI4XK5JeK1hx9yoEFypkKY8PaP6kdP0cYMg3ikBMQbecVF3zRmPTrShU8p3OXhiVIgZ6nmRblghWf2E2UaJZ05tKEfgeTckN1EEJiTKsgl5Ik7VrFK/88BWKEUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOjQAawR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f3e4dfc5eso824500e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756112461; x=1756717261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GLLuuF0nylz+PH2kjluwwHpcMAE0V4MLeUIY2arLuI=;
        b=bOjQAawRC8cTXMuc5jDruMMKC7YZAc9h+HRx+gYhfpQvSMw5V8IYAg7gKsDATjqPT7
         l6MQ2xe/hHCH3p5ax/hZVKcXyMNB8D1Guf0NELZ/XXUvefxVhDFBEqGwp3hpsv2iIiQf
         spZjtvOPQCPi2OLkYizKB2+U7TezLXONS0pjVYJ5tvnsxVLz6gsb7kjBq7j2qJh7FUrN
         zZA4+YtoC392S26+mGCgIfvo/smg3fCxp4yVMWpezLcHcOTkC7k6ar85EJRBzbotB58S
         YDI73+zvNYeLEj0BbdXV02LFDATUukccEXcDNd9GNr+Z5v68+8VYMt3fVOea2Soa+HXF
         voZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756112461; x=1756717261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GLLuuF0nylz+PH2kjluwwHpcMAE0V4MLeUIY2arLuI=;
        b=Ut5ECIgTvZmYRz3rsilFBVb9g/yL8OX+NswnFPz2TVH1qlC+73ZbFSmAAegiwBTIfa
         tmWRvETRi4NmVPVmm4fRHBUKWGLNwdLmVeP793QkD7wNb8+TYwyQJuZTkdGep55QJChE
         jbnwHdSWgxO5QuxSjBGGJBS9o1aF3CwWvyogzEhNJMOzZotIwl397ySjw05Fz53HaqvC
         qM7WbJhFb3fKAC2p8ceXgWxuLOduzYcFMeGIEZiYY0ZzJCA03RGMaSgDChxzli+FcaUk
         pVTmJub8ni7uRNqSSNk1NFpg9GK4M5mAjccxQQbFQuUXfAapNg38t9Ysd//ejGa5CbBE
         V+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD8MXlItTakyqi1S6yAhiXHSpsCGwG8Nf6IsU1dU2WsdSaAGxVWE/zQQ3zTH5E4UqrpbBlvBuaGi7hFxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZB5j6cD/1o5bzn7sm7Iey2JUbfM/SF39n/1GphzaOn7JMSYq
	TE5AaBlC21GNcqJjDWNvSag/Mds1QWSVYX7MrCnt7J+5DMb9jpws2jGM
X-Gm-Gg: ASbGncvhO/P9Ko+eh6s/oJ9wcehoXJwnG2Tmj3RPX8o3GdvCy67x4mIW5c2hmizZBkj
	tvAcGT/rC79RqQX72h+Lf9CubrBgz33twTAkcb80MXxJ3MUYf1M3mkVvqJ9a8U73g74SbO7rrDL
	p5g7aDo3Nmv6Lk3kT94mUyYKp7+bBZUCxBbtiDZ/eonXYfYUW4nb5sF+6LlJe+jDF72lwfUrxrx
	LNnteHt80+TFW8GLAfKx6v8v+6D4Hz9itOIeRn100MbnlOMAXN2ME5aRddvM1fnnV4ZTBVUEwHT
	kuYAWVjr8I6RWDOdrTXAq0UOw28Or4HqgPmHHk/I1ELGkzXZFeqr0LaTmQOqikU8shJ5m2a8NiI
	SF7Hc/M26bzdzWhypMp7bSKVq/MJ8OU71PIU+wNyuPRUN70TU5dGq3oRhpQGIsOLfnU8/
X-Google-Smtp-Source: AGHT+IGaTLQFGBcntCUybb60rpe5ac2c5Xb3UX7huo1J8YjrOMQOtwlzEVc6oELd8pXpCy3iqNWQoA==
X-Received: by 2002:a05:6512:440e:b0:55f:4361:890e with SMTP id 2adb3069b0e04-55f43619020mr1097338e87.15.1756112460558;
        Mon, 25 Aug 2025 02:01:00 -0700 (PDT)
Received: from pc636 (host-95-203-1-122.mobileonline.telia.com. [95.203.1.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f4335139bsm740757e87.111.2025.08.25.02.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:00:59 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 25 Aug 2025 11:00:56 +0200
To: Brendan Jackman <jackmanb@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, peterz@infradead.org,
	bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
	tglx@linutronix.de, akpm@linux-foundation.org, david@redhat.com,
	derkling@google.com, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com,
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz,
	x86@kernel.org, yosry.ahmed@linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [Discuss] First steps for ASI (ASI is fast again)
Message-ID: <aKwmSIOEZnG44aF2@pc636>
References: <20250812173109.295750-1-jackmanb@google.com>
 <cdccc1a6-c348-4cae-ab70-92c5bd3bd9fd@lucifer.local>
 <DC83J9RSZZ0E.3VKGEVIDMSA2R@google.com>
 <aKihQv8fWzZIgnAW@pc636>
 <DC94NN6SM15D.3DQVRLO2E282W@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC94NN6SM15D.3DQVRLO2E282W@google.com>

On Fri, Aug 22, 2025 at 05:20:28PM +0000, Brendan Jackman wrote:
> On Fri Aug 22, 2025 at 4:56 PM UTC, Uladzislau Rezki wrote:
> >> >> 2. The ephmap implementation is extremely stupid. It only works for the simple
> >> >>    shmem usecase. I don't think this is really important though, whatever we end
> >> >>    up with needs to be very simple, and it's not even clear that we actually
> >> >>    want a whole new subsystem anyway. (e.g. maybe it's better to just adapt
> >> >>    kmap_local_page() itself).
> >> >
> >> > Right just testing stuff out, fair enough. Obviously not an upstremable thing
> >> > but sort of test case right?
> >> 
> >> Yeah exactly. 
> >> 
> >> Maybe worth adding here that I explored just using vmalloc's allocator
> >> for this. My experience was that despite looking quite nicely optimised
> >> re avoiding synchronisation, just the simple fact of traversing its data
> >> structures is too slow for this usecase (at least, it did poorly on my
> >> super-sensitive FIO benchmark setup).
> >> 
> > Could you please elaborate here? Which test case and what is a problem
> > for it?
> 
> What I'm trying to do here is allocate some virtual space, map some
> memory into it, read it through that mapping, then tear it down again.
> The test case was an FIO benchmark reading 4k blocks from tmpfs, which I
> think is a pretty tight loop. Maybe this is the kinda thing where the
> syscall overhead is pretty significant, so that it's an unrealistic
> workload, I'm not too sure. But it was a nice way to get a maximal
> measure of the ASI perf hit on filesystem access.
> 
> I didn't make careful notes but I vaguely remember I was seeing
> something like 10% hits to this workload that I attributed to the
> vmalloc calls based on profiling with perf.
> 
If you could post a perf profiling data for your workload that would
be more helpful. At least i could figure where the cycles are consumed
the most in vmalloc path.

Thanks!

--
Uladzislau Rezki

