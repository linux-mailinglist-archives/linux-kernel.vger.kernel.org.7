Return-Path: <linux-kernel+bounces-820548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA80B7C70B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A0F164BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EAF24A06A;
	Wed, 17 Sep 2025 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JD/h670i"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF42DEA74
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107807; cv=none; b=iO4EqUWfCxUEakcpWe3k+QPglxcqzYyohNGmirfTkYFUqB9lOlkaBAF0CkYHx0bLRLMllHIVP+odP1g6VsotVJ7bcNGG819XkRhsphn9tHDU5AlI3k7rs5Iwp4ACogJWBqC4zLBB7tJbnDydCEu6Q0GC6TvHX68O845huRjzcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107807; c=relaxed/simple;
	bh=V7DSFThcWOL031kOhRZSDL6u8F3ywlLhFKRAxEYz6/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y94dT6xOtvgdg/k4UaD7vtrbNlkeMzem9cLJNnnVIQG0YZcuuMl9CnoQH/EFXrj5EK0Aqj6fVbcaEXyHwBKbnv5s0foes2m7dVVmY/1V5psG1Gl61k3gVKGZtiAzfH1Pnk50f3BSWJQ0KwWMzR95Vd8O1XXEp4b8+Bl9FhH2Yes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JD/h670i; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso4109530a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758107803; x=1758712603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5+QCfd7AnWxO1Uiu+yxEm6oSJQvuzcwXael9gAjARo=;
        b=JD/h670i9hlkK2XcCsZ+jIwKVOxk3AGf95Cn9Y7DtdkhcIW3KmcUv5JCbFLL5q4I8L
         Mj3gGICtLPjAbujkdIxShmPtvzSprhea2aMbulILb8AOLwFrQXpXiHyJR0T4GtLXPxLT
         77ch/8Y3NnKIH7KssMb28JMbbBxtEuhemH2mMwZpQ6raPjc2NNFcZYrZZoC8UGWAERf1
         uHOJsMXzRCrTp3C1/UrWwywkSTw9PylcVILwgEHthwVXSRsSxfzHCD8AF7v6u71Ol2bz
         6yWHL27pbxUreKbAoQfLYFlcSWIzqP7XIEpov0Mh7ZsobpdR8Gee3IkH5ATVXGJ2V+3j
         eTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758107803; x=1758712603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5+QCfd7AnWxO1Uiu+yxEm6oSJQvuzcwXael9gAjARo=;
        b=T4M9DNgCmXoEYWSnEYerqJfQ2OfJwREamO/f++nAXzFNbHzgAu2X0C7F1ipfFP7Npd
         ryYvGFMooW7K6BS2Cq+oOpuON9cv2KBXjtO4zFrGzoJXooCozN1ePZNwEnY98EFsC8+2
         Xq+p38CSWiK0Lr6pffdXlBSqIP8MDom8PXdF6KEHP2HzAC7zXQdFc5cI6TyPCml06Om3
         eubni1ss96DPlW98S2zXATfYoyFDj0b22qZyhjFVDCYQB21cjSOH9HXdzZxfT+V7T5Rw
         pxUmify7O2Ftx15d1aIWxiXJehge8ZD6Gz/imHTPs7NzNXyB8oOC/FMoLzeGU1EHCyyJ
         qMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYGlpna81Ny3COQ8kXrllXOMiswvtjQ25wwfwHnIxxdSZRjpARQXwHbgLUAJPVrl3G4/aP4zVU30f5Ff4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwCD2jymi6n78BCwN2QnxfTjZNce6yFlFhhLYxFKd1BiN6Fub2
	ycgErb0Lvu/33ZBwgdVDwRsSLtzxV8d7VMN1sE1ThoXG0UtSqCGbxPhBKBuLARPkwo0=
X-Gm-Gg: ASbGncsgJmgTH0GtuyLVEsdIeI8Tku5s8QKADht1g5Fn63Y8jVZQgE04/xBSSjx14Uz
	iSOKO26wGyfKaAj786tStdiIef1js19IiSFvVMhNNdasqa5Xnsa0jXCapSKZDclzvcR3/RvTgJT
	dzwTtlBcRRS5Q21JI9OX96TPv8u/Gav2+W1tT9rvixFs6DKFtwaIMMzQNAOZwUyDYzveIrWZQoJ
	t9Tg1IPCAIZf133KnHy/Txu0XjKHJYmxVftpCnM+xkwuE1mlYZ9sBfhao29tJTFelXXQgrXfWLI
	YCRog2hCiwKpuoGbW6NcmeH2Gmr7tpLuyNR75LwcMcxYlr0cZewilCZuVf17ZE6G+QKvYUV9llA
	DpJ9pfVH77EPQ5+4+bT8UAmVgSWHIdU3hzMM0
X-Google-Smtp-Source: AGHT+IFZy3mrCBpGywWYVRXU0ddDyLdCUVYtaMmLkV94TwlEwWXV8sRWsTgucNxGxD0epFiNoK0USQ==
X-Received: by 2002:a17:906:dc91:b0:b04:48c5:340 with SMTP id a640c23a62f3a-b1bb43380a7mr171298366b.9.1758107803558;
        Wed, 17 Sep 2025 04:16:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f22b1sm1361332966b.86.2025.09.17.04.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:16:43 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:16:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v4 2/5] printk: nbcon: Introduce KDB helpers
Message-ID: <aMqYmaqMSohDluhZ@pathway.suse.cz>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
 <20250915-nbcon-kgdboc-v4-2-e2b6753bb566@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-nbcon-kgdboc-v4-2-e2b6753bb566@suse.com>

On Mon 2025-09-15 08:20:31, Marcos Paulo de Souza wrote:
> These helpers will be used when calling console->write_atomic on
> KDB code in the next patch. It's basically the same implementation
> as nbcon_device_try_acquire, but using NBCON_PRIO_EMERGENCY when
> acquiring the context.
> 
> If the acquire succeeds, the message and message length are assigned to
> nbcon_write_context so ->write_atomic can print the message.
> 
> After release try to flush the console since there may be a backlog of
> messages in the ringbuffer. The kthread console printers do not get a
> chance to run while kdb is active.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

