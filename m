Return-Path: <linux-kernel+bounces-785604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2A4B34E59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8A7164228
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E8C28469C;
	Mon, 25 Aug 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBC/Nvp5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608FB1DAC95
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158500; cv=none; b=A2KSydOi0IYEiicdchtXSsY4rXnoi6jho6bMSBVoklgbUXDczRRkUa9FVTUQkINj3G04jEM57JyLFweY7OtE4AIdXyEZSci5DpFtjsZENCCX0CO4rttZDpKQEnwLhndyp4UB6hkFQSdCpP0dFXj098rJRZ1fWNsx/DwJmiCLBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158500; c=relaxed/simple;
	bh=w3B61eBiafdDrvJC+nZZR7OJXZPAnJJkvwPmNjZGdXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsXCytiZeQBSAE1ed5Dg0dsL9QtnjXAcK3TA7z7rJWoqdv9KVbvVOSGw4h3gKfSaKmvIPHp/3SplSIqkPmTZ+NREhW4LAW28SWtN/OAtIis0fPMBqK+MLyjl53YTD4DvFsuPuf9eAYTW/oEuTJE+87ex51A1pjWWDDj0aSAKQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBC/Nvp5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2469e32f7c1so13797075ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756158498; x=1756763298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZ7OfSn90L/EOlkfzFWAdyJIVJ5/8eF5gQsoaLymST4=;
        b=EBC/Nvp50CPMnNuyUu9M4wnacfx2lhWRaVyz2HiQZo9vNHPmBfbID2+zNekvcV5337
         0GU4WcUJtDhqHLCkcu4JBjpfdWi/yzRM3VGFx03uussufUjO4aHy/aDPsMpCdah56bgO
         42ei26sKVn+AVdCL1R5ZJMPs/W5IZRypeOg4roTLgSC/skeOrLJGjOWFqxu7f6/mx7Yt
         tVDw1/T4PCWEPcTsQRj5teqZsSrkVXnUIZlucbK1ORAWqRd7Q0Y4ChWUnKqho/6pmfOc
         sedAUlW55FkmcQMhYDJnUbhVaUdVqsfwHGZwxNf+hSjegaBDSjbwid6Nh3rp1aYGJtc4
         ia6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756158498; x=1756763298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ7OfSn90L/EOlkfzFWAdyJIVJ5/8eF5gQsoaLymST4=;
        b=Af4D9y3uqD75u2g+hKgEocMcGbmK47IKKCCiWTn6EV/y0U48C3vb9aMwGqOiZ3lgFF
         f9GnbNQnybwBSFsQWqrP46vWaZRWy1bEJ5ueFRGFa+9LCV+VZljDarvhZVfN5Y9t2OIw
         5yYUdqEhM+ix9M6UXWu2yCtxrhECNyfE+0h1hl1Eo0mJXtKkhq7Jv8tnecMciVnigQoC
         u0y8wvbDuOXX9wpTPTHXpBRWROWXryJBOSQIRenbaMFAGgmIEio6z+Ki5iw+16cWMnZV
         +Zy27zXu4t9KL8oKXzquuBZn8HH+eGp/e+cOR3z+n61tjuW+zDDXfu+5hrf9zCVsbZ/v
         Y77A==
X-Gm-Message-State: AOJu0Yx4jCWKPbxXdzenfJlICJb6fJb0JglFz4VphSchob3i/80ziP6v
	uewmOhPeLECqkgfpRIjSzw8AeHOFeFpF+FP1hS71Pw/XU2v3QChtK5TUzBHK8g==
X-Gm-Gg: ASbGncs8TIcc6XeLsK56OShg6MdK7LumBNkclD3ieM3ENQoQuOfcLh+eesgsXGX8wLl
	P2fPAB/z8SXBkHEoVlBAUGXyWqh0yyZRUtsZtB0VVEmzU1IMZnlaq4GqoVPQYckoEOvqR89h993
	8haX02HRuYxwYxAvYVpFjuNhV9HX93YrKkKgAYunLtiA2raHzvI0sAfMU21tYS8p5Bzfeg2zGVK
	2C8g+nQttPvMb96GP1kuMda75/VaZeZEa5kY/VuBZ/YdQUmUxaZDSdmobURPspZqjirthAuH6zB
	AVMvXI3y3GLYYX0VjOiF/LvRym10C4U2IqbKfQ9biQoTC9oQy4IyPiijKBuEhLp9WvSkelTvSXT
	fm/FbMKCSzAECWYNjWKSG6ihdMPhUArz2+0w=
X-Google-Smtp-Source: AGHT+IF0Snys7ynyb3EAH9B6N/ma/MmIzGQkAdlCLRY+H4Hn3Kj8twENNsJZPqV9Fiv2bxKTUvCnOA==
X-Received: by 2002:a17:902:d54d:b0:240:90d:468d with SMTP id d9443c01a7336-2462edc1a5fmr122493865ad.9.1756158497498;
        Mon, 25 Aug 2025 14:48:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af4d1besm7910978a91.15.2025.08.25.14.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:48:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 25 Aug 2025 14:48:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 3.17-rc3
Message-ID: <252824e6-c450-4757-83d0-9725b562ba3b@roeck-us.net>
References: <CAHk-=wgKmy+gOftf32wT86F+mSvdq2=XZe8Tcb5m0NaQTZt-dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKmy+gOftf32wT86F+mSvdq2=XZe8Tcb5m0NaQTZt-dg@mail.gmail.com>

On Sun, Aug 24, 2025 at 12:22:08PM -0400, Linus Torvalds wrote:
> I'm still traveling for family reasons, so slightly unusual timing for
> rc3, but it's (barely) afternoon here on the East coast, so the usual
> Sunday afternoon schedule technically still holds.
> 
> As suspected, rc3 ends up being a bit larger than usual, to balance
> out the tiny rc2. Yes, 3.17 seems to be generally in pretty good
> shape, but nobody *really* believed that it was as good as that tiny
> rc2 would make it seem.
> 
> And while rc3 is on the larger side, it's by no means anything
> outrageously so, it's well within the normal parameters.
> 
> The diffstat looks fairly normal too: about half drivers (spread all
> over, we've got a bit of everything, but mellanox mlx5 stands out if
> you want to pick out any particular area). There's a fair chunk of
> added selftests and some more Rust support, and then a random
> collection of fixes all over: architecture code, filesystems, VM and
> core networking.
> 
> Anyway, things seem fairly normal for this phase in the release cycle,
> nothing stands out. Please keep testing,
> 

Still nothing to report.

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 637 pass: 637 fail: 0
Unit test results:
	pass: 640016 fail: 650

Fixes for the unit test failures are in the pipeline.

Guenter

