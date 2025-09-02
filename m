Return-Path: <linux-kernel+bounces-795991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495FCB3FA65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188662C28A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532282EA74D;
	Tue,  2 Sep 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kZ4iS3eu"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381532EA73F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805405; cv=none; b=C7TgmggSRYS0i3SkQiVsDsEG3YD3Z3DcYsJ1JkznSCv3mjIaC6V5rkEO/L5lgran9ZBTxj4ALfdUNY3D5X/0azd6k9AR6/dNmkmsTebp8tMzSiTHmwMVQQA/h6OzuOg3sUbDUw5NWXrHqx2s48pcGj2HSXeLIoASlYkpM58Hg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805405; c=relaxed/simple;
	bh=5UTLFe9Na1x/q+MvJizjhdPCvRgJqWqRho5nedRZ7Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EccaBnxL3SlX55NHOcGeL3Omrhlyz8Ckd1NXP/SdRhQo8dPVg4HPwD9KcLQEpu2rxAGOK/G8Ve8Dp0PkxFXo3oy863EebsVNFiIorPaRK331Mdc+VrH/Mp25WWmOX9J+HXoFZXWdknxe820shi5DSIUyP6UBW9nPzDBRnkfJl6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kZ4iS3eu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d965477dc0so619930f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756805402; x=1757410202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=432khs7OCxGBblRoqEqWrfX2I6K5pnQLFbsVSHyt0Es=;
        b=kZ4iS3eu7DEWmb59PItVJ+I0lMf/Vb0iABIHfY5mOxbAu3Ay/MNDUd2oiGfxrAa7WN
         ZiTW0lzjDzTQlJU2Yc1xdgKWtfybjywinTDKeLS/2tkbRnRlm0kY846qUHXIFPQTc7wn
         JjIdwuxkPhOgsVY/RDxvI5ZRVq3vcwHeJIUz0yuiSrUyfRCTXwEH502wQBkOru+D+PWG
         6acGmh43b7Wq0y7hrHeIuvmhZjr3HCwuNN74BDuv/ItUsMiuFNKYJKP3aXpUEts+7C50
         euhHCNnChl/1o9YeUor3UZS3YDIfKIjXGngehUINRGaZ5LNvbnamvgU1GV37h0EGz2KF
         iRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805402; x=1757410202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=432khs7OCxGBblRoqEqWrfX2I6K5pnQLFbsVSHyt0Es=;
        b=IBZPtHbQEOSgPBLsZzdLISY2Cly5Gl29T2OXxmIvcdmw0yZSkOmQVJYAQESemrFBg+
         pyy5E2n7pKUmzRwGo8QTIClErA37fSrcc9wHDSc7GapDfI6hC5vC45DoY6EpXE2iFo4g
         T6IUideA98VtpeN0eKyxGDqNqRqLuY23K1Fs0koAPm64mRgD+0RkAG3raQPkZbErwq17
         H/Qx/hGiM8ZehWYAlQUURDhhqBynqdyGUmbK/F9O68I0aGbpXJolDgG/qqGmojShWPi0
         urnaFgLoUW9q+35cnb5+vz8J1x7m25d4eYYBmWVCW7WmRDVB8S74DBCTPD2Gk3tY7PvT
         xN0g==
X-Forwarded-Encrypted: i=1; AJvYcCV/PM6Zw4NlVxcUBuYnJbPHi7aVArXSMKllv1lRA6w7YweeEWdpKByCAgEzmDXAuGwOcvFfv/g2dDLCkRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5ZlFfBATBACvoncS5vHm4gI/x8wZ04MCAyc2HTbk2ToozivL
	0BIoM+1pKUumOTx0WX3GpJNrwL8lq27AwqZ97aJKUEeRLl4DvOwaXk9nL4n1XWmcMDs=
X-Gm-Gg: ASbGncvC6X0hwORJqReAQkZOmtlDTq4XQCmZqkp179Tt940SFcsfilvABeD0aOWki/W
	D5c+VClDw+q9Z8BFFsljuatBgzY3Ao8ug9y9eqLKXpMe9ksKegzh4rJqLFSYVhIGAFQqxCvG+UO
	VG/CkBAMRD10aQq69bRay8aIoEVMp6W2AwvQzP/WvHK5BxA7mGQyANzhBR+Un0IdAlsolosy2V4
	98+5ePwC0mV9ZOUxmuZNE/OFz/gFwrxTCbXcHlIFIWjOhkT8VMAGl3OURs7DGfiiWo3eaqKb/uU
	JUPRRayK01KYnow/Iu4QI0RUU7vwZg5LdAqM2Qewr0+LoFortRhDdWh8dsOW5M4jH4V+1JSeCtU
	s3PS0cCnjKwfVWRDbtxc76qFsdzwGlVBpTw==
X-Google-Smtp-Source: AGHT+IG42W61HHIDR/rDhaz/55c/dQ4iA+jW2ueIWFUoOBDEHqYDk9qKbuROvLVBex1Isp3Sw8cvVg==
X-Received: by 2002:a05:6000:2909:b0:3c9:4e1f:ef46 with SMTP id ffacd0b85a97d-3d1df349680mr8131402f8f.48.1756805402351;
        Tue, 02 Sep 2025 02:30:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3327:447f:34e9:44f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm19307310f8f.13.2025.09.02.02.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:30:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] gpio: fix GPIO submenu in Kconfig
Date: Tue,  2 Sep 2025 11:30:00 +0200
Message-ID: <175680539717.52527.14627198705710165881.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250901125513.108691-1-brgl@bgdev.pl>
References: <20250901125513.108691-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 01 Sep 2025 14:55:13 +0200, Bartosz Golaszewski wrote:
> Commit a86240a37d43 ("gpiolib: enable CONFIG_GPIOLIB_LEGACY even for
> !GPIOLIB") accidentally pulled all items from within the GPIOLIB submenu
> into the main driver menu. Put them back under the top-level GPIO entry.
> 
> 

Applied, thanks!

[1/1] gpio: fix GPIO submenu in Kconfig
      https://git.kernel.org/brgl/linux/c/ef9f21c3f370bcd45688a3a573b788e39b364e80

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

