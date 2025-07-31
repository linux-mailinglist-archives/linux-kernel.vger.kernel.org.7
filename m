Return-Path: <linux-kernel+bounces-752591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45140B1779A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFDE189C026
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99C3264608;
	Thu, 31 Jul 2025 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PqY8nbQH"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B515A8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995761; cv=none; b=mQFpprSGrmplooUxl9szJsUChs6TzpqvyHTcbz2LxJcPmHPm8dyWWGSRUlF0wAxwClzMfQ2CMhgK/47cp+6i2a6h+14b2I6za4t79fxdZ4W48SQ5lzl86R4LJtmInH1MqIAt3lXteOZPX5FIIQl1qOoH1l6TKjUlJebnajfm5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995761; c=relaxed/simple;
	bh=VvDcIIZYbR5ABGWrRAC8KtwDhSXJ5ShvR7mMB076vxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eYoAWVdYcFGHAGpeca5gUN59d9TrFz7jdkWkoeg3hky+6KqqgKvqbQnmXLcYPpseICljhcM7AONgm00pgwjPFo2k5ob+Mb5QvFD4sAjKpmR3/ieLmnuy2D8kgWHUd80OadpFQKwRHK7aH53O/XQp7g0PjWoN1va5z8NU3l/8YlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PqY8nbQH; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e3d31a9ac7so3900895ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753995755; x=1754600555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XsfntcqQ6csvTwNyJAnEEKzN96J5OJofevbNS9mkqg=;
        b=PqY8nbQH9d5A9Bk8kW/YOiUWMTnTsKjKT/PG/cQM7oBiSHLCN0rSr87F+nhNugDo5x
         tKHHT9J4zkFbwELX5X+AYJ6XCIZuodq9zR33gTElKMODPcskWEOB5rH1abX+grf3gV3f
         yVPGN1p1ijFRYdEGdesUTVkCUBt1dxy8e9Cm2qq8jSzezEv1QGsO75B4BY2NRFatzrsC
         7FH+RvWOHs9ixNfQs/tgbPDTTUc4wwmCetAckkj+mYaV4fXq0l/atoULPtqCT6uU0nBT
         l3rgaY/QRioSnILaDKU89I6RJkGGW6fV+fa/J697KSHOlsSCbrKdpUlzP2aesHpdZpBI
         u4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995755; x=1754600555;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XsfntcqQ6csvTwNyJAnEEKzN96J5OJofevbNS9mkqg=;
        b=bJMJ/Xvav/37hD2qqem4lfKXN/aZB5m1wCPeG06M2kM5hzLS+bc1tFJrs/UF+TWn3d
         VKqODaOuOTPF48x1p7DDXQAl3r/qs+t7yFZw+3wJzaUDvs4fu9ABP8M4M4CgB84vWl7o
         zZ82AvtceO0tasVpbhQH+Y4YBaKJMi+ygBZZ0I2xYpRgbt9GQxR23XVDZX+W9FxY5nyP
         lvUlp2YRmQNh8e6BY4YB0pWZ07QsqYhB6FwRaw5hZpY+9NWHcU8HRaCdNmbpOHLq9MC8
         8wEPDG4lLEEhoSjRnbOwD0yWDm3EzuBjPf8HYLTo+OTOuA4w2Y+c7/AkwtgQ/DEfXVNl
         bHfg==
X-Forwarded-Encrypted: i=1; AJvYcCXtRRDV0r9hLvtYL3Gi9BfSQFuAY9uHoZBQdKbhyCI4FJnauY1LfY7K2lfcb7fVPq+hIwB5jgHliT3Dv90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgps+BTjnzUilpmkkBDTGHkta15piECjJT6sWZZ/J31bkDHG7o
	PNwIvpMaoYXCTju/XFlKmzUka5ogf0AtGohlqth3Z77af2/uS68RTREkFV9aiGnJdT3MBk3Rjkk
	xolzN
X-Gm-Gg: ASbGncswAqJHqpxaoNUwXsnDfKCGjhVwBJMFSrQrsScuGZfKONW2+xBkSvueHwbGzLs
	SwlAGjq2byCGbImFANHCO4ILtbUTSfyHxoSb0AcsQZR29ZQ9Yg6YlG1J3DYIHj8xtZ96hxdptu3
	d8rBzZwA1+ThC2sQaSMie0GiO6oGhTZkvMDCV04pDE/t+I7QhQL/vTrQboAcAJgDvIn+apZ6SR2
	lIATC58Sh4neQnRarYupONoP8TAO3IleWX3Y2XSk8xau9tWisclwN4dey+gBEhF5ty90Kv/9KZe
	H7ecC6p6Mm+k7I7JvseDC36Ujle8sxLewgq+cVw6c0Wl775BO1nP+Cm+6P5dZSI23MZNYqmFQMj
	nIDltn0UAk7fb
X-Google-Smtp-Source: AGHT+IGKT0RgUTn9YYs1F89WnC3a/jmyDkGPckfY2oxUk+gEldlRw4qKJY41tJacKy7ZUvj8P6mzKw==
X-Received: by 2002:a05:6e02:178d:b0:3e3:fd04:5768 with SMTP id e9e14a558f8ab-3e40d65443cmr5688725ab.5.1753995755256;
        Thu, 31 Jul 2025 14:02:35 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55df201bsm752208173.109.2025.07.31.14.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:02:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250731044953.1852690-1-linux@roeck-us.net>
References: <20250731044953.1852690-1-linux@roeck-us.net>
Subject: Re: [PATCH] block: Fix default IO priority if there is no IO
 context
Message-Id: <175399575406.610680.10505836643407350567.b4-ty@kernel.dk>
Date: Thu, 31 Jul 2025 15:02:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 30 Jul 2025 21:49:53 -0700, Guenter Roeck wrote:
> Upstream commit 53889bcaf536 ("block: make __get_task_ioprio() easier to
> read") changes the IO priority returned to the caller if no IO context
> is defined for the task. Prior to this commit, the returned IO priority
> was determined by task_nice_ioclass() and task_nice_ioprio(). Now it is
> always IOPRIO_DEFAULT, which translates to IOPRIO_CLASS_NONE with priority
> 0. However, task_nice_ioclass() returns IOPRIO_CLASS_IDLE, IOPRIO_CLASS_RT,
> or IOPRIO_CLASS_BE depending on the task scheduling policy, and
> task_nice_ioprio() returns a value determined by task_nice(). This causes
> regressions in test code checking the IO priority and class of IO
> operations on tasks with no IO context.
> 
> [...]

Applied, thanks!

[1/1] block: Fix default IO priority if there is no IO context
      commit: e2ba58ccc9099514380c3300cbc0750b5055fc1c

Best regards,
-- 
Jens Axboe




