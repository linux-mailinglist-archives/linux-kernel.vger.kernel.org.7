Return-Path: <linux-kernel+bounces-833626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD20BA27AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDFC7A2800
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785A42773DD;
	Fri, 26 Sep 2025 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SV4Lka7P"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC825E47D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758866015; cv=none; b=GRHchxhWi0/IpOz+mWDlDoLorHV7Fzh6pvObKmHxXxtW+3ceLV7Khr7qgcCcLRNq6t1y8WUrRpNoSOqvE0zihgCsYvNNcONCNbSI6Q85Xd/pZZCU1GSevRcVwS1OxVJR1tWzzhpiPQpwdRqF/z7E+QIQYjsKsF6Ex6m6kea03wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758866015; c=relaxed/simple;
	bh=aFWWHXVgxqd4lnQjqtB2spZoFyI7vGEDM6IR2MCDxJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb1NwlTX+4yRahn4Yb5D4OYRoXgXzJWM5E//lwwt3hna258+1KZ8Lvm5h0o+jL9WJKqIffFHzxqdW51XuMimsYfq8/+5YSKg/csb+ZBvXMYtHpo3ttALhwhdLF/uGg4PH92ehyM8SeMxTHDlU6w0OXZp4LQfofHwP/zgV2wp2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SV4Lka7P; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f1f29a551so2338633b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758866013; x=1759470813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aFWWHXVgxqd4lnQjqtB2spZoFyI7vGEDM6IR2MCDxJI=;
        b=SV4Lka7P3szyok4dgG3fQE/vTHdaHgTIugdsN2iPrb1sDx4GJVgY7m/C7RophXhUL6
         CGE/W5tKGbiaC+noXR5ggFI4+D+dh9LTkWKCjI74jRaAriET4CmDN5VrjNuP1brLcBbk
         3amXAnCwbA0Xd+8jsoDOYMPQcaGx5gWThgmpWV7m9ufQ8LL43x5Z5gdWVmP4kvqE0XgA
         CtC/ESOnaxov2KZcS/LpD26UoCTcJvqPR/aMxxRc3MiU99OeYbmLjOQYj8MKkRYLGkDa
         S8JbWoNmWSSgTDhNV07I8bM61zvbqhN4Q7QttT1c+s+XQHq6uNJzigB1I+MfBU7P9cS+
         bFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758866013; x=1759470813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFWWHXVgxqd4lnQjqtB2spZoFyI7vGEDM6IR2MCDxJI=;
        b=u2HIXSgkNyeXjIHAbQcypVRkQssyICELnXq96KIebaKPVrwVhN1EVhW/yEYyxjaFMt
         yNo0odurawJBEfesAut/krCptl8Q3l6up6B+9kr7M6K/57ZJI4/td4yqjZEq8GN0Yp5q
         4pjkeJbiv4Ah5QX4KvEJlc0QNTGmz3ofWrVTn+Brl3weaACdTmDmlfbTyPnRzWWgliGs
         J5GR9IN4rsJIof0Btpe0NMHkZ7fwtpCKFlbcHA9nge7pYQ8WA+J+CG3lbBNmL8XShD2s
         TRK6P6RSBD89QUDuN5svgQlBCiJ8OUXVORsL7TPNnzwV0Wc3xT+tk6XtXYr02JLgRv/9
         SY7w==
X-Forwarded-Encrypted: i=1; AJvYcCWzH6akuJIhpGhNXY4gM47Z6nW7ItS7QgdfzsDRGLZj7uQXyvsMsRel60P4gi9RQ1719dANREDmSJVTmN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgI7jjpxslhcA6tgkmzuYuwuDT53cwnoF93Tr0iHrvmeqdHOJT
	2Sp5akT3NcSQYZB7n+/CWcbsGmzynPJCpiMdFckQEl+WtxkVoQF8Tnb2OF04NTEzqw==
X-Gm-Gg: ASbGncuKMCexu2eSmWOX3hqVRlPwNfsAxDlil899WVRu4cs+JjGlpb0vQ+8VTJNNhKn
	/FMECZUsvswB37R0HihsV3H6S/IkNWbv0rzkiNbPRvYXGij+UWS4EJRNdqgYXmaHSCTmajE5t/X
	X1y4jUnpX+UuoWNYkgbUqYp7RzbBQXuPmmTxAUJvP25NrNIoyxbfLDcPwOzs8zfsjQn7tuQUDrW
	/bHzU9mR2hpIofCcrQXhjR890rwJwFdsDGzazcTSyj7YW/5xJMK1+Iq6bzcdGu2R347ZK+ZqO84
	KNpztahIuupH6X2+godfZY2XEsrTr2amSIRMto+deanKHKcavfiJE9MaTMeMyGSOrIsSp3pR0jw
	Y/J8PiRSs9Peq0SbEA6bkdRyVxVD7l3fU9JY+Y/4QkCikKOGHiA==
X-Google-Smtp-Source: AGHT+IE6N8EhaevvU3+VyzbLozCKs2Jjam77B9Dw9PXgu2K+NM+IAs2aTPXUkMWHFxthQ6z/Ye+fjA==
X-Received: by 2002:a05:6a20:958e:b0:2c1:b47d:bce3 with SMTP id adf61e73a8af0-2e7d4376039mr6417245637.45.1758866013071;
        Thu, 25 Sep 2025 22:53:33 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347224b0f7sm4292305a91.7.2025.09.25.22.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 22:53:32 -0700 (PDT)
Date: Fri, 26 Sep 2025 13:53:22 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/4] sched/fair: Propagate load for throttled cfs_rq
Message-ID: <20250926055322.GD120@bytedance>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
 <20250910095044.278-2-ziqianlu@bytedance.com>
 <58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>
 <20250924113354.GA120@bytedance>
 <db7fc090-5c12-450b-87a4-bcf06e10ef68@amd.com>
 <20250925092938.GB120@bytedance>
 <72706108-f1c3-4719-a65c-c7c5d76f9b1e@amd.com>
 <20250925120504.GC120@bytedance>
 <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
 <fb530c13-9ff6-46bd-b9fd-6e9a8ddd66c1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb530c13-9ff6-46bd-b9fd-6e9a8ddd66c1@amd.com>

On Fri, Sep 26, 2025 at 10:02:53AM +0530, K Prateek Nayak wrote:
> Thank you both for testing the diff and providing the setup! I'll post a
> formal patch soon on the thread.

Thanks a lot Prateek and Matteo, looking forward to the formal patch.

