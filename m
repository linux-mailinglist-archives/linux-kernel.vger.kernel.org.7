Return-Path: <linux-kernel+bounces-830048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F653B98903
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7CB4A52F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30C727E7F9;
	Wed, 24 Sep 2025 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFpYrn2e"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722D27B34E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699365; cv=none; b=CEtaRI62dtP6qe1uwsJ9jHH4RZLybZRD9Pfc1Q8HnaH8O6bHJ1CEH83DAIfIAwru355nUG3gQNyG7QV5zcnH2m7PHomg7F4Nb9oSRAyIUOiS1nbxepDgD+D/K4sdTNn9cRbMutAyIXAxAXcfnYDYgeyFwj908fzu5OGIN0NutOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699365; c=relaxed/simple;
	bh=Kd8ZcB8HujjZyRuSROzO9d59wfH9TVHkGlJzNIZjVe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4twZA1ROcLSCqF7GzUo5m/bI0+8i9BahrwxkmF9KWNiLnrl0TQuyXB3SNOdkzqE2y9pE9NOYC03m5KNbNvPZY6vUDeUgAk3uenrknAxwxLKgZM1eoGNkfVO4K4wKxh+gt6wvkbWegVoc0Cx8Qwaat4viL8lSwHM9u83TudvE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KFpYrn2e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso47634635e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758699362; x=1759304162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzuWivt0fPkNm9SrHmJP3+hKkJHDd8JHQlpF6y9yW5k=;
        b=KFpYrn2eb4XOcpYFwickEOdoqsRHdEiTrOm9GABbmknFhHyl4p3cZ5vQ5VvC6LNVo7
         o0EOAHGoqxJEGkDb9+V6zccUM4lWOp2UIv9fCIEhU5n9KgSiPlgYSDZY5bcI34opd3gA
         9xKrINN0DnXj5IYLwqXWeaR34/ExtHIJPQApoTXi7BXkAxpv6FKOcEdPGfW0I1RopFDv
         ciEcRhnGa4Ukke1bSVISgv7mXYL7A5L+/fY+cZ61E9Fv+vD6/iujmqxHTUJYIp7KY3Kc
         nP9PnghyQyIpc1BnU2fLS4eGWuaw6VdlYHjwcY5dm2feqcrEbVfosXjyyRCo4RsWVdlf
         HgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699362; x=1759304162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzuWivt0fPkNm9SrHmJP3+hKkJHDd8JHQlpF6y9yW5k=;
        b=FjkAbNyOs2uni7aKSdndmyxo5RQBpwKxdeeUEgU3Zlrr5haFIjN4hBYZamJo9beZQz
         Wdk7m/3SMRiuCPGyMpsoNhVwmPFRVtlu2xQMLsg0oxSDwpw/MJyBlb89R1zlpnzyoW7S
         cNr3aaPPLsX7frNqDBZofo4JimxNSDZa9sOiwBis2uBISF0OlTeW29J9KTLSkwQ1G+kV
         T4+y+pmkdzsIbg6UWpM9X/nLAs0MrNh27w3kQ23+ZPmjdOpKJNIZDuExAJ6iiwMIGSfd
         Y4sGIuZ0xZi3MWq7vqkqlEHPnbdfCAWVYJsLOEPDTi4KzFFE/I7NCNiRXf9pgyV/vUQS
         rELg==
X-Forwarded-Encrypted: i=1; AJvYcCWncrN75X52nIQhcduDq16e5bQmj8F3nWxVCkqQyDG+JdL2q6vL5Dfs5LcJ5W30W9WdsqatK1WG3MCfYyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyke9M8+YmxJlMuvZJ7HxeEzNuP2tjRjGxcJQ7MF1S+1UQutfCf
	Gr3uAvw0qolacr5Dx9X7gQAyAUcvfSS8HoYVvJZ5n+AFrmQTqDMg7RbAVw1ZNVBL0xbHVPpdQy9
	jIHQy
X-Gm-Gg: ASbGncvHeRSwKMInAGyV6rJ2mTTRxpvXT/Fuc45xuWD87FydPQ5WiwpYIyWPo8U/yku
	q5JtiMk6QnJr0TixHaU1Gk8eKjgUDmNl30eghmfDvk3mVtzOz+IN+x9SAiLLUqmdy9zXsGOvtRr
	M3Jg1665oVQM8/GDA1oqa3nSGAwOgC1qU9DjzTp3/eBCUt4zso1Mv0L/5PKnzwPRhE7+QKID7TQ
	4qXiMk3NNv/6a0RK2IgYqxigiHdiTvHQ3NB8xXPkmxSQ60sAYbQ4nUW8xnVc135V3DVersG/b2W
	1UPQR6SfxgWVY1FV8GZZTlGs0NJo0hKUp49qxuYQ19+/ogsVaV8v9B9dQ+BtH8trU/wEsF+nM4u
	Hx/HQ2/b0LLgLhw24ZkjbvTPN4N3K
X-Google-Smtp-Source: AGHT+IEH42ZDWAD5VbXw0upHtx03eZMIIKwgq7R48zFJHivJhT6Mw26u/WOxCLoqGho2YLgjitB5+Q==
X-Received: by 2002:a05:600c:4fd3:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-46e1daccb44mr41847475e9.34.1758699361781;
        Wed, 24 Sep 2025 00:36:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3f3c118cd47sm17190189f8f.29.2025.09.24.00.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:36:01 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:35:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
Message-ID: <aNOfXlG21HIBR18E@stanley.mountain>
References: <aMvV4kK386Sni10i@stanley.mountain>
 <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
 <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com>

On Wed, Sep 24, 2025 at 08:58:45AM +1000, Amirreza Zarrabi wrote:
> 
> 
> On 9/24/2025 8:48 AM, Amirreza Zarrabi wrote:
> > On 9/18/2025 7:50 PM, Dan Carpenter wrote:
> >> Re-order these checks to check if "i" is a valid array index before using
> >> it.  This prevents a potential off by one read access.
> >>
> >> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> ---
> >>  drivers/tee/qcomtee/call.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> >> index cc17a48d0ab7..ac134452cc9c 100644
> >> --- a/drivers/tee/qcomtee/call.c
> >> +++ b/drivers/tee/qcomtee/call.c
> >> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
> >>  	}
> >>  
> >>  	/* Release any IO and OO objects not processed. */
> >> -	for (; u[i].type && i < num_params; i++) {
> >> +	for (; i < num_params && u[i].type; i++) {
> >>  		if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
> >>  		    u[i].type == QCOMTEE_ARG_TYPE_IO)
> >>  			qcomtee_object_put(u[i].o);
> > 
> > This is not required, considering the sequence of clean up, this
> > would never happen. `i` at least have been accessed once in the
> > switch above.
> > 
> > Regards,
> > Amir
> > 
> >
> 
> Also, size of u is always num_params + 1 for the ending 0.
> (basically means `i < num_params` can be removed).
> 

Yes.  This is true.

regards,
dan carpenter

