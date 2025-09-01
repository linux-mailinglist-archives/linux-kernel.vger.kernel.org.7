Return-Path: <linux-kernel+bounces-794498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E55B3E2A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E95443EF8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD231E0E9;
	Mon,  1 Sep 2025 12:24:36 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952FD31197A;
	Mon,  1 Sep 2025 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729476; cv=none; b=kd350lHke+/VXXB9oeunWvVGOo3RCbVC7yzDULSGnlFve/cqy+rBAMHJzEd8OvAR2VRQnGnNgNAG/vqCOhF/k0zjwkFuS1/4reY2to/4d1DUVEYlMBCIkiNn7dh8knS2TyXvpEfj1QeoL2k1C/ZixkzVWPQDsPGsOZY5b438y1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729476; c=relaxed/simple;
	bh=JL/8WhJDqZDZcUhtLpsOa9CfO2TM/nTblKJLHTLB7kk=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=koEKVsRfUXGG+AaGpANhTGwUZZpZw7Hkx39+2eEZuPz5WBjbdhB28CI3LysS9EVKZ31PSSH+/k5VSUxNAfEK2CcopAPyuMk/aNf/7lPZr5soOUjQsV3yFp+NIJP4l3Lv93lM8A70E1d1RUDjqLp/Zx9ScWz8SC+hJjdtZ46BRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cFp2r6LJ6z5B13Z;
	Mon, 01 Sep 2025 20:24:20 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 581COCTM095944;
	Mon, 1 Sep 2025 20:24:12 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 1 Sep 2025 20:24:15 +0800 (CST)
Date: Mon, 1 Sep 2025 20:24:15 +0800 (CST)
X-Zmail-TransId: 2af968b5906fa09-a988e
X-Mailer: Zmail v1.0
Message-ID: <20250901202415061CsA3s6BAjQfijGxfZU_If@zte.com.cn>
In-Reply-To: <202509012010265342J9_GMWSos_c0nszWwdsj@zte.com.cn>
References: 202509012010265342J9_GMWSos_c0nszWwdsj@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <fan.yu9@zte.com.cn>
Cc: <akpm@linux-foundation.org>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <fan.yu9@zte.com.cn>, <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSB0b29scy9nZXRkZWxheXM6IGZpeCBmb3JtYXR0aW5nIGVycm9y?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 581COCTM095944
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 01 Sep 2025 20:24:20 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B59074.003/4cFp2r6LJ6z5B13Z

>From: Fan Yu <fan.yu9@zte.com.cn>
>
>Add a missing space in err() function call for consistency.
>The change improves consistency with the codebase style
>and enhances readability.
>
>Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
>---
>tools/accounting/getdelays.c | 2 +-
>1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
>index 21cb3c3d1331..0c721efafab9 100644
>--- a/tools/accounting/getdelays.c
>+++ b/tools/accounting/getdelays.c
>@@ -570,7 +570,7 @@ int main(int argc, char *argv[])
>task_context_switch_counts((struct taskstats *) NLA_DATA(na));
>if (fd) {
>if (write(fd, NLA_DATA(na), na->nla_len) < 0) {
>- err(1,"write error\n");
>+ err(1, "write error\n");
>}
>}
>if (!loop)

Reviewed-by: Wang Yaxin <wang.yaxin@zte.com.cn>

Thanks
Yaxin

