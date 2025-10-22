Return-Path: <linux-kernel+bounces-864602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF482BFB27D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B379507E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14593148AC;
	Wed, 22 Oct 2025 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3Squv42"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0F3128D4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125190; cv=none; b=ZUxhm23ObjmWRIEb9vBhHqAx+zul6prqig+kH06Rob7jxChmXg3RZTMscIyB8FZYR2F2WH8H+UvQ9w+x+yn6z5O4+mJaLKldj4lznr4EIH6HL7pNny5DauSW9sfhRu8gS2p9G56lZL5l9xbJsBzrS4nWgH82J0qOo+QQ/kxo09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125190; c=relaxed/simple;
	bh=fbLS6NRaqRZXt4IRUEO+unR+6g1lk+XTzy3wHnWXedU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nF36/j8Lc5J5ia+YhIuwY62mLJLFw5iKiRa0oQAhvj7FDwdDakk2xc/4bBuUa7e/i19xX6IhQGzdsyJTDoIAWMiwbqgTygOAccg8Ov//fk2FIqyl0WlDMpIBoXjvm13UpiGA7gJPQsCWBmhts04JxF72GHlwVl6Mc8GVc1UO91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3Squv42; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so42149575e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761125186; x=1761729986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//C0wLViLyax0tzgYYWAuav1OQzS5yBkCfcAMr1bfAU=;
        b=j3Squv42Ne6AF4NRGlqQBVf5IhyStAbHMElZfA9MiZ6qcUatHcB8W4Qo1EUrq6beu+
         XmUWJMEMOtHw6wCHhjWurNLGOlgR5dF/Ey1TCxpllcZW0Oq57Uc3ZITpFGLO7+Yn9p0q
         h5yiUR+CEbpPYSMQEoAbs3Os+nYcga8BXXFQVz+A23AEOMFqKwnlgJ9tNlvAcuXv1umt
         NPWL8p9pWHfiERXwV/cBUb1qreZCBrk4BIIPLemsNfpr7jsihoyFhEluKPSbUPNW8R/8
         VHJmJxCyMKldiGJG8fztp5Baw5fJNQhWuiwVnCIwhcPBBr8QGOfZF0TEeLPoyB2xF1eZ
         /D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761125186; x=1761729986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//C0wLViLyax0tzgYYWAuav1OQzS5yBkCfcAMr1bfAU=;
        b=d58EDlGcbkZSEgwI5jf4H+oR8mdKZi/4cCwpEE9ruhSMTwUeSmGNT+8Roc97P8yf6i
         KtzLJbpYBy9wfZHR/bYXVpNnR0rFbY85Szo8Y39mtrBUIdW3q4xofdteJoVJJsZW1YlO
         FXEMZC97i0Vp5yrdiP6nONXKYWGDyv+t4XmSbizRa6tZI6EDyG0cazWSmcrATtnhdkRE
         ScGEE/OBVARzhgQEkc7IYU4Rp+hek3Y7boDYTvZtvBfwT68V++bMym5VJhELfR1Yd8yC
         PpEl+evjvXlGLG8QRsA5qJKNf+q9WZJc6zLS8hastfI0s02dwoQsgJo6SB0OHX2VEF0r
         Jggg==
X-Forwarded-Encrypted: i=1; AJvYcCXIzExzomVG14Y3G7lHOcMbzz+Hoh0q/HMfQaDJ+EiBMHfYW+oh4f9EUMMjeXiEw4MdWUDI/lqb9jo61A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0xr5lBE1N8XTgBAhP6xeDmkd51TTBeJezWE6PRTMt5PRh9Eu
	TfbxrfN0WeAQGunvJPj5DHdsg3z2d5VE7FwIShDZrE6A4uAReGGIuv9N
