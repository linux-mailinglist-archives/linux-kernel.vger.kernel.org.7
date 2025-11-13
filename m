Return-Path: <linux-kernel+bounces-898923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B853C5652D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6A5034971B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D443321DF;
	Thu, 13 Nov 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AV9OdHQB"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90E3321A4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022941; cv=none; b=L6tZpvdx87Xkyr27MSQnJVciSpSmk8I6iW+D0h4vPIrxptHrTTmI2E/Ph+3kcfDJbEL7vH7zNnix/tbk6XmupDOtm65D/H6kMM2NJQ+k1e63TE9UF+RQKoti+5RkXZZXu3FGM8LijP8X10bhNfpp9OzHboF7P2IuLlEzsmw+EkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022941; c=relaxed/simple;
	bh=kaEXDbYqpnEc7cym1YSSZJFawzDAPjN7Gx50+RjnVTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJbefgGoT2LrNL+5RWKYBu7CzeMBDbRzmZ+LRHHyhw3unfYLxkeBagVJk4a9R1JRyduOx7JQ/ilpU6f3AipTJjtRtHY+i1v9TElPuz6av4xQo4weZEKai0pwRjyEDcWjqg9U1zLV4xgGGqthhk1REV6gzwcXUi5+oYjIsJSVO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AV9OdHQB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5957e017378so578524e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763022937; x=1763627737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkdTtBBk3gcn/gXPa3g2EVuXikjPK5yw7YBwiunXWxI=;
        b=AV9OdHQB96IkJVehudCzk9G7FOYv2jUZqLUO4k/YkGuVnyMqyV8sux09wgcn0GCZE/
         YBPHHjYoFkqNHhF7LYv0WkeylR/rv4UmMN8W4EG+LqFerhjyHFdiZN2LevBIrOI9NeXo
         9B8rmq+5ipOuwXjrb7kqS/pxd0HTJzmyDzwbsPp5Mu3O8fYR+9mK2J+D46MzgyD2PoFi
         VJNchzNuQcUjrQJWygUARwZ9L3NzpA70r/Jg7BfAH6AOS0FCFYV3PI7rUjq7kQPlLA7c
         0qTtCjsQYJofoR5oS32GlqYBcTqxAtYhcNxBvw0Ri8NhUkpT/goQE16w7aXo0wZQ7HDy
         c/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022937; x=1763627737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bkdTtBBk3gcn/gXPa3g2EVuXikjPK5yw7YBwiunXWxI=;
        b=VQdV+F8q7v3PAtCWEFrmJo6uCBX8U/g+RoAsStUijqovosk2gDq/3QWoIRaufyhzAQ
         uGgg/woIUR/V5IWHRkA5JmAC3Dr1wK7xCXKPSZYKXM2LyQGDBSmIIymKQTpJhkPiC90i
         6j2c7AOHKfPL25mq6ujL+scPEZ1ZpBp+FUqy0y2934R9WaKDggcl0aHVwpudPdj2DZQ2
         JD13JBvCisXe0zOOwYikj7ubOSDdVfTIWrjnVz/sJ7AHT4nOvdTk8q1g6ak5YD7D3Ef1
         NSbDzeO7nInHlmZjUMTrkHfYKHjCsnV7InHj9Ht8i+x+bqv06/FmLhSyQuZSHS929BaX
         glCA==
X-Forwarded-Encrypted: i=1; AJvYcCVf8p41mtjacT+GIxAtNzUeWaxloc8F6X8fzGExZp54gFpD6+P+tUjHcJJBpW+MeYW2G3JqfM4GPqywO4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzODl5LGKD38sFbTc2htBbuaKg7jykMrUnPhSnarY8IA9n3Az+y
	asymmTyx/VJp8ByWxNzQhYcmQz1RxHG0PB+UUPFzD597/aGMHokckvkYcrufS8LpLz3J7DEc7n/
	WR1g9KaxgnnzykWlXu3HU5UrIquwqnxqKVMzQ0OkYig==
X-Gm-Gg: ASbGncsI34CyzlZNMPE7aBS7hyC511vIp80m9Md0epcoxXoeuLxF3gKkHuYt4sKGT4S
	NUjZBjroa8hEvdIyb21dShVbLP7Vrw/sxTCE9My8EuIvLH0ZmgFcpDBeIlH+ABDMkODISpFSwSH
	7FTF1ekx8/PiDD8yNL/rPkIz6PrShgAlNT9D1bER/KtXV2Lk6+3CSZzeruXCuRRqdL618vw2ETg
	ggLFxSl9TF5qcPNUzLHwZc+k23pNT+UhwvjaU5WlG2BPgh6j2j9wuqz5YBiWfyYNNiE36gz6Cc+
	VoO4S8GFBaoh+G9RaF9gDCTnCfc=
X-Google-Smtp-Source: AGHT+IHrGRpZG/MrsLG4K/0YTtoMIIIUkxFk/zXo4pfjcbWQIWO4/QQHXPahCUpuYWSEpGI6dLjpSvuhwDuAZ+AXb3g=
X-Received: by 2002:a05:6512:3088:b0:592:f773:3cb4 with SMTP id
 2adb3069b0e04-59576e19fa9mr2270119e87.31.1763022937305; Thu, 13 Nov 2025
 00:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8e6ec20e-8965-4b42-99fc-0462269ff2f1@paulmck-laptop>
In-Reply-To: <8e6ec20e-8965-4b42-99fc-0462269ff2f1@paulmck-laptop>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Nov 2025 09:35:25 +0100
X-Gm-Features: AWmQ_bmTujDOx8X7gXPq6PorLQDKOZbZX74yqmcwT235ZwvQnvyTIVAlYTCdVb0
Message-ID: <CAMRc=MfsTY5DkaLFSV_U5HE5s2CQb_+GkDKVDQ_keH4kxc+EOg@mail.gmail.com>
Subject: Re: [PATCH -next] reset: Remove unused variables
To: paulmck@kernel.org
Cc: bartosz.golaszewski@linaro.org, p.zabel@pengutronix.de, 
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:00=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> Neither reset_lookup_mutex nor reset_lookup_list are used anymore, which
> results in build errors, so remove them.  It would be best if this were
> to be folded into commit 205b261463ff ("reset: remove legacy reset lookup
> code"), the better for bisection efforts.
>
> Reproduce on armv8 with:
>
> tools/testing/selftests/rcutorture/bin/torture.sh --duration 10 --do-none=
 --do-rt
>
> Fixes: 205b261463ff ("reset: remove legacy reset lookup code") # -next
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 22f67fc77ae5..93575d5064a5 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -25,9 +25,6 @@
>  static DEFINE_MUTEX(reset_list_mutex);
>  static LIST_HEAD(reset_controller_list);
>
> -static DEFINE_MUTEX(reset_lookup_mutex);
> -static LIST_HEAD(reset_lookup_list);
> -
>  /* Protects reset_gpio_lookup_list */
>  static DEFINE_MUTEX(reset_gpio_lookup_mutex);
>  static LIST_HEAD(reset_gpio_lookup_list);
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

