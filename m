Return-Path: <linux-kernel+bounces-770423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4EB27A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535A87B350D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43FF246BB9;
	Fri, 15 Aug 2025 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stJr1OdS"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B923F43C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245303; cv=none; b=MBnDI/TEEecYmkogBDDcYSf/104aHz7xyI85av09IBBJyAcJ0P8wr/U5mJBY5EV3VGL6WW4lXLLDrnpsD31Hl9kiWg1cNqFcXJz+D1H8nJnrRUPVR+UoNMowDNvOTiiz1ZtrjoQ2jfiyAVXucObZ5QrxQr42GhHLrp++AXyNIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245303; c=relaxed/simple;
	bh=8A4TDN9tyEYv2858Q76tEWkh03e0+gd/EEe9+NAgsL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJ5hWutkin2OW0DAbmwkSYFDspVApqfZz4/l0yMbhBXt9F4jpKJ5hjn1B2F+tDWb6BDWeZ6o9f2UyNsC/IfLoy1NLXctRKYLTaAu/tu8llaPJmyX1ylxje/7OoDExm1HkrUel9/zjlj+vcZf2pVBo893RAVMY6HS1j62R8cdmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=stJr1OdS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ce5277b8eso1840738e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755245299; x=1755850099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BoUNg0NWnSD1ZMcCTQtaEQNN7qPQ5dP9cFU4cMtk98A=;
        b=stJr1OdSTTnVsuFpenyV9XRJPijuKibc5XwKBy6Ok/QPgPKoVtP3PHgTId9p8/JWiF
         EWjSeR6p6ALkHfeab17HtmJ8ZdvDn1tc8Q71vvNR6kBLLTsD8n5j57CXVn6ktGYrX2iv
         Ku0Tpsv8BiGzlCI0dmSggIKUWgSGhYiHtxC8getawUbAgTrozfam3q4FlQBA8E3CV5rK
         wFb6aq7ayF8I/5+a0UPIYqHyd7fAgh7rY0AwrOgjJW6LiVa8Nu8EXxnLT2lCLX09PEcZ
         zILgdIcBu7AUa48J6jZRv+ne9R9wneumyUS76qRkmHG3mNoCX1P6phMly3jr5jDSKjSE
         t2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755245299; x=1755850099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoUNg0NWnSD1ZMcCTQtaEQNN7qPQ5dP9cFU4cMtk98A=;
        b=H201GfFQeQVmU/CaTjFZG6sZzWaFbfYhI9Frp27DM5V8MoVND/xzjXne2U2PGQkA3v
         xZ3OQC0Yh8oGHiVOkkR4u6dRR8Mv4zixuBgCI3o6RJMG+wWnbxDEOJnxDJn1fDntdHNA
         azlS0pjaj6w46AMFEaI6V4g35T1aFKU8u8ZAFE36fNpH3vhhaCdKK2PBdOXKXTYpdC0L
         22+WeLDgVJC2pTKfiOty6/CVFfL5vZsrRTGaodj4fwLXRC0rEvhgGIP68XRGMQqcub7u
         sRiRKWKbvdQe7CRhOvX/R8fUeAZRogGdKTN9Q4HNNzbeSfsgerD3z2h4iWT2sjkXbL0T
         huGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcqDUOJ897Z7l9kF8+VvZMj3WDneJwxZn+APoiWoCHim6N6ldp7tIG/ucCi0bByV6Hgo1VU8g2tvSxAB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLn28URepVSV/ZMtaIGO2nS4NUHbWypgE4WAvtug+3r7sAPqCG
	h6m0uoBJekkAwUoHadwTaL2IGon9hYgNg8fBDXS3H4KKjJvNtHv56nBITgAKxkOZzYg=
X-Gm-Gg: ASbGncvNYweAmHjkNPahRhli+BLEFCKhF/g317F2EG9z/oJZjhWSgqAakBs83LHsybN
	fi/qWMKd5TcEnYrjm+op7GgiS0IXkTHWA++ETbMq6/6T8MGBFaPZ39X5cI1iuxlUHAcrxKo82+Z
	Y8uTSFZsGGYh9kcV7VS93UvfU3ynON0yi9RcZf5LcRojPSYEOzsFmL9k+9wUIqeLbUO2dVP/Jpw
	D6zqRcNNR8jWEzYxxaxqy+eRcah81JjulZFri/63ZMlqsoq7qH0W6VXvfsgx4X5pqO4Sds+49iw
	YiKoe3s3e1+QjgmmbpSzKyjbPSHwMWLW45zI0NxeAiQwIdgFfcl8sy/VVkjhq4NCZ+gjvFxAEq5
	EHmnm80AueVjSzbWHXEaK/aW1r/TxzNh7IbNNQMnSPxwv8DWP3Io4Ah2NbVV8Yql8evA1obol
X-Google-Smtp-Source: AGHT+IFt90Urrmo5HV1l7Yk3jJuUZrJK1egAUyTZX0v29li6VQluDLCOt3n47gyYnDJrd4tjNDr5Kw==
X-Received: by 2002:ac2:4bc5:0:b0:55c:af6c:db58 with SMTP id 2adb3069b0e04-55ceea048f6mr305717e87.8.1755245299163;
        Fri, 15 Aug 2025 01:08:19 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a645d21sm1925151fa.70.2025.08.15.01.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 01:08:18 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.17-rc2
Date: Fri, 15 Aug 2025 10:08:16 +0200
Message-ID: <20250815080816.282648-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a pmdomain fix intended for v6.17-rc2. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc1

for you to fetch changes up to b6bcbce3359619d05bf387d4f5cc3af63668dbaa:

  soc/tegra: pmc: Ensure power-domains are in a known state (2025-08-11 12:24:43 +0200)

----------------------------------------------------------------
pmdomain providers:
 - tegra: Ensure pmc power-domains are in a known state

----------------------------------------------------------------
Jon Hunter (1):
      soc/tegra: pmc: Ensure power-domains are in a known state

 drivers/soc/tegra/pmc.c | 51 ++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

