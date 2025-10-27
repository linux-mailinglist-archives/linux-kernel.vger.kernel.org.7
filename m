Return-Path: <linux-kernel+bounces-871224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCECC0CA94
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CF2189A346
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85132652BD;
	Mon, 27 Oct 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR8i7B2f"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4542773EC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557547; cv=none; b=V38FXxwGBqWL5K1A6dvGUSlp1rK0d418NliUw2VG1ZhRU91lEREPG7MdlhuPtIq8J8W25vEhGgi0Qun/WfJ0OlEfsuW0kXnvOwHzuv6qLIpGmcSSRCKV58lxZBb4QLxihzzZehng5L7TmUyrTlVVDkHCxGyzOMP1dRBaUg3ZkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557547; c=relaxed/simple;
	bh=PwYvVZbDfnjUt+9q3Vs352SJkjyRc6eTPU+alUw/55k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owDkU+AYHsHZI29BzNZWX4fmdS/oamL3yoFhle+e9IJmqkMIJKtuKDxCU9eomy3F5GNBjksD20n0oomEI9uQZVYd/4uk+KIG/tJ26L4rWBoBJzAKq0T88stX+RPAsRQIfVgFLztWJfAmJi3Ojg07M65heaGZF6tOeDsqrkxB9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR8i7B2f; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso7976531a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761557544; x=1762162344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HFXNnIoPUffpq5LRnYNe5XZlozI/CQ/SXlZWm3Cx7lg=;
        b=ZR8i7B2fz72zXk7BGPY6Se5KUQGXiBPZ+UFCkqGj+02HV8HI9MvPn335Y3PjAbHC5d
         9DuO12LGk09owUr0Fx96x1R4dciqDEI+LVLy1plQWvexb1N08RWC/G8hkeKhXmUnHmvW
         EdjYrjX2UlFvVYDXT/uJgpEUhbGDEgmjJjHrDsNCdm8sjp8guZga/9fN2lA1MylXT1G2
         aIJYL58v2vicBaAQ0GooeU5zg5JEhq5wMMnNnux74SjNEPzDfp217UZ0T3JNcaELW9JY
         y0kx/HQ8ehe+y2qKwEwKuWFZz3gT6qD6tFjE/kpJ/mqYM6F15Bsg7f3dDT+5tlWRLPYl
         lgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557544; x=1762162344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFXNnIoPUffpq5LRnYNe5XZlozI/CQ/SXlZWm3Cx7lg=;
        b=rWo4WifP4MKafyZUR/MuFQqY7bx93tB3Ob1ED9b/hr/cawVdErDBEPKiTVWfXsPr/Y
         FVt+ehw7QyHR6EhQRKmNq0BkUx0LMnGhAiasSUTOoXg5zZA77FNMnS0EQ9gsLp/VcdsD
         pxvNP7aO4cHEDJPe4JgvfJ5lEr+b8Q7sDdUbYVK+ZONdPBOA6vrj5tl9rnOo1YHQCBdd
         ydOTaJRpVE28p+hci2/29KZa5NS3GL/yK7H5U8ptp7zEXj0OBfHWgPzEK8ANzWcl/qEp
         KaTQ2nJThCaP7gGAr/5mL5QqJdHicBMqTfdjzRFOqLjFra9FYat/KjCzO/zGr4V9M2hV
         xEjw==
X-Forwarded-Encrypted: i=1; AJvYcCWRQ3HEvR6dMlheG9hO2AFyawzR9/9AkEsCfiA/oPbrrq10DLiIrGegD/ZlIzMu8E1ruD2vR8XQtnCikH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiLL0XqBOkEjlrrVhYP8XDkxmdQldqI2P76IdYlU1KxAdFpy4
	IuLzoWReDMe45KzmYL4ntJ5/LdSs8LCectuyfPKIiNhtrqO5oQopvkLC
X-Gm-Gg: ASbGncvihwJjdL263zCcytEeeoOkTxLt7gD6VLHInnOrM6D5NaxSOrLWd08APi5+Dk2
	aRu8XAUEWQ5/JlJT7lwyU8NR6qOjbgEO1SHeqGeYx0HQeiYfz0ppvwW/qxVmxmMWvYuQjpnvFZs
	gnl1JoOIEw7T+XqgOUuVZQoevVX5cQ/LRdVKxr+sZqdUKEHJ7WuOUp0/t//b2jViIX8rkUI1YYQ
	n4NHuy6CcxI0/Je2INEc5fvdblFXUKAgmcf6s/yVhD3e02MyPm9juz4sVZqgt0fS8JDS38XNkWv
	1egbZt6gs80CwXLkO34m8PBAVMVUDUIm1u3g9sIPrsZJCIao8F3doVIbxT/2U8XNMmwW0CagvnD
	+5+GsILE9G2od+HisCKWKqpP1LkGsGRGCCcuYxUPUrFlGrG3dmEuDGH74cjbidAa00ctxHQf06v
	91u1O2I8kqd5PfObVDf4QAGoR1D1gie37JcD06ei8WkcF28FQPp47RgTdoeure+UWts10s/irKV
	yHUJjSIMrPjId96
X-Google-Smtp-Source: AGHT+IGfPIauWeOpslI13bmvAnHqIt73uiqSk5b04/1UOaUS+qZFr7MvAFxL/2NZS2hRKHY7Dz10qQ==
X-Received: by 2002:a05:6402:5206:b0:63c:1f3e:6462 with SMTP id 4fb4d7f45d1cf-63e3e479149mr13612800a12.23.1761557543459;
        Mon, 27 Oct 2025 02:32:23 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6be28sm5681014a12.2.2025.10.27.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:32:23 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] arm64: dts: imx8-apalis: add additional functionality
Date: Mon, 27 Oct 2025 10:30:06 +0100
Message-ID: <20251027093133.2344267-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

Cleanup the regulator used for the Wi-Fi module.
Improve ADC node by specifing the used reference volatage.
Add thermal nodes and cooling devices for the PMIC.
Cleanup TODOs no longer applicable.


Max Krummenacher (3):
  arm64: dts: imx8-apalis: cleanup todo
  arm64: dts: imx8-apalis: add thermal nodes
  arm64: dts: imx8-apalis: specify adc reference voltage regulator

Stefan Eichenberger (2):
  arm64: dts: imx8-apalis: rename wifi regulator
  arm64: dts: imx8-apalis: use startup-delay-us for wifi regulator

 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 44 ++++++++++++++-----
 .../dts/freescale/imx8qm-apalis-v1.1.dtsi     | 10 ++++-
 .../boot/dts/freescale/imx8qm-apalis.dtsi     |  2 -
 3 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.42.0


