Return-Path: <linux-kernel+bounces-759911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81264B1E467
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AED62606F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C55263F4E;
	Fri,  8 Aug 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLYiuUWz"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A889263C9F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641840; cv=none; b=mx+mlYKVpQFNLt2qSl2f3EOPMop+RApDItddvaYLDBl5Nylfp6N7bnfOLWmrsAp3Y9t31k6kHX50R5WEaX1CorgDvjMdhzPREmqCJmvUBa7qmnJZS0pIkJELdOtIddt9ZCW5YCTP9AETdN/unadWHxp/6u/ugpdGv7ymTrEac+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641840; c=relaxed/simple;
	bh=qVxBvkDxJ7IhxHq3F0Th/Ez5bIy1N+YKsQoJ4RzF28g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU5p/Wn5tYPGnwJmnCldbJd3eBW1JeklW+27exOadP5+1QneycPsP61jTrsaTYWZohylGb0FpxSZ7lF6OvwVMH/+yrJ7Sf+2OKKclQBWLzLW9xP8rY+MOR8Rq5/3SAAgToTXMH9ILAFHJBJnR43Pg2yPkq1yjNirjY38555aNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLYiuUWz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b827aba01so1788254e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754641835; x=1755246635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xieBTMobclIdMCJXbvNoXqflE8aUGbCt52N/S4Zk4e8=;
        b=QLYiuUWz61hS0waL7xdPfRexv1TZAWt3a/mT3jXADhPPk+dg/27Pdj4SK0tukCa4gP
         ANqxL1aLjx9gncKkSNgCgRIZZbIano5o93K8o7KAUJFAtRlwzx9xxTzzfpwT7FpW+ayU
         MzBrxpP/NPkJGHIUlFq/A2Z2VMz5+s/22I57ijHLro4mZZN9TvBvliOEidTbTvIqAt6C
         cTEmJucKId1fXzQFV5NgnV1kQeiJqYry8oEuaxZGqKQxQtu37tjQmyAqvt+7XcjRRFis
         fdjqcbIwmgsI3L7foub+ybuEwKT4KrmDPv8ndCyZa/XEwJaldHDZZpZToaeXLXI4+APp
         hj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754641835; x=1755246635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xieBTMobclIdMCJXbvNoXqflE8aUGbCt52N/S4Zk4e8=;
        b=gDoiYdBkG2TCjXsJuKe0qVmCVbEIFnzTcCbWDfPloD2y/zq1XDklUx3KwIT0fQOIKq
         AB30LmsejdsWXKivwekIfxcDhUlY/4KwYXubooTh6dwPOcoBek3Fc+v0jlZabJIcxlfO
         3VfO/9V+T+TWbNaet+2urzDrgiJU5PZWf9MYqW3qcThDU/wgxhk2Ec8T0nBoGuj8Ii1k
         Cxac8dlFVtlDnVr69sH8BE7WDcPTl0Lla6vxPs6iQRRoH1UxWjiD/x3rIBziLE810Cj9
         XPs8owSNug0LbebC0Izoni0LQ5P3ozaRmYt4m0e4LaeAzIIeYG67ocyYFXnQ9X0h9ZFP
         xgCw==
X-Gm-Message-State: AOJu0YxWMVV0t7YHF7cCVDt0C4CfZTjz9z4g74ePSeHpl1lIW21wd/88
	6QEB+H9RWlk2qbB3AXVQnLaoofHFfhD0uZ7+yupmfLD0GRnVu6ieFgUgSJn7Odn4BOU=
X-Gm-Gg: ASbGncshs0/uNfQo7sfPGDOVmU03TegRqgp+z6tQSeT1AK/ynK7GD6S4G8Tis2OmVXe
	kfuxyIa6MhE7rYIMRmz3P6jtb/IeJ+VPtibyLRnjPpAIS75Z4u5E6U6LVz2VsOqNVPB8SOxWpQO
	rh/cWignXf5hfNz3NJv3TBqa1xv4TSLlFqaLjzuLvFOI4OzGoOq75KmXn925aLZMq6nGw0j9Icl
	0EQgNGjhlVJ0W3idTeNpuiH379qZpkSReKDe8AmPIqR1i6qySgQQIIhUDQ36YJ/3KDvpqCoNRBn
	+/4oRaYO1rt80+uAHGgiqLrrnr/KTtuiqNQYjLbXW3o6wUT0tpPclWdD81fLBrtCygoowSmAEdi
	kFP2T5GzhEPwxPc43eRXLD/QUN/+YZz/w
X-Google-Smtp-Source: AGHT+IEYXg7vtZbnJ2DYBddME/aAvQldI4kwG2TiNueAkrB9UxcNGaNQeqMSkd8yhFm80/f1+RGHQw==
X-Received: by 2002:ac2:4c47:0:b0:55b:87a8:6014 with SMTP id 2adb3069b0e04-55cc00ea733mr536665e87.25.1754641835099;
        Fri, 08 Aug 2025 01:30:35 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-332388d87f6sm31610381fa.44.2025.08.08.01.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:30:34 -0700 (PDT)
Date: Fri, 8 Aug 2025 16:29:50 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Nam Cao <namcao@linutronix.de>, Inochi Amaoto <inochiama@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Respect mask state when setting
 affinity
Message-ID: <cxiav5ufadstautkkf2hlwkl2erspl36nvlmditinftxhxktcm@3yweuuj3q4kl>
References: <20250807111806.741706-1-inochiama@gmail.com>
 <87fre3mhkh.fsf@yellow.woof>
 <nowqjgxmomniw624avrizohwzzq7ebkznb64m25qim3zgxjacn@oizd7ngxjd6a>
 <prnjyu7ev5scocf4jh5jikox3niftje364lf3bjvizppxamdov@hbizpiazqual>
 <87qzxmpg85.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzxmpg85.fsf@yellow.woof>

On Fri, Aug 08, 2025 at 06:52:42AM +0200, Nam Cao wrote:
> Inochi Amaoto <inochiama@gmail.com> writes:
> 
> > On Fri, Aug 08, 2025 at 06:01:39AM +0800, Inochi Amaoto wrote:
> > After some dig in, I found it is not very necessary to add this,
> > When all enable bit is clear, the PRIORIT register of irq is
> > not functional, so only umask the irq does not make sense. Only
> > calling irq_enable does enable the irq.
> 
> Yeah, I contemplated doing this myself when I added the unmask to
> plic_irq_enable(), because it looks more natural that plic_irq_enable()
> and plic_irq_disable() are opposite. But I don't think it is necessary.
> 
> > I prefer to add a comment to describe this behavior, instead of
> > adding this change in a separate patch.
> 
> No preference from me.
> 

OK, I will just remove this mask function.

Regards,
Inochi

