Return-Path: <linux-kernel+bounces-863597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21497BF844B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C5719C0A40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B7257820;
	Tue, 21 Oct 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSuXqKmb"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8821FF35
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075209; cv=none; b=ixjBlTic7oZ1GmIwsaGz+eSB1uSy+tya1lftqJp0E9YV6LL0ncFjdJnFoEq/vzsPvAIKpz46126OyOCuHFnKswBCbinRrVRSmGDMkyeGovpgv2U7rLix0T3Y7CthKHTFp+4Ld8bv+xyVGAoVSheStVIqP30Hn+r74w5Dg7RhpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075209; c=relaxed/simple;
	bh=2H049I89BxKd0KACb/ORIx1f6NaIgJoRwhXgD3m6n1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCwY84iogH31o9m6q25lmBJ7Sc2SEAoO7mHZtuu7Kosc6On4C/iBgr2RoTb5WSZQ5dsN89nedCsNmAio7vYPpWgOz2ACNG6e+0QssJpwSzjBgWdV4hOYrQ7F14ajbK2wOp7KgD/cSiWtyp4FFno8r2HIT9kGFptLlH+le35KZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSuXqKmb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4285169c005so462601f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761075206; x=1761680006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eceHFX0RmtQDMq4x5hNy8OnbHWKSwCTIDv7MpsAV2Jo=;
        b=BSuXqKmbhlWrR1eJ0jOAdn81p/OJpmfzRt/wdSwvcsrsfvShTTVIumDzCzpaQ6cmwh
         vLJo4eIUh2OGEegQn2nULP7KLfTYA7NIqGHPNFgmxqT/0OgX9ksb0YtSJl0X3SU2IKnR
         FhTHpVznJK1exGjANHJm8g/expuqCvSHKWHHGq9TH2EHg3iwTOsw4DAEL/1/zjyG5rLJ
         dlrvgScutxigc9S9V4Fsw52VzksfQN00AYb19Q/jXqspuA5kMNZMEnCUfsIBv8Ubce6X
         jK8QW77Dh3h4rE6/Qli+sAijFeNk3g1GDb7Gl/uc5JpIaFdhydivrUkgxNMSov9u1h8U
         OdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761075206; x=1761680006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eceHFX0RmtQDMq4x5hNy8OnbHWKSwCTIDv7MpsAV2Jo=;
        b=PDhxvdH4b1irITG0RRhOOHKttx63+Mjox603IiiX+Ha4y0+OIqUC7UMoDpDlz2dHmh
         C9rWPjnvRgH7Tewy+EhU88B4OFdvgNQdjI0ZmcrNYROBm6buL+rUddRc8RltYzjBx3a2
         RWV4WqBd68ymh0yqilb2n37UhRsvuWKE5DeuumIIiZbxkexUdWWlT+Pb3SrNUjorQLMv
         2+CjMSaSIDHRPml7I4sGZJHGxP50erSHQYFHHrsJBHkrqN8QH4nswBBB0Ph2v3A6OTpK
         Z1x80VCrBffHbNIrs0DLsUiYmfjZl7nCadnRKFmOPcDgTkE8i5Q1LO+uWV8TLpvPvmmN
         cY1w==
X-Forwarded-Encrypted: i=1; AJvYcCVztgwfn0jDuHU8KYbdoAUYvPyJ8UXekKMHDVkjvuEmAVH++PGiky9fngk0JU0lIMO/0ytLlL1Rac3gSMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZchTeoI46bXqYGd0VpXmZk5SzalJR61tNqO2G7yxcWQdtMATO
	Js2tZ+G7/HPpxifk23z8K1VAjTpyuNpkCpFqnV1JMS8gpb5oOi5byJex
X-Gm-Gg: ASbGncvibikK7i1xzX8rcBpnjdfYtW8dj1CfUbEIJ60YXCwqS3gPcJir3WX9Hr6C97K
	zMWYHkSqejJ/mHPNC63bo7f92sLG79KRvFFaQ1aWElw2zTmqNbxmArYFKy/vLMJI+kZ/p6xIR7z
	PjzwhQiD13vyCcyOrZr0I/PE+m5usqzjtDzbocl0590N6GJRk98ze2YaXNzVhdWPpumx+xOOaEt
	valOFdiDS+hMzIGssPeTbcguxfQCVaoXcMGwV9EakcNcVr8W+PyvZwNNktQ45+P7svykcfygF/o
	4/sw7/35uiiNjhVm4RWY/T+LNUG9t3FAJnGd7v/iJEpVu1+NfQM/gMWOVmMfoGgni4X+7kqTJ7n
	st9jLSjZCmo96TWXW0DQsQybFO4CBUlo/m5/03R+FAo5X3eIEozj1T/YImrvl6tnR/kRyXVMHBw
	V9basKznTlvGPEe6uEH7+655Xe4/l1zObZ0yZGoAmVubk=
X-Google-Smtp-Source: AGHT+IHOYqls17257tkZfrI1j3S/rbxbkd3G5LS7Xa1V5wyrUo+IQJd6ypdrMXOGDYIilpkwXDnmEQ==
X-Received: by 2002:a05:6000:22c5:b0:427:492:79e5 with SMTP id ffacd0b85a97d-42704d7504emr10968810f8f.21.1761075205922;
        Tue, 21 Oct 2025 12:33:25 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm21327187f8f.36.2025.10.21.12.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:33:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 0/2] net: airoha: initial phylink support
Date: Tue, 21 Oct 2025 21:33:10 +0200
Message-ID: <20251021193315.2192359-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This trivial patch adds the initial phylink support. It's expected
in the future to add the dedicated PCS for the other GDM port.

This is to give consistent data when running ethtool on the GDM1
port instead of the "No Data"

Christian Marangi (2):
  net: airoha: use device_set_node helper to setup GDM node
  net: airoha: add phylink support for GDM1

 drivers/net/ethernet/airoha/airoha_eth.c | 110 ++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h |   3 +
 2 files changed, 100 insertions(+), 13 deletions(-)

-- 
2.51.0


