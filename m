Return-Path: <linux-kernel+bounces-748979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49191B14855
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4061AA1333
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790EE25B30D;
	Tue, 29 Jul 2025 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGinS2r+"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CB25A2C3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771080; cv=none; b=E+GsowvdzP45lPkUpxnEg/vl6OjFIlXRrmUQGhABDUqSUIfIi0HGJo47snZ+uFkso5ZP3Kb4Fil4pK6XL6FqtbK4zk+HM2SK6Lwv40hhApHuVz8LOop+TNs4+UKp6XpZqcrRwP4NQXyiU/9ab78c8KPuPnendRkUxhjbY6fum9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771080; c=relaxed/simple;
	bh=naZF03yVuyzWmjfRvic70Y5lL7P4g66xW16e2TzlWes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgLH/ALzMlNmIWvZyFwHkTwcQmtjgD0BB5tHGb4PwQbPUuHxTqtuodrt9rI19wzwSsV/t6sPcYx5OnVqiSWw5oXuCwmuuJVMS/XU4to6nlApOGlw2iWeilbDjGCEP+TOlKBztVd9Q+1P7JNbbMGzHznwkIfsNQmV9DrdoEzO1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGinS2r+; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-302fdd379faso1701438fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 23:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753771078; x=1754375878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mhCwXIaYxmo7Z4nAHipCVOWynp0zVrQxnE8q06yN35o=;
        b=kGinS2r+SBTIUk5W20G5ZTqLzEPTJFzC5Lny/agpOiPifjED9PKp4vzW6o1fOIrcyf
         B6ejHbqQtPH88vu/gMOuJ4Wb+jfNI/1IMWeqY2//jMCtXR5ayDEDMknBWo4O2nmlYp4D
         0ggNit8N6pVju359vozI7lHb67cBvowmLw6Q5OAR1nofWUZSZ5GkS7nRGl2+AqrZIAjs
         gQw0MJeUUQucmFAPA7hxgT4vT2i+YFRQrMs3HfC6XbCPxM++XCyleSEmJRmWxxayd6FZ
         a8UV3+ZK+JUoeTPPRzpXltXcE/bAAM/wh0htzzyq8bfW8f0EwTHkrZ8P/rxSLNrlwxCd
         MM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753771078; x=1754375878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhCwXIaYxmo7Z4nAHipCVOWynp0zVrQxnE8q06yN35o=;
        b=vhmEH6EjD7okeaGiqO4WX3vKuJCAbSc+b0XSutKXUXLoEEyJUuBGu3UEUkeOp/Twew
         b0Omb+SS93+3nsNoZ5ws/lrwiTpGw31FYEHl4DSwP3J56+JGmfjUaFE8itsdFFpXS9/8
         Sl1AQD8OtlWHAGUPP+is6AbKVvmlNdyxp7ezkgNUDBUZy1lU/AnR6p/0qbRSUhgKrvEi
         Hz5Z5Vwnvouc+Zb2w3WMPiCX28AjanlDPbsWAfdQAjHl+fSWDJ1K4VYuYCL0YYbz/4p1
         tPiFYvcnxu16ZsQVkjcs0qt58G6GOb0dHAP/2/mSO/pTYDJQvIeKPRuPBczcSksy1aJZ
         +IRg==
X-Forwarded-Encrypted: i=1; AJvYcCV8EHTSxriQoA3Tks2iKWhB5VjJS7bW4gzKbaCbV/92CSpiuVHmcGOVViCwsSRXpfjXroCqTnQhsdKBChw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdv9sIJ1+WIgJZc0fJxwu45YIN00/CG+80is2XJUWW44OzSOfJ
	4O0q7FtIwq60KbSlMqFfjo5SOR7N54kiac523gD2wzqn1mCsZ1LgB4RNpDXxS0xOy2BWaPOw3CO
	gbpWVMnLdVFjEFbpoeIqw4wl4XDt0uFFw8pBkk1fSsw==
X-Gm-Gg: ASbGncsOHPkSWoV/bFRjCrZa98t64BGGHl7hrNNkOvmNXUpKjdO2DV8QouNST5Q4BIi
	IKTmjVZKB59bCn9Gknsvsv7YEeaWAXVTbwP4Xw6N8Yza5w6G8Go8c4SCE8PYq8+Zcv70b9ovD3y
	EsSQfrpCGIE8PM5SntDWo3ETrkDn8qJPLbGTcn1ybLW4u2/WhGBDmCvHiJT7l5gDOZjbOhgXSQi
	osX+8vB
X-Google-Smtp-Source: AGHT+IHq5dBQEHPn+wOw5U80KePwd2X2LC3B3SHZ6AGfb6CcYPi59PsdfIAL3XedQFjGq+dUKM0hm1XydfY8mUO4vb8=
X-Received: by 2002:a05:6870:356:b0:2d6:245:a9b3 with SMTP id
 586e51a60fabf-30701e2e8acmr9527052fac.6.1753771078306; Mon, 28 Jul 2025
 23:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729053359.49258-1-suchitkarunakaran@gmail.com> <2025072935-mardi-propeller-0d29@gregkh>
In-Reply-To: <2025072935-mardi-propeller-0d29@gregkh>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 29 Jul 2025 12:07:46 +0530
X-Gm-Features: Ac12FXxrrylrnNIE4Lfr5SOeXK870lZtcpnjc0R9SpK8CDLzvaVq9BoUlX5HvTU
Message-ID: <CAO9wTFj8d3Toafof0MBvPybfDMsAAuJ4rxrH0EMcVqZZrg0VCA@mail.gmail.com>
Subject: Re: [PATCH] tsacct: Remove unused macro definition
To: Greg KH <gregkh@linuxfoundation.org>
Cc: skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 11:22, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 29, 2025 at 11:03:59AM +0530, Suchit Karunakaran wrote:
> > The MB macro was defined in tsacct.c but never used, leading to a compiler
> > warning. This patch removes the unused definition to clean up the code and
> > suppress the warning.
>
> What compiler warning shows this?  As part of a normal build?
>

It's not part of the normal build. I built the kernel with C=1 and V=1 flags.

> We have loads of defines that are not used, especially in drivers, are
> we now going to start deleting them all?
>

Agreed, sorry for the inconvenience.

