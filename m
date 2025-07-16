Return-Path: <linux-kernel+bounces-733738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DDEB0786B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1BF17E7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC68233148;
	Wed, 16 Jul 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="qR9e+qTU"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5B19DFB4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677112; cv=none; b=jfMa0xbUsUNvr0k5SG5cXJkW9m8Agib7A7E35izXpB9kW1+KDr1QzcL0SMb1N/JMo/enMR1wDNFvahiDiwdkMDjGPv6UIKH6d+ot9K2c5RJohDyUhdfoXbG01kts32H8FfgC3+OBN6SDS9UtxOcGT167pr9+lgvUOhxx7e2cBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677112; c=relaxed/simple;
	bh=os5pnyLvmgjenphxs3CGL2/AWXjrv8Tb7g4pfJ6PBDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfDO+9IurvXwyvh9J6H6vNaaOxIX8Emjzaw4D7WxuR5EhEoTaZfEDvXja2qaam7ob8DlXidYan1RpA4sdPThAJUmFSFiaNJumA7bwZvxvhGB1fHOXMPLauqdnzdwE8U1EuPMBqv1kXkdZtqkTXFxheWWVAEg1xthmYO9XrLDynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=qR9e+qTU; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fad4e6d949so81586d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752677110; x=1753281910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e02i2KWG6c9SYCNIMMjw9if0xxxvkhtuw0NvkIv0Xm8=;
        b=qR9e+qTUfUI1QS0Mq77Kdj906LReakvOFfkz463HwRwthH8DqnzzwDO8qM12VwAD+F
         hTCiLNdztP5CEM4zp+tR7GfH6Ne/p/alT0lRHrdHvLN+BubQ5xirRBiMRfbn7JPP7aOJ
         4De9tk59mLbUL0G/f9/y0/0V8xyw/Nv1fIOCGv4yBDQyITxArv9vB5+vC1TFusObzYWu
         qEzxRhWHxs7fnsHZ2JVo8ddAovMP+lcaQuqktwIZ6NeF4d6nQnHbACxmLfzxunxHWLEU
         4jIqO/kcPJ5uzr/aVNfe+az3LP/CSu3AHUYEtPpNnnwJhj9Qqib7t9d3oSXgSme8I8Vc
         YAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677110; x=1753281910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e02i2KWG6c9SYCNIMMjw9if0xxxvkhtuw0NvkIv0Xm8=;
        b=UzKxde+TYXlqJNM7SI+MwEqVGyCqxGcrvtOT1MisPs1Hag7tVwbIiSLOwpZlTGW6kF
         klYciK2005lsdRqES/G1SMw4WMPk9q/TS1dMuztWBtvKGq6g0J5mqWdYx2puayh/HF2/
         zYesb6Y/kSQEnBNe3quRClVZi26UF1ceOPJEDSO5zB0f6i9KL4HR8b0FFgGJPLeh2b8O
         RUrg8uTNzV5tc5W9JF+lOJCzoUbXaT4ZtzNQBZNJuhuWaF8I4cQlWGfhWztKegtNsikr
         0SgVJ4ylEJWMhdCiDaJJuO9l7H2tjcq0BxpnAcRjNz9cVTIceZEUjgmTs+PmFl0Ks+zb
         RUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWejIrkhxIzQXbIZZhftLQZNB/YMWm3vWz86ra3agg4NYi1zHEsLywkC/AeZuG5cVV1TqDSGiQu4fwy7VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQxXpmnsJr8MEQT7EnkkjczQjlrfj2IMLG2kdpd9oM+4Lej/BB
	za9TwUnyY2M6XtqKF9S8yNWBuovqTe2K67ZAkBGPAXNai9fZznG8kCnAD3T2a0Iweg==
X-Gm-Gg: ASbGncu4DzKxxBagj0oWlEqppYdJFAVKyzd52tsazEyJy9jsiGVLlyq8tY1RGYa6mq+
	30Zm0N0FJh+iaFZHHdant3hwe36liAjQfmwSi3K2j41zRNw1KWqTZM0IxETwYBTuTigCZF7tR5c
	D7n1lMZj8MpW+MMIKqBGtfzBuIEWsQmbre4aj+9OolQPACZCR4K/J+fxjMO80XqFpu9T3v1TV5Y
	WRJClOr4P303dixluuQ9c9GWuzCIX+tUPGc3zdPQZ8LMtDuCQDKyCLEkXDu0L+3pUJU631Iw95X
	po3LFIxUDxDen/HlhamcCn7ckh8j7q4mLTUm8Uhx/WERTgigfk5TuG0KH7aF2LAXFiX3HAHt4JR
	PAgmyqUcjXhl7eFvMKSd5qPCCy/da2dmcGM1ywZAZ
X-Google-Smtp-Source: AGHT+IEo3wdazozYwME5fp8ZNlZIRmwvesEY8KgK+fi4IHibx/EBZTw888cTeFgAL2M6wHL3/ojohA==
X-Received: by 2002:a05:6214:248f:b0:700:c179:f57c with SMTP id 6a1803df08f44-704f6aebc0cmr48586566d6.38.1752677109215;
        Wed, 16 Jul 2025 07:45:09 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e42f7sm70950846d6.45.2025.07.16.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:45:08 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:45:06 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hillf Danton <hdanton@sina.com>,
	syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] media: imon: make send_packet() more robust
