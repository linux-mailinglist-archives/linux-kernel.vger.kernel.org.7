Return-Path: <linux-kernel+bounces-844185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C24BC1407
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1103B3712
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B326D22256B;
	Tue,  7 Oct 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="f85HYiqS"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FA849C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837565; cv=none; b=Na5F1vdlnCmg6YdLzWiijej+hAveKyyUdYk/VvOR2rwmqPpw7eyA6kh2GilBQrfxevBH+koNwExz+MiNLzYttvB2JDctykBgoDR2tI2urbdUauxGjN9uMiQOZtgTXmamcsci0/zvMUyGTI+RFKfLOvBQgEJwV8xDRP5lGoNrWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837565; c=relaxed/simple;
	bh=p7dHS+AB1QjkqobcDf4KXopDx306eI7bI3rZgSY9+ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Igp0/Z0MtGuHZrH0k6pioWo3r7wJlL3BZxl+bR0dq9Ev8CsQJYV0gHxm9YEv5QNJFpWtDxIiPG2t/oJARhxSML89RMIXTtLZGUNrZGv2SCfQ5V9Ye6VTMnum6ry8sdRg5U1WyK/+H63ltXd+4aSa/ZdMpeLq7ogj4gogiy81mPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=f85HYiqS; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7bc147fd11bso3795192a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1759837561; x=1760442361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEMaxv3BxiBCDuohapV59T47+AmE8saqxvqjqkQ5Wcs=;
        b=f85HYiqSfLsLN04iziitvl0+dnduuvw8yZo1zX3wwGOHS7SvtMOHrEvLvCtm/epqaq
         mu4uuewGmUtE1DC4imNTx00AgWgrADWiFl+t8iAXtousk6GBtdPcxrYwnwACBIb3Zs/3
         akDX/4y8Cs9mrjw5wxN4/Nr1jvmbktrx8Fn1YMD3/U0up1wAWHr7Y/h61aZdaS20Mrav
         eQIX17H+FWM1A5L1ifBiS7uuNyulcXJWnKKpirpLDRSs0F6Mm7u+KJupZ+IB+MviKbNW
         z+1fxFgoTNQE/kOUDnnbK22lKXorm+btO/hEFtkne62CqfdeggiF8DA0xITL2niZXtut
         e30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837561; x=1760442361;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEMaxv3BxiBCDuohapV59T47+AmE8saqxvqjqkQ5Wcs=;
        b=f0efX4g0KTy9phoDPFTL7C5s8ESy8M6EFV/3BvemiXMjTdUS7lTW95plWfXP8y2Dyi
         w++eTJug3foP9otccbwhhoHpDC4Zr1HFohhhypbAULWEqDeiO9QAhkYicGLw6R0PO0v2
         UI/mdZFeJfzzs9WRtu2Bu1yDDbPnxBXzuOaCzd5i1pW64rWSJ/mr5mH4HDU2CVB3I0bO
         35eISshBLHiw0NIHEDYDTbG7Fw3wV7DDQFpsOf9dzAS+KyWMSZv87uPRdvBq1HpJad41
         Is8NLy2HA2ohyxo1PQrTtFfBEYFkg8TRlE3Jzscwq5LT79DkgLyqxogp3E+qcq+j/kKk
         hZXg==
X-Forwarded-Encrypted: i=1; AJvYcCUTR+x3Gs4YdWAU7Ayy4UsyK8fnqxSjvJJpQDV3VGcdsVVg9TjK/rmagn8jo6RoS3MzhvNNzxdssWnG4wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF97zxWLHcF4zq5cA1Q1nBRnq4RHutU5i6uz2A5Qv5GodhQKYO
	SoIrZQv2ncEbgoittvqsE83SvCW/HdIAdHC1jQ9uEvRCyRuQm6XApzgg7F8cSF0/d5g=
X-Gm-Gg: ASbGnct06O4yzgkQMwZW+r/7LTSH7nHDy4mZLBLKVml6BtAdyMKi9SpEuXftiGWBQJr
	qsiYQtjnPdwlZDrPJ28MiLIAHQpyyXU2BeX1gy2gfNF15IGuf8XUGRnXGBVAQWfyCA+4p0ritzx
	TaoAo2WNVJEE47WsNz1poCsW3FcBCIJv1SYxi1j8rIAVv7qBPsJ6EUG7jqdrVaYuza8+CmjiMiw
	wU01uQEQufOMDPFqAv61bIUUWnNkWx8Wt8T5YgmW9qeJOa/EoeEdJdLUAe3/bp7QLWEXAh+miYE
	1Ncsm2gma+cdEFhAzQJn59I/b+g5dIrh2prn2ZhLosbN+sX/P7Zcp/lN7lCKdUxmJkTL+S271xZ
	59do8trOEAg907cDr43nQ1sj4YMnfyOiexhnr/ck8GH9huW/EYw==
X-Google-Smtp-Source: AGHT+IEJYj2mzM7UxghzpnE7ZizpCtChcl1w+w9JZOnMjgORq5FS20KxP3V46mcECRKJiHPODwX4tA==
X-Received: by 2002:a05:6830:2b1f:b0:790:710f:60e3 with SMTP id 46e09a7af769-7bf772bd7fbmr8108560a34.23.1759837561330;
        Tue, 07 Oct 2025 04:46:01 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:52ef:e8e2:6979:b8d1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf43028a10sm4538093a34.22.2025.10.07.04.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:45:59 -0700 (PDT)
Date: Tue, 7 Oct 2025 06:45:55 -0500
From: Corey Minyard <corey@minyard.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH] ipmi: Fix handling of messages with provided receive
 message pointer
Message-ID: <aOT9c1ULJolUHPSA@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20251006201857.3433837-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006201857.3433837-1-linux@roeck-us.net>

On Mon, Oct 06, 2025 at 01:18:57PM -0700, Guenter Roeck wrote:
> Prior to commit b52da4054ee0 ("ipmi: Rework user message limit handling"),
> i_ipmi_request() used to increase the user reference counter if the receive
> message is provided by the caller of IPMI API functions. This is no longer
> the case. However, ipmi_free_recv_msg() is still called and decreases the
> reference counter. This results in the reference counter reaching zero,
> the user data pointer is released, and all kinds of interesting crashes are
> seen.
> 
> Fix the problem by increasing user reference counter if the receive message
> has been provided by the caller.

Yes, the only interface that uses this that would matter is the watchdog
timer, which my tests don't currently cover.  I guess I need to add some
tests.

Sorry, and thanks for the fix.  It's queued for next release.

-corey

> 
> Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index a0b67a35a5f0..3700ab4eba3e 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -2301,8 +2301,11 @@ static int i_ipmi_request(struct ipmi_user     *user,
>  	if (supplied_recv) {
>  		recv_msg = supplied_recv;
>  		recv_msg->user = user;
> -		if (user)
> +		if (user) {
>  			atomic_inc(&user->nr_msgs);
> +			/* The put happens when the message is freed. */
> +			kref_get(&user->refcount);
> +		}
>  	} else {
>  		recv_msg = ipmi_alloc_recv_msg(user);
>  		if (IS_ERR(recv_msg))
> -- 
> 2.45.2
> 

