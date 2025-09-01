Return-Path: <linux-kernel+bounces-794477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413B0B3E260
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3F91A82507
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD618277026;
	Mon,  1 Sep 2025 12:12:47 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E902226D17;
	Mon,  1 Sep 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728767; cv=none; b=LVztYQ3Bu0T2ZLMT+NYLuiDixA7U5XJEXuPQyPsu9cSsexQWb+jEmfrMlD4/DaO25E6m60iqdYe/8FuPbFUxV07x0ggKzeh4beFLjoBslhJhRc8Q8uyBiTvl0oQ2LNOl55GFSw7z9ti72RytNtCm2zBFIQtiZyHQPxu0kcjoFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728767; c=relaxed/simple;
	bh=MpykzzBhuyvDECbIBCh5BjPCKqV8M26qmAnPgeJnMqY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=AxN/W55inLzBSsGnYOVeCZ0sf3OW/QJCZpAl/t2WojuLfWjb17GvnmEnzZceJ3hHHXCPpTQiPy+zJ+7jTcjTKXf+9FnCliWHFFWmVE5hIai/tsrmq4cxH1TmY0c+DDIFYnN4IuU71N6arXXwSQAnTYWoqeT2dCyjA42N6UtvuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cFnnJ1LjRz5PM3M;
	Mon, 01 Sep 2025 20:12:36 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 581CAN2H024220;
	Mon, 1 Sep 2025 20:10:23 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 1 Sep 2025 20:10:26 +0800 (CST)
Date: Mon, 1 Sep 2025 20:10:26 +0800 (CST)
X-Zmail-TransId: 2afa68b58d328d6-9576f
X-Mailer: Zmail v1.0
Message-ID: <202509012010265342J9_GMWSos_c0nszWwdsj@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>, <corbet@lwn.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <fan.yu9@zte.com.cn>, <wang.yaxin@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHRvb2xzL2dldGRlbGF5czogZml4IGZvcm1hdHRpbmcgZXJyb3I=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 581CAN2H024220
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 01 Sep 2025 20:12:36 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B58DB3.001/4cFnnJ1LjRz5PM3M

From: Fan Yu <fan.yu9@zte.com.cn>

Add a missing space in err() function call for consistency.
The change improves consistency with the codebase style
and enhances readability.

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 tools/accounting/getdelays.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 21cb3c3d1331..0c721efafab9 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -570,7 +570,7 @@ int main(int argc, char *argv[])
                                                        task_context_switch_counts((struct taskstats *) NLA_DATA(na));
                                                if (fd) {
                                                        if (write(fd, NLA_DATA(na), na->nla_len) < 0) {
-                                                               err(1,"write error\n");
+                                                               err(1, "write error\n");
                                                        }
                                                }
                                                if (!loop)
-- 
2.25.1

