Return-Path: <linux-kernel+bounces-725210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E32AFFC07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D49544BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479D028D837;
	Thu, 10 Jul 2025 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IreOlGsQ"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDDD28C87C;
	Thu, 10 Jul 2025 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135583; cv=none; b=XGQV65bzMEa8CuIWzqCYdjTu8YZkQh3KYXM+nAFCkbeqlHmSvsXRlT8bCw2GbKlIRCAzJFSgNNLPKhu2kzWVITj+dNlctMqu1BrcV90+fqqmUi3CKOiUuxLNG23mmiIj5+cm/wkFihhm9yIXv+FpHUToMZHEkGXzXbTtCb/IuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135583; c=relaxed/simple;
	bh=cPa0vR7JxoXcwBgmLMAumrfFT2HcMgxfIBiuqRRWEGw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=XCwcos85Ws1FYxiJolfy0QNA5IC51cPBmlQ0w9qI1B0QJcnFqPTO4ygS+/7/mRQzVbdpkW+Jl8WsSHPiZ3/1nwDUeha9LXD2jMV/+R9dQOUJQ+Iqt9o/ZfMtlVRToCUCR+swDmpgZ28m1iD8LFoouS1TIjInYNxL8pY7hTww0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IreOlGsQ; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752135267; bh=UDJSufRH7MdpT73PTeJHI5B5xQ/ocRLDn19NK0yHIMQ=;
	h=From:To:Cc:Subject:Date;
	b=IreOlGsQ+tw/SEuB6cj2mkcGmHDKMh8vLroqQxC3XqQ/enCqcK+mOY0WBFrtYlF+9
	 B8j2on/HEG27ho5ts2FcgsehOkVP9ZM725gRe9bmbRM4hjkJ06lQwTiOp0wurum//t
	 qR1yGDoe2EOnfXu/3YkDEiLBa8K81jLKMctOyUro=
Received: from VM-222-126-tencentos.localdomain ([14.22.11.164])
	by newxmesmtplogicsvrsza28-0.qq.com (NewEsmtp) with SMTP
	id 3998EE76; Thu, 10 Jul 2025 16:14:25 +0800
X-QQ-mid: xmsmtpt1752135265tzefjw1zb
Message-ID: <tencent_8E3F0D0AD7E5F6DC1F3009EA1DB7391A8505@qq.com>
X-QQ-XMAILINFO: ML9YGTkUAlSnKW9XbBOS+XuF04tvmh5Gcnes7kKAR9AU//kODsNwoHw13JwxkL
	 c59CFhLAAFryd9M0TvcPZSXsZHMF8uyCcH8eS6B+ZXbuBfizNnr5+bz63KF56/Dfqu/RluLxU6Mk
	 UtZx/xx0weo+lTYGXS082E31vYAzhoQKzkZAmxYVEfhvh74ohhzJ6yVjbIwJ0D6Wvzqcu628eX5U
	 knDnbPUKYYFkxhGIJq7SX5OV8XrXq6F8zqor6rUxcrV6daRqUM7eNjsa8kKwjbhQKI8yhiCbORCs
	 zwDOUD33b0x3qiv9T+d43sm6GHfGhvIZ48l4Qzyl7rwKFXef9mtx2+Y3/jsYAyPx7/8r3uRcLc0M
	 TGhkjdzSQiIPOjzAI9WKkiorMS0989I1MkvbKlepPIDla92q9TeRQotciZFVp6tSutBkQ4fRUd5E
	 9gtplsbp5ldnfrrr3OmQ66A3AzZCz/uu0uSERglCtZDii4wV/S1UMHe8mirlt6szcipMR49wf/ET
	 wzGzGHmQSJXzEylzZUPj6Xc0Of74Tsw38ONuIb6oDv1w3LpUi9LiatLIY6U3CgQ9cEj3v3n9xEKr
	 U10nAz/Qcu8L6fhe0uC8v/o0ydTBJYGXuvAOGSvWm4LhWNuoCU2Y7S9t6pKSvIYqZDn/FYLnVTJ8
	 cnJtWNiY5s5MT+E4EXnwLi15q7Faxv4sOJKKamrOZaKDk4IrfWiMqCdDkFyrZXkyYLmBOs9qLfpT
	 pC3qghWSKcnBMCVl9kwz9R/xmEeDTsev8LqecnDFSLqVvevAryXwaZFyQFUiPe2gB52uYXf6stlN
	 94eXFAC/rAl2kygXwYENrSWZI3u5fAVKa1gLW9TUD+B9H//8uXrgZW7/8mb+E8yNXQV+1L1fFe2R
	 UmmAS/FIXfieBn1hQmPLUyZ1IgXPDgvsH51iQpnVZmSYmzL7H0HDGINg2dDa2QIgtWT5X2ZRRYv2
	 5FVKp/WcY49bz+FEQS0N3sSpyVLY/hIV5YxDM5Q1dGgvaK/yzdAjJkzE+/c3WUiDHwwox8xchcHf
	 3V3E6K9wmsGe1X4zjY
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: jackysliu <1972843537@qq.com>
To: gregkh@linuxfoundation.org
Cc: 1972843537@qq.com,
	viro@zeniv.linux.org.uk,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: functioni: Fix a oob problem in rndis
Date: Thu, 10 Jul 2025 16:14:18 +0800
X-OQ-MSGID: <20250710081418.131900-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A critical out-of-bounds memory access vulnerability exists in the RNDIS
(Remote Network Driver Interface Specification) implementation.
The vulnerability stems from insufficient boundary validation when
processing SET requests with user-controlled InformationBufferOffset
and InformationBufferLength parameters.

The vulnerability can be fixed by adding addtional boundary checks

Signed-off-by: jackysliu <1972843537@qq.com>
---
 drivers/usb/gadget/function/rndis.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index afd75d72412c..cc522fb4c06c 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -641,7 +641,8 @@ static int rndis_set_response(struct rndis_params *params,
 	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
 	if ((BufLength > RNDIS_MAX_TOTAL_SIZE) ||
 	    (BufOffset > RNDIS_MAX_TOTAL_SIZE) ||
-	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE))
+	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE) ||
+		(BufOffset + BufLength+8 > RNDIS_MAX_TOTAL_SIZE))
 		    return -EINVAL;
 
 	r = rndis_add_response(params, sizeof(rndis_set_cmplt_type));
-- 
2.43.5


