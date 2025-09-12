Return-Path: <linux-kernel+bounces-814542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA250B55554
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F1F161432
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A67322DC4;
	Fri, 12 Sep 2025 17:06:16 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0E3112CF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696776; cv=none; b=ghmEk24fcvI09PlgDL3jzVE1qHHLzxDwqL6ixivEuIX9Gfg9gDX4GHt3GzoaFoBwwx7Qr/rOpy+GRE+eIADyKD2vw05VczGi7LYX4P3XmwekkBPG6YnXwFJUSbXMGEAAs3zB5kEt5N9F7y43adu6Wgbbp6ANJodaiM9XcJf7bus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696776; c=relaxed/simple;
	bh=z7ODM4yeGOyCrC47UrkJKlQNImokfG0fkhm+U4ThvNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lq229Jjp+RF2su+ikH+J4C0jGRfHyQXqq85VKGdrA9kgpf6syLFMpIIOKbekU6qrYbwTmYjBJ4paX9D63wyL2p9ixbbjJP9K6LwJnqHufxwBh/i8pny8+FhL4Nz5jGFUp/UuxXDL4oLp2tKef4yMlhovrpkqdmYsIpfkNsTXtbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b54acc8c96eso851618a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757696773; x=1758301573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xdln6TPyaoot6c1arftNTKI7b3e4E+Fw50+XLxdpB00=;
        b=Mybkve+5whdcB2/7BUNOmcezh1uloLQ099jJG+VmV/XC6ZA23m8y1zqnIiBJJObOxU
         PsotV84C4NEFzUmGMaZ+FKQ3xvIrNxx11Aso+HCzp3FTZLTqQ88vHN4zN3ENAi3Aolc8
         4uiW1e5ngE0ba3GPQhyd9uhz5P281l23wfQDFoV80eGb5L/sr9dEkHoQY9LQ5AAy1nse
         mDspueQb8BuXEWOE8hqRsyeqT4I2QkLj95OU7Qtgkej9DqM3yoHWe2qVKnGQSAsk/jGj
         Z2XCaGdaJT/WXqXQfGMNlJngifsLgoZ4Vunqu4IHN1I6fq5pFEL6oSjlnyy0ulChNaxj
         T+wg==
X-Forwarded-Encrypted: i=1; AJvYcCW2a513A18Ry13azmpa7lTDKwLqfrD639y+8sB+weFpK45kkApRQZ3n04QnKhWyVN5uYDwAJejZKN/FIk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNW0TYv6EajL/MWF3tfDBGs4PZhL9fe6X0AIty+3si9UaTvPpn
	IU0iyr1xNqZwsENO7U34BQtTwUZME5ZqJ9y6gSUrsLZuE65r75T1OvA=
X-Gm-Gg: ASbGncsvF9jKOxwnLfSW3vBeju/0/3wYdKqjtB73Ojek5F6UdsVMpCe8cErNneDeSXF
	SNzvSs9rwGZR7WKpbF+WxZ4a5berDYYNI3FgKUuhwWScRd8ConEbJNQV3KhZDXxRwxoBQ9IDQxX
	xPmEzsXWuCVF55EBQ+jEBKlNcylUHddtXYHqlKzjWnXkEBbSlvjSUc1FOBM27ZNLSnDEfyWnbpr
	Blx3W45bhejoyiXFKmar8XQ/X+EsgSnC/5VqofhaNBT1HfT4qcvbciqwyraoKULS70h7k1CDMhP
	PoAMMdtyWkdSXosW4DTjaEtILKnHogpmMl5rclaIMzD/g1Gp9dviDq53F87GMyKEFAnapny0XK8
	IIK7C6ff6ywSJOFgGm6p3Mb8IPwooNv0CInBVUGIFv56FgOvnT44sOH630KhnzdJ1jCTWU+zo5m
	ltIKgi5Xt7JROYw9zLO7gyY7mMn2/MWG09Hp7CSFO7BnLy27DzZGpoAJhVncdFJa46gY9OpayKW
	oQI
X-Google-Smtp-Source: AGHT+IGOdtov7MDgtAPJBxTWxT0eZs+wkblLgU6EWiyMAEUP1MXy6U8WZVCMX7DmcSMX0j7bBG/d6w==
X-Received: by 2002:a05:6a20:734a:b0:246:7032:2c1d with SMTP id adf61e73a8af0-2602a79259dmr4527604637.23.1757696772766;
        Fri, 12 Sep 2025 10:06:12 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b54a387cc21sm5204677a12.28.2025.09.12.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 10:06:12 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: ncdevmem: remove sleep on rx
Date: Fri, 12 Sep 2025 10:06:11 -0700
Message-ID: <20250912170611.676110-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RX devmem sometimes fails on NIPA:

https://netdev-3.bots.linux.dev/vmksft-fbnic-qemu-dbg/results/294402/7-devmem-py/

Both RSS and flow steering are properly installed, but the wait_port_listen
fails. Try to remove sleep(1) to see if the cause of the failure is
spending too much time during RX setup. I don't see a good reason to
have sleep in the first place. If there needs to be a delay between
installing the rules and receiving the traffic, let's add it to the
callers (devmem.py) instead.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index c0a22938bed2..3288ed04ce08 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -872,8 +872,6 @@ static int do_server(struct memory_buffer *mem)
 		goto err_reset_rss;
 	}
 
-	sleep(1);
-
 	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys)) {
 		pr_err("Failed to bind");
 		goto err_reset_flow_steering;
-- 
2.51.0


