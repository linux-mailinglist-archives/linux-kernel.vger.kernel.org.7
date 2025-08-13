Return-Path: <linux-kernel+bounces-767017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18320B24E04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C981C23B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8E230268;
	Wed, 13 Aug 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkgYjUH6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD41EA7DD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099638; cv=none; b=GRQ1HTSqqMHyo7mlkHKoJNu6pMv1fVOwcBih7f5HQ3hFo/kgoEqHpQELEw3+KGa6aw3cEg8HwQ7CPg5pYcGlkcVGCdZGsjq0aRKmYmL/IHEn+tuVnht7EXkWzea8hM5ul6nb/Y9ljIFPBzeqJepVLPHgf8zBpwED6Apjv8JmAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099638; c=relaxed/simple;
	bh=tTfqMQ+xfqg6EEGY4MoHKxYaaNAZl3Gjahz3boKFQY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soJz8uW4uI5a3WdgEL47MfDwkD7Apvu/fOcf1+EgiKMzs+TU1u+d1m9jdMMTvZ/uVCbEnkbfFjpxN3URmQEpAHYbX0GL/wRnjK1Itdj9tKD0K3DkpaDI7jz6ZMigBDyQzsiu+8IpZMA2qCU+pyTtah7VIy7d2Hy8nHgj7oJ+NRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rkgYjUH6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso65084935e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755099634; x=1755704434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9jF1D4WAW3iiaMWmJGnvVMjBRXIxJDhqU8qEtUUnnQ=;
        b=rkgYjUH6F9BVwH9DO+ir6KAUj3gJuVnyDbv/9gvQ/pHVSQ0NwXbpEu48JEeg7hwzrz
         jwwaJOy9de5jkVTBLU7b0VTa8/qVS0xjXoI5WYv/j/nD1JSJbTAFDiQadpg11huf0F2I
         I3MODyCDWGldiEjrzd0xB2CW4owl9IweSkFopNihJ+cno3V846T0Y4JR9PajtujaU7QJ
         Dk/+VyWh+gJMzR5185kLON7jDDRhVB1P6ukur5F0tk20hWFmpM5b0EtxZedu7s15UtXv
         bSLGjQbP67EAJ0hcJOkcDOLf1Vbipg1dqYM7orPqCMLjzOPZw/hmaMg6mM6KYozVgG1w
         6kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099634; x=1755704434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9jF1D4WAW3iiaMWmJGnvVMjBRXIxJDhqU8qEtUUnnQ=;
        b=oUv6Ohcbg82boPUSeUtcHIPljpgP17um48tzR/0WUWya3vzhCX7Vckyha0FOXvuXth
         0i9JaeCucNR3snGh1JEDBAhkde/ey4cZ5xC7OoD2a6uUnPkspP+vi4iOew0KloZXC6uH
         U1rN1NukkZ8spVYOBfLrXl5x5IuSyp841IMybibYw+0khixMxDUSv04kbEixahB99p5F
         TWaMhfaZT19qA+wzy1AXqUO7otuEOWUx+znGJ2+hjWmOEH1B07Yc2aOJoKMH5Ns7vZRu
         5XlqRAdVf3u1ShGMicv6uFfGzjhuZTjVaTKjdboLqFiJv1IfFjCBjCrex7QL0/9D3gWl
         6HQw==
X-Forwarded-Encrypted: i=1; AJvYcCWCwX/vTZyp6wAQXmbJwc8lMfMTC7L6wv5bq7rUYwv9/vmbOD4kPtdhGjuWZ+J4IyuIponvheydyKQlw2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYNIPEy8JZ+u6yVF58viggcXx1RQijWI5jflYzgG56nw49w75
	FiGvGdvnWOORx7FshG58fBS9sHnGc4pzaXvFEXP9h3Bp96H+ZuC0RA1qpQN/4r3sVXtWi7TKI98
	yi9aI
