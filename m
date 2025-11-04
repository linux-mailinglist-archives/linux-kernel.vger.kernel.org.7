Return-Path: <linux-kernel+bounces-885391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06637C32C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AEBD4E5923
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945C2D640F;
	Tue,  4 Nov 2025 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qgw+BgiX"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30A32D0617
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284416; cv=none; b=N1babccFEMo4ezhVbYHa5uJQ2tyC6u2qYxhJougMfvYgzDqp4wyDsWai2cYi0QX+/iZzNieRFaseAXEPGUhuOXv67vFGXD11l/Q7eDCRxjxECiFHOr2QunWnEDs8u+aw+FbJoDISMqxWewQAfz8lYuOPbeKdgY4gMW8++rWD2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284416; c=relaxed/simple;
	bh=5fxIbup6joyqmrns4IydivkkrduJVd2JGiHPSP/9gFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/S5Pudvww62+Bf70PhaijBUdOnhIRTr7S4Az4IK4YC3KlC+s9Y6T48jOXF47eoXmPUhf9UxsgnW/Yx1CkJucPc9CVudiI2CyEBUhLt82dn6o1ip4h7tY5QI5L8iZg3bssffVu8QIfzLhXJq1DFI1BkJW1YIDtmf6b4wnBta5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qgw+BgiX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=/2VBuqwC7zv2FCgBkt+u17LdT3yOHYDcJ0o3Q7AhBt8=; b=Qgw+BgiX5lodSonc/C0Kx8+qI/
	LrKymS0z0ULBEWmoburf+LQz7b5WePo95o+NBVakpp8Zs1PNlJejg6attoA38j3StKRaKEMX2aMkY
	/HxXuBNc08O6jHVaE+2o/XuzrGEu+pnLs+iij7REMhd7HPeu8jRM4VVYTAuI7D/LqnhpxnNMDXHIu
	mLlyJNxTgXqd/VmqXG8ZF/YxfOLBQcWtnVbkaJt5sq6L8YloIthfFfZHznVidkVNtl65iCmCUq3Re
	2JFrUSubaeUtsGiKaZr8JnhS/1X+zxjk75DplMNXqR77nrH5jndbN+bUm63Q6EUTrO5/hyT6zT+Dn
	rLy9wy/w==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGMg9-0000000CUQV-2hXj;
	Tue, 04 Nov 2025 19:26:53 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org,
	broonie@kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	patches@opensource.cirrus.com
Subject: [PATCH v2] firmware: cs_dsp: fix kernel-doc warnings in a header file
Date: Tue,  4 Nov 2025 11:26:53 -0800
Message-ID: <20251104192653.929157-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use correct kernel-doc format to avoid kernel-doc warnings in
nclude/linux/firmware/cirrus/cs_dsp_test_utils.h:

- mark one struct member as private: since the comment says that it is
private
- add ending ':' to struct members where needed

Warning: include/linux/firmware/cirrus/cs_dsp_test_utils.h:30 struct
 member 'saw_bus_write' not described in 'cs_dsp_test'
Warning: include/linux/firmware/cirrus/cs_dsp_test_utils.h:53 struct
 member 'id' not described in 'cs_dsp_mock_alg_def'
Warning: ../include/linux/firmware/cirrus/cs_dsp_test_utils.h:53 struct
 member 'ver' not described in 'cs_dsp_mock_alg_def'
Warning: ../include/linux/firmware/cirrus/cs_dsp_test_utils.h:53 struct
 member 'xm_base_words' not described in 'cs_dsp_mock_alg_def'
Warning: ../include/linux/firmware/cirrus/cs_dsp_test_utils.h:53 struct
 member 'xm_size_words' not described in 'cs_dsp_mock_alg_def'
Warning: ../include/linux/firmware/cirrus/cs_dsp_test_utils.h:53 struct
 member 'ym_base_words' not described in 'cs_dsp_mock_alg_def'
Warning: ../include/linux/firmware/cirrus/cs_dsp_test_utils.h:53 struct
 member 'ym_size_words' not described in 'cs_dsp_mock_alg_def'
Warning: ../include/linux/firmware/cirrus/cs_dsp_test_utils.h:53 struct
 member 'zm_base_words' not described in 'cs_dsp_mock_alg_def'
Warning: ../include/linux/firmware/cirrus/cs_dsp_test_utils.h:53 struct
 member 'zm_size_words' not described in 'cs_dsp_mock_alg_def'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
v2: add Reviewed-by from Richard;
    send To: Mark Brown as requested by Richard;

Cc: Simon Trimmer <simont@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com
---
 include/linux/firmware/cirrus/cs_dsp_test_utils.h |   18 ++++++------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- linux-next-20251103.orig/include/linux/firmware/cirrus/cs_dsp_test_utils.h
+++ linux-next-20251103/include/linux/firmware/cirrus/cs_dsp_test_utils.h
@@ -26,21 +26,21 @@ struct cs_dsp_test {
 
 	struct cs_dsp_test_local *local;
 
-	/* Following members are private */
+	/* private: Following members are private */
 	bool saw_bus_write;
 };
 
 /**
  * struct cs_dsp_mock_alg_def - Info for creating a mock algorithm entry.
  *
- * @id		  Algorithm ID.
- * @ver;	  Algorithm version.
- * @xm_base_words XM base address in DSP words.
- * @xm_size_words XM size in DSP words.
- * @ym_base_words YM base address in DSP words.
- * @ym_size_words YM size in DSP words.
- * @zm_base_words ZM base address in DSP words.
- * @zm_size_words ZM size in DSP words.
+ * @id:		   Algorithm ID.
+ * @ver:	   Algorithm version.
+ * @xm_base_words: XM base address in DSP words.
+ * @xm_size_words: XM size in DSP words.
+ * @ym_base_words: YM base address in DSP words.
+ * @ym_size_words: YM size in DSP words.
+ * @zm_base_words: ZM base address in DSP words.
+ * @zm_size_words: ZM size in DSP words.
  */
 struct cs_dsp_mock_alg_def {
 	unsigned int id;

