Return-Path: <linux-kernel+bounces-771007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27ABB2817F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19993BA097E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8DA21ADDB;
	Fri, 15 Aug 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="cW7GSEes"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA66F1EEA55
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267495; cv=none; b=Pwjrh+aJg6lkTEYPgz6Cty6POw+GeLy5kEwvLbYlPRbONHkhitJdEqy1Q7SBit97lmM89MysorNDHOby83Lo6ecDMfLgAGFqSVII0tABnNAA4j4yZeDOYV+fbnQbrT0TN9xHm4hqjZK+YJ3X6L2gYFYQgPu8L5/Vc+60KkfEOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267495; c=relaxed/simple;
	bh=4gsRnxE7oChc+quIPbsFQFun/LgwmjpEeBQUUQFNXE8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHjyBxAKk3GE5VHju9K52ZZe4CYOnhOK186ZMhG0nXkBFxvhzRh2Vyx4j68RySzV8IkDsO78khrBCMjtRqfXeh6zwGOSv/upWUpyFxxKwpxDAcV8NCtZs36ZJ8yfwmAuE5NVTr9s5/Lj/IsA7U4yh4vURs6P8QxPBoiBk56CxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=cW7GSEes; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 21999 invoked from network); 15 Aug 2025 16:18:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1755267488; bh=W+cgyWCHh4UHsnG/f+L/GZSsjoqYku5IHQm6xXiUyE0=;
          h=From:To:Subject;
          b=cW7GSEesx6mYoQrntvvPh4ng667KYcG+C228mzbhGMoFMmrMNMrhUkMA8vYatUxdX
           N3byiaaG33XU6X4gaup+2rKu54OYVRVisRh+c6jrz5uehBsnaN4bsA31Kz74NsNby4
           JAcMeCZ/gEk8PE+913qDxQBgtHgmFtGkYQweBAw6LFCoNmUdEV5QRMugQdqJXl+e2X
           kMv61LkhFdQKlKtBQwrWBd1xvzNkKMRo+0XVD7ufoI49jN4AcZAhnHe0/j4YvhlSZK
           bUuTqSMrT2uOUY8Dvx2w7FCN2Sfpd/jCS+umpmEUldVKvVOpxx2KX2IQ6kSnl/a2+d
           /6Rw3WtkpuWJg==
Received: from 83.24.134.210.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.134.210])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <tsbogend@alpha.franken.de>; 15 Aug 2025 16:18:08 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: tsbogend@alpha.franken.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	olek2@wp.pl,
	john@phrozen.org,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: mips: lantiq: cgu: add name pattern
Date: Fri, 15 Aug 2025 16:17:41 +0200
Message-ID: <20250815141759.3408909-2-olek2@wp.pl>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815141759.3408909-1-olek2@wp.pl>
References: <20250815141759.3408909-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: b14e8c37daf643f3a536705f3ad097e7
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [4cPk]                               

Lantiq target doesn't use Common clock Framework and requires strict
node names. This patch adds the name pattern to the binding.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 Documentation/devicetree/bindings/mips/lantiq/lantiq,cgu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/lantiq/lantiq,cgu.yaml b/Documentation/devicetree/bindings/mips/lantiq/lantiq,cgu.yaml
index d5805725befb..6a6127a09087 100644
--- a/Documentation/devicetree/bindings/mips/lantiq/lantiq,cgu.yaml
+++ b/Documentation/devicetree/bindings/mips/lantiq/lantiq,cgu.yaml
@@ -10,6 +10,9 @@ maintainers:
   - John Crispin <john@phrozen.org>
 
 properties:
+  $nodename:
+    pattern: "^cgu@[0-9a-f]+$"
+
   compatible:
     items:
       - enum:
-- 
2.47.2


