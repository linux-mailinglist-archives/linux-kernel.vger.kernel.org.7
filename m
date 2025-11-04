Return-Path: <linux-kernel+bounces-884538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38527C30615
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC64F6AD0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2F5314A7F;
	Tue,  4 Nov 2025 09:56:14 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87A5314A65
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250174; cv=none; b=Uqhbz2WR+CDN2vup1zuSZV1u7nIxqgFNU0z8TFWO+5bSw7QCUNkT0kInVRGLb794hhIEHjYmPTseBVOAb92rqOohALbKbfsSgiVuxkjPur2i8ogLEvhB/mAK6HEB4MfO7eSucF83lhOTfGJu1Oa3+qqaTsd7h/fFTr53XBLLyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250174; c=relaxed/simple;
	bh=s/v44C08qo3NEk+wzdHA/0i4olLgrSv821HtD1MY3wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJmwYO0TNjhRanyWqfqBq0egRjTszvB9wxQuc8nOGKLpBylwd2ZgZ1ZPHOyYT/GWp4/49dVueOgw9cD4Z1I85LjCAa/jILYO+imqz0uWdK3RDbUVw4mafOn3qa8EIgh8ah7Qr8fwyRzCBcE3DCx6C11btcZ6GJOlC+CL+7yvtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso4229608a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250171; x=1762854971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj41B415PpfjCUvKti7BTLBASCuRFMjNJ72pcm7Vdqs=;
        b=UaZxQvsOKIWJqLKh2Yrglvs9raudSJIAF5rV/IiPf95gnVl3CnGCaWvTIBdXJ+AO93
         C6mUP6EtJPRK1byqYr45j1EP97qdWv8vLIOgElPlQs792zahIWZFIOLABccesZMqJHix
         vS9Z8NPYkbzOEpDSKQDX7hXv3RiwSA/Ac77ZVEpuhZlCFPnWJIcShzDpueVwwj6riVFH
         1AprOolfWdDRUQBrh9qlD8wlyarBLSkB86XUnYVTrcyLBnyEjGmW4ksAaLYsLd1do32Z
         H0yB9mFeCnosxGGDscMyDpUtv6c+2lS/RPiDl/ZlYUu2XxedL7URyLa/2hYhZmmnRxKr
         IDyg==
X-Forwarded-Encrypted: i=1; AJvYcCUSE8JebygBKRuWMEcmYK6k7mL4zUjZihcZI0Eo9jAp4vxKktEH/DT49UdNdEZeIZLQqqgOM+YpuaykSyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOau+Rs89WGcxbLkxIU/JfJY5tVmQ0i2W3ER3YUMyD3UmJ3qc2
	PKU7/NSTGjnwxwWXel5Hr12131yd1jz2FqoVhR1Ynu2Zt/p15sHcTCNR
X-Gm-Gg: ASbGnctVphHZ2JCHL7JesFZCsdqfltDSOkGCOqCVybhUhv1YmuGW1XadWM77Q/CogmO
	SJDi/iDZbw4zGr9d/ih5JQhN1cvLtwgjkqeipy+QfW7QSw7u9tl0ybGrRnrrQIfrOP2/lskE3qM
	PgmgT9pge2HEil2UViml2rF67AqbVaIx/0/7hd9Tcs1v8Cn2AVzWRYvgFRRaY7l9C4xBfrgITfS
	5MW6Un7PpQ/YpI+QmU3IjWZvtcOf+l/y1YPmlTq/4J5CD+gaaOdSSb/N0U9+kl+uzjYpG+RT+kD
	5smtHeC9IhFiykdDbH10Q1KwXJpSPBwuLwzkYhFhaf2ZAYCCeai6rsZgQ3UlmXoAXU2EpvuxzW7
	NG+76S0LPVmFSWDE8RmZIJlzoxocziulh1GoD2oje9RDn7rSMIpVEeJkdL8OgspA3mQ==
X-Google-Smtp-Source: AGHT+IGQrsIgWdnKXehEkvQ3PBvgGaRAUSCon4oVEncxt9sVA7qhbXuHrf4s2uHtsO7WRJ+x3jouhA==
X-Received: by 2002:a05:6402:510d:b0:640:bce5:77a9 with SMTP id 4fb4d7f45d1cf-640bce57be1mr6461203a12.32.1762250170715;
        Tue, 04 Nov 2025 01:56:10 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6805813sm1767268a12.14.2025.11.04.01.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:56:10 -0800 (PST)
Date: Tue, 4 Nov 2025 01:56:07 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <ofk6hbiz4wjux6k4zdlsfglvxeszlxl4at232wcbvlovwjix4i@7e6wfdsf66pj>
References: <20251027161212.334219-1-john.ogness@linutronix.de>
 <20251027161212.334219-2-john.ogness@linutronix.de>
 <aQN-NeWzlxtWDLXF@pathway.suse.cz>
 <87346z5u1l.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87346z5u1l.fsf@jogness.linutronix.de>

Hello John,

On Fri, Oct 31, 2025 at 10:02:06AM +0106, John Ogness wrote:
> > I am not sure how to move forward. IMHO, the original plan was to push
> > this patch together with the other netconsole-related changes. In this
> > case, the conflicts will need to be solved when merging pull requests
> > from netconsole and printk trees. Well, the conflicts are trivial.
> >
> > Or I could push this patch via the printk tree and queue it for 6.19.
> > But this might be too late for netconsole.
> 
> @Breno: This new feature only exists for netconsole at the moment, so I
> am fine with it going through the netconsole tree. But we need to decide
> this soon because there are a lot of printk-changes queued for 6.19 that
> conflict with this patch and we should get those sorted out sooner
> rather than later. (Note that the patch in its current form will also
> conflict with the netconsole tree, so regardless of our decision I need
> to submit a new version.)

I would prefer you do it through the printk tree for 6.19 and I use it
in the next releae (6.20).

I do NOT have plans for integrating the port of netcon to nbcon
in 6.19, given I have other issues to solve first (described in [1] for
curious souls), and I am still a bit stuck with [2]. Given all of these
patch conflict, these patches are being a bit serial at this time.

Link: https://lore.kernel.org/all/swdpckuwwlv3uiessmtnf2jwlx3jusw6u7fpk5iggqo4t2vdws@7rpjso4gr7qp/ [1]
Link: https://lore.kernel.org/all/20251103-fix_netpoll_aa-v4-1-4cfecdf6da7c@debian.org/ [2]

