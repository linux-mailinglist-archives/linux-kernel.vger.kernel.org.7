Return-Path: <linux-kernel+bounces-805273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C7B4864A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7F63AE1CC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D22E8B8F;
	Mon,  8 Sep 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnJulFZY"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E22EAB65;
	Mon,  8 Sep 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318555; cv=none; b=pK7XLwwtMgn2CrMzvBfD0QVfKxF45bdYSoBAnqlBsT8V/CLzNA3RvvWELHRqAJHGeboDAvksod0w53kyfMUJHVhTkuwZZGFAUl5xua/mHfTS7p2QBABtA4PqyR5h84CwAmqnx4vlmwRrhuMkM4U7q9qf0mzuemQlpGjWD7ozoOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318555; c=relaxed/simple;
	bh=nNWpP6q+jPUM5vajZ7g4PK9iKb6/GN9lVTngws3MPV8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqPpIbzkvqT8SkL0qw/S7Shr60TOi1WS65PmljdU1PM+50sDSAI1TTsYULGj023GQ6dVCQ/ngCFU4tC1Uu0hTT9LjM9vfj0F/M96Xdeo0ls3v+nQQMKsVFPJ+clHTSAH3lQlJxTyFL1qG9WqHBWNyyE7YqUd5/g3v/h5bV7T/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnJulFZY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so5253349b3a.1;
        Mon, 08 Sep 2025 01:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757318552; x=1757923352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6xgaogVQKQX2VRV+ySbrwbZYS0YU53xZ1QdE3tIb0k=;
        b=TnJulFZYOwl0jJVTMmN3hEHrdzuQqYcR9gFemmtdK1iqVt5kyaYXlcsjfOk/70KHuO
         UzX1tpQ1cXj61/hI+OJI3/mC4rmbF2vj979wkH9nmVAq/HXZlohO5fZmQWqoeXmWW4Un
         FMkbvo0OX+EBC9BIpo+Bjkft/Nuo/m9/Ec/6gG6h8rDLMvLakhrMCfWI21yndAa4nLYK
         X+aBMesHeZ0cUNW3Bir7loXOkL1lOlx5sgxmfZbHtkDjgkg6QS+sK8y42N/ksdUB0W1s
         nlYs+jqvz0DWho4kiY1b5iMaWoqF2F/mpN7KfsWLB/AP32ddvibG/qm/lEqEOO3U5zQx
         FKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318552; x=1757923352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6xgaogVQKQX2VRV+ySbrwbZYS0YU53xZ1QdE3tIb0k=;
        b=himLL+KXmh2vc5VchJo/o98AfPTIfWWxX0k+OATglFfnNj7YWLuKmp6p6lGgi1Bktx
         O/rEfCHK0m5woEVVlGMABu+m28xeP4zhG2u+a0eqPxLMIzxlZr1/+V8abwQfYodeELME
         XC2TbACezpicnMTstXPe17RsDla6FutVCL20llHqAopXOnTLIO2SQkIQY2vdC+BkNM8e
         OjM1Tox8rwlsMB7G04poTU9USygWNzpifgQwWCOHMS7XKuTuUwugK8bWvj6RNUcMjPZ2
         k6YSDoc5CWuMHw1YVpGvaLi+GcDGWow8Xa8KanfRZCIA27mkr4e/44BbSDLNdaoE3sjs
         Ib7g==
X-Forwarded-Encrypted: i=1; AJvYcCV28/vXllR5yFWtvc+8wkRRkTHDrXwYbVSEk0/Z4h5Vm1w6U/ltDgNbYnUnSGhonVjHjG3COyAO9AXa0WH/@vger.kernel.org, AJvYcCXMFwEQ1wJTGW1l/NC4qY/TJzdTM4rxwywcts+pfgmn6+05W0v9ex3wwq4cz8njGIvKjee8jfQ+Ttf/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wF2WwPfRwBjrVi6nJBfud1Z35CgYFn1PJAaZJzLsWy+j5j60
	Rd+uY7mCQXDwpvI5Oqd4NLs+dT/W7OMYGyG8IeYpMc2aD0g6tz+5+Ecp
X-Gm-Gg: ASbGncuEaB5u93SsBAU1NORj00Hslo57CWuY7wOAZePeCnZ4JSNst+NRc7LmExF3/81
	9+kAn98XLCnmkZM93O9rgh/skPvy8N9AUmTTXYezMD7F38+coq9UApz4QXplPwmfHjAc1TuMgyz
	WRvUvovpIntM6PI79avDai2UaWl76TNDetWle3EM/geAP5/+Jbp/xmzOtKYZ9/xbJEUlEbrLAOo
	1kocO3kalDqukcwHYsESGml7ml/KtP7VkK9cA3/BKudZy6ZmjYvXnHZQUatLsmHwltBrDIWmjAq
	ZMqa2OPmvOxiEng2PyIlUFQbKxuu4MolT2lRxzcyKyGySGpagMhjs3ZyHEVnIVPzHdOzHDiM1yG
	17RfJKhoOfVcTRVV8ria/iqjd+yCLzMwdJ+f5UZTrqt1RIexPrDxTFwMYuFN7d08gMgGCWj5CO2
	D+spLnuKPqZ+KcbofWQ6Af+vhMseKNog1/EB8TTybds2lp3yqu6qTAjuckPBoHqdZ7Zb4=
X-Google-Smtp-Source: AGHT+IG/RzH8Pp7y0ft2xmHf4XmY2h/VHUbNeQ55YY0ob+wos3GdVYgnpsB9e0HRduW0lDHzKpD69A==
X-Received: by 2002:a05:6a00:2e11:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-7742dda40e5mr9781984b3a.8.1757318552056;
        Mon, 08 Sep 2025 01:02:32 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm15186600b3a.9.2025.09.08.01.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:02:31 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
Date: Mon,  8 Sep 2025 16:02:13 +0800
Message-ID: <20250908080220.698158-3-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
References: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the mctp-controller property and MCTP node to enable frontend NIC
management via PLDM over MCTP.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 2f5712e9ba9f..a453f8dc6b36 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1248,8 +1248,15 @@ temperature-sensor@49 {
 };
 
 &i2c11 {
+	multi-master;
+	mctp-controller;
 	status = "okay";
 
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
 	// OCP NIC TEMP
 	temperature-sensor@1f {
 		compatible = "ti,tmp421";
-- 
2.49.0


