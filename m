Return-Path: <linux-kernel+bounces-725857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C3DB004A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851D07B0126
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A982186359;
	Thu, 10 Jul 2025 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="b/7wNaxc"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9B21CC56
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156370; cv=none; b=YtPe+sLujcRWEu90HS3Zn+7/PazHQXYCivGX1jI6SeKDd3Q1BhDV0SHyPrt1nbsFaKKitmhgT5kWSVpisoE5EiGKudjooCQvmc9TPcApqHQUHV4E6JNcUGL19KZC2x3oKwpg7R/L441GAbcKor4DmibOKTzb22xi8uUmYb6zluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156370; c=relaxed/simple;
	bh=0lB7ayVfjS/ebQsXGCV7KD9ZOZmkw+YXG9IthbK3mqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ5MwXpAsmeOHrQqy3hoLhxZdvVaR1fvxHHKim01+lQSNlN0DHfdHFvYhuDFXiAUlL+N+VzTpsbCYEWmwKHCGj971TNCnZj3QVc1iLFWhC8E9uo9P2xbGv3gi+Ixr7fnJolp6kDsLSc+f0iMzEv2zbVYBvVZ3p2+BcZe39ffm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=b/7wNaxc; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fad8b4c927so9234526d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752156367; x=1752761167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mUhG6nQixPiwkNwnGkxTsDVIWYYy2y/ruQ2RkH6WpE=;
        b=b/7wNaxcPyNhd4Kto49bsbLScLz2Y1kGizYE+B4OeDwFnaQV4akl2bXPb/ne38U6ma
         BKB+451TaBrijk5xXJuU8qhlSSyUpbjEWtXY7X+NS75bF9V/y40z00OTiZkePI1KMN6J
         tR0segQbORWk+3KuzQoIdw6bF3c18nOadVJ+ALeNRwgdxOpF1TioeRac75AqXH6KV0WC
         jVDdY61uKEvpubkRjXIXjuWMmm+f4MAttCfSmWcZyZ24XMcOp6tT41ZZyULzwILyLAj3
         go3CAE28i3brAOfwcX7KqHfq260FZqLzXWJs5reVA0KyI06nSqYokwuGfoSX2Jyh/VPc
         lMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752156367; x=1752761167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mUhG6nQixPiwkNwnGkxTsDVIWYYy2y/ruQ2RkH6WpE=;
        b=a2d/Q3DylQmF66apVPPcWXz3eleGRzUkLovFmHAfdgIPLF0LsxM5NIUFLtNQUFHfFT
         dLyhcNxEqlzFx9YEWfLM1tIJQaNJXKOIdHao2G2OddsQBOeKLMKvNKiL0jQIrDZ2+3Ap
         8OZtuqIBb01xeRtgy8qbirf/VNC5+b6ucZSelBgSb2iK9FtbN2IRbpXOz3ZizcAJmNR4
         8uIYVubn03qdaO0p0ZiKgl8Pkex2VYvECMrPJ39SdrmuQ3T+lfNkamZmznN6fEQ3kz51
         iDLkexY7PlGM5rhKZAXWbxKqgQjA4lWrBItnRhodbuIduKekV+H49L5Zs8DKFjaqrIeh
         or6A==
X-Forwarded-Encrypted: i=1; AJvYcCXKyfnKQi2oASomYCgEm9R4qm3Ztu9aUQdKGvzFJCRdgROWYW2HBcPIJoiDWNOFGwY9W+Jt/tJR4a3R8tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMdHy+nhw0ypvN1IPvlRpao6Mk2/5bVOTtbrymHCZN3Orc5jfG
	kjusEEGk+hEKNKd/Ni28SAuhDm3Xe6WLBqoI1o1Z0jlfe5FTeHWVynipnmZZiyb/lQ==
X-Gm-Gg: ASbGncuxeL94ajBaH+nfzmPuoC6OloTxyhPYF2sxIJlQEfmcDAKxVljavegzsUeI50A
	C9L11LVRpLLQR262ExLWIdioxvjn5D0IG4hv4jPy4SpbKJch+r5yfczljIJCI0fL0N4g1tY4+4L
	QnaeGNyTyL7w7McMWo1cc/dmuQw84hwEjg8MxGnx6UPNKcDvw5EptGn8sO4PrlO8r3aqpD/NncL
	dhpGs/jadqRvk2G6rDxIFNrQb+ldodI65ChGHVdFa6XfEmvT9EEjfcdZ3bsatckd8E1k84LZ5/l
	1f+41/IbmyphGzIjAGKKt20TbVRn4oKJkg7UK+ywFlYpeDSGc7x3pw2XFgVt5+cLniYkHUPxCWR
	RGQ8j
