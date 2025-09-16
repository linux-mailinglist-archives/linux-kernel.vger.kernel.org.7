Return-Path: <linux-kernel+bounces-818303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85995B58F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77081892991
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3563D28152D;
	Tue, 16 Sep 2025 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDDBN0Ou"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E72272E56
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008932; cv=none; b=o73fpvCypQOSFHe/VCdyC0HBw6GcNMAkZ/d46H8zWojg+9rsdr2zRT1FCM478j3I1ONsK7tYS8AsAOqCFO43K8+7idp9PD/3u4JajQ573oI+Um2bAIFfISOjnwsswtVvLnjBP1WqXwvbtNUli6dd+omvkKvHUC4oZFSAMMu6Bjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008932; c=relaxed/simple;
	bh=EbxSoUUHARJ/26oz5qvy0rct4HOaMS6x3qf3UE5sAGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNRH31nBN5o+mWWQqJ3ynHxCFV3A4MczNTCZmwkB0cPUdSK7tfDHQ7qQiYsRgDMFk1OoEudHz/W0y/gPtl2lcxY9HWB2BY377enNsZhKTyxu79ci+QTycn6+ohtqrlhI6b3XhXQp1pP0G6TfB8o6RnOaXIyBGPO82ZpkPQrpkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDDBN0Ou; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso55631545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758008929; x=1758613729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=72mKaLpH8ZVeWabfEKgenc3kq6CKIlNYl8ZR1LugQjA=;
        b=TDDBN0OuzGB1/kuMKKjBN9M5+8Sykz6sDxOeayftXKGcWFXMl/jqls5Dx5BAB/C1rI
         WnS1HaqwYlP1x9SH0aR7BBkEerDo8mEhjOnKH506r2eeo/gtH0D9iphJCq+NX2aLs7VB
         MZv1fwf8brtx6eCQfOTd9WJ6Ms2b+bPm26oFKFcgEs3xjqwUM6hprX2sWWwYPkmPt6Bn
         XhUR4NGidwNyd0DmKEAnemMo5aCulwk6joE9J+i1yp6y+CeLlKG0XNVk5eX+auuqSFBm
         2ic/lr8/nZ0CcVs/+CZhNOK/qaP26BQ7iwJmVvo5jsfOc6sEgw0MWNXQxoM2eN+qVTOG
         w1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008929; x=1758613729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72mKaLpH8ZVeWabfEKgenc3kq6CKIlNYl8ZR1LugQjA=;
        b=rrgw6vr78YLT/TNmQ7DiXCPQ2kpliEu+cBlJwBob8SScSB7uqj9qgdYiwelh9XDMDS
         VgTDl+ttZaM8fMoLAGwjo615eaoO+jgxs9O0oj1UdW1xelcv9MywTxEAeKkVMnDVyv6Z
         7IBikmB71X443EvlIEGaYaNVU3mWPHvZQci4iczQk9HOZX/6LBj7sUclopIKOKyo+M4O
         4utm45AuTiZ7MAudzJeZtM6qp+eBa6QYs8eTeqUHcfpCWSc15oiX/gBbd8funf8klf0H
         sFj1gASwkxytZMfZzio3IAa+lNTmiF77TqBxUE/gvBONmT7zsRVmi1HtsNfBjnwja1Ze
         JV3A==
X-Forwarded-Encrypted: i=1; AJvYcCUlnmoUDhuzGKxa+flUuLz28bj53kKNwlhx5kV70BSyjNS640ZdViajesPpzQnUXDRkazHSkE9MwSUSGaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsBJhcZacdEK1s9XnLA+EiI06Qv16dCDj9Dh+3KL/HaQ5KsuZf
	G2OK5n4d75FGtsN2w3ZMwvQe1/WUyAVy8Y6X9Q/kBldDTm56xRyutxrcA57Fx/JZ/1AZGdSew2X
	ol7gD
X-Gm-Gg: ASbGncvm3tJdSRz6G9jRb0Xbf+iYtWirRZJetrDF48OMHfmeMafAZf7+J8K7aM/Zo2F
	fIV8g2asmVi16wCQ5ni2lSaF9+pwuTUmOcMC+avKgG3pil9Tlma0RzkEFYVV79sosImtqMxhEEc
	v3JM0fTN9xpVEJuAzQt3kxIa0zTeJdmjC/ebVKSK8HncGv983s26nDDugGHBO3xbbwlSqyDVat8
	zVmH5ei3+b45xXUqxjtfjoTP354T70RzSbq0VJ8kDuAAMz2ity7C8pfyK7HFhy4Z5yTt/hTt1MQ
	f8esH6wEauz88c2zJ/MFCUoVpLeSW01G2uV6DfGZRpuzG5ZZkMhMarA3sv7R66xPGjQR9saJRz6
	gA63W4R87GMlNyG1SbHRYu3Q=
X-Google-Smtp-Source: AGHT+IEL8i5Yw2VUOhkEwwUUdverukoVgo0AoLaHUFR9LPgOcR+nlygVIx1c77T1ysbBtnjWFKJgpw==
X-Received: by 2002:a05:600c:604b:b0:45b:73be:c707 with SMTP id 5b1f17b1804b1-45f211fad57mr85880805e9.22.1758008928887;
        Tue, 16 Sep 2025 00:48:48 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm103220935e9.0.2025.09.16.00.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:48:48 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Mike Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-clk@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.18
Date: Tue, 16 Sep 2025 10:48:28 +0300
Message-ID: <20250916074828.9677-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.18

for you to fetch changes up to 14be8b7b6cbc0a072c749e46e28d66e0ea6d0857:

  clk: imx95-blk-ctl: Save/restore registers when RPM routines are called (2025-09-12 17:28:29 +0300)

----------------------------------------------------------------
i.MX clock changes for 6.18

- Rework the i.MX95 BLK CTL driver to add the platform data to the
  state container.
- Retain the state of the i.MS95 BLK CTL registers through both
runtime and system suspend.

----------------------------------------------------------------
Laurentiu Palcu (2):
      clk: imx95-blk-ctl: Save platform data in imx95_blk_ctl structure
      clk: imx95-blk-ctl: Save/restore registers when RPM routines are called

 drivers/clk/imx/clk-imx95-blk-ctl.c | 57 ++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

