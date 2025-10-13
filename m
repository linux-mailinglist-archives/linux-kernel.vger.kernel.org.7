Return-Path: <linux-kernel+bounces-850955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 515AABD5572
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E7B581ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E8827979A;
	Mon, 13 Oct 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBG2l7tr"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4622257E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370672; cv=none; b=iIevfgBbBDonRfYU1/zeZMctvjJiEdsxEclFXsE11inBJPJ0AzTULT0U3TzqG5+XaxsUnF9j7zrfNBsIWdjGAoWt4DahcLC3p6jdiIwprU/ODCzFzBv8OKWYArC76d5stw74vlN8N6uCFVbjreT3LI+JzBuBg0v12ojER5/jFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370672; c=relaxed/simple;
	bh=NKeqYvLIifww0mj82IUGWogUIo5n0oR13zzEhbq/V0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCDaeikc7tebpIjt1c7Uf7U74hKaM1Dr+4uEYIEeFKA3l81MSwfpBfVywVUANNNHnG3xpxEmX5ASTgtoyyyloVPuC6n3ONYWFUmZ6tfyLhbwseKsuLJ0BCCptn9CXNVAFuXT4su8OgAMd9HWT5bQSt8M7I7PrEgZBPta9NCEnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBG2l7tr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so26574465e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760370669; x=1760975469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwyKKDWzG4gsyJSsWJd8GHM/HF1gjd2t0aumh3kXjrI=;
        b=ZBG2l7trmrpJTkuaJqX0O0mOmOPPum9n/fck1S5XKoR86y6suhK4D4KQ+eKpRntsrI
         D0tA3MAsV1ByZ1Xs2VDGFZfxQZ6oflfpW3j7KUvJQf3BBJz4l7iKCBjUMbE+iU7+Swvq
         ejdoPat3nbwvReaHlnD6206V4eUf3mxcuop3/RVdxlrk5mzM3WPwxAFB9Jeq4BqRdj5R
         dlX7PNdo9jkc7O6heYhtKzlZdblbqMMpXU9p/LdgS3CtInFJTpdMs2Tdi44rXciQz1wJ
         Mx7APE8ittl/bLSWeFy2gcATKheTpxmaQ5kW8ChWwdP7yGNwDAsLSrTHBcRklbuTWvkj
         4CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370669; x=1760975469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwyKKDWzG4gsyJSsWJd8GHM/HF1gjd2t0aumh3kXjrI=;
        b=d2D11aoMMTQRA+Xf3lmDKHKzuXhK/LYo5NsP1Dk3TA5e0w0ZF2+HlwYhGKrxJKi2r3
         iC4lLPe+fJ58RywpE1yQba+mPPNuHsBkWdyf4EwX2UwkxSwJ7Nks9XHcaSgs5+OoW9P5
         hx+zkDnLWGvk9dRkdo5RtOmKJTynoIyidg8PTRPOhyMsJJjVg38r1XmqB7C405K8LbC5
         b1BW7MU/ppnm/lerYyyHp0PjNT9bCaZwOehUGFqa/VVkrU74boLwBnBFdEW67rwTrMds
         NLLwR8ypDi5EslQOedLD/31HXAvpBn/SdV9pvbMQTrekymlA2oGWZAHkFMkOHHciKct+
         knrA==
X-Forwarded-Encrypted: i=1; AJvYcCXR2uQSVcIhL48VgCklayBLD6XjumJ8owrtTwwKHj10CrKfUANvM/mbj+lkM8In89zAekng+G+sG7Cgcqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywio/Mj5K/5VOAR83eej4UPiwPfiFMztc5CbATbGqYiGtTB2CYQ
	wz+MLcg1uhiQOsAlPU1tKtmrlhWGdJLxKfOiVrHaOVXCDWrg6zXUKHhT
X-Gm-Gg: ASbGncsUwSrBmPnknwK4vuLe6oij5se9hINvKLF+oV80M+a3nt4n28nf9A5j7a2V4KW
	VFZqS8jFyVDh3bydYoIfwYRCLh6x066eZyIYblCc6OKfjXWyQN5blgIyYjw4GqV9QOZF8rBjLDo
	vumbYlKGYRfz9kJX5WauDJ5XC+AFx3sQD1nLH6130UDXQJoRa92eqsGLDHXOTYwgXMVkVoFmNsA
	ZDc4EicSR15SNG+W5E4NtC6ShSAaHBa23FQDUJYz90ZmydBb4/XqBBBWZF2n4F4HhDDqLmd9F9x
	W0TWbflBWSzydzjMuubllyFK5kS4noroKJmLxkMJghM4dpFK6bqICI+Q+6v8Ly6jGH4CYMIe+k8
	Dy44hipnc3MkwbL9PZLA532Po9y3sqHjLKL4YX8RlCu3M
X-Google-Smtp-Source: AGHT+IHf3BqDFUdxdtDr5m2nldUhPx2Md3z5kS1xagTVE8+YxLYmc2AFaMMWKUh9GpwqhsdateVBwg==
X-Received: by 2002:a05:600d:4301:b0:46f:aa8a:d2e7 with SMTP id 5b1f17b1804b1-46faa8ad4bamr106658795e9.4.1760370669270;
        Mon, 13 Oct 2025 08:51:09 -0700 (PDT)
Received: from gmail.com ([51.154.249.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb484c71csm198294445e9.8.2025.10.13.08.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:51:08 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:51:07 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Michael =?utf-8?B?QsO8c2No?= <mb@bues.ch>,
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver: gpio-bt8xx: use generic PCI PM
Message-ID: <aO0f62-RnVyKRLS-@gmail.com>
References: <20251010105338.664564-1-vaibhavgupta40@gmail.com>
 <202510110924.dUQeeRV6-lkp@intel.com>
 <20251011122612.4fa7c97a@barney>
 <aOpAO7j0Uyo6FPcu@gmail.com>
 <CAMRc=Me2ABQUXVeHyfsDR-etyT9mdX-kqxfQDnh3msfZiS6ccQ@mail.gmail.com>
 <aOzcasDutRtw6JP9@gmail.com>
 <CAMRc=MeGbFi10f94GmmAMyLqBWWw7VmPcjaXQWDEtFgS=hvWdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeGbFi10f94GmmAMyLqBWWw7VmPcjaXQWDEtFgS=hvWdQ@mail.gmail.com>

On Mon, Oct 13, 2025 at 05:36:17PM +0200, Bartosz Golaszewski wrote:
> On Mon, Oct 13, 2025 at 1:03 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> >
> > >
> > > While at it: the subject should be: "gpio: bt8xx: ..."
> > >
> > > Bart
> >
> > Done in v4.
> >
> > Vaibhav
> 
> No, it was not.
> 
> Bartosz

Ah I see, I though you just wanted the transformation of "gpio-bt8xx:" to
"gpio: bt8xx:". I've removed "driver:" as well in v5 from the header.

Vaibhav

