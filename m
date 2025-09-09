Return-Path: <linux-kernel+bounces-808449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C581B4FFD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A684E30DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D162521323C;
	Tue,  9 Sep 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="uoFZINKH"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD61DDE9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429138; cv=none; b=srmfsf7gprjLlJsSA2NUnO0dfT06ML584m39KMZO2G9LqQ+AosqACNCCrtm4Dahs8kQsG3hD2oZGccqR88s9rPspNrJOFcGiq3lidUUaeaX9UOR12IfD3LTgN7H0pc5L8mTPGvbqUHR3s8EQUGuGQRe+nTK498efhwDiIhr3NME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429138; c=relaxed/simple;
	bh=Qpv2AjHQS/vKSY2OMnr2h1mECXLrrGaCzpI+HbMbcew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjuM5Hl2Ut++VG+hAw5kXdnylgoSs3C5hNW8HtBZqrPKBmIRFvriDCUahVOiDYtwBaXEOXgx4pXOQkQaLkXoGUuTLsqG3EPmAuKnqUEfJ3o/L/FmcmwbW9jnCf/Vf18IN1lisFbHPfN80b16fSXKFw9tnsn5hfgpilg1YYJiBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=uoFZINKH; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b5ed9d7e30so48240311cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757429133; x=1758033933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uZOXLAPyRyHSpVnROAOaZtIMYIq6zL7rLk9iGSlTxI=;
        b=uoFZINKHBcGp1Rzm1iPpdl9oxOZRYVol09dAi2Dnt5y5r83hcUbSRFtXKlcXLsfX+K
         YMcpya0vI/PLffZO8Is7k+l3c7dazClT9N0NcPkcH7shsloduCqw5xixpZzEuqMmfLT0
         07LXvSDRg0eP5Xzh4vdVt8HsDzK6j1fRP0oGoRDi0KzovOUxAfn/ez/uAS9xiLxmwKLh
         b11QD3v9pOIa8IvVXdR0BRxXNIDclkWcWt3bMi4W2+fOAWxpxnS5kCph+jcCIcF8AVBW
         JTriY9SMA64hZG8JsP29AVaAgYcg0/ahxROZgoT4iEb91XN27tpuWrki+WYQs51idfe0
         lZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429133; x=1758033933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uZOXLAPyRyHSpVnROAOaZtIMYIq6zL7rLk9iGSlTxI=;
        b=M7FKdN9pf6d2s6F+bZb3zX1uj//n994lP2AYja1BQFjDz6V8pWqZTxwVMkJMH3j+Ej
         V8iES/5tWdx6xFAOLTcDVkegz0uWnwQGMlcOzKc6yzWWyUajcKm/M4eKHJLfOvRh8wLd
         sTHraS7c/cYS34U8ITmW+wD7IJRxn5vMkDB0Xp8mzhi4owl4ScRZ3DPt/h1qk1FGr8Ug
         KjrC4hxpKau7SNNDUDrkQ71A2/mZi2BCyLsRVZZ1fvWDQq9AtYW1NlEY2vUG3+8pmdln
         wOGiZ+iE9NybKNUUcCkf8Tqw8pMhFyYGjONECt2ZlyHmUdI/rMRz23cLlk4jlFuk1nEf
         Yr/w==
X-Forwarded-Encrypted: i=1; AJvYcCVxDBuSGu5vmhjrPF2TDFrxv9cjlEhMlNBU5Z/ccnVTVAoRu+gGwdaRKIRarD2oSz/MN/SeY6sPqdp7m8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmha/xDSazP0dreTLU6RzG3fXNxdbjLd+klhMtAJBcZvKMDOlf
	QyINA3/2B2z+njWDXM60sGKnQ5xD7l47it6NE1KM4ghqd4sI6Mb/YjHqEOYWz6B5Shg=
X-Gm-Gg: ASbGnctJ/CO0DbOurl0wReQQpg5OXVAazaCATY9YAWPJIh6e+MmrFqRyAYa0Fxhibgb
	R3CzBRM3JPS5RhdxuYqM3ZDeHsa5fzJ0HilOrd8MCeCeirws9Bs8tpQPTZnVL4Q3gksW0nBr4eF
	wQk56yb6hytbCmbrE2ZviQTChmoP4eETu3myQIAagcBJ9DXjqROTJBaL/hvRC+hylTaHwa0Q2+N
	ak5PFwunJRtNNQFVnTh5us2gYDYFx9iSAzLfcisFKLHYZv0qB5AjkChohsd9lEcUdK8hJAlx5/V
	Pvwdo0V7EBr5gp9tswWSirOZrcw1OVVpA8mZjEx0Glby8zK6VbjscvhwjkEmBV5dVIrcMxL+1lB
	2pmcuwQtEHf6R
X-Google-Smtp-Source: AGHT+IH2Iorq9Vvi2EzyiF/RqM3KF2vUsBDvK3u3vXOIIzu/36bNO/hzenvFXa8ZjihEOUIdu3YOGg==
X-Received: by 2002:ac8:5753:0:b0:4b5:e89d:c78e with SMTP id d75a77b69052e-4b5f859800bmr149376721cf.76.1757429133333;
        Tue, 09 Sep 2025 07:45:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:600::6bec])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b61bbbc302sm9671331cf.26.2025.09.09.07.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:45:32 -0700 (PDT)
Date: Tue, 9 Sep 2025 15:45:31 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cuishiwei <cuishw@inspur.com>, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@redhat.com, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable demotion during memory reclamation
Message-ID: <20250909144531.GA1474@cmpxchg.org>
References: <20250909012141.1467-1-cuishw@inspur.com>
 <aL_aA2HKjfmwBaJ-@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL_aA2HKjfmwBaJ-@tiehlicka>

On Tue, Sep 09, 2025 at 09:40:51AM +0200, Michal Hocko wrote:
> On Tue 09-09-25 09:21:41, cuishiwei wrote:
> > When a memory cgroup exceeds its memory limit, the system reclaims
> > its cold memory.However, if /sys/kernel/mm/numa/demotion_enabled is
> > set to 1, memory on fast memory nodes will also be demoted to slow 
> > memory nodes.
> > 
> > This demotion contradicts the goal of reclaiming cold memory within
> > the memcg.At this point, demoting cold memory from fast to slow nodes
> > is pointless;it doesn't reduce the memcg's memory usage. Therefore, 
> > we should set no_demotion when reclaiming memory in a memcg.
> 
> We have discussed this in the past and it is my recollection that we
> have concluded that demotion is a part of proper aging and therefore it
> should be done during the limit reclaim.

Yes, thanks. This is intentional. Please see 3f1509c57b1b ("Revert
"mm/vmscan: never demote for memcg reclaim"") for more details.

