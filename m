Return-Path: <linux-kernel+bounces-799399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD65B42B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2B01894546
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD922EA46F;
	Wed,  3 Sep 2025 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBZaUcCx"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448EB2E8B63;
	Wed,  3 Sep 2025 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931778; cv=none; b=eKx0YuNjnerswgP86ZS6quR1vcFdoQcb+2XRrYoXq8A0LdrZ8Z8HqZDg2O3op0F31alAyOVsneEfK6L2YS+u+k0oJ9o0SKq2EVl6MuBMMFMEcsvaK63vdMr9sLQMWpqXDrjXGr95whhiDQNxrLzRx+1GqkDdIdfHDKF4Hyvqsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931778; c=relaxed/simple;
	bh=PvvP91MnhzT4YNmH5ovapJ2Nh95w1F0BoiqS+Bur/Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdknIum+tTDGmu9DbB61LoxNj1KBDRyn9Wrg9/lR9LVFDN943nuCZlAl71ss0CwferEW7dwawHU7h3irqch857sUn+1D6cdds6qaeJgc1z3vc2xtgiMgFWLci7OeDz6By4xTsaDtdQ46blwSU8VQTsqdX+VGn2nn1+uG3D04RmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBZaUcCx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so274852e87.1;
        Wed, 03 Sep 2025 13:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756931774; x=1757536574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSqMSOA8pNQO/DOY9Li0FyOVJaHw2fwPVQM8Xv37cok=;
        b=aBZaUcCxt3moQIRwkzpeKVVT3BAZGRFkNSelyFzAUB+e6usd4kRuFb51z27OwJKW54
         oHTW3AZk4tR+n3Cqp70SeV67GBF2InuEjMEdjnUS1xryrXROdp7S1JqQVW3wfB4/Ny+H
         BrTAJMHyHIBmTIoAaRsxJZg0k12UdRGzjKaKNOdP7cZ/6qEfu9esRJl6frrcs1coPOoT
         DuTFlGw7sXl+T9DaQ0HE49KUnOMMw0n6gawk/Qfa1Ls9d1j5ktqkNJuZmaTHtANKLYb+
         i938+gMHFinJ89BbtRWUpQK5bhH5gYnxl81Rgx/79bLJAXAFIPDSVkDYDGt40pkMsZRK
         mWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931774; x=1757536574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSqMSOA8pNQO/DOY9Li0FyOVJaHw2fwPVQM8Xv37cok=;
        b=c6zR1urv0/PHzhktsSmrDOtABfS+x7nY512hIsi2in91N8fTJk3Blhgr48IMOWo3p5
         HjMlSTg9sacUona2UHbnD6Zu0Ej3Dv8gpRhE5x87W89PQRuGzdqKanZtAAsZ84HtRfEs
         uNbaeHoO24ADTqRxALuCWvgjUcqVe3cyRzmvbcJ9hYVkJw5hveIUBTZMrtLaxyk0yRQQ
         +MMLtJCOf5aND8mt4VH2OxLiSYPL0js/lAMMprYDXaOb96ZINj8VGMMs+GQEkTjRZYDD
         rRzzKC1yQ9XWBt0RN3unZYdkR/SQDEUOuWGNcBUirUg+OTW7nql1agzRLSlRDOviyY2q
         3mlw==
X-Forwarded-Encrypted: i=1; AJvYcCXr6531938IMTSJuTvc+PEkmIbMlOa7p1toGx5vDZIPptD4gOAlHtgARrEdEHs/EbN4NpD9ZBRTCXoHNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAU6dE7br73YPmN+qtjSTHyJfA2Kyq5wo8dOFcr6AsZpnAPT4y
	hADTH2jHNLcYfFAryvOYXB47Pnn16LGlXdVIMZNUcMOViot86qCH10De9+2UgKUD
