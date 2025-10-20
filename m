Return-Path: <linux-kernel+bounces-860500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B95F3BF0451
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E6793420ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1837B2F9DA0;
	Mon, 20 Oct 2025 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqo8gXgO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB52F90F0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953232; cv=none; b=pzcdt/ZeI+bLY6OAOtvaoSd0Uz2vvRVp5VzNBl4tR7OMfYPvCIObXqNTt51MQ+CAcqYqJbrNz4mUeIVXkueJ9eELkw/i+1v5S8pokXz9XvicGzRLL4PKHuY4oc7tf8Q8YXWBfeV278a2lHiZHVyf5Tfk3r6AciJhGKz+icuQSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953232; c=relaxed/simple;
	bh=VTUnInoJmk9GZJcnn6m3cE2TWCPY7c9v08O7zIApNeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM+snL06OMITmeRRpMDaTEG415K7T6XOib6lLkmCpTLs9/WtTWVz7KidA+jXS1OREXfr+lGea0uDy4DPxcfRD06RGZL21rDww23WFAzhRVUnlC2OOPLZ8YQSsZ8gfzquJ0o99ZWZULro24GY4YU2F/d6eSyLk6w/Mb8HmynMNtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqo8gXgO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760953229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKb2gQzDVo6bNY4vG222qHm4HvmbCYNI1vD6W+Izvo4=;
	b=dqo8gXgOp6efNjU//t7+0EOM39CbVQWocncRPm0o5vuyyjE+EwP+WBoReRFixRFE40sqi9
	1BqIs0H2AYNbtC/AVqLxgH/7Ar6xuGQj/YJWqyGabkP3W9uh2X0tIGrw3XZ7sBTnyFTdZb
	vessQx7ozAEnAaHhQDwvZot9eaBnoAs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-zJsNDEePMQ2-BJPI3gTllA-1; Mon, 20 Oct 2025 05:40:26 -0400
X-MC-Unique: zJsNDEePMQ2-BJPI3gTllA-1
X-Mimecast-MFC-AGG-ID: zJsNDEePMQ2-BJPI3gTllA_1760953226
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47111dc7c35so26103375e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953225; x=1761558025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKb2gQzDVo6bNY4vG222qHm4HvmbCYNI1vD6W+Izvo4=;
        b=BXW6lGkwQz1WyyeoDsi6DYIChHDaWoPhPMlPwxLSribCtFnJSC67f/Rp8v+aC3wHNZ
         ioZcge3dc9D1GapK9St0N8EADPVB2UZ+tLir1YtHBkj+YmD0+RgsevCKJCocMXCfyqlS
         vY1VKCE9Iq+cg4bf5WNCMniVLPe+azqDUPREUnS7LCjQZHEH+dpG4qJVwGAv6oBXdMH+
         U2TAHUvW6LbmUG3TTA/w/GjdwnWnw730Sni9zBrFymbECVVqgxXGNSrWJCEXQCKbNYAP
         b8lvcT+8uaADF4qq33gKJ56a8A1dttbcwmmIg4fSWOLakFFYhsgBdQm8jbPvw8Hkw++e
         UTWA==
X-Forwarded-Encrypted: i=1; AJvYcCVKFEqOuwBVIjMAjrHCV7+wKFDPt14Wqb+wsXJH+17fDiet7qyhRKEWwcdmmZBaq7veeF4vH098Jahk440=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BNysozVmurpXehSBPa4IxVxnYzHxqet0N+9iRFB3ykQMYJPk
	8ZU04Ri7UtRkZiFEqnSPZRNH1g0O9SNyc4wfsvTb4QzgAYSWHEbKThLLWcQr62bm/uc5zgYtvpx
	PKYQi9ePUUcWoZtolQoeT7CUg5zwiY64tkCcqeQsyTNOSK9MsZLq/ZpOjpSDnU6pLXA==
X-Gm-Gg: ASbGncumWqpn3mYD2C5pYlBV+FDFOp30hJkZU8g+zqBPeSSz4CXDmcT+WN9CCKRulBw
	mbTQQB6LzMo+EzVYfGh/1BTNzFOvE8qjKj1dD5aj6giuo66+Z4YhEj6Uub6o3xnQ19/38FCjZjY
	v5maElPosNTjkNik8SOJz0K3SnFLXmQB2Fn1gF26ATbHc5kf7h7LINf9GxLpWDPGRFsNB25gqMc
	NEqi2gA2ACTkJu/aWtv6NkLxJ9UrVaNi2HI5NuH4ybZohbBhQIfHCIH7tWtr4S4Ld6yPDn/kMtb
	byR6OxFu6O7vqCP6keNK717rTYz9B0ErRW08WmtVA+AolbQS1ohoHmGws0QJNkV5lOXrwt5S74n
	QN2Ie4dVCA9khv5/s/1anwa9BOGAy90Y=
X-Received: by 2002:a05:600c:858c:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-47117917bb6mr82566695e9.32.1760953225580;
        Mon, 20 Oct 2025 02:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK8F+GqQ8zW3Xhikabz/d5iU4X0cDrsMvQLTZk1Wk95dGjkhJCo9kNuH9KNgoV+qjD8ThxQg==
X-Received: by 2002:a05:600c:858c:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-47117917bb6mr82566535e9.32.1760953225218;
        Mon, 20 Oct 2025 02:40:25 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm140662125e9.6.2025.10.20.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:40:24 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:40:22 +0200
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
Subject: Re: [RFC PATCH v3 00/24] Hierarchical Constant Bandwidth Server
Message-ID: <aPYDhjqe99F91FTW@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <aN4_KE-5kOCbpQux@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN4_KE-5kOCbpQux@jlelli-thinkpadt14gen4.remote.csb>

On 02/10/25 10:00, Juri Lelli wrote:
> Hello!
> 
> On 29/09/25 11:21, Yuri Andriaccio wrote:
> > Hello,
> > 
> > This is the v3 for Hierarchical Constant Bandwidth Server, aiming at replacing
> > the current RT_GROUP_SCHED mechanism with something more robust and
> > theoretically sound. The patchset has been presented at OSPM25
> > (https://retis.sssup.it/ospm-summit/), and a summary of its inner workings can
> > be found at https://lwn.net/Articles/1021332/ . You can find the previous
> > versions of this patchset at the bottom of the page, in particular version 1
> > which talks in more detail what this patchset is all about and how it is
> > implemented.
> > 
> > This v3 version further reworks some of the patches as suggested by Juri Lelli.
> > While most of the work is refactorings, the following were also changed:
> > - The first patch which removed fair-servers' bandwidth accounting has been
> >   removed, as it was deemed wrong. You can find the last version of this removed
> >   patch, just for history reasons, here:
> >   https://lore.kernel.org/all/20250903114448.664452-1-yurand2000@gmail.com/
> 
> Peter wasn't indeed happy with that patch, but I am not sure we finished
> that discussion. Both myself and Luca had further objections to what
> Peter said, but not further replies after (which can very well be a sign
> that he is still adamnt in saying no go away :). Peter?
> 
> https://lore.kernel.org/lkml/aLk9BNnFYZ3bhVAE@jlelli-thinkpadt14gen4.remote.csb/
> https://lore.kernel.org/lkml/20250904091217.78de3dde@luca64/

I had a quick chat with Peter on IRC about this. We now seem to agree
that a third option would be to move to explicitly account dl-server(s),
correspondingly moving from a 95% to 100% limit. That would also make our
life easier in the future with additional dl-servers (e.g. scx-server).

What do you think?


