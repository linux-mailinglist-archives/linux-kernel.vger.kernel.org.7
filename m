Return-Path: <linux-kernel+bounces-817572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3C4B583F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBD716D981
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92D028A1ED;
	Mon, 15 Sep 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Erbuebtv"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D4283FD9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958604; cv=none; b=UwhG8i8cZOObKJhXK1ppyhggNm0/JWwW1HAGVY7Z5j9khXSJM9khw05N+kRI1FHQpjOQZ38pnLtCD5n63iciRfm3xMoRoUMPIlNmtlgrh/NnZ8/jiL/TtyJBjTsmnAjBwti+E9tX6eapbRY6DXYOvTAlF+O4p5J12xuEVn+5Tbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958604; c=relaxed/simple;
	bh=X63k7EEPfIbzkbijj+NF+KbsXIHwYBQ6N5O3W/nlNx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ik2eMrnUkGeox2SG3q5B3WdApLgF7OoRB10sfDuAqX8ItReUsh31hBfK2i1ExvXtcR9C2+Ff2w/OOaJrURiUZXc+WBE57ygg4Vexf4wgrLOXWrknwDcGOQqo6K8On4qr02FSyR0NLAVlcsnvG8FMZqlyGAqJEiPU6hkU8PK1Oe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Erbuebtv; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-337f6cdaf2cso32802831fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757958600; x=1758563400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nUoHh/QaA/cJemcuKzQ0L0kM7hvamnSwD+AbhFj55I=;
        b=Erbuebtv43qrC+jN+jXplZZot1c86bhEp7Hdhjsqhi6SorXs6v+G549FOoDuwxU456
         YZbrGL+Nk0/c2+gcnNWwMM/AWuYvOVLdP+WbgbyG9QaQ1Hp5nLio74FoTcWQ52yxfdQ0
         LqYfRqaC7jkPnh6plfbZcsClM9nZcMlq7MdEyDjk8W378XfAbOmp65CFgYT0sfDl+nbt
         xXpq2gRmWuxmCDcuUTwd3G8mKVbYgmXCRLK2JSuMJUlKUnNzV87ambphJrm8o5NViZMl
         YcFqazslml7doqBcsMUohxC7lpAioUgO3reQZr/5J6GkHACv7EYoCDak1uQhK4sVDtvJ
         F0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757958600; x=1758563400;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nUoHh/QaA/cJemcuKzQ0L0kM7hvamnSwD+AbhFj55I=;
        b=ATMd+2Xtm5Rvvon3fk436Ooyq0nY0z2OUkoZ9TaghTh6MP5R1DOhlP2InMaFNPQwcI
         ci7fJc7sySzOg4tNAFBvZgvzK2C6QHfknGu7hdjEJf0I9jJ/kTJkgiUP16s+hDuYr5b2
         Mm6pmTweR4M1J9LJC6BPNPWss/pv+eOYy4fdzocr7S3R1/5at2ya8fCYBfO4SFxvXGZU
         eUaF60ORM0b1kqwI5/iF5Fu2sP+KuNdOWOr2Y3H3mZ/vSB5e8Cyw6cnhDZ1wF/e2FBnk
         JW7YgWOyXxjuNGJnTp0eyesDynhObwcxlM55X5zAywEBn9M/n8r5gt9hXrXF//eWmdhh
         UD9Q==
X-Gm-Message-State: AOJu0YzOJYG+KepyhUUSVNH3wQOI/JeVm7SYKBqbPo+OFgQTydyEM6BY
	30PMVhpOiWdSunlz3hc0rJyJQmRei3MPbNW75UboQuoaoMVh72+RAYORiG6/Xih7k1nXUF6KTWp
	/CsVcwQw=
X-Gm-Gg: ASbGncvp+8Oy7Ye2r+y+eMJufGX+kBolKIKMSbWebxf7eN2PaXvvxRnYtKGdxs6H2VG
	qfsaN5cP7bnrmPVr4GyOmAYmzCFe27v1Ln7b7CdJtdo3X+2r5Yz4hViKnTHX5Wzc4+BdP2wCHR7
	TQOqxJlk/+FRATvHg3GfMh/i+WmN6cs5w6ZH4vSE/RJobVoeY1oKrY28+Sf5Ala9haf27xwz1A+
	D3K6RptC8+AlK9FKlBR7CJhsOS0L3JyTQKchaWfY8cEbQ/2ntGjkjh5lx/TR5bnz5xA9LTiP1Mu
	qAkrU+EQGw812w/ubd2UNJ43G7shRiwbAugObVpUViCgCAlXbaqKQXNJpzZc7W6G4ho97lC2Ip0
	SdvldHoPmxMWcaTMHoHfZfLC1co2TV2T1FNnvdf17kMgkhjNGQJWMNYcInVx2S15nRemJgVhCsD
	s=
X-Google-Smtp-Source: AGHT+IHXonlyJsEwptAZtH8gqbNV18Yqqkb2gFcaLd8EoBqiR9uHczu/9wCsppE9vHLym1iN8/0B2Q==
X-Received: by 2002:a2e:be1c:0:b0:353:dece:550c with SMTP id 38308e7fff4ca-353dece59f4mr29367421fa.37.1757958600095;
        Mon, 15 Sep 2025 10:50:00 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1b2a925dsm27634961fa.46.2025.09.15.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:49:59 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:49:57 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org,
	Bjorn Andersson <andersson@kernel.org>
