Return-Path: <linux-kernel+bounces-745834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FB8B11F60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB0C580835
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F278113A244;
	Fri, 25 Jul 2025 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="h2m7zhlu"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140459475
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753450253; cv=none; b=aSXXXjkvFZpTkk13HCPMW/DjdK7zbhEFf7uoz9heY5PLWZewO/QNer2UHUiCdSTPOi3/ExUwX+XRR4OtX8WbnCi1Jd4bxW3aOUOExrnR7AsxxyxDLfaO1lOGcl3XOKqhgj9g8avVvds+u6z6E1DKqQzH6ANuUVm/tJrm9PBpAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753450253; c=relaxed/simple;
	bh=AFsV0usjt86lovH5mvsK/2BeBPrgAG25O/0Mf8BwRF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JReT2Zf6p6Gx/6iYKzEG12wToJuMChXJR74eVpqQ4J+j1pqvQ9ELK2bA/VR3XUjrtcwYstQQMtbeJm7e7Ev4VNzX0vVlRkH6FadNNmnvz5YdhkCU0eCUlZ79o2cVbqWZcQTYOpG1eiGC5njC69M7bkSRKhYk9WbeYraFRLn/E3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=h2m7zhlu; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753450206;
	bh=O8wzE8tH/Y17Uk4jPlIamrwz3jhcPfWByFA+NtEuEl4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=h2m7zhluj/vC0iZca6HjrkqSn9X8JWd7yC/lSoW2QQzzyMwP5F1DsDMt5MHJgfa1i
	 KkvosWeFwtpPwKmO03nKpYOEOnNDBIo+I+2M6/vPUeUXpsvWnUphQKUZBmOwwj0XOK
	 fGxuiLpQSMIj0nrLN/rIunzFLk27nW+HLeU6WpzA=
X-QQ-mid: zesmtpgz9t1753450170t5bc23faa
X-QQ-Originating-IP: sHW5lqbKDHnR5SkWwRvRC8NqCmHqjs5kNCy4ePgYHqM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 25 Jul 2025 21:29:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12710551630611873458
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	xry111@xry111.site,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] LoongArch: vDSO: remove -nostdlib complier flag
Date: Fri, 25 Jul 2025 21:26:51 +0800
Message-Id: <20250725132651.1974717-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NAtipnnbTPeayADMvfoNCP7BWo7l63XJ11w3FPknwaXtBwYP6U20U/wm
	sVMu6DW+48C392BBt/4gSX971WYxOwW1qzjZEuR3G11p6ztJ3X1CgCJblpF7MHvj3Z5f67v
	ZXcvQgNzJfUjNFxkijdITu6ZD6A1D3id9Of3XHYD+K5ZUd/Fb3YxChoilCFhwrIYCx63wLX
	D4f4c0k+HAuj72ygUiuQ+RB0+zY+Qjf2DQrkKcbFTVXAkELYLJxl7r6MAkmyOY3Jbrj9z/I
	61MOhUwHsQvy6r4YBEVhxCG4UNDcvGjdJhZ3GhYGnnFrzp+nrsMjJuYb9dVpCNoKHPgAQZu
	goQwzKizL2QK66PP2+CRZ39+FYCIALCmR6/UenScSzIoLnphu1/kIZsDAN7gL1eJMthlp0Y
	xDaN/eFLjzvyiS4fOm/V9hd6bNqYtlC+vXATdCB1nk0mxW9W66YR3p8luHJgXAvGqKE+lNZ
	WGEhPot/lNyrAKPdMJhBl1YAyjmL+WgOZjGyrCogbVgsfC06UmtyM0wkkM7XYYyc9oMjdx8
	22huSlKodN4cIsa6Putrz5i9j/PqkCjyy052HtdE3EGuohlIAdgSzJHmL4Zq7KFG0n7fZRR
	Nz6DFUskpcrSMXbyxV4ddxHXq188XPl11mS3ThFr627rX0eVXV9dgHopyzzWj5MyjId2EfP
	YTBIHTXupod+tWjeR7uCf3wXPWCkGadeJkMUnQuMAyHGe4RNPkVBhKM513kroJWF9Reqymp
	9jjtKnd7zohVBmxz1v33tdz7uiQfY01IqL7fbPLgBmK4abiwuEeMYFUab9T51sJUkzYhYh5
	fSkVaPG927WfH7k8A3VNMxe22Q7MNy2p7X6+HQ0dVKZWKfJV0nKyx27jQBZELkxtiHMj6TY
	EtTKa5A1W8ZccfqF+SWtbhRa6trjoiiotLry4iUnitzPkYm437oj/zNBDgf3/9ZCwCpxHnQ
	McW+6mKaufkZ6O0rosjRkSf9yZXp4R5uz8S8QLmpibEkoomypbP2k67b/tLCtTvcg6MFj8u
	lFODj5svxSSU71fBpL+Oc+qq2Uce8ESA+kp9GRwUQT5pe5RR5d
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

It is clear to remove the -nostdlib for ld, it is similar to commit
bdbf2038fbf4 ("MIPS: VDSO: remove -nostdlib compiler flag").

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 arch/loongarch/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index ccd2c5e135c6..d8316f993482 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -36,7 +36,7 @@ endif
 
 # VDSO linker flags.
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
-	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared --build-id -T
+	$(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id -T
 
 #
 # Shared build commands.
-- 
2.20.1


