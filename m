Return-Path: <linux-kernel+bounces-841671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF406BB7F72
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87CFC4EEBB8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6C226CF7;
	Fri,  3 Oct 2025 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkGQ0oWh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29B212F89
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518985; cv=none; b=LrvMxalXv5ERyFqmhtzVoZ5OmBKmfEGEUo5NpBeH5E0Cxlhb4uzjardGXkS0raqpDJdElGWNW4mZAaq1YrUyn1U4M6QXnPuDhSJgMGeP9BC66k1WIA0YXNQE+5lVSJFVAZpHkmX7fS5TjNfPZ7LwerlDj3ZwptJQbZYzsfsYHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518985; c=relaxed/simple;
	bh=tVL9p+nxl4y9c+ghVq3bDJ/Nc31UcENUohwqCzhd3MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9rMWLI4Ey4bseXh0anb8Dw/OPx6G1XWvIK1ljOVylVFQ/tieIEJr+Cp/6wziXwNuzVvPQbaHdeESFYK5+EWA9dxiY/EAMaJOwevIo+fmQO5/f5hs3WC2gYTCFTzy3s1XC2KbM2abpV6n5fBnJn68XfSwsQtlNsm34PqfgW0Ckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkGQ0oWh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so12945025e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759518982; x=1760123782; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CokE/k3sp2q5WMd7ECWNZXq4ObJTrjeetW4zf4kEWnA=;
        b=gkGQ0oWhqqkicVvhl/wFrNDqchmoEXRkcnXCSuEO8zVP+R7ygdOD23Ax5ujlX7iLLX
         W9lffsbkvFmc5XQvcj+1x0mArr67JqWrVRCyaHu6y0SYJbQFdthybHDyElGBBs4FJoLi
         7LKQURLzFq4DbD90hwsKwh5uYn8szWWceEKWYsbPeZtLAEddTeYPaUc2Oz9qbUZbIXJe
         FBoeGzHFvWB4zmVScg/ArFgqgESi07ulID1NemZEKAGihRU9tWsKEmJGByyxLIHTBFO6
         seou0XKxhrn8OuF07KsjyAV5a4K7HgjzV+QjG3KUvFnb/7CTbgkaYa7AVIPAo+I1qcx6
         Rbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759518982; x=1760123782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CokE/k3sp2q5WMd7ECWNZXq4ObJTrjeetW4zf4kEWnA=;
        b=CUHpIc9w3LRKbSjc21ApqVxzpFjQsTtlrDXnHtOpik02DTtkuP9ozGS5tjHXyKjOXN
         2meMXwvbBu4hkrlX/umyDkN6CyEx498kN9tUotKjL2/t/kQ4htbfOQGh1y12qiVw5FsC
         pV7IZ+wt/gsJyhmsYwiEIJCVaSlbfUv9io3dkpRvsGC9MRT/yW9hflS88UPcw7uVkSM9
         Pz3QbA5ihwcOy0pPLRul+zQX1wknZSdnsb17yCpHXnkLetDr8uzIiAHQo4maAEKOuQSl
         BF3Y27XRsqb2Sa4n5IJikbZ19pgn52CVkuUV+tTl71D4NtLKKMjBV4Wb5aDSJhv8SHKJ
         UOCA==
X-Forwarded-Encrypted: i=1; AJvYcCU5b6ySpWwTG/blILxiRsTLMjI1U80PhKaz663tmNdM/bCGw7lTTwqIv9ypMxqQsuHYpv1P2avqxWDz6z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNsDITtFTagk5WjgpBu8sdWazTW6texHCk9qG/8H/ZIHlS1zU6
	qGnH3ZPv378A7P2o/9/1gVFqXGpmnfg8TPZJ7eJ+bOCsW9oSPm+9gwWaTJWPTj3eksk=
X-Gm-Gg: ASbGncuZAt/2b5o5wOsC5iN+/DKfD8zcoDS7Nf6Ebq7uX1TC/LNzE3qRv7vyjIiDiiO
	6dJXkwxy0AjNhP3GQp+INY1H7M8UyWNPPpPnnpNwgAxv/RS3sp33SKbFgHgnay9q3lN9c+CuzPQ
	H27OgD3t/URtZpU6w5fNO55a+LJ583t2kbqRiJC4FiggaChSknhLrF3x8F2gDqDaW/VJip9aoxf
	ye1Oj6VXtuNRDXBslY0zA7QOoe0vNLiDj9FQFo3dS+mcB9mOKKc5P1Jadi25xPN6SQYD/wkQrNC
	qeiF10emI/w3CZ4EmXdKe7DRJyhDwKfch7OhL7ns/i1LLLvTp87g0nyWHXDQJjBAv0283jhQEuH
	IUIGcn6OhJHHGuYfntFVgTkS+xhMf8NovHZsK1XhuoAjDpRGbQS6pG47R
X-Google-Smtp-Source: AGHT+IFLZ0QvjwytGIsmgaGtzccZXtbd+f+pX+ocyHIDpS87vpgHFmVAbVGZfoGdGaZFuMKKHMJw+g==
X-Received: by 2002:a05:600c:c4aa:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-46e71146819mr29095885e9.31.1759518982081;
        Fri, 03 Oct 2025 12:16:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e619b8507sm140813195e9.3.2025.10.03.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:16:21 -0700 (PDT)
Date: Fri, 3 Oct 2025 22:16:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Oct 2
Message-ID: <aOAhAaUQdrFjJMk9@stanley.mountain>
References: <aN6qWFc6hIcbRU1o@sirena.org.uk>
 <aN7cRUOxq-zwCoZN@stanley.mountain>
 <CANiq72mDsU3W5Qfyf=sKhbad4tAHJYF8WnY+4VPz2J0paA2gTw@mail.gmail.com>
 <aN91pwLmB_2TwK77@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN91pwLmB_2TwK77@stanley.mountain>

On Fri, Oct 03, 2025 at 10:05:11AM +0300, Dan Carpenter wrote:
> On Thu, Oct 02, 2025 at 11:35:10PM +0200, Miguel Ojeda wrote:
> > On Thu, Oct 2, 2025 at 10:10 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > >   RUSTC L rust/core.o
> > > error: cannot find a built-in macro with name `define_opaque`
> > >     --> /usr/lib/rustlib/src/rust/library/core/src/macros/mod.rs:1757:5
> > >      |
> > > 1757 | /     pub macro define_opaque($($tt:tt)*) {
> > > 1758 | |         /* compiler built-in */
> > > 1759 | |     }
> > >      | |_____^
> > >
> > 
> > Thanks Dan.
> > 
> > Hmm... Strange, it is the `core` library, which comes with the
> > compiler and thus should always work.
> > 
> > So it sounds like a mismatch between the binary used and the sources
> > of the standard library (or perhaps other kind of mismatch, like the
> > wrong edition being passed, but from a quick look it doesn't seem like
> > it).
> > 
> > I will try to reproduce it. Did you happen to recently upgrade the
> > toolchain(s) or something like that, by chance? Are you using the
> > Debian packages?
> 
> Yes.  I am using the debian packages.  To be honest, I don't know it I
> broke it with an update.  It's possible.  I am all the way updated with
> `apt dist-upgrade`.
> 
> I'm on rustc version 1.87.0+dfsg1-1.
> 

It's fixed in today's linux-next.

I did go back and confirm that it was definitely something in the kernel
yesterday.  But it's fixed now, so no worries.

regards,
dan carpenter


