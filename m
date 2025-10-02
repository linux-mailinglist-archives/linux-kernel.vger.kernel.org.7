Return-Path: <linux-kernel+bounces-840287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1CBBB4080
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFA019E0BBF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60363115B1;
	Thu,  2 Oct 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un3XRnPO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E22D1936
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411788; cv=none; b=S1tC7pIqIu7OrpxnombexXDft1s16vEHK2OvvQIN8+GD5QavfVlgd9H8ryQbaF+mBMWp30ZYjzw/CmZ1bWrnTwjPajZOF4DRRmoO+QKM1F5/jq1pmeKY2quNWVTkJQSG/L7qkIrUADbMzfSHrFA1xA69BoJ29i2j0Viai1QwPoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411788; c=relaxed/simple;
	bh=rc26i++7Pe4Y9VMQrl1bV7VtbMfaf8x+SZyX2riM5uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZR3ySa1uKlbOvTnpsx8F5wfKHFKZ+lYDrQxNwTgyQYPR2y/gLC4GRZM8cmyLAhGQWu4ejVSjb9Uc0wsC87mr6D1eenp7Wq+SzkS6eJfjSCsGt6g9hjqnsF8go2uQdh3S9FWs5Z1D8HdYCql2Q+n88mgz+DeYrGMDJvdF8+IRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Un3XRnPO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759411785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qi9+7Ix/o9+0OE7Ro2QqAP5ZD23WvzNBFZaksF/or5w=;
	b=Un3XRnPOXBgfbeYbqA8uQISUByem4yljgwfI3xgytz/9zcIaqZ8mDrcIecDiCY43YZSLdi
	Xhxqdou5J6dR/oefpwBDcXW3KzsdVtu8TCC1lMjXGs0csSkwVp5Kl+C73ZmYJCGpaKYm25
	ZVYL6Geuqw9M7wnwC1ie1cGQoqVtryA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-TUIVsiixPwaNHjRgs6rsKg-1; Thu, 02 Oct 2025 09:29:44 -0400
X-MC-Unique: TUIVsiixPwaNHjRgs6rsKg-1
X-Mimecast-MFC-AGG-ID: TUIVsiixPwaNHjRgs6rsKg_1759411784
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de2c597a6eso38190091cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759411783; x=1760016583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi9+7Ix/o9+0OE7Ro2QqAP5ZD23WvzNBFZaksF/or5w=;
        b=s+BhQflZaW+aR4ImHWM01PpXh+3xepKKjKF4U7E83+XbLmXnkS6nvmXnzMyiRhdFND
         lJqOg9sG52dg9tK6vVRVyzzm1JDDfX+0IkFhzeZpUDSzMQXe75oF0iZx1psWZW/J3F/C
         dOJAxKCyY/9aDqMhLLbdl7tP5z42ORwiWjes/WkFVnqk2jfCWfCfgyljfUJaQiRcAi0I
         6RV9l9Dc5wYoEfg9vQ+Fg3s2yKGt/obPkDDBtypAyS/kkeS2n90FDq7cVBn4ANOhFWHm
         TnzfDGyPOqQ0SD6MiJk5xBTaaTVDBag9oO8/aLJ0C8kI9zImXFeUeUA/0dDbtPzGttLz
         VpoA==
X-Forwarded-Encrypted: i=1; AJvYcCVh4dQgfk2GCFiL6qg0AOvyBFCDDMmtrWRjcL7yiPY5jVlVXqfq8kkbHOCmMxYHfzMU5nnewBqn97uNkdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXW/aJoQ4BzlrLoSUSgjchFRoayGnQn5ncY+wT8IK32XytqaPq
	k8giV637kZ95ZI4cCBTt6JE3IbEIUI0J1AMRuonVBQt5/rKCiVPSAVliT7cGxh0bPiHeGz/YQFa
	YU3nbuoOmbxnBtBBGtGCqV6uenUUp1dsFo/g18qZXP8PlUrp86FV8jAZd72BhEoJX4w==
X-Gm-Gg: ASbGncuL8zLF+I2XLtlbV5inz4cVK1bTILkldNryXN324me6JKZaRfZz0F1Nw2Dbr03
	R+5dXLqfaUrcD2ksnv0kGS/xK+ZqK/dsLEqA3scpFp61HZHDgaqCroi5FeUGFXlF/S7e0uSs/LW
	S8rPCEIoAgOqvIMRrEhPK1ACMFBIMA4TGJDcDCFH034aQHvpdrYI00P4FJ703LV6BjSfe3GJP5p
	axC1JIjVB+DgBlGm9GUwwGOzRXM0V5hkGpjxZ79oAGIy+fSOZ/nulEIfl7me0vwDBLXQjG4TJ+W
	3DtsX5JPN3/ft4vjB5H87RV5j8hdZBYx9gGgP7yPKIRjmbcMITLvOG+l17GDQvCKdxJQOwL2UPa
	gCjh58c9TkDCqLDBrW5JV05QA
X-Received: by 2002:a05:622a:83:b0:4c7:9b85:f6d4 with SMTP id d75a77b69052e-4e41c352a55mr95354091cf.22.1759411783689;
        Thu, 02 Oct 2025 06:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsbkMJcPahXE1fYKWHrYbKS/hIo5rcFpkc8qWfGQ51JqrZdpR70GGnHy1u2Nz8fuNUNUZm5g==
X-Received: by 2002:a05:622a:83:b0:4c7:9b85:f6d4 with SMTP id d75a77b69052e-4e41c352a55mr95353771cf.22.1759411783202;
        Thu, 02 Oct 2025 06:29:43 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-6-60.as13285.net. [80.47.6.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877725550e5sm210853085a.22.2025.10.02.06.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:29:42 -0700 (PDT)
Date: Thu, 2 Oct 2025 14:29:38 +0100
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
Subject: Re: [RFC PATCH v3 02/24] sched/deadline: Distinct between dl_rq and
 my_q
Message-ID: <aN5-QmILMDZgnU4s@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-3-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-3-yurand2000@gmail.com>

Hello,

On 29/09/25 11:21, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Create two fields for runqueues in sched_dl_entity to make a distinction between
> the global runqueue and the runqueue which the dl_server serves.
> 
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>

The change looks good to me. Maybe we only want to be a little more verbose in
the changelog, e.g. the following?

  Split the single rq pointer in sched_dl_entity into two separate
  pointers, following the existing pattern used by sched_rt_entity:

  - dl_rq: Points to the deadline runqueue where this entity is queued
  - my_q:  Points to the runqueue that this entity serves (for servers)

  This distinction is currently redundant for the fair_server (both
  point to the same CPU's structures), but is essential for future
  RT cgroup support where deadline servers will be queued on the
  global dl_rq while serving tasks from cgroup-specific runqueues.

  Update rq_of_dl_se() to use container_of() to recover the rq from
  dl_rq, and update fair.c to explicitly use my_q when accessing the
  served runqueue.

Thanks,
Juri


