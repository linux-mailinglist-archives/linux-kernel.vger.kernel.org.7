Return-Path: <linux-kernel+bounces-867229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC64C01F50
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743B13A9726
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7D331A43;
	Thu, 23 Oct 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK0t3XsS"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767B311C1E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231547; cv=none; b=IiBGYBosf+Z8pITTm9L+ZzgJ4Bh92tGMZ6EpPv4rWSQ0IDXN45XYFQHDX2MoI+CUSFAPVlcd1gXS+bTHkZBpRuzwrzcN20iTRGXPpkjaBzgVSZpkMYknqcQjVTfLzTvWyEgKXkQK9XJyj02hx7of2wGA3mcvfrPZ93RWjJ4M8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231547; c=relaxed/simple;
	bh=S/0RC12Ct7sLa4BGsyULQ2Ksjr+REt4si7cQXyJnPMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cr7ycxEJ7FPkeSqFF6pmGP441PwelMrwbQ5pLS5he/cmu+gaKasrNG3Uqf3iLL1794SlGh1BXqahgl/UtLq+Zy5ltUgQ+nLu00TEzDKvG5bsGFLC6SLGv1/6B0/GSXla9yvjv7Glq2JzWSydgkXZUDtpjJczUm9T5aKK+4lh8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK0t3XsS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471131d6121so7454025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231544; x=1761836344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWoL1UZ/q1eqzSis7uaNsqbiHg0hktnmtvNBWCaQMdw=;
        b=cK0t3XsS/M4VuNiPBiOYP1ol2tFmd0l8dpUUmCpo4sNlLm6yb03+S8xPd4w8PKE08K
         xRH+FeRICVyrzmvc+6FBWtj4y7phnSTi+9ImuZ5jmLhIZKlo9HcajY/AG+98Uz6h/lhx
         jeprgLMO7+CDkilpM8FEj1RV2Br+VWRt+ikk5h02urws85egyZE5ZICDBjkq3QjnO3vX
         2RKvbz7pYGGma9+Dyhc032DBvbFvEnGUT7EJMj+ydDWiDx54EgsOCytD2QM29FjI1nx7
         mDe1pprPNjyNYnSsfFxqLyLuPFHZtkeJ+Wb0H+Kv6VFAD/+iz8Q67JnDlWllgM7o35t4
         haHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231544; x=1761836344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWoL1UZ/q1eqzSis7uaNsqbiHg0hktnmtvNBWCaQMdw=;
        b=B1mrv6x2UT+J5gC59K63LrBQ9IBjKYZ5fzJ+3CThorHHrvCKKjyzaNG7V733B9ZYq5
         r37R5OO88r/kGkEPDQ3zXAerZ03aZxLIeiyL4JzHNVh/qxLQVqI0COEG7xPtCkBnq5M6
         3BcXcMe3ttKgWQH0iKLHE/VYzOJsLau2g/W7Fh4scAqjs2+gSbhdKlc3Xl3K+xobSXVN
         ylKzcjFkIziSgTJptIgiO6dE/bmL7IrcgJVF1Y86fY1p8pZ0sfgWyDr8jF0T/npTarqa
         Y3O8oOpwhmEdwHE3ugl2tj31qNkjtCGy6WYAa+bJn+1+G0K10rvFBgGfqymHmq8AEwQh
         rIvA==
X-Forwarded-Encrypted: i=1; AJvYcCVFOM62CizcF28Wg7N+aIvnCIq4K6Isey++WItsEGtU9p10pTl5rEZ5oLuBL5TpeaoifDjdogIn0XDuk4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRWzAGpcfqzpDnRmvIwmaE9b9j7rOB25GRiHD5i8kLdErnJRAP
	ivVERb4pVK1HzZERh4Xl3y5T0x5EvhbhE8Wb6fues/1AYQs963wwHV6X
X-Gm-Gg: ASbGncuiUBu+u8jYnbSKcph31IfKbuX+IPBagykiaM4Trvi4QI1BaSLjgYmSqXcoc41
	9LgRkxuf0gqOgQuiw0hEGpNDh0IVIbPgQaeWhEGCocwirqkBqen4TLPOw298B2MerjMSsLANwDi
	ucyJMWP4F8rNJDD0kQoDr46nwpFS4WF2UwqLmNuCjWXIqlDtFEjNYgIIgCY1uFko4zSg5FUXCzt
	iPoxtqnfnT0WdCSKmh9u8Ob8e7hNcdTy9Ts0vV7WLLWXSaQrjtORQBR9iWmQCzmgpy1ebBQ935l
	nH3XZ5J+OMUZDaQfkgYMFvu/vKMJdgKWjA3t9kwZeeAU1uYOD4AU+ID2C2kbR9rue8FrsnmfhRm
	0evs5yBnecE1LGoKB+cPCkd0QopyH4Q7lC86nOqqMnart6pZ3oTzo/J/2Hq7MCmOoX85h17LmnJ
	YkIz9yTSy+GXS4sp2rMFVeXBjOr94DFctWzvONE+Ik
X-Google-Smtp-Source: AGHT+IHX3KE00pQn3aNP1QwDiE6EhD5Q3hRD8inmO43mr2wuZ5/VM7zYPzKmzGmrYwsAVd3vpyhaEw==
X-Received: by 2002:a05:600c:4f89:b0:46e:3edc:2811 with SMTP id 5b1f17b1804b1-4711787750dmr167242385e9.14.1761231544110;
        Thu, 23 Oct 2025 07:59:04 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-475cae9f292sm39822325e9.5.2025.10.23.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:59:03 -0700 (PDT)
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
Subject: [net-next PATCH v2 0/2] net: airoha: initial phylink support
Date: Thu, 23 Oct 2025 16:58:47 +0200
Message-ID: <20251023145850.28459-1-ansuelsmth@gmail.com>
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

Changes v2:
- Move setup phylink to airoha_alloc_gdm_port
- Better handle phylink_destroy on error path
- Fix bug for device_get_phy_mode

Christian Marangi (2):
  net: airoha: use device_set_node helper to setup GDM node
  net: airoha: add phylink support for GDM1

 drivers/net/ethernet/airoha/Kconfig      |  1 +
 drivers/net/ethernet/airoha/airoha_eth.c | 79 +++++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_eth.h |  3 +
 3 files changed, 81 insertions(+), 2 deletions(-)

-- 
2.51.0


