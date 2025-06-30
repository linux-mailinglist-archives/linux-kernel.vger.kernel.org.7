Return-Path: <linux-kernel+bounces-709397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A97EAEDD2A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 14:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C573BCA0D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D631728C845;
	Mon, 30 Jun 2025 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SUurTdlm"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460228C2BF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287055; cv=none; b=uH5x1273S7TNNTSaKKO5etfI+bPkqLZly19IaDfF58how/GyF3sWv92gViWMuCsNLHwYHEvPSifDaBwtgjGlbGQMcNwdTDScrWe3FTQSNJTRrhsVC06WQrClmUNji/gBOrEzOcbwmKp80Akt+y+Dt3leYqZMOv31T7AXQVDXFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287055; c=relaxed/simple;
	bh=qKH/Xx/gFP86G5ibgMZ3u7lxWPymmr9dQIqXb3a5NY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bz8GLKNND3qwq4YspZNLewVvKa5koFcV7F672XwOVpCb3rMepvBhL2tETV2bEfZHefgm5/i9WwB2IOo8/3YSXcNMmPG9yllJVe3g/d/45pAkL93n0bAZX5CBmrcl4to01ilgDryp50UVi4T/CZ5JbEQ3AFl0rsa9OPBA5o4GyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SUurTdlm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453749aef9eso15535815e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751287052; x=1751891852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tm+AP9yf/4s1zahGdn4RMNsFWWCbX0hdSX+OspH82js=;
        b=SUurTdlmaJjfBsFQaeHjC8gq7c/ln5p/jSHcl3ddJvdvbkjr9GOGGcqtBNlatEfpLf
         cVdIiD8fPmsT+9JG9EOUnqEYYvWdoL3V4Q9UVxYNgf+qb/uFXSCv0GdRFi3pDA6Ymxz3
         zbBdXKdF+8fOyI8Fbs+7qDlpulq91lqfLBkGD9Wu7skIySXmE2gHLTA0IcWWT/2wugAC
         h5U9xX65XXDhUser2WZWTB5kJPkDA+JPXbZAYmMk7C0vCBViUeL+RcyT8IZd7rKottQa
         MM2Zzf9f33YrS+EMZzbl1bRp0VL5hsm8d0pUatLNBBS97sf+vLVRt37HpkWH7C13C/aY
         OaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751287052; x=1751891852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm+AP9yf/4s1zahGdn4RMNsFWWCbX0hdSX+OspH82js=;
        b=m4ubP/u3gXfoCPNM+xaQSl2XJYwRXwIJhSSpKIl9KG8nkIfGFJNBhBwSAEIo6D82CX
         6iKSrDU1SVxUFeEMDpiiwQYr7Fw/bBlGkQXRYSYXW+Yb9z8usLJUVKZmtdWRZkmh3cDL
         j0kDRwwN+oGiVN5rvk6UKWvN6a/DasJpNdUPAQYEkE9hQ19VUWiKhIE1WEo54VbZwZ/d
         CdK79SroUGVSNIyiIni1aFBZNtXPlY4hpbMuZMkk/zTV5toTruboxl/PbX1JxKJBJ4Gz
         v4muuoKeszhWVUcpIxYXyu0mrGx1Z4z5lIFJUGJEvYhE5+um+7rqiMNeM3iPVAXuQmNa
         0FQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0foHKvSFNXH53S1sTZ6xQ4qN/YuEMgmGxCOFE38b+r8bB7IGUvkI8D7Qx+5QZTikJZjOT9nd2SYPWK0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNj5bDlg76+0sOxV9pUDgpLGF+12NCDnqAwF3MJzQc2mAZZon
	uR7lSWE+Ll8SjIsquLe5Eu9vf9ETgzGfGrUpshTfiC8JMhZ9x4BxuEX8NuqrGjA3xjo=
X-Gm-Gg: ASbGncvhwb8gv9xPIR/XsrC8cnZui3URLEo9dH82iHDKzDHJ4kMT0dKyJsZOJ+pzxQg
	KYbCqamK95eB1of5Kei5Mm7qwKJOT9o2WVydcxS1LR0QBdj3KhCVP5dtiDZuMQHNJ/xK41EhcNb
	jPWFkMcm3OMk2z664gln2mwqC41g+sDzcFqZtsx5zgHnFfC8foI5cpUXEt/bj+nQgZVVQPIzgUp
	+TR1DM6q7owSnAVtkrGIEnlVvNEmT0YqPDDV3tEddsKLNzQqHAhVaygci7WKPpbBh890Pr8TV/a
	Pi/zlOjlS7dRCbp6B5rGZh4NGhcsXN+xv8uNsL6EDT+mY9YV8zRa69YY
