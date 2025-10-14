Return-Path: <linux-kernel+bounces-852249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1F5BD886B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10753352096
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EDF3081C7;
	Tue, 14 Oct 2025 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XDV77NON"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAAE30595C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435111; cv=none; b=VzMNiJiiZ0Weys8YeA+5TGdymXuxN6N2Hu+visS1GKVmeQeoa1P2ClPkItq4j0WHMSeHNqkGkAh1nz161+UeQrkM4w/7oGyD0jabSi2DV2haSbErqIx8zJ9uV3tMDsHy2ynO9lK8NArYjtk6oCF3FMDOEnJ0PGm8SVBzxUBXmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435111; c=relaxed/simple;
	bh=9+jzJmhp4NDYlmVAzrpZPo68lQ6Jij+VLE6Up3JnboA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5dJJTJ8BegW7XflxiVsqrEjYxyq5Y9OghCKUJEPvASKbTkrmo9swlfN+lIkKZF17ClxwSCtZ2U3MYIZYRGW/RoehInQicBtqKnUQK1plSd7a0+GqwLm3iY2Cs/sKD8ArGUPoljGe5pkN71sj+94q4zvX7Ngr2Dnrlf/wBqa+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XDV77NON; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so30601415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760435108; x=1761039908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R75CvrIgcbILYeZyEie2SvMudL4DW8xIUI8yCH+RsPE=;
        b=XDV77NONhb6aE+xpGklpzVTPYklSS5txSxipRmfV54Mbn08SCU/o8mWQddE3WtE8Sl
         gXJYwCIf9nQCIWLFmIIDwKH5tskqCGjOZnmb8DLrKlYO3BHBVq82H/3l6WdI3dRxkJwh
         TLmut742gMNO3teiW8MPJ/aeDjaZWHLf/93D1stKQ3bHi0p7HwyJ9zLceSnAMqUECGvx
         49IRbGIa9zjSZLaeTNnVd7+uc8eRC7BTqVguORDDmNVXZypPxP0VyiuxjAaIXDP230zk
         Jee9KvOcUqzAFW7wjCAVhS4eLPLEGds2OUIepeCFn+13Br1QwjDsBisnKBG82f8oWLla
         YhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435108; x=1761039908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R75CvrIgcbILYeZyEie2SvMudL4DW8xIUI8yCH+RsPE=;
        b=LYBBOUNeCL3YqCCHxzB3tc/fqMjkXwqSD8kE63aQRPF9GoUnlhvf6sYx43+7be8/kD
         Jn5ZSi4e+7ZqiGtH2apz+r7gGxfIhjw9yH+DSnSd+YePrgyHW1XnYQTvx2cLLrqDHfBD
         p28Fxkd0XP1ODH6HGieoY4xewq0gUbgy0j5zdPfoeC5uwXQMvopI2mmG6ZRua/zXu/T1
         sJCx2Aj63Xrfe/YTj58+gKy1nK8EBoxq7r2TiKA0bz1UHz7x0McoNid/2eiWS6DXbL7m
         EtCjLYh3J5wZGl3syInnxfZtTbZIRwnLHrgQk6neerVHFNlUGygCWldmUArCTnWzACCW
         kjEA==
X-Forwarded-Encrypted: i=1; AJvYcCVSWmLJvtaQk0p4JRfdVOO7hvDous3IMhZDiGLq6Vzsa/Bj7HK9hnnHX4bISpyKalUpDrzDoCJhlsK60Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqsOcLk4VbEEeMxzT1nXAujh44qy3uJoLJOmr8CICqd6C8VtFE
	ofBULIti6X2vbImtKk1Z/c1GVcez/sNDOrtXmLw7zlLNK8vg4Wq75UXYHUO5Xz0+sB8=
X-Gm-Gg: ASbGncsii++UL6fr53Rs3XEVbK46D6b8nqEdizsE/TsSCfDn72cBMT3V5nLwfqxZK3Z
	e0kwVUYdYwTUMxTzvx1JsFauecSRFjB8RREjv/lXEVguRBCUmtQxEtmKl3STy72CFSTuMWhIf3C
	WuwRDwSisYtY1Qzxh6/gGJe+VPk11Jn/zmC7nZ5EnTiOZqABQWlKXyRnS+MZyd45MUdSsvdPXNT
	OJYQ16Rk+o1zgDTaqar5eceZYgkuFji/dgilkMDX4dx9CC0FEygyWyqaSiq0t9nhoGLYmrgC86d
	tvzAkw4MyjBf23ncG1zgXwIYYptzS3lLwHYxbJg36AlaMxx0zP0i8xgWS2LxVmXKjye3mC2zSgC
	XGIG3hkUbFWm6DX11V6ijA/8I22BYp48UEtH7hXG69R9cfQAHtZaWJPWswL+1rLwYnMRsNQ==
X-Google-Smtp-Source: AGHT+IFLMF/oRlSecQb1AgZUj9ViudEM8BAiQCOLkhiN8cHZAWDwJ7zBbTzbicn8TdmEii38ZLu7Sw==
X-Received: by 2002:a05:600c:890d:b0:46e:32f7:98fc with SMTP id 5b1f17b1804b1-46fa9af3656mr132535685e9.21.1760435107774;
        Tue, 14 Oct 2025 02:45:07 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489ad27sm230711415e9.15.2025.10.14.02.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:45:07 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:45:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: lirongqing <lirongqing@baidu.com>, wireguard@lists.zx2c4.com,
	linux-arm-kernel@lists.infradead.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stanislav Fomichev <sdf@fomichev.me>, linux-aspeed@lists.ozlabs.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Russell King <linux@armlinux.org.uk>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Joel Granados <joel.granados@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH][v3] hung_task: Panic after fixed number of hung tasks
Message-ID: <aO4boXFaIb0_Wiif@pathway.suse.cz>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>

On Tue 2025-10-14 13:23:58, Lance Yang wrote:
> Thanks for the patch!
> 
> I noticed the implementation panics only when N tasks are detected
> within a single scan, because total_hung_task is reset for each
> check_hung_uninterruptible_tasks() run.

Great catch!

Does it make sense?
Is is the intended behavior, please?

> So some suggestions to align the documentation with the code's
> behavior below :)

> On 2025/10/12 19:50, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > Currently, when 'hung_task_panic' is enabled, the kernel panics
> > immediately upon detecting the first hung task. However, some hung
> > tasks are transient and the system can recover, while others are
> > persistent and may accumulate progressively.

My understanding is that this patch wanted to do:

   + report even temporary stalls
   + panic only when the stall was much longer and likely persistent

Which might make some sense. But the code does something else.

> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >   	 */
> >   	sysctl_hung_task_detect_count++;
> > +	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
> >   	trace_sched_process_hang(t);
> > -	if (sysctl_hung_task_panic) {
> > +	if (sysctl_hung_task_panic &&
> > +			(total_hung_task >= sysctl_hung_task_panic)) {
> >   		console_verbose();
> >   		hung_task_show_lock = true;
> >   		hung_task_call_panic = true;

I would expect that this patch added another counter, similar to
sysctl_hung_task_detect_count. It would be incremented only
once per check when a hung task was detected. And it would
be cleared (reset) when no hung task was found.

Best Regards,
Petr

