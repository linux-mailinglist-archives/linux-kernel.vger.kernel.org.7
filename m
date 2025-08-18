Return-Path: <linux-kernel+bounces-774245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2242B2B04B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2917B44CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75577175BF;
	Mon, 18 Aug 2025 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB4QsyE+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463F3314A2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541716; cv=none; b=bdAqMhwV9KZeePi0CLgfs4XZ86EuYE3gUECIXyCTHUaLSfASmnX5/1QY3IIWkwnFNCK4AQ4bX4XaNu2Z1EO4RWIa4FoiRfWT6DCRZJY5txb/lijXErwyYc9Kfow3uI4l0np+2AT/3GFV1PARV0SZy4+gy+US7NPJFTfW7XioPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541716; c=relaxed/simple;
	bh=vcgROVnLsv8ICJ3BxetfcJoU6MMmQdWDnGmsiwucy6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eR5PlQXmYKLO83aF7/b/uIL49J8x+PoxYPalMxvHReHuZMRCyn6UVXdujlQjp+tFh8MtHa4WSpE3XX67AwchFil425wBfjRE5ZjT3KC9rEihEnkNt9LkDrZr6TmYKA9EdA6vMAJ4SbQg3n7SL/Nd19fLS4FhccRF3wH9IfI6U58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB4QsyE+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so26760405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755541713; x=1756146513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu7EALYgnjmwwWJlxOWQ01IF+PWZiyqsxCBqpJDa2fI=;
        b=aB4QsyE+mOppR9RdP0hqADAbniBghNAwzhDMMu1XIRfiGj6A2giP3h69Q/JK1+mRyP
         HE84V1eQ22ImZS47Ov3QJzUHtuZH2dEH8wr8Zf2OUjXNBBJKIluq50Biz7I1qYuUS715
         Ntk7rVKnN18NzGXPfz2ltdEWN2YoE47g3k5GYCynRhsJj19eK7QJpwQYGg5etck+BupV
         UedTV1TjbsV2xaIHIJvWzRBzGCWmIiLuJ6mjBMiErX7KlAFc70UpGVnXW4e8jRthnKLY
         Mi25RhG8L2o82xkZynxSOhZDcu4h5I5/ldPVr0Ji9wthG3gvYe1rMLh3rEtahvmpAjhS
         3zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541713; x=1756146513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pu7EALYgnjmwwWJlxOWQ01IF+PWZiyqsxCBqpJDa2fI=;
        b=knnBdr0jlcvE6PbhuDBlZJ5vWVn/qP3fhViEFhUWgOgS+h9QqSzctBkwJnht+Xhepj
         SiC7AIZ2b35cIfGS8O5VZlXoU5pMjl963yy8zhvBLOwN5maZTXidE1Z0P4QebGU0I2Jq
         eFrh9cxqDU1iZXGjuFTEWircawRBPnUQcwcQOUpybDnWNwHLMYriVA5tQig8qiSpzo3i
         4/lQirzOcCyyT6GlJ+cS47QG/ybScGoN2aIMUq0UyQoOWVu7VUmWZ1NT4f4PHe7l31D7
         PiD3rUNNXlY7Ks5Bz6LtDeLcoCN9oJHTQIknRKuK5pbz1ZoUIzejITT3kApWZS9is/ba
         UewQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQsF85JiIjX9XkJGpFE+kjH/UJoov6HAZftPkx4NDfKxQzZv/G45nDnkCtIm3o+BlvjPK9ZVVASwGSo14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTOnatszLVUxT4pSF7Db3rtYcsS40j/+T9/5vgvtNLLuaiE7GW
	4ypfFPKBxxOW3VBE5XCSSJbRjcq/zwDH0txI4W9UZ3uouqK0F8GZHPBX
X-Gm-Gg: ASbGnctXmqCCHy9PR2gZmEYBR7iWTLJEWpZ4NWJdC+BRDO723vYrIAjVYOnbA7cX3iw
	WmhU2XY+vPmfgshrGTl8mU45Y98XYysYQBd8LFfp3cslHoqMwflUloI30vWjy+AKjd2dy33BhNq
	Ur7m6zXeK4FgOcJqrvl3WAFZWePvBiHG8AK6WTf0aN1EoIQh8sBSDhvxbhdtO1k85ox7Pt4xqcb
	ji6yZ2bIkmI6Ksx6WPndVG4ixptOxVk4Fmdvvug/j12+r2OqjILzyjnx2ZongWubGKX7R3YVpYf
	4gv+oD5+VX9xuiqoDoiRxP3A/+CysB9DZ4x36eHfNNw+HvFEu6Z4X5XgjXdY3qEI9sJutg7CVp/
	Y4qcJ5C1rCtUajVRMaKdDenFpXAWrm7B5/bLKeMkklUkNtjzgsGUNbSv3N+uC
X-Google-Smtp-Source: AGHT+IEDVtW+/7sMW8GNjy1lxGeo0BeCpKyCnZTQ0YPehSyT6D72DKJIfcZAKs6vUdz5O/xgGZKwZg==
X-Received: by 2002:a05:6000:1a8a:b0:3b7:940e:6520 with SMTP id ffacd0b85a97d-3c07d0b5ad2mr306941f8f.18.1755541713347;
        Mon, 18 Aug 2025 11:28:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c166bsm466945f8f.33.2025.08.18.11.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 11:28:33 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:28:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, Yu Kuai
 <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe
 <axboe@kernel.dk>, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 0/2] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250818192831.0cc7a716@pumpkin>
In-Reply-To: <20250818123900.GB18626@redhat.com>
References: <20250815164009.GA11676@redhat.com>
	<20250817140726.223f8f72@pumpkin>
	<20250818123900.GB18626@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 14:39:01 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> David,
> 
> We had a lengthy discussion and you have already acked this fix.
> 
> I thought that we agreed on that a) we need to fix the problem first
> and b) x86 version should be consistent with the generic implementation
> regarding ~0ull on overflow.
> 
> Can we finally merge this fix, then discuss the possible improvements
> and possibly change both implementation?

I deliberately put this comment on 0/2 because it is 'future thought'.
I didn't want to delay the patch going in.

	David


> 
> Oleg.
> 
> On 08/17, David Laight wrote:
> >
> > On Fri, 15 Aug 2025 18:40:09 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > One of my 'idea patches' is to make mul_u64_u64_div_u64() a wrapper for
> > another function that takes in extra 'int *overflowed' parameter that is
> > set zero/non-zero for success/overflow.
> > The 'overflowed' parameter can either be a compile-time NULL or a
> > valid pointer.
> >
> > So the x86-x64 asm implementation would use different code - you need
> > the 'jump around fail label' to write the ~0 return value to *overflowed.
> > The extra pointer check in the C version normal path may not be worth
> > worrying about (but the '*overflow = 0' could easily be inlined).
> >
> > The typical use would be:
> > 	quotient = mul_u64_u64_div_u64_overflow(..., &overflowed);
> > 	if (quotient == ~0ull && overflowed)
> > 		...
> > That will generate better code than returning 'overflowed' and the
> > quotient by reference.
> >
> > Although I wonder how often ~0ull is a valid result?
> >
> > 	David
> >  
> 


