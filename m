Return-Path: <linux-kernel+bounces-725606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886BCB00157
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6EAB42460
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F51248F5E;
	Thu, 10 Jul 2025 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akksg0ED"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791023C4F4;
	Thu, 10 Jul 2025 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149550; cv=none; b=h5lDUbwWbtiFW93epkcZ0ggWefAmQBsRn/MSrHxZl3I4G57x4L973VosJ/pvo1NKalPC+T1lPLhjrqJfvUmyJBzDpujC0na7oazyolqohN7t9Isbe1Fp1MjKFiVaSNAYRLBEa0QfwXJqhmxb0mKXneBFwaGXYHH8zHQ2aYvY8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149550; c=relaxed/simple;
	bh=zRXsoN4t0HGYJYiKE4EXkDRzP+v+QPqSLpsz8ubYC10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcppU8zUjZL/CckXKm5LsmurnhwNL8slISloLyFEpu7I6ppkEniqDexlAyGNYKBHhqp5Uq4N5CtAWvzoUhCQUpXxL589bD064AJeqX7wcTHIjFxKCdP4YxTr/xgEeL5Bi3yd+f+beUHwzBUh1/aXj6lRYvL+Q83IE7HSFi8xZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akksg0ED; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so879303b3a.0;
        Thu, 10 Jul 2025 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752149548; x=1752754348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TQA4+iWdhebTihpcDNsTXRIFnfR3IxS8wu+OKw1UOU=;
        b=akksg0EDwWQnbujm39mUlWgcXIO5B94AZwCa6AVxGI4/UXwRpjNlEWX4WZSJFqHnTZ
         AkKYjxrRLwMWw1O8ua0fl2SBDvmAkFhMMCOuze/D2ld1PmXl/2SSoJBhQJlatF3X3uKW
         VEFzm4xiwWMJw8Y7rQbY34o4TTXu3UBDs+dAZJTOaNojscfAeMLnlwjzHJ/ZZbGcV+4w
         JNA+F5JtD+GK3G7jTQJiSrmJCykjNfSnH/pPA1sQWHd0J6IAPs4wzVTM4N0fBUKbzMMx
         FEW5xt1quYyLjI7v7i52gk9unI0afiXh/NO0K7YMSS84NM1yzd+MXucsCrLzGd9HGlj/
         IrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752149548; x=1752754348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TQA4+iWdhebTihpcDNsTXRIFnfR3IxS8wu+OKw1UOU=;
        b=CEwEaN6m7NDlBFx7u5rxP9BByy57C7oklUyuNxwfmYmcQxt1n0rTrMbZQ26Hs61LFt
         H8mamsbmZ45P7YwXD5qbRIJt9j3hT+IX1cfUZHZPsEnyLWBiGOFiIni7vTvho32n9GIL
         MssvLo3mRA4QBC5PivO4Rs2VRsSl8KVBeeD1ImOLi1PQ69yYhHgOa7tp8eDdJtA3DNpB
         5CfUmOvINVGQEkX+htsYvdeDjiLvY0SkRPtLmqpX0h4JqHK58dHGMuYfkakAyBg2yPyw
         1jzgn0JByzRAaPZq1CkEIMPZP+ltEK4MvEzIZr7cga5HCDDWj0c59ELhXdjbXVocvMX0
         B0pw==
X-Forwarded-Encrypted: i=1; AJvYcCV2bHlIsMYWH9qJG4FF+SNK//e9qa84PuicV4/iv/B0Jwq1FWEGgojuPEd9289albFQzt28L7pNrrxET4daj8XC1uToLA==@vger.kernel.org, AJvYcCXJsD/gkuyN0EAsiM7p2Fw/PSNEDpS3ciBh6FBxEjvaCsRKbsWlju6PtdHmG9TmNzp22ZWEdEZqt/BL/Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4w8Fpc//zdA4hSpb4O6vexc4OqVNkkLSMSB19dEEHe/7XLhwi
	WXwmw1v55BwMkdMDdlwEwSuhs44CIavnmVeLnYUwtVmdHslGuNVgL95x
X-Gm-Gg: ASbGncs9jnPgI+GImn6soB2IhS/qvte87lB5sxB8CoezkwFYnJNn8iWBWf+buv2Ck07
	DVuzVVezFbDtoQSBFLQC0ZoIp8Tk9ynIQwki0bndmq/7il1002so3u1Z9wm+WmcOHa2JdbIhWDF
	SI3wru9I9g7PB54LM0jSNwI6gts8IAS7lBSDaHVuTBC7L1Opj53ME3TrB3Pm+BMIgiFDgMM/P8P
	FE1vtrm7boM2IXqILR20OAiGImNr4OsDKFrQl2wXZg3qqKY3WvfAZpbIyV+nVQtZyCLpMeUdcHm
	gMd7qIxeZ73PU7amUxLYfIlSk1McR0Nel8CIB8g8ey/Jx5cHjNGNQiJ+//m0P/yPM0TVG9s0aQ=
	=
X-Google-Smtp-Source: AGHT+IEei79wCN12n4ivLRhMw6PB03mr73hXLL6yImc2GsFUsxXRJqLx8nVL6cz0fWEevcMBBvzVTA==
X-Received: by 2002:a05:6a20:2445:b0:220:21bf:b112 with SMTP id adf61e73a8af0-22cd5eee5dcmr11536615637.13.1752149548366;
        Thu, 10 Jul 2025 05:12:28 -0700 (PDT)
Received: from nuvole.lan ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e07facsm2194968b3a.68.2025.07.10.05.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 05:12:27 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: johan@kernel.org
Cc: bryan.odonoghue@linaro.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mitltlatltl@gmail.com,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform: arm64: huawei-gaokun-ec: fix OF node leak
Date: Thu, 10 Jul 2025 20:11:37 +0800
Message-ID: <20250710121138.228975-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708085358.15657-1-johan@kernel.org>
References: <20250708085358.15657-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 8, 2025 at 4:54 PM Johan Hovold <johan@kernel.org> wrote:
> Make sure to drop the OF node reference taken when creating the Gaokun
> auxiliary devices when the devices are later released.
>
> Fixes: 7636f090d02e ("platform: arm64: add Huawei Matebook E Go EC driver")
> Cc: Pengyu Luo <mitltlatltl@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/platform/arm64/huawei-gaokun-ec.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/platform/arm64/huawei-gaokun-ec.c b/drivers/platform/arm64/huawei-gaokun-ec.c
> index 7e5aa7ca2403..7170f8eb76f7 100644
> --- a/drivers/platform/arm64/huawei-gaokun-ec.c
> +++ b/drivers/platform/arm64/huawei-gaokun-ec.c
> @@ -662,6 +662,7 @@ static void gaokun_aux_release(struct device *dev)
>  {
>         struct auxiliary_device *adev = to_auxiliary_dev(dev);
>
> +       of_node_put(dev->of_node);
>         kfree(adev);
>  }
>
> @@ -693,6 +694,7 @@ static int gaokun_aux_init(struct device *parent, const char *name,
>
>         ret = auxiliary_device_init(adev);
>         if (ret) {
> +               of_node_put(adev->dev.of_node);
>                 kfree(adev);
>                 return ret;
>         }
> --
> 2.49.0
>

Oh, I should have checked `device_set_of_node_from_dev`, but I forgot,
thanks for fixing this.

Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>

Best wishes,
Pengyu

