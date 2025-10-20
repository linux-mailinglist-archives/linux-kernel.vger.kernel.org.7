Return-Path: <linux-kernel+bounces-860720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6BBF0C53
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 565164F2CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F992FCC10;
	Mon, 20 Oct 2025 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvNEszqL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F42FB085
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958844; cv=none; b=kHG3ggkAVryQCGd6kTcyAfHvFiU2BCfHhfGzlXXY6BUuL7VBh70aiRHdYUOo9Z1iiXn8JWjsVhiC0I46/fNPW4/K1tO+GokPJbyEjprg4df+Ro7w/N34zySwrbSSxdQxBgUuKVNVz2p284kZ95yrXF+8Ss3k1Y8wTRyK17ef6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958844; c=relaxed/simple;
	bh=gcBpP1ZhLnY9zOIftFnmJ1Hum0VuILkD2+x7sHEaLsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ5Ak5yK0kfsf1fkYhw4y7RPX686oO9QK4Ah1t7r8xyf3g1q0iGEuAzpZ/Lj8Y8eFzppHKQWbjiTJTrfKrcrxRxRXcTTX2KzCv2B1klrVf6yeNvgVtZTR/+Xpfe9SvjoCte540mO3zOwQ1EcnAEBPbwVCG3BN8CgMreCGg3Akro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvNEszqL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so22272525e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958841; x=1761563641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1heHxgcOS8YwObtzwumeQPol9GYSJNTAFquV9NKRtlU=;
        b=IvNEszqL73TqREl8U9naZKuPZO7ZoHjMMQiWWyt0lPCO3suS7Nn4SG8kPiyxsGYNZf
         VNxtRcZnKb9Z9qKOUjMdTshjA2IgCnmRIAQMvkZ0Y1G1QPjEKANe/Joqi0LON5+tR5qE
         GvJIPZk3J6emD8S5hL+oqRJThoOLNmJEMR0CfCYfCmOPv8HsXbA+qgqzOwNrOvZOhPyt
         6qwIn75/+sYNuGrAxYOtNWYFxvx5b+zX+l9Nr9g61w/CQQVwSwGxyR58+KzAvUwtGU5M
         ssTqHtbR4Idtw8jGpBPQNv1SvXLRPvmAF+cnt65813xFF6VYzrQ6/RQ5bDuVtGyb3OOG
         BeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958841; x=1761563641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1heHxgcOS8YwObtzwumeQPol9GYSJNTAFquV9NKRtlU=;
        b=HQ4QNxVjmLrEkjNza8j4etHipLG2DV666T+SdKeYArwgq/SOmrZ8LjS3dU2CFBr0uD
         BxQml3e4uAMuhBETAcKPPNTg582DdfqmBUBFBxVRvvh2Q+rXRbpsTFR+/TFwCev2omks
         Hn5RhU5ZHoudVxC6XSxHrMm5QRLYywDU2xe8/hY+07XmNxUGXRYXGXkWICgqS24fAFI7
         VQI/qo3EdsC3y3uaVfYHoXbLewTX26ffe+stu1izsjZNcfqVHYgdzXMkc4GamCL7lTv7
         qUpqYxJmyxU1czpFn09zP1xozu56CJdb4BVAqYz8t54LPqp6BTEaK17BuztdYI31wL5m
         bN/g==
X-Gm-Message-State: AOJu0YyGD3c8YTbw3/cwGPGplrewHaDmQzpYIGEhHR/G0njH5BPfvouC
	uQuZ6K9VtUaVBdjpQQj8IUm+uOtB2AJaB9bh8f9MAlyZN7nbFCoVLXpr
X-Gm-Gg: ASbGncsmtjDJsEccm25v/b2qTg2p8su+Zze0lmGSmdikNyhDTqk+XbBFBMs4tqju2hT
	gdfNku2/O4oASHoE/LZkycgVIA2o9ZZkxRtBL9pIsA2rPMe/cx0SsBjty1USXNmTK1YvTDC/kWf
	NVZb6ZSh3Y5R3K3JKbIINGpRkVPMY6OEYGjwhnLai1WF3KcXXu/m1nR/6LkOmTf2NOgOb5wnNQp
	rkTOIDPUrISwa2BuirGfa2vEO6RW8TqmDx/KWSKQ6kbmFYiAaMmh7R52g7ZPyQOqlOpLQ5WIy2U
	cJk0Wo0fP1uvQvhAWR9agUy1Zx6/iH0VD8ytDLVAtD+r+o0R4qnicIl/RsrySHdxw+ws1PE7zCi
	chPfv7y5WTLeMEtiQ/Ruc1MpdadsUprfUDmwX70LWF1Z4GuIyVUszgBM4mz7EaxoaMNf5e+K1yV
	KwBHc=
X-Google-Smtp-Source: AGHT+IHWoiPpeqTARzLXxV4BCLyaxgCCge6xGUQlWKCJbqKAdJmBiSsHsX5Cf5MLZPjNVhog6dZEIw==
X-Received: by 2002:a05:6000:310e:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-42704d623acmr8416696f8f.23.1760958841442;
        Mon, 20 Oct 2025 04:14:01 -0700 (PDT)
Received: from gmail.com ([51.154.251.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c34sm14733020f8f.17.2025.10.20.04.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:14:01 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:14:00 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	industrypack-devel@lists.sourceforge.net,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] MAINTAINERS: ipack: add ipack.h header file
Message-ID: <aPYZeLtsXqNQYsce@gmail.com>
References: <20251014030038.759222-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251014030038.759222-1-rdunlap@infradead.org>

On Mon, Oct 13, 2025 at 08:00:38PM -0700, Randy Dunlap wrote:
> Add the header file so that get_maintainer.pl will report useful
> info instead of just linux-kernel@vger.
> 
> Fixes: 14dc124f1b2f ("MAINTAINERS: Add maintainers for Industry Pack subsystem")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> Cc: Jens Taprogge <jens.taprogge@taprogge.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: industrypack-devel@lists.sourceforge.net
> ---
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20251013.orig/MAINTAINERS
> +++ linux-next-20251013/MAINTAINERS
> @@ -12216,6 +12216,7 @@ L:	industrypack-devel@lists.sourceforge.
>  S:	Maintained
>  W:	http://industrypack.sourceforge.net
>  F:	drivers/ipack/
> +F:	include/linux/ipack.h
>  
>  INFINEON DPS310 Driver
>  M:	Eddie James <eajames@linux.ibm.com>

Hello Randy,

Thank you for your patch.

Acknowledged-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Hey Greg, could you please add this patch to your misc tree?

Thanks,
Vaibhav

