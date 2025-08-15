Return-Path: <linux-kernel+bounces-770833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68622B27F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED611706C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E742882AB;
	Fri, 15 Aug 2025 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NQk1pLDQ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99204288526
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258063; cv=none; b=TY3ZmOzSBBUMe/LemIRcc5bKk9XUJMIn0ZrH4czI1YxHPkbGz482WG3MDvKhF6aaM+uBZnmfeiU8aX9wvPt16piFZNaR2s332CSFnMYIOKuIfCpoe1WT7acyE7JpjTBjAI4ff0QBFeBtM5+SSm/Q/ItzP2MDsSK2beT09esMOz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258063; c=relaxed/simple;
	bh=AgGFqXqrJ/VhBFHuGF8h1y5X7Jyy+ypna8Zk7EKgm3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU5/3zNnBkalj/VM0l5EwF0JRbnzq1Tnc/G+8m6i8VUeXB7jNpfMx9D0Rm177WVBsVLk3mr9HhpYD0BC2fQxVRnYpObaPRqjIYac1McVcOMCjckSOkPHUPFobC0tAftG+fWtcSk0pGWLfI5DVVONbpsiOCGXzDguC2716gBMfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NQk1pLDQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9d41bfa35so1572391f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755258060; x=1755862860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgGFqXqrJ/VhBFHuGF8h1y5X7Jyy+ypna8Zk7EKgm3A=;
        b=NQk1pLDQyDRXY67LVGOcER/4j6syqY9DMq7WCVAveye6pKu9KememyJtwgXXZNYs0h
         tvjtTVszpLKd3Lep+p5m3D/J0HzjmEFHRFUFpLHh1boXFXpy3JeS3DmTgWTcMAzd/3FE
         otMKeXgRwWmLNbFvg7k3dr96mOGxyZH+ZzOjyuTKMcPZth1uU7S06JFs1f59BRhzEtmg
         n670J8vXWgLhS+ryD33m0Ak6Ste3BbR33G0O79MV/Ck5XKnBthS90YUDzjarirrFFbBP
         9xFgHVp9/xGM/ii4NW84OElmsDS+AqjMdMlMXc0d9MZkiIaNNYhxodydzE7NBA/QDqN3
         qKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755258060; x=1755862860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgGFqXqrJ/VhBFHuGF8h1y5X7Jyy+ypna8Zk7EKgm3A=;
        b=cCf8HOXAxZBrPt7APxK33XJdUHbGVCL6EN9ppZ21+oZiLKEnlhnqNRpnTDYau/WN6J
         Mu9xFfQ+lvXqbJZtKU7GiZ//WQgXtId+DztGj+0T40sdyKLf7X6VSFcisHCkwN/THTQD
         9j2JUf/ltFOrYs449RF5iJFHpMIrJ8T1+yF9Rw5wIg2dRk+/R1wjrSdN0Sd9Vxxy2wBy
         RUkHI7dX6NL3Y1calZ/CJ2umaWr9fHpl0E0ZmjrrLOtNWHSPPa6tI71dTjpJznvi/OS2
         Wue/vvxUZIK6ebKTi472V976wumQJ+OzunG6mjScACGggiABl2H5hXYjiyyupcOIzSRU
         JSeA==
X-Forwarded-Encrypted: i=1; AJvYcCXRpVbutxHr8qGRgjYXto/LlxpZKv8mg5KwcCP5b4+ORdPzo6iLHWhUA0OJDlkILh/g/ugMAgqH/bddlx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uSkCM6akofSdjrtSNK6DdvYf6xeWI0rGOd403FSIZRukBl9f
	JtINSc6eL/VN9ixDmcXKLPOME3LGv0HLAf9oFU/O02ivSufqDMooPQGbhuzHXPjCZPo=
X-Gm-Gg: ASbGncuoo8X2JZu2k94G+8GYDnK3EKe3+NbJU0ojXiaed5T25Ua8U5ayE+8xJnCc7YU
	ZS8F9XhSfsLFQwGozLPQPs6ob8GtxNR1fRlTfx6cE2pAyHuIqf05nmueEOifn6QmCOMvVr7bln2
	LhfZ+QC6y6tw4FjsYpokZ9qL0bXsKBeUA9gsG/YBWJcp7MVwJcQu27Cb87Zz5/c4xpz3hvgvs29
	UlcaAawMob4eW3qWDOHjSGCiGrCP/v+m0oEkE9E9zrzKnyRt68nwfxjB8YOZje5hpZVceeR61UV
	pyxPbHffsSH/0RrCn1N2kNI1j8rjku5BRH8DBeAS+8NWZsNirzuaEfSydN9HkF2u4ZxMy38PcEd
	OIwqhE9mepNZtlbs8f53hBcrf7oQGTHooyObhpyTd6frvDQ9DRHX0La2PKApvkHjUOChpSsYQIK
	wOdNU3w91q6GOjoSFl
X-Google-Smtp-Source: AGHT+IEZLgCHpz2MKgcW37YJtcjLjMyMA+YA7eK+FAPxHUA+IxdCMDYin/UkgjRqTGXMK5VFnVqjvA==
X-Received: by 2002:a5d:5887:0:b0:3b9:15eb:6464 with SMTP id ffacd0b85a97d-3bb66f11537mr1399812f8f.15.1755258059879;
        Fri, 15 Aug 2025 04:40:59 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6816ef48sm1607789f8f.58.2025.08.15.04.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 04:40:59 -0700 (PDT)
Date: Fri, 15 Aug 2025 12:40:57 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-hardening@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and
 memcpy()
Message-ID: <aJ8cyXzMaa9b7ppN@aspen.lan>
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <aJ72XZ0VkrCkKFNy@aspen.lan>
 <710CDE93-89CC-4B60-A582-5F9B2916ED72@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710CDE93-89CC-4B60-A582-5F9B2916ED72@linux.dev>

On Fri, Aug 15, 2025 at 01:28:01PM +0200, Thorsten Blum wrote:
> Hi Daniel,
>
> > On 15. Aug 2025, at 10:57, Daniel Thompson wrote:
> > Sorry but a strscpy() where the length of the destination buffer has
> > been calculated from the source string is way too much of a red flag
> > for me.
> >
> > Put another way if there are "no functional changes intended" then there
> > cannot possibly be any security benefit from replacing the "unsafe"
> > strcpy() with the "safe" strscpy(). Likewise abusing the destination
> > length argument to truncate a string makes the code shorter but *not*
> > clearer because it's too easy to misread.
>
> Deliberately truncating the source using strscpy() is a valid use case.
> strscpy() allows the size argument to be smaller than the destination
> buffer, so this is an intended use of the size argument, not an abuse.

Sorry, I didn't phrase that especially well. I regard the abuse to be
deriving the length of the destination buffer exclusively from the
state of the source buffer.

As mentioned, it would be much cleaner to eliminate the string copy entirely
than to translate it into something so similar to the original strcpy().


Daniel.

