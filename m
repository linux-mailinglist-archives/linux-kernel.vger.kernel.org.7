Return-Path: <linux-kernel+bounces-750462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9021EB15B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B994454822E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A16E271445;
	Wed, 30 Jul 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8JqsNdp"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4838269811
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867799; cv=none; b=NearuYt1xOAp70OsLqvqfx1APhnPrCQ+NxKN7lubAYWY2q6rCRAwMfBEvbk3CCBuIGGlwSxEkw6p2rfXGtcAxk8dJWU87zvm0uHtLqpV/EBxDSq7e7KxjVCa8QmvkYgqZ6FOjvnbm4kj55ciQdsDRTQNL5qUmBNZXLsdcfcLdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867799; c=relaxed/simple;
	bh=fnvRP+SViXyCbSMzmsrKWpJn9OYHrE70YQgzPaCywJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WOfuZWiGkpuBEDlzGYJroiyUFH47W2LdKPyWsQlevMx9wFFXHif3oNlcdWYfrJDrYooJegpjZGnvaBgbqikDeWjb8cBUllQ7OwEwkQ2tw7efJ7WUxnfi6/+zaa0YXLkPiK8HMBfe5L0vvsWHFdWn8TPT8lkONJ/eKDNhUicMV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m8JqsNdp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso5840326a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867797; x=1754472597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0POlGKbEX0EvHYDWI2NptB2rFaQwWq9w/pBl23x/4k=;
        b=m8JqsNdpmNjEiQDZlPQYPmq10IeFALBuw6Cqqxxd5JCEVEc5XxrGhS5RiJm5CNuot7
         SJgEzx0BGd8lrtdO2/I75RCNyk5Su7htVs99clauIY5z7tg/+Mbp0Ml5WfHSqX+Dz7sM
         aa6gd8ty80jHXsZ4it3QMuMzSdmRbcAogtBCpC+TtE8Wp4EPl4i43AwVO64N17XLFIGb
         mpq/eRUjpHLefY/8DCiM/zkNzf5Mq5GfiQ1C4PTw71XwmJp953UGhTJeRTKhiYPaMwfT
         4qfRAbH9ag0X7immokP4AtKtFlUZfKUJtkNaw5AHan1uMGbg/J6XxJgEHdMue6WCe80l
         E1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867797; x=1754472597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0POlGKbEX0EvHYDWI2NptB2rFaQwWq9w/pBl23x/4k=;
        b=QVrOkTmhsYxknywSgqIju2nv/ACTOEvaLAU+4zzX31ZIn4IeTQsAw5g/sAweQhVui/
         V7O/47TY0+qisnIX61UMa2/AJNgpoNR0nuGmn5EwBhq/4ZCrf7EI0hzy6CXfXHaGJuVv
         ezzLy8VCJQrYg80WfHuE+ekWtNVcdPsnqlcBomGCqJXzsB/iQ4hb1CgiIgiS28cg+c+j
         9sz/6KLCX9MBHcJReg0RODlIoXqIW0miWyrYCCNvLE69Jx7lXgeO0az6eIh55T/v6Qv5
         QRpdbiC5syP3TgTt2HXsbFUHvGaIpqQ9q1FYGkkUEznHHKS3KKT7YK3ykclLsBrESQJD
         SbXA==
X-Gm-Message-State: AOJu0Yx3dgbS67ew7I5YzfT48i8lcHWjF75r2Fs8swwWkaO8cMstVjGh
	V9HiXtdxk2ZoV7Af6yNRBjorEQzns/5DkJT2PF8fbzUfleWVs4cF0yWDALHx+RQnWCfrBjZPsfG
	J9kot
X-Gm-Gg: ASbGncuJYmM9/19ak53B60XFgtfXYO7n5xET86BbMquYhBpqqqZTVg3UNVe3HtMEVMs
	Nya22DzItAjXzxv4SxDMXHI/WMfkN4fmhHuMGV+togTflQYwpKIgC1+9JWa6ZccL9zs3gUrSuYV
	t9duZD/bTRSLTfEXxQ1S0RrgemNE3voBAQJl/RS/WlM7xaWrZZwTsvYAD2y66Qth1kdQsvXwM40
	kxjiexfGIs8HL7NvIHLnHPcWXsCz+7GL5VKlTaK4mgLaQkPMmtdPH0MJFLRlIJZE96D8bFjLN6m
	9ajlz0PqlEdz8/Wuxq36PTuA8QizVIq6R86rT34ZFo+Jdk/u5xlRFpxGkfsyGAhX1D56Qg0ff2T
	ZoZC8hLYbjFI5gpSIf9RdvKc=
