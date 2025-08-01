Return-Path: <linux-kernel+bounces-753113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A1BB17ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F418C564131
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596D218584;
	Fri,  1 Aug 2025 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Wb9FpksB"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9E2AEE4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039242; cv=none; b=OqpQRAxbOSSru7u6HFeEIAflB2wxIa2qce+VxHf3DBfW69VNbEDFOEsw9qnjPgVIee7RJhXGv3imq4T5xIgAP5XaLjlTU4RlSiwUdt3gu8CNZ/LrR0Hdp/ZCLiA6LVv0fubFJXzdzRcbgcDRjgj6ytKIEHL9QcJgj9wf31vFbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039242; c=relaxed/simple;
	bh=jWfN9U7HSeOOEeb232m6YC+b3wA0NE60+ePggoODAFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3M+jNzpZL8DbNtxpEOZVUVtMVYwKYgK/3f4CddjfMNOEXa0t9Uf6Gwzk2zljTTnI2HZvs7yBMxXJEiTmDhXmH7jkdF/1S8pW8l4TMlvrsTveNQkoEOZckodYxLxEX7A/EBuklULIAeaebgTY9gPKN9ptKfurE5Ng/PgkElYZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Wb9FpksB; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1754039214;
	bh=pnMtw/DWvge/1AgXY0gXlGjA0EEKIxjlEa2RlC3rDHk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Wb9FpksBvjZsOV0RiFrX9enabLXZfRMtoGiKgK6giP1B5c+14dMfmrpd5AFrGESBc
	 EiC9neQmHfutXYxNGND8+W4cEM1xKPr4fZ9vcwx5UdsqWwyABbCv1M6ezc0oZ1ZXHT
	 fuuS4TxIoYsHosMnCeTPrGP1FTLoOpbksEbhE4CI=
X-QQ-mid: zesmtpip3t1754039171t6d2c0da3
X-QQ-Originating-IP: NLVxtxx5vHsEbFass3QzTVgPiJyuunuo9M4wi4g9+KE=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 01 Aug 2025 17:06:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11178572120782440509
EX-QQ-RecipientCnt: 8
From: WangYuli <wangyuli@uniontech.com>
To: alexander.usyskin@intel.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] mei: vsc: fix potential array bounds violation in ACE address allocation
Date: Fri,  1 Aug 2025 17:06:00 +0800
Message-ID: <78151482AFE8973A+20250801090600.544000-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MG0eYPcxdOU4aCmmEeFSf3kVGNsf52L3PSM6FRw6be7aoGjoU7aGrt5B
	9Mhv9WAUbZOJDISNuQ4Q6spbZiZL1tlX/Kz6sTlflIrb1f1FHAy5Z4MB0YS7hYZOmE8n5dL
	r7sr/PQCs5sPjKJGd1td4gX64QJsCdjr1ToyIf9lvuuEdsFsmhVklnAMlozLKh0Rdrttg8T
	mjxAiDgnJweuEQ206ZR75RnHjm49hqV2jJREMFklMdnA3PAShnuas0duqMrXEQrNNHI8vxQ
	BJYbiSphUe8bO5BFB8KZbttXX5LPtCDeEZk5jtIoRpkUnpSJQ9T6aU32DLjBthvkdyHeUl7
	CLMrChFe/aYanjp0dgl8gBc2S9rUbh8wHlSzSKuJJfWjqJru6AaSDK45tLuC+33MU3XTOlO
	j51y6KNPJaIs9rv3Pc4v4P+ThkRl5h0GKdrV9ECjwL1Pj/N5MrPRf/EeJIlGVWJYIAKVgao
	7CGnQjoxMa0NQCbUJIFUiAtfqYTNsE/Xw0VxMZRdcm8u96y9GTQKngAUCl9xeYFU9nQ7wHS
	lb2m3bC/r3VU9AbzPTvSm5moyuraLE1S5HzEGEBLgq3wSpCp+mmnrBwnWQDpwj2Q83tn9sI
	uITmFAwO9h8qTfAjYfwS0wWqqv3sNwJWjy+cpvLTl6WMNyfRdQF6XWX5LqYb4f+5Ek2Z1be
	pAzImH7AloGm8qJOOP/An+U62KY/7B6++jy7BBECQcEg4XrE2U0GquzoLFnZXgvSk0/DB9I
	Q+HvhT1qTDoBrYVFMSLkluEW+xPvkO3I8qI9Sg09Wf5JI5EDnmZ1Bqca5tHAm2QHvo3Qnnu
	PZfLOCqhXcZdEz1r92DI3JkjtZNTNX9rJI9waxePGiy3JjCG6zaRjLJurXsL2U/YOmglYYa
	sf6M+jxEQUmHR6ukSC7Q15HMUfwwo8vFrTv6U6zJtzNdS04W2gdxR3pRfsvfJlSgaHz5Q0O
	5b7uUp/EL+qnq2Vv/Iw/uQnDoCTWyaoFEm9xsaJGAlaplUMOvTj549fyGECHLGCbKxWAAi7
	wibm2Lgfh5YoLIdRrEVmQy5T2SKX/z8sixDl1utGMHR2cD5kgV/z0MyyAdXk4=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

When ACE images require dynamic address allocation, the code accesses
frags[frag_index - 1] without bounds checking. This could lead to:

- Array underflow if frag_index is 0
- Use of uninitialized fragment data for address calculations
- Silent failures in address allocation

Add proper validation before accessing the previous fragment and
provide clear error messages when validation fails.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/misc/mei/vsc-fw-loader.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
index 43abefa806e1..e2d318ecb76a 100644
--- a/drivers/misc/mei/vsc-fw-loader.c
+++ b/drivers/misc/mei/vsc-fw-loader.c
@@ -516,7 +516,19 @@ static int vsc_identify_ace_image(struct vsc_fw_loader *fw_loader)
 		frag->type = ace_image_map[i].image_type;
 
 		if (!frag->location) {
+			if (frag_index == 0) {
+				dev_err(fw_loader->dev,
+					"Cannot auto-allocate address for first fragment\n");
+				ret = -EINVAL;
+				goto err_release_image;
+			}
 			last_frag = &fw_loader->frags[frag_index - 1];
+			if (!last_frag->location || !last_frag->size) {
+				dev_err(fw_loader->dev,
+					"Previous fragment not properly initialized for auto-allocation\n");
+				ret = -EINVAL;
+				goto err_release_image;
+			}
 			frag->location =
 				ALIGN(last_frag->location + last_frag->size, SZ_4K);
 		}
-- 
2.50.1


