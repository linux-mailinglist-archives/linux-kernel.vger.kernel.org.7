Return-Path: <linux-kernel+bounces-880202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04932C25185
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 707F43510F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821C61E834B;
	Fri, 31 Oct 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHV9YMce"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8A31D75D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915054; cv=none; b=DV2hSWXEp8JTZhv/mB4gkkc6eVG2Q18gjKZkDgDAlowR3AyLWPrOA3CkfSyda4jZCxAdc2F7OZif/pKsDFYucOkc7HmnVtn+PKeSeWqKXgvQMe0BHB6d5wZhvAMJeIse0BEKq1l+Mg5kNamU32D+YDiPwRSisbDtMjs9HXlf3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915054; c=relaxed/simple;
	bh=H4Q6r6e/iHzGIp6iZre79NI2YVcV9IoFpqa7zETW6IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5u4vJDv5VQK7qR9g8Y4ywIvnMpQDMIXuTCp0/eYmrLS4E4KmXDQi6rsVEtYSgCvaZVt5cwueyfWLr4UPTmGJXGDptwihqp4Y5Iud82/NThKtLILYBAM2AF4+xm0k4bb4DhfpBCz8dg37CQWXqno6DlAGIhneWFF5gmUfXq6WCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHV9YMce; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429b85c3880so2067343f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761915050; x=1762519850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mO2KtY6kpP/4dstvJ2/nd3TfZivPb0AjpquB+Jg3MoM=;
        b=BHV9YMce+gUvO2KN/qVSwRKSx6igujwJBEcjDzPHChI6zaOGmCDOCTAxeveqyRX3LQ
         lK0MwDKtardXFzjL4Pu6BnMti4CusanSIRKCflyjh2YknAShySDdDM+dU60eULdOsj7J
         tm0AcxubAPScho0KBbctM19yaekE3jErpxdNLoQk65osh+769Mv+daRrwR1rWiOV/LEA
         fTNnhS1BXsTQ23BQuuoP19I14LGY6nrfVFEqqsQifjlwBCWhGfcFId6UBDDmV78yMkg8
         G9rFJ2Ot64OZDMloI4qo4nUccP17ljs3mdQrNFp59ZdwiSK+j+i0UEGfz8aFwWl8btFX
         DZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915050; x=1762519850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mO2KtY6kpP/4dstvJ2/nd3TfZivPb0AjpquB+Jg3MoM=;
        b=aiY6nazK3uQm9HoxQjAYqfzYzmI7RqC+jBTQvXo+9fqcMDG51txRFpH0KDg9Ckcml0
         FmGIZkrZlZpmx9B2A1Bczmq1yyZaXbcAe/zE+ASCAidRuCXuR40QdIY5sKx3KEDVKBGy
         SqhCLZt0ZDuM2k96K0hrqMAFDBJwLLxeVzg8NhyphBK73N6GQPmP/QS/Ou6N96ktRzmE
         cQhsLfBv1St5MAwIGhtNKY8PMIWFiVcf4ZA7WyOiQo4pWwQQ+5xqrVWmgFN6iUE752Bo
         bgNV+nsB1442hzsy2aKmJ/++SeDMxi1WRMgfGW+BRi07jyZ5ruknKzXTTtV5qf8x0Lzb
         g+kw==
X-Forwarded-Encrypted: i=1; AJvYcCWFNgzalOy2mc62+Xlmk+OPgjy02tkix0mFp4z2k5eEIRmespZonqrkzKBR3ZUBKvgCdLaBnhpDNej35h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymkU7QlihYg6stkLp8Fd6aNHr2loWdEV6mk2CG/v9WgwzExX3h
	0jGOqAySlBNVWF1CoLTOK7aPwvmGe8of5YIRbFuqB2WYHs1T2KWEIpjw
X-Gm-Gg: ASbGncvi5AE5BjBDJc5CF1ho4QjfyjqVM7SkI/chEcPIl8CWDupys4n50OydPFvcRsJ
	gOj6f2Wq6Fa6MHdYg5++NCMobKgvKQb73WaKKfG4lJfQX0S1kbRdrqzf+fa3cmz7koPREOTcTzr
	WxX/f4QEzMOBO96lvcGIG+OKpjZdeFFbYVzV0OArtYu71oz6/yl3osIrhACVxBid1Kcx39jdA3N
	+NN6awYiP+qUm82RyFx5NMCLvouvObfOpYNSDHnWr1loJq8w7WmVEmklVybNZ8eLDG3MRBy7j0o
	MuGNkEptx2yvafoHNiytNCx2cW2OhYVlT/hpFBtKf3I/BpjZokCI10SqM2wvvcR/W+OAiHAS+QZ
	x0Qq1xCiEiIUFzjm2DwmNqRO7iGiAAzFa9OILf/yaARXHzBikDv+0fQqieSyZFkFNhO1/q8TGur
	I3gyo0rgmS8ZX+NFo2v0moe89bb591YAqWIsWGkjTW+ztDTre2Q1IaYA7+48jN5P5z6f4TA9ZAU
	PKK8Q==
X-Google-Smtp-Source: AGHT+IF9Do9nR03BStcy/ENSw/8pRxFisHxazSviyoAjb3tK/ts2RifiuU7Em2HOcQoiNKmeoGdqBg==
X-Received: by 2002:a05:6000:2908:b0:429:8b47:2f35 with SMTP id ffacd0b85a97d-429bd689dc1mr3344895f8f.26.1761915049784;
        Fri, 31 Oct 2025 05:50:49 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f1d4csm3144559f8f.39.2025.10.31.05.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:50:49 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
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
Subject: [PATCH v1 0/3] arm64: dts: imx8x-colibri: add additional functionality
Date: Fri, 31 Oct 2025 13:49:40 +0100
Message-ID: <20251031125003.275033-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

Provide a pwm-backlight.
Provide the 32kHz Wi-Fi clock used during low-power operation.
Configure CMA from the device tree.


Max Krummenacher (1):
  arm64: dts: colibri-imx8x: Add wi-fi 32kHz clock

Philippe Schenker (2):
  arm64: dts: colibri-imx8x: Add backlight
  arm64: dts: colibri-imx8x: Add cma memory

 .../boot/dts/freescale/imx8x-colibri.dtsi     | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

-- 
2.42.0


