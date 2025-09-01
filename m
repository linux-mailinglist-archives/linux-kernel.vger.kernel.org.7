Return-Path: <linux-kernel+bounces-795029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AF6B3EC01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D89A1761E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A36D2E6CD2;
	Mon,  1 Sep 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5c37bX7"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B832F771;
	Mon,  1 Sep 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743134; cv=none; b=B19xeXvAkADxgxW9HtFJl1aECyi403eSNL+soGGSz6frHTFoeH0JzccazOMed3ZG/PjBgWJhtHUO+XPGAS51OcbaMAVs1rO/FFmi4CHiEyxctKqC9SOAPKpn09tI5d5HxA4bymfXuC+W3+FHgY+NgJnSOHsYS6bmOq43h11f0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743134; c=relaxed/simple;
	bh=XefpToXI8faKU7bzWysiCjznkCZwcPNqHAt23kwJPbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K40hDzXVK3qRcqeLaYBUab9/mu+VBUIQlcUHLnHFNgvOToJeFSv+46RRN7cqrtPWhntG6arVljOWPPY7c7DzeL0xA6FZWdY2Nbc6nuCGyHFipacFPByktvYxAWh7aHiIP/qDDRNOnHTONFz4vBjaIkHWtwWeJDphf9dio/ARdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5c37bX7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso1245940e87.1;
        Mon, 01 Sep 2025 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756743130; x=1757347930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWJdOsASsTVaMoPyxLoTcgfSjvqU/yV2YgCFw0wJex0=;
        b=U5c37bX7YC3RSN9BAnH33/FQuZi/JPQY9mWDC4ye2+m/Mg1xwr2hrKdMUyz5U4Rsm+
         +1hN3sAgtYd8l39YBl1ZBwkY/OOFL9PrXRpTUIWdPRJxoTvn/W4FSvP3ESFzRmGcdYCA
         XGFF8mU1hIsmM5J3g5t7TFh7LmNsHigsCwIgP8tjjX1S68xgogyIXBQCoCe0dHtX2pns
         ZX8xi793JGojO7vSAKffZO9xwc5Wbj0nHohePdSsIrW1eXlDdrDzTmEaf9s85+9c8J0V
         XIOc/iDm96eXyirVkSLPxPgUX/1SE3njkSrUC39qn5DUudpDFYT6nWy7cghvp/ooGKFF
         b2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756743130; x=1757347930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWJdOsASsTVaMoPyxLoTcgfSjvqU/yV2YgCFw0wJex0=;
        b=T0zRTkmjErFazmLbOLGr1HPfyOWEHZjl8jf9bY8W/7qsrFTZ4RBoZ8590KCppyIRLR
         0fN3sVcpHUbUcmgAglyvkPdFKrVwM/e/qbTGJk5pC1Uyfr4vN6n9a2ooVzblRv5TTGq0
         6EaqWWNjM9AeO0JVStoFez7tljptkQTR8Y7NdO7ZpgEHOS9wRysM8K9ChYbQjQdteOzG
         /Pmjtc3FJmFavjg7d4LVHAFE7INkWLX6CBty3/6rwwjIO5qurkif1kVjrX9Kuwkl7Gok
         LIactad+liev1YX8XnFO4lf5swGeklVZB8o7eOJQ5MS8LEGSeUmtskJn2QDHQ48TPs0g
         Gdzg==
X-Forwarded-Encrypted: i=1; AJvYcCUDDy6+AAc+XGj7K9HP5hNo6YZW1F7RsZJr19TnX/WDWwtrXT3A+KmJgsQ2nPKolx5WPyzfcNjmHw==@vger.kernel.org, AJvYcCUmvVDhcaRTtXV6RFUYM7ROBFJ9qtapN511p22PfJA1Z5scbeX+ChmPS2J2aFeEqq/6TNSPf9JODFlzx4Wr@vger.kernel.org
X-Gm-Message-State: AOJu0YwavS29UvmTBWCxu9aBusSBimdmG5SBRsEiDOyMCiKOdlfE9QTP
	TB/zBaimI94Mj3S5E/S6Q2hzVM0xHAAtj7DepDbb1TCYQzSCDtM92cv7
X-Gm-Gg: ASbGncviSvMe/DGM187LY/JfRAM0DdHdowk4C52thn/Zq2wbB0Obt2rQWX6A+8xKIbj
	T3TuNF1lPAF99eqUm866QkiV2jTcPxsA5efjkRi8fjdcRuftfpW2g4Pgkbbsu5lf2BWjiEUhL3U
	/TfQEa1S3SdA4/3x/bOHwJ54lEfNEZAp553IHTeibMA4vkqogASHPaCu4/fjZErbMTQtpyvNlpC
	S/rosC/RCxIDveWI7uBvwfgknFNi5CQpWRlbIkcfdlSAoeOUkkaku2VwU9qB/ikpGLaShk/kGdc
	VLZ+EQJxLjb5sSqX+Qr/3nqeLQg6HOMMCuz1jfN1thpBasHqmJw9EGNECUh9HO1H7iAOEG4WmOM
	tMAHJOR6Wc+A991I1K9tKsqdAGWmyUO9a2owHvigz46tq4QlpB9z7
X-Google-Smtp-Source: AGHT+IFTWMLUEQtnoB7hpFoQRkFS5VMsX4Q/s8JYAXjx1U98mhPYfLJJdrhBQSzQ+nV2fqe4Mj4VVQ==
X-Received: by 2002:a05:6512:448e:b0:55c:e806:6508 with SMTP id 2adb3069b0e04-55f7092c3e0mr2292770e87.43.1756743129896;
        Mon, 01 Sep 2025 09:12:09 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([88.201.206.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f6771b237sm3028827e87.54.2025.09.01.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:12:09 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Artem Shimko <artyom.shimko@gmail.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firmware: arm_scmi: Minor cleanups and documentation fixes
Date: Mon,  1 Sep 2025 19:12:02 +0300
Message-ID: <20250901161207.2501078-1-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <y>
References: <y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers,

This small patch series addresses some minor issues found in the SCMI driver:

Patch 1 fixes alignment and indentation inconsistencies in two files:

Adjusts function parameter alignment in protocol_id_show()

Fixes debugfs call alignment in raw_mode.c for better readability

Patch 2 adds missing documentation for the xfer_lock spinlock that protects
access to xfer buffers and transfer allocation mechanism, making the code
more maintainable and easier to understand.

These are straightforward cleanups that don't change any functionality but
improve code quality and documentation.

Best regards,
Artem Shimko

Artem Shimko (2):
  firmware: arm_scmi: fix alignment in protocol_id_show and debugfs calls
  firmware: arm_scmi: add missing spinlock documentation

 drivers/firmware/arm_scmi/bus.c      | 2 +-
 drivers/firmware/arm_scmi/driver.c   | 1 +
 drivers/firmware/arm_scmi/raw_mode.c | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0


