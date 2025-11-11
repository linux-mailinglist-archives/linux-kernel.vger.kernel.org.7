Return-Path: <linux-kernel+bounces-896314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582DCC5016B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175873AD80D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB82F5A0C;
	Tue, 11 Nov 2025 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLLWp0iG"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2C35CBC5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904736; cv=none; b=DOqCEUaZIKyfhpc+XXeVmAQ4WqSr2j9mN4JWI/6ilmD/pwf8kHUfs2da7K633eJGsR0K0/aR4klhnLwlVXpkhD5AK3x3zsfVzWKhBB8fzUX0RPvTOo4nuMJcKpd+PC92XxvG6XGh1KdmU61zeVmVsuIB6tAAzpgmjbh4P+P9wbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904736; c=relaxed/simple;
	bh=zJPX07ZyfktlqjUe3JPYIASY53h4B2FvjzqypAfLIfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c26McEcIlyv40WuKc2F1lAp2/oiVeW8WeRZWIBJVdGbbFZ6BZD1OHDU9tm/3YMyB0NSyq6p6iCB2GLnTM+97W2ftVitQZzJPdvCh1B3kaATo8M4S0VkhWOynHQb175riAaLQkt17zDKjiWm6/tIyF4W65KZRgDIeVZoe4eADipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLLWp0iG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso292957b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762904734; x=1763509534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHl8WC+Yx5kDN/c9d1A4NEdS4ms45YXejq9GQUU7yOM=;
        b=MLLWp0iGC+AhNQJGQxiwAtKcLNwCz2oFynJTeqBD9aYfkUaM8ei9sseYoHRwVkVhru
         htAJgF0yxfxbOqyQP6YXNakKuwzhcQLoOUZyGZts05Z4a36I8oG1UkBtYDn8pTTKsRky
         Jt9art/hRaYwSvjeY5pCGaoO1BXICQPpbvHtjoyx2HL1Q/1kUjTJHnm1glRQZ9QkiJma
         VJNiSmK/4aXEjCwub7YExeGYaw5uiXx1aJxPj3n2Empk4tY6rkU/J4U6UdcP0KO2WN3H
         Q2HPSmJLbOFxa3KVMab6Dc0ucc7nhWsmkRD72mXNHZhfOyAMpXR4gRqFDCyX/DLk1whk
         TU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904734; x=1763509534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHl8WC+Yx5kDN/c9d1A4NEdS4ms45YXejq9GQUU7yOM=;
        b=pXNAzRtX8nMr72XdUKiXkphSK2YCW7G79T3YfUs1QCUesn1LEqvVQNiJrRt5aglg9O
         K5IzBssq13RBgrHQdjuWJRyv1qDZHX5YBrju8Cho6NRkN3Oy4opgxpP50r13ndf3XVVo
         CGYtsyOpc3o00kRF+hvEfC9hWPdQKJ4KE7d/2XG7YOKTXkwRSSpW1oZoB8Xx8XbqJzK0
         GuB5N7RcGX+NmGDsrgAU5t9xHjm19SDiE6AM1ztwxYcRatsROKpaB8bno8QaYVHBLF8b
         yuCjhhqyDwzdTb9xGmugKLNZ5xdBCo8yJpx57CwHByY0Ir0qKDrVXObI0rOHFe1FtvxD
         bDiA==
X-Gm-Message-State: AOJu0Ywzywv87yu90zc/aw4kehvLXN3LDeG8KAdE0hQfjXAhd49Tr1YM
	Lt4SUo0IhcGgRydhfmZ8z3LMpol+53sQmrkSWD58HKcqP16hs//gTkpS
X-Gm-Gg: ASbGncs6us0n5EUWYmtbeCzXSQ+BeMTQQw/DExHNs2jioVLXL7S80X2j67V89N7OTzd
	w0v9QmzqVmzZyjs/BTiFHHfzdboNt2B3Wab3xe74iIzEhR6zS7xcJfYgeQ+WjfwH8G/Vs64MMD7
	yqNVdbxfOWFUSPS2N0hlMryyQI60Fc+EnFCFKoU//4ZHuvOAS2n0v+fXR+RDLrTRKatfQ20892l
	k9oLeptty7Pd7G6usKcwZA1o9RIZwm+zSb7iiPRonFNeNDV0CLuT7fD19ShHhRjoxjyUUJr9KfM
	P4cfYCe7UHjsFTYaA6ztkuU07N6nQAxITA5eiw27WC+nSAuM4WDwnJfIrj9OQD0rHPAMTwKfGal
	EX1FQoNfF3Df5qu1bsuqFIWxbSVImh45TisOKUrR9esNvBvw/SmZvpyxjgdLI1fOD0VSn9Cvacn
	0a1vibOYI7bsNXTtKJPaE4VMx1otAe8w6hoC9Lr1qd5bHKAWg1dmMxxOkoDSbyiQqAXCBS4IkpD
	C3TW0o0Bw==
X-Google-Smtp-Source: AGHT+IG1kqKUqOrjRrapu7xdbjn5g0ilcKHbFQIZ+IaVNxqvrqQimzUwNTVK+gdDH2VrNT0zNKduXg==
X-Received: by 2002:a05:6a21:339c:b0:341:d537:f8bf with SMTP id adf61e73a8af0-3590b40c13cmr1157218637.38.1762904734481;
        Tue, 11 Nov 2025 15:45:34 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf06e85bb4sm784308a12.0.2025.11.11.15.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:45:33 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 0/4] Support PSK reauthentication (REPLACETLSPSK)
Date: Wed, 12 Nov 2025 09:45:14 +1000
Message-ID: <20251111234519.3467440-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace on the host to trigger a reauth (REPLACETLSPSK) from
sysfs. This will replace the PSK for the admin queue when using
a secure concat connection.

This can be done by writing anything to the `tls_configured_key` sysfs file,
for example something like this

```shell
echo 1 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
```

`tls_configured_key` will only appear for concat connections as that is
all that is supported.

Reading `tls_configured_key` will return the current configured key, which
changes after each REPLACETLSPSK operation.

This series also include some fixes for the NVMe target code to ensure
this works against a Linux NVMe target.

Alistair Francis (4):
  nvmet-tcp: Don't error if TLS is enabed on a reset
  nvmet-tcp: Don't free SQ on authentication success
  nvme: Expose the tls_configured sysfs for secure concat connections
  nvme: Allow reauth from sysfs

 drivers/nvme/host/sysfs.c              | 25 +++++++++++++++++++++++--
 drivers/nvme/target/auth.c             |  4 ++--
 drivers/nvme/target/core.c             |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 12 ++++++------
 drivers/nvme/target/nvmet.h            |  4 ++--
 5 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.51.1


