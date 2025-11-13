Return-Path: <linux-kernel+bounces-898890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DEC56427
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C71704E5A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBFFDDD2;
	Thu, 13 Nov 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz5pVcjH"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726BD30C62E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022076; cv=none; b=SqzeMYAz9JYuoVDZUgZS9OV8wm7feUMBD3ggJDShczTMqXD86JlGHJSIsDoxF6dZcYvTv9nhZGWZJXRMRNUG/hNmIgxUvQ3q6E9txgWtzCdno8HO0zYFhH/jHi1qbTElQ70LL2CWukQam8m1snP/vQsPMaYDBOu9VCR3PKW9Wys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022076; c=relaxed/simple;
	bh=L7rrq4WiKIi6GSN+aCQUJaSUVAJ38fs+p26mjrNBcqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9h2mfG9MiRp5l/nsqNgbkFg/9h9gyiKQgEKnfu1jbu2DlxhbmJt/SkqfmldfGHyE42TMONpzZByqoHe6Q5gOF3IUcsjx6Ek1ihSPBgk3Ft/HIeJAgMCDR/IA7lwrABLl7nYX4OX4/h12yP9OakjGwoTQKS1UruTuRrXBbni7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz5pVcjH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aad4823079so498458b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022074; x=1763626874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7rrq4WiKIi6GSN+aCQUJaSUVAJ38fs+p26mjrNBcqA=;
        b=Lz5pVcjHLjyVs428Y0hpKPDn/LaATzeAbxLcZITOxrCMrcUgAQuy2dpyeXU+USKPOP
         ooRBeJ+DrWQc1f1X81sqAfPUx49KjNKZlHXh8eYLBtaPOZkHr0+MeOPFyDEQvr7ujiAl
         hIBC8IGPnYzxdc+YA5y0ufFHJmn5zNc/eXqFHc60Pv07FRurUlSCFCZ9p6qObG1oS69P
         tkxjq4h6ufTe8wjX3tQp00fNS6eBbAv+q7KhKJP7I78VF1gOt6V3QJNOX9lSI425eVLu
         kO/B+SaWbPQC7/d8GDLQZ8zt7KrRDJcdaUKxtQn3/77/hHKl3FKk+/Ibv8gPxwMqfN+B
         dEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022074; x=1763626874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7rrq4WiKIi6GSN+aCQUJaSUVAJ38fs+p26mjrNBcqA=;
        b=SfNDAnR//d4ZBDK8clBXIRuKfBagvb0OuY+kJHWYpiBibHKhRBrg7OzY3I58HwOLrH
         0MByajIcklImZhiwrGrWkwzgNTngT1mekdWk98JIXrZDn9vQ5dRb8s5UaXic+N7HyXGw
         VxkzEXVMtyVz9trNWUjLkkzGPpJfmuM6kgdbMkIGjFjR2LLPnHDahjDh1wkJ0CP3UDy0
         PTSjNSDGoxv1M4+OTUNd7BZaTOH44wiLSlP+uvawslM+hkP9r7AS1WaqlfChD1GSrezu
         jpZpVClyosQ0xGn4LcSWe1qGv400bN3adLSMzRo4blmBf7CvpYts8tsh/zp1jfztLfyf
         JUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeZj7fzfn9e2Nt5/lQZvRNsEhgLkN+gJIzpywu15CGmGHmUVURDhVfUX7WztrX8BIEE136PGBPIGKB1CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyOmwScgW/I4O5XzbWZnXMxaW9henX4kJ/cPQjXB5IU4UULxYT
	WkmZh9d++A5qJ9bt440KzQ8KViFVQ6p2i+PK3fiEQoIQA0fdNHG0Eloj
X-Gm-Gg: ASbGncsJgT8Xqcm9YxZqVxklGxZPEeMAfJgsbeqjvutYFuj490CyJ+uamTFEx1H4zZF
	iFr90ZV+MYbxfVrfq2PXkRyIqCbOgiIG6yMU4RP3ykMMJYJiyLvuy5ZGBXeN0tWnAO9kDBESmci
	7rWY9WXAKFFqQMIBXttwaIgKtWCzMv7gxwzWaugI8l6wCXQO/TOxU9uOMwZHTrMpS0qpL5UQH4v
	auoAuY8hoCC9exbOSvOFsmRv999IZkxdPGTf1e3VtIJftNIKgqGSHlA7NaHdh88RM/HX9v4z5hN
	3wUgts+h4CwxpBIKKGSnZWb5NMXk4Oos21h4+19ur2348TwNySXcPs/+QXPdHHUeRJr8J17DvUS
	R6RFIY0kv3Y4FmtXlCPITw/EbcfumfuOpR7wNstU6lpK/jZ4SRAw+GUQM0AkOgnQl+KH2KHjxyI
	vdjn0=
X-Google-Smtp-Source: AGHT+IFysTHUjNEuPh00MCrJEYLnKEdmVnsQMMpHldxJQNuHD1tNj4Av6uMadzQrVRooBE7mHyl74w==
X-Received: by 2002:a05:6a00:4d03:b0:7b9:a27:3516 with SMTP id d2e1a72fcca58-7b90a2738a5mr1716653b3a.21.1763022073646;
        Thu, 13 Nov 2025 00:21:13 -0800 (PST)
Received: from essd ([103.158.43.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927c230aesm1431467b3a.68.2025.11.13.00.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:21:13 -0800 (PST)
Date: Thu, 13 Nov 2025 13:51:07 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jianglei Nie <niejianglei2021@163.com>
Subject: Re: [PATCH v2 1/1] staging: fbtft: core: fix potential memory leak
 in fbtft_probe_common()
Message-ID: <zvkfqrnqwksg5otoy2wzfx2xtmcyyk2fgottnqkkwm6q2uxdam@2fthfckoffov>
References: <20251112192235.2088654-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112192235.2088654-1-andriy.shevchenko@linux.intel.com>

Looks good to me.
Acked-by: Abdun Nihaal <abdun.nihaal@gmail.com>

