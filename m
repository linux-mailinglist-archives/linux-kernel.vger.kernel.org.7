Return-Path: <linux-kernel+bounces-890309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D899C3FC3A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0311A34B819
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0060D322DA8;
	Fri,  7 Nov 2025 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSkktNqi"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0DD31BC8B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515810; cv=none; b=tcpTWzBgzgLp4Arv1xDxsYogSK72C023Xi8vYcUPeKn8H3zMnH4v2ewBHlYHllHljsd+qxzBRRTsSX1ZIjd44uICE2ypDbxTBmJVSww4nEhvycvv4kPqjdDaKVgnlMGwsiblSvhxTdFdVkx3S4PWLdq+NuApS8XfVkelewByNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515810; c=relaxed/simple;
	bh=AmjUPrWpuTwthWsVlqGLH9DR6E98FBF6NayNRYjqv5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xg6GNqkRrxpTJqGKJQRRfYrktuSugPpB5Y/9HUBwsWa71+9HmxSZa4md4WBjb5jgoLLyvX4JxiX1uB9PJ5is0H8u7Mtlv9/PL+XoKWVdyvI9ZHvcBbmbw+jNLv/j2xCNOvnFSrBgRFTZPuv/MbaLYwYLdvau/AiTrbO3KcUlOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSkktNqi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c2f6a580so609736f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762515807; x=1763120607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqzN7knDGH9QbbVJwM6bluXyesO87eP1mjfXDHBEKqY=;
        b=mSkktNqio9IcoHCXxwbligTDrRPU3DT6gRpEjQ+4Rud8/53kDBSYVQuxS/HIwfsFrx
         Yj+u3saj9StcPn8deML3Y4k99XQEZDca9E03kjQQd6+XRbYrVE0YSk5spjPKgbdloxYC
         Hz1GyQztA+riEwsvDjf8qYK/VwsJ1jRPrUbTCkftdicHCuG8B8k2iZvbPD5zpHKvdzNF
         kJ7w1FeqBlo6hm8U3FO2VATsRGTxfJBVb7elygi73NUHMDdJMDNSOU5WJPLWLmUgDFhY
         0cOM++qHNdJlDCvKqhWkotHTaFBUtaHOND/QXwzy7mXPD33PZPd27EfcuCx4Ty5kG9KR
         ebCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515807; x=1763120607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nqzN7knDGH9QbbVJwM6bluXyesO87eP1mjfXDHBEKqY=;
        b=J6bWScyHSTWjtfjHpjBiDng91kn+9mbvhZhJ1ZNt7DrK6yMxWlW7xrZKnbtGOc0BlK
         GPFPx/wyda6F1aLdMcZDoMDgHTqdMsNqJa5GT35Xi52oJFwzTWzgj7wa9Pm3oEFMqhnH
         19jnrcTgRMBG4uUk/s8Yx2djtJaY8ePGV0b83Xk1A9Be1marSgnfACdxbyxt0URvNMCd
         BlXx6KMkFKdfVwvYuzVJFCYmRquYV4PPN78ALMBq1GPz6sjf5yrpNcQvirRE0bSBeRmW
         UD+tFgBDtrZEB634D/D3+OPK5j6JE9W2HuLEf3hijLSOfWlk+pNQsXMYIJ7V1Ji6uT2/
         jajg==
X-Forwarded-Encrypted: i=1; AJvYcCUiCr/himgQJEbI8pPKUEUzZiesXqCFTQxswRCAM58L4ipJ4FQge5/IJUXWzOC+P/JCjZnvm8YFQhGR6gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUmd1fjMoYwuWDtCrivGzvovw2xf5lAvI2fI4fYd9+e8gXdO4
	RXjdsb+XfyIBUsBxiTeZcESExL+B5CHQztZS6ZBUhCDyxHw4x/Ey2i2y
X-Gm-Gg: ASbGnctq8nnP5hwKAADYadncPWnKAEELqpmmzVFxogcMScFVvgQdMPRBLlOOVySSkdX
	EeRfF81TU0beqDE6g2tsY0ctQpjBeDl2HJ1fqIKr7LvrterwU0w/yN0828PCo6OgVA0BMZb1vAH
	5rL5XKw18lcmIYVhi2wV5mV9Rp9pxNrGiANrhVl3BDIFRzRa4uk4rQBNCZreNOVQ4KUs7pXM9R+
	kPAu43rY/akcq6qSup6UbiyPYq6trToFzF/sMQQmvXsqt8uF2efv1A2SknXXokKRzTUMI6uJjtF
	9uOCmf51fUvK9VoUEmR+QM8Tj53Tykk2z0u0KoLEBPIOK1lR37d8wesp7l0GgRO+cUgb3kL7aoG
	qwxusQ5bATe8mbO0Jt9hdk8sFXrm3VC5W3pDwpBJLurdgw1dq9gJrZXUKuEcOwKPFiGmj7Gld+F
	pEWEh+CsJr5SuOXJTzK1bSRrTb4oGzYkGcCSQ4WkYo1w==
