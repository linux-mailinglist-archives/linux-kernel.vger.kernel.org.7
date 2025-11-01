Return-Path: <linux-kernel+bounces-881155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93744C27933
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52DA3B12F3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144F246BC5;
	Sat,  1 Nov 2025 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOmorMhR"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376D147C9B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761983587; cv=none; b=dnabRsnQHmAmnGDGF1OxtMwadrZd4onzBfsK7H+GEKRfP4ZVDolonBMsW+lTWCqOM3BSFM9t992I1NCIxKSGwu1rtZVP2xQMTxwGHKD7vQbgtcYv0UORre0v0a/xBmKeCrg+Foi/PZHOgHrFO+VjMwsdTpjzgJ7YLcnJj+ybhgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761983587; c=relaxed/simple;
	bh=FO8B+XSbG8/tNz7UwdzRHKt4zk5YCDQOjGbVamOS/1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVUj4lb1Y9k9osfxaX14bekwNVOUBkv+6mcnXCXFqu7v4tMmYfMzvprk62v4DEa7xL7wd84OqKb/pKPz9s0AfuP1kwNF0A7KQLMuwDaIlD+597f6RLz3+ZmzN2UT4pp2qk7d28uMopW7fPuaIdsBIssWCXrwO/oNwd3OgdngJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOmorMhR; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3737d09d123so39093201fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 00:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761983584; x=1762588384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YV8ILjCLbAd6Rh+u+y5fp6wN9Ns1g2oLwKcbOPZD8ow=;
        b=TOmorMhRgidaFv8kc3HEDgDjS8XfT8VNGbfvTF1V1lpTaj8YoIH8SDrmstcuAemigt
         ljEdsqChLtAbGir2lLY3HMNprCwgzDGDFtf8ydQvovDUYaPn1BV2xS6iVgDS1XoYNOPp
         XYLfvVaDnTsjmueGirNkHUwe2hDdAV/eqiaBQ2xObUYGZ64ecfiWgBOm16WEg7tEh5Np
         YztXhWtoYDnipNYIXyXBwa2jK8fLMNyo/6yr8Mg1JCiq6V4RWqncgwz3MQpOT2UKizAJ
         l4yGVau7FlZ0Ri4w857XBlF0Kty9HdVzmeOgfUSRAIS/oC40jD31rJVur7n3RbkpufHH
         SbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761983584; x=1762588384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YV8ILjCLbAd6Rh+u+y5fp6wN9Ns1g2oLwKcbOPZD8ow=;
        b=Zb3vV6OFuPkk8Hqtyg5ZDvEAW1dhQ3Eld0dLtGXvsvaFxEIlDwB/XDeEqhSaFwSG/p
         ErSZx4FC5IVg2WhCBh0Y7fNjq6q3aVGUl0n4CoovEgK/unKlR6+s92h+zOUGvp+GAknN
         oAu8vdXP6wRs6R3/XO7E7x9XmDvodPaHWWVX3VDqULUZYrWbWu4KxhgA2w0iy0KpWWz2
         xRhp1W40CTsko2L3vJa2IBTanPON9pGlyBnnqNFbtYkFYOnCx4YW5ClAe3lHghqSVJw0
         GnglpZ6Z6cAoBTGwCYtgjah5tk9e+5vXV/wTnMSxWX5iCexBidUYcbsNDk2rEePPN0yq
         JLgg==
X-Gm-Message-State: AOJu0Yx2FYCPOm2QbkHCcmBPjbpUJW9h6sTyiC9Hfg1JUn9ARBtYe7tR
	ZAu2gI2nv8dusATLNOQCvit5WRUwH27DeS86NqLgZtzk0SbWyMcXfjRjDm+Yc/ag
X-Gm-Gg: ASbGncsU40dKE9NpZJ+ECNTremof0oPqbAbwdodovw6DGg4sxKZNMghhL/qSMWv5WEz
	vIzyolwtmZbG8giiQKzhG1JEUjrccjco4rQHjTaxcQqRHT/m9yeWMWvW9Y1BJaNlPpH1lVysnG5
	zNt1LdkseWonj61Y1o7Jxv4+uF5t4aaamAMMY0Je7FF0bzK2xE821nPZifd7TicDPsBkq8iC5Qx
	73fYYU8FlBF+LZgQir5qPscY+gZOl73eQPVKulyFVYgoqTFY6RH55Pc378m51lO0IX6W7qNdpLz
	IEp2E9P+yuxtoQAlnWF6L722ANpNL3xlW5O53HVgGznEXKPmHxNW5SG2C5e+gCHz7xYRQJwUOxH
	ub6azSwNXz75Wlce1GTG4P/KnfyRvPYHPlhNdP6OLqRdj1UoMlALUX+QNQxWtb8C96jjxY6SEkS
	0Ct2K+ZLQRbCCcAQ==
X-Google-Smtp-Source: AGHT+IE0HcnJGsxbaeCG4AVppHi/hzI1/ydTTSIq4i3fwtlEauPkj+HA5GKPmybObzIqOF+AZJU4Gw==
X-Received: by 2002:a2e:bc19:0:b0:378:e08b:5590 with SMTP id 38308e7fff4ca-37a18d86953mr19329691fa.3.1761983583414;
        Sat, 01 Nov 2025 00:53:03 -0700 (PDT)
Received: from archlinux ([109.234.28.204])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a1c0e9bb2sm9142051fa.51.2025.11.01.00.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 00:53:02 -0700 (PDT)
From: zntsproj <vacacax16@gmail.com>
X-Google-Original-From: zntsproj <vseokaktusah7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: greybus-dev@lists.linaro.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: [PATCH v3] Fix tiny typo in firmware-management docs
Date: Sat,  1 Nov 2025 10:52:47 +0300
Message-ID: <20251101075247.11415-1-vseokaktusah7@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: zntsproj <vseokaktusah7@gmail.com>
---
 .../staging/greybus/Documentation/firmware/firmware-management  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/Documentation/firmware/firmware-management b/drivers/staging/greybus/Documentation/firmware/firmware-management
index 7918257e5..393455557 100644
--- a/drivers/staging/greybus/Documentation/firmware/firmware-management
+++ b/drivers/staging/greybus/Documentation/firmware/firmware-management
@@ -193,7 +193,7 @@ Identifying the Character Device
 
 There can be multiple devices present in /dev/ directory with name
 gb-authenticate-N and user first needs to identify the character device used for
-authentication a of particular interface.
+authentication of a particular interface.
 
 The Authentication core creates a device of class 'gb_authenticate', which shall
 be used by the user to identify the right character device for it. The class
-- 
2.51.2


