Return-Path: <linux-kernel+bounces-721314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE7DAFC79D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070373B24C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F942676D9;
	Tue,  8 Jul 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Duz2syNP"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A81DDA18
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968725; cv=none; b=gV4vzde1hcw1MeRxLpV9+YcaGdwwZR74DpLszu1//s2WsLSGNXFYHWzgY82p5zFnKCKkIaEV68KDFlg+qENH0+tG+qXcmy6DzpWruIz+qflRquS7LHH7FZ5dyIwU8dBmE5uOn5KNvEokONdqgOGtACWH2yDVdVZ1oqntmSBXVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968725; c=relaxed/simple;
	bh=IlcBLjZ1kbRd+8o4QY4C1799ZEjOSQMqjRJhSLBmFxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3GXbd83POEAF8ZlnHcAz94iDJiwJBufLCafSEcPLKkim5U8KO+HMz7HGmA3yApZVYz6A4bJbXfYpDS2hxRzQj471EKwhyWMlKxsNnhRaqmX7Lh/un7dVtIjC28vJ2oQAOxHde7Qz71HYWsWNJVnF7wJoeaMw6k6XSEV6IM8Gv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Duz2syNP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45363645a8eso28416155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 02:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751968722; x=1752573522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAcytUTUgS7XtSjgMWI1WK2/GvT+nRSft/rhC6nRc9s=;
        b=Duz2syNPnBwQb6e8FLR7Kaz35JtKKInicTnIIaeRLpbh0ujcciDiGAmTC+2rhZalj0
         SGkWcMxiE4FWsnNA0Aeg3PfbJi+uqic7u4g/fLJikNpTfIb8OlLqACOwcgJUIdzn+si2
         V9pWG1aCQpFalSGkSFwjtguYSR3LVCyQ5nB4O+DNDJUTTLTIbwyAdB4ngJ98cNsWnu1V
         RpKAaJgSidj7qB309/P20I4LgEr31FMUJA+vSaJMAnBAvgXgVE12OCErzA3WVmfZbOkl
         bufiTp3uVe6joYMpcMiQnV696Lb5m6MQmRi6JCcrr/Gv4PlZZ/vjFcbAICpALMMVCIZo
         lOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751968722; x=1752573522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAcytUTUgS7XtSjgMWI1WK2/GvT+nRSft/rhC6nRc9s=;
        b=OxZIMnZgMZ1LL0d/ShzrXx2mOBsFcPXZ79aAD0WqRf5KqfJxgANObAX6TVObtBnCDn
         ZdHc2O7rp2CjrnqHwtFSbaGOISku1hprxxyJgk0TTv5vcgdJyOornfegPzu5h4WZgiLt
         XYcUH1LOg9PpYAeoFtvHWG+Q2fY/rwmS83CVxAA84X7280GMyFiy5R+MYu8FKicJIbMZ
         e9hfRGrHL45N00SWyTNajVPdThzYuns4SCjfDIDW9A2GBO+p2hlD0Y1bMEgH+z3++sAw
         LDcmh7yTwdPaKy7U0lxgzHNLhxJMZBDbHo5VzvPerRFhPcrJN/HYWuBGugP7TpaUAjT1
         ki/g==
X-Forwarded-Encrypted: i=1; AJvYcCX/NHssqb5tb+LKhxgWOLVoPZJyaFBiU5jlVCf+U3Cpa7SMQbBoN3e842P6/eoZLiJwfgiYkTiK9WcDTyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWhGXXz9I1IVhPmuooQEbXA6eC44HRGpfDFjYlrUO0KilZBjr
	ANFdgEwbaS8vRShsd9KDs13P0lHfw9HyRJFX5JvtkRpAmx81695AwYnZ
X-Gm-Gg: ASbGncuv0oeHyjDeN3i6BdGgu49aN9lUVBReJGct6iPqwxuayV3wJKBS6WM5wrcZy4V
	vejU5VMaXls5fESPGkSADJnl2pi9U9WFPaoq+kkgiEJyeTVK5qPo7pn0OBLXIHg+BXruex7d43h
	X3Iy4kGMURthmGqfunY9dpzR72hfKefZUsQmmwj4z5lNQUeTu2J9aHWLUFEgUfDH9oKygykZA5Q
	QtwWKyGY29wye8vwhQlSX3eB0/u0Q+efaq8vpMY4TsvAa7ZoFFEHDEfSKKfH8khJa8UVXwSDbd3
	jjPhKzU8If6NmU9I4WNn87vfMT6P7f95Mt4aBg5vpST5ydzrh7q7tZ5RgqqoIMiXdENcnZQ1iGI
	3Fl6F4tbX0cb5BAmrLw==