X-Gm-Gg: ASbGnctpygInsEVQpwl9YW79lnlc7vDdHp4Mg3hWWQq7QKcxHxTZ8tbEnIzEwUoWyFD
	VgDzhiMbmGl/hvUZypUQLh0oQyphjueHiGJLMocbMQAe4Om2pn4Nkc4Egv0qTp+D8v0Dxtms5R5
	M77F92XS+lJxGrHIqZNF5ry4ciDYtGSY7umuOQ/B22W5fjA97QhJ85GoanwGKKBZBg8FJLyKiF6
	oEG81PSj86d3YXAML8JBIhJkUpQuSv6F20hzncMZQtqPuCcYSewbFLlWuP+ebo/aC4rCTr5LQqr
	9NE5C/vRzfszK2efTTMeHQ6x9LwVf+pUGhQWAcH6tjJak9fyofM+zC7cCUYx7cSJynJeYSx8pC8
	wHfKKdyOb7fQWc7Ug9uaGFmgBpF5mdOAEVKAyz2o+YdyBe3ed7IG8vXtPOoDHqGkWhPPL1Kxphw
	bq2El3OXV5uz0ohioFhjCX
X-Google-Smtp-Source: AGHT+IHpPGFUXOJiPHDyrsk0mdswAL+yiYrxEGTXAVG8KCttJvbb6IebJcf3Qea+5x8ndEDe5tUZMw==
X-Received: by 2002:a05:6512:12c9:b0:55f:5428:eb72 with SMTP id 2adb3069b0e04-55f708ec77fmr4622912e87.35.1756931773474;
        Wed, 03 Sep 2025 13:36:13 -0700 (PDT)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5c299sm731722e87.8.2025.09.03.13.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 13:36:13 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	hch@infradead.org,
	macro@orcam.me.uk,
	glaubitz@physik.fu-berlin.de,
	mattst88@gmail.com,
	richard.henderson@linaro.org
Cc: Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 0/1] alpha: disable DAC for 32-bit PCI on tsunami
Date: Wed,  3 Sep 2025 22:29:43 +0200
Message-ID: <20250903203502.1155-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've spent quite some time trying to make the qla1280 driver work
with 64-bit DMA on Alpha/tsunami systems with more than 2GB RAM,
Many thanks to Martin, James, Maciej, Thomas and Christoph who has take
the time to provide feedback and testing during my attempts.

This is what I've concluded so far:

*The ISP1040B 32-bitcard works with 64-bit DMA_MASK on a 21164 Rawhide
machine, hence the card supports DAC, even though the papers on the chip
don't officially claim support until rev C (just as Thomas Bogendoerfer
pointed out earlier).

*The ISP1080 (64-bit pci slot/card) works with 64-bit DMA_MASK  on a
21224 Tsunami machine, hence the monster window works fine on Tsunami.

*Data gets corrupted on Alpha/tsunami when DAC/Monster window is enabled
and the PCI card is a 32-bit card. The amount of data being corrupted
each run varies a lot, from no data corruption at all to several
kilobytes out of 20mb data. When data is corrupted it is always in
chunks of 64-bytes, which coincides with the cache block size on the
21264 processor. From manual inspection of the data, its clear that
the corrupted data is just memory content from other active processes
running DMA transfers from other drives/controllers.

The approach to fixing the above problems is to limit 32-bit PCI cards
from using DAC/monster window DMA on Tsunami based Alphas. This is
done by setting bus_dma_limit to 32 bits for devices that have no
64-bit memory BARs. There are examples of 64-bit PCI cards that only
have 32-bit memory BARs, like for example the QLogic ISP1080 and
IPS10160 SCSI controllers. These cards will be constrained to not use
DAC even if they are capable of doing so correctly on tsunami based
Alphas. I believe that this does not pose a problem since these cards
are not supported by any SRM firmware versions and hence rarely used
on Alpha.

In practice, I believe that there are very few 32-bit PCI cards that
are likely to be used on Alphas that have drivers which support 64-bit
DMA addressing. The only example I've found so far is the qla1280 driver.
but ISP1040 SCSI controllers are supported by most versions of SRM
firmware and is hence a fairly common controller on Alpha systems.

 arch/alpha/kernel/pci.c       | 25 +++++++++++++++++++++++++
 arch/alpha/kernel/pci_iommu.c | 18 ++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

-- 
2.49.0


