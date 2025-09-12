Return-Path: <linux-kernel+bounces-814677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2FB5572E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295D5B607C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B71341AA5;
	Fri, 12 Sep 2025 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmB0KJpX"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6E338F58
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706846; cv=none; b=k7hqENRHxgUD6DCurW8t3QqSrmS3lNprkFJUDWsHvflE2w4DaS/Rvix3CoRKL7GaZA0IO/HKzaAgn+K+DnPXg7qRI20qWfgiIBEcuRH63YUJktaa4sefXxNkK1epLdzBHXo/Yb/ueCHKbLbtXlwkNXqVzldJCmRyqk3cyJbKkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706846; c=relaxed/simple;
	bh=i9K1yIVISo2iQdbGiNCGMmX6M0Ed8p2gmujg5khZUS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayoPlsikNJHvRqEZvHrARmolvK02MZV0HHLY5UCz7dU68SXHBsvrELBc2/NFZEey6kGmG42qrea4Vp+2sOJoAErIQjNS5CBbyx5CG3I+FL95rU9R4JisaxxfKZroy5U8+E+DPaSRpCubo/95KaTKCI/+ApziEtEi0ulcWoTh63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmB0KJpX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e7512c8669so1573945f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706843; x=1758311643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJf9PqzT7hCLse/9dc5RnwMhZr9VIrZ+OxaGIRW52I4=;
        b=FmB0KJpXntobLEh5anKKetIlT+aOKPdtezTmCZwruXA/z0THXKhk9Lzhvafj7kTBBe
         mox4NOch+Rgntf5TObXKiucVCHfRTKDEkpNzpAynLo25CcTnfC4eC+KZxdjMyLqh1p0L
         4GtOC5MhB60kSEZdornio4QZEBH9ivwEBpBlPTPK9NIPXwMT1XCsSBUrqLJY+d0ARUlT
         4LoJkYsa4iMDNbJ4475xeHp75MSBLFdQUGC5LqmMXOjQzyzUJbA2RagXjIQ5lx8sZ7EH
         fk+jx6HkWf/I1MmoEShVXghMJXBl6tm0i/mPExaUyeuyWj05g4eL/tciGkYeIR9T+INs
         dvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706843; x=1758311643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJf9PqzT7hCLse/9dc5RnwMhZr9VIrZ+OxaGIRW52I4=;
        b=O6zyhofB3zdwez0nXmb8E4zNx+w/jfH2piKOUlOvAcNKg4+zNff2pQq0KRpGnFXrby
         0U8XPtLscp/MNvphUWxk6JURWJze2vO3d2n8vopBGbyX2tACx9Q/MyOdIwel9/PO3Psz
         FzWTd22TgZIzQdkDCRvZsTSd7tMJI53m50rj75pIhxXT/AM1AkHBDXm6bwjfRNGOPxQM
         o1Te6PW1QOsK0x8G/lf8YYqtbtiqPhCu33jazfuy8ht9n4+0ekSRqjh4f3EOohiHxDxJ
         P/ceaxcNND9fU1GhGFpGvIIDvHWFSeBqkHYzfM1fV9xDB6AapgXlA9QJ0WHizGAKmv9m
         atnA==
X-Forwarded-Encrypted: i=1; AJvYcCU5pLbK5yaP40hJAa+2SOKDLcC5Svl5bOWcijiZ2Eyc4IWixRl4Wzvkqul4KZuSNLg4+ce6QyE2p37Muwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+KwXUGtMl5L+SM9ae/A88xbFtULTRRhXiNJqnwkUnurYvwwA0
	V0uCUo3XOtm40CGj7Tr5jEzK9HeqNhufJmjntR/NloWJGduys5uB+JLe
X-Gm-Gg: ASbGncuQWmaxusO2AFH2QCToo5e4ZKIXjlvIDH7YmydV9O0AH10bNqQf6PQW4XFiuVe
	36bM8LGhMnbjNMKwTZjnW13e3q8ZnkNiQGXf/uqcnKow3KD6nzj07jwxmKPEvwfWp4O7MGbTwzE
	CvxoxWM9CxUl0U87iVm00eIbn5gMGgAy/4a9ZyzMysdHi7EYbAKLpjjSV7pfo9E+9JbDad3zJeO
	3IMxC3WUOyd118H+vkQ6JjWNVxZ8vNeUXXp8Jf75xr4O20dRNrsNMrPVu/KsChFLhmCvIl1p2mH
	NbnmC7M8z5/zVg4E/TZUzFg5nyoZmYBMMdBCB49BOoqtT8yOep/io+h9ZsWVJjvfhubn6mDKB3Q
	lRJQG6bFQO8bZsZB5X8Eppb7AaPpGDCtQIeFrcc6ObhTLmOnExNYT+g9nrpY8O7Yi7AzR1ZSL
X-Google-Smtp-Source: AGHT+IEPloYMebO2+94+EujzqnwtJ3qCQMiLzStQnR21n7BZH1TIPhWvC/p9EdtNP7maaHHDBFj5RQ==
X-Received: by 2002:a05:6000:26c8:b0:3e4:f194:2872 with SMTP id ffacd0b85a97d-3e765a140damr3473105f8f.31.1757706843387;
        Fri, 12 Sep 2025 12:54:03 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:03 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 08/15] genetlink: verify unregister fails for non-registered family
Date: Fri, 12 Sep 2025 22:53:31 +0300
Message-Id: <20250912195339.20635-9-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that genl_unregister_family() returns error
when called on non-registered family.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 .../net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
index f651159a311c..ad4228eda2d5 100644
--- a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -1402,6 +1402,10 @@ static int __init module_netlink_init(void)
 	if (ret)
 		pr_err("%s: Incorrect Generic Netlink family wasn't registered\n", __func__);
 
+	ret = genl_unregister_family(&incorrect_genl_family);
+	if (ret)
+		pr_err("%s: Incorrect Generic Netlink family wasn't unregistered\n", __func__);
+
 	ret = netlink_register_notifier(&genl_notifier);
 	if (ret)
 		goto err_family;
-- 
2.34.1


