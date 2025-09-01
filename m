Return-Path: <linux-kernel+bounces-793822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62523B3D8D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D613AA9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777B023D7DF;
	Mon,  1 Sep 2025 05:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iQ7+w11O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247862356C6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704828; cv=none; b=mU7JvXlnYh5twjjMIKLZIlULqkIS4DVo8++wJG+ttJDsaguOPUZkwOPl09KSI3LA2q8jQuUPuC1+iNzXeSrrwGhLZX0oDVWXbQCpnSgw1rzzcqVOdFBt84O2huQaJEx5mskw5K2pfIIjOOmvICRnyhwFJgge8r32knQfPiPdI1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704828; c=relaxed/simple;
	bh=UE2VAlFBk2DLWyEi3sDsliNgbJ5ypA2e8EdXf7WB3/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWPf0k4IGaiYyJPTTzmQuhZDR60yIbfJwNmJBYPqkh1HvNN8JOO8gVVIdk1lHiEnXtITVxizRAVmFcej+G2vizl3ebDt4qjtJSI7+YYcaIS4tfO9Yq081ASVGl17bz0M3WDb6/vgQaniW+Yj14/tO7TzHFdL2TV7Ii8h3uqJkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iQ7+w11O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VLuXKa026807
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 05:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IZcy5lp3+vK
	2Xkym55v5I9nDuPWPklB8MXh1zD3Z1R0=; b=iQ7+w11OrxfQUsfxmvTyDK+EBtq
	jGmee8zOY9L1DuuEfWOg6r2Mnn11XmjEImMxmJJbn/TWpgB4WU54Em/KY7jHmSva
	3MnCrQ09cN71KnwzpJRDTCtcDp4A3+44wXBkZUcpcJQS4tzaTa40f8VAnWuQp6xG
	rKPXoU+s6mfsesd2JDxesa+hHiBV4uP8iPcSuCpbYEcVY12p95R4uteT4WUO4W0E
	1oTNYFQ73RSMgJah0i3jD8AEI3c3wJVfOmAf5L/Qhb2dTVjJsXDfqMBDvqNEzUrf
	3+4DrdIdNROugZBrsN8FKMC8Id5w7LZcsT4UURYVf8YVm+E+tVzu63boHZw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8kdb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:33:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24abc029ee3so8319095ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 22:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756704825; x=1757309625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZcy5lp3+vK2Xkym55v5I9nDuPWPklB8MXh1zD3Z1R0=;
        b=SB5hUBBOTY4X7GMOe2GLq4P+uUCrVqSGM0laoY7x0Tv9kmK/QjoBurt3Lg9xqgl4zV
         a8E1NCxY1M8+kn3N78XAS5QWKYvhYB2lk/SmhV88ANFfRBZVY9i9kjXVi0XU0OyAoUx1
         T7cKWznFp8p7TJ909RS73O1cdpM4KrgI6TbnHSA+JyyE58z2VOQBSExjR5Sh/E2/5BnL
         qGkG8FZwte2zGwtFHcCeL85yO6WpNrAj56JvWcEOw9V8QHa3HpIWhZlxm1Fz/PO06I4Y
         N1qJS5MFCZt8kYfIOprHYDGaQReIC/ncJtgywuOjF9DHp1cHCDz//Acy+vFVjvXgHSsQ
         7kWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDlYW0a7L6geLmVQ3cFc+Za/zD0QFI7/qeeiUZKuvjDF0uOaVg5FUu9MWQaBZVCYZfLkp9zzq42HUajQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxdutXlssVeeokF2uKFcCiLfiyinqGdSkcznnmNFU9t5cfqLCg
	GRDuR85qLEMXmVpD0bv4MiHYfVL+MepKI69qg37kmljYLKbtRk0/Dd5GbFfkM/9kfBkAKcmHqz0
	cpf+tt9fQJMyhRiV+J+11unveyttF3+ktcofnT87pnhnK7EmniFCv6LyhdIMuPDgNlFw=
X-Gm-Gg: ASbGnctZ3AX0ceElxCGrQJWQYMz6gRCqdNpXL2E6E9FNG8wjLjxiJlajBZQbt49aH9J
	vpRZBEB5rKVMS2/O/ZrkFePrfCIbMcUkXVAAdyKZPFvbbQP0ul0e5PldTlM5d4iYE5jkXxqsCj4
	m6uij8g9TQFEa5xK6mdmKxmKhxAHTuY7iuXhn4k5Ne03VyDbkXogLXpgjtFu0B/FR5Ctkc3i3N8
	/oAsXxF/ejG+hC6mgNNb8X6fXlamak80pvX5G1O80X1K2T6T+npbuMHILU6to3FuOc+MKe4Yxb/
	Z+SRwv6yIrYSg9kHuOC/u1y4cemR/TwQZGart/VM1Z54WzULY78oOYXVmU+GG1OYqOnm+d1k
X-Received: by 2002:a17:902:d4d1:b0:246:6113:f1a8 with SMTP id d9443c01a7336-24944b29febmr97024785ad.40.1756704824572;
        Sun, 31 Aug 2025 22:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/9zfC50PCoALEOMly7nmWm821nvB1XXDGFIo7ShyQjJnQNMbN7EffzVijf65eEHW2zFlzKw==
X-Received: by 2002:a17:902:d4d1:b0:246:6113:f1a8 with SMTP id d9443c01a7336-24944b29febmr97024405ad.40.1756704824090;
        Sun, 31 Aug 2025 22:33:44 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906589986sm90575215ad.111.2025.08.31.22.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 22:33:43 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v1 1/3] misc: fastrpc: Move fdlist to invoke context structure
Date: Mon,  1 Sep 2025 11:03:34 +0530
Message-Id: <20250901053336.3939595-2-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com>
References: <20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -Gsxd0FjgbL6UVBoQ8nks9ImBH9rxagZ
X-Proofpoint-GUID: -Gsxd0FjgbL6UVBoQ8nks9ImBH9rxagZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX/xt2quTd0BVP
 s0b3GD4OxiRLgtWMIH5jIro0ILfsmiEkZGxPjh+b644RWzcXogkuuewNvmSQOwVydm8jq0yXCq0
 n3J+Z2nJXzfvKob6ikJbPB1PRJLLUjo0N/avQ270uTR3SawQ1dQIS2M31K6jTMWBvsnauLrlm8R
 bc6fTd1l8bJMPo/lFl1LBLaf1IZPgsnei4yuA6BBW3ZaY52iVnXI8E9rmK4riHWloZNlAe7upfb
 b93G2S1EZFVYzcXrjsa4en7gvUDjGfeq+uan1qzqhq3IEfbNA+QnxSczNLoRSUZDz53lPeHIpH4
 HsqhT6OjZdFMJjJtZ7qFJkiKOIaeOypYAdsnx9VXyG0+r8+/rmeZTlQEQOYIyH0HIGkzYerYxTY
 /eIWgWNj
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b53039 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=oXf4Wg5VOEMHQw36ysEA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

FD list is part of meta buffer which is calculated during put args.
Move fdlist to invoke context structure for better maintenance and
to avoid code duplicacy for calculation of critical meta buffer
contents that are used by fastrpc driver.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 621bce7e101c..0991ac487192 100644
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
@@ -985,6 +986,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	rpra = ctx->buf->virt;
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
+	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
 	args = (uintptr_t)ctx->buf->virt + metalen;
 	rlen = pkt_size - metalen;
 	ctx->rpra = rpra;
@@ -1087,18 +1089,10 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
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
@@ -1120,9 +1114,9 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
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


