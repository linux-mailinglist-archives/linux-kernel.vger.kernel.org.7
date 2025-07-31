Return-Path: <linux-kernel+bounces-752475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0FB17602
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADC718C222B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2DC28F92E;
	Thu, 31 Jul 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3qKAIvK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2451E32D7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985595; cv=none; b=o6Z+TB3XtMcfhnqK6CtcIeTyiFOzjT1kJQ8YtYhVZPCEUiqcy9vNKEjryARtQQdJLfWXW1uD7lPwaG0wj3mHNCCyRHbw55XRnLkQaM3SCIJcR9+NdfJAoYYeHseOzCf3wtppXB1UQc+tFq06uL4QaR+Pllg2z4UtpTA4oPOMifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985595; c=relaxed/simple;
	bh=wFLSG1Ulab6iKXiKYb5seOCv5xy4H4N4O+mXSaEOb0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDrkj/L5SxEeVXN2llWmqaS2diZCOplywMk8gKb18SXi9FS5f0mVMYvUU4RKuceUMthINf0UDQMh8w13ia4tY6kk+gFnpUZ+DjWbwWLS9S+ecdjRs2qHyoG3GH1ODIh+FLtBTyRmnWq1V2S/j01/ZeFvwvoxktQeVKJ83e8N3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b3qKAIvK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-455b00283a5so4342025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753985591; x=1754590391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khPC5CAFWL6Dx66QS31uBvJHhzcyJG/ZzOS5ZJNRudU=;
        b=b3qKAIvKe9aFGTneLKZkXKAYN27jhXo+91HrDe2nrt6WXWki27ifvT0jSN9bNpsaO0
         JX84Yda3DgfvL5PaQ0SX8mxou2CQNVnfY9GdOuidZT41PdYMAL5/BBiMSNLpb0yVF/Or
         m6V+6d4G0qo33W0Q9R5wMZO9FA348OTGdWySyOvAXHcaj9KmX9ekWR8c+dYgZNIQuG2j
         B19U9RBn6QONDod839TVKkQXXQb5MRLakBsoEoLbIznNBmLasnXwUNIbgif1Sgq1BCm3
         09E0AScTWuYn6Qxmdvpl4ipuwMDcxnGMpVs5zgwUsQm/VTF2BclR9wmkeFynXaHnxXAw
         3taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753985591; x=1754590391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khPC5CAFWL6Dx66QS31uBvJHhzcyJG/ZzOS5ZJNRudU=;
        b=Y3fKu4i1Hj9Y4q1tcxhq380p4AJNYVTMqu1SqBQ4LoKljBnPUuIcu+pjvGeaBfLKfr
         LlHZ6/5/yP7p5fddmiupxybt+AR+y6N6bFWrIjDbRyFGC8VX7XOYjSWAso6oH/SLfHsd
         99WVfdnZvVTezi9okp8Y5sSLejfR9ebSg+u0N65uVNTUMHdZ2FgUXIcG8T7ThIEsmVdj
         /smIppnYoV+UdPQxjD9TzqWoxRZf9WqkTzoSEKeXdMXkQGhrHUbxtQhppltz9NGMm2s9
         KYaYE8pbjzh2bTVbw4T8hZi+Y/VhWn3O3L2aJzH/R7JJYq9LLS7+XnuYdBR3qxP8Y0GG
         e0rg==
X-Forwarded-Encrypted: i=1; AJvYcCVfpfByiEZqwXR1jBYibFh+ueeCZokU37acQpTkyh78bg2BkjbCkWkUOzRLHIth6kYZz0MkJLvKz4tZDu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxse8yKobzixhPJGIvit5Mu+EXDcG5OZmsHBfF5QLCs7N5j9eew
	GfdkUyyFcGZJ4HHTKBrlz39bIoWoNIPnGA4CYinMdbtUYFnOBIuB9rkRfjVdID3RL/I=
