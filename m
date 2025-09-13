Return-Path: <linux-kernel+bounces-815094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E52B55F93
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFEFAC39A3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DBF26B95B;
	Sat, 13 Sep 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTjGpJlp"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE22C11FD
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757753635; cv=none; b=PgmGFReS1zuA6NGZMApLHNXP8p91aelnLN5u3iALC4ohrQ7JqXr8384/BXb1B1/280j1Nxjtdfz1xSSNMdEWLgENinHCKEmCJI6Voxv6wEUMuuIrzMw62o/m2SARn5LLmgJXYeZvK5iwaUAF3B6GIKfHrAtTrfB68jNkf5Sw1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757753635; c=relaxed/simple;
	bh=hjX/8U9e+Qrmt58XABWZDNFleTWJFxO/SMBT8NBKylk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkMLCxf6u+6+G7KKkCtURN5QNJjv/vXD9EM506dcUtBQFKmEKjBQIt6WEJXxrhIjcDMWcxs8Uqmo0sb5zRf2ZObhM/lHREdqbZbx+jUg7A33JR4M0mn7t2H3Zz1nNfTA3fF4jCvoEvNzpR6Xw4ctwW7LeJjgK+mTRQ6uU9j7GVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTjGpJlp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07c28f390eso289156166b.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757753632; x=1758358432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRBsxly/heSok1/GwCP1v2e7VTjywigrOJtGbwcrN40=;
        b=jTjGpJlpC0Py7to7GOkrrewUBu15LIyzJ68Cy+vfi/yEzxI/Tt6eQzog15YCgl5IvU
         cYpojcytMuxRruU3ZrjSr3eRVeyn0i/TpOOk4+RodboCpuk6HI7pENJ9ZOl6o5CnMCQ0
         WbMyjVv6fD/sFQsLkZ3hxkYb495Uj14AUBf8U/aWTBzlJTrCk7oXAlQ4EF2kjNTa1lxq
         OY4iYYUPgCNAhyk+TaujDxjXhzGvRayWdX0ZOvnAH2HiT+UXeFFSyVjBPVL/59+1eanq
         Dib2Os/Z9wJc3pF3iVT0qj4nBmfZxeuMIZlbdmgFM0Uak31WeiYAr3eOJAcD9YqhKKGH
         UYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757753632; x=1758358432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRBsxly/heSok1/GwCP1v2e7VTjywigrOJtGbwcrN40=;
        b=Art6GEmws7Do1b7q0j6s3FSpTyf/CkkgPze5dSSD7xHbB7UVP4JppFhUicOGz+gG01
         h3B6K9/efoAdrDs3ZqwNKuobyWwUUj7nEXQXifIOQaLDhMWaPfeJXmiOcJcC8bQ3aZBZ
         TOz7tAA5PTXX/LGgbZ72LohI+QXo9wQmmfeERrrzkDYOEELmIXdIJYMQTQmLSYj4ADBM
         uMS26slysh/C4KvJdFxJef3Z7VutDBvFa63YJ6sNhxgm3r8Sw2LB/QoqlblNOmiPfjjB
         +Qe2IaoVZVAIduf+L1Sge+6DPyY3hGMWgY5xPqOd9B3A0kAXdTle9iRiPyvEoS0y9Bpr
         st8A==
X-Forwarded-Encrypted: i=1; AJvYcCUCnh2vMVwj1lgVHnw2i/Ac0mAg/OTFNWBlJugdiI7bYRthGP9FTnYAALgYJ/zrHru25V0vVD46nOv2F2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0OIHoYMRWnWV7HKECJcCpDa+DWb8RexS0HsSdNfO3w9MCxxMR
	jE+va4TyUOvJD2ePzgy2jzwt7RzaB5joRmQuM7gl8jQqGKPvOHLzN1HK
X-Gm-Gg: ASbGnctlobEsWUYHhpeLxGtJ/f6FjV4DgIKcOWGoeAkACXfYtxWBaF4H9LhosCTEmUJ
	VgjDD3JfoGL3Ox6Y3jzXEBGlL+kVQ0lF9Cz87QxJ2SrOUzB1UD66EzkFhBOXqJH0ZRawWGIbhDm
	0aEUpP7f0pr6GAR3crg7/YtHg+RVrEpDEKUvA2+3yHdGKCaV2iPMJaObMj0S/65o9VGVuY6XRUI
	GSPPQO0yWtOZIjYSDkH7MtPRAYwMzPJB+2Te16Gyj4dr3Jdl7hPeL8fh42j5vHP3JS8iGkpemOr
	ucn9CcunklstPrE/Ty2WhdpDsa70cClAaYdwCDrn9mrnH/bId5aA0paxLeQafA2jx188Kp21Km1
	qFe6UqJGWcB1D4DAFd/fYDhTnqnKNIbq7zvLTyffh4TmKe+wqKa2ODaq/N+CnDhoCrrw=
X-Google-Smtp-Source: AGHT+IGRNH90vlh6pNSpSkah5E3lqgD6Qwr2bzQ2h7i2Vu2i65lG54BlgGQar3DeQCKypUkZNJ4X9A==
X-Received: by 2002:a17:907:9805:b0:b04:5385:e80 with SMTP id a640c23a62f3a-b07c3a98830mr539708866b.64.1757753631816;
        Sat, 13 Sep 2025 01:53:51 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d09e5414sm218564466b.18.2025.09.13.01.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 01:53:50 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E9A76BE2DE0; Sat, 13 Sep 2025 10:53:49 +0200 (CEST)
Date: Sat, 13 Sep 2025 10:53:49 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Staffan Melin <staffan.melin@oscillator.se>
Cc: zhangheng <zhangheng@kylinos.cn>, Jiri Kosina <jkosina@suse.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	1114557@bugs.debian.org
Subject: Re: [regression] 1a8953f4f774 ("HID: Add IGNORE quirk for
 SMARTLINKTECHNOLOGY") causes issue with ID 4c4a:4155 Jieli Technology USB
 Composite Device
Message-ID: <aMUxHZF-7p7--1qS@eldamar.lan>
References: <aL2gYJaXoB6p_oyM@eldamar.lan>
 <c8f3d402-e0ec-4767-b925-d7764aec3d93@kylinos.cn>
 <e81e8d68cb33c7de7b0e353791e21e53@oscillator.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81e8d68cb33c7de7b0e353791e21e53@oscillator.se>

Hi Staffan,

chiming in hopefully it is of help.

On Fri, Sep 12, 2025 at 09:57:04PM +0200, Staffan Melin wrote:
> Thank you,
> 
> I tried to apply this patch to 6.12.39, the first problematic kernel, as
> well as 6.12.41, the first bad I tried, and on both I got an error message:
> 
> Applying: HID: quirks: Add device descriptor for 4c4a:4155
> error: patch failed: drivers/hid/hid-quirks.c:1068
> error: drivers/hid/hid-quirks.c: patch does not apply
> Patch failed at 0001 HID: quirks: Add device descriptor for 4c4a:4155
> 
> To which kernel version should I apply the patch?

As the deveopment goes from mainline then down to stable series, the
fix needs to be developed first for mainline. So the patch is targeted
there.

But please find attached an updated patch which hopefully should work
which resolved the context changes.

But ideally you can provide a Tested-by on zhangheng's mainline patch
to get things rolling as needed.

Regards,
Salvatore

