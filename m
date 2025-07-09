Return-Path: <linux-kernel+bounces-724043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D297AAFEDEC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290D416CA09
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FCA2E7163;
	Wed,  9 Jul 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="hOgMkyJ8"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9806A272E7C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075692; cv=none; b=I7BtuJCrJxNKTWeO35zcYgGWf9sbcVO8Cq35/mhcdTR8yZA0tEp6UTLgpccSZXSjDoT8nwYVlKii6xJOArUKcX1FyOYtyS/B0h/kUFHZ8AITmKGQFUCrpgx4AfFUdtKEo7ei1pIpyzZ3408XI3IR63ZWHmR8/PeSwymYSJFAV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075692; c=relaxed/simple;
	bh=l1IMqQamnOSUMauOz72BUd8fZaqfC+kM2xLZw+/ZgnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFpZVykeCrirnwqGIuvAyHeeaTPYXY2fpJKkRyhDyvmNjUAhembTk0qe7lGAgCOQALXbB/dNQrXM1bN91UsCqnA0RQxWjQoS490NSqX5pH7lkl36bzgADV00SOqvTbiYhoymXmCrFwqOf0o6bo8nf7K/ZQnDEmTJclniWVVyXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=hOgMkyJ8; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fa980d05a8so252226d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752075689; x=1752680489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+8lINShdvup+8jB4CEo5zDF19kEcona9FuXtnWhTyA=;
        b=hOgMkyJ8ZDRxXFyR1Al8/ogDzxRuxjEYlso9jmZIX7W7SLF+5gY+8Oef25Ah1cnYuG
         ja6MumEPbmN5MRGfhz4GKAlRKn8zpCrG7EYxEvxzOQ/AUwycRdAN2N3XzEokCBDap+7e
         w+LiX7zOb2+j0gqxNjMDLDf/FuKcrT8BQOoOdypjcPbwp6GSgfTZFQkqz7icgg0h09iF
         fUkT/idtzpx5e4HS2sRyAvRxa8peJ+yAO7dY/u6n2RQP4bHqI5CyBfkw8fP5ZAo0/Lgi
         tn9U+nHcuWOoh0vb7dkrcyqqf7qsObOd7HRshbGXaWLjj1bvf/h1rcW5SWul8RnFUDjf
         TxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075689; x=1752680489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+8lINShdvup+8jB4CEo5zDF19kEcona9FuXtnWhTyA=;
        b=BK25mJW04ac63tJBaOez7ewEVGG3W+sX+XnsgQ2VNFX9CPISg/qthDGMUOpXDc5J7j
         2idzH7qKlYBiTKt3WkbFjE4Irhu9x42l20r4FwvI4v+cboDv15QMAlUJueE4xndQJpou
         aHrSqTbnAM2OaFZOGqAngvT5AUlh2GYjQyFMVDbhgwcm4Sq6BpwDqedHyJJuTO7C6JtQ
         3SPJWSJPxI4+9KxuVUOr5KlxCU4gxnX0+nNPlsiOrpkczkpYOaMCwjZNDCyE9A7YvR9O
         /ckTXddOZdx/9iCpHnVLHBRwa+h1CNnjC12Bcl60fSrm3ldq/H9CIDqn4xcA1BaB7qYk
         XH3w==
X-Forwarded-Encrypted: i=1; AJvYcCUyTUM9+Ra8tjFE1EUYD6UwVK/YYFxTln7VtSSA53c+GSS3xd/QUpwPa2jNACNIfyfqR9ld/+BnTU6iqV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnoHHVUv1wPlpKmFfdNNcUGYiFbq9pZeC2LwsckaNGroOjKBBP
	5C5WO5VEVbILUbQQdsz/ridXCiUNktJFkuxGz5QTU5oMqZ31kXqWf3VOlZBd3fNpKZsXkwtYuRZ
	2jsI=
