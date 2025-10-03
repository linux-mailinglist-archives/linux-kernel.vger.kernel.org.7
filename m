Return-Path: <linux-kernel+bounces-841453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4574DBB75A0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EF94873B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FCC2857FA;
	Fri,  3 Oct 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="DGk6b4cT"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16091E515
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506204; cv=none; b=kem9a5l9mBhymVU880vj5dlrYV6I+L8EvRi8jiPNDHuawznF+5Zux7HoMn93eKK8m3xz0hvSGTBDr9WeBKzKzoipEdiktiB5vuXZbTREpdRkOLB29MafuAqn9n48T+vF/zdKYzfzK4Q01MQ/kdqYeebYv6z2suLoaCndeYYFeYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506204; c=relaxed/simple;
	bh=PmNKqZB+PaolN2/icU45FIretvOy2SBwE1tVRXL0Ctw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNNCeXlYtI16XcR0bGlqen06J0dPB82jG9uKUKxM5xKQ6pitGtI027paI32kcldzwoKtkXrjwkgyx8NKgAFsQnTEixYSkCjpFxCvRhkjpuS9m49VpL4ZzjnAEmpeoBzTVA64xCo4nQtZtHvapaQv3q/HpGhToqCs3hvjCAVYzTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=DGk6b4cT; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-43f7e0494ecso1326170b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1759506202; x=1760111002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAGtpcOJ2IYN1BCdZDhmCcvLW4pOUHf47FweOs5VSH4=;
        b=DGk6b4cTEoAfhOEVqPAVfvL8Y3MBtH/0b1jGHeCfiBhjmhgjP5r9Jn1vxFTkWym1vB
         bfUl5mOwLaKGRiU2p2m3SDGKFDSbHdNYSweetUsrUHc7kPm2wv97Mk63ZmVCT3pgTt4v
         qSEpt8UjVJT2m+vIqoQtUlYFT+dhJQ6/D5POYxdOCJaj9nsUFtbLLUDEi7FFN3XKJgZs
         AiM5AqxfTsgi9mKazaJiaju+xKRbIKBFwg+FGFCvGSLX/hyegev89KtsACkZjegzVlKO
         kViLlpv0O36rcXhd1y8HnUc5DpLvUudvHeZPpGclksh4CDO9INOGavWxrB7usGW8B8JB
         Rn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759506202; x=1760111002;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAGtpcOJ2IYN1BCdZDhmCcvLW4pOUHf47FweOs5VSH4=;
        b=s2qqwm5CZojlfRj0NBIOL5l33rJU6iPhjoK3DoHJfX19nPsXnPxUCUWJC5W9GLOxRG
         Wd70/7KSkg2gWpZcA8Pw50O44W3kJAyAlus8vlEUi5EtQvuW+h48oRPpVZQQ9BxtLFWe
         S7NGaqyuWyEos0Cm9rKQHqOPQhqzGycfVZtICDuOXQ3BTk3r4+oB/2L4gc+xTfUrhgXe
         NCzoIfIrGeKoehiXzigRXSXVJJH6BfcjgbCpp9JyQ9ZzNS155IywJmK4QuBYgc2R8bsQ
         U3LsyAf1Q0SXg4AUhjqJh9VP9eXGZ9DF1jy0qyanV3Fw2i4973WDMBxhD5UFLAw8zVpz
         h1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4p0Eco2R6/cI35NlPMAbvHJtXyQF8dKCdg+fJWiDMQbYsSbg04pV4kUeeX6A5Q8EJYyvrEyJj214FuGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcHGDQ2DUlqKtzEF7xsFbBjC5Fv3ktRwlqbV2pGp9W6zQoPvks
	ChSiDyXdqzrxDT6mMqhKXkeEPPPIkDIu9ZoSbQRcepgbjhEFYE7Sv8hz/t1Me4I+6MESGQNvvJ2
	6NSjnqmA=
