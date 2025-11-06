Return-Path: <linux-kernel+bounces-887629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E5AC38BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 851A54EEB3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5D221703;
	Thu,  6 Nov 2025 01:52:03 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9D1DF273;
	Thu,  6 Nov 2025 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393922; cv=none; b=ZUxz/+sLhr3Ec1CqM2zANiVJABXvoXMh9YXyRA4hl3/CbWJ8EO8AZiGlNFd4igpnTDfm1WbGQpyvwW1IdvG2eJn5GQhUXLvs+fPUhnfyoHk5C+K06HHIiFCf0U7HCDGp23r1kZyMpy9Tuw+rWbHgQ/JImwdtbZmv/8aBpETyaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393922; c=relaxed/simple;
	bh=3CCbmMymK0ULlPSTKAXkiBqudh6MhKNCAHxuexNlEuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qmsv3tCPqae07rDZ2ycSICtbK9Ml+KFWePciAmuwjEvPRdUtZMlNt6D9gjaH9A3mfI29GqFOwm91RLxopvRqtxfsZoK25F9GbUKz+HiW2xe3pqGGJfq1t2whnC+jG9V2+3Uo1RWkOW2QWpE7M1n1qW+kq9MhfEBivt0vS3ARgkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2b21c0babab311f0a38c85956e01ac42-20251106
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:67eb8836-86be-490a-93c6-e1c8495515fa,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:67eb8836-86be-490a-93c6-e1c8495515fa,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:3721bf5aae6e1147e7218dee29ef3e10,BulkI
	D:25110609515685T1QEX0,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|850,
	TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2b21c0babab311f0a38c85956e01ac42-20251106
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1656210356; Thu, 06 Nov 2025 09:51:53 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs/zh_CN: Add kbuild timestamp Chinese translation
Date: Thu,  6 Nov 2025 09:51:48 +0800
Message-Id: <20251106015148.54424-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sync the translation of changes in kbuild/kbuild.rst about
KBUILD_BUILD_TIMESTAMP.

Update the translation through commit 5cbfb4da7e06
("kbuild: doc: improve KBUILD_BUILD_TIMESTAMP documentation")

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 - modify the commit message as suggested by Dongliang and add
   a corresponding commit info for the English documentation.
---
 Documentation/translations/zh_CN/kbuild/kbuild.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/kbuild/kbuild.rst b/Documentation/translations/zh_CN/kbuild/kbuild.rst
index e5e2aebe1ebc..ad3e84eabbbf 100644
--- a/Documentation/translations/zh_CN/kbuild/kbuild.rst
+++ b/Documentation/translations/zh_CN/kbuild/kbuild.rst
@@ -290,8 +290,13 @@ IGNORE_DIRS
 KBUILD_BUILD_TIMESTAMP
 ----------------------
 将该环境变量设置为日期字符串，可以覆盖在 UTS_VERSION 定义中使用的时间戳
-（运行内核时的 uname -v）。该值必须是一个可以传递给 date -d 的字符串。默认值是
-内核构建某个时刻的 date 命令输出。
+（运行内核时的 uname -v）。该值必须是一个可以传递给 date -d 的字符串。例如::
+
+	$ KBUILD_BUILD_TIMESTAMP="Mon Oct 13 00:00:00 UTC 2025" make
+
+默认值是内核构建某个时刻的date命令输出。如果提供该时戳，它还用于任何initramfs
+归档文件中的mtime字段。Initramfs mtimes是32位的，因此早于Unix纪元1970年，或
+晚于协调世界时 (UTC)2106年2月7日6时28分15秒的日期是无效的。
 
 KBUILD_BUILD_USER, KBUILD_BUILD_HOST
 ------------------------------------
-- 
2.25.1


