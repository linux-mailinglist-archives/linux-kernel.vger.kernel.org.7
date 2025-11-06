Return-Path: <linux-kernel+bounces-887810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EE7C3923C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8DB18C18EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEDC2D8760;
	Thu,  6 Nov 2025 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJr7EOIz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EMRf05Aa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E32D77FA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762405730; cv=none; b=UHHMSLmcKv3GqB+rwGj1PP75RLUZLvwG3xh20ZBIn9+ZeFvsAQnN0oY9c4vJ88hL8ziFxMKs8GupJQlk1LmukHQF6hDybnt55SGpFrtC+7zGLvBW8BUPvqTE7719g2jOPdW6eho06Muv32/mYrdFEzig6lN0xj85Iwr+33lxjYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762405730; c=relaxed/simple;
	bh=OdLtVtiwW1xAkEP1Tuk8yBW78hA3TuPbGrqvdFREa1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHAIHW57WCE/zHjoxder8a0WcFO4SfKUzpZggKTDG7fZgzvlmYMtL6Lpsfw20irNeDvj42/Cm9susRjmnxIPaQBVw5KaLwBxXphRh0cXaMW3cHn0eJsgE64TuYhjeWY4OIrkd0VnjjXese8w8OaRJED5FH1XOm+un4dZSFEP/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJr7EOIz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EMRf05Aa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KFBcM1657055
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 05:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=p+hWMKFKc2m
	VbzgviX4dn/1pRPQOpQtDu/1ysXFdpkk=; b=aJr7EOIzgAvUY+6EuNLCcqqUO0k
	0hOlOF/cmOdgrgwuiCmS0jCQ3FhRZjj+AU+o5mkoWwveuEJedOTwCcA9BjqhWVDX
	byTOws9ZVIZ1tjY/RRAHmf/VlR8cDRe1pEL2nEXPoRIL/jeT7YS2novXlpA53ptN
	N+5zGWLY70WUDUpQdfYYm46HYt24eX+bUzqyxf052D32iO/GrSL+o+ASz5Zz8Nc1
	jLZBhl8E32ytWuvWkr0lAB0/Aa2kCt6XrI7svpNpqT6T5MkrxTD3TtrXUQDNaf8G
	3mlaZtey7Bbso0yDC+WM7fYGjWWSandu54UQPS3aewVunhPllXy/Xoy6/Gw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8831adw3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:08:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a99a5f77e0so51941b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762405728; x=1763010528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+hWMKFKc2mVbzgviX4dn/1pRPQOpQtDu/1ysXFdpkk=;
        b=EMRf05AanMlQT+0o+n4ytKeE0PzDaV4m3qgueFB0jGCdJlPNMdILMXIRxCP6Pt/jFj
         QBELx13qGdck9u8Pxz/sFqGfmH96zpSD+ioChH4XRjtjpmQpw2Ans+lO3a1QDTPt868q
         29QGJEZmSxhdEoDdUXIvvXjsoQsry03+dpa5GkRAhq8c8XldotMPRIwB3Ic8agHGhT6O
         kv9qYOFXo9PfDu+H5aO5PT6n9/3H+4zsRq2jMAEe2NERI5W0PaUKT1cxqc9PsWWA9KCT
         81Vc7zBNnCo50+yD4BNEYP6eruRDdHWflnyltffxarCW7AWot5MMYrO/CAlYjTbizp1L
         pKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762405728; x=1763010528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+hWMKFKc2mVbzgviX4dn/1pRPQOpQtDu/1ysXFdpkk=;
        b=LtW0ffdx1L7M9vEHcPidfVbLIBk6fjqvtylE4dD+eccugBqc41Cv4VRE7OxBVvjqlc
         p78NVFo83aBdl7FBsE1rjiSrvDZ/RskG0P9kRXr6VGa64ksvI2Pr9s1oiiMCk90FhPnd
         4HUlGCzizsQariniJc8TLQq548ibvliJxC9myoeX5aYBHKKWCE0WWAqgBmaCBLi2BaTa
         lzFavCCuJeSBkGVi7fRz0GIbRLwN7nYP5b3xZXZ0Y9vqv+Z77vsURNTRjraaG0/2m5CD
         wCV9TRbjyOZnNaURM9lUCYN600DTc1Y4falojGoBxq6RW1sWQOmcD9htO7Y8P96Glg9g
         ERVw==
X-Forwarded-Encrypted: i=1; AJvYcCVPs8rmKuuRpOSKN2/JaQXupPvL/OrZaMLysPEF54ZoSNcD03nc6J5fl5GqQnMs9k9YbP2+d1SFxvhW/Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlsP2PgKYs1kMfH3BKFFA6Wjk/vDpeG+hmNo7zR+XVePewcoIj
	1dG3s/uG6mG2z/0xHHzy7pVIxa3jMJmlb46YfXhqAiLs+Hd+UIrAE5BIZvrJIWFLixSvw8EI7Fl
	8U+gBgU+E2sFuUvjFNu86/mynRAWcltRHWR/vc4fhpk8Hbv5yT5d/c7ze7aAW8fh6Qrk=
