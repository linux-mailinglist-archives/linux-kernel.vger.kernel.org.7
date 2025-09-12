Return-Path: <linux-kernel+bounces-813066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5225CB5405B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E18916351A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073641DE3C7;
	Fri, 12 Sep 2025 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="VyRrvgNs"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4801D90AD;
	Fri, 12 Sep 2025 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644123; cv=pass; b=teq8/xfL3Zkbqqs7/A5o1k3+1ViSaOhN5//+78sYskfKBI/JxqDAghx4PzZ18Nf0s/a6ryO1tm9cLcRyB2mtJ2NYQsarlB8FamEtWSJqvU4cS/H3i1TiNBH+Bw6ePhB1XMvRxZQbaX+3amiA/nVP0nSqZWoAVC94DVPRfX/e+7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644123; c=relaxed/simple;
	bh=g/uXEYH9ERO80RCXnIRCR4SGEtRcXAB85AgRzR57RtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDh+XuP3LnFpdfLhOWbI/FpCLyt5StmTbkShtBUipUrJCs1z0L6QtXYxZ2IQEtjpTTzo2cYpPIf9izMj2SiitEcxV/ByJQw9xPfg+cDtXe6kUnmfk66nnQgEWxEXb222wp2PJVLMoDIq6yfTO4INDwXGULTBZd3uCQkx7BkmUWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=VyRrvgNs; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58C2SY3f086931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 12 Sep 2025 11:28:34 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id D3BDC109F7118;
	Fri, 12 Sep 2025 11:28:33 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J5Il4MAUspaZ; Fri, 12 Sep 2025 11:28:29 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 808DA109EFAC6; Fri, 12 Sep 2025 11:28:29 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757644109;
	cv=none; b=rX6dzv0emRKeFM9TuN8o7zue9d88TytieiKvt1hzosHFCh1dZ8W3SjDH6xQ4pKA5jv71eQ/UCjQu1A4h10NNXNZ49S5RRt+nxMPLj2eUnGfYdKOKHZhAaYfXhMZeUV7HL0FF5OcK2kP0Szs7GUeiIVzCiaDUUBzQBYW9QjwiK8c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757644109; c=relaxed/relaxed;
	bh=ymB1SH1P2od9SZcdZN1Bzow9DzmfR+PmftBIx0Rmqik=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=BLwEIH/YAXxcS65/2Aae1L7uJynRg4gp3tv2QGERr29kg53F9MGqd3dvJW8Aqm0Co+gwhG3cxFSBXcnibT7FA9lthJeq5Ccg0/UZK5NyS06Vhf6rN57zidoNYMoLj3yXnJyEFBgSfWRCknxYBOODOlVDqDqRmnr3qBa/L9T3DO8=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 808DA109EFAC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757644109;
	bh=ymB1SH1P2od9SZcdZN1Bzow9DzmfR+PmftBIx0Rmqik=;
	h=From:To:Cc:Subject:Date:From;
	b=VyRrvgNstCUN/6c/3xEJntMkeOhqJbrRHAYHTlbHQyuyksXf+SFz3vvXkLBIzerUA
	 gs9nNFH5B6LRfeAjIuDB4EjR9HI59PfZdUoNGJXMD62hprF4tVCmL64KRfj0aPXees
	 T95NtmCBVTnQa5FbQy6Xiift5ehl6oxnDl74iIOE=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH v2] staging: rtl8723bs: fix typo in comment
Date: Fri, 12 Sep 2025 11:28:26 +0900
Message-ID: <20250912022827.676169-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/rtl8723bs/hal/hal_pwr_seq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c b/drivers/staging/=
rtl8723bs/hal/hal_pwr_seq.c
index 2438931ca51b..fba67a7c069c 100644
--- a/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
+++ b/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
@@ -8,7 +8,7 @@
 /*
 *
 This file includes all kinds of Power Action event for RTL8723B
-and corresponding hardware configurtions which are released from HW SD.
+and corresponding hardware configurations which are released from HW SD.
=20
 Major Change History:
 	When       Who               What
--=20
2.47.3


