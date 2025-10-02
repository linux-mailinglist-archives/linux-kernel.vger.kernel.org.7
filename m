Return-Path: <linux-kernel+bounces-840058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77ABBB36F8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BC119C05E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B232F3609;
	Thu,  2 Oct 2025 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="Fg2B2T5M"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39CC3009D3
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396824; cv=none; b=XaOEfAwTcJr022Nnt/1De1knnqKSUotBgZElxJIe2mqeiTqXcZkrIzOmXtoRjJSswfP8ulpBJ8s44r+rNk7ryPDHlnOgCKHHmfmPNNOWSYEnTFb2egQnPmd/FxorsTuA2edT2p4CSyI/0WKh+bMEpMM6yZJ3BHvi0hqLZ310reE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396824; c=relaxed/simple;
	bh=gIPaH2DDPr2930UcEfosjH7vdWnt++jHkhnT6tAzaRM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BYU84F0TseI73GCdw35uv1KrmN5pWdsjvCYdlFIanWKda7yoC0oPPglJpR+PjHJBQ/oCTaYZi3FXUjHmPqpyhJQcAl3xtDzZI7R731TSKstGO5Jq1+MSZp7J1nWy8gTGPBuZa/FOO/+Du7G1PJ9GrI9pi063a0fD7FtXKMppf18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=Fg2B2T5M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e504975dbso4569215e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759396821; x=1760001621; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bj9Abm1mWzloyTs0H8611oSscu6f+O7YderAfm+LnKM=;
        b=Fg2B2T5MZnxn9HGySGlsq6qpSH8PPiS4NSlFDlRk+cOl8C9f35ilpGzPaocLm6f32t
         j+UE2t41P1X4aMmEQHF/+IG/ubgtfeDMYYikzHCJb/usjiBMk0FxYz/GuQKCYl6zcVGZ
         cRWxJMyEiIqBkQmRVBrKAhIi1vbavO3CFhOxd4ejHLgxBYHRPnET51KAxPlHvf81SLd1
         /7+I7QEC6vBQkuHMnsvVig4sFS7kP7yOV8WNTxnrFbw9RurDofoSR6Z06rJxfbAFt/6y
         frx6mLLKiTyKaau0qHTa2nUKsMaA3NQe7dU+rXcTWN5hdvCASZxfP5QrmTaBQNouV7la
         yoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396821; x=1760001621;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bj9Abm1mWzloyTs0H8611oSscu6f+O7YderAfm+LnKM=;
        b=Gt/IfFsOIwcqi8i2Ws2nY9Dq/MZ9cuuqtF/t9rESyBRT+L9j+szC3HtNsW6uMkZMGw
         uR01cYs3vNtJZMNTlLulgw7z59CkgcLXXfLvF+9lXbaKFSC+PwS9RGlXO0uA6LTURlRL
         DQ+YgyEDU2QKl4Ib4RlOUEFqk4PCDuS/bW4nDu5KL0fU5N1fc4FlehD3UsSOz5fDskD1
         8yYGA3PyjE+hTFPmpIU7MMAF3MWdnH5GfpY5XNkCo4x4jG+w96NyOIqUzTOrvSe/tGs2
         yNmgyKa/5I0Isnla0hELFzL0in4k0H/sEuAYR0pp1no8OY8Ur6oGtO8gv4TbDYjU4g8E
         9BlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6yUHRC66Ug40lq97EstFJ8unqHT9m1+IwISDrVlyrpR0Txpau3EQaSc/fVVre/hej06GhjQvei9KjuHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHrn0F6EfxIEWC5sr0U+dxl/5+Z6nqCVeiLMozEFPC2D972NSf
	q7K6P0n8FJrtz2HsibXpuLld9JeM0Jqi0dIRa7IReQhGZje/iCXJjzkIboZhEuLgv6E=