Subject: [GIT PULL] TEE add QCOMTEE driver for v6.18
Message-ID: <20250915174957.GA2040478@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello arm-soc maintainers,

Please pull this set of patches [1] adding a Qualcomm TEE (QTEE) driver to
the TEE subsystem as described below. The QTEE patches depend on two
patches from branch
'20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-2-17f07a942b8d@oss.qualcomm.com'
of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux

Björn asked me [2] to pull them from his tree.

This pull request is based on my previous pull request with
tee-prot-dma-buf-for-v6.18 to avoid a few conflicts when merging.

[1] https://lore.kernel.org/op-tee/20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com/
[2] https://lore.kernel.org/op-tee/mir6lhkj456ra3i6w7def4rrtzw663f66l66cz4s3gxxvueeqk@ils2hjklbp4y/

Thanks,
Jens

The following changes since commit dbc2868b7b57fb4caa8e44a69e882dcf8e8d59bf:

  optee: smc abi: dynamic protected memory allocation (2025-09-11 11:22:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-qcomtee-for-v6.18

for you to fetch changes up to dcc7a571a3665a16581b5b18ca6b113f60a9a41a:

  Documentation: tee: Add Qualcomm TEE driver (2025-09-15 17:34:06 +0200)

----------------------------------------------------------------
Add Qualcomm TEE driver (QTEE)

This introduces a Trusted Execution Environment (TEE) driver for
Qualcomm TEE (QTEE).

QTEE enables Trusted Applications (TAs) and services to run securely. It
uses an object-based interface, where each service is an object with
sets of operations.

Kernel and userspace services are also available to QTEE through a
similar approach. QTEE makes callback requests that are converted into
object invocations. These objects can represent services within the
kernel or userspace process.

We extend the TEE subsystem to understand object parameters and an ioctl
call so client can invoke objects in QTEE:
  - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
  - TEE_IOC_OBJECT_INVOKE

The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
used for invoking services in the userspace process by QTEE.

The TEE backend driver uses the QTEE Transport Message to communicate
with QTEE. Interactions through the object INVOKE interface are
translated into QTEE messages. Likewise, object invocations from QTEE
for userspace objects are converted into SEND/RECV ioctl calls to
supplicants.

----------------------------------------------------------------
Amirreza Zarrabi (11):
      firmware: qcom: tzmem: export shm_bridge create/delete
      firmware: qcom: scm: add support for object invocation
      tee: allow a driver to allocate a tee_device without a pool
      tee: add close_context to TEE driver operation
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
      tee: increase TEE_MAX_ARG_SIZE to 4096
      tee: add Qualcomm TEE driver
      tee: qcom: add primordial object
      tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
      Documentation: tee: Add Qualcomm TEE driver

Jens Wiklander (1):
      Merge branch '20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-2-17f07a942b8d@oss.qualcomm.com' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux

 Documentation/tee/index.rst              |   1 +
 Documentation/tee/qtee.rst               |  96 ++++
 MAINTAINERS                              |   7 +
 drivers/firmware/qcom/qcom_scm.c         | 119 ++++
 drivers/firmware/qcom/qcom_scm.h         |   7 +
 drivers/firmware/qcom/qcom_tzmem.c       |  63 ++-
 drivers/tee/Kconfig                      |   1 +
 drivers/tee/Makefile                     |   1 +
 drivers/tee/qcomtee/Kconfig              |  12 +
 drivers/tee/qcomtee/Makefile             |   9 +
 drivers/tee/qcomtee/async.c              | 182 ++++++
 drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++++++++
 drivers/tee/qcomtee/core.c               | 915 +++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/mem_obj.c            | 169 ++++++
 drivers/tee/qcomtee/primordial_obj.c     | 113 ++++
 drivers/tee/qcomtee/qcomtee.h            | 185 +++++++
 drivers/tee/qcomtee/qcomtee_msg.h        | 304 ++++++++++
 drivers/tee/qcomtee/qcomtee_object.h     | 316 +++++++++++
 drivers/tee/qcomtee/shm.c                | 150 +++++
 drivers/tee/qcomtee/user_obj.c           | 692 +++++++++++++++++++++++
 drivers/tee/tee_core.c                   | 127 ++++-
 drivers/tee/tee_private.h                |   6 -
 include/linux/firmware/qcom/qcom_scm.h   |   6 +
 include/linux/firmware/qcom/qcom_tzmem.h |  15 +
 include/linux/tee_core.h                 |  54 +-
 include/linux/tee_drv.h                  |  12 +
 include/uapi/linux/tee.h                 |  56 +-
 27 files changed, 4410 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/tee/qtee.rst
 create mode 100644 drivers/tee/qcomtee/Kconfig
 create mode 100644 drivers/tee/qcomtee/Makefile
 create mode 100644 drivers/tee/qcomtee/async.c
 create mode 100644 drivers/tee/qcomtee/call.c
 create mode 100644 drivers/tee/qcomtee/core.c
 create mode 100644 drivers/tee/qcomtee/mem_obj.c
 create mode 100644 drivers/tee/qcomtee/primordial_obj.c
 create mode 100644 drivers/tee/qcomtee/qcomtee.h
 create mode 100644 drivers/tee/qcomtee/qcomtee_msg.h
 create mode 100644 drivers/tee/qcomtee/qcomtee_object.h
 create mode 100644 drivers/tee/qcomtee/shm.c
 create mode 100644 drivers/tee/qcomtee/user_obj.c

