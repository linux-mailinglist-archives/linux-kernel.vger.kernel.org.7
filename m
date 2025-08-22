Return-Path: <linux-kernel+bounces-782687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CAAB3239B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701BF3B5B50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009AC2D780C;
	Fri, 22 Aug 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Bo4JcEkR"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91F2D4B69
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894624; cv=none; b=VhTOgmk8mgDTrK8/7dDssieej60zzCJkgejjpE2L+hdZE90aaqTNWH4KxY8nsRkr8Y+SOW2n2WpolLdOQEz85T4GVZyRNL7P2L0K80LRHW3Dj3Fb02ntvWaSombHduk/iTs4a3qqiVBBjyZsgMK0LxU12zuphl9VbiuqRc+ZgFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894624; c=relaxed/simple;
	bh=lTl6wgweEQv4laAWpdYCO46ogSy927RmttBcv2HdDaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdC/s2oOyOGqaLBPrH2J94T2pkVyBsyxdkHkrXbETX9A0+0JzeZ9v8M1rLlvr8UkMjKxlf6yuH6ClHPRwoHmQbJkWaSRp208H8oaVVg9073rT45pkXlVCEeHyae7cPVj6cXh1njUDAmQXoDB1A3EhcylFPMporAMl0xbyO7RSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Bo4JcEkR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b2b859ab0dso4559141cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755894622; x=1756499422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbpkbOUAEzf+F7t3G4Zil0e0i2itYVJ77ywSmWwUXeU=;
        b=Bo4JcEkRAvnxaZyk72mrObiz2xdy2tauXE7+24GKJRYNV/oUGsa22I50izcVQjE0gx
         VU8YWyFQv2sxQOFwuGPn9qS1zKQj7Z1PyFzAUxeiEp7jshkfMC1zoIjJT4uNnG+r38IE
         yxkOLFhQ8l2XxZV9QKkSRPtTkJGPIean664ABSEu/60oOUXq/NQouN8GxQTWR5uGFZtt
         eKF+S1vg3B08PuRuFTyPTrXttebhhjayPN1hGGwPTN/QaCFLp7wP+6x+n9JMmYnd6Yd7
         GxPWjfYdxBLney7Bo2K9o3RR7z+GUeKq6aRIvYxs4yHtKct+jBs0mna/jGMZHPc+aw72
         lhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755894622; x=1756499422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbpkbOUAEzf+F7t3G4Zil0e0i2itYVJ77ywSmWwUXeU=;
        b=DzMyyTneAiIZ7GPmCZPYEeqqifJ1ElSxSpaazVTP6mBcER9lIxetzTPCVr/ojK2J6+
         yEhdbFGJwZ3dIuuh7WgJ0RSfwWfAr6bnRiqS6Mryb1BJ+sGpUYkaD14hFdw3LLWooo2y
         Z+Ivx7QBs7N/hG/wqQXncCUcZEex+kfGT54FYyD47GlWMS8HsyfORiRu/gzqtfYPsmGR
         9mykUouv9nHa33khdcULSZRVoFQYW6h0sgjkXdqnN+B1j2zRus2/NyEPRD8VdQix5DyI
         d89Sv7m3X9J7aMLF+DJDvyoYWxAOInXV5d1IsBVyWUa1Vn0OKmwzahqA1zSxtdmJQY/4
         2ezA==
X-Forwarded-Encrypted: i=1; AJvYcCXEiegjj/hxmXy4iXUyVPiJGvpGVIhUYS23Mo9jWfo9Sxh6exfLnvtMghjHybEJ66FwJG6PmzJzmCqZOVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvaLTLT6CUPZe9VRTKMY+mkKuKK9X+MXhTqywNt3u21Fr8bqAO
	0saaLh8ejcwP6cVDt6WHDjkrHT8fYRyjBfDLiyo/xANafj2f6k4/omFmHExqihJrRD1A/K1AJCr
	4sPQ=
X-Gm-Gg: ASbGncvLzBIGpud0aBHpKAWdAFtpfCyV6tqDZ48GR1QkSor5jTyHPmd4ksnGgktPzNg
	crQyFogRqvEZPhsByParZ3AdI7ShiIoos9GfmcYNbS/tr/OxcZXLpimIzAQwj4dEfiPOMqcwX3H
	hhVOVfNpXykjW41medFZhA/ssShzzspKlhq795Uyzk2AqhJj7PlkUp8sKY3TjxgkpOPNNd/YhEK
	BzkVs35qxdTFiDtBxCdJuu8tO75zNPtOIh9dJfko5B4fwvoHYCsHN/088zrQdDbVMpCdiBY+iJT
	4NxoONETFPGFjq7tHlPahPsrGEu34rLu3dB7gh988Q1ubPsBhk3y9mROqsgeFk3fz73tqeuK0L9
	wMiWZukQEd1Jyt5cWIhp/WoFm
X-Google-Smtp-Source: AGHT+IG2XWGEJciDU0PSbVvm4slMul4QRrIq8kKvevKNp6CtldMCRhHdKFdGhQLZvMXSrUdVQ4fuaA==
X-Received: by 2002:a05:622a:ce:b0:4a3:fcc7:c72e with SMTP id d75a77b69052e-4b2aaa55fc1mr47860031cf.9.1755894621579;
        Fri, 22 Aug 2025 13:30:21 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:156:8000:24f0::3e8c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebed79a712sm43044185a.17.2025.08.22.13.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 13:30:20 -0700 (PDT)
Date: Fri, 22 Aug 2025 16:30:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: ccc194101@163.com
Cc: gregkh@linuxfoundation.org, jannh@google.com, rex.nie@jaguarmicro.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] usb: usbfs: Add reset_resume callback to usbfs.
Message-ID: <f159e37f-3b27-4977-9712-345e8902eb48@rowland.harvard.edu>
References: <20250822024602.42894-1-ccc194101@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822024602.42894-1-ccc194101@163.com>

On Fri, Aug 22, 2025 at 10:46:02AM +0800, ccc194101@163.com wrote:
> From: chenchangcheng <chenchangcheng@kylinos.cn>
> 
> When an Apple device is inserted into the host, and the host
> wakes up from S3/S4 power states, if the reset_resume process
> is triggered, the absence of a reset_resume callback in usbfs will
> cause the device to unbind.
> By adding a reset_resume callback to usbfs and reporting REMOVE and ADD
> uevents in reset_resume, the userspace is prompted to reissue commands
> to re-establish the binding with usbfs.

usbfs has no way to inform userspace when the device is reset.  This is 
true for normal resets as well as for reset-resumes (no pre_reset, 
post_reset, or reset_resume callbacks).  I don't see any point in trying 
to add support for the latter but not the former.

Unbinding the device forces userspace to re-open the device file and 
establish a new binding.  How does adding REMOVE and ADD uevents make 
the situation any better than it already is?

Alan Stern

