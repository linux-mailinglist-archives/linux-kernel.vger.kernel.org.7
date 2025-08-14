Return-Path: <linux-kernel+bounces-767793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83DEB25916
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E232563BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D91B4F09;
	Thu, 14 Aug 2025 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/G5BgbH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4E1624FE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755135037; cv=none; b=VZEnqklbXO/FmJXVkIJH8botwl8gcyqKY/Cgvlk4pVYzA6IBucbkXVp3uSKzgb1YZPmJNbbzYl54KRgZdeB/JnWT64g14Sskk6Xo7tJmDTkjyGaO0w+1hj0ySuqun/xb5BmWiASkUowOLX4sxmxymX07GH1Zybyaj+DidvM8ET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755135037; c=relaxed/simple;
	bh=WbgJ5isNsqVYV5zzaKVbpULuS/3hHjDmri82xKxBaDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sT5E7dLP8ykxLb/YMUqgPf7MDJyK2dlgMdFOj8BDFNfeU5UHGdSTTDXzU5qELUOTiLhCKeO7wDAADm6YcoJLkWT8CyrTCvy2j5TNuh2P3L+p+lis3li8o8RG+W2A/Wins4uutWlKFjfqSx2RFvY2l9TqtdFCfOfDf+4YOElhLnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/G5BgbH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445820337cso3782045ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755135035; x=1755739835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4oH/H8Uczj38sjgvka81xmx7klPZUzo+Pao4BcFdNEY=;
        b=r/G5BgbH01l17L9hLaUr8LrJjHdwJS8TGK0S/8Y8GGcnlxtNzDshxVo7SmLGcBGpS/
         W2dQoqCIi5WWR+SUID++57ytheg66TiYNnytJ3SyBC19QP3HtH+4wjMHdRJXb8BejCSz
         FY1V0IBmZ7MUy3+4MMHtZwVDfqisttn0F/S1kpLpdeovqQZqRF7vrvszc2HJh6ArpZJC
         N8JefQsQSr7lxKfq44kKsaXY4KIGOyofQdDaoCdv1iarj7ye1wzw1RepuQxgO18pDOIA
         AXlBzLVsdY+9qAWCWhOtEpgKfmnpkiDSxt0KzCnh+EhknRHJzOMT8PSOXggtb8uy0h3q
         ROlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755135035; x=1755739835;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oH/H8Uczj38sjgvka81xmx7klPZUzo+Pao4BcFdNEY=;
        b=nNvzZBS/80d1ES4f2qnEJwd4tgX5ltb/JpdnUXg3TffDRcQH+r5g/ULubmSficeSFG
         fJzCkyEjxSPxAxWmZM37zj6voSTj1Ca5FmSRx2krTTg37PpR76nZfY2VwREcps0CzrLu
         EpVyVjJyQuJSA5m0z03hTV22Wgvd8hbv9BghdhC6iQ7zKJPO1rQSO2PhBinYSzHTfcH3
         3x+QrPzOfDYPuyLAXwz4I6ewLBvMC18eL8aCWO4DXv7OlvEdQO+JxrtM5ettx8pABX0B
         VvWemoxQt1UV+JXT8rcIwWYHueBJILm/1JCr37NA+cbmkp3wTLktm64SCDl55Us0ww3z
         xd6Q==
X-Gm-Message-State: AOJu0YxPvFvapSK1yzs/JzdiTALnpN7mKIuYBftSfbz2RHxE8SqVUPM+
	EPM0HlhSDu7DjOZaETjk1oSy7/noGd24jFkOrVhjtUDE6vXfx8FHIIfu3+oRRd2cdVuylu8gP/3
	LZk5Wp2fUjg==
X-Google-Smtp-Source: AGHT+IEvtjIjDFf5oUu8XtuvZ66AuDR6piAkpqJV0aQYguAIByySyHcA1rR4otGY+tKdX93cPC7afkFJ2b9b
X-Received: from pluo13.prod.google.com ([2002:a17:903:4b0d:b0:23f:f074:4148])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:138a:b0:240:4d19:8797
 with SMTP id d9443c01a7336-24458a50a4amr18212045ad.22.1755135035267; Wed, 13
 Aug 2025 18:30:35 -0700 (PDT)
Date: Wed, 13 Aug 2025 18:30:33 -0700
In-Reply-To: <aJo7udUoWJt_jLzK@slm.duckdns.org> (Tejun Heo's message of "Mon,
 11 Aug 2025 08:51:37 -1000")
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805032940.3587891-4-ynaffit@google.com> <20250805032940.3587891-5-ynaffit@google.com>
 <aJo7udUoWJt_jLzK@slm.duckdns.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8qzxe7kqu.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [RFC PATCH v3 1/2] cgroup: cgroup.freeze.stat.local time accounting
From: Tiffany Yang <ynaffit@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Tejun Heo <tj@kernel.org> writes:

> Hello,

> Generally looks good to me. Some comments on cosmetics / interface.

> On Mon, Aug 04, 2025 at 08:29:41PM -0700, Tiffany Yang wrote:
> ...
>> +  cgroup.freeze.stat.local

> This was mentioned before and maybe I missed the following discussions but
> given that cgroup.freeze is a part of core cgroup, cgroup.stat.local is
> probably the right place. It's not great that cgroup.stat wouldn't be a
> superset of cgroup.stat.local but we can add the hierarchical counter  
> later
> if necessary.

Got it. I had ended up opting for the "freeze"-specific name because
there was already a cgroup_local_stat_show that seemed to imply that
cgroup.stat.local was reserved for controllers with a struct
cgroup_subsys. I will update v4 with something similar for core!


>> +	A read-only flat-keyed file which exists in non-root cgroups.
>> +	The following entry is defined:
>> +
>> +	  freeze_time_total

> How about just frozen_usec? "_usec" is what we used in cpu.stat for time
> stats.

Ack.


>> +		Cumulative time that this cgroup has spent between freezing and
>> +		thawing, regardless of whether by self or ancestor groups.
>> +		NB: (not) reaching "frozen" state is not accounted here.
>> +
>> +		Using the following ASCII representation of a cgroup's freezer
>> +		state, ::

> It's a bit odd to include credit in a doc file. Maybe move it to the
> description or add Co-developed-by: tag?


Will do! Thanks for looking over this :).

-- 
Tiffany Y. Yang