X-Google-Smtp-Source: AGHT+IHw1xLInjNvQyJ+t0Q049pOhGmFx6agirkk01rOnXi/dnaEiyF9VIdrFsbRc2ZzQtwnJmDSoA==
X-Received: by 2002:a5d:5d0c:0:b0:429:d6b7:6b9b with SMTP id ffacd0b85a97d-42ae5af7ff7mr2595204f8f.62.1762515806681;
        Fri, 07 Nov 2025 03:43:26 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe64fd90sm4714454f8f.21.2025.11.07.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:43:26 -0800 (PST)
Date: Fri, 7 Nov 2025 11:43:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: NeilBrown <neilb@ownmail.net>
Cc: NeilBrown <neil@brown.name>, "Chuck Lever" <cel@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Laight" <David.Laight@ACULAB.COM>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>, "Linux List Kernel
 Mailing" <linux-kernel@vger.kernel.org>, speedcracker@hotmail.com
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
Message-ID: <20251107114324.33fd69f3@pumpkin>
In-Reply-To: <176251424056.634289.13464296772500147856@noble.neil.brown.name>
References: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>
	<37bc1037-37d8-4168-afc9-da8e2d1dd26b@kernel.org>
	<20251106192210.1b6a3ca0@pumpkin>
	<176251424056.634289.13464296772500147856@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Nov 2025 22:17:20 +1100
NeilBrown <neilb@ownmail.net> wrote:

> On Fri, 07 Nov 2025, David Laight wrote:
> > On Thu, 6 Nov 2025 09:33:28 -0500
> > Chuck Lever <cel@kernel.org> wrote:
> >   
> > > FYI
> > > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=220745  
> > 
> > Ugg - that code is horrid.
> > It seems to have got deleted since, but it is:
> > 
> > 	u32 slotsize = slot_bytes(ca);
> > 	u32 num = ca->maxreqs;
> > 	unsigned long avail, total_avail;
> > 	unsigned int scale_factor;
> > 
> > 	spin_lock(&nfsd_drc_lock);
> > 	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> > 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> > 	else
> > 		/* We have handed out more space than we chose in
> > 		 * set_max_drc() to allow.  That isn't really a
> > 		 * problem as long as that doesn't make us think we
> > 		 * have lots more due to integer overflow.
> > 		 */
> > 		total_avail = 0;
> > 	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> > 	/*
> > 	 * Never use more than a fraction of the remaining memory,
> > 	 * unless it's the only way to give this client a slot.
> > 	 * The chosen fraction is either 1/8 or 1/number of threads,
> > 	 * whichever is smaller.  This ensures there are adequate
> > 	 * slots to support multiple clients per thread.
> > 	 * Give the client one slot even if that would require
> > 	 * over-allocation--it is better than failure.
> > 	 */
> > 	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> > 
> > 	avail = clamp_t(unsigned long, avail, slotsize,
> > 			total_avail/scale_factor);
> > 	num = min_t(int, num, avail / slotsize);
> > 	num = max_t(int, num, 1);
> > 
> > Lets rework it a bit...
> > 	if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
> > 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> > 		avail = min(NFSD_MAX_MEM_PER_SESSION, total_avail);
> > 		avail = clamp(avail, n + sizeof(xxx), total_avail/8)
> > 	} else {
> > 		total_avail = 0;
> > 		avail = 0;
> > 		avail = clamp(0, n + sizeof(xxx), 0);
> > 	}
> > 
> > Neither of those clamp() are sane at all - should be clamp(val, lo, hi)
> > with 'lo <= hi' otherwise the result is dependant on the order of the
> > comparisons.
> > The compiler sees the second one and rightly bleats.  
> 
> In fact only gcc-9 bleats.

That is probably why it didn't get picked up earlier.

> gcc-7 gcc-10 gcc-13 gcc-15
> all seem to think it is fine.

Which, of course, it isn't...

	David

> 
> NeilBrown


