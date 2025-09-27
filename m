Return-Path: <linux-kernel+bounces-834965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206CABA5EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE103BD47B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0692BE652;
	Sat, 27 Sep 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEtpz2ng"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E931A5B8B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975428; cv=none; b=lH5JtuJs0Av826SHwULPotzJufOhTXeJK1vTBFyOJUW7eqFm1Vk9fQq7/txHW0c1zptfDg8DIKsAXYSBcKvMj0xIs/qk4hm5whVYhgcB/GxIE0rh7ivHDrpkwTaZtCbpzWUBL8+PQCu5F4AJOkJSv7LLJupRBLX97gB3jJm2src=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975428; c=relaxed/simple;
	bh=KUCC2p1XDN1zncgpTvWkeyj2061JKPwHdPb/zZAruJs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=arTJoPPoHqpuYcctg5E/ezGsbad7IV+FvT4K9jFNcXixnFt30jt7zlrHUYY73WNMXxy7vd0uTq4D7dxo3DzMUlsZ/swMaFsLb9//MyyHcpGC9iReCVvVh8Qel7y9sSWNn62jRKZitqtydxEwEgxNhvpAagmv5zEqfX5NFX1MJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEtpz2ng; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso19369755e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758975425; x=1759580225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag70dVUuM+4MRKMykXD7Nz1Gn1OJGnCoNyvf+OVQVG4=;
        b=TEtpz2ngbL+ZhtFIcULDjr2r+XlitJSgSbuzvR7EHkiFJqTCYz3u/17MB7mPJ3T+MG
         FcbEF0uIfBbBADj7KldS+ltjvRymLdX0e8ELCPjd23uP5GgvmWhvpUXBefACN6USVGQ5
         lfLbEAldiJUBbPub4WGzkfaZkqp6YtFrDf6i3ShmFMvOp4Q6YClajnIg22wTkq6rC32y
         PrXgOYPL2ge1aYDlJMKcSD6qX2Dv/XyDSnNrhLX/PudqZqYfiJzerYFQBQHbCZd+gzcq
         LXuuZE/Frkf23O1XTiEO/ECjkQ5p+An55eavTjJj5nGmJvLNczU46ka6fFJezfgTp/g3
         wfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975425; x=1759580225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag70dVUuM+4MRKMykXD7Nz1Gn1OJGnCoNyvf+OVQVG4=;
        b=TxICSU5JNNE3QYle2Q3pLunXgRj5I/egVbvXOCD9miVKbqKy+FdwERC89ju4PAekNq
         VszQ1NJGRG5dfU47xUjyp4Vi+FIxLQq5efo1GJUWM0SuBHD2G1aVC0YNQnbUR4MlcUUL
         h8SnitxHmL51RImXvk6u2hWc+JuLPrvE7q0AqBjpKFocOZJcTGUuAkQ1WGnj8FAfqDMq
         +ZOd+6i2/YaIJmFwDqjHAKLYieZow3K2EqPyaMe4a+nQSsCWC2e92xWTPY2WWQ9yKtpM
         o0yFeCD0/YlNVShWEny9Iie79JqHzBisYaof5mcZdSuT4KC5qkVRrMp7aZph553tPX+9
         EYnA==
X-Forwarded-Encrypted: i=1; AJvYcCVu2cFtv/zk2DbFF0006pMFKmCuxI/HHGGdVhXW9AhKQfDuZVAewLH0Wu4Hy1935z58k/QNGT7G3o+hIJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxG20j2DCKxRy/9r9wG8Prpl6Upvj9omZp9QZE9BN/lcyoOxDy
	KSBSMnq4fAOYhdADVNlFGfRpEbQRbOQM1DOfOqUrMUQHVYP/kxp/IiBCesJsv9fx8Hs=
X-Gm-Gg: ASbGncsnr8jS1STPzjC4jWlW4zVOLGAPZzI5cApTUPWh8K0j5clrv69+gDiA+TTpaNg
	qgmPWXh29xhVRSA/taBgP8bZb+9V4ZgXz72dPoYgBLNt1FfpDsDtQ8pwzlDYYDpq+Zi9jlEF1JS
	Tst4p8zacgG6RTNQzuVPvlhwIo7Pou62rlezgFnalZBFLvt8HrBdSV5ykTU6GB79N4NxNSjQCEV
	QJEBuqhlvzLma6Ml/TwlTcXvuWrbTb1ovinCDT8hJMiW9NiLSsxY4FChnBYhU6xBS88ZmKxjJyS
	6mUSxj4K0WVYwtCa8IWp7L/lMv4kmE38st8s3SCW1hI8/GG5X6Sd42ajC634m2DSsqXP1CGclA5
	tLRD/ebUYv6PPMjX3Z6YI77cwuUY=
