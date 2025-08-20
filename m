Return-Path: <linux-kernel+bounces-778104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201ECB2E16C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71044E32FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785A92E8B73;
	Wed, 20 Aug 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZEN1voQ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867002BE655
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704584; cv=none; b=LGQkx4p6utSYgFWSxHXtHqf+jRLSpOtXnJaG/DZ1u2pK1cCDOKZfcC3PBQ/UL7ZM8eHUzPI81PhlAVSs2GdDPBBc+bydY1PpEdnU9BSLWjKQFpiTFggekVRyc/yupToewRnd9mQiYXk5HA1krmkXh7XyGa/JhJ4y0IoDvXuBfpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704584; c=relaxed/simple;
	bh=Fr7nbx/XnA7T1p4cI5S4WK+IZu0i2IUuEMd6+eNNbUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx0aWeaVVHCLapGebCAY/pgRBHVFuuw+h9VgaS6AoYWW4iMYcSY/ZgQBHg4IS9mYjavFAJQh52X78Bto4769RAlolCuLMXYGweSMs/5fXnemE5g05j+hCkghnVbxZqKPN03fFMRe+79ETsKcnhmVfYN08o+5snfAyHmnuh70riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZEN1voQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4717330f9eso4751906a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755704583; x=1756309383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/HYcUpkMkv94h2XbvkcDPME37XSxTyvkygwYUU+N7Xk=;
        b=bZEN1voQTNFbiK+NcfUHZDout1Is7WQX4BNzX/Zr+d+4kro5PTq6IGUmQyOSXS/R2Z
         bWH9pRbT2SED4xwp1k+ZIxR/DxBHvBDxoYe8QUB1PbQNrEs/GrkH4tEip30u5RgMxJTv
         7tQIezCixBOCnRnW8OkVPAZHfP2pHKrVPXSFlBRzPA/zosqvBwZme8CMmrSuVG+/gsmx
         Ks2s5a2TCXBMd0u/3T2LlI45IjitExNm30X9QOZyAZsVdD1Gn5eB/tWbcPNr+rzTz7fP
         FOrbRqi+z4BOY59yNUNclZhnBQ7YIAQNOILXFzQZCDCRbjRYfYLwGk8st5kAAoukEFy0
         PRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704583; x=1756309383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HYcUpkMkv94h2XbvkcDPME37XSxTyvkygwYUU+N7Xk=;
        b=I/U9aE4R5MXv29AUozhxcW/oC7hvzd4t71uOb6UhBFZ7ofJYidLuQhq70ome7arrHy
         WDchuNTk21sjvQApgbeLUGUSkwsw8HP+fDrutWqi1WWTbfxMP2MgjlsLS4X/fB1RZa4O
         LjNOPwgXVELehhYorW+snBrru/FScaGZoJrOeaVV/8ljDa9HRkO57YISoYY2QbF0SYJx
         4D5ydbwaFahqHSkiSkUXF6+trZlgpfH/TKK6GwEiCYLi0GOHYmbPcuDLwvOSXLDxRPys
         7v9+p2YnEyudkRmIk1+yf5kEgF5NKPgVBFlWAFAyYAV4VBAlBo84jqSW6lcokm/dJdMp
         CDhg==
X-Forwarded-Encrypted: i=1; AJvYcCXXHop2CQ2IhiAmJpLBROLAm/bq+sWTwvQE87joLfbDNav0wEPc6dvpsUYpTEvXi6izn13rVMt4wbRQnSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP1KxUjRo3kz4bQ6wrjcvJNHvouznZg8s4rLyGob5gr1lV40/E
	cRtFJGV+flL1dJJTZg5S41HSaltNNoxS4onf1zfVFAJq52/NNneTn/At
X-Gm-Gg: ASbGncvCB8W/QU/K36lBme/gWdS5mOjP/r3ElRjXraHOUzQaaMUvo8QXQkEeEAsDksf
	RayQeEc0xJIBZZwc5trND6qJYqDU7CcM2ACItP3s2stDtnMpcvFMoeFpZ3IJgUiFZhz+joMK4iV
	I0B2lYepLLaGM+5GNJIemakxuKYhFIrsesJ/npSAKRZqEkMo5sRs9cozcUKA3lWqf0WMEEv3Ssi
	E1kBQsJiMzDfUfYTRBwrqx91dV+puMbQeMGMc9Mhg8pIhVL7eViOkPWer+SsE6muK7KsfkSkKJH
	OGRafvKOa2O6qi1uQj1wdTncyiIWgwRveInSvp8AcJ7kuk7Rq88yRb+QInyZUHB9CI59fNULsmH
	L2cOUtixgG4qYAADm3hcqmA==
X-Google-Smtp-Source: AGHT+IH6gZ26DxE2JLewlQcM21xboqntWHSUL7OzhgIsIqZtImyMgE5DwLxxAppSG+MW2AGNfYQzcQ==
X-Received: by 2002:a17:903:1b07:b0:235:eb8d:7fff with SMTP id d9443c01a7336-245ef225a57mr41050265ad.28.1755704582780;
        Wed, 20 Aug 2025 08:43:02 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c75c9sm29939385ad.87.2025.08.20.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:43:02 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:43:00 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vivian Wang <uwu@dram.page>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?QXlkxLFu?= Mercan <aydin@mercan.dev>
Subject: Re: [PATCH 1/6] riscv: Introduce use_alternative_{likely,unlikely}
Message-ID: <aKXtBJ5Aqqmvdc1B@yury>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
 <20250820-riscv-altn-helper-wip-v1-1-c3c626c1f7e6@iscas.ac.cn>
 <aKXiH1eqGliLNb8u@yury>
 <544577b2-6810-4bef-b588-e1c662d5be13@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <544577b2-6810-4bef-b588-e1c662d5be13@iscas.ac.cn>

> > This 'unlikely' version is just an negation of 'likely' one, and it
> > looks like an attempt to save on one negation. On the other hand, the
> > function is __always_inline, which means that compiler should normally
> > take care of it. Can you prove with objdump that it really works as
> > intended? I mean that 
> >
> >         if (use_alternative_unlikely())
> >                 do_something();
> >
> > generates a better code than 
> >         
> >         if (!use_alternative_likely())
> >                 do_something();
> 
> use_alternative_likely() and use_alternative_unlikely() are not
> negations of each other and in fact should be functionally equivalent. I
> also briefly explained the difference in the comment, but the difference
> is which case is nop i.e. fallthrough, and which case requires a jump
> instruction. The likely case should get a "nop", and the unlikely case
> should get a "j %l[...]". This choice does work as intended [1].
> 
> I don't think it is possible to give both options to the compiler, so at
> least for now AIUI users have to pick one.
> 
> The same applies to __riscv_has_extension_{likely,unlikely}.
> 
> Vivian "dramforever" Wang
> 
> [1]: https://godbolt.org/z/v8zTEhzTx

I realize that likely and unlikely versions generate different code,
I'm just not convinced that

1. it works in real kernel as intended, not only in the godbold; and
2. has any measurable impact.

That's why I asked you to share objdump and possibly perf tests.

