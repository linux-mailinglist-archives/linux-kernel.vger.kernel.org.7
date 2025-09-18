Return-Path: <linux-kernel+bounces-822805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27DBB84B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4126A7AB4DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CBA305064;
	Thu, 18 Sep 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXnGKhAL"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D1303A32
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200328; cv=none; b=cHA4io5R6XwkobAd1EPzy/0OLTHMXniWQ54/5sXGCV40QjsjdPUjFifWL+BPN8bEcv1K00EHxHOLsxlXuH4sHyUXZeTFGk5VjluOwQW66zr7E3j8pzKdY9WVr016qmWgA3gmfRc9oJ3RI1Xy+61OrFTjIkK8BqRB4u94e5U4+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200328; c=relaxed/simple;
	bh=lvcQGE6zMqa3RPKmZjZH5zBkLah9vgbD3X7rCwM3Uvs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LguCSHaosgSljiiYHdOeDle3GKkhhkisPt21kyVWGPsvE+gsAp4E/briEGbBgyy5dSTn0zz0728/Jr41slJdOEWDiV5KqfFOEEUEKSDj8H9o1FWrZEPbvEUtOCK9Erqo421DNPpGDvaPQDAlpfBjk97mE/NWaF09RU0xLlZKJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXnGKhAL; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b046f6fb230so191886266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758200325; x=1758805125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lvcQGE6zMqa3RPKmZjZH5zBkLah9vgbD3X7rCwM3Uvs=;
        b=NXnGKhALfj6DlKeOHQ2Bg5ICvOLXQRL87q2c4Dyfau+W0hglTwwzaKOaqY507QyHnk
         9Ki6JEkZw+W8uT7xLGegNVOiM3eJsB4Qsfno57q+yr9fZEhK1DF72giefaYlvQnbRh4q
         T1bxVw5tDGdpoNO6bNIBIx8zPnlS61+y/zkFtld7loynoTEUfDnADlYz8fSqBMuGhpsR
         4imNkTluKLs0F4YMvhlWkf3xFjPiE6DOAv4yj/VlZdgGAyWQdtqMAI4zg3Uqnbqibm4l
         IZvoXM2f6DyscJIoOV3AnJdAiOJiz7VFf/Nd/fIqK8gmn59ywBUTodIKGvjbjP/rBw1W
         uNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200325; x=1758805125;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvcQGE6zMqa3RPKmZjZH5zBkLah9vgbD3X7rCwM3Uvs=;
        b=cSJkSIGcSQpG+F/xy3QEjBUjTUuIH68U0F0IuAJO4mOsEOZv2Limf42l7IqBywis7E
         Ju+74Qfz4vZ6l7htB62j4BfFw+PdwQs7gXyuL2JraC07QNGHYHpiC25Kwbvq07ov5Nqc
         BjIiwkRcZvrxqJK56OK5rLRWaISbfnQICYUlWkn/5Mitiv6a/ktqxCtpkb/lJizrtj9Q
         jKXmRmym1iqkR7XJoai/wfXX9Q/fRLCR+rcLbSd397St/SkgLRclkm4silH+7iLBS6hw
         aU+1lloLsBLrMaRBWZQEsOdjIXm6ufngDyysmdUQJj+rSzO07i2TNFjHn/r1i8KvZ5Sn
         5jiw==
X-Forwarded-Encrypted: i=1; AJvYcCW0hNBrIXAdh8L5eP/+J6Hg7V+MAClZ9L2ARiu4AcZT+uI32Lddvq3rcPdFB+H5jWHGECGetzQP5P8kpak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLUJiONSAePHWo9zHtjhMQUywnoGMnEBmmlB/XeMksudz6Uk+
	akwVQHL1eXN0D083hSpeurcQ2Tm+4Ed2tdppSnNu0p6/zaKHWJ7ffZAId7P3HumBvzjKEwKUnyk
	JK84TUDtVNn8ig4SVSc/hxLmAnQdUKVw=
X-Gm-Gg: ASbGncsEzIW1zLT28fBEu/qa83JiE9qS96kIi4/IGOzvJdEt7PTICq75JXghrFobVLM
	tduiA2DpKjLmNthJUXZW3zTXwU76ZnKRqjb/AV7ki2iPDFuF9Y5BTL5cqnWNp1A0fYOIyg2uK2a
	BeM9AV14eEOONuTbkxLy19neelZCVWMLnF0FsZsYMAvnwrqR/ZS9Gp/Na9gfc1VFNDmioA8anxy
	Axe1Y2K4iZ8KycepmU/VeTH0w==
X-Google-Smtp-Source: AGHT+IHG8sk3bcUaHQwBrZoLncnJChfwaJcuvBt6nfYyVTZWygm5etjUbCmo0srSUZFjiTWBAdZCH1hJ4cgs9M5FLD4=
X-Received: by 2002:a17:907:6d06:b0:b0d:400:9182 with SMTP id
 a640c23a62f3a-b1fac4e0b80mr343825666b.22.1758200324771; Thu, 18 Sep 2025
 05:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrea Daoud <andreadaoud6@gmail.com>
Date: Thu, 18 Sep 2025 20:58:33 +0800
X-Gm-Features: AS18NWCEXBGAyDTuAdYfLyOIr8P8xtqgcUaqAsI0KK0ysqpeO0oKN9Ycaxuqg4o
Message-ID: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
Subject: Possible race condition of the rockchip_canfd driver
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

I'm using the rockchip_canfd driver on an RK3568. When under high bus
load, I get
the following logs [1] in rkcanfd_tx_tail_is_eff, and the CAN bus is unable to
communicate properly under this condition. The exact cause is currently not
entirely clear, and it's not reliably reproducible.

In the logs we can spot some strange points:

1. Line 24, tx_head == tx_tail. This should have been rejected by the if
(!rkcanfd_get_tx_pending) clause.

2. Line 26, the last bit of priv->tx_tail (0x0185dbb3) is 1. This means that the
tx_tail should be 1, because rkcanfd_get_tx_tail is essentially mod the
priv->tx_tail by two. But the printed tx_tail is 0.

I believe these problems could mean that the code is suffering from some race
condition. It seems that, in the whole IRQ processing chain of the driver,
there's no lock protection. Maybe some IRQ happens within the execution of
rkcanfd_tx_tail_is_eff, and touches the state of the tx_head and tx_tail?

Could you please have a look at the code, and check if some locking is needed?

[1]: https://pastebin.com/R7uuEKEz

