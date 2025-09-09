Return-Path: <linux-kernel+bounces-806978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74184B49E56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A511188A8D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B95A209F43;
	Tue,  9 Sep 2025 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBEQCeU+"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925AD1EE7B9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379028; cv=none; b=u+wLwJDi4FjopWUoKp8i3dYLDO8bsa6g2/t3uNE426ybnswby7IPMzSTPZl5hXl55b4KLs2cHa1L8gBGyzB31bhtb+62OIqW2r6BYgUvgkYvf3DrWKP/DDPc0XxmAm4WGT6wQfrWHEtd/hZtcwQqyMOUwry5W7lxNL4913MBOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379028; c=relaxed/simple;
	bh=Mi6tiFFn1OJj0PIZq+BkfNcKTgiQ4/76IP3+DOD/b48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv+BI4aUI300Mjcwdsdp3Q7U58rAt+0N2WqyzLdTNSlxDaplkCQlQmms2xl/fH0rwrIUXDnPtLGzROhrC3O1Ju0adMKUQU3IYRf0/Id9B3aP40DJGyGY3l+Foc3TzZcu3Y2hFUPxHPUtpZ1zzsD/dMAcgJPgRbHLJWHlab6SlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBEQCeU+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77238a3101fso3609863b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 17:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757379026; x=1757983826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHHFWprVVD+OsKyjD/7+6fkd3lqS3P3nHeKSBmtlIHI=;
        b=kBEQCeU+8jWDj2CSyrKBZpMfThKrJuwfmHOAyFeSkU6wvui5u+cu2LhomNIz7ga451
         QSN3THlvSEKlttSn2SlCLf9fm9nyP8KH8ipXfz7Yv3huXtprbM5VOTAsr41G46RIkCI3
         yifsAUSFWMjtvuPOm9gYUyyDkwJsnAf/AjgB7FOtebYguZDrJV+Qu5q5amo51EtoyjQ4
         RnvKnJ5Qnxq3RwWGaUkTrWxeU7jZw1sV5t+3ngVsgSD+WjuEt/sTqqhLte98j5f7XZ0G
         jC6BMYWSvtul6oKP5Ur+YP4W8/1iSvrJ7wi0ZTOG0UjuTP91jj1UKqEzb18rWnZvPgnt
         IeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379026; x=1757983826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHHFWprVVD+OsKyjD/7+6fkd3lqS3P3nHeKSBmtlIHI=;
        b=dhnOZbfnshw6Et1uLCWwIXNiziUVOFgGjjfGarPLG7fiZsCrBuhpC+czFDRBmnugi7
         FcvEpbu/PqI3/rimL7ZCy+Ff4QbEwYTJDKbELE7ipp73hCp63y/qsGXKicOux7Wav/qg
         yjmHI559/KzaHxGoseqqmJfLaH7WH5XYGPpzCMEVoQ8GgcpC98qw29qLtil/0ihmgkdK
         ZcaCnQchBzTr7M+dluba5Hk+lTCqnqvA7cIungUYodbUk7uhwKm2ts0LRmtSuS5vJsWe
         yO7ULnk0KJ5NPyXLGQDQ5Suhf5Ecmlm/4nsD1fQomOc2vHdZZIifV5LABk1mXv3LIYmi
         6jMQ==
X-Gm-Message-State: AOJu0YyPGkz2BqMtkjOIVGUTE0yoU1ntBhu0uS1lX+6D42FKrCd79QGh
	7Ypg8rj0i6ANPyVGRufKGbLBdRUHM7NPI5DKTmfLCyEgdswfeXF844Mn
X-Gm-Gg: ASbGnctXjo68tsUNesQQmkNF2me0Ry1yanrEW1sU3g4UiubGAmA0TCEStdG7W5pFWem
	ac8FPlGI4I/LUTzWqj5A6I1+f4eUNQQX2C6DWw87btaVUNh3fNFAfz5yJM8VHZ4KLbji4piyYTG
	ltm0PzjpfMl73j60sorYTTTC1quVaTcaBw5xQFQ2Qp8S8j4FCd+9J2lA969t05TcplZdwV5r5sE
	EXx9D91ZC1l8WjwyUsbLWDd6U+le+Rt5kpXOj2XCI4s/S4Je4UY8NYC2k/Z2MGyv8AQ8vtNS4e7
	I07NmAou2ZA03o9EH5lt/RPlGpEXjNxqp7tN4sAuJ/ocKgf0D7Mk2187M6WfgbUnUhNCj7/l12+
	wfC2v4DkfV/FaKWjQ1V1944m5USVHhJvyYFW4UPgLCkJfCA==
X-Google-Smtp-Source: AGHT+IF5KynMUYHhCWyUKXLw1dSsNf9Z+7W5dPNr7ZZvfxpfvw5MOfH1JfoCITg2/J7l/W9d40jo6Q==
X-Received: by 2002:a05:6a20:938e:b0:249:84dc:e0cb with SMTP id adf61e73a8af0-2533f4e686cmr13915676637.18.1757379025615;
        Mon, 08 Sep 2025 17:50:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0736ba7sm26783888a12.12.2025.09.08.17.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 17:50:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Sep 2025 17:50:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: Linux 6.17-rc5
Message-ID: <f957c6e8-98bf-488d-a898-39265a7661d9@roeck-us.net>
References: <CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com>

On Sun, Sep 07, 2025 at 03:25:47PM -0700, Linus Torvalds wrote:
> Things remain normal - both the diffstat and the commit counts look
> entirely sane. I'd claim that it's all small patches, but we do have
> one larger one: the DLink/Sundance driver was resurrected, so in
> between all the one- and few-liners, there's a revert that brings back
> 2k lines in the form that driver.
> 
> But if you ignore that one-off oddity, the rest is very much normal.
> As usual, it's half drivers (networking, gpu and sound stand out,
> although there's also some unusual pcmcia noise in the form of dead
> code removal).
> 
> The rest mostly is a mix of tooling (perf and selftests), some random
> filesystem, architecture and mm fixes. And other smaller stuff.
> 
> Nothing particular to report, the shortlog below gives some rough idea
> of what's been going on if you care for details.
> 

Nothing much to report on the testing side.

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 637 pass: 637 fail: 0
Unit test results:
	pass: 640105 fail: 650

Same story as before. The unit test failures are [still] due to the new
irq tests. Brian submitted a set of patches fixing the problem a couple
of weeks ago. They may or may not make it into this release - we'll see.
Cc Brian in case he has an update.

Guenter