X-Google-Smtp-Source: AGHT+IGTehSKClvXQ6913oZ/Gm1d5hpork/tHdT94HeDXEro8MuvMcs1bTBM7ptE+aQU1fTD/O/gdA==
X-Received: by 2002:a05:600c:154d:b0:450:d00d:588b with SMTP id 5b1f17b1804b1-454ccc7ff08mr33873495e9.9.1751968721933;
        Tue, 08 Jul 2025 02:58:41 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd450628sm17198045e9.12.2025.07.08.02.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 02:58:41 -0700 (PDT)
Date: Tue, 8 Jul 2025 10:58:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Li,Rongqing"
 <lirongqing@baidu.com>, Peter Zijlstra <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vschneid@redhat.com" <vschneid@redhat.com>, "mgorman@suse.de"
 <mgorman@suse.de>, "bsegall@google.com" <bsegall@google.com>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>, "mingo@redhat.com"
 <mingo@redhat.com>
Subject: Re: [????] Re: [????] Re: divide error in x86 and cputime
Message-ID: <20250708105839.4ed8c792@pumpkin>
In-Reply-To: <20250708021703.GD15787@redhat.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707182056.66a8468a@gandalf.local.home>
	<20250707183331.029570bf@gandalf.local.home>
	<42f5344b80e244278aaf49f112498e02@baidu.com>
	<20250707215322.0e4ec431@gandalf.local.home>
	<8f68278c4a454fd79b39cf21d4c0974f@baidu.com>
	<20250707220529.19eb2a74@gandalf.local.home>
	<20250708021703.GD15787@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 04:17:04 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/07, Steven Rostedt wrote:
> >
> > On Tue, 8 Jul 2025 01:58:00 +0000
> > "Li,Rongqing" <lirongqing@baidu.com> wrote:
> >  
> > > But mul_u64_u64_div_u64() for x86 should not trigger a division error panic,  
> > maybe should return a ULLONG_MAX on #DE (like non-x86 mul_u64_u64_div_u64(),)
> >
> > Perhaps.  
> 
> So do you think
> 
> 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> 	{
> 		int ok = 0;
> 		u64 q;
> 
> 		asm ("mulq %3; 1: divq %4; movl $1,%1; 2:\n"
> 			_ASM_EXTABLE(1b, 2b)
> 			: "=a" (q), "+r" (ok)
> 			: "a" (a), "rm" (mul), "rm" (div)
> 			: "rdx");
> 
> 		return ok ? q : -1ul;

You need to decide what to return/do when 'div' is zero.
So perhaps:
		if (ok)
			return q;
		BUG_ON(!div);
		return ~(u64)0;

But maybe 0/0 should return 0.

> 	}
> 
> makes sense at least for consistency with the generic implementation
> in lib/math/div64.c ?

I don't like the way the current version handles divide by zero at all.
Even forcing the cpu to execute a 'divide by zero' doesn't seem right.
The result should be well defined (and useful).
It might even be worth adding an extra parameter to report overflow
and return ~0 for overflow and 0 for divide by zero (I think that is
less likely to cause grief in the following instructions). 
That does 'pass the buck' to the caller.

> 
> >  But it is still producing garbage.  
> 
> Agreed. And not a solution to this particular problem.

Using mul_u64_u_64_div_u64() here is also horribly expensive for a
simple split between (IIRC) utime and stime.
It isn't too bad on x86-64, but everywhere else it is horrid.
For 'random' values the code hits 900 clocks on x86-32 - and that
is in userspace with cmov and %ebp as a general register.
My new version is ~230 for x86-32 and ~130 for x86-64 (not doing
the fast asm) on ivy bridge, ~80 for x86-64 on zen5.
(I'm on holiday and have limited systems available.)

	David

> 
> Oleg.
> 


