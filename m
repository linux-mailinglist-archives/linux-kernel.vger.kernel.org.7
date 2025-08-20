Return-Path: <linux-kernel+bounces-778451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C8B2E5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569581CC12AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9097C272805;
	Wed, 20 Aug 2025 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2dXB8ku"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBC25BEF4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719590; cv=none; b=ghAeaM/Po2ktJ0rVDK6Y093JGTbRSkxzo45qyP3IPRa2RJOryM3TvGfNFC20o6TbV+fa8f9fnWTTbwGjZ1vR9KEVdvkGbnLwf4VKxe/xzNkwLfHiV9cksRa9vD46vb4fhhddPcrbIWSNG0B+GTf0ePyLVnq0P9MytwQ+Y2dnkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719590; c=relaxed/simple;
	bh=dBUZtQPVBIjVk34eN0YxkwBmymmPtmgHIWcuE5cdGuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsT5tvj6o01jDw1hmUpZytTrf+odzZL+v6/pjscjeZZ2AuH6klfpEO324lCjKWFNlmjYa/BWuqHhJsc9YU1c4XSlz7btYr90iMZYRkYWUHTi2qmrZfEsZw/zo2Pllgwbj9mR1mO+p6CYrSSa/qZc8/Rh3wR7i9kOKIIsOfKVoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2dXB8ku; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24457fe9704so2300385ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755719587; x=1756324387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNHR3+P5KLHKn14do9yl+lDFBUWsf0SRTPbg0fiLIzA=;
        b=K2dXB8kuUjPiaIbGGbOLJJ5ouG3AXEJX4XjL+CBehOJ2UPDXOJutoF9NIauVEPjvrx
         KTK627nx4AyByxlur4cCZSTvnF75nf9ZdQEDEiGaOGQflOoJn1AG1OhlnR4OGOE+TiQ6
         U67T1UbpStOt0nkojYTPCRxWu4FE2KsH9yxUNtJNo1Rs8cRY342Lt+TcPCHNo3tJKd5z
         y/KLsUo22ypGQhc4p5mkQaSRjoBDcViyFBMERW7hTZmb/X5addEOiM6asXcXKvossH9J
         8pYUI9WJpMNAQFSBWg6OVn8pc2OfQtqBqwuPgHB8au+7oReJOsqcH9D5B2ttmJFSF/nL
         0UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755719587; x=1756324387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNHR3+P5KLHKn14do9yl+lDFBUWsf0SRTPbg0fiLIzA=;
        b=UzVij2RGy3eKihFkwuMoHa/VH0pbjn5Pu3GS0+x4fV7foXIf6u5+ohUTlJdSo6CZtF
         h5O4WTDoqT3WfwM5igw4Z6SdwsIiIxJcycw+RG7PumfqbNfhXvfKjiiCyrAKi/zO04F/
         tuphEr7hpa0AnqM1vE6EqgMssHcbU4PGz3DgRgAzJMTuBj1WGYyz47RyI78I8aewDpdI
         WZI/Hhu4/C7K58K/bEYPPl0QJZJhU2jQjUhltl344hZ1+UhKASYnid8Jy5KjNtjuNXR8
         1/u3f2eWwbA3KtiyOGZZ749+UmKU973KLMwvhGEKu9Rn0eoFw8KcT6FTkfDd/tMF2kB/
         nRmw==
X-Gm-Message-State: AOJu0YxIVYgSgU9q8OXLqpigfCjrt8hCDvxPG1Fw+0yOZ0IXWFxwqwJN
	OlEeQ9W2ST8tvvfCTcAEMHXVdfIwGjxH1ASTyW3wBKNuG/57cZLuGDGfCEdnRg==
X-Gm-Gg: ASbGncsU+Xv0DKiBGxkWr/kBzKaPAyS6nKhfq/MiUjHPsPwsyb6iI8nEYF0Fx/KAzAm
	FjDSxM5d1eE7pnJCv54p2H+vxtRe0FvyRwt3WeEtztV8/wi1gMiM+yjWzGEQBPhnPzbqL03MCBw
	aUWZhC3mFms6t19G9QIHK5OMZySmNQ3tnxss4gyLjUl2j94bc0z1gN3GugROg9UfPsGgVDEgo1a
	o1778CFS64eolfKK58gvJpNhfMYxOX/pOt3HPlEeh+IV2szAdo4+4pJfp76lobddDhDNcRriTpl
	pRWLGnzvNdb9v68h0toGGPcm7dcIbk7J2vkqz0Ft2q0W2WxNGj27DZoHI1T4AyLzh4m1+QO9NV9
	qwJkJJNYEWMshqWJpyaal3OiQd+zcRM/xPlw=
X-Google-Smtp-Source: AGHT+IH9GMXF5+SR8mfPioQF4NviZRvABUtqS/yT/tJYwwNvjMjLoxN9k4mizLbIS0bskcIEnyAbDg==
X-Received: by 2002:a17:903:1aa7:b0:240:3f3d:fd37 with SMTP id d9443c01a7336-245ef20ce56mr46652915ad.27.1755719587221;
        Wed, 20 Aug 2025 12:53:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51ae48sm34180655ad.139.2025.08.20.12.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 12:53:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Aug 2025 12:53:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.17-rc2
Message-ID: <cf5887be-46e5-423f-b434-e9f6b629f795@roeck-us.net>
References: <CAHk-=wiLHgdvJQkEW-pHcUuXOBJ9JOoKcZkzMaPSW60_-Mh90A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiLHgdvJQkEW-pHcUuXOBJ9JOoKcZkzMaPSW60_-Mh90A@mail.gmail.com>

On Sun, Aug 17, 2025 at 04:01:00PM -0700, Linus Torvalds wrote:
> So it's been a very calm week, and this is one of the smaller rc2
> releases we've had lately. I'm definitely not complaining, since I've
> been jetlagged much of the week, but I have this suspicion that it
> just means that next week will see more noise. And I'll be traveling
> again later in the week.
> 
> But hey, let's not be pessimistic. Maybe rc2 is small because this
> merge window just didn't have any real issues? Because that's bound to
> happen _eventually_, right?  One day we're bound to hit that mythical
> merge window that doesn't introduce any bugs at all.
> 
> This merge window wasn't _that_ good, but maybe it was simply better than most?
> 

I have been a bit lazy with reporting, but that is mostly because
there is not much to report. So, yes, this merge window seems to be
better than most (at least so far).

Build results:
	total: 167 pass: 167 fail: 0
Qemu test results:
	total: 637 pass: 637 fail: 0
Unit test results:
	pass: 640017 fail: 652

The failing unit tests are all due to the new irq unit tests.
Those also trigger some warning backtraces. Fixing those problems
is in progress; it is nothing to be concerned about at this time.

Guenter

