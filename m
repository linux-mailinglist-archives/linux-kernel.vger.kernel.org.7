Return-Path: <linux-kernel+bounces-829489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14CB972FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703231897094
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2F22FF143;
	Tue, 23 Sep 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="MAjoCTIi"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4882DC776;
	Tue, 23 Sep 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651920; cv=pass; b=sZHuy831ZRWCUXySbmkKEZmmGq01higF8GMdnG3d9tyyGJJx3oxIxDl+4t3/LDQI+mOtI6NS78xvoaZpb1R73snBlDjQSjZBEplEw79OQGI0e+kcPP0s40ZurxG+pAPVtE7i8a2Njm0VOjZVBkvvcUDLvNArLaTopkfeMizq1Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651920; c=relaxed/simple;
	bh=CcGi3wDFG9fsSbobIbSsPhS74gvgZpjX2+rpMvxZkyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0yOE1bHfReFa2KXptP/63d+sQRBpYXBBb/nO8UvBMn2UnK4iWPXUQAEvUCraTobCNZazERfU1Cggsl0gveeovtV/LM530ktSSwkBr5VQSw9TCiIcT3lXWssLEbDvPmF9SfEFgRYlq63sKG6Ci+sfSnAUMWbYlJ9RH8+G5JXG1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=MAjoCTIi; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58NIP8Ha037076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 24 Sep 2025 03:25:09 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 52BA810035581;
	Wed, 24 Sep 2025 03:25:08 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eSfbAE6IjWdu; Wed, 24 Sep 2025 03:25:05 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 0934F102D0547; Wed, 24 Sep 2025 03:25:05 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758651905;
	cv=none; b=VMnzEs8Hx+VbCuKjmIAHedko4gciOUIk4uWEEvvcGaEyT6MUi9nliDt4qcg5Sih7G8lnF7pvjW3SIvETtiVsPm90c/aL2gG1e4fxjt5YpgcBPUIczRmt5pU32ZfWN8ESpvdbAuOF2ynYKphDHXj60C6MR2nOYM+elVSajyV4PtU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758651905; c=relaxed/relaxed;
	bh=u4E2ac3BZfQgWsbOyZbl22Tes5An/S2IcDUGIAMz56c=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=jFtB+PbsFnID7xiiPi4LqxECm/XIZCzjvjZpl89AaOtLA7tDdYYecQ1j499LyFSJk3G+tnHdNxzsfwAk8Hkh9VPJ5lzoYMFydpIgTtgnRyapgbBqJ0MjmoXuDDr7BzJolazWMdQw2G33ArEetZWggj2jZjD5uBvVQ1+Yg1xRZxI=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 0934F102D0547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758651905;
	bh=u4E2ac3BZfQgWsbOyZbl22Tes5An/S2IcDUGIAMz56c=;
	h=From:To:Cc:Subject:Date:From;
	b=MAjoCTIiJLjNNbJsRre13aGiuu8v20+MMOtalWrbSV/t3Zlh6UkUBK681X2+ZRfu+
	 cSD0KeYYyTBHvymsKfW2rIRJit1StgRlJxZTimbMOMosnuRX4KXC/39ObvaUay6MxV
	 14I91lorJAfxwttdSDXnT7p5oZeRrPZPlpmAJuUQ=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: dpenkler@gmail.com, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] staging: gpib: tms9914: Fix typo in comment
Date: Wed, 24 Sep 2025 03:25:02 +0900
Message-ID: <20250923182502.2573049-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a typo found by codespell.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/gpib/tms9914/tms9914.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/=
tms9914/tms9914.c
index 04d57108efc7..e238652b12a5 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -535,7 +535,7 @@ int tms9914_read(struct gpib_board *board, struct tms99=
14_priv *priv, u8 *buffer
 		buffer +=3D num_bytes;
 		length -=3D num_bytes;
 	}
-	// read last bytes if we havn't received an END yet
+	// read last bytes if we haven't received an END yet
 	if (*end =3D=3D 0) {
 		// make sure we holdoff after last byte read
 		tms9914_set_holdoff_mode(priv, TMS9914_HOLDOFF_ALL);
--=20
2.47.3


