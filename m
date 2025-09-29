Return-Path: <linux-kernel+bounces-836429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72816BA9A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC0F1C1A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3730B52E;
	Mon, 29 Sep 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfD6KdNS"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1630B500
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157112; cv=none; b=jD3OkDtueqsbLJd5B5afRY/utfbY8ag6pkZSGPi6wYpkO+sT3x4eNeG51y7YTkFD5YxPbOdFjgBAEJv8o3DZ7DmuRsHpBbDV5wmhSxuSCQ773zzDvjP12RAn81GHFXUrNMafU0d3RZ0o0R6gQPRn3lMMAF7vvcXKxQGDKHnFrx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157112; c=relaxed/simple;
	bh=bjxqZJBkr2pejLReLGp57GQuP/FODmdpY+jwUhgh3aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix5ROB1/ip1nFVqHw/7A6XamA8C9bGlDXG1Vp27MGhKMu4TBvkP1DUT53ohevwMZlo7XwF9JB9h1XDYcIq2DzoQcBF6ZDblnqyekSxXfARu38zWnsE/+L+mZ2snrzfxKZJ/1bzc7wFtn2xqfnMFzDgDD/ZmlzeRzA8S0nIl9cFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jfD6KdNS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b551b040930so3175436a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759157110; x=1759761910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDJrNu/87oxhFdV5g2mGhCBxbl9CU/Oxx1V95f1k0Lc=;
        b=jfD6KdNSWevOBFhVdANpOGnAFFHTBhIB1bWh0bLPFgPFFQA2SCqSZlqmhITzEKd/Qf
         KN4Az6HyDKlg04hxp9O6Czh36FOKXDT8fvuk3KbSKRUUkN9RQ87YbTA9/6dJ7FjqlC18
         TMxqSQhY2Rf9kP/iWbHJvNq1+oJd0ONKKuwmzuhAE8movg6IAGjsNOsVbkv45+jYFQ7a
         ChUPHZR0Y59hoKvqBMvS9ocxxUMaoMRZDOEH9ids5TPCOgnhy3gb95vVf6nMR/Zph+uz
         kyIS4n0cme4QuTiIFg9d9ZpCgnt59NttE6BamMCU8xZGQKXKyFpjagNpJuaEkRW3ycW/
         BEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759157110; x=1759761910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDJrNu/87oxhFdV5g2mGhCBxbl9CU/Oxx1V95f1k0Lc=;
        b=wvUbJ5y8MXaw2sOJU1OICw7dwH8nRIoeTPXFhCNUOdv8wkX9/r6HSk48sUF/UDRCgE
         +UumMYwO1M3a+GqVJ1gaZLGHW5e5LkmRWomkOMqAOY5awsF6opArX3z+xn55fhvvLQ/1
         GndaVCbHfdUJzOxcgM9FUdHhgT0kNGxoeYA9Nv14oBmXmGHACcLcWEsgV40A3irN1MDC
         xn6eKEYRkqkz7ws5j3C+r4TeBcqTuL9OGJG4Yw1DD5eWvB4BCO5ReFtV2G2okzQ+5Vsv
         MN/P+CCnrdX7bXtHqSWRoctIshfFBEUFfYUjSW119DWtovbariLscySU3skTgcqi17fR
         uJzg==
X-Forwarded-Encrypted: i=1; AJvYcCXKY9Hb2sXD+Emc6bAn2RjqmvNMfj+w0I4OtneDANYKNWXy0wal4HbcC01gspwxpUixW02BjORGEtHtpwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtOrmqFL5jYs1t2MVwaMi3HaF3iHz2Gb+nNnnoV6zGGv/EOXIm
	3WyI2XnQFxvuJjIg09gnHyeSq381gerGJotSGs1a3JC+j1g7UwVSlDHwHPIBq+MkABM=
X-Gm-Gg: ASbGnctl6s5s1hamiHoGDmVpYBNmvmhi6V/4GjGdxt09TW8u4C5Gea0n2Hz1HSgk1PH
	jpQXmsMcoahmgMMaNIJcAC3XcIE9SMy79PetlhAEf5YBNSLDshZNHPD2TaIza1eWceOr0epeImz
	lVGh8Fl/KvrqpbPjb55t8kQHdt0yscC5khPnjQ9Lxa+hO1EMtHnC25+eLCDNEb6m3A9QF6+lrKg
	2u5fnRV2FYTP8RlWd/XJHrCkYl94kdSv/XYVBuamL1Ym/T8DNA+czL+5ahkQ6SfciRBsXl5Hq9/
	PhrgEVUc79VjEDA5L+CQiQndcXkuYUTTuKYUvHL9ORMP3WIkLu5wNd2PAiGBpw19rfB0WAAOtdK
	fmCRurufOkkSWQO6WxkXHc+Bv5w/6YcoRtQYrZJ1UZqRLRART6iHUrQnbUWlTSzm0qoPBpOLvWv
	m9LOMx6UpPW/fC2VZOiCZKzdQ5