X-Google-Smtp-Source: AGHT+IHreITphoTLIChq2Z0zBSWyvB3a6PbQi/LJFxUQeY1LJUPn8RY17VoZ6RePs2Nhxk86mKEzFw==
X-Received: by 2002:a05:6214:246f:b0:702:d6e7:18bf with SMTP id 6a1803df08f44-70494ee3ed9mr67061016d6.3.1752156367018;
        Thu, 10 Jul 2025 07:06:07 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7049799e3f1sm8614036d6.14.2025.07.10.07.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:06:06 -0700 (PDT)
Date: Thu, 10 Jul 2025 10:06:03 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Zongmin Zhou <min_halo@163.com>,
	shuah@kernel.org, valentina.manea.m@gmail.com, i@zenithal.me,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	zhouzongmin@kylinos.cn
Subject: Re: [PATCH v2] usbip: convert to use faux_device
Message-ID: <a735f877-e13b-498f-9eee-53ebefa8ebc9@rowland.harvard.edu>
References: <fac026d8-12c8-4c1f-96a7-264ced8391f1@linuxfoundation.org>
 <a29703bd-08b7-489b-8fb0-15838a1245ab@163.com>
 <1a13cf53-ffed-4521-917e-9c2856a5e348@linuxfoundation.org>
 <4fc877f0-b55b-4fa3-8df4-2de4ba1ac51b@163.com>
 <2a901b8a-9052-41d9-a70d-76508ebd819b@linuxfoundation.org>
 <4759911b-8c35-4ca9-bc34-09dd41b14582@163.com>
 <2025070949-activist-mammal-b806@gregkh>
 <dd3659dd-7e45-479d-ab65-9f5c1bab26a0@rowland.harvard.edu>
 <ce96291b-c0b2-41cf-a71c-c13bd8d0f139@linuxfoundation.org>
 <4478924b-fbd7-4a5a-ad0d-4fe0569b4971@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4478924b-fbd7-4a5a-ad0d-4fe0569b4971@linuxfoundation.org>

On Wed, Jul 09, 2025 at 03:57:35PM -0600, Shuah Khan wrote:
> On 7/9/25 15:49, Shuah Khan wrote:
> > Right. We have a few too many moving pieces here:
> > 
> > usbipd (user-space)
> > vhci_hcd and the usb devices it creates
> > 
> > usbip_host, stub driver that proxies between the device
> > on the server and vhci_client.
> > 
> > PM can be complex and it has to do lot more than it currently
> > does on both server and client end to support seamlessly.
> > 
> > The current suspend took the approach of refusing suspend
> > which doesn't work since usb devices underneath hang in
> > usb_dev_resume(). Looks like this usb device is treated like
> > a real device bu usb core. Is there a way to have usb core
> > PM (suspend and resume) handle them as virtual? Would it
> > help to use "supports_autosuspend" to disable suspend and
> > resume?
> 
> Would it work if usb_disable_autosuspend() on the devices
> that hang off its vitual bus?

You have to consider PM on both the host and client.  And you have to 
consider both runtime PM and system PM (that is, suspend to RAM, 
hibernate, etc.).

On the server, any sort of suspend will interrupt the connection.  
usb_disable_autosuspend() will prevent runtime suspends, but you 
shouldn't try to prevent system suspends.  Instead, the usbip driver on 
the server should have its suspend routine close the connection to the 
client (rather as if the server's user had unplugged the device).

On the client, you've got a choice for how to handle runtime PM.  You 
can leave it enabled, and when the client decides to suspend the device, 
tell the server's driver.  The server driver can then attempt to do a 
runtime suspend on the physical device.  (You might need to add a new 
type of message to the USBIP protocol to accomplish this; I don't know 
the details.)  Alternatively, you can forbid runtime suspend on the 
client entirely, although it would be nice if you could avoid this.

System PM on the client can be handled more less the same as runtime PM.

Alan Stern

