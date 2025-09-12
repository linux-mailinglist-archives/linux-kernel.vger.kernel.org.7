Return-Path: <linux-kernel+bounces-813285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89570B54323
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43733AA1B45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E382857FC;
	Fri, 12 Sep 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="ldVdGvTC"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF32750F2;
	Fri, 12 Sep 2025 06:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659464; cv=pass; b=h3ycuFDUzgcQw5x1dBNk3tfBYTbutdr+kKasETBSvBcZw9Ipra15pMpAveSbgzvA+CGhQ7fRLsMFwLVfOQW7uhHQOTcw40vZtdknSoyymioy1B2Y15S7xt3K3MlYcsWrS63vgkBSK5xx2nwEJAcU8IrEHWiQnYIBIsIt3iTecvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659464; c=relaxed/simple;
	bh=+yXw+yTNyO4V7IKclB3JGNpOoeVDuHadn6UlGgHeNH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWNsnTDRg0SB4PMyBhk9IlbewIBAu/OZYpPkW5uOSZP4Wnd26sOfr7FEE3AqpFRSxGseONrGnhHHHO/QJ1lcybnKJFy0fkqZp3PEeDqirKwMo3vApxgE07Ta4mt0IL72xDPF6PZVUyJlX2LjcCnqxIMRRwiE52MOkFISOWsuq9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=ldVdGvTC; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58C6iDgh077816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 12 Sep 2025 15:44:14 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 8818F109F7118;
	Fri, 12 Sep 2025 15:44:13 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 64P7vzqD880y; Fri, 12 Sep 2025 15:44:09 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 8792F109EFAC6; Fri, 12 Sep 2025 15:44:09 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757659449;
	cv=none; b=gtLnqdZNMmR688bS0oIF5DQsITXLaKw/0/UCSDW/RyopFij7z3xSAO99Hvt/jaW6sBcTOuSjEBVIT5jyRZO03U9Vusf4f/qpVPTSOgZWwIQxkaLFJrLXf9ofnSbnw1f4geOUiWIyeJaRkqejT+oM9eubeJxIjoXmoyr+iovhr9w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757659449; c=relaxed/relaxed;
	bh=9GjSQTWfZ3KYWgvDn4c5iH03yGzcluMmqTkSGunr0oM=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=ybbtrxZhjBm5kYHbFrSMxl4PJI8jjWvxq8i6HQtQd8DVPoJTxHOSAfX2Bd74DjcsXjmklmv0FWRZJkncXaafTTwHG9NopEn9N6UyVAx6c/XRMaCZ6pI1+/Dk75ZoNihgEij2Kkb89axOL9OaiyYivHq8CjSYEL/XGLDbhqB18YI=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 8792F109EFAC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757659449;
	bh=9GjSQTWfZ3KYWgvDn4c5iH03yGzcluMmqTkSGunr0oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldVdGvTCVa/6P26owRZO/y7xCRIhbCx2AGdLobhvQWWz9kCLr2H+2ww4fAR24sXmW
	 Y2dQWdxjsPXwJHwfslJsOnuLdzUULH5KwpghE2ziSaf6WQUfVBU6Y+OYV7MyPtyX3x
	 LeCispBEDRxR8QZIkJAFjDMXKspbyDk5tlLz6mL8=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH v4] staging: rtl8723bs: fix typo in comment
Date: Fri, 12 Sep 2025 15:44:06 +0900
Message-ID: <20250912064406.707039-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2025091223-dispatch-angriness-7516@gregkh>
References: <2025091223-dispatch-angriness-7516@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a misspelling in a header comment: "configurtions" -> "configurations".

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
v4:
  - Correct reversed diff.
  - Drop "No functional change." per review.

 drivers/staging/rtl8723bs/hal/hal_pwr_seq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c b/drivers/staging/=
rtl8723bs/hal/hal_pwr_seq.c
index fba67a7c069c..2438931ca51b 100644
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


