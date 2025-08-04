Return-Path: <linux-kernel+bounces-754991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E82B19FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BCF17A334
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB724C692;
	Mon,  4 Aug 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0weyGFd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86ED1F30BB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302774; cv=none; b=S8+/2I0psbhAzHGBU5ND8ID8GvkyRUr1tEe5R6aDksuzQCjrzovfuVsXSDEwJ5tTBinKR8TcGavFnoDE18zu3cniX96iIOM+7hGdagdVty99dquJ01YVmVty7jgu+TZeOEx1CigocgD7rZ9XoA4ExR4CxtDJkt1usnNA8X2XgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302774; c=relaxed/simple;
	bh=RDOSW3BTi/7xC0REpgTJ4XkCmRZDmSH10t1Dv6fn80E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3GTDuZxUFB/yJwq7m16IACLKtj4pBkt1SnAqTBARAOPK8YbNjJegAmfF5NhkhBrz2OYJ9CwkEpURvfqdX/NxD9qU4prlg7ccEoFa1k5I4+cVPYradlfXXpCmXakvAsHGlvb0lXJM3xxaIfxk5Qtc8dxRL/ypU9fzwgi6//PhcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g0weyGFd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458ba079338so12440115e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754302771; x=1754907571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oq5/FdOzGZ1inlNbjB3s7XlQSummuzkTt86tAsew3/A=;
        b=g0weyGFdp+vmvB+10LKxGUl+IwT/qI+nmRSjSgAZ6mO2cYraZy5yvVHUXFdVihcdAK
         JDtYhwgXYCHqgzkYOyjMsei+6T1qoxd4bv3bLd3p32qsS49DChKS+mmjKEbxkkBjo1CY
         2Umj2l3Etvf0MpjeogLFaA9kbHKCJPY6XmVXVVgdeV6c32BTqgLi1Up1p0x9+PKAmXsH
         E5PmOKC/ogts3K7IAIw2EMPANBlmzytmR4X4W/8DYL82LsBz6ZPY1bbzpUEL6t3jeGPr
         E6IxaFFVU/tQ9m1uJghZYevq2/eyb3zLX8+sZfLeMBGkAkn5hY7yPgopzj4NpzRBJpVG
         sZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302771; x=1754907571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oq5/FdOzGZ1inlNbjB3s7XlQSummuzkTt86tAsew3/A=;
        b=ak3JN4Y+YzBHlIF1M3whlrjg0M+v9VTZS+aqxlgT7H2WDg5enVAuB4VUgDmwutXYXH
         C7UvQWRh2g7ZsOkTHZ7RDIiodWHC1uk4M30BV9C94wjuMnD796CI87dB4rDkRM/aYHtN
         MOUI0PU7qzh8dvGHHR4IKLKqaqrtwGaYmjMUmwSlqEr65TDJMAAhPKM7Cjcbz9gZQeSz
         zYSJ3orkTBcBmH1OqA8Nmf++EOt8kpbqutzMt3iIFz/tuIi322U97z/CB5TALm2nEJta
         RJ37aH+vtssilGKAVxpEipdjOma0nBBXS4waHA7fGp/YCpyuF+iTIwEdOgkBkc4S5Wl8
         3jjA==
X-Forwarded-Encrypted: i=1; AJvYcCWINtsf+Ezwnt7S3sk/ol+X3jFEPIjO9w4/MgW1/fyuOC0xy3CSxHQECIqNbhMlpPdVr2dnZJWARSvnPgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvuiYU4sn1Fv/VwIiMVOOd5pNF2xrE5NgEvOxzMYfsA79YIT3
	6j1PBwrCVPdFv9izZ7ULlL2QK2F1Ws+Pd2TCTXVpPax6N2JjKpT7q1TFNXSyAdUiNd0=
X-Gm-Gg: ASbGnctSNseLk97kj6iFUKEv5mRTkzh7R52/ix2IwHXnu0VJJ7RMMDiecOdcS9J2ykb
	AeEgMomT0WuocECfx7AQOyATddcSY2Vyn1kIxWwPw7ZcSAyCDS8YfOmXIv53yokXd4pNy0gBMbi
	ydjq1yXQ/WMEP7zwi1OOZZ8QMDO59umcv7UEMzZRn4QB9gh0LtWya9BSfwajdtQPY4JIuM1tIz2
	XlT+YON3XFDTWS4MfkQfSSMzN/M7Ht2nSGUEMFUFeouGeg5cFvILs7BqzojZ6fz/6X2zscJDrpU
	Aot4rJjDeJ0HunV6kaGhqY4Qr4iUPFm6UvQKzI97/wowOg633qMXcafRa/BmyuaEk+SPUhQj1Yx
	j7YDLrREOhSFs03TCvA26qOojL8w=
