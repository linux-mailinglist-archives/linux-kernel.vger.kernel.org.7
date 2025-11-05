Return-Path: <linux-kernel+bounces-886352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BF1C354F3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A303B4E86C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B61630F948;
	Wed,  5 Nov 2025 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Zu2hghgb"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896F30FC0E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341313; cv=none; b=P2jGZQfcbQR8tcmMaKA/X+iJWYYomTdN86f5hTDAnUsJv4ihosNHw891Q2H1j2109lxJskRx7/EeKfu/rXKTack8K23LEWvYoac5wXWIoSFF8nzZhPgITRhub9nwvWLI31s/1ep36T1W/p9Rha55L+LXgguD77W3UHDzgFUpSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341313; c=relaxed/simple;
	bh=b8NLflI1+239K3aB4h6UiQXjhstJCs4ItnoyobU/xvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTwDggkUK9zM1+V6aYyNmeX55Bf/M5SHuW2BbH9VkD6eqEUSBNI0rtsJoU9nS/UKbUVL2lKazHNGcuP7gI7/opewb+F1W9xTGLR3bOZfuLcUhY9YRSMnGE8hJYRmRwRvy42+OnQIVvYQa/UDXNgp6UQBHj4d70JxGXsTQgEgjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Zu2hghgb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429cf861327so1050741f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762341309; x=1762946109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAPLoTchT6XoY30KdYFFxFqaI9SuNLjLbilldo++DMM=;
        b=Zu2hghgbcf/LWm8N6MF5IPy0lvMr+at30EqbpQqW/umTY+nnrVxJVmFpvvqilgwR4g
         IQCtgsO5tcWbQdlFLiGgdNHSjSpFeapWCpJtpibdUr7ICGY3oXHL8+9sgAcLLnf/V3dK
         II8Vm9CsbcZnYd9fNa+npqMP0SEcQbPpuPImAkdsIfRN941bG/gx2sqfQm1mHParE/r7
         QY7XhLrbhOuy7gFgTvfRW+QryhtNJj/kGhde3OMak0PCoYPd32bO23nTppBFHXrzoZUo
         8SO2yHwQOz3wJZKrU1HQhbHWPuKrjlOQJb8GWe67c/2hq7zLmCtWZbpqm1/uUae/y4n/
         qrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341309; x=1762946109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAPLoTchT6XoY30KdYFFxFqaI9SuNLjLbilldo++DMM=;
        b=L2X4/+9RmFMEWa726GI4Pe5ZA6KopUZXIZsjvUeMw6+TU+mEShmFWxDAD0dg98CEqb
         TF0KEjJ75fO59UalXU2vS6KCQqj8RnSxYFM33+6eI2MtMCjuX2/OEZi/RYmThUcFONQg
         HbxzlqbXinsovkfDa136nL6wSegr2t8ytMdN24NP9Ez0zbsNnli8HdVdogBeNXUHyZ1O
         GrA3b0Gsm2U1VGArCq8t7w9VkTEH0/Um37ViNBavTinLSVCwevNkNzYZ/Za+oXnia61K
         1H+admpgX9AwY4oz1KkAi4NfQ1YrXXB9VqjQ3KrJq3xSnBLsXegHhl0aVc89GcvtgBbh
         wo9Q==
X-Gm-Message-State: AOJu0Yw9hn/l2JYrluEcpRPXVDQRuUwAMtpNS+hWQ8s42zA/mkrzRCfL
	pWNotStrIW95y2omHS/R7BfjpS0eZKlhgUo4hQ6Dj94N7OkQTtYN6x6U2NWmArvcN0BoqIqPmQA
	xszKq8zNlLg==
X-Gm-Gg: ASbGnctsJYqH1f7f6x6pbllpZHUhRQU9dWs2J1jz25mlujosS8WEQcUwMnsYsmwkeRZ
	oRhFnir0EVLqRSlEZ//ZJTBe5hadTdLb3JkdTb+EBZ3SSOmvd/FboGTMmmornaDr7sIdj7dyFMz
	rmOaKMxekjLVR135/8egFx2mZWjiWgTg8q2C/75/gdyikJnjtFGD9ZIGrs4y2M1wemJq6Qz2AGo
	mp+wsZ4RUUJnV27IDWbZrIWFZOustOVNpo5fNnv0TIvzfapBwaDkmyW17nwkaaHGd2iDh8DtCyY
	ddYx62VZFBFvTPgRhJVGzylyACKaU6JeZCGwgwS094ce2LBFwM3z/Y7n+TKM4+CSlOzk3eWOlpx
	B4gKM0OUgfG4HYvnKfx+6A+dcuK4/CdHtqd48fPXj12xk/tEjx5JqwfS2B0Oem4iD3C2aMA==
X-Google-Smtp-Source: AGHT+IH/0DnzWoziqd0EkmGpk63QntkLm2srNLkFToLi1ng2mHhma7kmyyi1K59sN5GGeDB20G8mTQ==
X-Received: by 2002:a05:6000:288a:b0:429:bcd7:ac9f with SMTP id ffacd0b85a97d-429e3312cb0mr2728372f8f.53.1762341309377;
        Wed, 05 Nov 2025 03:15:09 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:4e71:8371:5a52:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5bb5sm9928777f8f.30.2025.11.05.03.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:15:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Marco Crivellari <marco.crivellari@suse.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH 0/1] replace uses of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 12:15:06 +0100
Message-ID: <176234128319.20998.3148035011153421288.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031111628.143924-1-marco.crivellari@suse.com>
References: <20251031111628.143924-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 31 Oct 2025 12:16:27 +0100, Marco Crivellari wrote:
> === Current situation: problems ===
> 
> Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
> set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.
> 
> This leads to different scenarios if a work item is scheduled on an
> isolated CPU where "delay" value is 0 or greater then 0:
>         schedule_delayed_work(, 0);
> 
> [...]

Applied, thanks!

[1/1] gpio: cdev: replace use of system_wq with system_percpu_wq
      https://git.kernel.org/brgl/linux/c/b6d31cd41814a33c1a22b8c676131820440cc44e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

