Return-Path: <linux-kernel+bounces-866435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D62BFFC13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5DC1891BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A72E282B;
	Thu, 23 Oct 2025 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GOsCqLSp"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D82E1722
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206393; cv=none; b=NplYAQPWfjtSG6TOtAaX9s4HFArWWjRNeVMMry9NTYhoXhcTrhphwyKHHdd9BdQ2P+vXkhB7eERhL1vQw+U9mrXur7Olw//VCBo5b5vvJfS0b68ldOD+giSIiV7Gfc4dnPoPUGkmG3Lw3b10p6WmDTAAj8uXjaOxWz2pmLwJozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206393; c=relaxed/simple;
	bh=+SpyXxRkftlNGmLUWNB3Rcdg3zyaCMYWurX6VO02fTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWofLN6YVu9v+wAMulnGJftIwhs7aB5PQk1qAGb3UeE1lsWShOzzK4WNb6i8wZxZ5DSXUlzemINJBAENYyXeiRsTK7rZr0FeOwGsSJjJybdKKE1fho4AZ8IaWthoPaPF5H8tp8v9sAZUQ2smLS/Kx55VtHwkyazM9x7ssn9yaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GOsCqLSp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so2444975e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761206389; x=1761811189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5LFle24C4lX4/lX8LsiFnLh/vNITYUjWURDn9xN210=;
        b=GOsCqLSpNrZkVzeKwwv0ivG0JN+EMZYfsgSnlDcY3rknELlPurWfx+Kj0BsdJrbun5
         W9r2BgELyouZndPzwMeQLU4f47DEqVcfI+0Wm0N+vMSVgG/TOhROhvMrTFAy29odCfAw
         4A1shlcMIxybJDMN8CGapZH/D+SYoasiyU2Lj8o+1VXWvj/wf8+m1WYkBL0lCwOLOA1Y
         9J/xl72VjjOkqTzK7mN55ovaOmPXV1KL3EXz414km6mO6hBkTdoBvb1gED77YwiNEy9H
         C+/delPUtw1TbZfqMULRQMhwVsjwoFv6LFFgctIARzNKYory4XjbquRNEcZpp3Wudv96
         Nnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206389; x=1761811189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5LFle24C4lX4/lX8LsiFnLh/vNITYUjWURDn9xN210=;
        b=v/WJEuA9bU7RNO8tmnNX/lN24dR7Y61WQyUeFDJaZql5cHxudwIjrbnitADNK677kn
         lhwRaNTGmJP3sHho0iA6wh8mhY+CVdvpi4raWRgGoSmpyYBKGmisu0Cs2AGj5+B8PD3m
         Pzi+xIw1Oc5F+xu2dAWzXDZV1IeGsxcTgDvnGJG4WlY61olp2qRDYPXN7k3gZfssXzxI
         pQmx2B6Bt10HECG4tNsYMRX7GWyS5sFD7VnHmEoVclXWnT4tfJ3/r2E1eE5ljfMUlbUR
         3PY4YXTolEveDWcwbqKV8M6f3sdspqATAGYvXgsm0Wys5MTYgfku7e7QxHUno0kG5Psb
         nLkw==
X-Forwarded-Encrypted: i=1; AJvYcCWLDx5kJfxkXPezWSGiQJUVcEpKql2UD+WiWEaME2OUlpzSWaJnmjVa4cbwmmmoZ8fH2cCgqWGKOHInD/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfqScAmlMrSuTIoWSPyOsC5x4tIDvy9SkaGoPO8HhaYiASiso
	nA60MBdZCUaUG8plZXGg5K7SvFXnwgDKz4KFnlTUSRivhRTGsWUfxXyZMhuqzaAnxeE=
X-Gm-Gg: ASbGncsln2iJVtEEsraYA6mDAs+t4yeG80E9vGWwGUCXEsWYBlADIFoOS0VYJm+I8do
	us0ktW6m5r9HWyFa4X1YOIR6jreYM9Ktv/eAcBi+o5y3amG/1FFpXgquf2bci3TClgpPG1m/mBx
	Rlof3QOo0r9ki4XMa8HDGicUaVtnIzS7/donZ1lXQcONlA5mYZXuoSVcYAkYnbI/qozB5m4Hkny
	S5J6GY7EsAlCpNuSIxTUjacIV2mWklAiY3EL2Wq+FC+p4G+lWnEuA5gZzSM4XnkE2ldrbU2odse
	yXBHscyTlCY3ySKbKlDhAWsYgj9qtHjOfuAga1teq4AJSrlW42ubGQt9risD+w90r3nf0tN9oDZ
	PPZFqDdcXGXpjoIrdH2nqkkJKCgpmx0lHh35DH+1pHuc97rpT5xWRlUHINbsskaYLiYGjCKzSfB
	njkRQ80KI+7RZMqhTi2wIn5g==
X-Google-Smtp-Source: AGHT+IFw8DrAsP2ujJ1z9Xf51elPbfYymJObtmKWyxRCkb7tIajC9Z0M/MWJkVISOmNQ3AsjztV93g==
X-Received: by 2002:a05:600c:190b:b0:471:a96:d1b6 with SMTP id 5b1f17b1804b1-47117874dc2mr176361195e9.7.1761206388338;
        Thu, 23 Oct 2025 00:59:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1b4:e02e:c538:6feb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caea0468sm22931325e9.8.2025.10.23.00.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:59:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Michael Buesch <m@bues.ch>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] gpio: bt8xx: use generic power management
Date: Thu, 23 Oct 2025 09:59:46 +0200
Message-ID: <176120638405.24462.15473867139996562246.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016163618.1355923-1-vaibhavgupta40@gmail.com>
References: <20251013174319.GA847155@bhelgaas> <20251016163618.1355923-1-vaibhavgupta40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 16 Oct 2025 16:36:13 +0000, Vaibhav Gupta wrote:
> Switch to the generic PCI power management framework and remove legacy
> callbacks like .suspend() and .resume(). With the generic framework, the
> standard PCI related work like:
> 	- pci_save/restore_state()
> 	- pci_enable/disable_device()
> 	- pci_set_power_state()
> is handled by the PCI core and this driver should implement only gpio-bt8xx
> specific operations in its respective callback functions.
> 
> [...]

Applied, thanks!

[1/1] gpio: bt8xx: use generic power management
      https://git.kernel.org/brgl/linux/c/d5376026f9269601e239545e2ec4aea0cc62bf2a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

