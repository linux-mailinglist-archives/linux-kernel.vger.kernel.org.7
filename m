Return-Path: <linux-kernel+bounces-844175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1AEBC139C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B00A4E04E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4282DBF7C;
	Tue,  7 Oct 2025 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMXfIbdu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23419E7F9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836809; cv=none; b=eWByO24ikVJlfJF4+KczPBi6X1Tc3/qUwHU0K/2ayUeqeIcUu0TjEE/xsHSuNSBvEtcCEY68Xx69lq+pRdLRwnU27MSgu5dYGmHmoPDnGJ2r+0AAbdj2KHekIrNDcMq5O+XDzRi2gCKjSUZni1/+F1DHapqJxljUy+xD/rYtgIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836809; c=relaxed/simple;
	bh=RreNBgcHcd8C54RBRAXq1rSo4fvG1VkY8fYy6fi+J9k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ajY7iT5UGH9XXgEzEmYitNAMqLDaF/n2eXHmKaincTDkIARXUVyXieaC1rli6W1ptTGX4GuYwSwBeApGwPKoBEfZKru4o0dqIStXKrxGw10vaaKEWC1iMk0xIOEQBPeWzuTY2QyPncgbKqhYmSXK4thn+uAlib4+QV0ug98RCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMXfIbdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E9BC4CEF9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759836808;
	bh=RreNBgcHcd8C54RBRAXq1rSo4fvG1VkY8fYy6fi+J9k=;
	h=From:Date:Subject:To:Cc:From;
	b=WMXfIbduFN67EseDySexGpel0o2teqE2slzjIc5trVFWdWQ7HWlAmphPa3LGP6irV
	 mr6ktrYgN5X2tX85mb0Jxp3xv/E/usacJ8Turo0d0r3vsoQGHRIR8NeCCz8veONRKm
	 OeEYS5Ijr+j2qA4eTE33VEux612O/r3xzf1twBwDc9oV2Ekc1SAfZyYycJV22tYFxK
	 TxNuR86e1/1uJMzWyO6EP2KzNNxl+YWfUivVnUyVOt2IEAmzOts7NZ7tDncrn+tnrn
	 O10oRoSH5qrwe66gRio/6N9YdFJLu5OxzWdX7CphiBdP9lnKXArP5UKSmoImLmLtr4
	 7QrMBIr7VBEKg==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-43f802f8515so2987224b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:33:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY3NnlP4h2UCnqNle3n0vy+32wi6gpxbXeBF9ykWAY6PJPNdTLivB7Oz1uigbflbm+lamRZstz7ATV7I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTyONrmplHB77/Fyi6jBMrv38tUN0pvGwSRBx73hDO3pHXUm7q
	/32kMv1T/DZL3HrRdGYiLsYDglsIRC9cEev/9Yy5QdYdivuuTHTK64/YVo1EDRbQzwdhXCotQmE
	kFFfc7+pGqbAlKuv2C8TNHDtNjbwhFxU=
X-Google-Smtp-Source: AGHT+IGEK+FtvwNkqJhxOwWhJIYjn2fiu1tyne54MUIHP1qMNgp9WkOhRZm0r1jR/BASRLIQt8mD+Y6Yr1YWGHr+hnQ=
X-Received: by 2002:a05:6808:250f:b0:43b:7bbf:9a78 with SMTP id
 5614622812f47-43fc1888183mr7777788b6e.43.1759836807336; Tue, 07 Oct 2025
 04:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Oct 2025 13:33:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbqcV1GzM6AKzt0kob8ZzuDYRRVyXCEMqD9kL_4ZPNOw@mail.gmail.com>
X-Gm-Features: AS18NWBIg9wjHUkiw2sshfqd7FF__eIjEnw3ac1KUN_IjwRdPT1ECzvaHFX19Lg
Message-ID: <CAJZ5v0gbqcV1GzM6AKzt0kob8ZzuDYRRVyXCEMqD9kL_4ZPNOw@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.18-rc1-2

with top-most commit dea00c204e7e99aca9a4cb8603174c4cd0051728

 tools: lib: thermal: expose thermal_exit symbols

on top of commit f13ee7cc2dca5ebbd7f01e14d6c8db1caabd863b

 Merge tag 'thermal-6.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more thermal control updates for 6.18-rc1.

These fix RZ/G3E driver introduction fall-out (Geert Uytterhoeven) and
improve the compilation and installation of the thermal library for user
space (Emil Dahl Juhl and Sascha Hauer).

Thanks!


---------------

Emil Dahl Juhl (2):
      tools: lib: thermal: don't preserve owner in install
      tools: lib: thermal: expose thermal_exit symbols

Geert Uytterhoeven (1):
      thermal: renesas: Fix RZ/G3E fall-out

Sascha Hauer (1):
      tools: lib: thermal: use pkg-config to locate libnl3

---------------

 MAINTAINERS                      | 14 +++++++-------
 drivers/thermal/renesas/Kconfig  | 14 +++++++-------
 drivers/thermal/renesas/Makefile |  1 -
 tools/lib/thermal/Makefile       |  9 +++++++--
 tools/lib/thermal/libthermal.map |  5 ++++-
 5 files changed, 25 insertions(+), 18 deletions(-)