Message-ID: <2c34ff38-d41a-453d-ae2e-87dc58f27a14@rowland.harvard.edu>
References: <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
 <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
 <20250713081148.3880-1-hdanton@sina.com>
 <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu>
 <aHa3xpKfGNqAocIO@gofer.mess.org>
 <c4e88c28-28ee-4e37-9822-8e2999d0f0ee@rowland.harvard.edu>
 <aHdzD7EowAKT4AhQ@gofer.mess.org>
 <a44d5568-48d6-44f7-af93-e1b966489a84@I-love.SAKURA.ne.jp>
 <aHefSptAPBoRG_20@gofer.mess.org>
 <c83f37f2-a0d5-4c3d-b311-a3bc8ae142c9@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c83f37f2-a0d5-4c3d-b311-a3bc8ae142c9@I-love.SAKURA.ne.jp>

On Wed, Jul 16, 2025 at 11:07:17PM +0900, Tetsuo Handa wrote:
> syzbot is reporting that imon has three problems which result in
> hung tasks due to forever holding device lock [1].
> 
> First problem is that when usb_rx_callback_intf0() once got -EPROTO error
> after ictx->dev_present_intf0 became true, usb_rx_callback_intf0()
> resubmits urb after printk(), and resubmitted urb causes
> usb_rx_callback_intf0() to again get -EPROTO error. This results in
> printk() flooding (RCU stalls).
> 
> Alan Stern commented [2] that
> 
>   In theory it's okay to resubmit _if_ the driver has a robust
>   error-recovery scheme (such as giving up after some fixed limit on the
>   number of errors or after some fixed time has elapsed, perhaps with a
>   time delay to prevent a flood of errors).  Most drivers don't bother to
>   do this; they simply give up right away.  This makes them more
>   vulnerable to short-term noise interference during USB transfers, but in
>   reality such interference is quite rare.  There's nothing really wrong
>   with giving up right away.
> 
> but imon has a poor error-recovery scheme which just retries forever;
> this behavior should be fixed.
> 
> Since I'm not sure whether it is safe for imon users to give up upon any
> error code, this patch takes care of only union of error codes chosen from
> modules in drivers/media/rc/ directory which handle -EPROTO error (i.e.
> ir_toy, mceusb and igorplugusb).
> 
> Second problem is that when usb_rx_callback_intf0() once got -EPROTO error
> before ictx->dev_present_intf0 becomes true, usb_rx_callback_intf0() always
> resubmits urb due to commit 8791d63af0cf ("[media] imon: don't wedge
> hardware after early callbacks"). The ictx->dev_present_intf0 test was
> introduced by commit 6f6b90c9231a ("[media] imon: don't parse scancodes
> until intf configured"), but that commit did not call usb_unlink_urb()
> when usb_rx_callback_intf0() got an error. Move the ictx->dev_present_intf0
> test to immediately before imon_incoming_packet() so that we can call
> usb_unlink_urb() as needed, or the first problem explained above happens
> without printk() flooding (i.e. hung task).
> 
> Third problem is that when usb_rx_callback_intf0() is not called for some
> reason (e.g. flaky hardware; the reproducer for this problem sometimes
> prevents usb_rx_callback_intf0() from being called),
> wait_for_completion_interruptible() in send_packet() never returns (i.e.
> hung task). As a workaround for such situation, change send_packet() to
> wait for completion with timeout of 10 seconds.
> 
> Also, move mutex_trylock() in imon_ir_change_protocol() to the beginning,
> for memcpy() which modifies ictx->usb_tx_buf should be protected by
> ictx->lock.
> 
> Also, verify at the beginning of send_packet() that ictx->lock is held
> in case send_packet() is by error called from imon_ir_change_protocol()
> when mutex_trylock() failed due to concurrent requests.
> 
> Link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a [1]
> Link: https://lkml.kernel.org/r/d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu [2]
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---

Making multiple significant changes like these in a single patch is 
generally a bad idea.  It would be better to split this up into two or 
three patches, each doing one thing.

> Changes in v2:
>   Updated patch description.
> 
>  drivers/media/rc/imon.c | 69 +++++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> index f5221b018808..3469a401a572 100644
> --- a/drivers/media/rc/imon.c
> +++ b/drivers/media/rc/imon.c

> @@ -1761,16 +1756,30 @@ static void usb_rx_callback_intf0(struct urb *urb)
>  		break;
>  
>  	case 0:
> -		imon_incoming_packet(ictx, urb, intfnum);
> +		/*
> +		 * if we get a callback before we're done configuring the hardware, we
> +		 * can't yet process the data, as there's nowhere to send it, but we
> +		 * still need to submit a new rx URB to avoid wedging the hardware
> +		 */
> +		if (ictx->dev_present_intf0)
> +			imon_incoming_packet(ictx, urb, intfnum);
>  		break;
>  
> +	case -ECONNRESET:
> +	case -EILSEQ:
> +	case -EPROTO:
> +	case -EPIPE:
> +		dev_warn(ictx->dev, "imon %s: status(%d)\n",
> +			 __func__, urb->status);
> +		usb_unlink_urb(urb);

The URB you're unlinking here is the one that just completed, right?  
Which means it's already unlinked, so this call is unnecessary.

> @@ -1802,16 +1803,30 @@ static void usb_rx_callback_intf1(struct urb *urb)
>  		break;
>  
>  	case 0:
> -		imon_incoming_packet(ictx, urb, intfnum);
> +		/*
> +		 * if we get a callback before we're done configuring the hardware, we
> +		 * can't yet process the data, as there's nowhere to send it, but we
> +		 * still need to submit a new rx URB to avoid wedging the hardware
> +		 */
> +		if (ictx->dev_present_intf1)
> +			imon_incoming_packet(ictx, urb, intfnum);
>  		break;
>  
> +	case -ECONNRESET:
> +	case -EILSEQ:
> +	case -EPROTO:
> +	case -EPIPE:
> +		dev_warn(ictx->dev, "imon %s: status(%d)\n",
> +			 __func__, urb->status);
> +		usb_unlink_urb(urb);
> +		return;

Same here.

Alan Stern

