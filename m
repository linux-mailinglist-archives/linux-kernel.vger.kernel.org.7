Return-Path: <linux-kernel+bounces-721430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 689EDAFC91C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D92518978F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C625A322;
	Tue,  8 Jul 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8pBYaIX"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87451C84D6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972422; cv=none; b=VddUcRjGGndA3x2VA2DPJlAiWthgxHx2t4ROhb/9lStaWq7Ubwn5D5GNYOD52e8p6gERQVDyqYoYNsJU36lDUK4jH9WNzI+BTqs1XUU81BQ3t/HD9RF6aen06YFQsAU+1OXCUURVaLbf43jDnV61KNn7Ts1sqevSVzzkjd5Xqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972422; c=relaxed/simple;
	bh=c4YFa8b9hzSI7lOxFkUPcUqmFuZYMY7yqPMbe/jObJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnTK6GaQNpTKNJlhL7GCzBgniU/m5TpCsaYY6Z7U0qbDlYdQ+JohUQTdP2RRnFsIqEJkC90Tt+NXYOpoKBM0YzRczg8YfJlmO+fsw/tVFK4pKmJDoZJgN7IRyzDbXOI5h7ncyQvawhKn+cvE2GMi6le7KtY2ML3Ou0RQZGpWKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8pBYaIX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so3473476f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 04:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751972419; x=1752577219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoBcid39/HWhBIm/dq+IPA85iXre01XminkyrWR8xLc=;
        b=a8pBYaIXPQrH5zOKh6vT3Rv06akctkrnUQ3jIhVB6EvdITr+saoXuhjb74et1XGF7f
         Gor0kUDQ5mIqnDPwo9dQOTmKGE04i78E+nuxgnVA/yEBDMpdXdO3xXgEHRB5DZA77fp8
         kFMxzwEBRkUzeE4WnqevgCoDUEphxi9IPk0aZ9+L3+9Rus1mLRBrzm28ymX1ktib+wAo
         cOALrOF/yfrFXi/AkCqKYQxBTj79s+P2Lj8XJ3wYpSgXZj0bCzfkvDjm+rWU+/WsD9Ov
         ik6K+BDjR0igd0MBotn3/Z0S4DhKydGSJ+Rzq3pY0qXU0BVBWsa/EbnTUPlZ2XCGbXVd
         2sYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751972419; x=1752577219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoBcid39/HWhBIm/dq+IPA85iXre01XminkyrWR8xLc=;
        b=hngQ8pYYClzIlt+KTXTAX2hQmwvdI9tw77zPg883J2Ph0j4bkp8hv0s7a2YH2DWL26
         f+R+01NN+5gioIiBbyEhLordc9xa3fZEZdrfV7jSt/qalBWcGU5BGJccLpLY3SdkObld
         TD1DilcFwxQUe2PhzVaod3TS/jrP9crCappowF190ip9CpBdqQpbe8QgKPjoTivz38u+
         dfREEbZaeWqyvV7C8E1jBt7kS9GJ+Q4XBn7Pxd8n9WP8Bwj2lIMf14n+vtDquK9qWelJ
         B1bOjYTWkNR+y+MlDKNYKKM8x2kJt8qwp6bGYEQPGLRl5CWkzk2J0fVXyRDuTqJ7Zv4n
         zZGw==
X-Forwarded-Encrypted: i=1; AJvYcCXZhk16M5n7MPhQQKkP72fzQ4yzLiyBX/gD8eeMaDF6TQSInAoWbYSMDVkZzh41y71poDIHb9hkLs3ABN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFoT19kMfxRPknFyY1kmrEVWKuKDfI3TlDMRGQdFrKqQp6ryk3
	WAs1Nl2dvWazzUATmt7FaG4zd94mXeP7t543VDpwv6IsdQZVQCs4Dxjn
X-Gm-Gg: ASbGncv14P/cxmRBcVKGfkIUO8aYzph9abm0HGa9p3dHzjQZU5RR01SMdlz2y32v33W
	X3h8EtMylClZfdPw2JMYvyTh8tDX5PGqMWVLL3na+UgUh5YFb0ibn5bKeXSrCbSUS/mM3RDzI6T
	e0ON5DOndjfe2Du3fnQ5UtPe9bim8XvlZkuw+W00I0lAiGhRlhMShjD62DPvruyL60eJXG91CRo
	BOnW6cjfQuEfZLgfC9lu3CWG/mv08/iaG8GAttj+S/869Udd0K+7ARh5oDD39DB4PuK+5Yy6I8D
	wcYVxR3TVtMOquqvXMMWBjwwU5JteSpoZgDITlyBne+FADzXBSRR0xhQ0UVRaixpFJiLNprHugL
	d5aTpsXUFZyESZPfx+w==
X-Google-Smtp-Source: AGHT+IE7YAKMD3vOtpei+l1IjmVHqRE52P89BTGI45VF/g44zT0sRMWmGN3i7eH+KQHLe86JAT1AtA==
X-Received: by 2002:a05:6000:642:b0:3b4:9721:2b13 with SMTP id ffacd0b85a97d-3b497212d88mr13614365f8f.14.1751972418802;
        Tue, 08 Jul 2025 04:00:18 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b975efsm12453659f8f.46.2025.07.08.04.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:00:18 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:00:16 +0100
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
Subject: Re: divide error in x86 and cputime
Message-ID: <20250708120016.4071595d@pumpkin>
In-Reply-To: <20250707230057.GC15787@redhat.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707182056.66a8468a@gandalf.local.home>
	<20250707183331.029570bf@gandalf.local.home>
	<20250707230057.GC15787@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 01:00:57 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/07, Steven Rostedt wrote:
> >
> > On Mon, 7 Jul 2025 18:20:56 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> > > I would say this should never happen and if it does, let the kernel crash.  
> >  
> > >> [78250815.703852] CPU: 127 PID: 83435 Comm: killall Kdump: loaded Tainted: P           OE K   5.10.0 #1  
> >
> > This happened on a 5.10 kernel with a proprietary module loaded, so
> > honestly, if it can't be reproduced on a newer kernel without any
> > proprietary modules loaded, I say we don't worry about it.  
> 
> Yes, agreed, see my reply to myself.

Except that just isn't relevant.
The problem is that the process running time (across all threads) can
easily exceed 2^64 nanoseconds.

With cpu having more and more 'cores' and software spinning to reduce
latency it will get more and more common.

Perhaps standardising on ns for timers (etc) wasn't such a bright idea.
Maybe 100ns would have been better.

But the process 'rtime' does need dividing down somewhat.
Thread 'rtime' is fine - 564 years isn't going to be out problem!

	David
  


