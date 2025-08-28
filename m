Return-Path: <linux-kernel+bounces-790470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481ECB3A797
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E992C565FED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FFB334732;
	Thu, 28 Aug 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqJAJsdC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B842192FA;
	Thu, 28 Aug 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401412; cv=none; b=oTCLDUZXm522rTm+90TS52u4oznzmwB31s5awh7Ph9EBz4DQue/PUH10kT9y52n9ZrOC/DgUJFbjvskDEV2uQEf5TVzVlmSMbL04EhM8tGgmhL3DORvrC8EGcmGigmfL4Gy+xQAiLF22AG4cXgKrbKl7pgEou36SiXFWeK6iesQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401412; c=relaxed/simple;
	bh=ovsbqp3NMEVweN+CsPpCOuh7ZLk28Mh4tRydqyeYxIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qA61WoVDdHWJ0ac9t29YfV15PPngIHIxnpc8Vx62hWLcKOaDOUYw+osoOasaiAbg3+mO3qjyFcUKiNNXUm9Fh9epm0N+88BeAj8X0z7reWH5zg8NaSCJBrRQ5VXhge+Gl+SrQbpYWkjQJ9EBXWpH6SgM+rZGHfLvAAqjXc2YjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqJAJsdC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b55ed86b9so6854825e9.0;
        Thu, 28 Aug 2025 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756401409; x=1757006209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFLbqb99XY/4p3kGQ/FKtOO9I8ts9rQ7PGKFEyAjmE0=;
        b=VqJAJsdCRXmZyZxcUhH0kWfQmhyg4sOzd7uil+XfvR+kz5gnjsKIAVOkZcodqrcybc
         ik1rpWxg/fBgM6Qqhd+FPfoCfMRHylwSIcUC6hFWuZ6eRkCFEn8TYiRSE1rB84Dxnr6U
         dEB0ULp2JnZGmv3S9SqEG8NZfPgEBFu275gCIBE2KxGcxZdx2Ttbu64px4dui9OJGWXq
         Ab93UEm57LSFwUQWqEdMT85lXeXS6r189Zc5CRJriMi8lw7G9sV/mskIKV3mKGYeJ1Nx
         YpRN5u9We1FoiLU3kSPj6Cvsi8vJu2LQ1wWr50lEr3kH6u7UXqFy1zDml2bGYX5/u37m
         F/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756401409; x=1757006209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFLbqb99XY/4p3kGQ/FKtOO9I8ts9rQ7PGKFEyAjmE0=;
        b=ZWo34AMX3+PE5fYqlt3LjNoeQCXC8X+GUzPm5o1TxnzKv7/cevZiKwqTem+A+u6DOK
         StE5r3/wtbQQOygMTGY4U0Nw1cdFdTPpozQgPoD9EzYVwd6NpnQX5fOROPN3C04zHmzY
         RRsQxeiPVrhJMLnGzLzqvryIcinnZ4XTX49yt0u6bGZ7gtXrMfp2NmVy7LtK0dLsl+2A
         HC2/zXUU31bIGEe+TldcbUrfqVMZ8kR6HVySGBppu3bGO1mGrIOie9vZPDWYrUZfpZMz
         QAJ7h3XgR/gzFhAZdYzqGymPQf7mFrWUoeJFEralwKh7iwM+G613npCD5U8fd6YhLRYe
         LqdA==
X-Forwarded-Encrypted: i=1; AJvYcCW2b6moJ0nMiwOsjFUtw51UY7st38Sr/FNKsDr04N5LgkkT2iOdY9/h48Ga+HgFXjyn5ZtOOxr0SW5O@vger.kernel.org, AJvYcCXrlosVwAdEYGkWQgF1kEZFgC2cD5V2XeXeODERp0f3gFv5fan/JPMjbGKFkhXIgQG6Mz+kqOykhzs5nWy/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5z9DM6+EjLWiZc29WMbJ1WzTqSE0lAyp+VavlVkrPtN0A2xKi
	qc500jT5RmBXdcs7XCkDSXFjJ0LVtkgUcLpOYJ+TygnGmopOqGwOIAUL
X-Gm-Gg: ASbGncsydPGWc/Giz67hwl/mAEMZdIZLmGq4Bx/yHEmTANZlivW1KmDsjSyfLIFr9hz
	o76tEcZoJLI8N7tKkd/i4T+wpxHKXlwsX/VzhRCHev6FYIjNrRARcFrCTQ0pdzv5mIT+7slhqhC
	VWXDhsi9dkmVYV52ZqnguMHYKR5ccmvDZmXJAAiU1uhtAguc8S1DWqVb3kMHvtwHNfhOkfSRYKj
	XrJ5Oymk78w0TOG/EzKvRYSEgqbclqLauD/HZcYw+BfB8nlp6A5M3Tlt+iA97o50dx7vV0VdMMw
	yH/3rKtRjSqNdftCaUTXdsQi4DWIHj9OtoYXZUcBJBqwGIGHMpLKjFP+CMg1knFuwZOlKax1nJr
	OFBjSL1wglSclUU6rdPUarMaLpOO6YQ7/ctfz/YVntHclgGLS
X-Google-Smtp-Source: AGHT+IHf2zrhqkImFnC2Ql49KDCTShn9uK3ZVmRNtWFi3YICQvp5eHq+etZ8QeXQZIfouCJFRYZXPg==
X-Received: by 2002:a05:600c:4f12:b0:459:dde3:1a37 with SMTP id 5b1f17b1804b1-45b66343ea2mr95635395e9.25.1756401409276;
        Thu, 28 Aug 2025 10:16:49 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f30fe02sm80653665e9.18.2025.08.28.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:16:48 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: add USB3 on Beelink A1
Date: Thu, 28 Aug 2025 17:16:45 +0000
Message-Id: <20250828171645.3830437-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Enable USB3 for the Beelink A1 set-top box.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
index b276a29bdd85..632b0b22c52f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
@@ -381,6 +381,11 @@ &usb_host0_ehci {
 	status = "okay";
 };
 
+&usbdrd3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &vop {
 	status = "okay";
 };
-- 
2.34.1


