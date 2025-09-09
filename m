Return-Path: <linux-kernel+bounces-808546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD641B50156
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676A05E395A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355F3368085;
	Tue,  9 Sep 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JPlMFwh8"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0DF36208D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431683; cv=none; b=J6HZKuUscrnjuZPW6du/MPfNrTIqgMR/0Z5P+vx0RseKEGPH+omRvkxJAQcDrZfVymXFvKr/Y2qKV2lpGzhbxj+jVeSrSLGLow7r5ZiZk+xNUj9VQZu1oiQcHM/OHjoipnoQM6FectRxMAxSyZ2YWcwaXxuRaZuHJzgu7rKCpew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431683; c=relaxed/simple;
	bh=pzCFqMrHWSbav6qgQpI0njY47bCfS+Iyh80gcNkiSOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3FXgtUzYOvJxB20SUA3Etv5WqFQO2aEX7+pwc2NWAkS8CbU5ZORG9oiyovOG63PrflJBAktYZOTOcD/X8voThYT3fAJKg/+4EMn1DVeFvwnD/O38aWnnnUc5PD0y2hU1zg08HLbsiwuB7xXIXaVkFXv8QdUnt7uuHdy3O63pOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JPlMFwh8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77256e75eacso5165643b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757431681; x=1758036481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krG1Xr+YTZd43EgVBgk+rTBS6xhFex03YE3IwjmOKWg=;
        b=JPlMFwh8SjEmJurBuS8gByXySJXLHrUWtdMNTHoGRpia3YPilUB1dqVjaBiB2mGuhC
         rUFMprg8TI1Hpgh/Vm7oXp+5GivC9meKjFZqc7wuyVIxtKHclX/YEIZBAN75CzcdQCbp
         vLNDdQS24WFMfjYikJLr8yvs9haFom+DPQgtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431681; x=1758036481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krG1Xr+YTZd43EgVBgk+rTBS6xhFex03YE3IwjmOKWg=;
        b=IUHG3qdcCcPRyJc9GkQIRqsaLYMv09s0FBMOqmJ5sQOsxkmB08GplApV0PEKPU5ns2
         2SdJqCAnWqkOs3ylhnpYx1UYQL/5IErOGKA+QkTWha2bAiefO9PzjoOt+oBg9jCBhBb8
         Sqm31nyzdcEPI4TN+n0whb6b0f57mDu3RFe3sFDoqGAgLZA0dsr2jr787pPUxFmO1jmz
         62WJUylv13V6SBJ1ekcswUY7hWEO6dQqizYscuOLD8xnpJIaZS4WY+CsXwY+RmKEfEqW
         2qO03iBzFaIzJ2dfToGbKXnwV14ROOIqRhi+Ymmc0A7kjSlsSMZM+EUT8OrWKOzKVtrY
         tlng==
X-Forwarded-Encrypted: i=1; AJvYcCWPPgDGEc1GXa349MYexyOi7pu+aVi+WjkH79ICw8MS4FinM66tsdNsYhU5UUzyXkZA/O0EokrCjwWTsE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yync/8md+6VtY3H3h5P8TgOiusuR8YExhRGjTCEE8lzqZZuO4FI
	Ndi1+Pq2AinUvrCabK1pubdWzGTkf6Rhx1WJh2K46Pq7iYhwlALOUmysKa2/QngY/KCVFIhKMqU
	ZZDA=
X-Gm-Gg: ASbGncsTgXM5RUd+Sjge9C1E6x0l4xh/LISTrDBGqMv+rO5eMYL3896Ach46TH4jxqB
	KSO7xsnREwpOPJCKpbDD72XxzgnmCQZyVTv9VofvdLV2KCPwjSrjqbfC9NobQZOL71UdLzIIlY2
	pp9eI7W0xV398jmYAyhI7KKJH1E1VnmuIu7BTsgMsqROYs5tgx6MOJpluXNECGpeWM22rlCxpO7
	Sd9FFpATxo9HU88SiyiuvGbnIwG2sSj0O47n53MSsE7Ol2J7YkBUExPoMpHomjM/pqLY/Rbj8OQ
	9YjXrL29RyzXUStf2vmyl+VbF8nJI7sl1zO3/0OeRAFNO2QvKW9cfWyX+1lGXS8FOjOEGJEmgrV
	Sf/r42dvRkaBOc+rpejDeNUlO4KFT8y9vvV9+Vg8wfTOT3OdUsBjgH3vwd8C+/Z4JtcL98bk=
X-Google-Smtp-Source: AGHT+IEPk1JKVDOjC1mdUjtijlAKa77DPdq7V2QWqrB9LY4Dva1kzIUFldmz+ZJR3vXmCuLMTandnw==
X-Received: by 2002:a17:903:2346:b0:24c:c190:2077 with SMTP id d9443c01a7336-25173119212mr179448845ad.38.1757431681109;
        Tue, 09 Sep 2025 08:28:01 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:8283:3441:d9a7:13c9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25a2a344838sm1003985ad.86.2025.09.09.08.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 08:27:59 -0700 (PDT)
Date: Tue, 9 Sep 2025 08:27:58 -0700
From: Brian Norris <briannorris@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Gow <davidgow@google.com>
Subject: Re: Linux 6.17-rc5
Message-ID: <aMBHfv3dQPZ0iLSM@google.com>
References: <CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com>
 <f957c6e8-98bf-488d-a898-39265a7661d9@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f957c6e8-98bf-488d-a898-39265a7661d9@roeck-us.net>

CC David, Thomas

On Mon, Sep 08, 2025 at 05:50:24PM -0700, Guenter Roeck wrote:
> Nothing much to report on the testing side.
> 
> Build results:
> 	total: 162 pass: 162 fail: 0
> Qemu test results:
> 	total: 637 pass: 637 fail: 0
> Unit test results:
> 	pass: 640105 fail: 650
> 
> Same story as before. The unit test failures are [still] due to the new
> irq tests. Brian submitted a set of patches fixing the problem a couple
> of weeks ago. They may or may not make it into this release - we'll see.
> Cc Brian in case he has an update.

Thomas has all the fixes queued up in tip/irq/core. Presumably that
means they'll go to 6.18. They're test-only fixes, so they don't affect
the behavior of the kernel itself; I don't know the policies around
that, and whether they should be prioritized for 6.17.

I think this is the full set of related changes that aren't in mainline
yet:

c9163915a93d genirq/test: Fix depth tests on architectures with NOREQUEST by default.
f8a44f9babd0 genirq/test: Select IRQ_DOMAIN
59405c248ace genirq/test: Factor out fake-virq setup
988f45467f13 genirq/test: Fail early if interrupt request fails
0c888bc86d67 genirq/test: Depend on SPARSE_IRQ
add03fdb9d52 genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION assumptions
8ad25ebfa70e genirq/test: Ensure CPU 1 is online for hotplug test

Brian

