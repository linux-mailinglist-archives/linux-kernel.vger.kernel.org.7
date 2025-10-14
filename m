Return-Path: <linux-kernel+bounces-851772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 609D8BD7374
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 743784E9A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867982F7AAD;
	Tue, 14 Oct 2025 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOPlwEpj"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A81D47B4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760414518; cv=none; b=FxWjg0tx5k7qQ8lkb7xAZZzFy1/pBNJmSUdp+7zP3tvUK/cksMatg+EfpegSllclhkL9PJd0ufLoO6XQeOcxrZ+JAn8LlGBQk4t3iqnPGSEpEbBBcJ9wambOey1Imh9d0CrNadelC6k+arW2f/40rOWWLzwZYDt9ssrS67JagyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760414518; c=relaxed/simple;
	bh=6rKEi5rVMoICrmlvGRwYms/LqfiAGgM+OUJeZoAy+hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TV58rTCfwdGLZDxq8yNuYC9joVzHupWqm2dGRHAnbr6ILwv69qgGDoX9dWhZdRzMJFi/XBqC+rYvRBF7rxAR9ER6umSykdG5BDq51OAj+UGL4n9Q1YtqsBNPOQccg7LJwtjdz9Y+g8+p4OYVk5PeYCQc3ElJtHofmHwX78mAy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOPlwEpj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-78125ed4052so5725002b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760414517; x=1761019317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsB0izycZm3OO4+5XE/3dmw7Fn4MStV5GzPqI2plKC8=;
        b=SOPlwEpjI4nGte158TcRP4ZAEKhHLaV0Ivnjt/7QcwyntDWzwWu9vZ9mTajkSWFiKL
         UCT1pIaqrH9cGKsdnY60PsMPTazeaBzgGGE5TrFRX0yyn9d72Jw76gUB/g7bQMzzTKTI
         zb5vpu7IraTdzfEo3I9pAXZTfC/SriJKvtuQszrL887ychpm8tJYV/x8qU3cRCWeZ+hK
         0cLgVwYN3LnUCIbgXQk+/1QMtSImT41xrFy4NbpSTjFbMbAqv/SgGL+54PHO8H7aAs7N
         JEm1daD0Wa1LoVY4+Orc69rPMEZKsLEyCjJPpDAVnPPBtqn2HsQXPyCnHb2RidBdCEg0
         h6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760414517; x=1761019317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsB0izycZm3OO4+5XE/3dmw7Fn4MStV5GzPqI2plKC8=;
        b=Nh1hQJ++rcExBBRLyCiAUzYcan4atjhWacL5uuHiYScoR3Y7lcZX9UZH8dBxoe50+b
         GXNBTVMoH/HwSWutZp+T7ej0IDt85KaJs5tsbMeM8R6pf8269HuloQMYTBNKUwOdD6zY
         xTk2+opuc/73QepIyVmck0eBQG8m5fzX7n6Dh07BHiMYolCALqfUli1iyBEgV6nHQ6Q7
         gZ8cnnmXgCwlddgyTXnG/gW3P5QTvOLKNW/RvMb2/aTkxnUKOOXZzhEPENmt6kgodqe9
         0Ird+6IRmHBoiuFXycu2op+VQRJeYBPiK8PHt6GsE+aC8/0X5xCGJ4zEY4GFbagqLCvc
         B3qA==
X-Forwarded-Encrypted: i=1; AJvYcCXktbMuFFCOKkar1t3n1Gnwj3Ysf9Mk3FnH5K/etxl8q+Y0YLGU2tIjJuat3vffvkDjgCIlSqux0oPem5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8JiJK1j2fClyhwAnL74K841BNdlwY4FE7qPxV8QOC2P8KbQB
	Karn+9e2DTuMHB7moGMyWT22QZU/jiIn1w6YTbGXu37SS+JNhX1lKZwk
X-Gm-Gg: ASbGncuPnHpec4td0+glOU2NC/04deWeBCzns0w8LDeF1xBjiYKPON9BquHk4KCzDKR
	guc/cdaKwT8FVG5lEfwQG1M7LGEWfHRAyqU1Gc1STPXBS/mEudLlctH0H2dt+PCi6/0yEE9KDpY
	fnTaVFBQ5vOJQRXPKyUEZceee5wpPgTZZKC1HT+gL3IMPwCU0OYPLKlQ7McPPS1LNvtw6cVx/dq
	suRBrnqNFnOpSeTFl6j/r/ZRNgYS7AcOelaRDlV/gyyjJ/3hhNPb4Tso6rzNa3ULUwQKF67+2jR
	T8t7tQ5sh3/0UTMbwvqnmeCuTq2taSsKGN+SyjKNQc5pTMGo5IzyAcwCEPuuTj6I6JoVUlXrlG6
	/SY7tV4IRkA9/gc3wP43Ic+6l/p0oE7K7MaVImMfVQ8ZxlbHULZIV
X-Google-Smtp-Source: AGHT+IFrtfF17eWlEmSsbrrCEoLlRLW+h84XvFQh9e46H8cF0iymlCZDGFzyK4npmcVJn/1/I4iB5w==
X-Received: by 2002:a05:6a00:2e13:b0:781:1771:c12c with SMTP id d2e1a72fcca58-7938269d8b7mr29748487b3a.0.1760414516006;
        Mon, 13 Oct 2025 21:01:56 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09a87asm13378751b3a.46.2025.10.13.21.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 21:01:55 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org,
	cryolitia@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	pierre-louis.bossart@linux.dev,
	quic_wcheng@quicinc.com,
	r772577952@gmail.com,
	syzkaller@googlegroups.com,
	tiwai@suse.com
Subject: [PATCH] ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card
Date: Tue, 14 Oct 2025 12:01:49 +0800
Message-Id: <20251014040149.1031348-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025101225-lisp-monkhood-af34@gregkh>
References: <2025101225-lisp-monkhood-af34@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Thanks for the guidance. You're right, the root cause of this issue is
that a USB audio device is created without a proper interface.

To fix this issue, I added a check for the NULL return value in
try_to_register_card() before calling usb_interface_claimed().
I have tested patch with the reproducer on the latest version (v6.18-rc1),
the issue was not triggered again.

Please let me know if any changes are needed.

Best regards,
Jiaming Zhang
---

In try_to_register_card(), the return value of usb_ifnum_to_if() is
passed directly to usb_interface_claimed() without a NULL check, which
will lead to a NULL pointer dereference when creating an invalid
USB audio device. Fix this by adding a check to ensure the interface
pointer is valid before passing it to usb_interface_claimed().

Reported-by: Jiaming Zhang <r772577952@gmail.com>
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 sound/usb/card.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 1d5a65eac933..270dad84d825 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -891,10 +891,16 @@ get_alias_quirk(struct usb_device *dev, unsigned int id)
  */
 static int try_to_register_card(struct snd_usb_audio *chip, int ifnum)
 {
+	struct usb_interface *iface;
+
 	if (check_delayed_register_option(chip) == ifnum ||
-	    chip->last_iface == ifnum ||
-	    usb_interface_claimed(usb_ifnum_to_if(chip->dev, chip->last_iface)))
+	    chip->last_iface == ifnum)
+		return snd_card_register(chip->card);
+
+	iface = usb_ifnum_to_if(chip->dev, chip->last_iface);
+	if (iface && usb_interface_claimed(iface))
 		return snd_card_register(chip->card);
+
 	return 0;
 }
 
-- 
2.34.1


