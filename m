Return-Path: <linux-kernel+bounces-762198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B75B2034D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2647B7AE53B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD82DE1E4;
	Mon, 11 Aug 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W2x4wT1p"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3472DD5E0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904341; cv=none; b=ecV7A0o+21GrTl7N06zjGlb1FpqbC9Kt14lYrK7yusz7mhlYUC/486ftNLaakVJc/QPwky1f6UG3tIUo7zEsxnoLrzOU2r/9/7gW8nics8UTv1HyX4HnmfzjxRCTBx5Ggns9KB/5uUlT5ilwDWzSkJDjnFa5+P0V6fxPuo2bfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904341; c=relaxed/simple;
	bh=/Y+j5nnBZmfosDIt5AA2wiHFd+B/n8jBcY8XVbUbILc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tyf/b/MiQWLwBl9vq9xU/6JyXS77aHXXc/qlZdPJF5xvML8CONdFg+i6cjFHCH58pUmXm9LkmZcM11wvXpl9VTEEZcScR6GaRAjxtaOWRZyLq97tWtMwqNbVmrBXg7caNinLstYRAWzz1P9pvhxQYCpoyDXrJrFKellZC9uvZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W2x4wT1p; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754904327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nvZPeHoZUGv8yiunX9lwcunwG1NgaTC2loxZhPTUEvY=;
	b=W2x4wT1pGl+/zjamyP4eVKDX08Acuv/skkrSNde8nC2qSwGaKpnfQLeQSNUo3UnyUR9ONe
	unQKSK+kNlKpywrG3vts4cHDOSo9NBMaTB0m1HW+pEytyWZCwO45CmoIu81QJe6E+1Ci88
	fD05Jh4G5EvE6ARCpMhHSjyQcMnPpc0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Shijith Thotton <sthotton@marvell.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: octeontx2 - Call strscpy() with correct size argument
Date: Mon, 11 Aug 2025 11:24:57 +0200
Message-ID: <20250811092459.4833-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In otx2_cpt_dl_custom_egrp_create(), strscpy() is called with the length
of the source string rather than the size of the destination buffer.

This is fine as long as the destination buffer is larger than the source
string, but we should still use the destination buffer size instead to
call strscpy() as intended. And since 'tmp_buf' is a fixed-size buffer,
we can safely omit the size argument and let strscpy() infer it using
sizeof().

Fixes: d9d7749773e8 ("crypto: octeontx2 - add apis for custom engine groups")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index cc47e361089a..ebdf4efa09d4 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1615,7 +1615,7 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		return -EINVAL;
 	}
 	err_msg = "Invalid engine group format";
-	strscpy(tmp_buf, ctx->val.vstr, strlen(ctx->val.vstr) + 1);
+	strscpy(tmp_buf, ctx->val.vstr);
 	start = tmp_buf;
 
 	has_se = has_ie = has_ae = false;
-- 
2.50.1


