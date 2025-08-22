Return-Path: <linux-kernel+bounces-782072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08854B31A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32870B026E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97773074AF;
	Fri, 22 Aug 2025 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="p8zbifub"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF42FE58C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871017; cv=none; b=CCtZKeazLOgpwpwGHtUHieqkIXJliGDRnCHxLW0+FiUSRcVVaoB6Gn8Hmw1AeeqmQwS+s89BEqRK0I2CKCaaQuP/yUxJZN1NNG6a8yT4iUrMmhkvkyWS2Pmj/3bThdLjHFjLMAAV/p9l29Nor3VYcBwrsobicc/OLvCC7qK9bDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871017; c=relaxed/simple;
	bh=Z38lZ8HTjUBjB4ep5770vP6LsmNBlzJ7QTHWWCYh6S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdOImhhHfN6basASxU1rGO6g7zDSaXUDFpxaDUUHWbiHpMDqKhQQV/xl7ez44D6/4b+JfSo/YzG1dj1b41HRS3IaynijFdT90dKzbcYwPGiqKoqBx2P5BBWfHdtqk1d5Yd1iGZOB0OfY7s9eemSlYONW9aVpqykDOChLpvPsY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=p8zbifub; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e8706a6863so255141585a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755871013; x=1756475813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZYV/lOVxyLopKkodxehHImvjO52GrrOsoxMKVsFDgs=;
        b=p8zbifubRHUjF/Nwk2M46Fww9EdZZ084fydB2uzrVQ/8N0mf9SU8Ksf1pOMxHNOFQp
         rpklAfkTZQaxZHxWlztRMdwVHNfxsFDOqvQHRa3FV+S9FfV+j7XWwMCfJyi4GcgVHf9B
         lR4zumfVa94+tkJLzijSuZVZk349zmunsRSymVO/2g8eqwx2znQk3Vq4r8r2ad3SNggv
         nPzxxrqRI+lOMfP7YZZ7mX71EwxUULQKZE2A7X+Wfg71lH/gWuitv5AInXALeswa+BhK
         REshncUro+kGRaQePdPEpzz0FVlCfHp/ku+7bSK5i+NrSVBHhHY4aPf8uaWcWumZn1cz
         S0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871013; x=1756475813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZYV/lOVxyLopKkodxehHImvjO52GrrOsoxMKVsFDgs=;
        b=Iv6JPmlav6DbVNQvR8p56hnItr2N6Y7LGq0qcMvf9WfneMwxdqTGU95nARhMq0Z2sN
         BRebkpEsH6mpeCkr0HazYbJQ3NNrd2BZc/CUIyL8fzi/mYMs6mQeCIVSrhDulMid1A/W
         6bYXovn+TK5RjLWWH6OdwbfD5u0kGyUa+wvePnwMtIfGr7bn4IG5fPo7CEK1OhwCiL5R
         Pr4L59yY870NNCaXx/pqCLqstQ9aUuQlp5uKLIdpW2Vg0C7qYvDmS2swTmUMFaM6iwCb
         R3f4geGUdpwclnZGSfGvgIqtiYKqkQ+WsXyOTcht4jw02oxRc27z6DCmvhEpIc4/5m0n
         VFtA==
X-Forwarded-Encrypted: i=1; AJvYcCWdpqrEaltpmrP0I4P5pD6jg+Wc/EmetsQtYnBH6h4ubfbZku9Lre+7XMBMRck3PYXMWgrMWvQSKdEOwRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/K2Y8XBV8QLK+ays9I5TwEo0RzrlsHc7i/Lw+qlJfOxASKrMQ
	cKOQAyooOZkeludBOrNl1N/xHew3Gt8zhsLcIPqLmikvT59p0xeTIeq0dPpcFA08zw==
X-Gm-Gg: ASbGncsqlT6ZhhUNGhZ7kgfLb3kp703KC2To+xqTsg0JwWG7GuiE8h8Gls87EDzUgpA
	PTPEbwW75qzJO0uy4w0T/yPAyvVfoJd4BmE2fGp7JNSVH3Nba/vtAilanaubUdD2blb3j3h0kga
	QTxW4QjJ8u6V2nkMpNull3kGSMMNsC/hKBsoiNdOPooWYEuTBolK7gv2UQn4bfuHJRDVI46iAI4
	GwP1U1DUDeEVqgIlRCV59ZxrQ8zlMJINMdX7mow00YIr9MJFi3pjYb7iM5mvoXYMaOaL3neruip
	UkMF36iG+m9l2/XkHkBx41FUZVJjtdbDf3meWaEUpGS7C9w2TVLOHSKSrA5lj1mxP7vE7B19LZU
	3Cixpe/qDCACYHtPgyIqaH3r3aday
X-Google-Smtp-Source: AGHT+IEenma9Vbx+kv/9/x3JbF+/IZ5+YvWnnHq6SX8M5lkdxgGOoJ4n+r2TlUe1OinW734nthus/A==
X-Received: by 2002:a05:620a:4003:b0:7e8:13ef:2b33 with SMTP id af79cd13be357-7ea110445f9mr348465385a.59.1755871012947;
        Fri, 22 Aug 2025 06:56:52 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:156:8000:24f0::3e8c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e04f43csm1322495585a.19.2025.08.22.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:56:52 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:56:49 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: William Wu <william.wu@rock-chips.com>
Cc: gregkh@linuxfoundation.org, Chris.Wulff@biamp.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	frank.wang@rock-chips.com, jianwei.zheng@rock-chips.com,
	yue.long@rock-chips.com
Subject: Re: [PATCH] usb: gadget: f_hid: Fix zero length packet transfer
Message-ID: <c09f21ee-be83-4880-841b-70e1e5c036f0@rowland.harvard.edu>
References: <1755828118-21640-1-git-send-email-william.wu@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1755828118-21640-1-git-send-email-william.wu@rock-chips.com>

On Fri, Aug 22, 2025 at 10:01:58AM +0800, William Wu wrote:
> If the hid transfer with size divisible to EPs max packet
> size, it needs to set the req->zero to true, then the usb
> controller can transfer a zero length packet at the end
> according to the USB 2.0 spec.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 8e1d1e8..8021af3 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -511,7 +511,7 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
>  	}
>  
>  	req->status   = 0;
> -	req->zero     = 0;
> +	req->zero     = ((count % hidg->in_ep->maxpacket) == 0);

Here and below, there is no need to check whether count is divisible by 
the maxpacket length.  The UDC driver does this for you automatically.  
(See the kerneldoc for struct usb_request.)  Simply set req->zero to 1.

Alan Stern

>  	req->length   = count;
>  	req->complete = f_hidg_req_complete;
>  	req->context  = hidg;
> @@ -967,7 +967,7 @@ static int hidg_setup(struct usb_function *f,
>  	return -EOPNOTSUPP;
>  
>  respond:
> -	req->zero = 0;
> +	req->zero = ((length % cdev->gadget->ep0->maxpacket) == 0);
>  	req->length = length;
>  	status = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
>  	if (status < 0)
> -- 
> 2.0.0

