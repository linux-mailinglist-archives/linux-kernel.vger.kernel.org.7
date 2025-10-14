Return-Path: <linux-kernel+bounces-852759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDBBD9D34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D313B3408
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C426A1B6;
	Tue, 14 Oct 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jO2zU59t"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3732EAB76
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450199; cv=none; b=L2QweDU6XPzsHg7J4JpD7HHrX+qhK9pFPPdE1fw5xxRRyCBFIqcIswqtEVEia1zIUlaVoar7Bl6gZtESOJkvbQwPAHmvAIxY3ZUReE9Qc5l48fb6GEzTcoJftTv2f1wEPrnWUtnbywqGc3dX5JdP/uUmqcDQoeSosRhJQIeXDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450199; c=relaxed/simple;
	bh=Q4/GoNBIxcfJU4OvgQlSaRNFKEqeX55zgRostC9LIc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/4hzvGh0zElPy9Q9GT1U1Xch90oSI8Lm45SeSt5H9QGgDKR9NfOFlVZH98EMEla+vnxLqRmynH33ggtX/fHOUmStzmo1a1IIvGCDw2m0GGoG+L+EBkXOk+DXzplk1Rg3QyyhcQIDYxri2BX1Iq8BX8ZdOw8lYuuJUSsmEdZDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jO2zU59t; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2897522a1dfso50038435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760450198; x=1761054998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2JBdlCNVHbh6ekaYzoo4Q2V4kVXYeSiuY6W4L0bPjk=;
        b=jO2zU59tqfHuc+A02ATtPo8yjwx7p1qrnbVxxxT6uo0AZRJrbVxudNjIZFZPqoU3nD
         cARo0HNOrY/YSSuitp+Zua8/28PZ8QS/xfVJoxBd/SdGc/dN1LX/uTTln2S3TZELMZJd
         H3Vi2J2fbFt7gi3Z4t+jYpY+/AiTLL+RVPecM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450198; x=1761054998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2JBdlCNVHbh6ekaYzoo4Q2V4kVXYeSiuY6W4L0bPjk=;
        b=S3SDaPFf5T1m04hBnw4OKwBfHxM+UeBHr6J45Y9l8qNJAej45ykVSgRB7Sx2waLlwy
         Rh8F843nQfOiHggMfi2Z9djONK5RJekL637PyNnlowkAb2XuLlfsfugSKUhfRTgVW0Il
         g8eemuYRArfgdpPXGpqnrl2aEtwzlUQMYudTaBX13ulz2rGyDhjXMT+Hc36RoorGI7xo
         ixc65mj5nSFVVDzMb4ZJgX4JybZBhjk8GWUWKmRigYmH0Y9ZKJDGpt2noPEq8xHxTdFq
         7xgsC8VFIau2h6kTvptFXAoW7HaHAS+ncCLHM1r2P3G6X0lvE3umsnwriXZEownwU3p9
         G6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWZJNsP3Upj7WUbEhLJHNbwqXfsPw/2M9QjwFomtMC+1cHJbNJtHB3jLDL2lJHb6GZ0k1xMKGrUc0+g59c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEHZCEbUW5DHC16uiscXb2GtVPspji4UoE62HH7IUhqRXsafnL
	ZPGrbwaS9xdrl2SXTZNgbCLPm5rfLHDwCr1O1D/ptkpBT2H8qBK2B/5ptRLwi70vTw==
X-Gm-Gg: ASbGncuJIQvdKv+zmDI8rdcrZRGuyqQrY12KBfdDu6quOMms69qcq8n7BgbDz8kj8rl
	u4SB8XniSqwPDk7LrpcJs/1csuhQvifurgmvbpfiaoXd2KmEgyDbdU+cEBSe/p9+seIAnQVR0MH
	OGUlWq3SlZYttflBVArZLuFsdTjGzalC40y8VKWyLQ59QIQrt5GJ626m3g0fGfKr45qjVKjWw0x
	lhBGcYtaTGPcmgwR8CXKcFK6ptpKu/cefffO9AmPzvcbBwrmWC8q7IFKmBjQRQgBpGZA8n4faFb
	U6jFDrPiRkp7VRchMDC0iEFZbJGMyj1YICgyddhSRb88qCm8KBg5mpUAqTwLQVYHPH0J0KrCCgp
	e9uESvU1IEYeJH7qgGbqBqrwFqyLaUGyY3X1YWiLobMaOOyoeRbvXKw==
X-Google-Smtp-Source: AGHT+IFom6gnN5okXgH4ljiWIYO99mKWEOVLNkApX62i3COUI3Ge2cjYBTcSk6VjeaaXYz+cDhldKg==
X-Received: by 2002:a17:903:1b4b:b0:271:479d:3dcb with SMTP id d9443c01a7336-29027213537mr324664955ad.6.1760450197603;
        Tue, 14 Oct 2025 06:56:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de658bsm166127145ad.22.2025.10.14.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:56:37 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:56:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
	stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <ns2dglxkdqiidj445xal2w4onk56njkzllgoads377oaix7wuh@afvq7yinhpl7>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>

On (25/10/14 15:47), Rafael J. Wysocki wrote:
> On Tue, Oct 14, 2025 at 12:23 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > > Any details would be much appreciated.
> > > How do the idle state usages differ with and without
> > > "cpuidle: menu: Avoid discarding useful information"?
> > > What do the idle states look like in your platform?
> >
> > Sure, I can run tests.
> 
> Would it be possible to check if the mainline has this issue?  That
> is, compare the benchmark results on unmodified 6.17 (say) and on 6.17
> with commit 85975daeaa4 reverted?

I don't think mainline kernel can run on those devices (due to
a bunch of downstream patches).  Best bet is 6.12, I guess.

