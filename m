Return-Path: <linux-kernel+bounces-746606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7DB128EE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6191C80B39
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C7D1F3BA9;
	Sat, 26 Jul 2025 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL7ZfCDW"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651A43159
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504397; cv=none; b=a0jFA1NynnTDyZxIAv43M4aRlO7h/R9T/aERvq7YpB82cHCsvZfwygLzc6l2UfJ1RY/WqI/mEvV+V3G1Y8lq69/sh7xk46YPJ/brDYp9YJ4PZ7IinnXk6sXlkQjrYcn1OUxgp37VJs0KBbo5Kk7jh/bKjpo/grxIPNKSAVOK4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504397; c=relaxed/simple;
	bh=yqLflEss5+rW5p1lBzUzxijl/tQZexw316Q+5lZBc9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=go+QrHH5l8X1l2ImAYZGTgUk/2Rth2Q7dEPuJYnwciJlY6ulad4WlymE0kc3sJScej0/AP0EJFq/LNp3ld4s3gDTLu8w6R11Z4Oco7pax2Q/ySoMwGferyNPLdj8k3BwSQ1jtAmrP6v7N450qwVg/LfjoW5PcrrTA9K5jISvgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eL7ZfCDW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e623a12701so431014785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504394; x=1754109194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BW1xnx+eic9ymH8SDNqekLeIBVOT7EdCfOdZuvvoJF4=;
        b=eL7ZfCDWWZi9KM4QF3zJgSGyzqe/oSn8QKt1tdZYzy3I3hsMpMLuhFTn8//lIk0kFE
         A1AY7YKmrHbvrfhAWr8Hh7qkkr8trCbsO78l3MEjydVpH23Pk1hpLRQQCNoemxpglLA/
         crK1Uc1F/hLamvlRrzunbqAb1FG9AEFBCGjkhPbK5CnEqInDPMJW2AHkOsrcEKHxdxXi
         MBbgc4ndQn9jxh4/4rO6w01VBWrSRUJzjVZERIArzAk06hsVZUU5hC02enx+8vb3wv/K
         kmJHA+QOBGFA4et2ZGpaN9xcKw47iT8zeb/7VZmf4azlXYvuwNFXRSp46chDO/evfIBu
         NI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504394; x=1754109194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BW1xnx+eic9ymH8SDNqekLeIBVOT7EdCfOdZuvvoJF4=;
        b=sLcHyvp/FwqibSkyMG/5HUmxPONuAWfYmTnxV15OaFIkFmoOyCMNGI7TIMyqnI1Map
         0kX15id6hTlXUVlb8N+eSAHT1KFzVxHlcHtE9hQh+eqYvaqAB8v3aZ0qeEOUYHZFcGd2
         CjDMFNZzbvgYxibGELhNLFwOV/sUJSGU49fW7iIzRKtD48C/AFG9Zq7qR9qYPkWyCPaI
         1U6pNbLb8PJodRaoPorhvlRwBOFiPkpOIAv2Tm30oRp/DMHgid16+tYXu7gXbLOSqGMq
         oBvBGEadmqqVXqOb6gFNBfreZujhr3yIP2ZQUUHdxAgi2k4S8P1wg6+T91gUr1V+wS/L
         dReg==
X-Forwarded-Encrypted: i=1; AJvYcCVMrycCtxjju1rU+9TSO+ka6XN8S8BP7JKXaUkxgYF1vYTCWra6njrKIfVE5yUwjT4cjPFYgxwuQEjF6cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyFzFz5uqQn1mq8RTk1LIl7Xz7KpwG7rxVXQw7kfMMm4yGN89B
	3/eZFuUiuZBrjQVkYg4qBC3Nfnz+nS6Rf9xdOmyA2/v37PN1rlGpBDYq
X-Gm-Gg: ASbGncuh3lnMjwhDez88xwaIjTvILE3JxOEDki8Ux1AbPtw2ATKFZMW6IXWAEGaZlIF
	vDAeXpwYdmQ/KumFZig77GoVL0CkvRIEKSJn9OYL/ymuNbGecx3Y++qKFLs4hls7Pn0NFgE9GBn
	V+l932POVBphUTs/Xhhrd7tUFpWZpfJylYWkhcnX0Yoz3ad3vE18g9fADQdgwSatdFDMkBuQhGv
	RGiUESLNdzcj+UE7Zk2HIUxTYihELh0dGd0oR503Fjlq4XBB8DwjESwyiCjlyAmbWBEDyuV300l
	M0NMUiwKTWbGBwDBvezq3hKwlagoHa5XBpdUAIfJZa9D9g6exAG5tVAyeO9AsoDDsmbj3ns+0BA
	XWDyNtU/wE7pL4EWW+D/KM/coKawLo2quTolHo0ZKXaRQ0VvXiYA=
X-Google-Smtp-Source: AGHT+IHd3rG8570Bas2ZttHZNDcdf3KiYipJI+hbnOt3fNKzufWFCnJEWz0pfoRYwZE5qJwTFLQcuQ==
X-Received: by 2002:a05:620a:260f:b0:7d4:2c9:e0c4 with SMTP id af79cd13be357-7e63bfb3348mr447476785a.28.1753504393652;
        Fri, 25 Jul 2025 21:33:13 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:13 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 00/20] rtl8723bs: cleanup and style improvements for better readability 
Date: Sat, 26 Jul 2025 04:31:58 +0000
Message-Id: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series includes 20 commits that clean up and improve
the style and formatting of the rtl8723bs driver in the staging tree.
The changes address spacing issues, indentation, comment formatting,
blank lines, and minor code clarity improvements.

No functional changes are introduced. All commits adhere to the Linux kernel
coding style guidelines to enhance code readability and maintainability.

The patches have been tested and are ready for review.

Vivek BalachandharTN (20):
  staging: rtl8723bs: fix spacing around operators
  staging: rtl8723bs: remove unnecessary blank lines around braces
  staging: rtl8723bs: add blank line after function declaration
  staging: rtl8723bs: remove unnecessary space after type cast
  staging: rtl8723bs: remove space before tabs
  staging: rtl8723bs: fix overlong lines and clarify lengthy comments
  staging: rtl8723bs: align asterisk in block comment to fix formatting
  staging: rtl8723bs: fix logical continuation style by moving to
    previous line
  staging: rtl8723bs: fix indentation to align with open parenthesis
  staging: rtl8723bs: adding asterisks in multi-line block comments
  staging: rtl8723bs: remove space before semicolon
  staging: rtl8723bs: fix excessive indentation in nested if statement
  staging: rtl8723bs: fix unbalanced braces around conditional blocks
  staging: rtl8723bs: remove unnecessary parentheses around assignment
  staging: rtl8723bs: remove unnecessary braces for single statement
    blocks
  staging: rtl8723bs: add braces to all arms of conditional statement
  staging: rtl8723bs: add blank line after variable declarations
  staging: rtl8723bs: fix line ending with '('
  staging: rtl8723bs: place constant on right side of comparison
  staging: rtl8723bs: merge nested if conditions for clarity and tab
    problems

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 506 ++++++++++++----------
 1 file changed, 285 insertions(+), 221 deletions(-)

-- 
2.39.5


