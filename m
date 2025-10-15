Return-Path: <linux-kernel+bounces-854428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1502BDE564
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E7535046DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D900323407;
	Wed, 15 Oct 2025 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRwJoJrN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140632C028E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529102; cv=none; b=X5r/3k9AMYPskyeHqcLmhqq+LS9e3jcJe01fHwKAMgsyxliNcj95lKoRpQ3FG/IyPGYdaBsCVKqXxd63zHT+IxcJ31DNG5AN/MVs/P35zYDAs/g4/Z3iQ2lZi630AIIjJeEBPKC3nM9EjpGorlO5ku8bhWJNVmU46VVJZnedXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529102; c=relaxed/simple;
	bh=2vcwISJ9LreMt7RXyx8ZfrkJ84upVMOetIH2sQJdlVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiLRsdkfBKJ0trpipZoYv4JHehM3BNP8w4vtOYr45yEvrsewv5gJjJQUxMJ8nvUgQdsDe5SHAqTqzupRlWogb9tGJQARjINMLDXJ05eTdCTityQcmAkZPn44PYv/MOMWYURYT6phurmaufH6lPXjB/oH84S6eHQfJ76mzoTQMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRwJoJrN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760529098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dgjPo3RgYTe44Gp9+99ijo+aH03cLKv/GPAev8R5rYc=;
	b=SRwJoJrNjuQV7R7mLh1jAEQIxjBi9ICYhEAhBna79QytzgLAxMP0QT2BRhmkgOu1zl2BRE
	4+onGYD9ng+kPTvq/rqFVMCJVY800SqLZry1v7f2tCrxr16NCgR+L/NFMdfMTc/Art5wFS
	4dcVcQa8Z9S4t/f1o1ZBNEQ47GHt7to=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-RSoZRf96PfmDVsOJAK1mQQ-1; Wed, 15 Oct 2025 07:51:35 -0400
X-MC-Unique: RSoZRf96PfmDVsOJAK1mQQ-1
X-Mimecast-MFC-AGG-ID: RSoZRf96PfmDVsOJAK1mQQ_1760529094
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f42b54d159so6469111f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529094; x=1761133894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgjPo3RgYTe44Gp9+99ijo+aH03cLKv/GPAev8R5rYc=;
        b=ZM88syzynw/6unNGW1CGY419yr+0n8QDOUc/3+OGAl5//Doitj4vfSyfMXLa96l8bA
         y2HseYJazjYQyiUU4QBCP+SzqpwuU0xWZAGwJWVGPt/o7pB+2JUdwIlbyoRSKLnId4Jc
         cx7S6dQtgKJ5y+SRUD/NoFXne36OlcZZ8fL2FQy743l0VHAWKlnjtN9YTzPWlzFDlK3p
         ZCOqgfx+9Z+VeCy7kxTz1egv5iChvidwOEO7u5QP+GdT2vDjA+E9Lmg/nv+SKp7e1Ss1
         lrfT1JPdfxtP//EIKpgKKCG3dWr4tLL+IWLXEQuOrlqdJik3YBv7kC/m4IgqnRWMmimM
         J7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXiF2iDZ/fwGcNQlScUCsV7hKg5GjDmZSsVsq4atqf88erZDKJQPP/xErkBMgFoWl0A+SClQo6J50338kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykndVy6wV8cK/eu3ClhLUNPmcyh7SCccyCwQ2F8xolZxbYtUIg
	wuoD/GcQBoy3ZxeSFlhFEW3FN5SkLNKk/yKSCyoax7sOXkFjQZA7dTXhLJyNr/jRqshBWu5OsNx
	S7XIJkIPRGyFnGvrhYe8bBcdWM3QllD01EcwvJXTgsuV7jFhXOmFzrlIlloTiSZ6AVg==
X-Gm-Gg: ASbGnctV3//4KZWQjfUn/JuONLl4WY565m7q+LUsrXBNradNHco70HJ6KrbXT8Qd2wL
	tG2q/SVSLcU5rzauDHFWzgh3ge8Y7SW4mnrDebmw9+sCE/J+8HxlWbRXtGh6asU2r0QPT0T63Ym
	VNXFDuv3BF3H+/sXe+fCtr2ZEHBTDaRkPLssKNhYjyZHSpiyFGnJBaJL6+7H0cdT6Q9cj+pLBfc
	sICVlrjBYMlltZeU49Zv/LiYQOe4U02HDrizbOwJCfS7rrW8B+c/pnoUoyGEVIaWZDysUjTAoRB
	LwhNmR2LqnhkrvRuU3TLTImTra83FMzk37JnSD8Ct6nAxtbm+MjS6iXnifDvHG4jU+giSbGs
X-Received: by 2002:a05:6000:608:b0:3ee:1125:fb6d with SMTP id ffacd0b85a97d-4266e7ced08mr14564258f8f.9.1760529093850;
        Wed, 15 Oct 2025 04:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEutVwlzePECt93YmeVvfMvecxD6UICIwRyzw2gXJjm9qCImvJba9O20JkFFLPcti+xCnVRw==
X-Received: by 2002:a05:6000:608:b0:3ee:1125:fb6d with SMTP id ffacd0b85a97d-4266e7ced08mr14564242f8f.9.1760529093446;
        Wed, 15 Oct 2025 04:51:33 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e10e8sm28713219f8f.39.2025.10.15.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 04:51:32 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:51:31 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v3 17/24] sched/rt: Remove support for cgroups-v1
Message-ID: <aO-Kw2BQ24_Pp1Xf@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-18-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-18-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> Disable control files for cgroups-v1, and allow only cgroups-v2. This should
> simplify maintaining the code, also because cgroups-v1 are deprecated.
> 
> Set the default rt-cgroups runtime to zero, otherwise a cgroup-v1 kernel will
> not be able to start SCHED_DEADLINE tasks. The bandwidth for rt-cgroups must
> then be manually assigned after the kernel boots.
> 
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---

The change looks good, but I think this series is currently missing a
substantial Docs update. admin-guide cgroup section and scheduler needs
some changes, I believe. Please consider doing so for next revision.

Thanks,
Juri


