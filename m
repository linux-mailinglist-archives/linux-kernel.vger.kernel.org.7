Return-Path: <linux-kernel+bounces-802932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC4FB45888
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA495A4501F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098041C701F;
	Fri,  5 Sep 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EfWaZPkp"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0321C4609
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078031; cv=none; b=KvHroedicB7mK5xBz/cpzaiGuwoz1CB1dIK18lmFt8QD9uqitQ+0CG23zhtNlOMJ9ThF79//ort0435xCulb8ZvKQForiM0luEnOb38FZhLXPqlsCeG4qxYgZ2qSUcukuCJZAXZOeUaGLWB+1FEFT7pn4szLc/Ea2HQ9cUSV4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078031; c=relaxed/simple;
	bh=pc2WPgJcGLhrpFaKlsLQahXKA9chhCVy7k7/gF1Cbmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4SLh8hxjZZeAZcEoUiBo0WZ+UF3px2QdkZZY0t0Bi94UhCfojQ6SVE2CkDf4r6Nr5Ah1MbCZko2OTINiAKTfQfGySDqZJJfrsE8RSZ6jzDPD+Px0xNXieHgKLQRHxf90TY3eA8jiugR6FukpkFbuv/PjqWyMiBhiYy2pEAnZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EfWaZPkp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e2fdddd01dso177209f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757078027; x=1757682827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNWX8w7J5IcI97nXdwv0jKcOCYSaYB+ZFn87ka9R6Bg=;
        b=EfWaZPkpSH4KTQKoh8fclPWGVfQ6EgSnmc9J+smP62pADd4qdYbLZOhZ4AyoeABjyY
         U6stjICBkpDvN2XmrihPO5CSox9NALv/QhILpo7soII6xHQCMDXXjc0mfAsGVGCPQkpK
         WmLN8r2fpkRtKdgmN8N8LQ31E78eB7MucVdnNQw5Cjdatz0TXz2yy69MWUPK4/XnW3Kc
         h/aCxFEHlsznlrz2FfJ6iMj2bK4frl53jIHKoiJ0KvURpoTquiuvo5D3LXKAs1iJ0yFg
         IMPjBiOVfyPyfMdcdr9FlBDu6Hfowqf5ADA9o3+tJx1p1SflB0aH6j1IaXz4xfqUb2Ov
         8YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078027; x=1757682827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNWX8w7J5IcI97nXdwv0jKcOCYSaYB+ZFn87ka9R6Bg=;
        b=ufyvUqnL3z+FiBGY773mkmjllfOcaQXqjitrl3eXUeiTeUMY/dWhDeR6zOZ/TaHKnA
         YRXmpaCakswxmlnK8heTIkV0ZV6WygyboikaStkj9z7COAaiyHbTYb0kaGUJLOX3E2I4
         9JlmkZunJ65u+TfgO/xoUJP7zmIpZnlmjcqH9erNVuite+yX2NlifVLaZPP/Msy6Dd1x
         k5O1//Ovkh5lCWlpQhBNBmlhfNUp7fwYPMjfPoOYUgRb+zwFvanw42OocmW5xNECG8kZ
         XQUlUWFAfTA/0yxIZ3E+CRjKuiRGATxbD2UaMMxOXTT6zcUBt00ZpiWwqUDYyc+SyBt3
         zLKw==
X-Forwarded-Encrypted: i=1; AJvYcCWJzsOY3T3QxRNc/Ir+KXAKWMrup8lcAIUgz70oXTU+ohvl5EKnyd77fcT/84bv64QQjtO50mcoGQrOxqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvK7g70sPa2QUjF5qvMyPQq4Ou6Z/ARwLwpXbjmv76jPW06fzP
	96uhXhs7Z3j1isV0J/Ztr3AL2RfQGygUvM7VsU2oACKr3b3ZmZDzSG9kr+sYnDgSZ/0=
X-Gm-Gg: ASbGncsDNJxmIMJb+kgcMT+fpTRb9ZwJ5T+QMBEM67Qx8YtFeoZdt+V95VKBWZmgkSx
	bF2LXyLBEiuB+ElWIGJ7aEtg8I/TkcpPtiUZIqQQlE45fQWxZhG/8bFyEfKZDjpbipAa/p6ilKM
	RZOOwGHvDtzbJB+875je2AvtJvYlbx+RH+unN8KHLzUhkviHthwdnwbk908iomqnnUSoscihQA6
	ijpoMtcpeEOl6dN2a2Z9a/iRRPzn3G/M7KEYPiw76cwrwe4jHp1+JgVnpfrYCPF6f8oWoK0TUjZ
	DCxVJ6AmuMPRJTYEsBATZIbYkqhMa7DOz5WTQvWaUdMHNi0VXYo5fCraz5d8RcADkuipe8q8cyh
	WpyfJ2TN7NL9d7KCUMAIpazE=
X-Google-Smtp-Source: AGHT+IFFbThKQaUMn97luKJ5NYCELBoHvf5CkKM0PAFFCnugiFcAZ60cVT3FxKj4IggIaIVjsWVqcw==
X-Received: by 2002:a05:6000:18a8:b0:3d9:7021:fff0 with SMTP id ffacd0b85a97d-3d970220156mr11098273f8f.37.1757078027295;
        Fri, 05 Sep 2025 06:13:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:35ed:b892:eb7c:cc5f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b98e77231sm155189905e9.12.2025.09.05.06.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:13:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.17-rc5
Date: Fri,  5 Sep 2025 15:13:45 +0200
Message-ID: <20250905131345.105630-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of GPIO fixes for the next RC.

Thanks,
Bartosz

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.17-rc5

for you to fetch changes up to ed42d80f3bae89592fbb2ffaf8b6b2e720d53f6a:

  tools: gpio: remove the include directory on make clean (2025-09-04 16:29:28 +0200)

----------------------------------------------------------------
gpio fixes for v6.17-rc5

- fix GPIO submenu regression in Kconfig
- fix make clean under tools/gpio/

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: fix GPIO submenu in Kconfig

zhang jiao (1):
      tools: gpio: remove the include directory on make clean

 drivers/gpio/Kconfig | 6 +++---
 tools/gpio/Makefile  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

