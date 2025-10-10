Return-Path: <linux-kernel+bounces-848272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3C1BCD26C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 267934FDDA7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4922F548E;
	Fri, 10 Oct 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mc5AE4zw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AECB2F5482
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102347; cv=none; b=LSmYJZXSGSnmN/TzM4Xmqa0moh6T1WM2lhNS+zvasH5JF3YaPKkXHGf+p1UyumXGY0COVTcBezbCHU9G7sc9HgAU9Wqf35dejMZH/d5j1u0AMNs0SCab1PqIxKk89GyMoZ3VZ9olTj/SJF+OOMTktjpsvXDGZKNXYNW1MPLUCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102347; c=relaxed/simple;
	bh=3vxa0bIhWKzpLUrAlTprZcKO9BcLIggp1N4gz1sNzPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MG37fESrpSmjxXPhtRhzfEjdfBgvFQj9Lf5zK8KTXC2IxCdxj7ci9XXwFJpw4wKg1Unl67oZtM/wvgRWwwdWnLwoasyD8dI1DyLE+NoTjbCn/FO5p/xS2e54rd60m3of3DswVCOPTJsxwaXzgGzmdFthUE6vKJ2NCjlfRJVzSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mc5AE4zw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso12269735e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760102344; x=1760707144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eESySdgcY9v9ra8tdnwU8gzCn2jOOBOg4UBQNbKN7Mw=;
        b=mc5AE4zw9Wmf8kTnMET+cFB400XOkmtDA1x7XJ7sMWyc95I25Uw6P8bq3JcXSk9KKn
         ERR52FlKImmmAOgB+Uz+vtgw/TvnRYvl8xHJ/1Ls8WIcWTXPLogl53kUAK9rXVfZWKVO
         4hCNGWwY1wdCbAneRsQNHw7sLedDFuk5PEoco+iUu0IbtUvPf6aWtpkCapLFnK+Fk5mf
         MDivV+On1jhkRKywZBrKWr4u/pTawJ3LlgAo573lv5bDgGICnfaxPcpQYnSlmjvgD+hT
         H8LUOM4+dRN/MV+YHZTvYy9X09wfVCylSic/kKsuSRtZxU4EaTUZ4731p9ud6fG+8qIl
         SgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760102344; x=1760707144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eESySdgcY9v9ra8tdnwU8gzCn2jOOBOg4UBQNbKN7Mw=;
        b=P60uTPpke4/v5AOajXLpdMqekSC3UDZobcHd77kxNwbse3MacCSebrZ9UAoWIzax90
         yCzNxeHWUf/of0it0rmtHWrIZd9yOdU7MEjIIzaImUk1gPBpZHdkl3SYijqyAIW3BRje
         FZ4dYbtimx7RjfQitIs5/Ezl9lAj9VSscYiII+VI6QXFz+bvr0WkH/eH2NdGFoMh9ktO
         J+pWswYdEZFEvffdF8nAUsh9SnSNm/FQAVG56JuthnWQaCFAfEtcwt9uOKMytrMT5U5U
         nFXb9mimZzOxtzrN5he7W+3XkET1cQUrArWaxkm2X08oo+0U5/VrCAeDyR01Qor9o6Jp
         aMbw==
X-Forwarded-Encrypted: i=1; AJvYcCVkqeFMROKVzprHJdL0TBBkMNkJVOxGzg/kiAlL956ndGvh5XR3FZM04WT5C2GGPlmImLAZIok2rJDtJk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1ZEO+7LDPSvbOy5l9xifa3S8KfZ6uDo4uiXfHIOnnOVGmCb5
	rx9VaEz6JgFRIaeccABMmlQ9XjfBjMeAFlbgx0kkcR+5GFPXdR06kMXNOt3/T2wYpL0=
X-Gm-Gg: ASbGncvnJv46e/F3VvB/ZsnasocRbNd17go0e6CCAcGg/wxQw+80dpF4v51R1JkbKA3
	I7AU2WT9/FsB+VTTLj+BpGnZykEAiw+KBxZVzOvs0s0RGsN6qp8tRF4ZtFUPnowZG+vGvOSKFen
	QwD/Do2D7nU+eYuxCuol6/u+sqg6H5R4MJCgA6RquyOgsmGCN0sq/h538oiJELyC3ZmwtlMzhln
	qMIHmDaMvOEhqO4qCw3YMWZ0GYLk7x52Acnggoi9K0883IemRNe7FIzdBESUgKmcZGqtVscbIuV
	5vd4kmD+AqWiGUKvY4gghC2n55kfT9nhzFy0faeYPh+2K4EnuDH5YH3Txu1qhT4RgPhmbD8y+YL
	ftUmZMmgCmVgLqZqCQyCBHeK0wjGhe1pm/1Mhfw7H
X-Google-Smtp-Source: AGHT+IFH5I37Yiesi8opgO7PE2x/yg0YnPIPS/K45ngR4nLlSYEBIuRjzlOfGz2UlUetHqtnqjPzSA==
X-Received: by 2002:a5d:5848:0:b0:3fa:2316:c32 with SMTP id ffacd0b85a97d-4266e8e44c9mr7182247f8f.57.1760102343168;
        Fri, 10 Oct 2025 06:19:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d1c1:43d4:ab99:c8a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8309sm4144798f8f.50.2025.10.10.06.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 06:19:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.18-rc1
Date: Fri, 10 Oct 2025 15:18:57 +0200
Message-ID: <20251010131857.26204-1-brgl@bgdev.pl>
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

Please pull the following GPIO driver fixes for the upcoming RC.

Thanks,
Bartosz

The following changes since commit ec714e371f22f716a04e6ecb2a24988c92b26911:

  Merge tag 'perf-tools-for-v6.18-1-2025-10-08' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools (2025-10-08 19:24:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.18-rc1

for you to fetch changes up to b5f8aa8d4bde0cf3e4595af5a536da337e5f1c78:

  gpio: wcd934x: mark the GPIO controller as sleeping (2025-10-10 09:37:19 +0200)

----------------------------------------------------------------
gpio fixes for v6.18-rc1

- add a missing ACPI ID for MTL-CVF devices in gpio-usbio
- mark the gpio-wcd934x controller as "sleeping" as it uses a mutex for
  locking internally

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: wcd934x: mark the GPIO controller as sleeping

Hans de Goede (1):
      gpio: usbio: Add ACPI device-id for MTL-CVF devices

 drivers/gpio/gpio-usbio.c   | 1 +
 drivers/gpio/gpio-wcd934x.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

