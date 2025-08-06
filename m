Return-Path: <linux-kernel+bounces-757194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681FB1BEEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 04:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A6B183543
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7331D86FF;
	Wed,  6 Aug 2025 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIBzWcUq"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9240217A2F6
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449190; cv=none; b=Cw32fte7/+ozllgL2XpTPlMPhAyNBHpzwJF/+AkTixvE/Nr9x/GWlheR+W9fcr4DM9xV92s1V3lai8OLAmVofhZ7h6ItynqXTFeOdEBQFnkyqCJrxxaYViOGXMvxyPpjLGK13A6WxxSNBh4PGTKL4q2xu3CZD7QQQNDLxw2WCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449190; c=relaxed/simple;
	bh=2Sy51UIDbWhWeKHVaneconwV3uWv2TM+n+05gLEQfho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZm+KO7JQU6drdXtq2VONC0l3XGfHu/VL8VOUDxodRTMCkXF5xOdUDfC8kKKPQfjXZcEtk+BWNgrxzmCGn0f9WOANOXxdHMR6lFj7iOsgeXyW5qVfQWOBhW6+W3BPKIEsc7mx+EOAJE/yKjGC2TSfoBgv8wth4N1O4sExEWBNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oIBzWcUq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31f3fe66ebaso420850a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 19:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754449189; x=1755053989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csMGrf5jAXlWmahqYDn+czRvht0UxHaBsWoGJ3YlYt8=;
        b=oIBzWcUqWG5kPvgkoGOKVGeHS5T4ye27hPftT5A1Ktoacrk5GIni5tAhZpCpwVhN2K
         Nef5yyCGY3yDEezt7TOmmMVHeCZKCYWCTCi2ThOUfzNK4/6CdSuOo0AeJDEdDPDXkZAa
         QWgmLAHF4PXxXBcOz3naC2zpGGPAhi+WYY31I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754449189; x=1755053989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csMGrf5jAXlWmahqYDn+czRvht0UxHaBsWoGJ3YlYt8=;
        b=Nw1aqtsEfJiWkjC1LDCdgG1QZJSug6+cUDCfJtJdLY6XPpw9QioAsa26UvkuuEgEFI
         AY3MZ1prfFhVXwM8ODAFgaZefzfJwT0mH0RR+Ex4vlOTJFOrFnkfZAB58XdkyW9zAIMZ
         XJ1bv+VrbfJm7T8VV75aFGfA/Hevdao93q8cBppqe0AR62OvTWp4AZzdTUYXjjfMo5AC
         NPVgiKHkqapDsXbDXolGNdM+GRyrkPU8GS5gL67jN6tIKbB0MJ4oQocm1pGLJHdqgZiY
         T1BvJdwbFZ7o86LWYx/sxYCJ0u/B6E1witAOqg+T9ApPz433aOrRLDFRtyVowNW/lF0c
         nXeg==
X-Forwarded-Encrypted: i=1; AJvYcCXAQRumP32fd15Bmi9Lp0hrq2R1NM/grTdObt6RYriiO1Ziy7rQLxeSzwab4D5YdCq8ijYziwjZsjGC7qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgzUDlZjXto94zPJoms01sn4vVOAptCzgSm4oh67cLVM7Ux1+n
	CA0FUzOBgidWARDVt90/ykco0/y0Tt1kfJSOhAWuflTfODsGwRsSjeQZIl15MmkoE2lOyc+jPMj
	XcwI=
X-Gm-Gg: ASbGnctSuFAqlIHliTLjNSJES3c0LYyc/qUKHbqwbBR2MtGM4s429P3gJMpKOajkLJ3
	98lTDxiOfEs7SKgmIdluninMO/86sCkde9YLY0cnS6WQUMBEQTJ4/8v9ETR9YbV70luqpe8HTg+
	DLCr4BAZYiqiOHXyDKreYAJaAMpGRJ62Z92tpCVQaYSnY8Qm5CLfHlPyIpv9oufj165jdbRgjIt
	Qi8PKsOIXmf5lHi4Po+rRtXQ3bam5zgTpOB7kEr+XJPqntJDcPdvwEOM1Y4oc7zWnLx4XtwBj5b
	oQjFbnfNpyFTBROQEQPpghtCW5dNEINh8GhCRysqfQ702IWr8vYltUAO29etkjMULggjNEsO2Ft
	eM8J3mzm4PcdH1FJ8IBTCJpo=
X-Google-Smtp-Source: AGHT+IEuIyAVHK9DXmPrpCmyJe8g9FqVpouWfFwjWzGsjgBCZSUXcftxofFAUIeBUhsZwm7S6rTi+g==
X-Received: by 2002:a17:90b:2d50:b0:31e:f36a:3532 with SMTP id 98e67ed59e1d1-32166a395dbmr1667250a91.13.1754449188844;
        Tue, 05 Aug 2025 19:59:48 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102ae8b5dsm7792503a91.3.2025.08.05.19.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 19:59:48 -0700 (PDT)
Date: Wed, 6 Aug 2025 11:59:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org, 
	axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <h3fagdwigvveeqkd7zikzv2glcfiarqpowiumna6ngb7ktd4zz@7is5ivhmyvbu>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
 <d7gutildolj5jtx53l2tfkymxdctga3adabgn2cfqu3makx4le@3lfmk67haipn>
 <6hs2ou3giemh2j7lvaldr7akpmrwt56gdh3gjs7i5ouexljggp@2fpes7wzdu6l>
 <edvzxvoparhuqppuic5amgz5smfar54zmli73nhyojnj63nom4@kmqnjdl2af7u>
 <elixwhbyatkcaw7djpzfa6nodhxh4b4hg263ito5o5ibzewamx@nuux3sfh2g4h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <elixwhbyatkcaw7djpzfa6nodhxh4b4hg263ito5o5ibzewamx@nuux3sfh2g4h>

On (25/08/05 18:03), Seyediman Seyedarab wrote:
> I need to correct my previous statement about the use-after-free issue.
> 
> My reproducer was wrong. The garbage output I reported was actually from
> an uninitialized buffer in  my test code, not from reading freed memory! 
> When the device is removed, the kernel correctly returns -ENODEV
> rather than accessing freed memory:

[..]

> The kernel properly protects against use-after-free in this path. I 
> apologize for the confusion.

Great, thanks a lot for the update!

