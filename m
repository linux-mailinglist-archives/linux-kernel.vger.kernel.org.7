Return-Path: <linux-kernel+bounces-893163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2391BC46ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9FAC4EB1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8297930EF71;
	Mon, 10 Nov 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="eQ4QZa0H"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64358217F55
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778636; cv=none; b=Js6vrGY6L+tRViT+GPqjvaijXFsd1ScWkD/tX0oZ7zRMqJ2X5TIzEXuET+/QsvPuj4p+RVVD876xyOHk+3bXLglXtrTrWN45CLx3nuE+KuaFVfSLiQKDbSTR1LHkt5yDmQxuHjPldR+J6OdKh2PGoh48Aoz+hN8OSIZJzV4flMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778636; c=relaxed/simple;
	bh=Dqk2TNHLlYpECDsfQQqf3/nq6Wnc//qiCf3BE7O4V2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8PqZJVHg8oF0iLLMreDtJzFrmOpC2oXZfpA9OhBL1bNfDCQHmnhjXSSIfFQLgg3RI+ghkLFLOq1uffBG5WPo/eRV6A38inGTSIEmzfvLuV5TLPhn2F3w5/SfjD+KnQu4MsHMJOydIFRFpMyghBxX7xVQJXMR7jdsL8qJZesOyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=eQ4QZa0H; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-85a4ceb4c3dso278237785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1762778634; x=1763383434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mokE1STeYnllduXZ+33QLu6bZS1LJLoqGu+1OJ9vbsE=;
        b=eQ4QZa0HSfmvDaneX1yhRverg6HXnlIrxWyjAK7uE1jJ5BKaSe/xA8t/F7RdnWjkeX
         TgM+xZR/D1d5GZ6y0P89b/frEf3b9W/Ee1GRuWr9eA8bUJ1XMCEFeWlCgpwSpfVOIO7P
         scr74wPRw65BlG7lhr2W+Rwm43O1MqqfG6/BFTBuZ+VYSWSOGFfoX6r1qDK8zPc7saoV
         FMvP5CfLaOQsSf9sFVvwMiUPNLa1er+aKEPYSYlZn22OTzFZjVoeERwMJndSQ7V0XNcE
         P6aosstbsnwgWlFS4P8yQLxr8i5SJJtHfB+7866VaT9pKSODlblD6EPdfFNXI37AE6J0
         Fuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778634; x=1763383434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mokE1STeYnllduXZ+33QLu6bZS1LJLoqGu+1OJ9vbsE=;
        b=AqqSXRzX2/Wm+l60jRYCRzU7FT7DOFvnMjC3aORjSskDViRFg7fBMLKmhHO0qpcMpM
         ktHIJO8UMaZHiQXJv1DgVHwyv0nweIvtzZ26ErFej4DIDZHFDjAcmqSTPpHZccNkAN5G
         Sqjof+MaM9SN6c+AXIHZSR1fi25ogjnUalXZyAuMG3HoCsDyCAx+/4QwdQXhZsVkC7oe
         5kMkc/3Mf/kBgTbwnEXBWKVgH/kXuHLw7v8K1iJucOC7fPFgzoIxUaXBwWnXQW4te6df
         BMQrBpBqP66lOWR+k0lKYahp0TxUNvzH+Wv6ziJnRKe+WM4qt4dMC9dr35HogM71K0I4
         HdmA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5AJ1m806ZC0XAEiaztgnhB7fo6d8xRJ7dRYIWyj7cR7xK6QiQ5BbhiYEgfh9vyxWfH9OMgXNPyrAQUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoddEQk3r8oDPwsnWsdlBSN/8BE1wLFuEQBgAvEdy8Kh7+gwN/
	v4SZ2lT1EanXagGsqI83dVpX2/rtJTnl5HLpcAMhi9cegob/6VIWbbgzuLp1Wuy3uiI=
X-Gm-Gg: ASbGncugqppgSCAF8X94SAKRG5ecchkNBCDseEpDI/e+glj+ublpPTD+ce1ubUrCD4a
	n/aeX9ZuK6eStGvh00k6NERh+1FSriRhXf4TwD1KnbREAL8Fgfn8s6H0Z5mUiw44xIFI7C9GXPn
	2RIFLr4POlR6Kd3wtbS94mqCApB+BbaIIdETSN8DZYkUyKOZ67Bd2TInLntMLZsI63iw0PMKwXC
	Fna2Y0k4I5oZ8gNNTtovJaiBJGcAJweHL6tET35pLU0tXEC8HJFDKZjoTiyHSzoDKYEohJ8kNNy
	Vf8tvSu6ER1y/BCSADu9Qji7NW2kl5taGTM1c7E1xi5tl4nyiBD6BZVgnM5jgTsxXj/thhrSpK1
	b1eihJDhYZAWAG/hd8GPjMZdPLT6mZuJQLcsMyQiZPsRFRm69RQz4uoBggIEzKeH4pBbbgNewnH
	aWhsouL6NxDrLDESY2AK9dzRL5qV/8MpA=
X-Google-Smtp-Source: AGHT+IHzD9vQiWPhgW/CmDZ0Sh3mVAM0JnEabgV9DyCHXVHZqLCr17WfmN9Rv8GMnK6YWCsW15692w==
X-Received: by 2002:a05:620a:2982:b0:8b0:f2bd:474d with SMTP id af79cd13be357-8b257f6bb13mr863976085a.64.1762778634203;
        Mon, 10 Nov 2025 04:43:54 -0800 (PST)
Received: from fedora (cpezg-94-253-146-68-cbl.xnet.hr. [94.253.146.68])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-8b2355c24f6sm1002765885a.6.2025.11.10.04.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:43:52 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	horatiu.vultur@microchip.com,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v2] net: sparx5/lan969x: populate netdev of_node
Date: Mon, 10 Nov 2025 13:42:53 +0100
Message-ID: <20251110124342.199216-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Populate of_node for the port netdevs, to make the individual ports
of_nodes available in sysfs.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Per Daniels suggestion, set it directly in sparx5_create_port()
instead of doing it in the dedicated netdev registration function.

 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 40b1bfc600a7..582145713cfd 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -395,6 +395,8 @@ static int sparx5_create_port(struct sparx5 *sparx5,
 
 	spx5_port->phylink = phylink;
 
+	spx5_port->ndev->dev.of_node = spx5_port->of_node;
+
 	return 0;
 }
 
-- 
2.51.1


