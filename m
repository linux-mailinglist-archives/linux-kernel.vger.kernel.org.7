Return-Path: <linux-kernel+bounces-744348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0211B10B66
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94707BAAA9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060292D9EE3;
	Thu, 24 Jul 2025 13:29:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB22D948D;
	Thu, 24 Jul 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363789; cv=none; b=stLNKTPqfNRgjbhafdgG9d9j72uyg+i7n8yTVjNdzyD0hNUlLZioE6DYkIR2ArZs9MJ7VIqNAwv2CkGpC8k6WQDjRTFGhh2wXg5SowJO3A2qZMSkfeFesvAxJ+bLTNjLX0Hf7zD3Br79fqNr9A2aaWd35Is6Q8gy44Mh9EIotsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363789; c=relaxed/simple;
	bh=Ug/ucAnqueExNi6tsOnO76I8VOjQNJA6clqwgyf0bdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8Mq45XNBSgHDE2C3r6C7APj4c05LIPZUb4Z+tD3Sxzbl3bfcJvT0b7YTejByEvrN+gWZh+kUZIBpSlqxeLwhb7HgVVYacOd96DNZcV5ghSeuyg3zTUfmEu/RtwlIrwyhAO7/weIPnEbF/fW0fXS3BWQVUb0hUXSCVBAYgvp5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6448C1A00;
	Thu, 24 Jul 2025 06:29:40 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C60E3F6A8;
	Thu, 24 Jul 2025 06:29:46 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:29:44 +0100
From: Leo Yan <leo.yan@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] coresight: Fix a NULL vs IS_ERR() bug in probe
Message-ID: <20250724132944.GK3137075@e132581.arm.com>
References: <7bd9fae8-a15f-412a-8800-ce47acf0b5ce@sabinyo.mountain>
 <6fecd7d0-a5a5-4973-94ce-c63a3dff6bc7@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fecd7d0-a5a5-4973-94ce-c63a3dff6bc7@arm.com>

On Mon, Jul 21, 2025 at 04:46:30PM +0530, Anshuman Khandual wrote:

[...]

> > diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
> > index 0e4164707eea..d542df46ea39 100644
> > --- a/drivers/hwtracing/coresight/coresight-tnoc.c
> > +++ b/drivers/hwtracing/coresight/coresight-tnoc.c
> > @@ -183,8 +183,8 @@ static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
> >  	dev_set_drvdata(dev, drvdata);
> >  
> >  	drvdata->base = devm_ioremap_resource(dev, &adev->res);
> > -	if (!drvdata->base)
> > -		return -ENOMEM;
> > +	if (IS_ERR(drvdata->base))
> > +		return PTR_ERR(drvdata->base);
> >  
> >  	spin_lock_init(&drvdata->spinlock);
> >  
> 
> Do we still have more similar instances in coresight ?

It is a bit shame that I have enabled smatch for static checking but
did not verify this series.

I can confirm that the coresight driver does not have such issue in the
current code base. After merging the CoreSight clock fix series, we
should be able to dismiss all errors reported by smatch in CoreSight
drivers.

A side topic, I observed that smatch does not like the long functions
in drivers/hwtracing/coresight/coresight-etm4x-core.c. So I built a
smatch version with relaxed limits.

---8<---

diff --git a/smatch_implied.c b/smatch_implied.c                        
index 9055d676..7469f1ac 100644                                         
--- a/smatch_implied.c                                                  
+++ b/smatch_implied.c                                                  
@@ -462,13 +462,13 @@ static int going_too_slow(void)                   
                return 1;                                               
        }                                                               
                                                                        
-       if (time_parsing_function() < 60) {                             
+       if (time_parsing_function() < 300) {                            
                implications_off = false;                               
                return 0;                                               
        }                                                               
                                                                        
        if (!__inline_fn && printed != cur_func_sym) {                  
-               sm_perror("turning off implications after 60 seconds"); 
+               sm_perror("turning off implications after 300 seconds");
                printed = cur_func_sym;                                 
        }                                                               
        implications_off = true;                                        
diff --git a/smatch_slist.c b/smatch_slist.c                            
index cc3d73b7..039cdae7 100644                                         
--- a/smatch_slist.c                                                    
+++ b/smatch_slist.c                                                    
@@ -321,7 +321,7 @@ char *alloc_sname(const char *str)                  
 }                                                                      
                                                                        
 static struct symbol *oom_func;                                        
-static int oom_limit = 3000000;  /* Start with a 3GB limit */          
+static int oom_limit = 4000000;  /* Start with a 4GB limit */          
 int out_of_memory(void)                                                
 {                                                                      
        if (oom_func)                                                   
@@ -332,7 +332,7 @@ int out_of_memory(void)                             
         * It works out OK for the kernel and so it should work         
         * for most other projects as well.                             
         */                                                             
-       if (sm_state_counter * sizeof(struct sm_state) >= 100000000)    
+       if (sm_state_counter * sizeof(struct sm_state) >= 500000000)    
                return 1;                                               
                                                                        
        /*                                                              



