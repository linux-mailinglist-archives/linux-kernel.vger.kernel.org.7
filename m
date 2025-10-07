Return-Path: <linux-kernel+bounces-844711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A48BC290D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6758619A1321
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F999239E97;
	Tue,  7 Oct 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="HSQ4TJX2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AA227EA7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867062; cv=none; b=A46uu7nlhxn626kjj4E6GOR+oMNBA5LZBeD/Iia6Djmer4S/cconQjkPCpA9mQqOtlm8Q5zBVWW+m632s6h1HkuwdKFZrE5rcXeqlg9PstnMuvBxSX4cZFs+T4IIhxDDGwKqXWP9mJKZaPbwgHNrxigwDplEo8iEvWhmWU1muIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867062; c=relaxed/simple;
	bh=LLFoPlsqXZ6cVvc1iROcimhAMsfDr/77J/uNnPt8xZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WG3jN+nSQTUYV8EwmwkB+0sZ7GW1lOcSMvQVeAetcL7lj8gUs6SxiuxCd5SMuBTp7ayr+3onb3dPMRoIa5aCEyMQ1NCSEsWeR3qfJcoUlq24oo7++ccKYYf9ChLb5yH+7o4VQc4Rbm88WXHWzkkd9jYoIH158q3jBv38NgwguCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=HSQ4TJX2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e504975dbso40640975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1759867059; x=1760471859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+qx4RaKoGovMIC4vNJLjFd56LfO6/L90wBU+eqHXZo=;
        b=HSQ4TJX2O6cUh8iVr48fLJla1S2tqFm7CmIPMdpNGlhD/n2+dwCduwU0krxVGbSId7
         egsF0AoPLJQ0AI77pkW+QURNoG+FeN61Hv2CPSvbljFly3d5Aomn6rqy/vvmlJRQHb/n
         9TDFodWMsAyu4sJ9CSDr5RZzpJOVApfVqfSj+c5ibvwWIOtyASFbaHmB5irUWxojZcPF
         iFfxB4NCx/a4ZuwmN0NU5lbFjI5iHA4qtbNZIystXl6aIRD90p/KF30Xb7A5E7g2OhN1
         pgdlem5jo/1Y5cuja6r1h0ITztyd7pfFFsDWr8eeU6/AiURybN7YfCiueYIhi4KfdiOg
         clQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759867059; x=1760471859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+qx4RaKoGovMIC4vNJLjFd56LfO6/L90wBU+eqHXZo=;
        b=dm+/Kb2SAVrIgu18mbLGUhpmLppGbws6W51NfV2CEpxhfdDAj0vCIwAPf8I0oQB2k2
         mG6nVSjRyvU5wHyunbiQn/UI1H1CCybXgaLk5nv9IrSOveBPrsj6aO8/j6Fww0UVSYRC
         phsC/ZDSZFHoAZNUBKRK9sibaqatgk+lgP3EvqRTFYt49SQ7OSU4o/K5P7OUKkqxWJnn
         wMee1L5JoIJH9gx3vM+8ft5Lp75kEZXuuWcZINRg8R8VLjnPfm9Q1UBt2zS8gALKLnC0
         lv0oY6RWo+dZjOqQBOxbkX2HTl0La8aEet6+tjjHyjz8H9nLL53normDDVRoA8wceIBP
         X6rw==
X-Forwarded-Encrypted: i=1; AJvYcCWR3zz/fpl3ajH8PfO4TjPy2+cTAfcMiAGplYgywXMb5LJYVdzL6cdPZdJz+lsdu0JwEYx+PlesZmGjLbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7WyTFWwlzcjx7NuJf0mTpSb6YmTLLaetscaCTJUdRGa/Rj0e
	onzqvaxgJJ5JNsuEVFqMsP5C/3BnYmqunQrBtCvFww2T7lESm5yZbZz5MyTz22qmFCk=
X-Gm-Gg: ASbGncu2iGOwGJcay8jEuUUpT9JsLt5AyoTwT4qu3eGmUlpcq/ceMzaBOkL5lE7O4ai
	9c3zsEOHV4eV7E+nvWR1WnlMx3wd2uYyrOn4QXTPeXo0PWqsJXKdfrfkCuZDJD0tLtUL8NjkRWH
	UzRA5mYBnG8UWy0EmZ2o5wKuZFO7uhiTxinWiVuatl2n8nWha/Al6IWQRaedz4hxKHVRFx8BqgC
	Vqa0LsAqLiXWivxccSJmiACANHZOe8rc1kx4ZIT1rftcDiqhaZW60deY2Plc3EgnXfXXxlL9hTS
	fn/hvl8cmGkTWeEaJTaPACQTv+9EF/lLVPXs0hsmHuDeFibZPeapNz99Iji7h/26n9y/SIgdji7
	Zlu9P2nCgQqujXbM/7ag29vSeTl3IypvFnyN58qKVtVkZRnvAah/3tw57fuuIp92G1nkfImWZPn
	k=
X-Google-Smtp-Source: AGHT+IG+/J0gFUNE9o2hpPt+WBbb/cdcTnJFI5jfr4VSMTfm5DuIbrq+63b/Wf83a/Mm/bMhowHzng==
X-Received: by 2002:a05:6000:4284:b0:3f9:1571:fe04 with SMTP id ffacd0b85a97d-4266e8de175mr353643f8f.48.1759867059042;
        Tue, 07 Oct 2025 12:57:39 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:bdb:8f55:60a1:c8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm26830896f8f.26.2025.10.07.12.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:57:38 -0700 (PDT)
From: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
To: jacopo.mondi@ideasonboard.com,
	hverkuil@xs4all.nl,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
Subject: [PATCH v6 0/2] Pinefeat cef168 lens control board driver
Date: Tue,  7 Oct 2025 20:57:30 +0100
Message-Id: <20251007195732.16436-1-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Pinefeat adapter, which interfaces
Canon EF and EF-S lenses to non-Canon camera bodies. The cef168 circuit
control board provides an I2C interface for electronic focus and aperture
control. The driver integrates with the V4L2 sub-device API.

For more information about the product, see:
https://github.com/pinefeat/cef168

Changes in v6:
 - removed "focus_range" custom control, instead modified the range of
   the standard "focus_absolute"

There were no changes in dt-bindings patch.

Link to v5: https://lore.kernel.org/all/20251005133228.62704-1-asmirnou@pinefeat.co.uk/

Patches:
  dt-bindings: Pinefeat cef168 lens control board
  media: i2c: Pinefeat cef168 lens control board driver

 .../bindings/media/i2c/pinefeat,cef168.yaml   |  47 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/media/i2c/Kconfig                     |   9 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/cef168.c                    | 317 ++++++++++++++++++
 include/uapi/linux/v4l2-controls.h            |   6 +
 7 files changed, 389 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
 create mode 100644 drivers/media/i2c/cef168.c


base-commit: 6093a688a07da07808f0122f9aa2a3eed250d853
-- 
2.34.1


