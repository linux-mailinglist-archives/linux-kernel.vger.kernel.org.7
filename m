Return-Path: <linux-kernel+bounces-896334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35440C5020E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5ABD4E5181
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687531A38F9;
	Wed, 12 Nov 2025 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLRxDIeq"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFE35CBB1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762907708; cv=none; b=sBtyLzJZ6OzxFffyijFo7Xzg6U9FuQTbWW8NFONock22LTaZiW7lOJ3F1JYTvyAc+JupdbnC0gsRqb4lZAEh52NFLDBCMY/ZhdPlmIwLiWFfNmmdlhJvDlykrcsSk/h+BS+qgr8JzurMRbvbqiOodpO7i91Ixw8z3U80paSgX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762907708; c=relaxed/simple;
	bh=/uddJhBBzzW8L+E3X13d+vydY17/3a+z2ohQB6rVS6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzFB7Sh371b3zav3lnqqT7aMRpE94bS3s5yyfYIHHC+6X4TBNGlsrMqNr+xDkyJBp9O26SUpQr07E12yjqSfyuZVYwqzCoT9vYA6+tic3fVRHMvWVAkmHuDjwp4E8QHqo8L/ETFAn0J+Ur9y7PtgGqrNmaTt1MvM8EZWk6KlKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLRxDIeq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b73301e6ab5so52935166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762907704; x=1763512504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8bA5fyqCC+W6u0vk7OwR/d5lvOlTqdfez3AJaemrP4=;
        b=lLRxDIeqpWVSjy4aNVeVN/KjYWHErAt+n6I2YfgUZK1vsm0QKU9D4XExHJWxxYQM98
         ZCPQqfZ+bf4uqq7tU0EldzfQbVl/Ss4E4AZYLgDZ8Kv20O3WU313bIo+YD/JdSe7CVwe
         Fwkk5tnKwmJ8BH8d5C4lwrwj4IDVQ+/+eyZUyMBlD8WGLQeim89f6UqQ60qi/KlG349N
         mj30GspfrfyAGlHxi5n0aNCSoAWAqWowEaacIBoAJ7CZDisa6j2DIxe4ELP6JPYOgiow
         K+yJJYUs4+LNhOgHZb4yCtyxhX/GxM5Kcb0T7BRTwr1174lfI9SKmCZ+4Z1L1GwJ/JtL
         7XwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762907704; x=1763512504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8bA5fyqCC+W6u0vk7OwR/d5lvOlTqdfez3AJaemrP4=;
        b=ThZvrqljCYCdcdd4LDhH4kBBh1oi774srDwNNnWmDR51z/HE1i0vxgRcGYDLsviEVd
         xRVgd93kOqUMfqWxRBbFWkANNTtgjJxh0rkg2wESloCHpmhS5eevQXjAkKyWRVtv3MWN
         txslwvy1wifVpVcruEtDG55Qh/vVKjbnqmFoxxg7dk1Cr/CiaWPNaLIPmw0l6Ns8siBi
         fvTgbt9Mnk0+5lzq19azbyk+NMO7pcZjdJYbWpGSiZZ8OAxOXzbwKpxCtY+xrI2147be
         tOkbL1zcyhbOSIMChrg7HzX21iBMJVSFVh0hypHe6ocUnms5YpDCxNG1WKVbg6OhupGG
         IOlA==
X-Forwarded-Encrypted: i=1; AJvYcCWsov6czTJ7lSRXvAJXxpzMJwsyrnuaAq7b78FhzM8FCyAtpKvaUd2vNOezFv2XyitXAbC1OxjWUqY2NWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+sLm/aekLRWZFMCuvNqBhEpgWgS9Xc4o3ciYpjAq7ZQkIZPB
	IGoOwPUgfiCWy4Gkz9WDjrDyzq2YEf8T+Ho9K9Cb9FFvyLgiQiIFtHkEiXXD6PXP
