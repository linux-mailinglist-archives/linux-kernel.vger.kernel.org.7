Return-Path: <linux-kernel+bounces-744902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7E7B1124F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D2916F32C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0BD2517AA;
	Thu, 24 Jul 2025 20:28:00 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7A24BD02
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388880; cv=none; b=rbk6ETPVXGN3HV9uAxB/r7MRtOXAp2+aUgQA1mOJNZbVtO+qcyZGYjVm8JjRI5Ll3lPbMWSUlQluwN9Eqome9Ay3eMVDfB46G5JOV02ma0kbmtvdI7eS7sk9XA6MoPu1PcY+7C1p6fokhpDunkAGvBOt6n0MD3Otxgfj5B3inqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388880; c=relaxed/simple;
	bh=zNtrBu+kTs/smfECqJRyT2HxTKly8gxYBZ22kH5Z5/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbMJcdA7p+pZEPHZvHsfWzZT1VvzfUMUZjqh4coXFicoRsUjw2GREJdSE7aAY/QTr4D4Tfu8dr3HXwo3Dc3xnEeYeHmPbDD/hm5/ITy8oIhGjPTV7ziwbzyq6qrHp69ypcJWg2pXU3xZMiQRX/WJz3hCByT++XtBg3mpKwC6XBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:3262:d069:d197:592c])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id B8F6740239;
	Thu, 24 Jul 2025 20:27:49 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:3262:d069:d197:592c) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: syztest
Date: Thu, 24 Jul 2025 21:27:44 +0100
Message-ID: <20250724202744.101807-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <687e8e18.a70a0220.693ce.00f4.GAE@google.com>
References: <687e8e18.a70a0220.693ce.00f4.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175338887021.20311.1597650206083317691@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1636,7 +1636,7 @@ static int do_insn_ioctl(struct comedi_device *dev,
 		n_data = MAX_SAMPLES;
 	}
 
-	data = kmalloc_array(n_data, sizeof(unsigned int), GFP_KERNEL);
+	data = kcalloc(n_data, sizeof(unsigned int), GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error;
-- 


