Return-Path: <linux-kernel+bounces-786433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18245B359BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DDF3B13F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36586319858;
	Tue, 26 Aug 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f2UCS8gX"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B802FAC0A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202602; cv=none; b=CseWE13gLA/EJIG7MKwpGsfZvDP3XmqjrWFFmB7CwhnZhOiwYSxqlkmzIq1K3tFbBMwt6Dn9bfpbKPDCk2DyJ5NNT80HezqUIjh+Rvk0kPaNh07KCM7sb1LeQFhym4YDO9uWMj+GCzP/qeK0/1mlEn+OvNfNlm1zvVXMrBK43d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202602; c=relaxed/simple;
	bh=xevhfAazTddx0rQjEFUdAx6GLBraql1L8NM2pfEwN9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igeKYs3XkftDw0SSN8o0mOk2v6r0+WIbvuMgRfDzcB/beYi7xccmuZP5jg6+ZD7eDQJBPI7/anbMrzWg+PSl4I1Cs2lxLIXfKM2CWgaIUajc4awnZOVhFoZlKBraj/rLbek6Lp06SSnB1KhibRstIXE3sthUnnkqiwPoo2cXcDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f2UCS8gX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso43414065e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756202599; x=1756807399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBqfnxPgAMrsbBcXZi3Cjt/GmjJIAGmLFwEyWU22RiY=;
        b=f2UCS8gXWLwmQ50s+/yR8zA7E1NtlXB8KO2r5YSvL0Z/BZjLZJ8GVG1nfRRnnAl6hd
         87AY4q6/0FwXNBMoVWwFK4L3ymyPgzQ/3W9Xueey1QujBbhDsjaicFjpcSfgfj/DZrou
         MAYztSGCVfZtn3tAixshr5X521wcEaoe0UXPDqdEOQ+TArTeR5ESHTHeyXEgNbiqy4VQ
         gli9Ze+JMMSKP4kMNyXBYnwmhiyCc2ZVnhJgEBoCnahkNW92hdy4NpGAgWHuXYqQzlxE
         e9kYtZ8aGZ0plENB1KxkZWJBscBKGgq+C5xoY1v1DYi2bO4xFRNcMxTXRBXUlQ/WBeKC
         Gu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202599; x=1756807399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBqfnxPgAMrsbBcXZi3Cjt/GmjJIAGmLFwEyWU22RiY=;
        b=sUM5EJd39auECl++bpC4XphMct8IEtfSiIGgnfR8nPtxcpp07IPI2DApNUcB6o2BB9
         dEkYZKt7Q3i3I6bGlOf/ulwZrs9XQtjC9z57Qng6WOuUTnpP5RkxfuwGanp7Sh3ZjkVj
         rroMwbKj49Ak7sVvIeSYY92XOKDXDSWpT50ETEzUBFr6iIVg47DjAUQ9FYJl02Dgsdcn
         E9bwORHJAr1reoxwd5cORp4j5mzL8AXRZ8l1RSsMT6CcWJwtNKbXWwvCOWmTLLFX4cP4
         fLvJDl1oRm6jMU6oIrHAU0L319iFzDvS8gMRXJ6pTih2okY5BMSmcxypnksnVYgeyVuF
         +4og==
X-Forwarded-Encrypted: i=1; AJvYcCUAqk05XQsfUTQr9R3CMdpKd8lz/F83088JYZ6oODQ3Jg7QxEsLCz4sBydRLM10T8HGBeOA+B5CFfz9FWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmRiecbqSWTxRVkjUCyYsFXEhIECZf13wjIjA0Ype36MPyQuA
	1Mckfq84zd+e2lbjU73uqShtWzs1LV5FE4EhxCkIZxg82xRuFSd5W5fzI+glWdu/YPE=
X-Gm-Gg: ASbGncsOk2qVgo49oOu42ZyGv2jkmKRZ4KoF8uryK59srb8/AzHtVt0IhjivgA8xH00
	XQn3MAUhLXLNgxg0Fmau0vRIeU6vP5PxAcq5AMh01wSP2TQEVSEVljBw/hgxV18f1nvGe1AzFxr
	hRrsqp/Gh+BHEXgsDmSnZG7dSETjpxAIpz9aY/XwefYUeU4ghxr9WBNO8eepzXoKOeE3T1gzoLG
	5au2zsx6MZdeiRZ/5FUw5Efw4tj/SHuDafdijvJGx0ZCHmsD/8wObRFLsaf2e1v/GKyAuvQuWEC
	Vhq4kMIEtqoJ8N1zfsxqPr88iEObYfS7PPpZxZt0a8V1kPADIsDi4oXMwGAtHb8FqAeI2L4Xyf8
	km1ac1MD2z2kUT02ShvUNOojH
X-Google-Smtp-Source: AGHT+IE6TWi8fg6okLLjPcaEFCRB/2mOkzoLagFUTSt4mPmBp6bUoi+XqTJoRHs4NKTP8NhEfIQA9Q==
X-Received: by 2002:a05:600c:4590:b0:45b:47e1:ef67 with SMTP id 5b1f17b1804b1-45b517e8d46mr98883845e9.34.1756202599397;
        Tue, 26 Aug 2025 03:03:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b661cb14bsm13613675e9.2.2025.08.26.03.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 03:03:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Junjie Cao <junjie.cao@intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: timberdale: fix off-by-one in IRQ type boundary check
Date: Tue, 26 Aug 2025 12:03:17 +0200
Message-ID: <175620259460.21991.7139337951107127710.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825090850.127163-1-junjie.cao@intel.com>
References: <20250825090850.127163-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 25 Aug 2025 17:08:50 +0800, Junjie Cao wrote:
> timbgpio_irq_type() currently accepts offset == ngpio, violating
> gpiolib's [0..ngpio-1] contract. This can lead to undefined behavior
> when computing '1 << offset', and it is also inconsistent with users
> that iterate with for_each_set_bit(..., ngpio).
> 
> Tighten the upper bound to reject offset == ngpio. No functional change
> for in-range offsets.
> 
> [...]

Applied, thanks!

[1/1] gpio: timberdale: fix off-by-one in IRQ type boundary check
      https://git.kernel.org/brgl/linux/c/810e154d90f44127239957b06ee51a55553a5815

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

