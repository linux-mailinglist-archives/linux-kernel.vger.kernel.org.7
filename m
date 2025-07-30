Return-Path: <linux-kernel+bounces-750163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597EB157FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57CE7A31A2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7F338DD1;
	Wed, 30 Jul 2025 04:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTSP6c/u"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D72DDAD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753848263; cv=none; b=FCP1BqsoUYxtqtL75c5bL00VRy1s0Pyq8xxjudWlYGP1ZLKVn/GxH1wYkOEXYXJRBsTcyjZraPMunjE6KlUtwkRVT1t5gt6UQtyPwOajKNSWFT26AQ04slsjFJroYlNwu8E4t16xfswMiKGUz5WJM3XC8FH3XMYcTwj3PxpjWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753848263; c=relaxed/simple;
	bh=WO7h7ptNQ+0Kd+IO3No6V43g//yPa9vBMPwtDSJ281A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DnjQvkWnI3r/jUrZOfYiy6maMG5oqEjogmvJBV2BHIG9NEO8eJ4cFvphKvLYfIClu6uqwDFayZZ4AWazE0lWVnb3uVueQDhkSfupZQG3AOYBf4rgKOTs2XJ2nv7o3rkd2CbZ6+G42hNKZvU2W0uJstMho+ciQ2lxgapfOPyAAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTSP6c/u; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab82eb33f9so105263251cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753848260; x=1754453060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4a9sYy5/UHt9zQbhrCp+lFdkLTN7GRIjDcgOwX7XLc=;
        b=dTSP6c/ubB4Yc1zqs0m5mnw6kYIF6q4Cv72rjNC7JzyIPMx8VlYHIqaqozEwaf4t0A
         xY/KicM4vvkY5EOJKUIdcgicGs4fqt7D5SK1jabJst3jkvIa7aso5sfP6Ox10UG2oRBc
         e313/AP1fiR31dCHAC5aF9NfUaG539LT6DAqrLIl2qEnkk/hmMmA+HBtfyf/kIP3E/tj
         PZZ+ZuEucgIflh6bSQJ6RY/2ZoIWW2KBzbvej3fUBb2Mg0ycDACXf+fvfpwmtVsFcxKN
         1JrrDjO3jM/Lc/YL5rvEssu00b/p3vVCN3vkYppAcvlK0kJ3+79eUC1R2w4WSDBruI0R
         S8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753848260; x=1754453060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4a9sYy5/UHt9zQbhrCp+lFdkLTN7GRIjDcgOwX7XLc=;
        b=RDjaZPMRaLhr+2KpinUqh915pBkmQl0ZDHfo0y4eeqflbtPKHvLAdfxxHyr15iJ5+e
         69QPCm7OYc4zFjBR8A2VEAiqEtAlhHLpdImo33NQhDOZ8ZmfLYciqWoIkAaQsiY6uVjh
         INHQRIHvbVXciqp0M2MV/QkSx6Fi4KtR3D0bfST8edH5paieIZMEPP2OZnArPaSmzV9C
         w86fk7xWCfZg/Z1WMl5B8aBpu4xkqIwFJ/T1FpKS2a05EegapYdocaNTpBGNE8/R8dfT
         xLDdNRUdy+Ig8cDkdiOuG2TDXPV4ItVQlUSKRVLG7az5KkSmKS6iMv6GjvZitQ3VAwlQ
         w38g==
X-Gm-Message-State: AOJu0YxpIkwLCHgfzaF1wiel58KwnalFGUjOHCvQORPKyti6USCh3Jdl
	az0+wiZ8Q6UsgLokJcUbeO/fnYKCyxT54LIhJkpkrQA4qqt35IifLANeYXIHvXmo
X-Gm-Gg: ASbGnct/VygvOnlFMtMVEmsRweh0+SIcDb2NnKcTOUHTR6gQV/1vjGwvFNDrtz/4yu/
	R0K9ocXx7m8XSWb9xKw7nDjWm6uQPcVcgjcfn99Mufui+tFgbr34nDVk7WqsPckrKVaBYF3rQes
	JWfsnz55C1Ch/yMKmsOBmcBVhN4rTg+hMcrI4FJ3vAU4J0gDFemg6dHQIYUilBT6XRjn0HkvZYF
	kOrLFQ30zgSqdGOhaROky3OjwNEZO0wkL9aVft7FBGJdFCGqGfjXdYXy33eyz9hzIRoxZ764i7c
	q5jRzuqp8kgXbsp64QJoRMqrgxES+oi6w1K2Qdm3vJEA8Tgsl7r+vekbacepBW6vOIhrershqv6
	rYhViTml++zkHFQBuxfTyFCJ+eDR40htvANxT/YO8p/JJc+ZPJAQ=
X-Google-Smtp-Source: AGHT+IGj5tKV/3vzPEMftmSFFMwZvypQkE6wxk4J02+x+4t8xFQyvzhizYqTcghhmrhKkbZNHTeITw==
X-Received: by 2002:a05:622a:1819:b0:4ab:5651:3fa0 with SMTP id d75a77b69052e-4aedbc5cf33mr32039031cf.28.1753848260178;
        Tue, 29 Jul 2025 21:04:20 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae99671b3asm60056091cf.58.2025.07.29.21.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 21:04:19 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Markus.Elfring@web.de,
	vivek.balachandhar@gmail.com
Subject: [PATCH v2 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
Date: Wed, 30 Jul 2025 04:04:02 +0000
Message-Id: <20250730040402.488284-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728043628.421849-1-vivek.balachandhar@gmail.com>
References: <20250728043628.421849-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a blank line after the definition of rtw_roaming() to separate it from
the following function (_rtw_roaming()), improving readability and matching
kernel coding style guidelines.

No functional changes.

Identified using checkpatch.pl.

Changes since v1:
- Moved the '---' marker line below the Signed-off-by tag as per kernel
  patch formatting rules

v1:
- Addressed review comments from Markus Elfring on changing the description
  of the patch regarding readability and separation between function definitions

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 24e505111f1f..b1a427a655ef 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2449,6 +2449,7 @@ void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	_rtw_roaming(padapter, tgt_network);
 	spin_unlock_bh(&pmlmepriv->lock);
 }
+
 void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.39.5


