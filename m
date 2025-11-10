Return-Path: <linux-kernel+bounces-892800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F23CC45DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 058964EE8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AFF3054C2;
	Mon, 10 Nov 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="KyD/G4sZ"
Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB935303A00;
	Mon, 10 Nov 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769495; cv=pass; b=qPq8d84IU7CPUdxzQAUjeBwE+aufkoLsTCKjwa57O02ejGeZse3RY+9SG4eKUNLM+FFKsruLCmMA8f1GFZN6WxSMsrkQXl3SdKw/6YEODhhIQ0FF/4adydQp0tUNxT+t8tMdNY4ciJ1c0eEHXaJh/t4+pwI9TwUGPi2vdG+Nk7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769495; c=relaxed/simple;
	bh=O+cKx9jwrS/Ki4QUd/qTabygkwMGB4NieelMMR7+b0M=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=fMzt2Z59wLaO71PL0M08AS27ge8rDEuSZ4+DIYSWVZcvBH7NYUWHBcHnh864UByQDPDrCfWJJ6VbNtzq6KpANEvHGhCa7ZeEq71xr9N4oR4F9BVW0z9XX+Cvjy1jvww4hChWnGLDjDduzQmtnpamHTkI/QRNcQPFpQgAY8DbNRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=KyD/G4sZ; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0FDF24610B4;
	Mon, 10 Nov 2025 10:11:26 +0000 (UTC)
Received: from fr-int-smtpout19.hostinger.io (100-124-152-27.trex-nlb.outbound.svc.cluster.local [100.124.152.27])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6535A4618CC;
	Mon, 10 Nov 2025 10:11:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762769485; a=rsa-sha256;
	cv=none;
	b=nRLB6YBrKv1gNpsdHHYHa2Qin4+LoX7V2CnJOsadfIzntZ0XsFS2mTpu1svs55MPbD6a+W
	UlT90d6S1M6Z7TdxJxdbtsoEwTezXHXr5/alYfYeSPBTLGZjIARbebdb5CMO7XA8LSLX7e
	mBa/RE3UAPz5d3CvGbQ3fiME+ugQe50s3ZeH7HUs0wtZ1Ma+PqlfThanNTQIp8w4ARJSyT
	zXZ9/S3xfiso0gd3LmbxM7wp6LplQOpI4qQhjeVXxfSapUmrMf3EGIDzksc8H6S6gqMOcM
	1qjwt9bEh9DY2mfb/3jeQQder8zrDXDHdZ4RO2VYcufHFKROKymNCGGEy0a2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762769485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wv3nqbaAcoK237kl6M6hgh2lZMBA0q3s8XRwe89wOGs=;
	b=ouvUe+TOSC/n7x949nM35FzWp3wtM3ji+V99CAJo5qVHBETkUmIIyWgOM9g2pT/dGYGLxb
	f20MeUz6wKGZwMaZVVb1rhtf6JaoKI42AiAa6Ip7oiU+dJaPs3ora6/7XNDeUC7TEz79/g
	V0C+GCA6GVsbp4EwDWWF+DYA9VcLEMwZWZhCZIUbb2ucjIBkL9PUHX7IC2GHTCV9QUE2f+
	iNjnYBFiRcxshnC/LsABR+r6kw/elGqj8j3vejqkebmYBVcLYOy8B9fDVkonsUprZkNuSl
	1c3yWCeN8hkWdraBNNfOjqc6rsq4ZTECes2CSAH6l7Zvhk/vbMXvPrPWOBZBlg==
ARC-Authentication-Results: i=1;
	rspamd-77bb85d8d5-r7qnn;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Tart-Spicy: 172f72206bbb80f7_1762769485924_4217622453