X-Gm-Gg: ASbGncvzV2MY4s13EP1TotduLoDKArvcYh4bv0BY1yI/6TDn4EmO3ppuxGt9X3bpDRg
	QnTry62LnVHtTBzVvG7izlvBADrS0JBD/gnyixuNqyKmf0zBsHCQJlNxBkJuqqG8HOp/3tRWJ4N
	ffCoR5PCIC/2W/m2LCIPR50dHghAg0B7GFynofIPH45dc272qDzqpgTM3XT9H5mcUdjcR9S2tkG
	0VpiKkC1O4w3wSr8XNtBoBUz6IIxClIcuzCO+QxV8E8bpJzgZoO2ZVhHWaaSu0NCFOJCfnowLxy
	flgv0TMJ0Y81Y9bTzxRayWSBMLGYWtBDcULRvc5XPNz8+Y7eOYGw780mxVbJ1jzhAvLb/OGTQkt
	RSHUpmFUn4I1aFkR8cqqEd1eO1fbL/JcsffH1yP4pr1V1OxC0kBGtuS+H65hc
X-Google-Smtp-Source: AGHT+IFbJkATFtfDDCaGhZCKFa0SXFgs+2NyZrjUWzowyBwJrBYN44tBdXJMH5ef1Ybjei3cps0Jow==
X-Received: by 2002:a05:6808:218a:b0:43d:28fd:610e with SMTP id 5614622812f47-43fc173bbf4mr1719340b6e.9.1759506201906;
        Fri, 03 Oct 2025 08:43:21 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:d469:1917:5c33:260b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf6c8e9987sm1262405a34.12.2025.10.03.08.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:43:21 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:43:16 -0500
From: Corey Minyard <corey@minyard.net>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ipmi: Close the race between __scan_channels()
 and deliver_response()
Message-ID: <aN_vFKhMi0tDT2rK@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250930074239.2353-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930074239.2353-1-guojinhui.liam@bytedance.com>

On Tue, Sep 30, 2025 at 03:42:36PM +0800, Jinhui Guo wrote:
> The command "ipmi -b -t" would occasionally fail:
>   #ipmitool -b 6 -t 0x2c raw 0x6 0x01
>   Unable to send command: Invalid argument
>   Unable to send RAW command (channel=0x6 netfn=0x6 lun=0x0 cmd=0x1)
> 
> The race window between __scan_channels() and deliver_response() causes
> the parameters of some channels to be set to 0.
> 
> Fix the race between __scan_channels() and deliver_response() with the
> following changes.
> 
> 1. Only assign intf->channel_list = intf->wchannels and set
>    intf->channels_ready = true in channel_handler() after all channels_ready
>    have been successfully scanned or after failing to send the IPMI
>    request.
> 2. channel_handler() sets intf->channels_ready to true but no one clears
>    it, preventing __scan_channels() from rescanning channels. When the BMC
>    firmware changes a rescan is required. Allow it by clearing the flag
>    before starting a new scan.
> 3. Channels remain static unless the BMC firmware changes. Skip channel
>    rescan when no BMC firmware update has occurred.
> 
> 
> v1: https://lore.kernel.org/all/20250929081602.1901-1-guojinhui.liam@bytedance.com/
> 
> Changelog in v1 -> v2 (suggested by corey):
>  - Split the fix into three independent patches, each addressing a
>    separate issue.
>  - Clear intf->channels_ready only when the BMC firmware changes.
> 
> Jinhui Guo (3):
>   ipmi: Fix the race between __scan_channels() and deliver_response()
>   ipmi: Fix __scan_channels() failing to rescan channels
>   ipmi: Skip channel scan if channels are already marked ready

I have these queued for 6.18.  I need to re-review them; that will
probably happen later in the cycle; I can't put them in until 6.17-rc1
releases.

Thanks,

-corey

> 
>  drivers/char/ipmi/ipmi_msghandler.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> -- 
> 2.20.1
> 

