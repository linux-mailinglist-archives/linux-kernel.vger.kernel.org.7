Return-Path: <linux-kernel+bounces-896762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48407C512B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D042F4F11BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F842FE07B;
	Wed, 12 Nov 2025 08:45:57 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB32FE052
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937156; cv=none; b=Qp6p44qh6XGfeSXLr4eDz8WXhW4K4ru0hCdWLq7wv2MYsVahlweKhjviS3BM6CzVWHi4qeVAexwn8cSPP8v7LulPe5ZhE40ATpzyU0l5bs1xhYufIWy5rKbOLFAkZ5b7gxl/RorcoI1H84mRw2yzF+9paMS8vwpq+k1bME+mkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937156; c=relaxed/simple;
	bh=XmdKTnnyHUqNeiEg8lR8cDQAudHSJCs3xM8SfYCQvGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoO171bOXl+pxfZC2oZR+n18ttiQyG49GiDgCQZ1Un5WzE+nhuHxn9jfZ76lewbr3+pRgjl1b0Duob+npc9mXZuyDfB8NevUAhGw9Y0Mkl9oPRBskofIS+arAXwjlVP3Kp2nj5f8cTCXM9PXrnFpzrX7e1Gsfi8TYLHy4jXAoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso757402a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937153; x=1763541953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1x6mI9uM3ReqDgxtDW/pYEZ50tke1MXkEHtEWx3A+g=;
        b=Cg0ns1/Zt2UpIrSLg9Zlj08FLA6weHyuTiPjeBwYbbu8lji3J1UzPXMtmtwBgn+at7
         V8SJEOU4PLMu3TNLqZe+FYwh+RwJtiR+Y67tEvrff0NTFIN53qYjJzbs/gclviMwbwl9
         XRjjlWtlatp8zcGf/p5dDPh6s3ij7l/ZIQCR7NLTKaU4ZR0j/7L4jJJ0Yw8lljxdg1ba
         F7s/2ubeX/ncHWuNmTi3aw49mSslibFStdqsAuvD4Ke8FNbci29A36WU1C6n4gdYoKsf
         QxayYqcxxCDKw86nd247rrOkE1kQef7b6nQsPH6Nx6THMVhaw+XhEhSb5B24Lgh6zm9h
         0amA==
X-Forwarded-Encrypted: i=1; AJvYcCUSIl8jfyuSQtm0TpuWYZtrywf3MQ8UMWMLe2OjoToFTuPL8O/m0Evpu+cs9CxsJ1+fz0wJgjJM1MdcBOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD6aBdO82xFWsfcI+dmygtdPPfqntVeIx/wi0z8INc1yf0o/6Q
	s7U9adEuTlA8smpkQwpjJdsqVYfJ+mWAnVqrryk+cgw9LfuuupyO/5qJXc9v7tdqkTg=
X-Gm-Gg: ASbGnctOuQzcUS2WKHytcg/Mj+VVzNT294jM7MZXQw/Mk+FmvQ95ztt5bhuS4MH5siH
	LMBVpM+ZO87hH5NdSZeHIX5d7stSuvlNU8nhTDE7qpNE8QHBeGr3kxFlyBnMjnGKthWXAH9Oee/
	rc/Xp3UX+Il0fa82m9A4ikrVp3lwc1L+9noNP8p+7UYRlIcNWbpkAl1otOICoZa3bYBXQLmdWRc
	XIXmnHsI9HD0xdpEvaCIcESSF6hdZ6qZ7eCFjGYWLvYFhfGjuou0Q/PhIm9TU1rg/XUXURCnvGj
	d/FPUtVkiuv5XWAI/HzrkLKgoJntrtQLmhj2eRfPi5gHBK4cWS+WC5/Ej0w0uIyVfhBu2JB4il+
	g8/+749rnvDdG4JvEtJHdqfq2ImiPQEphtL7Za8Zj0qYFm0lmFlShjkehBDK1nCPy6xwN1E0C6l
	2L
X-Google-Smtp-Source: AGHT+IFD8PZ00Y2eGZhZEudwtgTVJiohD/6vz79m6IyJ9+oDUE+6/ViIhC08fEaP0ZqmwfcQGt4tJQ==
X-Received: by 2002:a17:906:eb4a:b0:b73:28da:9ddf with SMTP id a640c23a62f3a-b7328da9ea3mr335461666b.25.1762937152743;
        Wed, 12 Nov 2025 00:45:52 -0800 (PST)
Received: from vps.markoturk.info ([109.60.6.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf4fbf3csm1544409066b.26.2025.11.12.00.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:45:51 -0800 (PST)
Date: Wed, 12 Nov 2025 09:45:49 +0100
From: Marko Turk <mt@markoturk.info>
To: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
Message-ID: <aRRJPZVkCv2i7kt2@vps.markoturk.info>
References: <20251101214629.10718-1-mt@markoturk.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101214629.10718-1-mt@markoturk.info>

On Sat, Nov 01, 2025 at 10:46:54PM +0100, Marko Turk wrote:
> QEMU PCI test device specifies all registers as little endian. OFFSET
> register is converted properly, but the COUNT register is not.
> 
> Apply the same conversion to the COUNT register also.
> 
> Signed-off-by: Marko Turk <mt@markoturk.info>
> Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")

Hi,

Can someone take a look?

Thanks.

Marko