X-Gm-Gg: ASbGnct+n91iCEtTic7mZQw35w6ifdRe0q2AY+U2SAKMPHdnETA7QxHXBFlT9BABUa3
	KK/SXuTOT3tQIjoQTwKjxwvoIuIfs2lTJbd7YQkkQAZUiN43D/vGsUepVejIdFZ05vbhR52dF4w
	PUL6M2KW+AAcZFDHcVXzLvtkaIDvDBYSgMmGebfudpYZWHve6MZi5JC8S3xkPmjplx0hCJusb7V
	9XzgYwr9TLoEK+KOsr11Q1txlLZLM8nlB++n/eYlYPbmI3dZT6/y79n6yQ+1JEsO1ITfsdhCRRA
	uKhxEVKEQ/xEYFWL0FQRrOnmZnoYx+BajUywG+ipXrRMvyYAoZfHgxsf0c2DXNMjaGyZC3F0r9D
	VFGMg8JXzPKNgEac94frnAPrMKp5sMpWYvj0onF0OoCnisMhG0owZgQ7C20nDGwtITbd5svircl
	imVpUi5675ZLw=
X-Google-Smtp-Source: AGHT+IGqrNbW7Y2frs0SjkA276j6v0NPZI9klOiEtgkLEjlg+yLRP1GOA3gr1+LqrmTZn0GT7QZWpQ==
X-Received: by 2002:a17:907:3e1e:b0:b6f:9da9:4b46 with SMTP id a640c23a62f3a-b7331bb64cdmr106614966b.43.1762907704029;
        Tue, 11 Nov 2025 16:35:04 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcb0aasm1434568666b.11.2025.11.11.16.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 16:35:03 -0800 (PST)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Subject: [PATCH net] team: Move team device type change at the end of team_port_add
Date: Wed, 12 Nov 2025 02:34:44 +0200
Message-ID: <20251112003444.2465-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempting to add a port device that is already up will expectedly fail,
but not before modifying the team device header_ops.

In the case of the syzbot reproducer the gre0 device is
already in state UP when it attempts to add it as a
port device of team0, this fails but before that
header_ops->create of team0 is changed from eth_header to ipgre_header
in the call to team_dev_type_check_change.

Later when we end up in ipgre_header() struct *ip_tunnel points to nonsense
as the private data of the device still holds a struct team.

Move team_dev_type_check_change down where all other checks have passed
as it changes the dev type with no way to restore it in case
one of the checks that follow it fail.

Also make sure to preserve the origial mtu assignment:
  - If port_dev is not the same type as dev, dev takes mtu from port_dev
  - If port_dev is the same type as dev, port_dev takes mtu from dev

Testing:
  - team device driver in-tree selftests
  - Add/remove various devices as slaves of team device
  - syzbot

Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 drivers/net/team/team_core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 29dc04c299a3..94c149e89231 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1134,10 +1134,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EPERM;
 	}
 
-	err = team_dev_type_check_change(dev, port_dev);
-	if (err)
-		return err;
-
 	if (port_dev->flags & IFF_UP) {
 		NL_SET_ERR_MSG(extack, "Device is up. Set it down before adding it as a team port");
 		netdev_err(dev, "Device %s is up. Set it down before adding it as a team port\n",
@@ -1155,10 +1151,12 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	INIT_LIST_HEAD(&port->qom_list);
 
 	port->orig.mtu = port_dev->mtu;
-	err = dev_set_mtu(port_dev, dev->mtu);
-	if (err) {
-		netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
-		goto err_set_mtu;
+	if (dev->type == port_dev->type) {
+		err = dev_set_mtu(port_dev, dev->mtu);
+		if (err) {
+			netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
+			goto err_set_mtu;
+		}
 	}
 
 	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
@@ -1233,6 +1231,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		}
 	}
 
+	err = team_dev_type_check_change(dev, port_dev);
+	if (err)
+		goto err_set_dev_type;
+
 	if (dev->flags & IFF_UP) {
 		netif_addr_lock_bh(dev);
 		dev_uc_sync_multiple(port_dev, dev);
@@ -1251,6 +1253,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 	return 0;
 
+err_set_dev_type:
 err_set_slave_promisc:
 	__team_option_inst_del_port(team, port);
 
-- 
2.51.0


