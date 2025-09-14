Return-Path: <linux-kernel+bounces-815433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A1B5642E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 03:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36288420895
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A87202F8E;
	Sun, 14 Sep 2025 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ8DDpY9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45E20296E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757812844; cv=none; b=KTUheHqTdUvZpc5BkdTadqaZAuV3cYO9nrgAMNm2Eo6BvbgelKJg8xnxl6Wd8L9f1WXmRgofS9QfNlU69J84E0PX7mzP09XJYHBESRKIS+c0jjQ7pTjlOC5B4XGXz+2ttwneEH+dY4iCndwdptQz6weAPshd4yY3IFPWtAei6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757812844; c=relaxed/simple;
	bh=FkpJKDeauvQC6Z9YoUkrAnt4nd1U5i8M0RF3HkbD/5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SY3cWK2wi9602Nczpl6ftTYlTMLjZfJfWRbyC/Cs55xyj+ezDvC8jvpcMrzAQM0hxJxeKm6TRFCecsb7Ci5TxpgwvfbkKawsQg+kY8utsAMyCrNc2XZOG1P0wu1k7O+rh5D0+WOQ/tHGh45taFZzAZYNtdg8WGVMkcmcKtJNmNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQ8DDpY9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2570bf6058aso41499495ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757812842; x=1758417642; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4i6bDVD5hwBYMgRX2DgkJN197oaGlVqOUQIQ1shHYA=;
        b=cQ8DDpY9uxGPQijczXBBI+U6dFECAFLl3wOSVrCebZTU4q89sOs/e6EPXsSS9IbJUd
         CDDaEE4Q8lB16fYfGRxX5WzeVzM/ijKaT8OMfrwHSlIxwfXGFB1238U1v1c/8pk/gG7+
         VQEOgsYbPmy+xMXf0iq1fqFFghq6Dp9MvAK6GJJgrZ+aePzTKE9jmbPEogCBoret8C3J
         liW6nJtsbDe6ved6ZDh2VL9pqwGTZ9wy0EZZC2cwYhJ1/PN3m8Cu7EwTVq1Ejt0CSRmK
         jhYAq+hIST3zGxn1h040wRZpLrbIcovm0U4v1ZoGYmdBtuYB96GuOWHiojM7Fx/FaOoJ
         vdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757812842; x=1758417642;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4i6bDVD5hwBYMgRX2DgkJN197oaGlVqOUQIQ1shHYA=;
        b=hWqTjFO5RV2FbfPeBty4UmQaxjGnlYadJB6lQPDg0khm7lyfRuBf7BgUz8socNH0tq
         hwICv3Cph4s5VuTr3ql0BEYVTNIOupSy/zjcLyZq+9zMTEFjVUglHQ4EK4bKw5dq7lGn
         NsIK0qSYLgcZraGIdUPg3qr/bN4g1pLqlq5H0ihvyzwujai94Enxr1MP15Q2OfOPgJS4
         D/Ex4lQ9A4Q7C6BxREMiNAkyfqc94ILvXTLKFHznTqzIxGN3KHB/Y4xeVjHzPaVwsbNL
         RBVh4IvWcLp92LbvQrHEx2qf0+XtAk2pP679MT3OUokwuZmFdEi2b0s5nJIdPWEyRGpa
         R3OA==
X-Gm-Message-State: AOJu0YxL0S+GJKGAbT7TL4MxHQEt2g88Lqm9N5w4B37yC8I0bRojqPGl
	g7A+yLlHCb/qoB+OhJW7FUlpd6bbu56FKhIeFfdzChPy4n5Q6p6jVLs8
X-Gm-Gg: ASbGncstlNRyR6vEbTyGHr8IBUnIQMu2LOD/Z3c4yLeo53PsG8ZRkojvqhrBZd5k/r8
	JeUkt96ZmjRDeOx1GJXIrrLHT0QnHF+TU5pQPEZwwPZTTI3zPRx6RETb7Zhqvo3be/VV4s/OJmT
	xQWGBuBz3EvQYJu5nsKIHpMjaEgsPVxWoIF3TyO2BwL4UtabnWrxWwLbQqFrZQFQYyitkK3YCGF
	8foKD28XgrxdZ9QU/Mqq/qG6FcBPAj31uBB+hW9rXoFnNTzB0NaSOY4BPUmsHA6hcFcDneR4Z+Z
	Eh41OtcwDhwREeSdHOMgYDSjlft5PnFVW0sjH5EVLW4dVgOw65+xNbr3k2favQZ5FrWtX7scPPa
	MS6pPkUogWZOtnrAdC9wEzPVPMpyTwAMD
X-Google-Smtp-Source: AGHT+IGpnDRI201c71fNLQkFyHJumgspF2T5sIyMovVhhCFRDsFqRg0trRxQAB31uKyVOuiBxMFVMw==
X-Received: by 2002:a17:903:2c6:b0:24b:bbf2:4791 with SMTP id d9443c01a7336-25d2646f828mr100742185ad.39.1757812842046;
        Sat, 13 Sep 2025 18:20:42 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:81bf:abc:6590:f690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a7a0sm89268285ad.89.2025.09.13.18.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 18:20:41 -0700 (PDT)
Date: Sat, 13 Sep 2025 18:20:39 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.17-rc5
Message-ID: <pr27r442uxseunxtnoko5fquveeb2qg7kxue7uht4marr45ais@ce4alsq7hatm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.17-rc5

to receive updates for the input subsystem. You will get:

- a quirk to i8042 for yet another TUXEDO laptop

- a fix to mtk-pmic-keys driver to properly handle MT6359

- a fix to iqs7222 driver to only enable proximity interrupt if it is
  mapper to a key or a switch event

- an update to xpad controller driver to recognize Flydigi Apex 5
  controller

- an update to maintainers file to drop bounding entry for Melfas touch
  controller.

Changelog:
---------

Antheas Kapenekakis (1):
      Input: xpad - add support for Flydigi Apex 5

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Pro Gen10 AMD to i8042 quirk table

Jeff LaBundy (1):
      Input: iqs7222 - avoid enabling unused interrupts

Julien Massot (1):
      Input: mtk-pmic-keys - MT6359 has a specific release irq

Krzysztof Kozlowski (1):
      MAINTAINERS: Input: Drop melfas-mip4 section

Diffstat:
--------

 MAINTAINERS                            |  7 -------
 drivers/input/joystick/xpad.c          |  2 ++
 drivers/input/keyboard/mtk-pmic-keys.c |  5 ++++-
 drivers/input/misc/iqs7222.c           |  3 +++
 drivers/input/serio/i8042-acpipnpio.h  | 14 ++++++++++++++
 5 files changed, 23 insertions(+), 8 deletions(-)

Thanks.


-- 
Dmitry

