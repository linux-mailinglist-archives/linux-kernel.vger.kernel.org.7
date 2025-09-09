Return-Path: <linux-kernel+bounces-807260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC3FB4A234
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CD3188401C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23146302166;
	Tue,  9 Sep 2025 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DGCCDkXn"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CAE2FABE0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399248; cv=none; b=XksRK0BH8SKoyfzdX/2W6nT3C1m+N8t/xD0+u0K3tThP+kHdfWODaP6OMLjpbuXztNeSoVwgsc63uQCFyHkYG/JbTosU9BOUklErj1wZr3R/mqM9Qu5SnOuCFLOTVsu+ZhlJ4GsZ70zkyY3Gd+vQIrMLW5E4Ij5Sq9t5l7BpJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399248; c=relaxed/simple;
	bh=oZT6kWzzKCaWeBLUxhtiZLLSS9X2Fa0fJAeUILTYYN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbzutuxBfC2YTOQHhXznXmY5Z1FFrD9l/lkMIYvrm30j0TLrFhHZyxQb8dZZyz6eAxD9eVgBx1FCPT/vOTtDnlJmLgX1c6VeeKbsUqwQ55oUuUJQtMI9bf9K5T7+T9E/58oCebkgwxspbg+GDr0f2btMZI6IYexkKSNjDsCPDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DGCCDkXn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4672877b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 23:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757399246; x=1758004046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TIfQ0ej2H13X+Mf/hogW6BzJHq1AE9tbW6U5ofOKEOY=;
        b=DGCCDkXnVS3BpR9G5a60WH+CWG3KAj0aAWmWo1WBR/X5ZNk6GNA+G1y9iSGIxUKCTc
         6JeZ2B7tKaKiM5xMPFgCpr64w9nDkUDBbXXbd2PMPdpvs1suJWJhthswWz7CbKI2tcDX
         EALpDhp/3VxLJbyxHx9aB0XuoESnTlbHJTsY7CYx8d81+0GS/c92cfEE0e1a3fKd0pCG
         84d3ArXA9wVINFSvqWr5zL5EbaqhE0G9jwUDWTGTr/H67uRTqNa3x6cst/RwvkPKBIyw
         YjYNBpd/1BVaLbMdwwGjqFlk7Qz+wSYe1+c12SBiz0i4T6/B4KD/CBCuJrujmjepQ83Q
         bGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757399246; x=1758004046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIfQ0ej2H13X+Mf/hogW6BzJHq1AE9tbW6U5ofOKEOY=;
        b=IyGezq4W9OoNAQaNNx8Pw3XRAneDBj4AisvOEKTPK6l/Qcp+Al7C7QgiEFZsAFoHU3
         Hq70gdEzMKIzi4LMDCf5XAgi0emvpB2wokKg3xkYcaTbjt+Z9r2oPDmT6sG7QKnCrhJN
         zAP+pzJRIrdTmWga4eIdE/IzqqU1VBSxNod3eA98wV4MRdJH3XMEoQ/M/o6io2PbBKwY
         CmRdWhgJq7rTKeGE5/wV67xS9TF+AT8+kUHPyRtcvRUyXG2FIqBHBbJjeL13p6CDmNng
         K7Kyjk+7qUo7Cb8xZKNNWSJhfSU2LVsOk1IKs5GUlt6KojzWdzNVxi7fVMQv9jV/ewho
         Pj+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWf6yAExRAZhTasRgIv4njrf37QWMwoP2dDLyOAe30tO6r3icb8OEjIBaZsw6IT4agVogZgHkfBWZh/V7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0k12imXq1hBZu1ELIM0TdUFUAptjt2d9YVGs5PzK0nGKRsymU
	XxTf7Wf/wNbdObkclcQJ4Thz91oOBAQALQJ5EqY56zsc/J/sdemLggmgCCCmsms16w==
X-Gm-Gg: ASbGncti92E2N7sHWEQLhPyCD+g+CEIctn/uMmSiFVTLsEXCrMNDZoiMmxnAWELXZVu
	YnhNveMDykircHN0t/ACyZP7dCu65Efyy+ovkKDDyl2dpnQ5cnv7bj1R8m6radFMr+8QYmg37UB
	6EhxIz7EyvfiNsuGl9OXf7f2sgbcv0I2964IWDPFt1KRBlPaWsHunG4vW/MP27W1rVMzM0jKxLu
	BqH7/XHT8DfeL12J67iL36w9ZWn/fOmd4TBtOoiFGuopQcpBdrCCOH0RMElmX+0bt4IfoH4xLnd
	ErcRI7hnWiZrcaTB+FmKDRIMTNu4auhbLjbDcWsPgrfz5e8n8Tpomy8hUpFJtutD/f3xtH985V3
	dQKxTJ8oYgXsExIRWsRE/Gm5sxzD+rOAf+n8jyWrKlUav2Jbg0thOeLt9k+R2
X-Google-Smtp-Source: AGHT+IEjXDRhmzDLAQ7JbHedj82gankQmM/a4mRdl/qrwQdv7IW3BtEjOxI5vHM6y9RbJG9gtfcz7w==
X-Received: by 2002:a05:6a20:7484:b0:246:1e3:1f7e with SMTP id adf61e73a8af0-25376386b77mr13623443637.5.1757399246269;
        Mon, 08 Sep 2025 23:27:26 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e55f1sm944357b3a.13.2025.09.08.23.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:27:25 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:27:15 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: kernel test robot <lkp@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	oe-kbuild-all@lists.linux.dev,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
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
	Michal <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Propagate load for throttled cfs_rq
Message-ID: <20250909062715.GC35@bytedance>
References: <20250908110548.GA35@bytedance>
 <202509091233.f6nP3BVh-lkp@intel.com>
 <20250909061746.GB35@bytedance>
 <fd017cc8-0eb0-4961-8f59-575505f27a68@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd017cc8-0eb0-4961-8f59-575505f27a68@amd.com>

On Tue, Sep 09, 2025 at 11:52:55AM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 9/9/2025 11:47 AM, Aaron Lu wrote:
> >>>> kernel/sched/fair.c:6747:1: error: expected identifier or '(' before '+' token
> >>     6747 | +static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
> >>          | ^
> > 
> > Sigh, I remembered I did a build test with !CFS_BANDWIDTH and now I went
> > to check that build directory and noticed I didn't have CFS_BANDWIDTH
> > disabled...
> > 
> > Sorry for the trouble, will send an updated patch later.
> 
> While at it, another nit.
> 
> On 9/8/2025 4:35 PM, Aaron Lu wrote:
> > @@ -13151,10 +13161,13 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
> >  {
> >  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >  
> > -	if (cfs_rq_throttled(cfs_rq))
> > -		return;
> > -
> > -	if (!throttled_hierarchy(cfs_rq))
> > +	/*
> > +	 * If a task gets attached to this cfs_rq and before being queued,
> > +	 * it gets migrated to another CPU due to reasons like cpuset change,
> > +	 * we need to make sure this cfs_rq stays on leaf cfs_rq list to
> > +	 * have that removed load decayed or it can cause faireness problem.
> > +	 */
> > +	if(!cfs_rq_pelt_clock_throttled(cfs_rq))
> 
>           ^ Can you also add a space after the "if" here.
>

Yeah, I definitely should do that, thanks for catching this.

> >  		list_add_leaf_cfs_rq(cfs_rq);
> 

