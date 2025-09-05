Return-Path: <linux-kernel+bounces-802285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ACAB4505A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25A21C842F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC022F4A06;
	Fri,  5 Sep 2025 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jBoqEGCb"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D862ECD34
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058832; cv=none; b=ez7YxE4H0ctH8J4J4dLV4NJ24FtuomHZWcMauWKC5+RwKD+UqQecih89kbnyYQJ9FC8KjlL5UlWi7djJagK2Fb6ARQtZHVKh1uZCceS0Pq7fTTW3n9lT5j1FSbGIFb7EWMSK59cvfgA1bWKpF0qFFCJ2CsrJaqRwYuSX7aNQvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058832; c=relaxed/simple;
	bh=5206wKiSIOhPdIK2swluTZY1LUZNMnLTyK3osXxQIVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADsir2BdrH9fK2dF7YJuzyFihwYXr2yvx52y9UjcfyuIjHFdB8Yzz9atRNkGC/ZnDlwSfZiVTiEKW1ux+PsYsHdPonQvos2588ZhXrYaj88wPNV1ApFgJuDqWJJ2jF2b5lZH+lirerjHCcsnFG0MPTtyKSnLAsSlDtKISZuUV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jBoqEGCb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7722c8d2694so1707375b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757058830; x=1757663630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5206wKiSIOhPdIK2swluTZY1LUZNMnLTyK3osXxQIVw=;
        b=jBoqEGCb12po49MFWNAmx7TrgkwSQAVAEFYNAdy7dxMASVpJTRCNI98pDsfuM7fThZ
         Laaxp/l7zFZMiU+ThZKazp1slk2ofCEU86Jkrz8xY4vv5FWtO8IhEIWwZ6gG4uyamRzY
         z4XBv9TDJkvoieqGdm60RDDHus+3y19afonaOebHjx9xerw1YEUrbXXsQpFSfJQu+HrU
         bRtMO41KDIRc8ld0YoGHKWcm1TT4XP6Avf33kAakcMlShtrfvIdHIOnzGre6JTjlFi72
         iK9H8LvbbI1Ca1kP5D/oHMF49qmoa6pgq+YdfnRZ3Y0QX8fc1QBWkfOP8kwA1WtRwFYr
         Gb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757058830; x=1757663630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5206wKiSIOhPdIK2swluTZY1LUZNMnLTyK3osXxQIVw=;
        b=glc7tz4MPWDaAMl2eGhLWy5PNxVwsgcKIpWCjJDZLjYtSCVORITzdd42qpXWykSgZa
         DMUxA28ffy/E9XOBtpX0NYi82YSjUE/3Q6iUgV+brIOj/t9hsVpTvrtdtQDoHy2e2AYI
         XJlWyuwaZG6czKbEW3nlZqGDmE6lv1724+iwfoHwjKCFu+X529aGELMkJJmmohHnHZ/n
         sSDY0WIJu94nU2U3g5zkAGsnhRxhOCYJ8X6iKLXXgXhcPt6VcRyLpA0Zuvwztay4YibC
         DE1l3hfNgCYdIbMKY67N2eufKDLYrqf/TveDP4FOlGOqqPyIGMz27HtRX0bbr2p0h7xx
         bB2w==
X-Forwarded-Encrypted: i=1; AJvYcCV2nd/IomMxaaGxmZUokB2+fNWfzA9Gf8VyxeJPNqW77xHLgamNTWJpMnunGPRAernP3AZChmkc1yq46H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddXmr3JvmXWpu/7oek99d1u+DshH1tv0d3M9mzdtmCC6DrZ6+
	E3M25JMaveSTemb+KDvsxdL2TJJ8vseSYQ5qnFn2TV3BoIDSbSp4Kj0IuXYwL7/nSw==
X-Gm-Gg: ASbGncsK8DRCJ5kTNUNdeb1rjVbhJNZqz37pXfaC2bI2dGCgSZMBYQO+aAihp5iJejK
	qxTRx2HTo94JWLpKkhZsG2JbmvuyOEeGZzO3lbv0t8IrYTQTYc6lHJeN3XH4LjFfsjcwx/qjLRy
	tCHKL+L7wNTomIWXc+wXwIjfiF1E4AwT4TXb/R0htiP1zRv5WZa0BpYpgg+haWE+DsKOx+A2ss4
	X7jG6wc2B2rjZ6XJ7q8Akg4v2nwuXWMy3vgJ4dJQC612bZt8+R6DYlICVuYJH5k3igVvKvtjrDS
	NfNuMA0JkT3CCxnMUpBs5gnxCy/GOjNHvIRsmq4NPv8vJyC2LI3WFwBKgrb1Hb8i4Usk/6Zhw7l
	PXyvOFI2b/LYL1G69yuZbq3wsiojpqxJw8GMyJfFgFqTo+dV/QU2QWfghCy6XvQJY3xV58Fs=
X-Google-Smtp-Source: AGHT+IGH5ZqKfkchCCOnddYpy5RDhGJJhoWQ7H5BZLy9vAjMtwlzv3mEOy1ZV5irIfHX1mRF5h+0jQ==
X-Received: by 2002:a05:6a00:7496:b0:772:3f03:f3f4 with SMTP id d2e1a72fcca58-7723f041a85mr27982570b3a.14.1757058829884;
        Fri, 05 Sep 2025 00:53:49 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77241f08b3asm17327541b3a.28.2025.09.05.00.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 00:53:49 -0700 (PDT)
Date: Fri, 5 Sep 2025 15:53:38 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Benjamin Segall <bsegall@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250905075338.GK42@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <xm26o6rrtgav.fsf@google.com>
 <20250904081611.GE42@bytedance>
 <20250904120401.GJ42@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904120401.GJ42@bytedance>

On Thu, Sep 04, 2025 at 08:04:01PM +0800, Aaron Lu wrote:
... ...
> Per my understanding, we keep PELT clock running because we want the
> throttled cfs_rq's load to continue get update when it still has tasks
> running in kernel mode and have that up2date load could let it have a
> hopefully more accurate weight through update_cfs_group(). So it looks
> to me, if PELT clock should not be stopped, then we should not abort in
> propagate_entity_cfs_rq() and update_cfs_group(). I missed these two
> aborts in these two functions, but now you and Peter have pointed this
> out, I suppose there is no doubt we should not abort in
> update_cfs_group() and propagate_entity_cfs_rq()? If we should not mess
> with shares distribution, then the up2date load is not useful and why
> not simply freeze PELT clock on throttle :)

With more thinking, when PELT clock is running, root level cfs_rq's load
can be updated and that is useful for things like load balance.

update_cfs_group() is a different story and as Ben said, there is cons
and pros whether to abort there for throttled cfs_rq so there's no
obvious thing to do for it.

