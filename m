Return-Path: <linux-kernel+bounces-841449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B569BB7564
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8955C4E4307
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEA42820BF;
	Fri,  3 Oct 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="1H3/wkmE"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212D4501A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759505937; cv=none; b=HosWjNM9f2TCC9h5fZNit6+KjsOfFYg95sSHZyRZZnRXGs6Afx95kSlxLc5A7T9qV+Zt4UJlMMCA0UEaPtQP1MaU/sJAiM5+eSvMsLXCXrKJuUjc+YC3w3FN3EcTW+/ygGkfkqA/EImn7Q9avneu5JBaoAFZYqg3l1intRoCbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759505937; c=relaxed/simple;
	bh=jElmrcAr4oyF18ok2YTyfN6HMn3LKMWha9ikcRLOezA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq0NBkgGUMdc/iunLDUbCtG26eW1mZXnPCFhIvkBcRSbb7qm+dofEWx0BMp7AM2qOBm7ofOMqmE0cLg1OYmFEt46cLOxYHH4IMSmIrNlIKVVLN088KWelg3tZvxAHwOZafHgayi+PGJf/EisCL8I8FZOLDWpp0slAkcNs94tGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=1H3/wkmE; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3729f8eaa10so642476fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1759505934; x=1760110734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3NqBU312xiWkxtkoNh25eWrcrpT/Ku8WJxrKUtTl5c=;
        b=1H3/wkmEUKnMDq9CcQNmLemphflXSjcM4FDYhu+odjopvEjnwMLLLIVoHV0RFGFuRw
         M3WL4vQ9GJKthy1kd7Wisrv5pyDkd+ULofCHL52v/CR9vHMXt1rOuO8U0sxLoLi9I1mL
         FAviq9dQPb/Uv66YZwaJNRzxNUtwF22AH1QC/oryLuefABWt7Kdkca87WEm0cU64M4pb
         Au7Oz/cMq1ZL9MVikBs7eXohQkfIO5RGqVits4mJkFiRpvVhl8VYRacu6lPihsyRk46Z
         arBmSlvUuEGn84mscjgYha6+2wTlGoJZp6FK/jcX1GPVI6lwfLrXJGoMsTyynN+c71M2
         QIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759505934; x=1760110734;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3NqBU312xiWkxtkoNh25eWrcrpT/Ku8WJxrKUtTl5c=;
        b=am2o9NwQxgTE5V4Pf9VLP47+/ahsrLaV2lrAb6Lm4c+DyZiKdbIF4XfidkzCk8/00w
         +gpxQxuKrKgUF9kKltGzruAz4g0UJY9OKZnIVdf0o7+/JfqI1cKElAa95k8mFiya+yZ7
         0+dPCrNmybE3gyJ7eVQrrSYdp/oKDy481a5cKannUdlofBeMyOnwfLzXQgAejMVyKUDG
         QvXegfYVgxEhNSKrNG/BfZbUGTMSiPzf00MQTyAfwQYMl5Foq2TDkwT9VNXzKlL2wPpB
         VLo3TyPvl77u3Q3PaQmmMfGUl/COJ71cJr7yiLe1e4gqemXlgH5n+98R2mKsoOjKeA+6
         a+7A==
X-Forwarded-Encrypted: i=1; AJvYcCXtzlHmpDOQedhPjnD1VBBfoy/bTSu0qOjFjyAGXprKzDNFdzaI4GMj6TBuTTbnNEp8OQI8DZTB9x9+eU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvvgZ6cHj0sdbwmpqf1UFV3gKKA+x0+kiVg2o+9nX66VMQ6Ze2
	055D6jUqpv18/iB3RuPRyg4axuV7bzQvq6/01jfQfHHIbnXypiND7Jw2CamNxvu6jUQ=
X-Gm-Gg: ASbGncu0Jzp1H7CsO17ztLsmNgVQ1FZq/lvEY+06zDCD6O1FrptTOW86FxjC0rg475U
	d+bHxb0QXV1AZRQ4xxu1Cy8kqzrUa/4h6mikDSWrMq9h649UA1rt45mWtWpklh6MzZ8PnwGr+DR
	fRJ/WGmbnn7sEBAzu5TWtMOGgcw4hzlr4WF5lAL4CEzUIHXQ3jVPO5Ze5dedYpFJckC4zifyeW1
	0e3k8QaBgHwaX60DjH6cpI9FR3jiBsaCHlUbvDkS/VK38nd51gYtg7nWXjUJhWU4BVqYOunR1YG
	Psm/IWsU3WBBnHjpSlvQyizu0BJ2CsnPU+CZuC7GuX0CLwHSVE+n9QNxgmlmJUTzmHo78oivUXB
	Ik5zyRwJKVDMTLjBb4FJsAcHxnWdzOXMzuDa5ys+GMA+b564loP1HkgWdPP8B
X-Google-Smtp-Source: AGHT+IE8EDl0B9W2Gv8lTp/9cSWxCfsU8sLmJQH7LwxIzbTfkytfxbHwVFOC2Zf0EEScMGV2CCVJAA==
X-Received: by 2002:a05:6871:8411:b0:3b1:8e5d:d450 with SMTP id 586e51a60fabf-3b18e5ddaeamr1563916fac.46.1759505934239;
        Fri, 03 Oct 2025 08:38:54 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:d469:1917:5c33:260b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ab94d983adsm1627897fac.27.2025.10.03.08.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:38:53 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:38:48 -0500
From: Corey Minyard <corey@minyard.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mfd: ls2kbmc: Fix a couple Smatch warnings
Message-ID: <aN_uCPqymUbVN34c@mail.minyard.net>
Reply-To: corey@minyard.net
References: <cover.1759478975.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759478975.git.dan.carpenter@linaro.org>

On Fri, Oct 03, 2025 at 12:28:58PM +0300, Dan Carpenter wrote:
> These are two issues which were detected by Smatch.  They're not really
> going to happen in real life.  Small kmalloc()s can't fail.
> The devm_mfd_add_devices() function isn't going to fail either...
> 
> But still, they're worth fixing just for correctness sake.
> 
> Dan Carpenter (2):
>   mfd: ls2kbmc: Fix an IS_ERR() vs NULL check in probe()
>   mfd: ls2kbmc: check for devm_mfd_add_devices() failure

Got them, thank you.  I'll get this in for 6.18.

-corey

> 
>  drivers/mfd/ls2k-bmc-core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> -- 
> 2.51.0
> 

