Return-Path: <linux-kernel+bounces-806107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303E5B491F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF2F3AA9E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365730B500;
	Mon,  8 Sep 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="Za5epwye"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962215853B;
	Mon,  8 Sep 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342825; cv=pass; b=WxajCA2zVh8u4V2LrczMo91UZr7vP3VMRowet2J3HtdLtjP+IkVMbPt4U7/HrPCURxIPegw+NtwKZD1LCQ4saLKCiURG7q+QjEhwQrq9uOvLYLIJWFQ/WjCpNwax35Hd/RzLmb8/GVZ9JgtsKZLIXikVLWHfd6FKLQgekVBneSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342825; c=relaxed/simple;
	bh=x7crhV08VPBnsufEovoxAY4NKlFOuXVLkS5Eme/gQ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcxTN/+1jeK1nogHRK+5lLClBzclYZyEhvWaTe7nKJbJOE/2IPfmi9rFz0YQN1LSZd+/dLFxNr0s6ouJmw+ObFpmyaolJxyl1+i4afbYCr4jhysP3SWDdNIybHysXbUJS50UmhNW8g4tfsejDgntgywbQOwFlr0xt61iL1qrMiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=Za5epwye; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 588EknhB011754
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 8 Sep 2025 23:46:49 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id E28D010A2494C;
	Mon,  8 Sep 2025 23:46:48 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ILztLWlsm_1U; Mon,  8 Sep 2025 23:46:45 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id D7C1B109C12BC; Mon,  8 Sep 2025 23:46:44 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757342804;
	cv=none; b=Yb9mTTu88UZWXCuHIlyiwA3tdVkIFgWZLQ/YzTiETPh6rfVMWh58taLLENPzHhZYRPQlvalCl9zQlww9Xhw+tKDZHxGo+GzElpGmFpj9i0ut8v8OlMyMmS0MzYpnCNcP385yzJeZ3aPaIdmXgK8E8C5QCE1zT4cdmSYSErgXEy8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757342804; c=relaxed/relaxed;
	bh=FB9DSy76R+KkspwmLdy7aTmCl+PBGT6k/7lmJ25wzDA=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=je1Y28R+zXs6SPTTPvaL9BgUu912JZNxjG3h8XglfKzKLxJpTmU75hktrqRRwQ+NMcjowUhE3sYwwlK60dqoyPGL7o0h6Y+o5VMLPIJqdMX0ppTZ2dK+S/hPKwqv0BczvY5Km7afXhDJCtbat5yjeVNJUXHfHLNCwC2RxhVtc70=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org D7C1B109C12BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757342804;
	bh=FB9DSy76R+KkspwmLdy7aTmCl+PBGT6k/7lmJ25wzDA=;
	h=From:To:Cc:Subject:Date:From;
	b=Za5epwyegoMrSgbwNd00vRQaDHhvn0a7o1yxicxzP78N2WtArhHoyPl3WVHGxpozr
	 Va0ykpVdssLVdvL5G4Yv3HXIsqpC0CqVxa7e99jGsicliUZTkX92fxZCCG/LSkK0a7
	 yCDSmKbJw92HtuRkBJvHxMrFI3rVV0FGAUzCyMvI=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] staging: rtl8723bs: fix coding style in hal_com_phycfg.c
Date: Mon,  8 Sep 2025 23:46:41 +0900
Message-ID: <20250908144641.39518-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function definition for phy_StoreTxPowerByRateBase() did not
follow the kernel coding style.

Move the closing parenthesis to the same line as the argument to fix
the style issue reported by checkpatch.pl.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/stagi=
ng/rtl8723bs/hal/hal_com_phycfg.c
index d5649e7d8f99..f137ec747ab3 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -60,9 +60,7 @@ phy_SetTxPowerByRateBase(struct adapter *Adapter, u8 RfPa=
th,
 }
=20
 static void
-phy_StoreTxPowerByRateBase(
-struct adapter *padapter
-	)
+phy_StoreTxPowerByRateBase(struct adapter *padapter)
 {
 	u8 path, base;
=20
--=20
2.47.3


