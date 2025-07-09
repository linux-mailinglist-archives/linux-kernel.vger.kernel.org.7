Return-Path: <linux-kernel+bounces-722840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E3AFDFA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7CF17A66A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC4E26C3A6;
	Wed,  9 Jul 2025 05:50:53 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454026AA91;
	Wed,  9 Jul 2025 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752040253; cv=none; b=tXZaUBACAh82bXbWsICzssdpc4pG98t5d4v0SSs/wF/Jc1TmwTcsRov06NHM8JSoOiYZpjsVanM3o+UzuWsKOMpCSkwzUgnBSk+Py7Ip8qZyb16mlLVZreBsKxcI7LnFINkLX9kP2nfw4tEqKsAH4J1GZHGdcg2PfPj4D1mLq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752040253; c=relaxed/simple;
	bh=/aoQ7q2KbTf36z6g5QeJFDdDvYGAM81wilyWf/NlQcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFI5sVW8TQmdytUoDpkvU1uNnlXQTqiEsZuyFMjqYCY8wUAJYW4r9laOdue0p/+3quCWacAteIYIJPrpfS1EP4AgU97l3Ac47dRKMPnBzlIvI2bN8bQKwGalvpAtOSkd2GkYh04AEiN0+2qJXpSthzwlfNotCvZ+fKuwP0GhrZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a746838a5c8811f0b29709d653e92f7d-20250709
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-CACHE: Type:Local,Time:202507091339+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:4c0676b5-77fa-4dee-a77d-090f85a94aa0,IP:10,
	URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:4c0676b5-77fa-4dee-a77d-090f85a94aa0,IP:10,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
	ION:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:d6db3cc7352ac1bfcd58bf73af8a777e,BulkI
	D:250709133928S88GGQZH,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: a746838a5c8811f0b29709d653e92f7d-20250709
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 207230891; Wed, 09 Jul 2025 13:50:44 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com,
	chenhuacai@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	guodongtai@kylinos.cn,
	duanchenghao@kylinos.cn,
	youling.tang@linux.dev,
	jianghaoran@kylinos.cn
Subject: [PATCH v3 2/5] LoongArch: BPF: Update the code to rename validate_code to validate_ctx.
Date: Wed,  9 Jul 2025 13:50:26 +0800
Message-Id: <20250709055029.723243-3-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709055029.723243-1-duanchenghao@kylinos.cn>
References: <20250709055029.723243-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the code to rename validate_code to validate_ctx.
validate_code is used to check the validity of code.
validate_ctx is used to check both code validity and table entry
correctness.

Co-developed-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index fa1500d4a..7032f11d3 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1180,6 +1180,14 @@ static int validate_code(struct jit_ctx *ctx)
 			return -1;
 	}
 
+	return 0;
+}
+
+static int validate_ctx(struct jit_ctx *ctx)
+{
+	if (validate_code(ctx))
+		return -1;
+
 	if (WARN_ON_ONCE(ctx->num_exentries != ctx->prog->aux->num_exentries))
 		return -1;
 
@@ -1288,7 +1296,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	build_epilogue(&ctx);
 
 	/* 3. Extra pass to validate JITed code */
-	if (validate_code(&ctx)) {
+	if (validate_ctx(&ctx)) {
 		bpf_jit_binary_free(header);
 		prog = orig_prog;
 		goto out_offset;
-- 
2.43.0


