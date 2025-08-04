Return-Path: <linux-kernel+bounces-755195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC6BB1A2EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39861892A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40749261594;
	Mon,  4 Aug 2025 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="IflIlvJU"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916FC22D4C0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312859; cv=none; b=I3pTU+tyetkWL+PVvR/VQqU5/sS7oR+i5ZXCvLnklGZ9VzHk+fGKkMMgD8qD2i6ephK5zhdBR76jFqZvDO2POOYqZApH5IPbqLzryCn3rjdV1vmCWgPgQP/19SE+IhxdV1P8spQzIC8MUIglcOtb2gy3ZzTXB4A69XT5NvsCeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312859; c=relaxed/simple;
	bh=tXY0UG9dEPlaD0d+syf1G87HcAD/g5qfseSBwhr/oVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTCgUHFXW8LyOK3d5yB1vAetp++XhkbhVBfudorL5mChdXexNAY6KqCKZBg7PVHOeZtlPeUs+wbpX5qkL3SqmRMJc5JUUs+jEbEiytLJWNhNU8gQAqmCcIi5TVp7Y+mDYmYMrpujF5ARwE9RaNc8Ak72we6aXSCpcuf7iuLLGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=IflIlvJU; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=DaP0ayMeGByY0ROe63H0HewzgwwoiTuHUzxlFsQn5vc=; b=IflIlvJUMBjYUqWkKpmBSRGQje
	9XylnDnR5Mh8AdUow0Na6XIoAJAsqVJLLQWsZh5Z0wDxL9D5FXoTBYlabqMwmxu+smUPdqsf9BJ5p
	Yz7blE9zN1iUmCVuvJnq1795mrTqcSl7za3HsEVo+3ve6aUnFB2skJDcF1rjx9IeOjuuFIxcrAIOu
	6BBxc5MNY8A2GddppSbHWXdXMrSygvWKPbg0IQf/tZ2Fnn3QLyNF3u0Y2rHRe2RllH70QP/gSapt+
	cZpTK/bWrNu4hAovvxfD57OXtPRFS+t4Xq4a+sK9YJ00BnEKVjYFiKHmat5yksZrpsPgbSizdeov/
	9XIjQOaQ==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uiuuc-0004Ov-LV; Mon, 04 Aug 2025 15:07:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mfd: qnap-mcu: include linux/types.h in qnap-mcu.h shared header
Date: Mon,  4 Aug 2025 15:07:23 +0200
Message-ID: <20250804130726.3180806-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804130726.3180806-1-heiko@sntech.de>
References: <20250804130726.3180806-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Relying on other components to include those basic types is unrelyable
and may cause compile errors like:

../include/linux/mfd/qnap-mcu.h:13:9: error: unknown type name ‘u32’
   13 |         u32 baud_rate;
      |         ^~~
../include/linux/mfd/qnap-mcu.h:17:9: error: unknown type name ‘bool’
   17 |         bool usb_led;
      |         ^~~~

So make sure, the types used in the header are available.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/mfd/qnap-mcu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mfd/qnap-mcu.h b/include/linux/mfd/qnap-mcu.h
index 8d48c212fd44..42bf523f9a5b 100644
--- a/include/linux/mfd/qnap-mcu.h
+++ b/include/linux/mfd/qnap-mcu.h
@@ -7,6 +7,8 @@
 #ifndef _LINUX_QNAP_MCU_H_
 #define _LINUX_QNAP_MCU_H_
 
+#include <linux/types.h>
+
 struct qnap_mcu;
 
 struct qnap_mcu_variant {
-- 
2.47.2