X-Google-Smtp-Source: AGHT+IE0Y9ajWKwRqE0DRMgV+5o5dJoF5XuqnYQuo4xMGuuW63Maj4QhGtWtBbyqgOL6V4MEAbCaog==
X-Received: by 2002:a05:600c:5246:b0:456:1281:f8dd with SMTP id 5b1f17b1804b1-458b5f190f6mr70111985e9.12.1754302771128;
        Mon, 04 Aug 2025 03:19:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee5795esm163292765e9.25.2025.08.04.03.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:19:30 -0700 (PDT)
Date: Mon, 4 Aug 2025 13:19:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Mihai Moldovan <ionic@ionic.de>, linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Denis Kenzior <denkenz@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 04/11] net: qrtr: support identical node ids
Message-ID: <d2884803-c2ff-4beb-b982-b8533ab71066@suswa.mountain>
References: <cover.1753312999.git.ionic@ionic.de>
 <8fc53fad3065a9860e3f44cf8853494dd6eb6b47.1753312999.git.ionic@ionic.de>
 <20250724130836.GL1150792@horms.kernel.org>
 <a42d70aa-76b8-4034-9695-2e639e6471a2@ionic.de>
 <20250727144014.GX1367887@horms.kernel.org>
 <aIz4pj5qgXSNg8mt@stanley.mountain>
 <20250804095522.GP8494@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804095522.GP8494@horms.kernel.org>

On Mon, Aug 04, 2025 at 10:55:22AM +0100, Simon Horman wrote:
> On Fri, Aug 01, 2025 at 08:25:58PM +0300, Dan Carpenter wrote:
> > On Sun, Jul 27, 2025 at 03:40:14PM +0100, Simon Horman wrote:
> > > + Dan Carpenter
> > > 
> > > On Sun, Jul 27, 2025 at 03:09:38PM +0200, Mihai Moldovan wrote:
> > > > * On 7/24/25 15:08, Simon Horman wrote:
> 
> ...
> 
> > > This seems to a regression in Smatch wrt this particular case for this
> > > code. I bisected Smatch and it looks like it was introduced in commit
> > > d0367cd8a993 ("ranges: use absolute instead implied for possibly_true/false")
> > > 
> > > I CCed Dan in case he wants to dig into this.
> > 
> > The code looks like this:
> > 
> > 	spin_lock_irqsave(&qrtr_nodes_lock, flags);
> > 
> >         if (node->ep->id > QRTR_INDEX_HALF_UNSIGNED_MAX ||
> >             nid > QRTR_INDEX_HALF_UNSIGNED_MAX)
> >                 return -EINVAL;
> > 
> > The problem is that QRTR_INDEX_HALF_UNSIGNED_MAX is U32_MAX and
> > node->ep->id and nid are both u32 type.  The return statement is dead
> > code and I deliberately silenced warnings on impossible paths.
> > 
> > The following patch will enable the warning again and I'll test it tonight
> > to see what happens.  If it's not too painful then I'll delete it
> > properly, but if it's generates a bunch of false positives then, in the
> > end, I'm not overly stressed about bugs in dead code.
> 
> Thanks Dan,
> 
> I think the key point here is that neither Mihai nor I noticed
> the dead code. Thanks for pointing that out.
> 

I did test this over the weekend, btw.  Warning about bugs in dead code
does find some "real" bug and they might actually be real depending
on config.  But it also triggers a bunch of false positives which are
hard to solve:

	r = dma_resv_lock(&resv, NULL);
	if (r)
		r;

The dma_resv_lock() can't fail it you pass NULL as a parameter, so
Smatch says "every return takes the lock", and then "if we fail, we
return without dropping the lock."  It's difficult to solve this.

I guess we would have to say "If we're in an impossible return and it
was the locking function which failed then we didn't take the lock."
That would work, but it's sort of a tricky rule to code.

regards,
dan carpenter


