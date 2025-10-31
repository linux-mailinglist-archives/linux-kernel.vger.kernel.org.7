Return-Path: <linux-kernel+bounces-880235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18262C2528E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2004424286
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D9134A789;
	Fri, 31 Oct 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWUEHXVz"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E41EA7DD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915875; cv=none; b=M8k1SYqfXFlpJQ2QVNw2p6elftSOJGW82u8BS5IhM6MzXv5n6jLgUqcSA24mY6739LD2ZY2at33O16x09mpL4HR3tL5bN+/39TqN7oR3t2KBXEOQ3ajs34ChAKVjdOFgwzveN4geoDR1GNxi1TYIEYB89Vd8z/91OzDDdqf0onk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915875; c=relaxed/simple;
	bh=yeiq88IC/wiatgkkK0r6GR62xuv/O/ItLS4vy5v9HZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uL8M2tjhe+j1YfCjCKL2e8sRwRWgPgXYRR0BKk6zPj7xjSKUEwfMc9WLdKl9hzMYbZ9pQ//WNanS2731ejrzoWMcShqIVZUY5ZXzNr1/bV0spYtruv1poR7m6GO/yyQM5grQmW09Snxb1Uljc6UGp7jgymHk8oOSuLXMlHHUcaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AWUEHXVz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47114a40161so25294765e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915872; x=1762520672; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhTG70xhFOoL3LxdnSOH1s4YIgOQ3cukod+Akz7RCDg=;
        b=AWUEHXVzRER+h3Fa/h/PpkzNHYFo+BN1THtGkFpY5ACBoaNibcfs88be+6wTqjh5c8
         4+rLyQEHYb7P4zllAPFRz9VCNRiRvSDvqT80y8xqGrp1ryUg6VhmMt4Gmm9sXvzNuThu
         I+Q9YNN+DawHtGuUNqAfa6lt14W4ZlfL1U2bt5weoYD/n9CxZVj6haqd6oFAD4/Ds9AF
         b5IDNha0wTlqbgIKwEDgNk1sTybAEMIH3iMM3nzkDGkvM4Q8Patnj0bwuu997iAHSztQ
         gt7kBpINEcP5qJsYeonUmMevIdL3Ugr3+F17Qa85h65aGcA1ootFzMqkoT76epJpDb+n
         bwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915872; x=1762520672;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhTG70xhFOoL3LxdnSOH1s4YIgOQ3cukod+Akz7RCDg=;
        b=AH8iY/AT8H7bIVwU9SPL2uw78z8MY90aQxRSeaGmsUJBJq4cMuOH7Kz9t347m5GhsT
         TtvqFc25kshjPM7HfPdu8xSqID7Bw0QHCA++bpSpgnpQreS7L9mP0rE9AJ9ctk2YpW9S
         xmXiduEj6yFc3k0uIeRQ40AAStVHKnfnDdR6U8OvDU3r6GFv8C3kB1POpb3Sc4YN9Zn8
         rIhFFpNVhb5KeOTZUibBOt88gkmLwKAkuSrZonD7T4GXBY58CsDTH6khRZ/g/5E7Tw3h
         GrnJ8n12OcdpHSPGI3xn77XA28QlkXjDDdsjK0EOYXN2ZauDXqvwln+3dogrBVix1VJc
         paQA==
X-Forwarded-Encrypted: i=1; AJvYcCWkOPPHEJnloIzBYxjlhFctaCyCgGFQtVneMjwmr2a5GIw0KxvWaHdtCRmObVTNEXKWypECnvw2g2P2aGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3JUP/UmluBbyspQ0FeLtJMCKf9HVzygcZZrjP3D+MLPgf1RC
	zAo6BtGec7L3BrBJtqwUdFlPz417JAbyOQZMKO+pN16Pk2C/a8qROZV78hJQKomZgWA=
X-Gm-Gg: ASbGncsP2p0euEbnRbn2CT8CZuW/5wPEJV6yOt6sIOWsX6Jr88hmO2WBDkyl45wX4W4
	5Se6UzWogfAigrCn4dB88ggM5QHzcgfR8X6zrplg23aTnxINBiIaiWqIrWEtElLj0qtdjb8xBu8
	bhON8gKNSrDMdo9af8yVSEwhS/o+IM7fwX7rcsDpDpoDVRIePGBJqDrBB2K8qrfgts4oz2p8zsh
	CK67e/z76FbULaj0GCKKjg80Dc7siLZA6z7VYldiQlp4FkbrWthM9tzVZ1MjL9ZBjaRbKBqFQqW
	WxKY5KMLDk+awGhf5oFaLLk8HELqHdOtCw0IqcB2zUonETsSLgW6c0PaCrv9zV2sMfQLkeqpajT
	sjvbS7P/Xny9YrZm6sxohy9E2hwYTmfFzNNg+Xovh7K/ZM4IatlILeL7CEN9ZjZ/zNjFhhzYueB
	v4LYaromTtEq+MiD3W
X-Google-Smtp-Source: AGHT+IESqZPWaIgD3AFJm0+ERJLsHPPT26aWWfG1t25b6cC3jhoS3LSTQWz0ZPa8qZHwD6kKbm0TEA==
X-Received: by 2002:a05:600c:1907:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-4773089c432mr29850955e9.20.1761915872032;
        Fri, 31 Oct 2025 06:04:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47733023256sm33788435e9.17.2025.10.31.06.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:04:31 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:04:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] rtlwifi: rtl8188ee: remove an accidental '-' character
Message-ID: <aQSz3KnK4wFIJoe3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "->allstasleep" variable is a 1 bit bitfield.  It can only be
0 or 1.  This "= -1" assignement was supposed to be "= 1".  This
doesn't change how the code works, it's just a cleanup.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Found with a static checker rule that Harshit and I wrote.

 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
index 7252bc621211..7ef57b1c674c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
@@ -694,7 +694,7 @@ void rtl88e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 
 			if (P2P_ROLE_GO == rtlpriv->mac80211.p2p) {
 				p2p_ps_offload->role = 1;
-				p2p_ps_offload->allstasleep = -1;
+				p2p_ps_offload->allstasleep = 1;
 			} else {
 				p2p_ps_offload->role = 0;
 			}
-- 
2.51.0


