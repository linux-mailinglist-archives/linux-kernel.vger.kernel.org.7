Return-Path: <linux-kernel+bounces-772494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C959B29360
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D3C20844C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7789290D8C;
	Sun, 17 Aug 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWr3x6rS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C5290BD5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755438777; cv=none; b=UZnt4Q/IprKhwmNBwUC2eAVXOZmswo0g/82kkp6k2MYJOtEWZk8R8I2Z77a6LObrmEuxO6lJi/BRX8H1/xLLFXuY3GkXdhR1qYAgz8KCbbp0VC5WZqiojCMAguoGKgzlR/SaRNeanzimagrDasy46YANjwarNfR37Pc/Zx8MDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755438777; c=relaxed/simple;
	bh=WjQhvdcnz7Tjy0IM6iw8BZJ/SqhSRZyUZRV5d40c5Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2xTxit+YPneGlID97weBFPlYzZBscqqL/CeWyQ5U/rAOsCda5z9UHjEAJZfRVaWu3d6cEEo93hS+XnWmgZBixbEk+yUGkMGgtAaWMdV/AmmNIoEU4kFaAd7GX/sumv/nvFujmfuXqfJiv+5J2tGAzrJ57nB425XbmmLLZsWjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWr3x6rS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-242d3be6484so121605ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755438775; x=1756043575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Yoq6R34dP0jAlkU47rK4UTrE93AgcGz/78lM6h9D5c=;
        b=JWr3x6rS69qNcr1/a6h89BNOsFn2c0DrM03iCG3g0G672BzfMVcoK0ZHjakSPQV4nd
         IqTZS1huQc+WcRDOUINpiGph/WU5NFhxEzgNpJp+kckP05MNSu8G4vKLkxg/577rCuFG
         Su/FF542oTHfsehPY42+ke558u5BZigYyvELEeN0Xv6bAFknO9O8fMl2fIKthjy9385A
         1Fo6+G9sSvogWdiccoF1ULEIHfGLYW40w2aq0I8egU4dokfazzn/tB3vIsbMGaIblZIB
         YTqs/3PbECj7B0GMp0DlHYS6/B88WYcDqa6uYsrz6CmgxrWKDvjR5zblKhjp56SzmDeH
         vaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755438775; x=1756043575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Yoq6R34dP0jAlkU47rK4UTrE93AgcGz/78lM6h9D5c=;
        b=t2TZqktPwG93n6ONTu7H7NNAIzs8fIkB4Fnmq1AAwTZ5frgjLRS6yBNLof/4cHIuri
         AJjsIEHm4GhRecNy2RAA8VzVWn0XMnf6K6DdficXRwW6IeVXVID24uAokI1paszA9WEw
         VaJHG5+1m8FJJOhOtnJRP51FF0GBYYs8gQUjeQFSRPHZMO2DV5yTcFAXyL8bdqrBBqei
         PPtSRlS2SylxG0A4eXZxkr6LNhELx0i5DDza3WcWArbjPkfKH9+y3LiHrgUcq6wJ5tvr
         VPmJbFco39nS+AQs8w+CPJvijdRBI4eZ8RRtNXDI2S6wW3Cd3Yt8s7oX7gptIqDOe20p
         m2ng==
X-Forwarded-Encrypted: i=1; AJvYcCVj7Z6XpMArV8fN0weq+NtDs4to63nC6aP4d2QGdzWuwj9F7bjc3SGz6KUwNyXJg4DhUbziIwz6FzweVQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMwNcrVlIbsr4VBITzpoz8kn/b6UM9rrkOVBd4wfEzIApaJs/
	zz/PZmegQG+EuPqmEX5Qp8rp2IIsJ4OAGJXo96FXmKnHSyro13okM588BUD5XuljtQ==
X-Gm-Gg: ASbGncvJRkZ7i2hUAgO3HyAdO83xq7s02co4yvYc7CVc0IBKISdUh++BopXl2iS9KW/
	5pYj8hX0nmJ6fz/XpEhB5qEMsRZcIPZbKFs7MALIBE/+CnkChhC3pIsnDWNQbOFzgOGrzLIGJOk
	HMaG+HjtPjxd5gPg0rezXar0hfGNkTpYeLH4S22d7yo8zpqRXJz02dcFLogF5DuFfmOEVKBmw9o
	ziTibU3RnFvAlBIEM3oyMPn2nXPVzKtNiZ/oq1i+pyjH0mN8vLSt4P1JH48qBek63TuOoceL6PZ
	NHVTwiZEXi8Es6zSpeQxJOuWoQOC5V3iVTaKe9zN5M+0sIs1RGaNKr/oZ+59+g4f+Jva2MNqW2V
	BERJxzjn8Aubv2uX0bmoO/ny+S1mrs6KY3lMNjpNfC9RV98baRIVKeNluOlHfsGSt+TyumxwC0Q
	ztJqon0nc=
X-Google-Smtp-Source: AGHT+IFEX8xeLkLj2QMtKZiGxnug5hoUNxUSAsvkrpAjewS3UVX7FPbJFSpMJmKjQ70RKcrM71ykxg==
X-Received: by 2002:a17:903:44cf:b0:216:48d4:b3a8 with SMTP id d9443c01a7336-24478ed2d4emr2762725ad.16.1755438774657;
        Sun, 17 Aug 2025 06:52:54 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d79863dsm6019436a12.56.2025.08.17.06.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 06:52:54 -0700 (PDT)
Date: Sun, 17 Aug 2025 13:52:49 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Hutchings <benh@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Add missing module description
Message-ID: <aKHesbIMjifCg8LF@google.com>
References: <20250809073018.1720889-1-carnil@debian.org>
 <aJoqFKYpWkDCiIJp@google.com>
 <aJov4RkRMRhCB1DU@eldamar.lan>
 <aJo6IeEPEJpqjUlu@google.com>
 <2025081746-cyclist-stegosaur-6895@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081746-cyclist-stegosaur-6895@gregkh>

On Sun, Aug 17, 2025 at 11:42:03AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 11, 2025 at 06:44:49PM +0000, Carlos Llamas wrote:
> > I think it is best to drop all MODULE_* macros and avoid further
> > confusion. Including the current MODULE_LICENSE(), this is misleading.
> > I'll send a patch fixing this.
> 
> Please do, that should make it more obvious that this can't be a module.
> 
> thanks,
> 
> greg k-h

Oops, I forgot to hit send. Here it is:

https://lore.kernel.org/all/20250817135034.3692902-1-cmllamas@google.com/


