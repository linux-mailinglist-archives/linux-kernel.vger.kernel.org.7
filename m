Return-Path: <linux-kernel+bounces-824258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D6B88842
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42377C2F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819AA2EC0A8;
	Fri, 19 Sep 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Vgn+qvWv"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70D1BEF7E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272966; cv=none; b=RPgezdxOFibohHkQCRXSnA+zes0/ehwj3aaZJoC8QiL9B/XAyb1zaEZci3rgK+TLV4Nz1BIgw5k5alQN4H+GNpq+zy61vtARqYBrjXr/4LnpHDpvMKeYahpk3p9sYEnIxP8yuAcl9R3rbeWBO1fMg53PQ7Ncxav7dno2Aa7oa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272966; c=relaxed/simple;
	bh=+mPQMIU8onA4/Yv1XT+lDGW9sUr35DDZ+cEPNMpVZYQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=CIUFcH3+e/9EpJB5/GGRTiTUceQSD6/WUJBasgaYv+oYzxjDWr/pwIHk+8VKGoyzlXH4tfC9puwPUU0PuyLnTgfF/oKL+4ZJ0muEsekIbQMQRpd2Y5wiqLdCm9Cm6O7rFnqNziVh+etdmMS1izVn0Tn5+Yo0QOVp2eZ+I9Glu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Vgn+qvWv; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758272652; bh=rt6ZBh/FACEEV9iyMJnNEDtC5qcJKC/AkiDFZH1KTFU=;
	h=From:To:Cc:Subject:Date;
	b=Vgn+qvWv79AKpEg9BeiYMH2XLPhU/Y09ggDSnp2mNnajigoIJthV+MaQP4eexOr5Q
	 dnllS80O6F+jxQDd3xSrgc36YULzBTZuOqSbGJuiFrU0E7kUAK3pr11izD8D+buNUz
	 Jiz3Vazs4++r229M+/TZDR5LgazJMj5Du8qPmcOU=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 10A89E10; Fri, 19 Sep 2025 17:04:10 +0800
X-QQ-mid: xmsmtpt1758272650tmb4aqqmm
Message-ID: <tencent_9196B487ED0904A6B2F921A50EECF4D6CB0A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XS8XmBr2Wd6f3zXRrcHh1WXPqRhUjotNGNfPiTz+8RR0uJGg+1N
	 5be3cMf99KbKXKt0FVg/DyKD0aP+VFninFogEb2rLNNlhW+Ab/zN4qcZYgD8j7W8trZdWbUETaB0
	 7zZf3RMzi7mUQmv0cysVUUCYviv42RX3ZFDWwjyu5IpYjHPlOL2tie0jg+FEXrtTzKSZvuZMHJv0
	 JOWwS6BaG3wyivLjk1+pFTyI+L5VUcJ1UaO3IfKYDIjPwv8E0YLAb2bVGAjnMiF761lzE1Xgdi3l
	 AQF+EjqIHhj3TEZuapaf9SjmJ5fnl/UIaaLCfcQ5rZG4pXRMZOvXbjafN542CTS0+PfqQytzM2YY
	 HtjC1Ms4k2IHoKT7way23bzKpt4Fjo98Xv5ZbOuUINlfTbsEOwbvTKmEFHo85mP8lhP78sB7LTvk
	 rcs7xFhxqL/i0eYl4ivmAFnpnG3nfyixFQmdrOUFHicuE6rvU6v2R0Rcd5qrYZhQCVbOPsk+PMGO
	 +zf72RIQXwBqVZURuI47tEv+VGABp9DQMgue1ZaFCGWCIbLCt9BoDqLTZcJdegO0ck6rkLWOTeSe
	 CQz1eKK4iTXLK1davMUWt/fpFGzEzX0Y7gh5EOjVVI7CmeFccMU6EEXNphttNziKB+m/md8RhAFv
	 G7MapZRMucH+bVm4CMe/q0GX2NddHec/8WUDlq09O7wEc9M7Kdg9x+ZHS3d+n3+xtSrbwnT8kSYh
	 3fzD1TwKiVrdiKrH00TehUUr6MZe+DglZ/ti5U05zbC1nTvHH7yrgn1KPW9SKqTWd92sgGp/880T
	 1lysQgZjQpV3FC5+5lJKHpTcLS2IDCeE19hNdHNRLVotjqZyieBT/YfKu8XndH9hZf+CbAqlOX0u
	 L9JcALaua1DGQPcnEGT0v1Xoic4Ct1zOnQwTPb4EqfDEYHEPRfOWvww69YyfqyME9AkHB8eiCFrd
	 bvnhLZg18+anEo15k6T4LhAP0WrsTVcTqGVR0uB85csFdLSqBuLGWHi4lP/yVnST5WlVfZSW4zCp
	 zg4EA4xn7v3dJJPjcidOwHDV1h67gErLmAcjkaIh1aXE3qF3LpGsz1PRBngco=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Haofeng Li <920484857@qq.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	lihaofeng <lihaofeng@kylinos.cn>
Subject: [PATCH] bpf: fix netfilter link comparison to handle unsigned flags
Date: Fri, 19 Sep 2025 17:04:08 +0800
X-OQ-MSGID: <20250919090408.47532-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lihaofeng <lihaofeng@kylinos.cn>

The original implementation of netfilter_link_compar() used subtraction
to compare the netfilter.flags field, which is  an unsigned type.
This could result in incorrect comparison results when the unsigned
value wrapped around due to underflow.

Changed the comparison logic for flags to use explicit conditional
checks (similar to how priority is handled) instead of subtraction,
ensuring correct negative/zero/positive return values regardless of
the underlying data type.

This fixes potential sorting issues when using this comparison function
with algorithms like qsort() or bsearch().

Signed-off-by: lihaofeng <lihaofeng@kylinos.cn>
---
 tools/bpf/bpftool/net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index cfc6f944f7c3..9f840821beda 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -816,7 +816,11 @@ static int netfilter_link_compar(const void *a, const void *b)
 	if (nfa->netfilter.priority > nfb->netfilter.priority)
 		return 1;
 
-	return nfa->netfilter.flags - nfb->netfilter.flags;
+	if (nfa->netfilter.flags < nfb->netfilter.flags)
+		return -1;
+	if (nfa->netfilter.flags > nfb->netfilter.flags)
+		return 1;
+	return 0;
 }
 
 static void show_link_netfilter(void)
-- 
2.25.1


