Return-Path: <linux-kernel+bounces-730248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA826B041CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F94A1E75
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14C525A328;
	Mon, 14 Jul 2025 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AmWuMjaD"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B625A2D8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503689; cv=none; b=TgoR255eXw8Tn9lcWtrQoRNOr0LB/4mtbRjwkS+tBDHK5tl/uKVEuQFmrfDXuBLOFSVt62X9l3nbjsR7yvAeO6XEP42M6eCyIvjPTJAJJrLeHMX0+0VsceX5pckPkIpUFJUJKxABOf7sBCX6HZT7hfmNkcI6QGySIX+LpBSiB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503689; c=relaxed/simple;
	bh=x4VH7WP8We2sREpSucr6S63/HIKE6v5vuALeoeU1eKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqVY7FhT7OyDC+Sj+wAug9Prl1BOoWb3CtN+mq7D26OGZKW3wB0YhhKUZpH5nKZmvdpqFqa9nh1ZcKKeVhehhbfRHDu6hO5YHa8nN5xeHMMg07dmSn6FIQYQUq2MilBv8dzZGDhVKybfOdRo9MNkCVGNe5FRj92wUaI8DDNPNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AmWuMjaD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7dfff5327fbso370369185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752503686; x=1753108486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ/uMtd7PeY7ArKUEfzEaQhJJ3owfAv8oDZUoZLeu20=;
        b=AmWuMjaDAhTE8Qz8oOABGBiGJh/Lzrn3OUIF+otBL7hL1G931+0x56xiHyr/QkE7GL
         NNhJprZZ00o3CHkvQv8vZqsc+Uph0v3iBNKgPrMYVRHhtoar/twrOQbIXENuJMutm/lZ
         rXi72Ydx72JOyES+gojbLVxlAfboGgvUmMpsh4lY25kg19Z7NYmM4xcE1LQK9Cj8/sp5
         zzKuFO74Jo5QchP7ob8f41D6LKfdquDY583Jt2ntmwH5D+QfTsuyYyJFY1yVfhyVA2Zs
         m2REWJpv0uuponGmvwUX2AXH3qa3kPRLZsap7dyTQ096V7GSlDzkAsHBwz6N3BA+wPIE
         nk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503686; x=1753108486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZ/uMtd7PeY7ArKUEfzEaQhJJ3owfAv8oDZUoZLeu20=;
        b=hbcNEQmG/JPU68ZB97dnCZ69QRDi6mSfiYfALSakfsG/u6F/hEMjg6FU6yQFQGsgnp
         Tx9jAw0x6fUtm3MGrL/uNEBmkxTXqQVfZPylOa6iY6Ts6xhUoR30Jpu2OzxKs/MNOpkD
         iheq5YEd4nLLLxEnj05eg9Og+itUpKbmu0ehp7hwAkEQMp1Yx9qK2CSneqCS81AokzG8
         lMae3Akz7i6NS9FmktMNWAqSWUqo6FkLGEOD2JbruVZcKBMfClNAAaKT4xs0CZ0EmGPi
         8HYSP7DTJUYCDon4tckylzuyUxDXTce3zWGgVJMAI77VVhtWhku7DBd4s5rbVbSStj8C
         e/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVKfsEXEH8UQjw66Dx2+VOsttQPHUe2CMvHN1/0TmhCqvvbWqqsLtFbEGiKGzAtzz4l62GSFZyrpbHftYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAd0MYAyfyqKD9QuTw1AvDCbZCRElbSgsqv57T2+WP0OIcWSAC
	OBIh8z9dHrV20v4ftmVEfTH8h2A/Vco+nJyqEZOccewKJYG4EKhQHn4URSSQwwXNVGY=
X-Gm-Gg: ASbGncunXUNhQe29pMe2ewbX6OFIv/QLhVgzAvFjfcstFAsj6oM20nDoe8aZ6WVf7dn
	uAxCL+W16AnNQqVMFitFgi3nE9AWTdD/0+cSM0086v7tQW2Eu4BXM5JVXkDsupWd6Bm5pkFoF0E
	Bszfpz6TNHtcAvvyHrPX8nDaGDoiCQl9mk6iYXLxIzx7sRJgr3Syt2sMDayuEfKcdcyLZwq3LEr
	TJYq1ROXL6qaVYJY4D0yZBwJMsPzWpx9KMLMtiMjRVfV3Xwp3xXjoWLqz9qV84ITXvukvCZJtqR
	y35AoW+mXPUcFKf3aPq8BwUOS7dZHUNQgmz8fPFRM6lss80T/Gqsdj73u4VFx3rV/qCDHt6s1go
	PdZ6BVCZ5Xwz41DO/GxKEnjwdi9Pg1VI8PHlUFsTox4UAMSVxB1fVTLrqJdsSBh69vpnJoOuCTQ
	==
X-Google-Smtp-Source: AGHT+IHDPqyfa5MILfbuRhIA4DZi+evKn5JL2EKdUIYjPKjjIxXzRswcxsKcTqlW4cqrt/sU14Hkyw==
X-Received: by 2002:a05:620a:4613:b0:7e3:2ec5:69e2 with SMTP id af79cd13be357-7e32ec570ffmr287943285a.28.1752503686149;
        Mon, 14 Jul 2025 07:34:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f5d42sm515494885a.28.2025.07.14.07.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:34:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ubKGR-00000008ft9-1MVt;
	Mon, 14 Jul 2025 11:34:43 -0300
Date: Mon, 14 Jul 2025 11:34:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com
Subject: Re: [RFC v2 10/16] luo: luo_ioctl: add ioctl interface
Message-ID: <20250714143443.GF1870174@ziepe.ca>
References: <20250515182322.117840-1-pasha.tatashin@soleen.com>
 <20250515182322.117840-11-pasha.tatashin@soleen.com>
 <20250624-akzeptabel-angreifbar-9095f4717ca4@brauner>
 <aGqHFkPWOrD6whv6@kernel.org>
 <mafs0qzypys0j.fsf@kernel.org>
 <aG9rNQ277weSR_dl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG9rNQ277weSR_dl@kernel.org>

On Thu, Jul 10, 2025 at 10:26:45AM +0300, Mike Rapoport wrote:
> IIUC Christian's point was mostly not about using VFS APIs (i.e.
> read/write) but about using a special pseudo fs rather than devtmpfs to
> drive ioctls.
>  
> So instead of 
> 
> 	fd = open("/dev/liveupdate", ...);
> 	ioctl(fd, ...);
> 
> we'd use
> 
> 	fd = open("/sys/fs/kexec/control", ...);
> 	ioctl(fd, ...);

Please no, /sys/ is much worse.

/dev/ has lots of infrastructure to control permissions/etc that /sys/
does not.

If you want to do ioctls to something that you open() is a character
dev and you accept the limitations with namespaces, coarse permissions
and so on.

Jason

