Return-Path: <linux-kernel+bounces-883884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC825C2EA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DC9188FF21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66C1FC7C5;
	Tue,  4 Nov 2025 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SmNmdf2O"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A831E5B7A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216964; cv=none; b=GjXq8AeqU64zWqxLcIBXDGgIJ/7CGgwO+FEiGWd+O0lPqp/IhoC/s4I86xv3RWv1ukOZiANIi/f9cdWFWVRD3TFjM5rj3Ark+n2G3eopb4HNZumKlzQ3Isw4+mjVqYJNCHk5Tsb9oweH3Eznjl9586nZt4zYCh2znaR2WZRHgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216964; c=relaxed/simple;
	bh=ieVcgouD1fIRWguH3vv0rjAGbsx9tIpcqUB/nXH1xSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ax0Li5TTlO9TeqBRJPUuWOfZFH7SY/pM7Tfi1m0ePIm3SuDHYE5uyhveNXB7ZvQL7rsoyDGNVluAVjYTwbqW/ZKH2hR8+7UnwftVaWf6fX0aGikKeYeLryhRHGb0hYpzbOBGUp4UP6eRS2FXR9UcHQrbpgvWxrgYZcyMU97sljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SmNmdf2O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tlcotiyt0fzR+u4Q2cFuQsPbb4Lri3wczewEJGt5nfw=; b=SmNmdf2OrYhbSiC0BVGJ9B+6XI
	XzD8RUPOfBMOXqb0BUdwe2F15VTgZ7ekNEsTzv6Sa4UEbkXcVb1/uH59QqnRsiItjESFvBfiaIwpn
	pSwzpjZvQHXLRjYn3vjr60rOniEUaFof68dun9olLM4hXi3LZ62EWlmjor3IJdL9MnnW3uLVYVQkf
	dLn1/2qIbpM8eZowV7KwDU6bJLhFtvTR9dGV+6rlu/ue5zQelOd2uKKnO+Gqh+epOPUcjGjGYWvLW
	FcMJwzRf4sr15T+tyF9BzZLMpHB3Vdt+UB0nK73YuRwLuMIvXfGRHwiRjqaUiaOdA4VyVoWrS/jhy
	4iWBEQVA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG58D-0000000ArWM-2k3t;
	Tue, 04 Nov 2025 00:42:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com
Subject: [PATCH] firmware: cs_dsp: fix kernel-doc warnings in a header file
Date: Mon,  3 Nov 2025 16:42:41 -0800
Message-ID: <20251104004241.482723-1-rdunlap@infradead.org>
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
---
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

