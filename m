Return-Path: <linux-kernel+bounces-802518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3AAB45313
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9B31615C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25621F4168;
	Fri,  5 Sep 2025 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="brXeq3FC"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ACC2836B4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064038; cv=none; b=c2Nh3W+j7DJQ6WJNv4RLtoIOyYjYZRpan5hlMrLmE3s2/qBJ/mOpxAHEUPabQjHxkwl7S/C+IkiI9HToyL/36/XZzJD+S3HwzAWkNmf59O71/UkKIDejHA1oN/93onrb6BPZXdhkLQj4LMF2cTugu5TJG9mLt0JhquxovHWVNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064038; c=relaxed/simple;
	bh=oM2tmimwc3NuazIswcDXdIxLK21NTDotdqDLkd3Ro3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYJQvK2V0useymlqOB+drV5r/2tm0LH4ou2EBHyOO6r36E07KWAOORco7P8n9BsqZdDl1B4uILYuyRFQMBllUeecV/6tshKPlLo422acBM5bnZRJEc8a6zn4VwBFev1zqG7qKNqdB2iXZ0G5ztaIeLoKo7CystJcu+jiQSxNCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=brXeq3FC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3dce6eed889so1552025f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757064034; x=1757668834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn5dEdZ+lZHL1bSbN7KhfCFXfCyJi17J1T7WYwt+oY4=;
        b=brXeq3FCmhCNev8GyIcu02f4LaTGXbxjD0oJf5Ovds0+G6y44ea+QIOolhFBWVbcJ4
         4s9VG0MH7/1xgXRx3L7rF65xvkswBqzSsGnNq+4X4lsJ6L8qakzvgfze3HNaHOpxVAGY
         YC0CvWHLRXHaUXDL8vbS856vpVuSCLErNOJAgOf/ElDL22WDC+C3ohni/cX5CYkkAK/r
         rifHOrds9vftVCHrBuW55T2QpHvH5OYMrUmkA1AsABVc4ZuEZlmYBrrIB705wymhFBou
         +5bxr5M1eSgWJ7WV0jQa1qkj6x44GtenCShZ6x8GHWYobrVn8pW9SDoNaA1TsOTmPPEY
         0gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757064034; x=1757668834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn5dEdZ+lZHL1bSbN7KhfCFXfCyJi17J1T7WYwt+oY4=;
        b=JE+dgix5sQHOXNDN/iegTmh30gpkrJgi+QKSTv4DS+N8308IKFrMulL0A7ZIHNv4dl
         YClnMc1RPEH769kBeFUBBvelflaakXig+fPSgd/Pmor8yyIr6ioR8c8zN53B3pWS1kib
         WVHtBchIkkLGCg29mFYE9BY2Y/j6sNV3Cbk1F+ZouIEajNKfvnK3zicRzKLWpCOAM6u2
         r/w0T+aka/Fs80kzYlK9dYQOHd6ZghaIFAy5KEPS9ijeoUEYDvU6jWpF+BpJZvXyP1Ia
         st7jSaDFOWlfzUXEa/l3ZQEbgAzu39Yr14tWArKug/5iHsbI10/4DDJ2u7D/Jsj7UHNI
         0PNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnz5foNps3CJubtRUx485eBf9TRJi7bNzUEdvaDViyrMMuoolHOB1+ljxkpkuQBsrRJAiA7WQ8gqDzDu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVxAEYaRLdixn+Eaa5iZLq6Y752iaPfftc7eyGwejTvmKL9MX
	7mOSwqRms/ukI73X0eHw4ccQVYbtT1oKIMKARLnXnCi9kkEVtT5i/4zLdKOWg6n8rGY=
X-Gm-Gg: ASbGncuMjMSgf0hftAz9+SQRq2eLMJqvValxjfXAWuN8nRv6Q6DbPC/g2PfQAeF+zx9
	+pmoc3jbDMwxSWj0JTp73MA+g67yn7gR9GCw9wfuljitYwy2zBGfxsRodz5NcmYUn3JcEDEPvAb
	zvxRI7yDCJx5x5Cv50KUYC5q0mN00UaGt3mdX7wHODc0z32Cm+iPtYdep5KqRzM0iyKbDl/kePb
	xM1Tn1Grd6WiSUt0Tl6vcFDGtbfnYV2qAkuogP9xhTdjWHQP+Jn9Dck61p5b65TUI30KN7VsLka
	4yaeLHDO0jhzEHTjBNYImgvChsbJP/BZVaSIl9qjZf4Msy2zjlYmojKx5Dyp7gOwjeHweVYhfQJ
	NO0W8ooU6LMVp9tlNhH3P1suSxDyxVSkp
X-Google-Smtp-Source: AGHT+IH/8fhX/fgj2tMYfhp5tk0xz7+PqaSeuV56lrf1jk5bI4HL3PlQBpwu2LI3QZpIRCEAOgjxYQ==
X-Received: by 2002:a05:6000:2f8a:b0:3e3:921b:659f with SMTP id ffacd0b85a97d-3e3922aad5cmr1139388f8f.2.1757064034085;
        Fri, 05 Sep 2025 02:20:34 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf276d5816sm30579447f8f.25.2025.09.05.02.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:20:33 -0700 (PDT)
Date: Fri, 5 Sep 2025 11:20:33 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com,
	shakeel.butt@linux.dev, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, lorenzo.stoakes@oracle.com, surenb@google.com,
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v7 2/2] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
Message-ID: <aLqrYbsLzdr8tXe7@tiehlicka>
References: <20250903092729.10611-1-zhongjinji@honor.com>
 <20250903092729.10611-3-zhongjinji@honor.com>
 <aLg7ajpko2j1qV4h@tiehlicka>
 <7rvwvuifkav5oz4ftfuziq23wek2bn6ygvrfotpaweypuy7obv@hjuf3eknscii>
 <aLmENFH-g9MUQAsE@tiehlicka>
 <a3hgvhvix2ulzfof6d23f7kzk5clsnea3grmd2wowjyhjwuiyn@ymzvkqf7gcsc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3hgvhvix2ulzfof6d23f7kzk5clsnea3grmd2wowjyhjwuiyn@ymzvkqf7gcsc>

On Thu 04-09-25 22:12:48, Liam R. Howlett wrote:
> * Michal Hocko <mhocko@suse.com> [250904 08:21]:
> > On Wed 03-09-25 15:02:34, Liam R. Howlett wrote:
> > > * Michal Hocko <mhocko@suse.com> [250903 08:58]:
> > > > On Wed 03-09-25 17:27:29, zhongjinji wrote:
> > [...]
> > > mmu_notifier_release(mm) is called early in the exit_mmap() path should
> > > cause the mmu notifiers to be non-blocking (according to the comment in
> > > v6.0 source of exit_mmap [1].
> > 
> > I am not sure I follow you here. How does this relate to the actual
> > direction of the address space freeing?
> 
> It doesn't relate to the direction of the address freeing, I think it
> explains the perf data a bit.
> 
> The exit_mmap() would have a decrease in mmu related work while this
> thread will have an increase, I think.
> 
> If they race, this thread gets virtually nothing while exit does all of
> the work.  If they don't race then the work is split.
> 
> Does that make sense?

OK, I can see what you mean now. Thanks! I believe we need more data to
understand what is actually going on here. Having the overall duration
should help to get that.

-- 
Michal Hocko
SUSE Labs

