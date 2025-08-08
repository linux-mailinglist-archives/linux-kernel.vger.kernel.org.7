Return-Path: <linux-kernel+bounces-760823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358A8B1F0A7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA906235E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D0289812;
	Fri,  8 Aug 2025 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="KmmXGxI1"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376FD255F26
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754692098; cv=none; b=sH1sTqYulIXH0KrZZI/RoZbtfPv3yxmxIAlIThg7RLSWy8p9Zug157r6oKsP5oLMq7hDPlmsJjeaT2TSHHP530M1ksQzeVw3rgUte5fExNdeSwL3iJQz/eshzHZzizJDTaP7Vgo3cv2ZH1GGotD0SNNBDe0SOb2+P0HvbJwCE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754692098; c=relaxed/simple;
	bh=/jxw3u0MmsWwa2Ov9j/mQBzshnTP0apph8DRq/uzhuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohyN+EsqFdkNrjjkx0oDhLEnOrpxeuiZ49h38Ahvbqh1dXHcS+XjRqSC5HI6N8AmToKWHR4T0BNgJUbJ2zF7S0yLBt7hSh1jK0qXjSdRemnQS6ipDGQA748zTuy0Fh3gtMn1raoY3MiyBnNxuPFI+PACC0nC2c4ddcb961Wuzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=KmmXGxI1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bdea88e12so2471159b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 15:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754692096; x=1755296896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEGYyJXldsnlGE9tOCaB3uk2uTlfrO37SMTWq1FGa88=;
        b=KmmXGxI115SVxPFjGwerjfpXcx5If8wovaVjDBqDWLQIsrO1ddQjB+NjbJimdAncEH
         8UrjaBZ51wdjx3xhDFuDE0NS4eiJVdRhijz2XtB8iN98Eo/LA+CkjQ+d6lcf8PTZLHYU
         IJtt6ObKMnRdDOqBv3vkLXSynbWK76LPryU0ofn4qMwS4GaIP+9Pw3qzob970TVXgfkB
         Gfyuh4Ake1SrPZ8pPOJ0E+ZUEPy9NmuAzNW2BJ1AogvM8oantDqS0/VxVYEdLTOiUt93
         qDF3DE4Jovsjn5VYLf23/yKxuh0b0l3ooUGTB9pfM7fT836QNw17weC0rF6P4q/OO3BG
         1jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754692096; x=1755296896;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEGYyJXldsnlGE9tOCaB3uk2uTlfrO37SMTWq1FGa88=;
        b=W2xXDbwkxUAH8uDpyl1TJL09A4e3/pnsNGQwKFfFv4TxD/gTalolEXk7w4fqIZmE7n
         KXN21NAe4CR+puD6vX6w9yCvqSz30fhuGbuzkH/YNq0OuBTQusWPAwy1zZBo5t85YVEh
         nllyEq1qUh6rYTIuUWoL9fYC7vTyFHVSSCq+Ol7ykZg0tFmqvqPRxE+52BAlBxsndfUZ
         Ucn7lZA21H7ycUo+EFQ/w1R7QjLKwSrq62YbFs6xLBQlhof0/iVvagb8oWyVK5ag3Mxh
         xepgNmxb8PPsuQredQG2mzwNgDSECt8xKIKp3X1Jx4ctSFEByV1l7JWAybZom8x72S1Y
         qf4w==
X-Forwarded-Encrypted: i=1; AJvYcCUG0wXdMM1nWT5se4ed68ZMqeYDC0jOcv5bY5bjCAbo4lfSJLepWt75IGYsGbJfYCYNsfkaixxkX7uvFCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1nByTRS2KKAAfuGx+83jlc/iWoI1Jl3AU/8j0LPs56LMiPPaN
	xxFlfPcrYeu12We43bMNNhl9UySB2EcSYkWFfoMTsj2b0eq87Qj+j38pBN4koXIYVn4=
