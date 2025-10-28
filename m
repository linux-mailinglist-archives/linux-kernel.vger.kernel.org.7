Return-Path: <linux-kernel+bounces-873384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281AC13CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BDF24F43E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3DC303C8A;
	Tue, 28 Oct 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX332T8P"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409473016FC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643540; cv=none; b=LG5aJTrEr89DTYyh8GHH5jl6k+6m3nKwqxCFKo3D9n8xx0aYo53b5EIAHafADWGCkNbgrUmtLenTdm7o5dC/If498/g6v0HmHn0F4yyhFmdM5R0k0VQZQmJwZBOYcxaBRrybg5rTJ8rbd4jLMjwmv5ITZnUc4vXLSjSZAlGru+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643540; c=relaxed/simple;
	bh=/Iii+N1pB+IX8ozivJEIczKINrVHiSyEufjWtYoS9l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJ056369PC7n35FKDyV8Smfs+8A7U8sVI6g5VFONv8boOlMBWdp0euLsg5VWqmIdpd3mGmmjQvyqhB9mcSWcmKkRgERFhRuByy48JhLJbf6vBIbfAh+WL0/o++jnOMap2X9yyQhL0G13TUGMy+FaHxSfFZlQjQ+ylxkeHYNrT/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX332T8P; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3708030f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761643535; x=1762248335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eAEySv2XWlwHuqdOI9fzzrs359mLloz83GdyEXxt2mU=;
        b=gX332T8P5aM33tKcdtBbI+kbhYvc+VvpvHoy68n3pCyd1VQXx8CFjdOJX0fs3tyjMP
         I6DK9D7rxBevhg4tJTo83L/DtnoQGgqkJPXz031eq0WzlyRnYTDsOOoNZnv8AYIPgNTQ
         dWjKJsw5epuhjco3d1G1S+pIDmV/eBeZjk6gkIt5LTcdr15UcT9qQM6vSKnxuzR7nn+W
         ksFAj2hLeA+zVlUOOUN5e3vbxBkpCaf/BKNyt10oBfZiIRoXKih0oYcQvq5iJ61q31lD
         d6eKu/Y0feK4iK4grTBoBo8fWIVTjWJbbHgWarUHSZh5jZVG0C8h5ygC0SewEMKEIP9d
         l/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643535; x=1762248335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAEySv2XWlwHuqdOI9fzzrs359mLloz83GdyEXxt2mU=;
        b=IiSS7mNvLEUKCspHzbmgA/c0emOcfgq9KLQ8Y0IuwCiWhbagKp/V0rWcp0r/IiVXji
         SQGTA30JgjOZ8U/5tRC44xR0bXQOWN/w+mMydMAHEOY0/mhr/hwwWUJf9izapvgDgmmF
         d8hKPUCH9cenjGMPlSvIxJtyPYMER3DczldkYXh/qxVpJCDgODx5RppoEGUvMh5zPjJm
         gs8WXxfD2F4+zEDYG3uUcVWR9LxmfT75cIv8rzg+aDtk5vTb6O9pBMZ/NQZ1Mn16XJZn
         1Hrg7LUsUQMtnae7OrNF8v/ZI/zPO/iIET/1IdnxCdHeOa7Y7pY+OSJc5o2C2LuWpjnT
         dkQA==
X-Forwarded-Encrypted: i=1; AJvYcCUwh34wHOrhqdy5ExW57HqpvwwjUZNMgb4idm8CqfTjQWmRhbVGnuMLKziR2st5AzE97G9aPiBkEN4esVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBeuJq14CNlv54n6TiVK3JcQUv4nZQLLLyGZ7De1y41lxB50s
	MmYp8HQDOpX4poVWjgzMnoXBnB267ACp1p8tLwlPdo2PBWV2qBKMDRbn
X-Gm-Gg: ASbGncvaeHuRYKz2i2p7RKCh579A4LBqzvEU3hv1cmxBr1Ff/DgJjpyC2mUesq9BpQN
	HYgdcKhLAqBTg5CGk+YroMKFU+zgE05iZpwFLXiOREpYHDUCHWME0KTxw27AD+Y/Aturq+q6V/I
	cDY/ZY61ZWte6z+QU0MGJPG+PTbEEVzF40KE+qJhM/MJocfQx4TY+UmtBIJfJ42TlbtdQlE4/1u
	6xTIBH1jPhR3k/Zvlm01DuZADh8lti56ktp5YhkUanwxaF/7GryTF2sIJ66iLf858sh8hMKU+nZ
	J3D20yZkpNy/sECO1hZdnwC48u9Bfgxh0+PfQBcYRn7w2YDlWYeB8A/nXBUa6CIK3FBi7NO+I/j
	eR3NMQ8EjET3kH1uvF0QQYqP4qqzV1wg/RKnhTlHAcCtZPuVczM+wpE6lhWiMW5uVzNM=
X-Google-Smtp-Source: AGHT+IF3+1mOM9sG24twLPTOS4d6Ytk3inqVnLJlDJGYU4qNs2J8zRECxVSlGJ/pgP5nQ5QB1eWkjw==
X-Received: by 2002:a5d:5886:0:b0:428:3cff:3240 with SMTP id ffacd0b85a97d-429a7e36fccmr1692146f8f.1.1761643535448;
        Tue, 28 Oct 2025 02:25:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm19231079f8f.41.2025.10.28.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:25:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1 RESEND] ARM: tegra: add support for Xiaomi Mi Pad (A0101)
Date: Tue, 28 Oct 2025 11:25:25 +0200
Message-ID: <20251028092526.7349-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Mi Pad is a tablet computer based on Nvidia Tegra K1 SoC which
originally ran the Android operating system. The Mi Pad has a 7.9" IPS
display with 1536 x 2048 (324 ppi) resolution. 2 GB of RAM and 16/64 GB of
internal memory that can be supplemented with a microSDXC card giving up
to 128 GB of additional storage.

This patchset includes some schema changes not yet applied. They can be
found here:
- https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250909143432.121323-2-clamor95@gmail.com/
- https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250912065146.28059-2-clamor95@gmail.com/
- https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250912064253.26346-2-clamor95@gmail.com/

UPD: patchsets above were accepted

---
Changes in v2:
- added fuel gauge interrupt
- added CE gpio for charger
- removed always-on for vdd_gpu
- improved pinmux configuration
- added camera regulators
- removed usb@70090000 (already disabled in common tree)
- set correct modes for mmc devices
- removed thermistor thermal zone (not used by mocha)
- fixed pmc interrupt polarity (removed interrupt inverted prop)
- configured OTG support
- removed bluetooth reset-gpios
---

Svyatoslav Ryhel (1):
  ARM: tegra: add device-tree for Xiaomi Mi Pad (A0101)

 arch/arm/boot/dts/nvidia/Makefile             |    3 +-
 .../boot/dts/nvidia/tegra124-xiaomi-mocha.dts | 2790 +++++++++++++++++
 2 files changed, 2792 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/nvidia/tegra124-xiaomi-mocha.dts

-- 
2.48.1


