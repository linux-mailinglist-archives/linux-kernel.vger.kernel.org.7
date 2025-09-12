Return-Path: <linux-kernel+bounces-813688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D86B549B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909F97A4887
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA692E2EE7;
	Fri, 12 Sep 2025 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmlnEnDj"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BF2E0915
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672278; cv=none; b=IUPXfRcv/mI+GDYDFK50H36U1SHsVognLzS1WSHiRr933ebzeJKOuTqOHahGsRlKgrnqZqoy9g6skT4+7WzBKaTBfrS1ubTfC84JIyQQaEaBOR5ejaeIM9nPAZadGK8JqbtoUeehE16mL0pREnyPcBBjrBGdzeWjwjHJMESeIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672278; c=relaxed/simple;
	bh=vT8/LQIRmt2vHfU5/njcIHRp8dw/7DucV1ajqqMxloo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PyqHo0lJi9PM12unDhHLDigzJYbEDOHafNe6lR4Bie5ZiEsQxvpFGSnIq8Puo+uMtcqmL4Ks6IzdAvUEggHhvfQrdTtesGe9saQ0NpIPar4Geo72wE/MOQbHcUzIzgeoFfK0mv9SN2j+dEgghcEFRUTJaJ0SKTC7QKAipkJoeL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmlnEnDj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b043a33b060so256874566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757672275; x=1758277075; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTzuzrwSKIoy0QCORxUKogHZpcF/Bu7LDHHnirDhYR8=;
        b=kmlnEnDjoWS7T3DaP0Qv6MLMT2dY66m7gmQIyvYv3JOVB92lExrOlLBslVYhbfBhAz
         5qEsWXBw02pxC8snCg155jzimVVSHbM1xoydYgmbGp5oUUwa55YSfCktpXte93tiDLX7
         9PCev6gvov+6EG1YdSk9OMj6q4SlfLeiCfv5LmAxOYmJgz3+k1aOB9HFA3hJP2iNfXTy
         YXUasR8gmQzMmabdYg2ER06ZE4EIN0JojmMVx3f/TWXG33eionK3fXHEW7aqU6L0M2YG
         NZ77qoL0ZsPBO9WfIa/Cp6MvPLi3WBhRsLDXyWYk4kVgKMviNRQ4/4ZJv8EAi/N9i+Bm
         xkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672275; x=1758277075;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTzuzrwSKIoy0QCORxUKogHZpcF/Bu7LDHHnirDhYR8=;
        b=CtO42fma4eosN0NksQ5zqdeoSIgbCVO868P5HsMGNogUx/UA0qEbCS8nnOgoPSEXCp
         o9h9pwx0vZSB71t90q4Nwt4jhyZfBKni+qFdgieu3mMbMB4SHTBt432Dc3v3OpPAPZKX
         mB3j1udZ3v7p1d+yPHHkASAD7J8Ba/+07yMkKWkYMCEDCw0WVP3ZwIMFg4AHe3wrYixc
         qXfY2Qgrn/GAWbwVnPGvaLgibeuYQPH9ph554pmrj4Io88IEa4224DsL4UOWBnrEcrqZ
         o0lpbo3H72c25xOSY9Falxk6uo3zfo24mn2UgLIHRtX4n3MxA1f2ydFOv95JVdc8hagN
         N94Q==
X-Gm-Message-State: AOJu0Yyc5nJOVQDGc82o9z0Ra6ifkZjAEw1JwqU4TZHyFdTJ3/GNNOts
	XxOoTpuK97bhunEWWwAU77sZDNihmVoDiHTl5aX/C5Qj9AHiClGZJhqY+LGhzTAPp/Q=
X-Gm-Gg: ASbGncuPtGB+0BoiT+Fa4wFO5jU1/B+DSU80g/WzYki0Q02FIz/rJCpO8owq3IABcys
	OR/jMYRDQm8HgzCVZkqjR54wUy37Y7BChPf8+5Wk7q757dFFb/8ijeKxDrCSb1baZC+OjToqgl1
	CZI+bjLRaGZT7hTwPGJRmQMW+1FwhRQISFFoA454QQskQIgfnXgp290Tb13r91+pweQ9zDQ8Zqo
	jeWYY/AyirU1+SCHUsTAwvBvHde+zhgh09Whc5fM+GuhfLX59etXH8qFwH58BBLE+iH64vsgtXO
	RQsnTPijdQ4MOPxPwhFoEunLHJGKu1YuOserPjaZm6iMxW5DjXkHzKzIusDHjZ0ZIv7i7n19V6X
	C3bcFZgXxibaeDZiJ2tuymGmpMz+D061mAKh1XPk0zNBRNZ9Flmc0ey3j67fbSRjWAV5KeJZZbs
	E=
