Return-Path: <linux-kernel+bounces-882665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9B4C2B13A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A573A83A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386CA2FD7B9;
	Mon,  3 Nov 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YS4zi81W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqpZMSq5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CD8405C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165982; cv=none; b=oBYJokVbTgrxVxjYyPicTBdhwmx1hHuiCvEFgfYfPUdj/iySg1q31LFPE/OwlbI/zr2tHSA5wHbU0KCaxYmUZ3eS9DQsPepWJ/TpdDXnoelqgfv+gN78eFC0ESOTm08OfYr3Y+cHH7LqCSvqX/nMCrDF6YdOG+zd9s3Ssa0g1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165982; c=relaxed/simple;
	bh=NJWxjZIgxKiEsG+VYDdILywEUI+xo//LsBQwW/F2dgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWIreYWQc1hB6kLNTqghjmt62JcuCLA4tVJ5eCmUw0KeemXDpi6YLGr+uYhO2N4x2pr8FEiva/w7Nm/DGrJpmrln1U/DSPD2XJC8vzxt31iqazD/QGvgdu+1FGai/XZKC/U4zPt00nhtqnS/UUcQujOodRRFZ6ln7UJu7UIHN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YS4zi81W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqpZMSq5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762165979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGMLIFNYPehIWSkWmdrlUtLmtax68ZJ+M72mm5/cyRQ=;
	b=YS4zi81WUBwfGotcr8vZdLxAaKONg9xbX3kn5JLDRxJD9q+hRIga20tXZfWLtRKu3DjMFO
	L4F5DfPQMKFGat17sV6zsh5Dkg1Q+8IjRTW10B8tfKl+r3z49wGD8nKeDuEnt0H0Nj2ntL
	inI2MG0vAzqXOJFkkPZHHvnIedfrHis=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-LDcj6VQ4OCWZsEyF_Xv0nw-1; Mon, 03 Nov 2025 05:32:57 -0500
X-MC-Unique: LDcj6VQ4OCWZsEyF_Xv0nw-1
X-Mimecast-MFC-AGG-ID: LDcj6VQ4OCWZsEyF_Xv0nw_1762165976
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c17b29f3so1793407f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762165976; x=1762770776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TGMLIFNYPehIWSkWmdrlUtLmtax68ZJ+M72mm5/cyRQ=;
        b=TqpZMSq5U5MgJN5SERcYMIvOBsVUrNmDN4jsikWrpTkHRBBEYcESXriC6ZgN/N/J6O
         qv+Iv7eEQZCRfPaWXywLILkQwUGLWfAYCzpKmdgvoT7j3cyg4jxd4rPP6RVeS33Ov3qa
         y7al0IkJKce71ykMMTNDH/sdYa/12qPcrIkXqDZsP5QSDaCZal0xccyTY2khE0xcpHE1
         QSpA4qSrQKT3w8iCNhae011YcOM0JrPipZZgpko/mJ+PalR6WXqn+pJBNMUy9uN/KR9K
         EXJ5sf9LtWKf7AZOOaowU8r2YlaBVOpwK6RU/BXkVohmmL58a2RgqZNDGZEyaOMStVc5
         nSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165976; x=1762770776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGMLIFNYPehIWSkWmdrlUtLmtax68ZJ+M72mm5/cyRQ=;
        b=g0/L7RL1PdfYqv7D+vRCr7t1qGAAEOm+k54LAFtKzS4POvlfMLGOXls3ty96gaYRrQ
         MgPGeQ0ugLkdz7EyPfnLS2XUiF3BKGbpXeqvr2NT744hs3VA2QoERHI6SprR2AEMKLtc
         VQ+MQaL7td9A8KWWFoBA+h56S7abHWa7DtmhDx6Fsb2XAyu3LXRfBTuPBLIWIukKl2tb
         Qwv22mZkzw5eemy0SwnGHGbFdXa7SILy9mzWUa4iXZoMz1nXb9OlTSgqD5WPSQvFnxt0
         NqqJ4/IKyuje0CaSYeBCPKGmlDwo6cVYJVfpEv9gVRpUDc+28A9gbOpyXFlPpEYIwrd9
         vhsg==
X-Forwarded-Encrypted: i=1; AJvYcCUEnD9izzFCvwSOrEUFD0kbCsV6MB4p71vd0nX3/69lguJMYJ+h1RzGcolsNuhDFWd9QS0X3BlHEG2HzMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQV0gx8SHxwbe+8WfxkIpmhvzmzbssM8YfHpfdWSRSeEF80hFG
	oB/rEYbQOdiRqUkNOYtfJb43ToL4DGuoSbjbwVZQAmpDleWRhl8RG53ETAmyjI69Q2XwQ4VvOCd
	6ssDWcttAdjYYTv4GhmW4tbIGMe+n4Nq73G778NZR5rNFfqQU3WG2CLtC+4AU5DjQ3w==
