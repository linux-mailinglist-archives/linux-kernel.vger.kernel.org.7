Return-Path: <linux-kernel+bounces-898764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85855C55F64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 408E94E5D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E250322C63;
	Thu, 13 Nov 2025 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcrg7R39";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="itXOZaY7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE2321428
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016083; cv=none; b=QC6GsjAJco1M1GIjIUOf/pLHakWQVBWr1Lr2ym5DFphMrPotbC/XJVQKAgICQBtr1bM5SnZu6UFQSUiqRjZ8jh58veYAhSS9Nxpnpml6g0fO+0nl0cXEy1sAuDQiVx88+x83Imm+4CZkAxliluXPgoyWtMF4oeOwhQtVlv3M7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016083; c=relaxed/simple;
	bh=OdLtVtiwW1xAkEP1Tuk8yBW78hA3TuPbGrqvdFREa1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYrJUgGlNqmHQzDEPtRzVf6QsGpadptREomx9h6Tr2RbZKhiDrO5h2DPRVDClLBhinRRJ82ZM7kltifOxk/95ARDcjNnzLq9JwdgBfP28jr//rhIE5mmGxyD5g+nJJb8BFhkTFzn80POUA1yPQYsHqQkMMga46wdjzVpvpNFzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcrg7R39; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=itXOZaY7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD5S2Mx3440417
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=p+hWMKFKc2m
	VbzgviX4dn/1pRPQOpQtDu/1ysXFdpkk=; b=lcrg7R39k/JhY3JsjXhOBdEOMng
	+MhLO3kZspSmlGJ332Tux8Tuo4mnP5zNXdVmVl2aIL41paRaqIggpnHiDJeTVjAM
	CtxtkBCtKIIcwmUo31z9ty8IcVNQHnm5Ia6vJCmGhNJJ8DpjKhq2R+ygnaNNpEqY
	GdcWCtzmd5UdbCsX6ThTtAb5HaSZbtKAQ0eLJN2NnrNHoT0JhadMx1QhjowGO4Ku
	tfe7OXAlQxPOuGHMYKoes23cCD27vtp+AEuEYxBV2ANysgIsyV8GciF1KU8mXcfw
	PLMdBU+3WM6sE77jlTCqPL8axxuCvPn/3mtOiYaHJ13Eps00381ODLISePg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad97887b8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:41:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55443b4110so456380a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763016080; x=1763620880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+hWMKFKc2mVbzgviX4dn/1pRPQOpQtDu/1ysXFdpkk=;
        b=itXOZaY7x1TGX6/xA4E5opkKNxKxU/9ZPG41M+024pX32EnpyQQEWmvG5+5vVfRkLk
         TI6tJ/p07XMtEZzsoK6OMGjHdqzoSKH3cPB3DjiuxhjVMQP006DzFS3DpqwE2j/vBPjH
         l71XRKT/QfhP43sRj/l1lVXyIRgFeigXkNG0pI36WAuH9aOFDn90xTlauhivjuKlHB0W
         EEiusmlsW8j7fce3K5DyYocq5LmscsKqNZweMgxF3vL3i75yo/APtlbidumFTM0DlWn1
         z9lnW6wUEgdaQCDQ8Q1a1NIr/z3NU5ggRk/JpAXiKPxoN2B+w8MhBJGcg/ge8RN8coez
         5rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763016080; x=1763620880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+hWMKFKc2mVbzgviX4dn/1pRPQOpQtDu/1ysXFdpkk=;
        b=JcORkCSI0VL3lXf6qpqU27SoGcygPVI9S+CkcG/DwMMD8Ld+vvkhdQNrigsIlZIdA5
         6M3RXFkxfPs3saAB5y/eAF2WkJ/r58nxbXIJym03JEa3/RgAJh3S1AHZWYDWNwWUR//H
         YLc6LNU937kmzo7Zc6Sj41OWrxHNzHmL1xwM8ZYms7maCmkN7D8kqBKlVPQiLEt3il4y
         p0w4DUkguCq32AgCrf3YjpRc5wryNEWltufHPNPMkN9WUAqEIPeahOhrc3JTVgUn6Tbf
         zSDaCab3+9qHSSuLoZ4bUAqb9a3JJ5gGNqksxKQ4POOF4tveWW8RMaWD4NQtuGXHWTiF
         t3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM94EHKZdnHb0ihQO+Cdn25zHdxLf7FmJpDYwcjgAQALf94Ts8iyt9EZYrUcjchpzhhVQZGJTYoqiWsAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvF277ryUk0rBceRdbJQ0FfO+xnRVjyrKgJKW6xJVOAFfF1JM5
	tzJmlFyemDOhIrvtekLA8qFdy6HpLwTjukwTpe2lDTxxbGaqRku5xC76/7GjRPTM0eWdL39tnPV
	UVN6jRx6bYLcjmvBHRoddnZSWbj5P8S6kB/BM1MkhLd6Kk2ob5/SiZ9v5plCgCU1VJYopvHdYbQ
	g=