X-Gm-Gg: ASbGncvrVJhJg0rT1JtuhsHlt450ug89W2vSZsl3ecxpRFg+CMX5EHyF+8AXS6iIQQ7
	8oKpujywRualPcfMUB9d6nv35J6znuuOjSjp8CjD9nnc0+2d2BrqRbSbQsA0LJWiSsXoQSBqhyw
	fZceGFEDG5vd4EHeNY7SmEdNLSL4Mnb6z27WHmtWex1+arz49uPrJxPaBYBGgaoQXf95R9aZJK4
	gzJqdsW3e5kzKEEooGAYy81rUB8D/fLLQ/4PBJDbHdKf87HtKLIuGEFaEbqz7+7Nexcdp0IUIL6
	D0I4TxV0i64YcKRUsVH83UvtuZBYruPQ4Bc4mCSffNQW+ZBqX7kQKnMVjwmB2i3/dqZvEPHy5Jw
	OkCo12beOzLxQCJ4KKRRdcFzqlnE=
X-Google-Smtp-Source: AGHT+IHEqCFNhgCLiwP/29jshYubmNscmwnmSCzs+vaDOgyXEAUaqK75fKy7u401XjtvRY2P9tl/Jw==
X-Received: by 2002:a05:600c:6304:b0:456:191b:9e8d with SMTP id 5b1f17b1804b1-45892b9d0bdmr68568855e9.11.1753985590948;
        Thu, 31 Jul 2025 11:13:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536bc34sm73465595e9.2.2025.07.31.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 11:13:10 -0700 (PDT)
Date: Thu, 31 Jul 2025 21:13:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [External] : Re: [bug report] staging: sm750fb: Fix polarity
 assignment for vertical and horizontal mode
Message-ID: <ed4c5bce-d252-4d86-9358-65a48214d3b0@suswa.mountain>
References: <20250723192528.77109-1-alok.a.tiwari@oracle.com>
 <dbd2df69-27cc-4fd8-8e5b-78b6872d5d16@suswa.mountain>
 <25636f64-7b15-41d4-9ea6-216c22d84be4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25636f64-7b15-41d4-9ea6-216c22d84be4@oracle.com>

On Thu, Jul 31, 2025 at 10:03:46PM +0530, ALOK TIWARI wrote:
> 
> 
> On 7/31/2025 9:41 PM, Dan Carpenter wrote:
> > On Wed, Jul 23, 2025 at 12:24:31PM -0700, Alok Tiwari wrote:
> > > In drivers/staging/sm750fb/sm750_hw.c,
> > > the vertical and horizontal sync polarity assignments were incorrectly
> > > ordered.
> > > The assignment for modparm.vertical_sync_polarity was mistakenly using
> > > the FB_SYNC_HOR_HIGH_ACT bit instead of FB_SYNC_VERT_HIGH_ACT,
> > > and the horizontal polarity line was commented out or missing.
> > > 
> > > This patch corrects the logic by properly assigning:
> > > 
> > > vertical_sync_polarity -> from FB_SYNC_VERT_HIGH_ACT
> > > horizontal_sync_polarity -> from FB_SYNC_HOR_HIGH_ACT
> > > 
> > > Please let me know your feedback.
> > > Thanks,
> > > Alok
> > > ---
> > > Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> > > Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> > > ---
> > 
> > Did you find this copy and paste bug by testing or reviewing the code?
> > How does this bug look like to a user?  Please put that in your commit
> > message.
> > 
> > This looks reasonable to me, but the patch is badly formatted.
> > 
> > 1) It should say [PATCH] in the subject.
> > 2) The body of the email should be the commit message.
> > 3) the --- should only come after the Signed-off-by line.
> > 
> > Try applying your patch with `git am` and review the log to see what I
> > mean.
> > 
> > regards,
> > dan carpenter
> > 
> 
> 
> Thanks Dan. By reviewing the code, I noticed some awkward assignment.
> However, I was not sure about this code, so instead of sending a formal
> patch, I just removed my SB and marked it as a [bug report].
> I will send formal patch with proper SB.
> 

Good eye.  Put "I noticed this in review and haven't tested under the
--- cut off line".  If we apply it and it breaks then we've been
properly warned.  Something needs to be changed, if it's only to rename
the variables or add a comment.  But I think your patch is correct.

regards,
dan carpenter