X-Gm-Gg: ASbGnctg39gC7kw1IEjLJT0gNRwElmWX282rnTgkx9HFow2r30YaEb99IQW94gKAmJG
	XKZt5HFDdDOOuaXL8QnGAUYUWlFKrTgYzc4ieNp+OZR1FF2X0ZJLjuvDZpatHr99EBsx9a/ZRnU
	WJ2WpeK0mUMxAWqQuQCcevtqTDyx43N2/tkCsmaeLndE1AL0ttw6CSEnV0I6KGSzc52Er/1FPFd
	DgVPDfH3WZHukMBr++nDYw+re76E3KLYzlosldRmf/J7sPVOOceexGZ/2Ifx5RjPGvLtdyHr1Uv
	8AzRgpm+tdg16I5aAi8DlaQc26TDilse8JEikzBj8f3otjj2mJ04wk9RlSaLvLsq3dRQuwq7lPe
	cfBKr77f6YIHnsYQrQybaEebt002Y7MBuZwiC9mUn61o=
X-Google-Smtp-Source: AGHT+IHjyT6fodZTCUswIlR9R1NEGMLkFv4skjXff6LcV3bNBKG7HbuXpFFE1+ZhJWivPfA0Kl0qxw==
X-Received: by 2002:a05:600c:45c7:b0:459:dde3:1a56 with SMTP id 5b1f17b1804b1-45a165e996cmr30088825e9.28.1755099634561;
        Wed, 13 Aug 2025 08:40:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1a519633sm6837845e9.12.2025.08.13.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:40:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 18:40:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
	gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] staging: most: video: improve arguments to copy_to_user()
Message-ID: <aJyx7o9KeVS0HEhh@stanley.mountain>
References: <aJx6OF6L2Nza9zQ0@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJx6OF6L2Nza9zQ0@bhairav-test.ee.iitb.ac.in>

On Wed, Aug 13, 2025 at 05:12:48PM +0530, Akhilesh Patil wrote:
> Define cnt constant as unsigned long as expected by copy_to_user()
> to avoid implicit type conversion. Define rem constant as unsigned long
> to compare it with the same type size_t of count variable.
> Use standard helper min() to carry out careful comparison to achive
> same functionality.
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
> This patch is motivated from coccinelle report which suggested to use
> kernel standard helper min(). During build check, I found that
> comparison max()  showing error while comparing variables of
> different types. Hence this patch also fixes that to make comparison of
> save types.
> 
> Compile tested only.
> ---
>  drivers/staging/most/video/video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> index 2b3cdb1ce140..4b15c390c32d 100644
> --- a/drivers/staging/most/video/video.c
> +++ b/drivers/staging/most/video/video.c
> @@ -172,8 +172,8 @@ static ssize_t comp_vdev_read(struct file *filp, char __user *buf,
>  
>  	while (count > 0 && data_ready(mdev)) {
>  		struct mbo *const mbo = get_top_mbo(mdev);
> -		int const rem = mbo->processed_length - fh->offs;
> -		int const cnt = rem < count ? rem : count;
> +		unsigned long const rem = mbo->processed_length - fh->offs;
> +		unsigned long const cnt = min(rem, count);

The easiest (and most pointless and trivial) comment to make is the
"const" adds no value here.  It doesn't help the compiler and it doesn't
help human readers.

So you wanted to use min(), but it generated warnings that rem is signed
and count is unsigned.  A different way to silence the warning is to
say umin(rem, count).  The umin() macro casts both sides to unsigned.

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 2b3cdb1ce140..de07ed831815 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -173,7 +173,7 @@ static ssize_t comp_vdev_read(struct file *filp, char __user *buf,
 	while (count > 0 && data_ready(mdev)) {
 		struct mbo *const mbo = get_top_mbo(mdev);
 		int const rem = mbo->processed_length - fh->offs;
-		int const cnt = rem < count ? rem : count;
+		int const cnt = umin(rem, count);
 
 		if (copy_to_user(buf, mbo->virt_address + fh->offs, cnt)) {
 			v4l2_err(&mdev->v4l2_dev, "read: copy_to_user failed\n");

So can the rem variable actually be negative?  It can't unless there is
an issue with locking but I feel like the locking in this driver is
pretty suspect so there could easily be an issue.

So probably we could investigate to see if multiple thread can call
comp_vdev_read() at the same time and maybe add a sanity check to say:

	int rem = mbo->processed_length - fh->offs;

	if (rem < 0) {
		WARN_ON_ONCE(true);
		return -EINVAL;
	}

regards,
dan carpenter