X-Gm-Gg: ASbGncv92yM3mksDPfBkW9nE02EFNkZ5ZTebseHJ7D+Wjsh8I9chnGtbMf44/9JY3Jx
	bkxG0AtHc2bWC6RXS4a3wY3WWMek7BaRUJI3lmDbYql4/zY/2VADoaSRT8Njq5kmKjezzBYqW4p
	y/4NoT0mCFqe4TMSSOLoVRG1OWhKumbaeyXzG7IGjNb4RE9HR1+2M5Gk2ZUbzEjLNibt7yLdxNq
	RxusNggTIq3M2uCwgjyj7FCw0TwiPytw7nlt1i4Twdk156U2Uvjm9zkpj184BJ7CjyLcDIUoV9h
	mxBCH6loJDVou5ki7yFyno7qJYz3gGcl/iiRfO5BxjN6rdFTrPNa8KCEpGYkN9hXPeWU6NYmEaf
	zZrgy249/w9l+1Xq0lZYqg88ndXCBnN1YMeqHfwzhtjy40UPZTi3ac8kTnTlo
X-Google-Smtp-Source: AGHT+IEscjxe8qX8+wcxvs4YKWYqZeRUzUgazCwsVmzKHp1vbho1fwFonw8ocJOeBXrMnKFrCWJp7A==
X-Received: by 2002:a05:600c:83ca:b0:46e:4912:d02a with SMTP id 5b1f17b1804b1-46e612c0f3fmr45077015e9.23.1759396821032;
        Thu, 02 Oct 2025 02:20:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a02:c7c:8a3e:8c00:3430:5fdd:d596:adae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6918bdebsm28958795e9.9.2025.10.02.02.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:20:20 -0700 (PDT)
From: Harrison Carter <hcarter@thegoodpenguin.co.uk>
Subject: [PATCH 0/2] dt-bindings: leds: Convert to DT Schema
Date: Thu, 02 Oct 2025 10:20:14 +0100
Message-Id: <20251002-ti-leds-to-dt-v1-0-1604ae333479@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM5D3mgC/x3MMQqAMAxA0auUzAY06KBXEQfbpBoQK20RQXp3i
 +Mb/n8hSVRJMJkXotyaNJwVXWPA7eu5CSpXA7U0tCP1mBUP4YQ5IGcU69j6wbMngtpcUbw+/29
 eSvkAJCic+F8AAAA=
X-Change-ID: 20250924-ti-leds-to-dt-ebcdbf5fdf22
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Harrison Carter <hcarter@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759396820; l=811;
 i=hcarter@thegoodpenguin.co.uk; s=20250904; h=from:subject:message-id;
 bh=gIPaH2DDPr2930UcEfosjH7vdWnt++jHkhnT6tAzaRM=;
 b=ijRptHzk3y8rIOFHY6uJGzszf1BVhbFIbDN3kLyr/S1OCA+3wibHk6MVQCqJTjLkvxTZniekk
 hJHWDxX2nQBD82A4cW7wohwAtPIlHlPFn5wjz5JSsoxTaZljuSYBiaj
X-Developer-Key: i=hcarter@thegoodpenguin.co.uk; a=ed25519;
 pk=xn5ghTMMWQniDtZih4xwKCTAaBHDozflTmqNKtaKo6s=

This patch series aims to update TI's lm3532, and lm3601x to DT 
Schema.

Signed-off-by: Harrison Carter <hcarter@thegoodpenguin.co.uk>
---
Harrison Carter (2):
      dt-bindings: leds: ti,lm3532: Convert to DT Schema
      dt-bindings: leds: ti,lm3601x: Convert to DT Schema

 .../devicetree/bindings/leds/leds-lm3532.txt       | 105 -------------
 .../devicetree/bindings/leds/leds-lm3601x.txt      |  51 ------
 .../devicetree/bindings/leds/ti,lm3532.yaml        | 172 +++++++++++++++++++++
 .../devicetree/bindings/leds/ti,lm3601x.yaml       | 100 ++++++++++++
 4 files changed, 272 insertions(+), 156 deletions(-)
---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250924-ti-leds-to-dt-ebcdbf5fdf22

Best regards,
-- 
Harrison Carter <hcarter@thegoodpenguin.co.uk>


