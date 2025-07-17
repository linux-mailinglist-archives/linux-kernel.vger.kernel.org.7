Return-Path: <linux-kernel+bounces-735465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD9FB08FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3163B5F31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827252F85D2;
	Thu, 17 Jul 2025 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GP448qg6"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05B2F7CFF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763272; cv=none; b=Mh1HLWhnfFb/O7NlRWQdwzXPmhDmIoeJlOjl4MSq1VFScpsG+WlQirSOpxIHjEmKRnfTXeV0FoExhQ73TW+r1djesss9QSWmSFaTsO7KDm7w74PfwK0JOvb5FB0UKqJXkKiD/+M7tsjqd6tVfz2Kj5p2atBmxDhowI0Hrff/H1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763272; c=relaxed/simple;
	bh=labVMQqdJyvR5/jdB07TNWqq4YEJd5WCdpHU0L+bS5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP7hbhKwTiLrhhxc3sVHX9MKPcTVEbnOVe1v1/XfrhXGltxdvF5LVrSjIB4q/TloHuh/IbSQrRJoqrQypdrU+anb0oyWgKgRh1uruRtlupDbJCNTkE+g3XQ3BN58UCTRRK5Fp9oPIB198YjN6Axwfy/9nXouPT8VOWJ6lDry4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GP448qg6; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c09f8369cso362758a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752763269; x=1753368069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOLlzqOvF05B7j1/cu0Mg0IOPy7P+W/8Ezls8+sFmRc=;
        b=GP448qg6hgmMNFqEA3GIdZ5r8Vz6milupeD3S3rNz82MuyLRdsGxrtYSQfGS8Ra0bM
         EvmMzDemtK3w1ry6N5Kll4Ra59bkqaE/XC5c4jVe32k9FUlX1R43bDAmATohadKMsgnu
         iSklSxqB/cdOovmJh2Ca0andhd6KdaNxmRwB8tGFQusIiwTIenEQJAHZAbmWpkBl+WWO
         E2sJ0hQmetRzZUaJOFNp6qFB3NVjDGioMFJJ5PPlMTkcMTbkJhAIDe+3ZTtEtgTWzgpl
         VAcSG6HA0xoJqaccYStxve5x3W6idT7Cjf81W+qT7EGgCZ62BP9ipg3d/fSQFfO1rPZE
         wQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752763269; x=1753368069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOLlzqOvF05B7j1/cu0Mg0IOPy7P+W/8Ezls8+sFmRc=;
        b=qISmFezrtO9bzHa8EjS3mI7HoZXhHYnsBFjJd0HrVNFVDI6pgmSiN9xh6iPUY0ofKq
         jDwSHiMbXffIfZ7ANC68ilrLvC2bNCAC2wTa17cJo/d3FQ8RI6tAjXQbj/gp0ybUoxkQ
         BMSQBFbm1tXWPhgA3FgyFG7YZbP2jmcrezSD/BFi0zVtTjOPSaukPkNDkyL6pq8Xok/S
         3vrT0EyM5P5WVGghKrKW10/Pj6AnsWZlf/+8qw+vQPXvgaxqDbv27z/vKUREgpOJzQ9i
         V//N7B1VKOdLtWz2huCwdRi/t33G+AB4HvfLO0BmpBdOo6c9VjopiOZREM9fH8PLzq/P
         wcUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVneRi6XsYFfU2dTrtthojKpI892WDOG8daH3wdZZN3fkNPQSLvO7mAfdpDEtVdMcIomTvBVJOXT4xIBBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBpMV0y//zzi4zmT8hzEAQI/XAgMU+KWj90XKnDkJy54zdSzIj
	L5cQ6jjGj82FYm4L+lDjwd54H1NM2IPJQk1T/Pm2Gs9fSzjv5QaViSFRVfDq8XgKiePH29qErqK
	DVbKb
X-Gm-Gg: ASbGncs+JkphksvZq9+0M58hIBOqcPiZT/MlbO/5kOOHMdaSv0RKIvNHaY6Yjnh5A40
	DjY8X0gOVTrFl+gWiSVq8J1nVQAROeHLoanHOIUWNxm6/uNhUVllmvvpy6E8q13VtfYRiFSNAeT
	YWaaMaJkpI7sPbAas71iU/AnP+TySYv/0mY+hqYkX9xZ9CqSku6AYW4CZFr35ZwHtb583yK5bhC
	Nni5Hk+bkFfRI0dRXgHyJEagTrazA06OlWcPBxFXUwLp3YcXtgHgaCzA32/AH4746i+gBXzgCpF
	cFYyRK7DmRbQsesXAmK6dQaAwZWWMO+pjMdRyh/OBKmo5DdDRSGVK8y/pBHukwMc/2T4B5MtlIr
	WFo44JkbltcYkxLUjaUMO2OH2NLAx
X-Google-Smtp-Source: AGHT+IHY11r3be2AgKsKzf76injlnJw53F2oFbGYqPw0mSWwU9m3Yv2l9kEZegI+e2J/7Nm8/oQtQQ==
X-Received: by 2002:a05:6830:7202:b0:73d:baa3:82cc with SMTP id 46e09a7af769-73e64aa353bmr4811092a34.19.1752763269281;
        Thu, 17 Jul 2025 07:41:09 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff8ede965fsm2575267fac.40.2025.07.17.07.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:41:08 -0700 (PDT)
Date: Thu, 17 Jul 2025 17:41:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] irqchip/gic-v5: Fix error handling in
 gicv5_its_irq_domain_alloc()
Message-ID: <5c22b679-853d-410c-973a-ba3c91a54b84@suswa.mountain>
References: <cover.1752693640.git.dan.carpenter@linaro.org>
 <4787a3c4-9713-4b99-9b8a-7ba227e91d02@sabinyo.mountain>
 <aHjBe9k2Igl2iopq@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHjBe9k2Igl2iopq@lpieralisi>

On Thu, Jul 17, 2025 at 11:25:15AM +0200, Lorenzo Pieralisi wrote:
> On Wed, Jul 16, 2025 at 02:38:22PM -0500, Dan Carpenter wrote:
> > There are two issues to fix in this code:
> > 1) If gicv5_alloc_lpi() fails the original code was checking the wrong
> > variable.  Fix the mixup between "ret" and "lpi".
> > 2) If irq_domain_alloc_irqs_parent() fails, then clean up all the loop
> > iterations instead of just the current iteration.
> > 
> > Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/irqchip/irq-gic-v5-its.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
> > index 55360ae9f1f6..8cc8563e27d5 100644
> > --- a/drivers/irqchip/irq-gic-v5-its.c
> > +++ b/drivers/irqchip/irq-gic-v5-its.c
> > @@ -949,15 +949,18 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
> >  	device_id = its_dev->device_id;
> >  
> >  	for (i = 0; i < nr_irqs; i++) {
> > -		lpi = gicv5_alloc_lpi();
> > +		ret = gicv5_alloc_lpi();
> >  		if (ret < 0) {
> >  			pr_debug("Failed to find free LPI!\n");
> >  			goto out_eventid;
> 
> This should be:
> 
> goto out_free_lpi;
> 

Yes, you're right.

> otherwise we miss cleaning up for [0, i - 1] on LPI alloc failure.
> 
> I can fix it up - not sure it is worth splitting it into two patches,
> just let me know please how you want me to handle it.

I don't think it should be split up.  As a reviewer I would be annoyed
by a split up version of this.

I'm a little bit surprised by the offer to fix it up for me...  Is this
going through your tree?  It's probably easiest if I just send a v2...
Let me do that.

regards,
dan carpenter


