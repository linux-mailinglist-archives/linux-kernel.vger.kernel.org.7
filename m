Return-Path: <linux-kernel+bounces-829185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B357B96792
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4AF1891F34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50225783C;
	Tue, 23 Sep 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="sP2q4quO"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB79255222
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639507; cv=none; b=JEM/lyfy+ELt4qZ9h2XjHAv0IFcdW1xbYDXfbhy9Dz8uKahuAb2Y9+38nFp5FF2eG/EjH6/xwZz7ifuj6Tezq8a1Pb2/lRorxoktZQ9JPiX8CqL7niKK6gFqzYdMA+3phJg6jHWJjYFh6oiX0MBeYRop3qfLHcvm868X32WkWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639507; c=relaxed/simple;
	bh=2JkaldusHnBs9nmgBDsrH+Q4WyDqb15X4kwjmxawQQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICcctgYyvpfUEHXHXZpz5kBrBaGTsGuh4Ya+XzV0wEoGugH8vd4AiAZw+47Cz25Pf4iSNwD+Wir4I8RZb1nat5pWLBiaw5jUe5RpCnmJFgm/H702rDs4MC1OmBbyMVeYhDmehjYhArtsxf/ot+xgqb4utj3hXAKpiRdM9Qc0Bf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=sP2q4quO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-854585036e8so39066685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758639504; x=1759244304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ri9p27Eq4rFSbThj+QyWFkt8KhHdU/v11ZSJ66tpy+4=;
        b=sP2q4quOghk4AmdeQfkzmAp6v38+MLilc6cbq47H3cKnN/wlNnmOcFekTKtif/TOqQ
         q9BqQAwrQUVrln9qvB3EOtOaEqEsvwGLvSpIDYA/kd5jJU/O68cU5TsM+AfY1x0eZdkK
         92OYqB4u0OM57ZHV3w1cThWDLHlNqbsznZrF6NVR1FEisEZsfTrDTH70J0fUN1JhoQor
         WHj//WVSAHYVBuaweV8gGWQEhUklAAj6kTk3uyjGk6P9U9UZv6Frbqc+5sz2QJ/dMfMr
         al3sGbD18AfP9NVnOEuQj/f9ONO7uYhc1paHQFB9j6YezGYUHG1gqVJSKB3Rnjt2p6jc
         RFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639504; x=1759244304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri9p27Eq4rFSbThj+QyWFkt8KhHdU/v11ZSJ66tpy+4=;
        b=Fj2FbdVVMmvVZU0n1jWiFChCtgaRlMtPpuQ9g4RQSxxb4ISdbWxLYhQ5a2VPuC6MxQ
         DLp8jGZB0M4MXPwV0Td8GQNx7wfLK/M5lG7QMOqua5/CuZsl1TxCte6XeZxvBeUclv6n
         lVoSQNX/GpFnbu5y5e7xSxVMnV7bZX4SjkD9OmTqcdxKYJ5w5ePGzE5IlyLoQq5J0Iad
         0dCpgHiK53SWYaTmrgpeEztahyKe0ZGE6jWDi8vXqECdWG2qSkb+wA881tf5cN4pqrNN
         zrbVR0Gaib6yhrTTYTjo0hMvilgs0V/oty2gckpIVlPMI8REyWXfP2jSn7WgW8G6+6PZ
         w8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU1wrbDTJJPhcAEelxShEFD248M2K9JKflpy3mWDusGreUPuMpoLbhNZJ1EGggqjRcEkvRs6TNREqkBCfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJR+ttN3pxWaklfwjh0GpNmsTLFHGGmJHimf3uDA/PLbud12hD
	Vx6sssArUMV4c7+NYJb1KKdHkw2bikYrfcxjVzkvilZtaBUewGkwdi6j1jMEiSp+Fw==
X-Gm-Gg: ASbGncv8Tk0TVrvBqBigr0F5KyoFE99tZpXA/FR5G1vh0a20wlJaUGq5CPePJTyGN6K
	yndBF6FSHd4jWZv8z6ZLZyqa/4LhJnETFrIBifVttaRb81TDVmKrHLLJ+xwszgpxyWEkSp+aXlN
	k3TxsPPZUyxfOAatc3TO+BqkVwRph+1eMMV8qOv4ALd/iBM/kiSdmiPrO6i1m88fwViImTUvbjD
	Fs9bffQ1rANfrFrq+VQj1DO1T0UtDpx9zmQ0ZpG791QNhaUC/4TJtQ//96FuW1orv/sffOtFLRt
	OfNrJXXxHWZSgaYHIa3d81Xor2uFiD0G5rT6cFTHkUbkAn9tmO34fflEW1jUdk+C/kHP6QwybtM
	4KLMSBDtxtIJ2rtBMThlwyUwb+gAu
X-Google-Smtp-Source: AGHT+IEgq8/SYBm2nZcy+yIjnlm8ABqUN8h1aeiVdFzWtXPHXTllLJNSOfYjpkG/XFj9RGAIuprC/w==
X-Received: by 2002:a05:620a:2588:b0:84b:871a:1651 with SMTP id af79cd13be357-8516eb46222mr283379585a.18.1758639504418;
        Tue, 23 Sep 2025 07:58:24 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::5082])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85411d12270sm55868085a.26.2025.09.23.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:58:24 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:58:20 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
Message-ID: <0ff2a825-1115-426a-a6f9-df544cd0c5fc@rowland.harvard.edu>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <27AB9C59-BAE6-4F1F-8638-DF9244D0A616@collabora.com>
 <DD08HWM0M68R.2R74OSODBIWSZ@kernel.org>
 <2025092326-banked-resubmit-67c0@gregkh>
 <DD0994IZMBVQ.2HZOA2ZMWT2I@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD0994IZMBVQ.2HZOA2ZMWT2I@kernel.org>

On Tue, Sep 23, 2025 at 04:38:34PM +0200, Danilo Krummrich wrote:
> >> @Greg: Can we guarantee that a struct usb_device is always bound as long as one
> >> of its interfaces is still bound?
> >
> > Bound to what?
> 
> Well, that's kinda my point. :)
> 
> Having a &usb::Device<Bound> would mean that for the lifetime of the reference
> it is guaranteed that the usb::Device is bound to its USB device driver
> (struct usb_device_driver).
> 
> The code above establishes that you can get a &usb::Device<Bound> from a
> &usb::Interface<Bound>, i.e. an interface that is bound to a USB driver
> (struct usb_driver).
> 
> It also does establish the same with other device contexts, such as the Core
> context.
> 
> Despite the question whether this is sematically useful, I doubt that this is
> a correct assumption to take.

The intention of the USB stack is that yes, a usb_device cannot have 
children if it isn't bound to a usb_device_driver.  However, we don't 
try to guarantee that this is true; a particular driver might not 
enforce this restriction.

There is a surprisingly large number of calls to 
usb_register_device_driver() in the kernel (four in addition to the 
standard one).  I suppose a little auditing could ensure that these 
drivers do deconfigure their devices when they unbind.

Alan Stern

