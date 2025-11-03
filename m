Return-Path: <linux-kernel+bounces-883186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E12C2CBC1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9074842820B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2990731D741;
	Mon,  3 Nov 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Gb/b64iU"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186B3176F4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182684; cv=none; b=JidiyWx0qZiyIzezlKVmFGhtvVybq0qIJSidQO+NLeDXwmrkX84r4kWSFQ7+ncK+LzvBLajEn2hnlqg/S+ZlMp5DSU9jKeJm4sSCeXaLYh73goxfeq/VrMFl5V8MmaLww1cwRYOYzHmhJ7KmXK+oyrRPOMZQe9BIsRXVJrJx590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182684; c=relaxed/simple;
	bh=ppU8+0KMVjssDLeGA5ZQKn/3oy/3w+zGpv5OB2K4V3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMfCDSe4DC52kAvvz5MeDlAz9fJHSNU156ZpcxOlYJSHpaMvww3klOLdAO4jTR6TSgLL8NRB7XMq9LFEi8aHF/sdQvxkSxGAleO400V2B2tc2It9ikzqo+F0juIrwzVkD9BIxkeDMcE7+WicEd0Clw4nzyBoxD0a17/O2BeXR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Gb/b64iU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c7e438a8so1742595f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762182680; x=1762787480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DazVAKjsIrcYtXlfdeVBEA2qvrz0reDmGQp37QD+7+U=;
        b=Gb/b64iU9sw7VSFoVkB5F16FNE5yKfRRDeeDIDeH9s1gYU+9Irvxuvjr9YaCjXvDdW
         mcrNHchJVA//oe4ZSOpcxKm7jx0NIdAV9DnrNzKBjugd+MZPMhk7Y0vmx2w7YxQAG4eN
         cQa+glDSTKBRmjyiszLz3BoA4vxgWJWHYqhCK5LiLXcQgCewvOKE7UepFuvK8QR0oaKS
         fySqzsyKl536O6d5zIRhFFhjVg6krMtNz123HvhP36BnmESiJLv5lzTo43+Ihh1Gw12a
         c+oX7NR/2nZ10ZChftAWvHM84IlmZ5YP+w41fhbFAG67n4kUrjvEbQ5WxdFEWZ8Qmips
         co0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182680; x=1762787480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DazVAKjsIrcYtXlfdeVBEA2qvrz0reDmGQp37QD+7+U=;
        b=O5/u9EZvrEi1uW2M8wm62METW+xwobn1WV+lkmojOGmka73SIw+RGoBvT4bvVWuhY7
         U0nVFHbpC3NgOjg1orr87zUmSEzC8kON6V/DicYSqGyaRxR1b5UELuqgocTVhpFFONBZ
         Vq1v25O2vx27KvuqaBOJdDSRiMt7RUjm8t7KnFbr2ou6Y7YcCtF6aVqkeTrg71jCBGzS
         Kyb47+KFhrt+yl/d433qVdIcxY4QhWdoGRqUAs64i6JBahNOCh60kyqGMmkOQI8UYlQV
         N8MiGl2lX+puhToSdj4F227QXzj6kqYQTt78z7GdmW2zp3CfnPnq50Bd5Tr/osgW7C1A
         +/rg==
X-Forwarded-Encrypted: i=1; AJvYcCXt3CnVT0ioRzJBdHlbmyRr6fnJiG2hT+WnWK5tAokHt0jyQWvXyt5b/4V6cQYJqTt5yG+p+fPXsKgTs64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7a7HOVn4BkK3UWqwoZIzKEdIcWH2PsDZqdsijNh9IjaN73AwR
	H8D0zc74dyodei+xxdCINI0ouQhS5N5oi/s7cYhuUOWwUh3YTzwBe+jbj8eppN+C9Sc=
X-Gm-Gg: ASbGncv4c5+ADx4PoLqmQReEfHEXrB064BTp1ymPfFNcgf0im3SP6bJQyBiwm1j19If
	ps6dJLMydIAPG8HYckgxDfW62F5XH6Vd24X3G2x4yDTWdjYn3XkyMLAsFHBF3msWRuGVmjudSOI
	eHpQFgPq9Oi8rQapCyfbTMj7Yn5yX0CyVil0cYr7jI/64KF4GO7rP1kE5yFnf4F4eRgkcbSTZbC
	jZ9jdOhbnlvp2GJa+OmA/5V0VONs6ZjFScuoqfZfJczAzvW+JE2sEcw0y/flRRhZGtIeq7VPBBk
	36CiuN4mbN5EkOaZ0a00WtfN0t+7SXiqnZUB4sPjwP4MSx6jo4uGv1LyTA8pS+shbGoW79d1lL7
	1fCBAEX93nSbT9MrUVRFhu79DbOB6E0pP8fHLCOYPnDCnoduGj6ywRRFVj+OhyegCSoK3zg8=
X-Google-Smtp-Source: AGHT+IEK9m5S4OyAt+8+jqF9utRaLNjHjz1A1Pnmz56EXWQk8b3s9Aud4E7X4OrR8HH/uvBllI7Qvg==
X-Received: by 2002:a05:6000:22c7:b0:429:d79f:c86b with SMTP id ffacd0b85a97d-429d79fcb0cmr2028605f8f.58.1762182680270;
        Mon, 03 Nov 2025 07:11:20 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c11182e3sm21317427f8f.11.2025.11.03.07.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:11:19 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: fix invalid pointer access in debugfs
Date: Mon,  3 Nov 2025 16:11:18 +0100
Message-ID: <176218266920.62377.10595261785996832493.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103141132.53471-1-brgl@bgdev.pl>
References: <20251103141132.53471-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 03 Nov 2025 15:11:32 +0100, Bartosz Golaszewski wrote:
> If the memory allocation in gpiolib_seq_start() fails, the s->private
> field remains uninitialized and is later dereferenced without checking
> in gpiolib_seq_stop(). Initialize s->private to NULL before calling
> kzalloc() and check it before dereferencing it.
> 
> 

Applied, thanks!

[1/1] gpiolib: fix invalid pointer access in debugfs
      https://git.kernel.org/brgl/linux/c/2f6115ad8864cf3f48598f26c74c7c8e5c391919

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