X-Gm-Gg: ASbGncsyUseR56UA5u9dfuoZMTcGnw8tsEDxYylFtY4Etua0lEpi7hgfpuBHtR+5Skq
	4mTGyzaRDAyMEBS82iIFvo64iNZXsBHCYEymtqyqSX1aFODr+cygXXVND1eFcVGPWnZlAPPsFzP
	917ANVBuvxcWjibD2jFVQHvz1T/oXxg2fLQuQj9wRRw+qqyyUDYZ+VfEv4B4MbSY+6Dt0NN1/9N
	bMdQaCXq3C8iQR/+nsr0Xr9heH+ba2WzFIX/zw1+9dJLv4UG6nWTZophRFeLFWdCcfSBc0R2ITn
	tU9nFtr8eRAHFUvhDV+tZyFiAwEBB2vmvUqQI5KcuK6pV6JDFFRCfFT/uA40db7Y7xNi52mOUlP
	wwjYvb5mEGpH7ia+mhpyla6NtGSThrBk=
X-Received: by 2002:a05:6a20:914b:b0:354:1d68:4cd with SMTP id adf61e73a8af0-35a4f6924ebmr3655278637.11.1763016079650;
        Wed, 12 Nov 2025 22:41:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtQXaEJw3cpwnHLq9LAZYgHeBTeUkFAJXdBKUg5ZDdPcbmmAje3PWxAh4kNGtp5umDsqMu7w==
X-Received: by 2002:a05:6a20:914b:b0:354:1d68:4cd with SMTP id adf61e73a8af0-35a4f6924ebmr3655234637.11.1763016079132;
        Wed, 12 Nov 2025 22:41:19 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db25bfbsm1138419a12.1.2025.11.12.22.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:41:18 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v3 1/3] misc: fastrpc: Move fdlist to invoke context structure
Date: Thu, 13 Nov 2025 12:11:09 +0530
Message-Id: <20251113064111.2426325-2-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113064111.2426325-1-ekansh.gupta@oss.qualcomm.com>
References: <20251113064111.2426325-1-ekansh.gupta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA0NCBTYWx0ZWRfX2uycQa99GcYl
 rtKV0N24QfDXUGHJtLiJRoJ37xTYZ0C4wxUwk0Xz7HUkxmx+m9INePAtp4qLlDVWYpYyVdWaXhs
 ced0sD9ZJKwoNQuJM3vVKQoaoz3BYM3GzCnK313Tn4BiUuimbe0XySY99tlyb9DOjZTSieL5qYV
 QfnVfEx7TC3yYI8hdXzzgHctkV+ICWeK7UF+ga01xrq+RLcpzIPwYAKMw0DJ/w8SMuHPfDcW9+r
 Rmqz3UAWAORTNu/TxWceStLc9JxCDoYoH0b1Hg2c/y1SBwp8C9brv2xXVQsz6wSuJAo/N17Az6s
 eqfm0wQTSYuGpDrwOufCEgwewpoXpfycNhoIXFuCaTdArLlNTsTMjv53suqMe5bc9qGlzypW0yE
 kW3U0bQYavzMSVok4C6v3XZrgt3Q4A==
X-Proofpoint-ORIG-GUID: jXMFVddvmMZnlvUR_HC24Z3OmXFTJevV
X-Proofpoint-GUID: jXMFVddvmMZnlvUR_HC24Z3OmXFTJevV
X-Authority-Analysis: v=2.4 cv=PIYCOPqC c=1 sm=1 tr=0 ts=69157d90 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=hRzSbfjIAxXVlyYcgJ4A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130044

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