X-Gm-Gg: ASbGncugXd5iI5xhU35YWnE8ubESLz8uRygLURV2oEfgt9sBEMX62qWUy/6KZPRaWv+
	dT8gJxkSEVmKSsuU3adaqgsDEKs5rEuuY6uLHTWQjE+m2+h5FozWj+bbL+wLgO5XmhePheI8QqW
	Ge3SxvahQqJMDg2IOrxnqxrjeDcIU0RDbPJLAPAw/asDA4zS1nH6QH56h4NQ3BDdH0srlZBy/Sn
	wSZ8tkZky2eKOrYSfZwkLm35ByLAPy53MUJQfTWUdIiLsXwhpgpl2/cS46EkZhz1KrAJ7p2Sp6d
	T1nxGKoNtNwHX1wNRwbHsNAECtRIp6lBJ169/ZmckWZdY06hBMvcBZIu0+7A3wBaZbSpMFCzv1p
	cKOj/O/m60v22qZEfGA7PVMrtcf9ypg==
X-Received: by 2002:a05:6000:186d:b0:429:cf88:f7b2 with SMTP id ffacd0b85a97d-429cf88fb45mr3606313f8f.45.1762165976236;
        Mon, 03 Nov 2025 02:32:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa+wD6iJ8nDCvkLCznYWc5HmA4nh5vuPYAXNrQG1j1xrC44jbUcJ/iuNU/X5dzK4tWfJUlFg==
X-Received: by 2002:a05:6000:186d:b0:429:cf88:f7b2 with SMTP id ffacd0b85a97d-429cf88fb45mr3606276f8f.45.1762165975802;
        Mon, 03 Nov 2025 02:32:55 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec2csm147991395e9.11.2025.11.03.02.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:32:55 -0800 (PST)
Date: Mon, 3 Nov 2025 11:32:53 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: luca abeni <luca.abeni@santannapisa.it>
Cc: Yuri Andriaccio <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v3 00/24] Hierarchical Constant Bandwidth Server
Message-ID: <aQiE1ULtInJS6X4R@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <aN4_KE-5kOCbpQux@jlelli-thinkpadt14gen4.remote.csb>
 <aPYDhjqe99F91FTW@jlelli-thinkpadt14gen4.remote.csb>
 <20251024100227.6ab1bfde@luca64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024100227.6ab1bfde@luca64>

On 24/10/25 10:02, luca abeni wrote:
> Hi Juri,
> 
> On Mon, 20 Oct 2025 11:40:22 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> [...]
> > > > - The first patch which removed fair-servers' bandwidth
> > > > accounting has been removed, as it was deemed wrong. You can find
> > > > the last version of this removed patch, just for history reasons,
> > > > here:
> > > > https://lore.kernel.org/all/20250903114448.664452-1-yurand2000@gmail.com/
> > > >  
> > > 
> > > Peter wasn't indeed happy with that patch, but I am not sure we
> > > finished that discussion. Both myself and Luca had further
> > > objections to what Peter said, but not further replies after (which
> > > can very well be a sign that he is still adamnt in saying no go
> > > away :). Peter?
> > > 
> > > https://lore.kernel.org/lkml/aLk9BNnFYZ3bhVAE@jlelli-thinkpadt14gen4.remote.csb/
> > > https://lore.kernel.org/lkml/20250904091217.78de3dde@luca64/  
> > 
> > I had a quick chat with Peter on IRC about this. We now seem to agree
> > that a third option would be to move to explicitly account
> > dl-server(s), correspondingly moving from a 95% to 100% limit. That
> > would also make our life easier in the future with additional
> > dl-servers (e.g. scx-server).
> > 
> > What do you think?
> 
> This looks like another good solution, thanks!
> 
> So, if I understand well with this approach
> /proc/sys/kernel/sched_rt_{runtime, period}_us would be set to 100% as
> a default, right?
> 
> It is often useful to know what is the maximum CPU utilization that can
> be guaranteed to real-time tasks... With this approach, it would be
> 100% - <dl_server utilization>, but this can change when scx servers are
> added... What about making this information available to userspace
> programs? (maybe /proc/sys/kernel/sched_rt_{runtime, period}_us could
> provide such information? Or is it better to add a new interface?)

Not sure. If we set it to 100% by default (as you suggest, which makes
sense to me) I wonder what would be a usecase/need to set it to less
than 100% later on. We have the debug interface for tweaking dl-servers
and sched_rt_ interface doesn't distinguish between DEADLINE and RT
anyway (so no way to leave some "bandwidth" around for RT tasks).

Maybe it's an interface we want to start deprecating and we can come up
with something better and/or more useful? Peter?