X-Google-Smtp-Source: AGHT+IH6lB3PD/SmhSAHcJeYKh0+HMGcpi08kyP8CuF+lmCwJGwyblmxw8T4gNgHLlKgwb9ALTb5Nw==
X-Received: by 2002:a05:600c:8418:b0:46e:39e1:fc27 with SMTP id 5b1f17b1804b1-46e39e1fd05mr62543715e9.5.1758975424931;
        Sat, 27 Sep 2025 05:17:04 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab7d4e3sm152435835e9.23.2025.09.27.05.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:17:04 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] media: si2168: increase cmd execution timeout value
Date: Sat, 27 Sep 2025 12:17:01 +0000
Message-Id: <20250927121701.591576-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing with a MyGica T230C v2 USB device (0572:c68a) shows occasional
cmd timeouts that cause Tvheadend services to fail:

Jan 28 12:23:46.788180 kernel: si2168 1-0060: cmd execution took 0 ms
Jan 28 12:23:46.790799 kernel: si2168 1-0060: cmd execution took 0 ms
Jan 28 12:23:46.878158 kernel: si2168 1-0060: cmd execution took 80 ms
Jan 28 12:23:46.879158 kernel: si2168 1-0060: failed=-110
Jan 28 12:23:46.879908 kernel: si2168 1-0060: failed=-110
Jan 28 12:23:46.948234 kernel: si2168 1-0060: cmd execution took 60 ms
Jan 28 12:23:46.949121 kernel: si2168 1-0060: cmd execution took 0 ms
Jan 28 12:23:46.949940 kernel: si2168 1-0060: cmd execution took 10 ms
..
Jan 28 12:23:57.457216 tvheadend[3126]: subscription: 009B: service
instance is bad, reason: No input detected
Jan 28 12:23:57.457392 tvheadend[3126]: linuxdvb: Silicon Labs Si2168 #0
DVB-T #0 - stopping 778MHz in DVB-T Network
..
Jan 28 12:23:57.457584 tvheadend[3126]: subscription: 009B: No input
source available for subscription "127.0.0.1 [ | Kodi Media Centre]"
to channel "XXXXXXX"

The original timeout of 50ms was extended to 70ms in commit 551c33e729f6
("[media] Si2168: increase timeout to fix firmware loading") but testing
shows there are other demux commands that take longer. The largest value
observed from user reports/logs is 150ms so increase timeout to 200ms.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes from v2 [1]:
- Wrap lines in the patch description to 80 chars
Changes from v1 [0]:
- Rename TIMEOUT to CMD_TIMEOUT and move below #include
- Add Wolfram's review tag

[0] https://patchwork.linuxtv.org/project/linux-media/patch/20250331075838.3444332-1-christianshewitt@gmail.com/
[1] https://patchwork.linuxtv.org/project/linux-media/patch/20250331084437.3974648-1-christianshewitt@gmail.com/

 drivers/media/dvb-frontends/si2168.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/si2168.c b/drivers/media/dvb-frontends/si2168.c
index d6b6b8bc7d4e..843f1e01318e 100644
--- a/drivers/media/dvb-frontends/si2168.c
+++ b/drivers/media/dvb-frontends/si2168.c
@@ -9,6 +9,8 @@
 
 #include "si2168_priv.h"
 
+#define CMD_TIMEOUT 200
+
 static const struct dvb_frontend_ops si2168_ops;
 
 static void cmd_init(struct si2168_cmd *cmd, const u8 *buf, int wlen, int rlen)
@@ -40,8 +42,7 @@ static int si2168_cmd_execute(struct i2c_client *client, struct si2168_cmd *cmd)
 
 	if (cmd->rlen) {
 		/* wait cmd execution terminate */
-		#define TIMEOUT 70
-		timeout = jiffies + msecs_to_jiffies(TIMEOUT);
+		timeout = jiffies + msecs_to_jiffies(CMD_TIMEOUT);
 		while (!time_after(jiffies, timeout)) {
 			ret = i2c_master_recv(client, cmd->args, cmd->rlen);
 			if (ret < 0) {
@@ -58,7 +59,7 @@ static int si2168_cmd_execute(struct i2c_client *client, struct si2168_cmd *cmd)
 
 		dev_dbg(&client->dev, "cmd execution took %d ms\n",
 				jiffies_to_msecs(jiffies) -
-				(jiffies_to_msecs(timeout) - TIMEOUT));
+				(jiffies_to_msecs(timeout) - CMD_TIMEOUT));
 
 		/* error bit set? */
 		if ((cmd->args[0] >> 6) & 0x01) {
-- 
2.34.1