X-Google-Smtp-Source: AGHT+IEdVt31nj+P++csUDxqjuagbEh5ULVO4D3+RMjfhmemFzD9hX4NJb0J2PaR7MVDdJHgA5O3JA==
X-Received: by 2002:adf:e007:0:b0:3a4:f55a:4ae2 with SMTP id ffacd0b85a97d-3a9014bb92emr8982583f8f.50.1751287051637;
        Mon, 30 Jun 2025 05:37:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:19e3:6e9c:f7cd:ff6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa2a7sm10238192f8f.21.2025.06.30.05.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:37:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 30 Jun 2025 14:37:17 +0200
Subject: [PATCH v3 10/10] gpio: TODO: remove the task for the sysfs rework
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-gpio-sysfs-chip-export-v3-10-b997be9b7137@linaro.org>
References: <20250630-gpio-sysfs-chip-export-v3-0-b997be9b7137@linaro.org>
In-Reply-To: <20250630-gpio-sysfs-chip-export-v3-0-b997be9b7137@linaro.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Kent Gibson <warthog618@gmail.com>, 
 =?utf-8?q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, 
 Marek Vasut <marex@denx.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=F4uLYTcDjYHCQKRyv318429+cTJ5TfubDfqP7y0o1W8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoYoT/m2wkA9V8TfStoUWd68mbhltDznQO6A7er
 E4fseJxa4WJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGKE/wAKCRARpy6gFHHX
 cuhPD/kB83m2s6pNRR1PsJWHQ9BqzEv0Ac0JcnFNcB1PlAZu0GRcIUZDdLUGlnysVsl7FbMu0fQ
 hNG0m4AVpLj4DTxL3NuQy7zp26fhyGPXV9EbF9Ix1uzwPLJttB61ZAM55UdWXQDtpx0i6s0CZak
 9oXDOblTPkTC0EtGrIjEfFIPfvXSHzYypAMntPcG6HzbCCPqzR+h+IxYaGDI/espshbADclK0Sx
 Wy5sSj+n6Nx91MbrYS9hTKaszydfbqZmiBbUr+G+N20pKt28OJJWrKQvaRxH20Kzcf99wPNC5zM
 jRLKoGyu9vAB8+N6axUml+ofIvCgRoHxfZ71gICWRIWlcE5qIr3rAy3XJrXMTqVmJe0t/fxhcop
 iUbEHXExcAVvxVrAJ9KZOEEt921L2KOI6iVbsWlEaydpvSLrdAt7KXZvsi0AtHcH03sNJfIjL2J
 2qwXCiacm9+JYAjjlhjqyZQEL1qKdhKexSQliR1EeNHmPI5yzADHPFIzdylG8ZIrvj9uW8fKHk1
 B5pS+l61XXQeSs5JcDVKooqff5RvfT96onwX/dsILpkHybdjajWuJsLxSV55zj3sCjwbwQkGMFm
 DayRQO/XObUexmv2r4AHgJrH+C2SI9P2pTEbpvPDQP2LfRwUZccJ1VEn6OLbXH4OJuqL8e8JujV
 4790VcjfuWcyy1A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Remove the completed task tracking the rework of the sysfs interface.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/TODO | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index ef53892cb44d7c01d100f10f1b805c0aca561b46..a6380e51699cc5704aebefbda906762fa60cfef3 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -188,19 +188,6 @@ remove the old ones and finally rename the new ones back to the old names.
 
 -------------------------------------------------------------------------------
 
-Extend the sysfs ABI to allow exporting lines by their HW offsets
-
-The need to support the sysfs GPIO class is one of the main obstacles to
-removing the global GPIO numberspace from the kernel. In order to wean users
-off using global numbers from user-space, extend the existing interface with
-new per-gpiochip export/unexport attributes that allow to refer to GPIOs using
-their hardware offsets within the chip.
-
-Encourage users to switch to using them and eventually remove the existing
-global export/unexport attribues.
-
--------------------------------------------------------------------------------
-
 Remove GPIOD_FLAGS_BIT_NONEXCLUSIVE
 
 GPIOs in the linux kernel are meant to be an exclusive resource. This means

-- 
2.48.1