X-Gm-Gg: ASbGnctnL/Oi+TPq5yfV2bx0DInjLEHlDCf3ReM8lLLmnXXqHoJqDbXTLKzQS/IbIyn
	eWdMWAX/ePqH+tJNpK/zBG/W1f36GPRIZtLq4VO57hTnWVEqmeKK2LHgwjjEYU6nn6Q2iLSVv2+
	KNg/4svkpaa6z8MBruVsoKhAJI/+hLfCb2v2IHAUgzl5Bt4LaIAGzcC29H+B8OCAfGMxuk3+vmh
	o0eoYHT+NXGFynpphF+X7gLX1ylC8r9lZLixds/E5uXDvzkqRgaVliIm2/2SZmuuqyRu3TTChQW
	0EnwVhIOJiY3RMuW1lb/yQjE5hzRCFEBhqDwvsLhkfiiM+d1D1A2cPKlkeE97TwvBqJiMueRbqa
	7vQBVbKKvk+thIH1GhJIotG3bW9UH0fgFEviANGZSpZ295dB0V1nWXmY8urMnNJCm++WQPV/IPL
	5bSE1XhbdNNrH30oRUIL992phu42zoEk5Y4AU2D78DyU7WeZx//VCm
X-Google-Smtp-Source: AGHT+IHrGA5T0AgWx+Lb6J0FhMN0AQHzVB5XwfYTdFFca9HjP/vMr81DyX12YfBDWtMAdWtJX6IJPg==
X-Received: by 2002:a5d:5f49:0:b0:3ec:dd16:fc16 with SMTP id ffacd0b85a97d-42704e02995mr13060765f8f.43.1761125186340;
        Wed, 22 Oct 2025 02:26:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b988dsm24749957f8f.35.2025.10.22.02.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:26:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:26:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
Message-ID: <20251022102624.18d2c6f7@pumpkin>
In-Reply-To: <202510211232.77A0F8A@keescook>
References: <20251020212125.make.115-kees@kernel.org>
	<20251020212639.1223484-1-kees@kernel.org>
	<20251021102600.2838d216@pumpkin>
	<202510211232.77A0F8A@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 12:42:10 -0700
Kees Cook <kees@kernel.org> wrote:

> On Tue, Oct 21, 2025 at 10:26:00AM +0100, David Laight wrote:
> > On Mon, 20 Oct 2025 14:26:30 -0700
> > Kees Cook <kees@kernel.org> wrote:
> >   
> > > Add flexible sockaddr structure to support addresses longer than the
> > > traditional 14-byte struct sockaddr::sa_data limitation without
> > > requiring the full 128-byte sa_data of struct sockaddr_storage. This
> > > allows the network APIs to pass around a pointer to an object that
> > > isn't lying to the compiler about how big it is, but must be accompanied
> > > by its actual size as an additional parameter.
> > > 
> > > It's possible we may way to migrate to including the size with the
> > > struct in the future, e.g.:
> > > 
> > > struct sockaddr_unspec {
> > > 	u16 sa_data_len;
> > > 	u16 sa_family;
> > > 	u8  sa_data[] __counted_by(sa_data_len);
> > > };  
> > 
> > One on the historic Unix implementations split the 'sa_family'
> > field into two single byte fields - the second one containing the length.
> > That might work - although care would be needed not to pass a length
> > back to userspace.  
> 
> I think this is just asking for trouble -- leaving that inline could
> be hard to track down places that needed filtering out.
> 
> It might be easier to move to a separate struct like I suggest above,
> though maybe as:
> 
> struct sockaddr_sized {
>     u16 sa_data_len;
>     struct {
>         u16 sa_family;
>         u8  sa_data[] __counted_by(sa_data_len);
>     } sa_unspec;
> };
> 
> (So it's easier to cast between implementation-specific sockaddr and the
> "sa_unspec" member.)
> 
> And then pass that around. But I think that'll require a LOT of
> refactoring. But that could happen separately from this change, which is
> to just get us back to the existing state of passing around an unknown
> sized object but now we're not lying to the compiler about its size.

The problem with that is it misaligns things later on.
And you really want to be using the length from the user,
which includes sa_family.

I'm not sure it even works if the extra sa_data_len is u32 (or even u64).

I did wonder if 'union casts' would help.
They would require a union of pointers to all possible sockaddr formats.
Annoyingly I don't think you can avoid the need for the cast on the
call sites for a lot of the functions - unless they are renamed to have
unique names (so a #define can add the cast).

If you do add a #define, it can generate the size from that of the
supplied address structure (and error things that are stupidly short).

	David