X-Gm-Gg: ASbGncvk+oDCjDbH0Eku0wpQRl2nP/Wx8HGn5eJC6d5dwTESit/Qowa24OjwdZqP4x8
	Xry6yh3oLnsixAVlZy8O6kiVvCX8UeXz13TMLcd61D0gouacKyO0oICBDzoAl0SxMTAcWCAXEP+
	ZdkEPxI6AcZs1oguYlMf4h07TcnY8cGHBkcjmEDxtG4u8V7i7dixB8Eb+i8Oldfs2ZgPl13lety
	i2fzUIqYAHfmfpJNwblOBgmDsBFEUHu0WyN8KRtIcedLby3PSQPLnnaeuWYk556vMowYnODjJj2
	sueLnDqsQRkmwvrLmMm7Vrc7ViTrxO1AuykQrGSS71dE5VkZbR8YBDxUqrRWGwzfXDAoxtpwLLg
	sl+BQgLyXmhoZkPXcufzIakt8mfnmp8s=
X-Received: by 2002:a05:6a20:4329:b0:2e5:655c:7f93 with SMTP id adf61e73a8af0-34f866ffcddmr8038723637.33.1762405727759;
        Wed, 05 Nov 2025 21:08:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9x/9PQXFxurYjajKLl4M0E+BvzwI4iNtYKbcQnSyyKegfSdBjBGyv0hbXFx4kxfKFSUcyZQ==
X-Received: by 2002:a05:6a20:4329:b0:2e5:655c:7f93 with SMTP id adf61e73a8af0-34f866ffcddmr8038656637.33.1762405726586;
        Wed, 05 Nov 2025 21:08:46 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd5238csm1185862b3a.17.2025.11.05.21.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 21:08:46 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v2 1/3] misc: fastrpc: Move fdlist to invoke context structure
Date: Thu,  6 Nov 2025 10:38:37 +0530
Message-Id: <20251106050839.3091707-2-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106050839.3091707-1-ekansh.gupta@oss.qualcomm.com>
References: <20251106050839.3091707-1-ekansh.gupta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4PsQkeg-6y39EWGzUJfMQLaoMN3vi-Ip
X-Proofpoint-GUID: 4PsQkeg-6y39EWGzUJfMQLaoMN3vi-Ip
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAzOSBTYWx0ZWRfX4ygcM5YEBAIb
 AaAuh2EoJAdLi6Ky/DxQyWqRuW6PfEQCoHdsbWw0urW6vcc2171YtxPd7dZWTXqzNlyuDo9EyT6
 R6FNlAnPCPJoyIR+ZVNvLLS/73v3a8/zb7DRUj/Oin0qW5DKUO5T1qhn7B6GHgze1wsdpM5yRMl
 vaqDH08wrBY1rRXON0WGpduKP7EEW96yxh2aDYFc8zONxzdK7LzTsQLw4c/qUo0P+YVQ94/Pu5I
 I+q70vfS4zJiI2a+HvO9ZpbLPJ6ukWU4s508z5EdibFb8dG2NV9h69clfvjj7oQO2AMwdoCQvA4
 9L4Hq6tjqUrc8KnlYpSLphKck5f6IrRr28nR987q3cA49OK8z4jVetUcAy/y3GykAKn7CJEVwpo
 N5oIElSRTfNW6v47CZKeqaIhO4OVmg==
X-Authority-Analysis: v=2.4 cv=Mdhhep/f c=1 sm=1 tr=0 ts=690c2d60 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=hRzSbfjIAxXVlyYcgJ4A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060039

The fdlist is currently part of the meta buffer, computed during
put_args. This leads to code duplication when preparing and reading
critical meta buffer contents used by the FastRPC driver.

Move fdlist to the invoke context structure to improve maintainability
and reduce redundancy. This centralizes its handling and simplifies
meta buffer preparation and reading logic.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index ee652ef01534..679cd8997a00 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -233,6 +233,7 @@ struct fastrpc_invoke_ctx {
 	int pid;
 	int client_id;
 	u32 sc;
+	u64 *fdlist;
 	u32 *crc;
 	u64 ctxid;
 	u64 msg_sz;
@@ -987,6 +988,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	rpra = ctx->buf->virt;
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
+	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
 	args = (uintptr_t)ctx->buf->virt + metalen;
 	rlen = pkt_size - metalen;
 	ctx->rpra = rpra;
@@ -1089,18 +1091,10 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	union fastrpc_remote_arg *rpra = ctx->rpra;
 	struct fastrpc_user *fl = ctx->fl;
 	struct fastrpc_map *mmap = NULL;
-	struct fastrpc_invoke_buf *list;
-	struct fastrpc_phy_page *pages;
-	u64 *fdlist;
-	int i, inbufs, outbufs, handles;
+	int i, inbufs;
 	int ret = 0;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
-	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
-	handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
-	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
-	pages = fastrpc_phy_page_start(list, ctx->nscalars);
-	fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
 
 	for (i = inbufs; i < ctx->nbufs; ++i) {
 		if (!ctx->maps[i]) {
@@ -1122,9 +1116,9 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 cleanup_fdlist:
 	/* Clean up fdlist which is updated by DSP */
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
-		if (!fdlist[i])
+		if (!ctx->fdlist[i])
 			break;
-		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap))
+		if (!fastrpc_map_lookup(fl, (int)ctx->fdlist[i], &mmap))
 			fastrpc_map_put(mmap);
 	}
 
-- 
2.34.1