X-Gm-Gg: ASbGncvkaIHPsDnsQrxyQIsPgnHUuC2XmnenMPMn7kcb/dZyJMW9KYpJi17k1mPpRfk
	nKS3FF3Nb3env4x7OuXGPaecFvYQNUPhdE864jOpPy9BWiakAwaGjlqRsxbxmTA2y52VDpb8TjT
	q5H0+lj1XeldbvnHLWHGSs9iox4a+z0uwohnZ5/OUr9J7tDz5tx97dyVgDcMG6oczJscgiq7xRG
	yNhkX0b6K7dnjXe+9qTFxZEzPiDS60PAuRtYwGDL7xJphUdNIwlcReySOJ8omN3EOMrV6WEdmKv
	GfokFTGG05Q9DhkIw7xTpc5CKm3/9Go8brNwU10RbhqZZvjSlV00Kh5wMN6hcUqkQxMaOKcpmrv
	YoolrKhIRKfQ0/6uAdJ67VXcJYZ0Ocv+/HJs=
X-Google-Smtp-Source: AGHT+IGEuLkCa6eymEthWlGU8klr8RO0bORK8jccZGv069RpsewtDDZjrvMvXY/FQgusoX69D8fh3g==
X-Received: by 2002:a05:6a00:3cd4:b0:748:f1ba:9af8 with SMTP id d2e1a72fcca58-76c461959fbmr6252278b3a.21.1754692096355;
        Fri, 08 Aug 2025 15:28:16 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:4a9b:7646:8b3c:6e8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2078afd8sm9289316b3a.117.2025.08.08.15.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 15:28:15 -0700 (PDT)
Date: Fri, 8 Aug 2025 17:28:09 -0500
From: Corey Minyard <corey@minyard.net>
To: Frederick Lawler <fred@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH 2/4] ipmi: Disable sysfs access and requests in
 maintenance mode
Message-ID: <aJZ5-Tv1oU7FMjgC@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250807230648.1112569-1-corey@minyard.net>
 <20250807230648.1112569-3-corey@minyard.net>
 <aJZgH01YM9sFRkUO@CMGLRV3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJZgH01YM9sFRkUO@CMGLRV3>

On Fri, Aug 08, 2025 at 03:37:51PM -0500, Frederick Lawler wrote:
> Hi Corey,
> 
> On Thu, Aug 07, 2025 at 06:02:33PM -0500, Corey Minyard wrote:
> > If the driver goes into any maintenance mode, disable sysfs access until
> > it is done.
> >
> 
> Why specifically sysfs reads during FW update state? Is there an expectation
> that during a FW update, that redfish/ipmi/etc... are chunking/buffering the
> FW payloads to the device, thus needs write access? I'm assuming that the
> device is blocking waiting for paylods to finish, so sending additional messages
> just get ignored?

In my experience, when the BMC goes into firmware update mode, it
doesn't behave normally.  But it's just my experience.  It general, it's
best not to mess with something during an update.

-corey

> 
> > If the driver goes into reset maintenance mode, disable all messages
> > until it is done.
> > 
> > Signed-off-by: Corey Minyard <corey@minyard.net>
> > ---
> >  drivers/char/ipmi/ipmi_msghandler.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > index f124c0b33db8..72f5f4a0c056 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -2338,6 +2338,11 @@ static int i_ipmi_request(struct ipmi_user     *user,
> >  
> >  	if (!run_to_completion)
> >  		mutex_lock(&intf->users_mutex);
> > +	if (intf->maintenance_mode_state == IPMI_MAINTENANCE_MODE_STATE_RESET) {
> > +		/* No messages while the BMC is in reset. */
> > +		rv = -EBUSY;
> > +		goto out_err;
> > +	}
> >  	if (intf->in_shutdown) {
> >  		rv = -ENODEV;
> >  		goto out_err;
> > @@ -2639,6 +2644,12 @@ static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
> >  	    (bmc->dyn_id_set && time_is_after_jiffies(bmc->dyn_id_expiry)))
> >  		goto out_noprocessing;
> >  
> > +	/* Don't allow sysfs access when in maintenance mode. */
> > +	if (intf->maintenance_mode_state) {
> > +		rv = -EBUSY;
> > +		goto out_noprocessing;
> > +	}
> > +
> >  	prev_guid_set = bmc->dyn_guid_set;
> >  	__get_guid(intf);
> >  
> > -- 
> > 2.43.0
> > 
> 
> Best, Fred