X-Google-Smtp-Source: AGHT+IF4uc5aZmco6mwIQFVn7igbRT3lJPHP6Dmmwr2upZelWkrrgq0JOAt0HEgC+nPLPHXlqWICLw==
X-Received: by 2002:a17:90b:5103:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-31f5de54a99mr4185193a91.18.1753867797096;
        Wed, 30 Jul 2025 02:29:57 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee4f42sm1477362a91.23.2025.07.30.02.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:29:56 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [RFC PATCH  0/6] virtio: Add support for Virtio message transport
Date: Wed, 30 Jul 2025 14:59:29 +0530
Message-Id: <cover.1753865268.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This RFC series introduces support for a new Virtio transport type:
"virtio-msg", as proposed in [1]. Unlike existing transport types like
virtio-mmio or virtio-pci, which rely on memory-mapped registers, virtio-msg
implements transport operations via structured messages. Those messages can be
transported through different mechanisms such as mailboxes, shared memory based
FIFO or specific protocols such as FF-A on Arm.

This series includes:
- Core virtio-msg transport support.
- Two message transport bus implementations:
  - virtio-msg-ffa: based on ARM's Firmware Framework for Arm (FF-A).
  - virtio-msg-loopback: a loopback device for testing and validation.

The code is available here for reference: [2] and virtio-msg loopback and FF-A
test setups are explained here: [3] and [4].

This series is based on v6.16 and depends on commit [5].


### Memory Mapping and Reserved Memory Usage

The first two patches enhance the reserved-memory subsystem to support attaching
struct device`s that do not originate from DT nodes — essential for virtual or
dynamically discovered devices like the FF-A or loopback buses.

This reserved-memory region enables:
- Restricting all DMA-coherent and streaming DMA memory to a controlled range.
- Allowing the remote endpoint to pre-map this memory, reducing runtime overhead.
- Preventing unintentional data leaks, since memory is typically shared at page
  granularity.
- For the loopback bus, it restricts the portion of kernel memory that can be
  mapped into userspace, improving safety.

Device association with reserved-memory regions is based on DT node naming
conventions, such as vmsglb@ or vmsgffa@, similar to the remoteproc framework’s
approach.

Feedback on the design, API, and approach is welcome.

--
Viresh

[1] https://lore.kernel.org/all/20250620224426.3923880-2-bill.mills@linaro.org/
[2] git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git virtio/msg-rfc-v1
[3] https://linaro.atlassian.net/wiki/spaces/HVAC/pages/30104092673
[4] https://linaro.atlassian.net/wiki/spaces/HVAC/pages/29657792513
[5] From linux-next: 5be53630b4f0 virtio-mmio: Remove virtqueue list from mmio device


Viresh Kumar (6):
  of: reserved-memory: Add reserved_mem_device_init()
  of: reserved-memory: Add of_reserved_mem_lookup_by_name
  virtio: Add support for virtio-msg transport
  virtio-msg: Add optional userspace interface for message I/O
  virtio-msg: Add support for FF-A (Firmware Framework for Arm) bus
  virtio-msg: Add support for loopback bus

 MAINTAINERS                          |   7 +
 drivers/of/of_reserved_mem.c         |  91 +++-
 drivers/virtio/Kconfig               |  34 ++
 drivers/virtio/Makefile              |   5 +
 drivers/virtio/virtio_msg.c          | 655 +++++++++++++++++++++++++++
 drivers/virtio/virtio_msg_ffa.c      | 505 +++++++++++++++++++++
 drivers/virtio/virtio_msg_internal.h |  88 ++++
 drivers/virtio/virtio_msg_loopback.c | 323 +++++++++++++
 drivers/virtio/virtio_msg_user.c     | 140 ++++++
 include/linux/of_reserved_mem.h      |  13 +
 include/uapi/linux/virtio_msg.h      | 213 +++++++++
 include/uapi/linux/virtio_msg_ffa.h  |  94 ++++
 include/uapi/linux/virtio_msg_lb.h   |  22 +
 13 files changed, 2166 insertions(+), 24 deletions(-)
 create mode 100644 drivers/virtio/virtio_msg.c
 create mode 100644 drivers/virtio/virtio_msg_ffa.c
 create mode 100644 drivers/virtio/virtio_msg_internal.h
 create mode 100644 drivers/virtio/virtio_msg_loopback.c
 create mode 100644 drivers/virtio/virtio_msg_user.c
 create mode 100644 include/uapi/linux/virtio_msg.h
 create mode 100644 include/uapi/linux/virtio_msg_ffa.h
 create mode 100644 include/uapi/linux/virtio_msg_lb.h

-- 
2.31.1.272.g89b43f80a514