X-Google-Smtp-Source: AGHT+IGStDkVMSVVTnzQVSh3FuJHIMb8NmKtFl3BQOoTbaB7Lrsqqm0cwlWfm9TkpnyXcPEyZALIpA==
X-Received: by 2002:a17:903:faf:b0:27e:f16f:61a3 with SMTP id d9443c01a7336-27ef16f627cmr117331725ad.23.1759157110103;
        Mon, 29 Sep 2025 07:45:10 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:385c:dafa:52d5:8bf8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53cb975sm11720855a12.18.2025.09.29.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:45:09 -0700 (PDT)
Date: Mon, 29 Sep 2025 08:45:07 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Tanmay Shah <tanmay.shah@amd.com>, jassisinghbrar@gmail.com,
	andersson@kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] mailbox: check mailbox queue is full or not
Message-ID: <aNqbc5Q_tVStXkhI@p14s>
References: <20250925185043.3013388-1-tanmay.shah@amd.com>
 <20250926073735.GD8204@nxa18884-linux.ap.freescale.net>
 <e93f0ee7-687a-4f47-a847-90cc1ea87290@amd.com>
 <20250928075641.GA29690@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928075641.GA29690@nxa18884-linux.ap.freescale.net>

On Sun, Sep 28, 2025 at 03:56:41PM +0800, Peng Fan wrote:
> Hi,
> 
> On Fri, Sep 26, 2025 at 10:40:09AM -0500, Tanmay Shah wrote:
> >> > ---
> >> > drivers/mailbox/mailbox.c               | 24 ++++++++++++++++++++++++
> >> > drivers/remoteproc/xlnx_r5_remoteproc.c |  4 ++++
> >> > include/linux/mailbox_client.h          |  1 +
> >> 
> >> The mailbox and remoteproc should be separated.
> >> 
> >
> >Mailbox framework is introducing new API. I wanted the use case to be in the
> >same patch-set, otherwise we might see unused API warning.
> 
> I mean two patches in one patchset.
>

Agreed
 
> >
> >Hence, both in the same patch makes more sense. If maintainers prefer, I will
> >separate them.
> >
> >> > 3 files changed, 29 insertions(+)
> >> > 
> >> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> >> > index 5cd8ae222073..7afdb2c9006d 100644
> >> > --- a/drivers/mailbox/mailbox.c
> >> > +++ b/drivers/mailbox/mailbox.c
> >> > @@ -217,6 +217,30 @@ bool mbox_client_peek_data(struct mbox_chan *chan)
> >> > }
> >> > EXPORT_SYMBOL_GPL(mbox_client_peek_data);
> >> > 
> >> > +/**
> >> > + * mbox_queue_full - check if mailbox queue is full or not
> >> > + * @chan: Mailbox channel assigned to this client.
> >> > + *
> >> > + * Clients can choose not to send new msg if mbox queue is full.
> >> > + *
> >> > + * Return: true if queue is full else false. < 0 for error
> >> > + */
> >> > +int mbox_queue_full(struct mbox_chan *chan)
> >> > +{
> >> > +	unsigned long flags;
> >> > +	int res;
> >> > +
> >> > +	if (!chan)
> >> > +		return -EINVAL;
> >> > +
> >> > +	spin_lock_irqsave(&chan->lock, flags);
> >> 
> >> Use scoped_guard.
> >
> >Other APIs use spin_lock_irqsave. Probably scoped_guard should be introduced
> >in a different patch for all APIs in the mailbox.
> 
> Your code base seems not up to date.
> 

Agreed

> >
> >> 
> >> > +	res = (chan->msg_count == (MBOX_TX_QUEUE_LEN - 1));

Please have a look at this condition again - the implementation of
addr_to_rbuf() [1] is checking for space differently.

[1]. https://elixir.bootlin.com/linux/v6.17/source/drivers/mailbox/mailbox.c#L32

> >> > +	spin_unlock_irqrestore(&chan->lock, flags);
> >> > +
> >> > +	return res;
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(mbox_queue_full);
> >> 
> >> add_to_rbuf is able to return ENOBUFS when call mbox_send_message.
> >> Does checking mbox_send_message return value works for you?
> >> 
> >
> >That is the problem. mbox_send_message uses add_to_rbuf and fails. But during
> >failure, it prints warning message:
> >
> >dev_err(chan->mbox->dev, "Try increasing MBOX_TX_QUEUE_LEN\n");
> >
> >In some cases there are lot of such messages on terminal. Functionally
> >nothing is wrong and everything is working but user keeps getting false
> >positive warning about increasing mbox tx queue length. That is why we need
> >API to check if mbox queue length is full or not before doing
> >mbox_send_message. Not all clients need to use it, but some cane make use of
> >it.
> 
> I think check whether mbox_send_message returns -ENOBUFS or not should
> work for you. If the "Try increasing MBOX_TX_QUEUE_LEN" message
> bothers you, it could be update to dev_dbg per my understanding.
> 

This new API is trying to avoid calling mbox_send_message(), no checking if it
succeeded or not.  Moving dev_err() nto dev_dbg() is also the wrong approach.

> Regards,
> Peng
> 
> >
> >
> >> > +
> >> > /**
> >> >   * mbox_send_message -	For client to submit a message to be
> >> >   *				sent to the remote.
> >> 
> >> Regards
> >> Peng
> >

