Return-Path: <linux-kernel+bounces-763457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B113EB214D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF6F7A9DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4729B2E2DC9;
	Mon, 11 Aug 2025 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dgmA9WA"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C554C7F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937896; cv=none; b=QAxfbnz+x/VCPmi1xjhTSo/zzzb5qbapv5/c6X+YFkIXsq5QnD9LsUVqAe180KLymEPYzYu2bO/ThVegDwS06Jlva1ZKQMeuYfSOO1zf5YTmHtMdEb5F4G0xBTUO0FhqWNE52Sn9j3QjdAJTu5lCm3FMwrvA2yT6xzGxe4EJ0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937896; c=relaxed/simple;
	bh=eD1JMRP/Es5HwibQgtWu9SSMYOCGmGkjaLv83QJ5r6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZM8pVQcWluNBQPmvuDMUoUnuZ8g1HSDCRjlae9s6i1xZwGxgpaJqttp1Nv9+9e7OscwxU1ajlUBhoVoYX8IkQCuPQqIIZ4ZyN4bb/gbz0Ahm8a8cdV/wAeGfu9Kz42ZpbVOdYSytqHl8GvxNVIq9oyE+xRl2nQZJNaRDSTAsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dgmA9WA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-242d3be6484so19155ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754937894; x=1755542694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKekbjtMMdJ7SIAlWQb1XQZx7DQygmQqrvZPNnvPrMg=;
        b=0dgmA9WAidlZmyfCNze8rUU6sNpCVpnbctobljatkR3c+dk77tZL1/tulEjbS+P2kb
         sYgEPwXnd5rfkl6xn0f0uY8on8IXBPaKdhQg5tfQmm5xm445DZK97TSjYdy9qa+DHx8f
         zTYzIL2Ks7JgxjzO7LN8uIYDKhNfVvRpsqJ16R4Vojk2UexWR/2yYIvasFVAJxxAKYDE
         52m5PaXc2iAN8OEhpu+3HOIgRzsKwupp6XV87RjLrdOMnzmRWJylZoLjn3DqniYVYdZ7
         dDDA/5viJKJbYaWy9VP1lW8d+eVw7IitN8bHFOKsjzXGIN2NMdWtNPu2woc3OevHOQuX
         8sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754937894; x=1755542694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKekbjtMMdJ7SIAlWQb1XQZx7DQygmQqrvZPNnvPrMg=;
        b=p3phmY5TryJNaCgUJ+N15alb8enJ1CveW1D0lre9r4a7jZyy1mFU+/Y5Bezh4fhcES
         VVQKpHzZMrMuFNDfmjV7mRFEGhGBv0YHuzzJaR36MpS0hPWmRC9IBbbpdAtlzNzqyCMY
         yEAbjGYZliEg5csx6SejRBsjX7lK01NqoRitd4kILJ5sS4XUiiN0T7DF0PeJO8Bb1B/Z
         nFVLWPSVr8z3JfppurzoyJpSt/8CkJvShpz52LQTdvVFn4OODSzdWAN3iQg8rv1Khx1A
         DYuIGrHxW+ETQp9E+gcArQbMuZmP2hOwdn3lkSW9IukLC4U5lbX7TvoJ05Sb6btY2dwQ
         1YWg==
X-Forwarded-Encrypted: i=1; AJvYcCUhPOSbU2ZCqhagbktL3WLa3yPDealTDrD3c6vq8imqJVO/vDXf3U9glO+EsdKgO47g2bgM+8Pok+vX1so=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7vMTpPhF60t071xWz/Xg6qirsVYxNtRC1ND1GvSqkua8lD0O
	uCBAisMO0gmuBl0CPIH/qI9Ea1Z6TfGqOa1ybAfTl4Hqco8BdBUIvFstxUKAzgb/fw==
X-Gm-Gg: ASbGnctegpgNNjvM6gD9Ae+9tj7Fo4lBVbhtS0siXn8MDPq3EJ74Y/gZ3/AF1jSptda
	x4HDPN09CgWcnbRc0FgYx9vG+CY8SwNoAyHOZRUE38RSZcS/LMTTDn1HBq9QuH/tdx99T71P5zE
	LTwOs8iDQA6hRCR8/W+TQmP031nEmbnFkQsV6ZgFe8A2PV5FOrKA7mANXhOQ3mJY3g+P/JWy5fj
	kHVFbarK8tMHuXbaDlGMAQTDB+il+YOizo6771gsthTUoWHOptnynKBDRfZzEKhZTgvYT2VlMBa
	rXaPTvUF7B6aUp/7w5Hnt36RnW2erYWvlnSQ1bquH5BmMb5wcrwF7BQpyBeAV/6HP4YrC8emq2+
	Vj93/+ZxJ0LqvuHH/Tdkt2+qvkaf6689/hrxicyZOLMjhtLf8t45bbeL5xCLi+6t2DjFPo1ikRR
	x3680UV3qU
X-Google-Smtp-Source: AGHT+IHiWhl4yc5ItCNYYFXdPnCpao5l924cPX8Bpsl13IeVj9dmt98bP86j9X/meSw5RZVCjXBWXg==
X-Received: by 2002:a17:902:d652:b0:240:6076:20cd with SMTP id d9443c01a7336-242fd768bf2mr237815ad.15.1754937894246;
        Mon, 11 Aug 2025 11:44:54 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216129c8cfsm15380238a91.34.2025.08.11.11.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:44:53 -0700 (PDT)
Date: Mon, 11 Aug 2025 18:44:49 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Hutchings <benh@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Add missing module description
Message-ID: <aJo6IeEPEJpqjUlu@google.com>
References: <20250809073018.1720889-1-carnil@debian.org>
 <aJoqFKYpWkDCiIJp@google.com>
 <aJov4RkRMRhCB1DU@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJov4RkRMRhCB1DU@eldamar.lan>

On Mon, Aug 11, 2025 at 08:01:05PM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Mon, Aug 11, 2025 at 05:36:20PM +0000, Carlos Llamas wrote:
> > On Sat, Aug 09, 2025 at 09:30:18AM +0200, Salvatore Bonaccorso wrote:
> > > During build modpost issues a warning:
> > > 
> > >     # MODPOST Module.symvers
> > >        ./scripts/mod/modpost -M -m -b        -o Module.symvers -n -T modules.order vmlinux.o
> > >     WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/android/binder_linux.o
> > > 
> > > Fix this by adding the missing module description.
> > 
> > I'm not against having a description but binder is not tristate. Judging
> > from the 'binder_linux.o' this seems to be some OOT version? Otherwise,
> > I'm not sure you would be able to reproduce the warn.
> 
> This is entirely my fault. We saw the warning while building in
> Debian, but missed that we apply the following patch:
> https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/debian/android-enable-building-binder-as-module.patch?ref_type=heads
> which allows to build binder as module.
> 
> I got confused by the fact that we have 
> MODULE_LICENSE("GPL v2");
> in the upstream variant, but no description.
> 
> So you want to still have the description added or drop this proposed
> patch completely instead?

I think it is best to drop all MODULE_* macros and avoid further
confusion. Including the current MODULE_LICENSE(), this is misleading.
I'll send a patch fixing this.

However, I don't see why we couldn't take all those patches to support
binder tristate later on. Assuming that other maintainers would be ok
exporting all those symbols used by binder that is. We are not using
binder as a module but it doesn't hurt either. wdyt?

--
Carlos Llamas

