Return-Path: <linux-kernel+bounces-721383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D07AFC87E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648D74A5CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7413E2D838D;
	Tue,  8 Jul 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d54DaXHT"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF1220F34
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970908; cv=none; b=Pnwn/kM4NPwNM+woEeJMb4lxJIVxZ4ilJ6fxsMsPZMM5nVEQil741dkapiiHFzJoVGWWImHTpGsJmRtdEI/lXTjwmsKZU+QuzvKuAdyNjtU40VWCtrDgP7Ij+YWj0FhLdzYiEZ6edjra7M25fhefiLj+sUQ+O8sFHsgp4MKS1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970908; c=relaxed/simple;
	bh=7IXc7qy1Bw7RI+SYkAYx0fei8hDB6WkKYe6qaSLeOpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fs0kSqHKSA8ojX7svXaoCL80qMHtVRSQ1WpKq560DJiLzLs8EMDu2jvu7P2neZYhh48Osu8mX2RR4SkJ6SKlk7tSNRiPV99N+2rfQKdXP88K38i2LwhK3KgxLuKIdITA+xQEMytkCA0/wkOmUlJ4N0j+Whp2m66NWkvrRMilQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d54DaXHT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so29991785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751970905; x=1752575705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv1xsOFh+dbVCfKzJOvR436AlgILovMDLylRoCE6V0U=;
        b=d54DaXHTCg0WsXit7s4zivc9hV3ZmjR8VqW1xBigSK4uXOhjjXBQd4rcwKcXtw19I/
         dkHlgdJ0sJPauTtzko4eEUxnw3DW6Zhhnz/G5Mnhw+RlTWmXZEqZAH+If3LgIj1OXONt
         PpHAS69sYoYDVDM6EIE1e3kUJIV0y+LRC/i3LJKaw+9RVO7EUGJ6ujso363ob+LW23Lu
         +RVkXaIQrcxazeFLzo7jjzB0VtiE91hHyOGq6pO+CkmWbduND0G9D+JUEUy0xuf3Copa
         O4OqBpEQGoBZhJ1CzyQ25WBRkVsn1sT2kZ2B38cMNBeTPwBLcaxyO9ciqsXrq0yHDnfG
         JxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751970905; x=1752575705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xv1xsOFh+dbVCfKzJOvR436AlgILovMDLylRoCE6V0U=;
        b=m0zYdMENgNhfxfUIuS8kI2/xfUerIHUyDRqfPdgl1RkLaVqoosW7rRUXUKS1X7aC2r
         OWfhL28nh7TU4LnjBhwaOD9SH3c4F3Z4ZLADqKrhjSN5hLv1L6lR8jU3/efkb4GPHN5h
         VhGhgmwq9HXKbSVYGLI1A1b7EZj9AMSYHMFp5nO2Wo21PCIE4NwFKYj2bga3Gqh6ITM1
         S9p871ZL2Rr3iFqPe4blLDZJb+/UI6cTtSP5SzZmUkL1kVNniOuxRS3Muz2F4rl92hJd
         I2ej64sNnSYDxiZdLfysMFDEyeZ1T4kOQ4qHW2XT+AmhgbxWH8i8xS3Mm1slW5q3u+tF
         4vxw==
X-Forwarded-Encrypted: i=1; AJvYcCW1WUFj7KgzTcmwfC0yOoCO6EZFHyz4wwb/qzSYwlBB6aooCwOhRyKWWzleAfLO36veeMqtgPUgma896Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7PWhi+vgGVDP2jhG/xJiyuCgBedEqVeKwnTyYnNGd9P2Rujf
	0BMVrrOCEkE4kJ0aKbkPOIZvUmU1cW1j7R20/xxNIi4mLWjlqXF5tPdH
X-Gm-Gg: ASbGncve/BSuMAGeVa39dbIFIN/FNlNHFGWYMh1ti3QcKQrWFIAC1RCPycHBmk3cNIY
	IoGCAFHhAJAW8LM/rZd1fre3Ny0Fs0DHajWNQqGQgfQwYMX46wIJY6mgM8nSvKJ8u3aqnHymmQi
	fT3EucYM4EeeqgpQJz7Y4P2rrWN3M58+QDenBeqjHhqQpVfO6xc7344sOaIlS6TYz8U/qjtQczO
	TrrGpzOdRejATJUhdJ89+LgIYRbYpFWDmVxzf9/UU/EnMJvMKh/Lf77tzUb1gLKDvrJh0BOefCy
	p3H2hyMaSLGpj+75TbwQLr954D/BpHa7uLOwUDYMnKEpz0ID/HLg6vmon8ARzBIvIEamoCmHSfM
	u2i69cU0fBh5hB3KIeSvj6rX1VnbL
X-Google-Smtp-Source: AGHT+IFgCqRsjEn/S+TNQAljzXjge0wvm7w93QHtGJoWlmQh0T0gXPXcOtlHI+1p4PZ0x6kq90ZQKw==
X-Received: by 2002:a05:600c:6285:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-454cd691a7bmr22519145e9.14.1751970905315;
        Tue, 08 Jul 2025 03:35:05 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d263bsm18262795e9.23.2025.07.08.03.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:35:04 -0700 (PDT)
Date: Tue, 8 Jul 2025 11:35:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Li,Rongqing" <lirongqing@baidu.com>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "vschneid@redhat.com"
 <vschneid@redhat.com>, "mgorman@suse.de" <mgorman@suse.de>,
 "bsegall@google.com" <bsegall@google.com>, "dietmar.eggemann@arm.com"
 <dietmar.eggemann@arm.com>, "vincent.guittot@linaro.org"
 <vincent.guittot@linaro.org>, "juri.lelli@redhat.com"
 <juri.lelli@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [????] Re: [????] Re: divide error in x86 and cputime
Message-ID: <20250708113503.147336d0@pumpkin>
In-Reply-To: <20250707203057.1b2af73d@gandalf.local.home>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707223038.GB15787@redhat.com>
	<2ef88def90634827bac1874d90e0e329@baidu.com>
	<20250707195318.0c7f401d@gandalf.local.home>
	<92674f89641f466b9ebbdf7681614ed3@baidu.com>
	<20250707203057.1b2af73d@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jul 2025 20:30:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 8 Jul 2025 00:10:54 +0000
> "Li,Rongqing" <lirongqing@baidu.com> wrote:
> 
> > >         stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
> > > +       /*
> > > +        * Because mul_u64_u64_div_u64() can approximate on some
> > > +        * achitectures; enforce the constraint that: a*b/(b+c) <= a.
> > > +        */
> > > +       if (unlikely(stime > rtime))
> > > +               stime = rtime;    
> > 
> > 
> > My 5.10 has not this patch " sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime ",
> > but I am sure this patch can not fix this overflow issue, Since division error happened in mul_u64_u64_div_u64()  
> 
> Have you tried it? Or are you just making an assumption?
> 
> How can you be so sure? Did you even *look* at the commit?

It can't be relevant.
That change is after the mul_u64_u64_div_u64() call that trapped.
It is also not relevant for x86-64 because it uses the asm version.

At some point mul_u64_u64_div_u64() got changed to be accurate (and slow)
so that check isn't needed any more.

	David

