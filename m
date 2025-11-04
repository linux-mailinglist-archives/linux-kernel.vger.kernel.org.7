Return-Path: <linux-kernel+bounces-885560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14263C33532
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E73AB641
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16EC2DC323;
	Tue,  4 Nov 2025 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZrTTXPbJ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229C2D248B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297615; cv=none; b=UV8IWljQYt1c22VIexGU5IVeaqLK4+WHFM2+ZDJymrNOlJK77DVKVpOuFGcP9YKY/fEtXzQkom8c0DWKoRV9+Jy9hzOknGQOv2wvxTln2/7p2xJueSnzT5saPm+qgIonD3yH1rVUWkDn+DqoQVwZBYWF8pNwkacIb5/URbxWwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297615; c=relaxed/simple;
	bh=12vGFUcZemOMh5QBaAJfQHOdmFM8hY1UyGUKJ7JDXKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J2twhDkfz4mFN+kB6TvwsEksvitLpNJSFqLhquipxg222zxagTIUw4UH9W5FYcuiXkvDsadAP6KWOLZehlXPHUf1Gc4XxxEG201kSFYKw9W/2Sh6AnP1vNHqtUsuWAEBXKuiLOtDg1xtq0fhD0NCa8lWvIlTMho4bUfVJRNOikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZrTTXPbJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2953b321f99so44130445ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762297612; x=1762902412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rLeRaREaYFNIk98QRUcTfCmsFgqK+8yNycFcHOEqW8=;
        b=ZrTTXPbJ/uPRGAhHaD/bwiMG7sKuU0zhwATXvdgry+h6V0uJI75VDJbxn8St53ZfKi
         0nc2tSoHLXSV6Nffd7l+gMCEmtbgKrDml9aQJZZ/1tVaK7qrQOOTmAvEFqkWpwrHcSZF
         Ooso+7fwEkvyw60Icat7XGXDmhhJL9a1MhMG2Gcc0ATJw4Qfj5hW7tCxCv6vEP1/JjbU
         Szr23QIHqkVTDig+DAAIsEgoJMG3xRECwIUkqj/XgKmMrLmdI0sOTm7Pl7jNxGfmNa0X
         kA5wK1VgilHTgms6Pi+V++YKUEk5QIs4u9cFH11EGp9zAg6CDHhAzyibYA0HjVETQeIL
         17PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297612; x=1762902412;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rLeRaREaYFNIk98QRUcTfCmsFgqK+8yNycFcHOEqW8=;
        b=O1UrcxGV3yu00OEz7PdkFFuBt15VLB6LHPUXphm/F6d6FJ5KUAL/kvdZ7n0VT7N7aC
         uhzxLHnIFAQ9KjvHvdLSUU6BS660zbCjrBkdPgmsRCT94rwDhmohA/K/hWQ+Ttaa/G6r
         7/dSO8G8DtBB2ZRJxRkGAzHCmKmfpMFEK4eWZPyaE6Pab11xfnfFHLixMKcIx3Neiz7N
         HqnolTm7dUPLFDEq6OZApJH1VGaCNhiGxn2APzai4e7XbYZhUOs/wayF6GfVSEgU/+vG
         Z0EEfygPwYvZU6GD/AZ3oeh5nMeFRyV1P7Z2TZeLoLYbW1E7XJU6Usbm8i2zLBgJKESW
         o8aA==
X-Forwarded-Encrypted: i=1; AJvYcCUGPLBSfEJwx/am7z0JYfPPldBbySATJDPe1i9+qehbbAku19XJekAr3TuGJrRt+PDzFBgMPiHlytNBA9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4z4heAVsvp41Y+sUyBUKsGhYfHGIkZwM4FBGBkyFVXnGjxzOv
	RKQtNn7xNYTMpXTgUiAjuDM4zrNm4u2t2D5K7K40cG3IGsHZsVtCVHC79acSCGenmAw/DkYjXxX
	4mVjW
X-Gm-Gg: ASbGncvmfR5Fqdp/pNL549pFvu18wNpjWuMEDiAeFlCtcWGbC0JkeyX2xUmXDhAjDZy
	cvVFRrwO2lbc7kRBtyeuc5J6nP8T/A21eqFDvFo9uDfZZheaFEjlWEccO3I+w7CjoBNZbVW4amX
	4EhWhse+GVRmNnqlQ9z0cd1FOmu+Y6CX3bBNT16/UgwxDlblDErd2Z/PewUPVZchdT+MD7e9zCn
	Dq+6dUcJaFdkkG/STEj0fRddUZRyNFMG3LZKP3eHRgOMILVnNhjViRE19YmDxu/q9cXq4v5MG7b
	pzuk2xAQ5RBJ3gY44JL5MADyq92KGMa7u03u5lXg5VGXM8G8uDI2/ksHdFfsTvdQcARp4ECT4Rb
	QuL7SHXlN/PEE8dHFscUGK0dNgUbyuahoQUS2wHF29429OgcVqBuxXSfLI12SOUCJsAT+pf8vZs
	xhz8p7Tpe6
X-Google-Smtp-Source: AGHT+IEqAInSq7/OcKAz3KBjMGwdkltgrZQ5n2MVBtC0iSVzd8WVSTSxnKY4wAu8Z/1kBaGkPjKa7w==
X-Received: by 2002:a17:902:d2cf:b0:295:c2e8:dabd with SMTP id d9443c01a7336-2962ad3c9femr17882525ad.26.1762297612348;
        Tue, 04 Nov 2025 15:06:52 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a50e8fsm39573235ad.79.2025.11.04.15.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:06:51 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Tony Lindgren <tony@atomide.com>, 
 Bruno Thomsen <bruno.thomsen@gmail.com>, Judith Mendez <jm@ti.com>, 
 Arnd Bergmann <arnd@arndb.de>, Matti Vaittinen <mazziesaccount@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <63cef5c3643d359e8ec13366ca79377f12dd73b1.1759398641.git.geert+renesas@glider.be>
References: <63cef5c3643d359e8ec13366ca79377f12dd73b1.1759398641.git.geert+renesas@glider.be>
Subject: Re: [PATCH] ARM: dts: am33xx: Add missing serial console speed
Message-Id: <176229761135.2840692.14067519312360759831.b4-ty@baylibre.com>
Date: Tue, 04 Nov 2025 15:06:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183


On Thu, 02 Oct 2025 11:53:05 +0200, Geert Uytterhoeven wrote:
> Without a serial console speed specified in chosen/stdout-path in the
> DTB, the serial console uses the default speed of the serial driver,
> unless explicitly overridden in a legacy console= kernel command-line
> parameter.
> 
> After dropping "ti,omap3-uart" from the list of compatible values in DT,
> AM33xx serial ports can no longer be used with the legacy OMAP serial
> driver, but only with the OMAP-flavored 8250 serial driver (which is
> mutually-exclusive with the former).  However, replacing
> CONFIG_SERIAL_OMAP=y by CONFIG_SERIAL_8250_OMAP=y (with/without enabling
> CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP) may not be sufficient to restore
> serial console functionality: the legacy OMAP serial driver defaults to
> 115200 bps, while the 8250 serial driver defaults to 9600 bps, causing
> no visible output on the serial console when no appropriate console=
> kernel command-line parameter is specified.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: am33xx: Add missing serial console speed
      commit: 9c95fc710b0d05f797db9e26d56524efa74f8978

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