X-Google-Smtp-Source: AGHT+IHFwPpvM0RAZ0u7rHWSik54d2YaYUorN19OUt5HDkQV06Xun9QOHOryJK4lnOZ1tS+U/f++PA==
X-Received: by 2002:a17:907:7fa0:b0:aff:17a2:629 with SMTP id a640c23a62f3a-b07c353eb39mr226343866b.3.1757672274881;
        Fri, 12 Sep 2025 03:17:54 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e4fesm343087566b.106.2025.09.12.03.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:17:54 -0700 (PDT)
Date: Fri, 12 Sep 2025 12:17:52 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: [GIT PULL] TEE protected DMA-bufs for v6.18
Message-ID: <20250912101752.GA1453408@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers,

Please pull this set of patches enabling protected DMA-bufs in the TEE
subsystem. There's a brief desciption in the tag below. All patches but
"dma-buf: dma-heap: export declared functions" are withing the TEE
subsystem. The dma-heap maintainer, Sumit Semwal, has acked the dma-heap
patch to be merged via my tree.

I believe I've addressed all comments from the reviews including providing
a demo as described in [1].

[1] https://lore.kernel.org/op-tee/20250911135007.1275833-1-jens.wiklander@linaro.org/

Thanks,
Jens

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-prot-dma-buf-for-v6.18

for you to fetch changes up to dbc2868b7b57fb4caa8e44a69e882dcf8e8d59bf:

  optee: smc abi: dynamic protected memory allocation (2025-09-11 11:22:43 +0200)

----------------------------------------------------------------
TEE protected DMA-bufs for v6.18

- Allocates protected DMA-bufs from a DMA-heap instantiated from the TEE
  subsystem.
- The DMA-heap uses a protected memory pool provided by the backend TEE
  driver, allowing it to choose how to allocate the protected physical
  memory.
- Three use-cases (Secure Video Playback, Trusted UI, and Secure Video
  Recording) have been identified so far to serve as examples of what
  can be expected.
- The use-cases have predefined DMA-heap names,
  "protected,secure-video", "protected,trusted-ui", and
  "protected,secure-video-record". The backend driver registers protected
  memory pools for the use-cases it supports.

----------------------------------------------------------------
Etienne Carriere (1):
      tee: new ioctl to a register tee_shm from a dmabuf file descriptor

Jens Wiklander (8):
      optee: sync secure world ABI headers
      dma-buf: dma-heap: export declared functions
      tee: implement protected DMA-heap
      tee: refactor params_from_user()
      tee: add tee_shm_alloc_dma_mem()
      optee: support protected memory allocation
      optee: FF-A: dynamic protected memory allocation
      optee: smc abi: dynamic protected memory allocation

 drivers/dma-buf/dma-heap.c        |   4 +
 drivers/tee/Kconfig               |   5 +
 drivers/tee/Makefile              |   1 +
 drivers/tee/optee/Kconfig         |   5 +
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/core.c          |   7 +
 drivers/tee/optee/ffa_abi.c       | 146 ++++++++++-
 drivers/tee/optee/optee_ffa.h     |  27 +-
 drivers/tee/optee/optee_msg.h     |  84 ++++++-
 drivers/tee/optee/optee_private.h |  15 +-
 drivers/tee/optee/optee_smc.h     |  37 ++-
 drivers/tee/optee/protmem.c       | 335 +++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 141 ++++++++++-
 drivers/tee/tee_core.c            | 158 +++++++++---
 drivers/tee/tee_heap.c            | 500 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/tee_private.h         |  14 ++
 drivers/tee/tee_shm.c             | 157 +++++++++++-
 include/linux/tee_core.h          |  59 +++++
 include/linux/tee_drv.h           |  10 +
 include/uapi/linux/tee.h          |  31 +++
 20 files changed, 1670 insertions(+), 67 deletions(-)
 create mode 100644 drivers/tee/optee/protmem.c
 create mode 100644 drivers/tee/tee_heap.c

