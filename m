Return-Path: <linux-kernel+bounces-749412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B389B14DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E9B18A3706
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030AF3597C;
	Tue, 29 Jul 2025 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n+9XF0GE"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBABBD299
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793576; cv=none; b=FkTxhX5A6BSxRU0PECdaAWc/u4JTbvvrSsy0aletKZlqwrlR5W3bdx3saX7Ny9RZtDH0xUVAuqUSlA7oweVyCZYax/WWV3pRJB7EKJzSJ4mMjHXKC5qIiYC7xfYfgNpnYu19pGsIqeXeVl/AfXoAKpK4cFn+W/QuDsAA4i0CYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793576; c=relaxed/simple;
	bh=LijYy0l7nJEPF84TxSsO/ddopXrskl/0GYVY8fU+zio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/TlDEsjQvU/xOdkG/jJDxfYmwJWN50jwrEBZxljT0kBnEuwHNXaeII1zitCxci+hiKEQ7KLoBvyvT0+q/ZAcKtPFTsFge51j36D9YSmM1mG4La6p09YMohNFWOpIZ3U+coMvxVmJKvfc6ngEa6e9e6oihV4O6JDrL4PKcY8NxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n+9XF0GE; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Aq
	v3oXq6HihvHrozeSwZl3+37bg7Yv73vpJHdyNYwyk=; b=n+9XF0GEJTPWpk7Apj
	EL4BtlpwiZ3A2chA99kZvgNyyJ1un000zZago79U+GufJXFuqFBM7EVn1nK1QzPR
	91EP2uet3Ewiz9aAr3TNlz/eXybVz3ubk6TMdjS815PffvhOsWMuGmc6xN1qMXzq
	GztF7DSlTh+a/cJ7oORzo8gWI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnd8ccxIhom27OIA--.13805S2;
	Tue, 29 Jul 2025 20:52:46 +0800 (CST)
From: Jiawei Zhao <Phoenix500526@163.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libbpf: add SIB addressing mode support for x86-64 USDT arguments
Date: Tue, 29 Jul 2025 20:52:44 +0800
Message-Id: <20250729125244.28364-1-Phoenix500526@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnd8ccxIhom27OIA--.13805S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw17AFW8ury7GFyrJryxKrg_yoWrCFW7pa
	yF9rnayr18tr4Svrn3WF10vasxCrs7KF4rZr4xJa45uFWxWr45XryfKF15trn8GrWIyr43
	ZF4SgrWxCay7Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UD739UUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgASZiGiIvdFmgAAAs-

Add support for Scale-Index-Base (SIB) addressing mode in USDT argument
parsing to handle complex memory addressing patterns commonly used in
x86-64 assembly. This enables tracing of USDT probes that reference
arguments using SIB addressing format like "1@-96(%rbp,%rax,8)".

Signed-off-by: Jiawei Zhao <Phoenix500526@163.com>
---
 tools/lib/bpf/usdt.bpf.h | 31 +++++++++++++++++++++++++++++++
 tools/lib/bpf/usdt.c     | 22 +++++++++++++++++++---
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 2a7865c8e3fe..59599159baab 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -34,6 +34,7 @@ enum __bpf_usdt_arg_type {
 	BPF_USDT_ARG_CONST,
 	BPF_USDT_ARG_REG,
 	BPF_USDT_ARG_REG_DEREF,
+	BPF_USDT_ARG_SIB,
 };

 struct __bpf_usdt_arg_spec {
@@ -43,6 +44,10 @@ struct __bpf_usdt_arg_spec {
 	enum __bpf_usdt_arg_type arg_type;
 	/* offset of referenced register within struct pt_regs */
 	short reg_off;
+	/* offset of index register in pt_regs, only used in SIB mode */
+	short idx_reg_off;
+	/* scale factor for index register, only used in SIB mode */
+	short scale;
 	/* whether arg should be interpreted as signed value */
 	bool arg_signed;
 	/* number of bits that need to be cleared and, optionally,
@@ -202,6 +207,32 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 			return err;
 #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 		val >>= arg_spec->arg_bitshift;
+#endif
+		break;
+	case BPF_USDT_ARG_SIB:
+		/* Arg is in memory addressed by SIB (Scale-Index-Base) mode
+		 * (e.g., "-1@-96(%rbp,%rax,8)" in USDT arg spec). Register
+		 * is identified like with BPF_USDT_ARG_SIB case, the offset
+		 * is in arg_spec->val_off, the scale factor is in arg_spec->scale.
+		 * Firstly, we fetch the base register contents and the index
+		 * register contents from pt_regs. Secondly, we multiply the
+		 * index register contents by the scale factor, then add the
+		 * base address and the offset to get the final address.Finally,
+		 * we do another user-space probe read to fetch argument value
+		 * itself.
+		 */
+		unsigned long idx;
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_kernel(&idx, sizeof(idx), (void *)ctx + arg_spec->idx_reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_user(&val, sizeof(val), (void *)val + idx * arg_spec->scale + arg_spec->val_off);
+		if (err)
+			return err;
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		val >>= arg_spec->arg_bitshift;
 #endif
 		break;
 	default:
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 4e4a52742b01..e432c48f2d2c 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -200,6 +200,7 @@ enum usdt_arg_type {
 	USDT_ARG_CONST,
 	USDT_ARG_REG,
 	USDT_ARG_REG_DEREF,
+	USDT_ARG_SIB,
 };

 /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
@@ -207,6 +208,8 @@ struct usdt_arg_spec {
 	__u64 val_off;
 	enum usdt_arg_type arg_type;
 	short reg_off;
+	short idx_reg_off;
+	short scale;
 	bool arg_signed;
 	char arg_bitshift;
 };
@@ -1283,11 +1286,24 @@ static int calc_pt_regs_off(const char *reg_name)

 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
 {
-	char reg_name[16];
-	int len, reg_off;
+	char reg_name[16], idx_reg_name[16];
+	int len, reg_off, scale;
 	long off;

-	if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", arg_sz, &off, reg_name, &len) == 3) {
+	if (sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^,] , %d ) %n", arg_sz, &off, reg_name, idx_reg_name, &scale, &len) == 5) {
+		/* Scale Index Base case, e.g., 1@-96(%rbp,%rax,8)*/
+		arg->arg_type = USDT_ARG_SIB;
+		arg->val_off = off;
+		reg_off = calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
+		int idx_reg_off = calc_pt_regs_off(idx_reg_name);
+		if (idx_reg_off < 0)
+			return idx_reg_off;
+		arg->idx_reg_off = idx_reg_off;
+		arg->scale = scale;
+	}else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", arg_sz, &off, reg_name, &len) == 3) {
 		/* Memory dereference case, e.g., -4@-20(%rbp) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
--
2.39.5 (Apple Git-154)


