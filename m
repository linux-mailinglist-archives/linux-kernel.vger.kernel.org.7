Return-Path: <linux-kernel+bounces-855499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CC7BE1750
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B698F4E8789
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF4720C00A;
	Thu, 16 Oct 2025 04:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0GjQlM9"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D82153D8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590651; cv=none; b=sWD2hPGvXyUwt8vYx7U8WvMmjjHCGe3sBS5h4r1HO2fnmQsftifHVa+G+q6VtB2lzNhFZ8rkdhWvz2z05cwZ/4e16JRcO3Y6jSTUUug7FrkGBactBSB/J3Dp9OSGdEhfO+P25+jcF7Z5xgqrh5icWVNIBESr8FIcggKgmWFpi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590651; c=relaxed/simple;
	bh=ycXwIHSULxLOKelyoMw1kfz4fvZtlHOxyQBUEQvwH1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGXIwX80x/YyroE0VcKY3wzT8Vbntp/vbMH9z4P0kzV0Le+6TdgwhOBkjdPsSsNL5FydjNoxE5C2R1+RE0o/6qXHhdOBUZ2M3ny8LMYr0hAJ+pZA1h/vs1gkR7Xch0xso9HlxGX6GjcTfeRY7ohqBE8BgEK5LNNNW+nBSVDKI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q0GjQlM9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2897522a1dfso3349935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760590649; x=1761195449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbio/3Hp4DA4Om97Ada+C8lyoGbDCkIRGtSA7EfxlAI=;
        b=Q0GjQlM9DIG8TPbPaJDwaxYjFLwfRPrNMu6TdtNLxGOUUDeUfxoXGC9eKIq6naF7VU
         KzvHV+6ebUfllk4C+tuEZWa3c26U2VpzgtOnILmVRxZOK/KJYMrYvQE7yRIG6OIppZNX
         jcSDLgIOkP22qroDn3zITx2vHjjJjkuuMX4U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760590649; x=1761195449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bbio/3Hp4DA4Om97Ada+C8lyoGbDCkIRGtSA7EfxlAI=;
        b=D6Vr5SF9CvdX7rAm5g1JkIRYYFGAUE7JdfHRYI0MfNiqot8qKbLzByWBj4xYOsIXMA
         PDmxbq4kszK15UMvQO+z3v6cLLgl9kVTi9bbEu3eA4lVa9Q00t5SQW2ju+YmynDpcezu
         850C7Rus5oVHOYsVoMbp2JG0JykKClVpHnhZHJvuV+6mUru99egb4v7nPN23EGQ0m8SS
         fEi/nTB90WBQzkFBDcyPRDC5R91PIoaU4w5BUCYnaj2ScvDf6QKR26tSE6vC/Tv/BdTg
         aGnCZDd4pWtJUsLEGYiTWi4EnFmsblmG3As/HOET26d5kYGTnUjiYVZh3B36zMyrwRmI
         g+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFP7R+Skw+FH53Dox6vyiCttGp7TrKa7TVxcDY9RqwJ0PMpgooC4l2YrzTZKHdFYVDuQm70T1wtOqcRRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHizjLcvgWNN5Lhha31g11sNFYhz8y10Gj5vqCBuX7ODtxosFA
	o+UDHYNBjMKXog8J9XRFvTLjuloige5wBDZy8+fvZLQUuv7ykz8FawlJqKWF+iO6kg==
X-Gm-Gg: ASbGncuOTTM+nRjnQoRZveRAHd4v97d8F+D83Lg5Yk+DaDP7umkQ9us3S7JEtXpXRUp
	KcEiNiiYU1ki8jSTyq3LDk36S6TOa/8rSiGKUxrbK7DSjnexkwpO0k+FnAT/4+Nvbm/RilB3cAA
	o7MYENURCAPHouweRoB+kGptb5GEzlbbKhbguSM9ydiecE4j+yK1s1gqeRkQOPBeiJPyOSNNl9J
	nvuSSwRLLJwHTIs70bQMqbaClK5DrXY/VAdyoY/nigIm67mr1cXVbjIQP0FZgxsQZPJYH+Cj1O5
	ptaXeKonBUynJvd7f+Vn61io6nGHuHRlfKuPn8UwsWHBx2AQMG4mqFIuZnq1LQtx2FEMsKyg1Pv
	JszTwwbtI+mFo/vJ8ZMV1kIFxRcj1i/t22TiZ09zwtR3OetYJynmOPuNxbFABEnuFwPeC2v/SeQ
	BL7Bw=
X-Google-Smtp-Source: AGHT+IG6pV6T3EqWizlYJiSDqOG3iYJ0VWq5XBwemEziGJYiTELwOGp/PUZsKzFN0fJLNllV3149Lw==
X-Received: by 2002:a17:903:3843:b0:24b:11c8:2d05 with SMTP id d9443c01a7336-290272dfc42mr385419215ad.45.1760590649069;
        Wed, 15 Oct 2025 21:57:29 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:18d7:f088:3b2a:6563])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343087sm14450085ad.31.2025.10.15.21.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 21:57:28 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:57:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
	stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <t3sh2ifq7bdykxjejk2uopra76xp3fusbk3rpbw5aojmt3hjnt@o7djv3dntbwi>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
 <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <CAJZ5v0ix7zdR0hJqN9OZPGp0oZMD_mzKU48HH1coqHTm7ucTDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ix7zdR0hJqN9OZPGp0oZMD_mzKU48HH1coqHTm7ucTDw@mail.gmail.com>

On (25/10/15 14:31), Rafael J. Wysocki wrote:
> > Please find attached the turbostat logs for both cases.
> 
> Thanks!
> 
> First off, the CPUiD information reported by turbostat indicates that
> the system is a Jasper Lake.  Is this correct?

Correct.  That particular board is powered by Jasper Lake.

[..]
> Something like this may be induced by RAPL power limits, presumably PL1.
> 
> Do you use thermald?

I don't think so.  chromeos doesn't use systemd.

