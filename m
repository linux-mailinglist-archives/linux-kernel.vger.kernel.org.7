Return-Path: <linux-kernel+bounces-890540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96377C40494
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEB23B4ACC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FA52E6CCD;
	Fri,  7 Nov 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JsJOYrVi"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0C08BEC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525189; cv=none; b=afrC4s6/nbxd8zT1oU2MTd03u69uCXme40e3vMKeIKKkbJTIhZcckxxD/6LG94ofFvLVGYNPunGctEHWQI1NVN7JGem5wFRwlzPH4GsKn3mMLwqZzFyYsTA5OPHUrglZTx+OFcfYjCAdMoFgi4oxsHBcZK65mxewaWn4r03D9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525189; c=relaxed/simple;
	bh=G+GK50091GF8zGY4pW7Yj4+0UiXOAijvF2+COuJTEIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EH7riOXa2aThxZL7EbFTqu0LQmstsPGjkQ+5ZWikaYGIaj93w+RKIrblCK+kF6mhIHCGem9VcklVvq+0jOEmKaSFREEbGxXWNzRIYyl1pppLRce9HD9Je+BsvEUOpg1/rDMgnWLqRi4/QMuo4rWgGI3fdGP5yUleRrSDSZFf6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JsJOYrVi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso1406574a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1762525186; x=1763129986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RndfiI2tvXOM+1ZP6efdxoHZT1tlHUVs/LDHnVUxmno=;
        b=JsJOYrVi+O5hlOYCxiKYE0j/AAhfw1oLixuQpyuILl2e8DeGA0g2Id25fkO65IzILH
         +ysf4Ib84x42WBiztXhRe3TBdp2nuInRxHXu/zQIFOZ4LxGv5esfljUIvz0r/BsoMFtH
         tSgWareDOPEjesV/9TqEEGSBHXSOstQEKCKwvq2XDTm0mBHtmmiIwApPxrP8e+nLVtGE
         mZo+3Wi04c0l9Txt0sXBYArl1ROfGnI9hZStc2Ln6md2gx+znXm/qBWKGAXBsHtQqY2l
         51XYHMvP8kHtRk7uo6oNikqFKKOpLTASu/lVht5LA06zdFENdqctNGm69xR5yAvy7stj
         xARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525186; x=1763129986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RndfiI2tvXOM+1ZP6efdxoHZT1tlHUVs/LDHnVUxmno=;
        b=e7BYeUPGJ35vhNuCKj23lBtLE+/K2fAPB0+nPZbuF9suTCJSeUnzQvb17hVOkYW9TV
         1FeMKYV4DgR0XVhqG9bkcAcc3lPynRCKzcI5KpabTP5CLJRvg9Tx3kQXGILKvS/gs41H
         YdsB/YboDcEysmnuwzOIZ2WQXg69fd30K8rXta+7jmvWfpgliFoor/3lmAvXW8XKGV41
         Hk9HrpFR3p/0u2B3q0IJZcTzJ0880LeM8NROHmUPYyoc64YqABPvsUi+kLSChUncDzAJ
         U6Gr94jVAmD7fPes1++A9dIrrGCGWM5LVG73CdbNV/U7gGUA/+BgCCkxEiv34R+L/ZNK
         0lxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsOPdgnXyFBZcyA93vr0yURiD2xDOzWgcjD6Cw7cs5nk6KfEwUPqO4j8s7EyVVCOr8/nQdAP/uBtCb/z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3ymSpiu82uM7zSO2HHhcQ8Qbsz8XiBUYIoN3lkt3yn6H/Wdh
	XstKBoczhYqCM5ZdEId1rD0wvfbNs0vvOeW+R7zUqIuqIOysPbiHdbA0pV4y4diI7ZI=
X-Gm-Gg: ASbGncvzWk4vu/X6VysT4Q5v27o/mzHk2iy5jrYvb3VDA5Y/7U+qKS4odulqWSKHw+2
	QxVafBrMwjc+5rjkD+9mzrK1TdZT0YpDm3/57ypfPfogIGhOvBK4p3PbelXR84FUYdxntUmP/2R
	vhWGvhaT/97P4v/2f7fAfxaTJEcIQRbHhvHAqL+9Z6X+gP/bH4uPp4TtD4JEPSGqL/0ReqE9rpz
	SjEgeZUfYmyIaEUJjI43Bos7nSLUzZYhyH50b0/GIeitWSJ4y4J6mydm9i7/7fV+xyENZbTSGpr
	g+FWFV4xrRqPk8aZ1dje1tVJq0HCQtMucmXC4Bsl0FDbmc3xZL0D4sZU2Z3qihUhhTHS1553BG8
	RElh/kX6jvo8EbA9YPk7vU1qgadsnDW4ZE3ye3QN+f9zaTn4n+cy7ZtmLIF2FqIXaFXsikcJi8+
	JN840QywsASVKYV/9yiG6YaO9F6M9TrP4H2QQolg==
X-Google-Smtp-Source: AGHT+IHvcVjtU3i+l/XfslQjy66bL0j3tv+P0XVI6VzvvCI0MjbHHb2f1vtJQa8ltGMFapgBfUjvYw==
X-Received: by 2002:a05:6402:21cb:b0:640:7f9c:e90c with SMTP id 4fb4d7f45d1cf-6413f06de7emr3189084a12.27.1762525186212;
        Fri, 07 Nov 2025 06:19:46 -0800 (PST)
Received: from fedora (cpe-94-253-164-190.zg.cable.xnet.hr. [94.253.164.190])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f7139bdsm4245121a12.4.2025.11.07.06.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:19:45 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next] net: sparx5/lan969x: populate netdev of_node
Date: Fri,  7 Nov 2025 15:18:59 +0100
Message-ID: <20251107141936.1085679-1-robert.marko@sartura.hr>
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
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 1d34af78166a..284596f1da04 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -300,7 +300,11 @@ int sparx5_register_netdevs(struct sparx5 *sparx5)
 
 	for (portno = 0; portno < sparx5->data->consts->n_ports; portno++)
 		if (sparx5->ports[portno]) {
-			err = register_netdev(sparx5->ports[portno]->ndev);
+			struct net_device *port_ndev = sparx5->ports[portno]->ndev;
+
+			port_ndev->dev.of_node = sparx5->ports[portno]->of_node;
+
+			err = register_netdev(port_ndev);
 			if (err) {
 				dev_err(sparx5->dev,
 					"port: %02u: netdev registration failed\n",
-- 
2.51.1


