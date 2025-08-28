Return-Path: <linux-kernel+bounces-789650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EDFB398AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829C31C827BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBEB2DA779;
	Thu, 28 Aug 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXp+EWQv"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120E26E6F2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374407; cv=none; b=CUq9TQ8zK+9h90tjUsbCdu1hFpoJ1y8UnBoy1HI7Z05L6mCGVsIR39xQQH/+80RkJpsfZsotZmldrxzAFiwAm9IZ+na2sqN7zsP2vcWBSXFfp5VTd6XRFX9AGs71H6zUuAAS4deIFgY/9pKrKkZlMeafqF1jLUcLfgIivTqPHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374407; c=relaxed/simple;
	bh=Yuh2ilkl49qigY14vDa5g90O/ZTEywXMWlWBmVgjN6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvcxxhweL/oMtA8+2UFa1Z1mgE+6j9JL3cmjS4BgS6yGfs5PEiY+UxqIJhFeJgIvPqMiEXD9gyG64gnulD3elfB2SvvMgvqve0p8ilZLtR/d2nfepEsjoiHu2WofmJNnOtpO5Thk+aSxYZQpQ9MRj/Mof05WsImq8pcWIpv3wuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXp+EWQv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7704f3c4708so905644b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756374405; x=1756979205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WV9EP3WiHIkOcIDq8xrAUCSMCtBiY+6XMNrlVI5mv1E=;
        b=BXp+EWQvvXgbrhqgwXhKnHX0C23PCTeU7dWYb5DdtQZt1RWXVbiipPvRAEpu6FoZjl
         sGs8T/iW9PsYB954sYNNZos+gS/oy7BfIZqQyts8oLuT2o5YXovPcNU2eCo9diM50Wv2
         QCAAAkmaYSIJ2ywA9yXU1eySXy5yApSDe43q1QNpZ9HOtHJzqh1hPwzoN/vxvUR1L6dS
         CLz1CD90RDe1lFiJQXX7aB9NCjIa4IfrmlTjV7GQD3EZK8TKqZUsQsK7unMYtJ4NErux
         wTaE0FQZlT1TcPAvI66jN4Lal3x3qnevWgEOmnD2SVZlWMhmbD4ii11RlobKtkXW2PN8
         7D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374405; x=1756979205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WV9EP3WiHIkOcIDq8xrAUCSMCtBiY+6XMNrlVI5mv1E=;
        b=LSMK3iY+K/VqtIgLD2YDGXHSdIumh5TVLV/BNzvY4jjzx4UJ37avHkerS8+3mWGMS7
         ZE5rQzGPCcgNL0vRD/Yuiv5CvXqKZHc28SZHwo0CBaj+ZAhroQmpsaaAt6wu8jElsBpd
         yfEJOq3XE5JME3MnZIOKashtfH0Jbp1l1lZ1sjJB/IE5br8TbNXdojK8vkekrrT+t0u3
         SjxC2rL/ZaOR940wB1fGiiZ94VQelEYmmZP+iV4afM455TSUEvd9CkbDqulSbdrcV1Za
         ZYFxkb5bGav7qlKlCVtpuyq//uh4UEI/brzOzOgYOpkQAEKukeZwC1bIAdEgksXdv+3D
         vpbA==
X-Forwarded-Encrypted: i=1; AJvYcCUXPDqvAGZUq2GX4fBzwmfPGx+R8jTr7EFF5G0513CxuNJQa3KhswpVRgpjL6ChrQ0/MrMK1HQM9Pt3fms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA51wZ/8Unop/gB64Wjrhs3wFUESMusv8QChFtMzcipLr2dI1G
	5lf5lLl/5V7oxvToCfgc+FAsdaU0D3CpHc+vwXA/ufB/DKfcje4DGAkm
X-Gm-Gg: ASbGnctuikHIm1LCPARi9HpUc+GOzbHCag+pdAvYr3hf5tNv781uMfqmBe8P5iVUFK2
	nafjUsiVYfAVMdfHif0pqBj61gMx24v2Pdld6sjH0Y4Un8i9G3elRI3xkhUYzkXxxFUfMeXXA4D
	E/D4mTdCngpJZ2C2nPGJtzuh0Fi2RdbNaWw9HPDn5CUSxh0dO6vMT9hIIa6OvbJIMXNlJ7D/dJf
	8jfn7Wrnf8omqz5Zt4stge2+yajFtfhlZt6vmBRqIahJQ+2mBVVyRNViU5PexOJuHS8FZCE2XdN
	Ba7obYVrT2bxdujf8yUcIW4LHxLJOrFthOU4JrO4QCFa48gUO2sAO/LOvqs5E01hn3meGjbGLZN
	UdckzosIYe0P/49Lc7S8damsW/AQ0bsUCcFCcDobDc76BYp0yf9hlpCqChDdwf9xa6Z56y7umLg
	VdrA==
X-Google-Smtp-Source: AGHT+IFzCwjXA12UFQ+soxjLMPsT7ynuD1wJEEhRU0FFfN/HRedhPq2h53Pq5F2zABdrX0M2lgpglw==
X-Received: by 2002:a05:6a20:1592:b0:23d:dd9b:b563 with SMTP id adf61e73a8af0-24340d15dcemr34925546637.39.1756374405378;
        Thu, 28 Aug 2025 02:46:45 -0700 (PDT)
Received: from yingche.. (111-255-102-121.dynamic-ip.hinet.net. [111.255.102.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8b4b98sm13591617a12.19.2025.08.28.02.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:46:44 -0700 (PDT)
From: yingche <zxcv2569763104@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yingche <zxcv2569763104@gmail.com>
Subject: [RFC PATCH] staging: rtl8723bs: fix fortify warnings by using struct_group
Date: Thu, 28 Aug 2025 17:45:37 +0800
Message-ID: <20250828094537.884046-1-zxcv2569763104@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix fortify_memcpy_chk warnings in rtw_BIP_verify() and
rtw_mgmt_xmitframe_coalesce() functions by using struct_group
to access consecutive address fields.

Changed memcpy calls to use &hdr->addrs instead of hdr->addr1
when copying 18 bytes (addr1 + addr2 + addr3).

This resolves 'detected read beyond size of field' warnings
by using the proper struct_group mechanism as suggested by
the compiler.

Signed-off-by: yingche <zxcv2569763104@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 8367fd15c6b1..314ec5894d47 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1363,7 +1363,7 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 		ClearPwrMgt(BIP_AAD);
 		ClearMData(BIP_AAD);
 		/* conscruct AAD, copy address 1 to address 3 */
-		memcpy(BIP_AAD+2, pwlanhdr->addr1, 18);
+		memcpy(BIP_AAD + 2, &pwlanhdr->addrs, 18);
 
 		if (omac1_aes_128(padapter->securitypriv.dot11wBIPKey[padapter->securitypriv.dot11wBIPKeyid].skey
 			, BIP_AAD, ori_len, mic))
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 8c6841f078b4..424da9030f60 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1209,7 +1209,7 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, s
 		ClearPwrMgt(BIP_AAD);
 		ClearMData(BIP_AAD);
 		/* conscruct AAD, copy address 1 to address 3 */
-		memcpy(BIP_AAD+2, pwlanhdr->addr1, 18);
+		memcpy(BIP_AAD + 2, &pwlanhdr->addrs, 18);
 		/* copy management fram body */
 		memcpy(BIP_AAD+BIP_AAD_SIZE, MGMT_body, frame_body_len);
 		/* calculate mic */
-- 
2.43.0