X-MC-Loop-Signature: 1762769485924:2509645552
X-MC-Ingress-Time: 1762769485923
Received: from fr-int-smtpout19.hostinger.io (fr-int-smtpout19.hostinger.io
 [148.222.54.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.152.27 (trex/7.1.3);
	Mon, 10 Nov 2025 10:11:25 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:7d90:b645:1639:d009])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4d4ln45wnJz1xxR;
	Mon, 10 Nov 2025 10:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1762769481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wv3nqbaAcoK237kl6M6hgh2lZMBA0q3s8XRwe89wOGs=;
	b=KyD/G4sZrY3FoJOXp24zKmDhvUcwjt35jtW90wNhh72vXf+GNweIbJ5FykHHOyOWkR01Rc
	mujg41iHMrzwezeEkl+esmKcTWFJDAUKoQsaZCAm9usWElgXusX1bgSpgvq0z4QA//GLUq
	4/+Grv1U47vHQTIj+nOvrTcbV8vPtX05Pvz++w+qW04cZ/B/OSXP0nT2HsbdgO40+1/YOK
	YEwm537AUK/C3U0ZFStfxZ4LCz0ZzsOxJ//hEovsyoG6uqXBbo0m7w06MKVW+S9r2NK5B/
	f+wed+Hn9+LVe60LJKcwsR7q40oxXkJfQOU/W/LS2Bhrn8IfLvjVAK7lLp9w8g==
From: michael.opdenacker@rootcommit.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Yangyu Chen <cyy@cyyself.name>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S board
Message-ID: <20251110101110.948198-2-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110101110.948198-1-michael.opdenacker@rootcommit.com>
References: <20251110101110.948198-1-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Mon, 10 Nov 2025 10:11:20 +0000 (UTC)
X-CM-Envelope: MS4xfKatZgfJ8jxp/fEczryQ1HCdtNpCrfQ4+siPi4GjxU1OYoXHupJHe/BWZ3ZKT8zMiKFQ2MoJxWEVQJFR3DqjbGhVbDwmqEyohlPobaLvBfDY3I187Dx7 ffsGa7LJRQAv03F1tz3Ot0DZAhoaSc3X0U7ZNgOi9JRIFhhM6pU77getIgJ+qqkdl0n3Y+5lcFMmtu480pjJnUtnskkJzphLYG1ptLuvGCk2uN9Z0N+UPYf7 jETQeBY6GDXWuyQeHEjOMeBUnDOVKhsPTGO1gJyW05Z/Zt2di/OcCO+YxSXzXkRP5zMXRzPF7dbeQAluV7NbY4R2ymBvSZ9SX6mhRdY0MRClZzu21YsrQ3yU ziyvKkxcjSvVqix6S3rY7gGb8Jhi5rWQLDqSZke76qHMmv/WR2MAmsd6bXDNjGtSkjEfV/8ZY6UFhMX84AtsxNuZ/pjKudnsqWkFwl+FY/5o5CoVQ8pP6IU6 lNn0dxN0kKjNjqElPXfrxB8ev/L2HGI0c669r5Hnztg5W5paTBd9AowlIpaOWpwIFaJYEOfXYCXyRcJCl10i6DqyZcYkaihLSZYAeVmwJjT+k67LuWF3en8C 95wXW4J5rNJQdMG0WVfuhqp+oNatc3POcQ8jrVhZwN9afeMGD2HjwDTLLbc6UDkUfmv7+r73+JH1Kwz1Yi1kPFWmOMP3tp5ufl48D660kt/xCMoGYZQO8snH E5PF5/pAiGI=
X-CM-Analysis: v=2.4 cv=NuiDcNdJ c=1 sm=1 tr=0 ts=6911ba49 a=G6G7neK3IwemRqrlzYSHdw==:617 a=xqWC_Br6kY4A:10 a=5dAzR5NRAAAA:8 a=lv0vYI88AAAA:8 a=d70CFdQeAAAA:8 a=ahLzFxuTVLoCwVWoPR8A:9 a=9STjDIb-X-UA:10 a=ZKAZAlVgJm32z6MX8p4a:22 a=9qqun4PRrEabIEPCFt1_:22 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Document the compatible string for the OrangePi R2S board [1], which
is marketed as using the Ky X1 SoC but is in fact identical to
the SpacemiT K1 SoC [2].

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-R2S.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index 52fe39296031..1b2f279d31f9 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -24,6 +24,7 @@ properties:
               - milkv,jupiter
               - spacemit,musepi-pro
               - xunlong,orangepi-rv2
+              - xunlong,orangepi-r2s
           - const: spacemit,k1
 
 additionalProperties: true

