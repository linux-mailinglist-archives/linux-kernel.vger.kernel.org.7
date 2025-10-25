Return-Path: <linux-kernel+bounces-869987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCF7C09493
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 096E94F3BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0491E3043B5;
	Sat, 25 Oct 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsF9pIbf"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7F3043AF
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408747; cv=none; b=Fb53vdq07eKZMvhrAl/4CUJGteHyzKgnyaCLCyry+tJt/YcnMcP14WnfPcI+y4CObj5mIw7Bhg3b/q1Y/iPZuB38sHwyj0kbMD4wsDpVRF3OH6+YTar9KoBkYA4UjufGAwcYelzoynbfF+BHeW+bBscU8q2xygf9zm6JAmcsiTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408747; c=relaxed/simple;
	bh=yu/Dh+IfCLtGqdkzWYmGphnHwzjdW7LS4ezBwM2rJ4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gi6zOy5eOZ1rV54qjyE/Jf86SgDVnP4jj97jlQ0juR4kaDl8h6c0qha27sioqaWK11hVYyM72avS3J8YEKsa46vg5kxP9+SoCWe0eJOPLEJusXkQnMVnWqexz4aa+3yHFimtvz6OXB6BTbTugCR7WPXO+YAI1FBTIgH3N27TlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsF9pIbf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2907948c1d2so32842645ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761408745; x=1762013545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XFTdA7k8wwzMFaWlCyo1JPNHO/S9MJnKXZUm98Yf0w=;
        b=RsF9pIbfUsxTwz4xvwVpDGuieJ8HNVLvzfwcioixeM1hDDJxOM6I9Jj3df2e5y5MXi
         9SdnIO2kjLY20ZRbkMbxb1H2JZfrCYmPjA2oxmdfI27HtzLQ7YUQY/Nz9SEplSG6U/9T
         UdAqzCJZYxmraFl9MlZi/sd8mf7Td5y4CDOuKdOo9I4NOBtjeSbi+VzvGbwdHXE7tcy4
         lrODzMWvVgeTDVj6fVT3jUdsHnCW1qctahX9Da3XRyN+bHBsriSEs/DSLqGXyXY4LkGr
         Ve433qHjC6RCQJygzLKtYI5HPdN4vc512Gk8PH7a96gjEFogkLrEwJ3ZK5FecsxxIhSd
         OMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761408745; x=1762013545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XFTdA7k8wwzMFaWlCyo1JPNHO/S9MJnKXZUm98Yf0w=;
        b=bSj7YYOX/AYBYa5qTnpnGgpX1Dar1Gra8IeNTpTm2RchccxDrYrYyx3DPB+qg8gZGD
         nYrtznkZxnncPE/MvibvydUdawaf9d5QBj7C1fEqQ7UeLkANVenUIdLThvDbw/IKL58q
         W4APjifSiRgPkQQ+Pbc062g1+C5fg1swDRLg4WWQTzdi6KPPJkKFELs+KPkvKb/PfvGB
         Ij/+oTIw6mcKyUeZfZJehKsCkLs96+SnG5k2rYbu3kOkj0TgV9GVdP88UfZ2Yy14XAMH
         5QlL7onoqKyVHkKzvhbAPCF+NgeXR2rGthy2IKM0TcNmVeVUePLuG1cGaEZcNhU6BX5J
         XS3Q==
X-Gm-Message-State: AOJu0YwFAaarDI8bYFR9j5QA07a5544m+lolDIi0jQoyUMwa3Lf4+GYp
	buA4232G75Obpptx2CDLFuYdW0Ubii/2GglOxZ9JPrGYonfTBqqhKWsu
X-Gm-Gg: ASbGncu6zVS2lQn1HSlTeCkivnMYViA7uPT26bXGWQhKuvJ3EqPAePNim4njq6JV1Pc
	0BQuARUaJ2w8HwIPdgv/o6ull5wx/s00P9NkhOtceRvOuX/s65kajohL297FuR7zUkdyhN6xr2C
	R1QSUZ3FdtqaEltbH0t5FbISXXEtUJtlU75dk4KE35dg+JV/sU9DSbhg9BPH7hMLj8b0HqzTXST
	Tqyvf73h7XY/jXMlQnIkK6XcNQV8vF1wkqAsCuRHJ0VdKCpDnIGEgiIl47nyuH834S1Mk2IJWmE
	9fSo/aO0y2cwQn3WIBGSwTVXWe8hbXJCS3hB+vfuOLpGeoYaUywxecY0OV6YXSgVUXmKpMS449N
	FLhy0UWwcGGglGhL0B3lUT+3W9emCGR2N3LvWtE9JQEjBcAkI+gCEKU+w9aD4FuBVI3AyJtW4Qc
	Gr83HBE8FCyUGolk0A
X-Google-Smtp-Source: AGHT+IE8vlEVwjfaCK6fWdzSeAWUbPUodgqwlEaURtg/eP8og+MlqNHWouRBq41EznCRbBnlLq053A==
X-Received: by 2002:a17:903:2445:b0:246:80b1:8c87 with SMTP id d9443c01a7336-2946e220396mr116623225ad.43.1761408745210;
        Sat, 25 Oct 2025 09:12:25 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b50sm27823415ad.75.2025.10.25.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:12:24 -0700 (PDT)
From: kriish.sharma2006@gmail.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] tty: document @dlci parameter in gsm_modem_send_initial_msc
Date: Sat, 25 Oct 2025 16:12:06 +0000
Message-Id: <20251025161206.795784-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kriish Sharma <kriish.sharma2006@gmail.com>

Add missing kernel-doc entry for the @dlci parameter in
gsm_modem_send_initial_msc(), which fixes the following warning
reported by kernel-doc:

Warning: drivers/tty/n_gsm.c:4175 function parameter 'dlci' not described in 'gsm_modem_send_initial_msc'

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 553d8c70352b..214abeb89aaa 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -4165,7 +4165,7 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 /**
  * gsm_modem_send_initial_msc - Send initial modem status message
  *
- * @dlci channel
+ * @dlci: channel
  *
  * Send an initial MSC message after DLCI open to set the initial
  * modem status lines. This is only done for basic mode.
-- 
2.34.1


