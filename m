Return-Path: <linux-kernel+bounces-858948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1EBBEC521
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463B7628618
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDD31A255C;
	Sat, 18 Oct 2025 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJoH37QW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E53146D45
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754024; cv=none; b=LIqQbxifPnpNCnVn7Z3BDNVYT4MOKD2y7Lu0hrzZDP5O9EszaJjkpB5NPl1iWqM8n3oL4waU6ImTzMHmcXHmMS9FTJvaUedPnsJxNVgJ5/aNNa0bebGZoGShZ+P4O6azFJRKCBtwpFZEa5+jpsD8ATjeDCqjp6u7GNLMOiqHpC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754024; c=relaxed/simple;
	bh=9PJ4KcysYW4YXjIPToJ2650aZOxXhoNlmKH3oNm/ewQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dGx/6LgcJ8nXY5g0gHHqoB753eoLzgeFa4wu3yiA4i+3tEyv066nB3OehYeCg0hJHAiJVgagrAdMV4O9miYZ0eWT0QX7Dtg3YmW6cLOJh6BjA4lNGNF6oWbi9o+GcqglvBI7yhXyQ8NNzb0GsJN0ZMRSOLlGI+cudCNtlB7sdj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJoH37QW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C4AC116B1
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760754023;
	bh=9PJ4KcysYW4YXjIPToJ2650aZOxXhoNlmKH3oNm/ewQ=;
	h=From:Date:Subject:To:Cc:From;
	b=FJoH37QWmlxBUvnQ4I9Wv7I7ovMCid/TW8GMCmRL+CBMDisSTscPVzVfZhESD2lNG
	 Be6pB4VRSM9oOn1FMOF6tV1lcGOOYiHZkE7TM32Qyls809tW8CpxZmEikQbyrsLou7
	 oKpJoZo9PFBiXG4ngjcudR6LcClC+xSBJcyoxj1rxHw5bM+QM/EigLgyiONQ7PD+fE
	 nM8b1eaAYqah1pI2oQBQPEbrO0RiqcBLkS9wMw4J30eRV9AYDgx9/uiqSTgQVfTuiS
	 1i8PZGE29WvP76jmvoIhJtbHYTapBgPc4QZmbudFYrkpBYvVKJPNQqOXN52ysqWGaz
	 FaP8UwERH0C4A==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b4aed12cea3so418567666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:20:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmSJVvL8mE+ifm54nSs5pSry11qQqHBdgRRMm5RqGde0/hB13ZrBnGq1WxC2pL1lJFkyqIyVIP35loJ/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/kuCmNWw7WTO27opPF8bU8E/ioSEvZNLQcGz40RZGvigy2XMK
	FwoBeoIPp61XFADkKkJwtyJlPj/jp6dbYzGrzI0q3oEeLq+DNHGn6lm4chAYg2rl4M/qzSusBcb
	yGL63yWH/6QzgD1hPyrn6Rn3DYQw/TV0=
X-Google-Smtp-Source: AGHT+IHRnvUjvditbiilLiQPRWnOUGwf3bA3tJUmQf5Z3B6YADqtnSi7E+Z56D6kpvYI8OMtep0Uohl71h77tRtS61U=
X-Received: by 2002:a05:6402:f07:b0:62f:3721:fc8c with SMTP id
 4fb4d7f45d1cf-63c1f6d49b7mr3619438a12.37.1760754022469; Fri, 17 Oct 2025
 19:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 18 Oct 2025 11:20:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8W+qcDYn+37=+ZcmAr0fDCiGHTyQjSWXeViPGCuQgb=Q@mail.gmail.com>
X-Gm-Features: AS18NWD7JYFfZRYViHcqF128zLQzin6NETPnDA19wVV1QTpeayFPQxOBMeyM2D0
Message-ID: <CAKYAXd8W+qcDYn+37=+ZcmAr0fDCiGHTyQjSWXeViPGCuQgb=Q@mail.gmail.com>
Subject: [GIT PULL] exfat fixes for 6.18-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat fixes pull request for v6.18-rc2. I add a description of
this pull request below. Please pull exfat with the following fixes.

Thanks!

The following changes since commit 9b332cece987ee1790b2ed4c989e28162fa47860:

  Merge tag 'nfsd-6.18-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux (2025-10-14
09:28:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.18-rc2

for you to fetch changes up to 2d8636119b92970ba135c3c4da87d24dbfdeb8ca:

  exfat: fix out-of-bounds in exfat_nls_to_ucs2() (2025-10-15 17:53:20 +0900)

----------------------------------------------------------------
Description for this pull request:
 - Fix out-of-bounds in FS_IOC_SETFSLABEL.
 - Add validation for stream entry valid size to prevent infinite loop.

----------------------------------------------------------------
Jaehun Gou (1):
      exfat: fix improper check of dentry.stream.valid_size

Jeongjun Park (1):
      exfat: fix out-of-bounds in exfat_nls_to_ucs2()

 fs/exfat/exfat_fs.h | 1 -
 fs/exfat/file.c     | 7 ++++---
 fs/exfat/namei.c    | 8 ++++++--
 fs/exfat/nls.c      | 3 ---
 4 files changed, 10 insertions(+), 9 deletions(-)

