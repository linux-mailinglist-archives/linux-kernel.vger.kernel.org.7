Return-Path: <linux-kernel+bounces-808499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD91B50096
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CCB189F8AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498D8322C66;
	Tue,  9 Sep 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EmdaHhGp"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730502749DC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430204; cv=none; b=cxcoiTIAPy84PimoJD67z9aIG4QXJY8ZfG3Toui4J+gPsIXWgtrNAxw/GayPw0muRD5mEEPg/feZrqOawSo/9AVC3X3UgUu1IorX92GWxGP9pNdsxLrnfv1rv3af9sSROtvpuWofk/LtIM6Kf59DXVIv87lqMNljq+EjGbquOLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430204; c=relaxed/simple;
	bh=jDXVbSbhTbe7AacmcJHMRUvWeIYoAwxzJWrvX7BAmwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmPSv5tJtq9lny00M1ps/FnJdc+9AnC841B3rOPuRpRBvCVf4SNEai7CO8hy47iFnQkzGEQ4IYk6SHsQPwPWZJ98lwV3lsI64U3GTDSPHX6EexnWpMlxo+EmJ6kQsQX4RYG0f2ihdfY7sQXpuY0iL9O7TJhKkTtEr0Su0AKCt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EmdaHhGp; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b00a9989633so202532066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757430201; x=1758035001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5JCNA5C9ya4Jo5xtjb6FS9fyG6SoJInYHtCloGYGcus=;
        b=EmdaHhGp89T4r3dyM2EFi1E8Ep0Mr1pXMnoNP7HOgc4HXSHQaF7xnyjUW5vnnYpz/d
         UQVGLV9jjbBBuAdadaA8skmBY3Cayz5xAa0NYY6PxuHFRvJH04LwV3FJwjpAV2sL0jxQ
         2mTufF1GzBj7z5vS+7ILU5+WeNZshkO0bYbt0mBWWBrg5NMSY71VrqrVV3pdTGg/UzVj
         I+7OM7LHWzPyCHc6Gbnadz6lAM+PjTTp1Wa2ySyeaVZ5bULsc5C+F2d2uON1Va3X6UCt
         IQSDst7/W2v6l5EFCsfYLC1ajw2fzBiEwNk/CpO3P7RTws4vogeo6Dq64KakZFLnFIIK
         zNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430201; x=1758035001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JCNA5C9ya4Jo5xtjb6FS9fyG6SoJInYHtCloGYGcus=;
        b=BZzdS3jnJ2pntJg46n8tT+KyN2Y63KxrJWha/ONxbd0IaRxXhqcXr9vW2AoT0Aa3Ax
         +9yJNWndiY6aUeHPbKs7Ss8i83FKpLrNSCafnfHlyZsPfMzKcnE11K6JGE9TuOvq6q1X
         4BKVZCXLHGSDUz7CZqCwA0bEfxyxf0+pHw5AHb7y8nljkZp/K0Hczz6kl/nhVopq0tj7
         cwENvnnK8wOS0EW1w7FAH+TbbBjL1PaYdlbdG7VJkj5ShIx1aJF9IMiTe9E3bqhX+K/l
         flLYs7nGgaDbU5YTPraXYcJt724k/hiLyKJ27yQEkknvLtIx2xX/0y1T77h2vsAZ51aX
         CtmA==
X-Forwarded-Encrypted: i=1; AJvYcCWe1+2ygxF+HD3E8qjgxqLizTCkeLhfpg9BEmaVoTib9gcb3ohKYOg8lKGIYJuBWnX/7hKR+JkU5TqiS+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7GKs8Z7DDgLcdyjGNGO7Y1LeGJtxtD/T2umeE9OTlU4vuQp9
	rDx3qJ5J+kUIhnjFVSZ7uuO7XsbSPOtOhz5bqScjlDbKlaM0QsAbMvQStFHl+m9VCAg=
X-Gm-Gg: ASbGnct0oqb/YC9IqwU5dpRo++4N4SzLd2Z2rf9bnqxdXM61lQZQzhJxJkuc6iPg1m/
	Yiw59mneIpKvg5hgcCX4CkZSK3UrVknUitmDGxNnvvKeyWwU1/VDXpTb0mr6I3ThCfpL+8nXb7t
	QhgF7sY79p+SjHeEXRyin71GcnR/e7yQvY/W0nnF7zS7eoBl/Ev0wn+vTJfgLd2rKks5BWmH7S0
	qYMTJT6Jrwie0nVDuIroGphybUPjiOQYWpCvpq4aw+fiSR9c9xaej0OsY9Cm1Xqn8V37bMkdU1O
	pPa3xmC+RvYDdS45zXOBoHdnGSKedlSLfbtxlTwjinlJ+TCU8QhBRDisIylZMWhLPJR9PA2RgtS
	XBSYnyzMkTepmLL4NeIKm8sqgIw==
X-Google-Smtp-Source: AGHT+IHdxC0JePk3qeMEY0oBAOfP9396mjUVW5jGrhBODN2YmkUTvFgIlwQkSj3Cm41Bms/JnFAwUw==
X-Received: by 2002:a17:907:9691:b0:afe:ed05:2e68 with SMTP id a640c23a62f3a-b04930ac043mr1723174666b.11.1757430200254;
        Tue, 09 Sep 2025 08:03:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783411a3csm3334966b.100.2025.09.09.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:03:19 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:03:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 4/4] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Message-ID: <aMBBtYK0pIYa_Ba6@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-4-cd30a8106f1c@suse.com>
 <aL77aq4gZBsn4epT@pathway.suse.cz>
 <d73e8cc0259c140a0a49f670c6c165bb662281ed.camel@suse.com>
 <84segwjbxq.fsf@jogness.linutronix.de>
 <aMAwMz4vWC5u9OpN@pathway.suse.cz>
 <84h5xbk8ll.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84h5xbk8ll.fsf@jogness.linutronix.de>

On Tue 2025-09-09 16:29:50, John Ogness wrote:
> On 2025-09-09, Petr Mladek <pmladek@suse.com> wrote:
> > The problem is that wctxt->unsafe_takeover would need to get updated
> > after acquiring the context. And might be reused for different
> > consoles, ...
> 
> You are right. I think it is best to make nbcon_write_context_set_buf()
> available.

I am fine with it.

> > But wait. I do not see any code using wctxt->unsafe_takeover.
> >
> > It seems that the motivation was that console drivers might
> > do something else when there was an unsafe_takeover in the past,
> > see https://lore.kernel.org/lkml/87cyz6ro62.fsf@jogness.linutronix.de/
> > But it seems that no console driver is using it.
> >
> > So, I would prefer to remove the "unsafe_takeover" field from
> > struct nbcon_write_context and keep this kdb code as it is now.
> 
> No one is using it because the nbcon drivers are still implementing the
> "hope and pray" model on unsafe takeovers. The flag is an important part
> of the API to allow drivers to maximize their safety.
> 
> I think it is too early to remove the flag when there are still so few
> nbcon drivers in existance.

I feel that that I should be more strict and push for removing
the flag because it is not used and complicates the design.
I am sure that there are cleaner ways how to provide
the information when anyone would need it.

But I do not want to fight for it. It is not worth a blood
(changing code back and forth). I am fine with exporting
nbcon_write_context_set_buf() for now. We might know more
about real users next time it causes problems ;-)

Best Regards,
Petr

