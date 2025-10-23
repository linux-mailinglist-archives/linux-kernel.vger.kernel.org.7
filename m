Return-Path: <linux-kernel+bounces-866432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7257CBFFBFD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DB83A9E25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3B02E0417;
	Thu, 23 Oct 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTvZwyCl"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC22DFF0D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206300; cv=none; b=pVGUr8aT2Vd1bmFrXpHDHJejG72HKGa7WkAR99d7bqh3fCEIKILq/BwISLrR4MLZ4+eLpjq8hzu5kvL5KvgOfgRgvgOWeFOe4xTghLMsvUMgoHk+yU40HHNMb0EY+hrQRavi8Q4/rTggAgO8Vvhs20Gjqw9an4h+0MB0MxOjysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206300; c=relaxed/simple;
	bh=V56wDzpr+FK/urAryAZ1emGQhQ+cHHyjui2JOXvsrfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcbvg5TH6WHZ07ceiWWG08+PdFu4zHgYkZc0saebKxZAkA4Ix7R70o4baPiU+e+vph2UPBFTgJUfdTDt5FexaD9M020PF2bltAuLNBdzOtX/kOnuaxH/K48GvvQLxtH5v9BLAd84/ZQhyOSVq6SQx0fhTZOOve2DsaX+1BoaXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTvZwyCl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so4701465e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761206297; x=1761811097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQ7/jSo7tNBTZd/AumHePa99ISr2zgcjojKglbLQ6TA=;
        b=jTvZwyClULm7JNOQbvohcgc+Ox6/EfQnpbVqjWcw5LgYqakW2Z/vSh3IRmvFnPcZJX
         l/5OzDs1lpDTTqZir/bksuonHsme3i3vXyu8PqpgK3bF+thTKVRlh/EE4cLbYBEQdGee
         9pNs5ValN2XoGlFrWkpKqtJMiRRhBdsuNo+MvwagPwfhttQTv7VdVUJYVylVOm8C4tlk
         CjqENXEfFjyIBlscVldhWV3un2fukIdz7RzR2Q/q26Ncw/XC0aJBVv5u5MHgB2GDBUJX
         0tUTbigcz23BZm+dGfy7OPvkbAsfPiVFVYaTcTZmn6IxG+FjNxsYW0+9f/lu0J3UjNXV
         aLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206297; x=1761811097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ7/jSo7tNBTZd/AumHePa99ISr2zgcjojKglbLQ6TA=;
        b=FDus/VnlO+fVabLZ5gsu6qNVh9mBH3mptY6rhV/nBo7KFZul69fR26iEeKWvk3kOJF
         v5ibewHzmx3Br/1U+2kypKh8qzqz9Ae6/aOvv09PRSl12+iePoAalLF5qPvEsfzXJM1L
         kHNaZCc3wGtig0k7f5zdfc3NY2lgdx/wyu1u5gsWew7GZsS2Q/TK4qpuilHu6xgRuUdc
         JvE6iD4rg/McwUA/2aMLRD6gWXpYkfKAXlOd/CybrTr5C+UONAUJuh8p41EF/TnW5AQ+
         +RlZ54qygS8VM/w8Zp2bHF6WGaT9UUWhAI0Vhb1QQZwB0lLChnt9qxLM9B/D1DGWcbvs
         T95g==
X-Forwarded-Encrypted: i=1; AJvYcCXn9Zmih/Z69GOMoqDjlNmkuH3AqZZTci3DXdNWcs+xNpmIZNMHN74FdX2EW7cyR41CxziblpXDw1E6Frc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyARWFoQBwKJ2taagcmPBLp+RxgEZr21Rg+qFg3foGzNR6ZCYvg
	5VgDAYOHeq+pV5NyeasbprMlXJMJKBKO3fWYv64m3leyTPpvMctMlSYK
X-Gm-Gg: ASbGnctQdY60oz3sZneQJYzggWNdNYvhQ0iN1tFJJWhNNVNZrSDr1UIHMmvmPrX2lXq
	g2yssSN2U7uHuQilokN5jw8Ne4sEIP0gz/rcP3ma68WF7nN7iUMsj9X5meejgXdcvnkYX7sODwL
	fc16kaqHKCakISyO0Tqtn7YZ5EI5BVlkRcFqU4gEw2wmN+ccTDYCL45Ih5QZo3M6UbJaqH4xQIS
	1u9NTecnBcFQ3erm8PN15NVaYIJ9LlQOGzjJVIzgxhxRlp8hYfFt9vpK2/kqLxFnnvxS93r3fMr
	5GOIgWkyqMANb+Ba3ePQLE4fn70ZSaENlSHa5a43woRr7fQv1h8AZs4fSnmfPsLhe7YTME7Dmng
	fYGLwzWPoloio6fmmpQnmrPiLOPtD3/0xY8Q9I0a0xxyu0yKBwIKu6lqt6HMSr81N2xelpCUW3d
	ohkNooCnnwSMpRuDra2DeIaDoS
X-Google-Smtp-Source: AGHT+IH1MMAfSJxCVNQWeVW46sI3k3nHOhskn/OU83kIm3TVkiWr3RGyFq8Jge1vnvirJ7cC5+EzHw==
X-Received: by 2002:a05:600c:444d:b0:46d:45e:3514 with SMTP id 5b1f17b1804b1-471178b13c6mr160678435e9.17.1761206297352;
        Thu, 23 Oct 2025 00:58:17 -0700 (PDT)
Received: from gmail.com ([51.154.250.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2f3bbsm22103695e9.16.2025.10.23.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:58:17 -0700 (PDT)
Date: Thu, 23 Oct 2025 07:58:16 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Michael Buesch <m@bues.ch>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] gpio: bt8xx: use generic power management
Message-ID: <aPngGCKnyFheybg_@gmail.com>
References: <CAMRc=Mf4FnBoZfdR3gG47te=X53jASzb6MVnUmNw2q1rtUwxzQ@mail.gmail.com>
 <20251022192901.GA1265216@bhelgaas>
 <aPneCYtkbxWp4Hox@gmail.com>
 <CAMRc=MdbHqMJv4otgG0Cwc1KcK2WbL4JL0Q75PRqv8582yexyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdbHqMJv4otgG0Cwc1KcK2WbL4JL0Q75PRqv8582yexyg@mail.gmail.com>

On Thu, Oct 23, 2025 at 09:55:39AM +0200, Bartosz Golaszewski wrote:
> On Thu, Oct 23, 2025 at 9:49 AM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> >
> > Hello Bjorn!
> > Thanks for the review and mentioning the diff between v1 and v6.
> >
> > Hey Randy!
> > Please let me know if the diff mentioned by Bjorn is enough or should I send a
> > new patch-mail describing the v1-v6 diff?
> >
> 
> Yes, it's enough, I could have looked it up myself but I shouldn't
> have to. Please, next time just list changes under each new iteration.
> Preferably just use b4, it helps with version management.
> 
> Bart

Noted. My patches will be more clear from next time. Thanks for the reviews and
comments.

- Vaibhav