X-Gm-Gg: ASbGnctJaoSc22zu5l5Hr0BE2UNrG6nCZPP5ePvt7SlbSnjmXmaiy5tJqeXKObbWEDk
	U/xDm9YR2zzTnK89DJ1+r04scW4QM1+pScqCxPbRep/iscbTsqZwhr1EPjvtnrvZyVjMEh5VVMh
	HbRAb80fZElc6Zj78Dy3SYjpwrZa5tL6/Xh5/FFDAYVx90zJZz6J/NLEcz6e/h6daO8RJ6u+QYC
	/dJXOZdtHtz1ND06BVH4sb+3xcxxTctwJ7BNw/U0jI8h32I55vtDkPOc6QD8zKj672NlkEbZUKw
	bN27HD7YFRG+PVIixhMN0qInXddCoFbyjSKahxtgUv9xKp/Q7wTsP0W++gbRWTBw2q3FEUojCtW
	XuSYvskxrTaT5Odc=
X-Google-Smtp-Source: AGHT+IFQ8reysvGiDHB9SlFWV74GS4KL17/ACFp3PeDv69dK0w4A50NNV0ufOCxkqgR1vs+8lKQAmg==
X-Received: by 2002:a05:6214:3d01:b0:702:c150:46c2 with SMTP id 6a1803df08f44-7048b8d8da6mr44190726d6.10.1752075689343;
        Wed, 09 Jul 2025 08:41:29 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704831532b6sm23936286d6.101.2025.07.09.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:41:28 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:41:26 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	USB list <linux-usb@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
Message-ID: <1d471e25-6671-4cb2-a2c9-af96c2b4e13d@rowland.harvard.edu>
References: <686e7698.050a0220.c28f5.0006.GAE@google.com>
 <79f634db-c149-4220-b8d4-0fff2c6b6a01@I-love.SAKURA.ne.jp>
 <e064a3e4-ae70-4a24-ba5e-1bb8c7971f23@rowland.harvard.edu>
 <39f312fa-d461-4377-b809-50c8a7188f6b@I-love.SAKURA.ne.jp>
 <dd932df4-2a13-4a5c-a531-376065f87391@rowland.harvard.edu>
 <43189e93-2cad-429a-a604-15bf5cc95e43@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43189e93-2cad-429a-a604-15bf5cc95e43@I-love.SAKURA.ne.jp>

On Thu, Jul 10, 2025 at 12:33:00AM +0900, Tetsuo Handa wrote:
> On 2025/07/10 0:19, Alan Stern wrote:
> > On Wed, Jul 09, 2025 at 11:44:46PM +0900, Tetsuo Handa wrote:
> >> On 2025/07/09 23:27, Alan Stern wrote:
> >>> Which of these three BUG_ON's did you hit, and where did you hit it?
> >>
> >> kernel BUG at ./include/linux/usb.h:1990!
> >>
> >> matches the BUG_ON(endpoint > 0xF) line. The location is shown below.
> >>
> >> Call Trace:
> >>  <TASK>
> >>  hub_configure drivers/usb/core/hub.c:1717 [inline]
> >>  hub_probe+0x2300/0x3840 drivers/usb/core/hub.c:2005
> > 
> > Those line numbers are completely different from the code I have.  For 
> > example, line 2005 in hub.c is part of the hub_ioctl() function, not 
> > hub_probe().
> > 
> > Exactly what version of the kernel source are you using for your test?
> 
> It is current linux.git tree.
> 
>   https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/usb/core/hub.c#L1717
>   https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/usb/core/hub.c#L2005

Okay, I see what your problem is.

The bEndpointAddress field of the endpoint descriptor is not just the 
endpoint's number.  It also includes the endpoint's direction in bit 7 
(0 for OUT, 1 for IN).

__create_pipe() doesn't bother to mask out the direction bit because bit 
22 of the pipe value (where the direction bit ends up after it has been  
shifted left by 15) isn't used for anything.

Alan Stern

