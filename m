Return-Path: <linux-kernel+bounces-882217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4809C29E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5873AF665
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4C52868BD;
	Mon,  3 Nov 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiQS4k4j"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB512D1F1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762138818; cv=none; b=lfr7Xitni3+NXBX2/fh6ME7+5gLtFNqkMlYRsj2s/CRo7KK1OxLBTvZ3MS9dTPLBXL2I80XXuMEbDBpIcEGqR83uNMbuZjGKJ9HrOsTe9fyW2H+eSCGuoITNXFZ6rxqHimBHRZZ7jYvQbNrgZ2Sr45rcloknPK6DRmZ8tSEqL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762138818; c=relaxed/simple;
	bh=2bSH6wJGMCkCLcVdvYI602cwgiyzgPLruCtTX7O+gBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxlvUYuNHbpZbX7L/aotwA75l38vzmDOFSf8BDlZJI7z8LpjxhpsJccgKffq3OexO5GXnuNlCdwMWtfK2a7VHg7A6/wq4/1weGXRLQc8MfiIL4SgcgUGFQVPkzU8JM1DiBVkua8IuZp1/IMYiZM3GFQ7oGCIQUJvOanHW+5U+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiQS4k4j; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-880439c5704so16017256d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762138816; x=1762743616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5ZbiMx3qqtfcVjWwdialQet83TR7IyJeUH1x2oAlJ8=;
        b=OiQS4k4jB0qCF9E9ZcdDisTxfVF6d+HrONMYzH8ti8fAyJ2qUjcaKXRwh+mecqn0EI
         VQGs2mFDaXRvUrf/DgO5caP674fRrOPR4jFwSnOvhjp1pojs2+Xc+mBFiMt7ydByxDan
         rI9UGk5n7dDZCFlbJl6G8h3YEf2Wi6lfWgjGUkFyHdzkS9ZJtIoPtRhAcFsBKICo+AGj
         Af7vS0ZMilw6Vw85KimWAf0R1gevdB1Li6l5A7n9NCMd9WgsbOlniTGZGgr2fq7qqn/3
         pHKv9kKCZ7mm7wK1P4N94B9vwCO/Kr2gKFVpDDgH97ifelLeQ5wbKYvW90hzzGkqyUw9
         Y+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762138816; x=1762743616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5ZbiMx3qqtfcVjWwdialQet83TR7IyJeUH1x2oAlJ8=;
        b=bIsGEMd8OYO9RppFRcOH8Ta3xjIf1IJD03HlwNC+q/yFsw+uWLWzwIKFRjVhQDZZQ3
         qskUQw+S3ON5QbKa2i/wNBu+s6JGPS6YCSSiVMFoF5nwBFevRz6VYWyp1+8FhL/Ki2GB
         YO/YxX0uZSw735hAJ89xFQ8ZFydQwjLu9DACadkPgZwuOGKg5h4yamXCTz5cLqjuoXPb
         WTFrt6HkGzeXWy97J8ys0ZQhd1q7S/iCF1MNhjkmwG9rlMwsuA62aI4KJHSNgun5LSrK
         VS7YTWmmhjIPoIlIi1rdYAj9mKtJp3uypxSzHTGf71ZQVdcN/L0GnDkk9wZftJrpV5wS
         Kypg==
X-Gm-Message-State: AOJu0Yzx6QzcVtj0BWaLzjBJHrPkUA3wvgKaWe7j79BMzvYEuHZplOfQ
	Em4YDUoNPPRA3KHsLakaqt5Shw2eAhUQB57l3iGsNN92fXHzJoPkG/Ri
X-Gm-Gg: ASbGncv2OfNrH3Xww3i8LJU7To6RjD5TmR12nBsQSVZ5+PnS3ObC4VrJnNBP19bNIGM
	19liNyQi79sn7I2NuMXdxFpgGDB4y+m9loIK81TJlFK1arthVOOlrbkLfw20GNK7mD3XzTAhwwM
	p8I0R3N8t8hL5YMbseAGhiHOpcrFpEbNxgr5K5Lz1sE2kU4i/B4RPMiANeRBk4a92azl5Xi1RL8
	TcxMVRLLmzTTEWEGvS6Vlkqlpxu1Q3MZpI6wqtgD5g3cJIZF+9jCGje7tF1Ih46wUImhmjDY8pw
	7+Y4h9mimD+AUjLaR6ISEB9YFpuwx6kphXaH2HQJ7XyFNrNea1g10fwL0PDNW6Yekk55lh5KYwA
	HTlvgXq7HfnuwqTOrqEuz3jNRowLqbq8vRJcPuxpbCI6mtOo8x1tKazbFGyQJzmgcuQt5FCYnu+
	GtFZxysB9X5D8=
X-Google-Smtp-Source: AGHT+IE9q6q36jFoYush26+7zuM0CA2YJRuXZnQbAUDeAEDIKmfEKoJBQdpgFxpRDvqs6HCo/ISz3w==
X-Received: by 2002:ad4:5d45:0:b0:880:4eac:8689 with SMTP id 6a1803df08f44-8804eac9381mr63546746d6.57.1762138815676;
        Sun, 02 Nov 2025 19:00:15 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88051e1a353sm21830446d6.1.2025.11.02.19.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 19:00:15 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 4730E41C0600; Mon, 03 Nov 2025 10:00:01 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Accelerators <linux-accelerators@lists.ozlabs.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: uacce: Add explicit title
Date: Mon,  3 Nov 2025 09:59:50 +0700
Message-ID: <20251103025950.23159-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; i=bagasdotme@gmail.com; h=from:subject; bh=2bSH6wJGMCkCLcVdvYI602cwgiyzgPLruCtTX7O+gBQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcUs7iu01euO0/rStaM0/LYUqHj7ZBOpfjyX9vk4Qk7 hVZN5R3lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCL3HzL8YuIov8ddLWEwYdvv Do16oW+nbXVXOMzu7Pj+8daJl5KNcQy/Wc8dPGA9gcN/0c/HJgfMz4vZM097krj/w4GPGTvrWd0 nswEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Uacce docs' sections are listed in misc-devices toctree instead due to
lack of explicit docs title. Add it to clean up the toctree.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/misc-devices/uacce.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
index 1db412e9b1a380..2ca539b7d6c799 100644
--- a/Documentation/misc-devices/uacce.rst
+++ b/Documentation/misc-devices/uacce.rst
@@ -1,7 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-Introduction of Uacce
----------------------
+Uacce (Unified/User-space-acess-intended Accelerator Framework)
+===============================================================
+
+Introduction
+------------
 
 Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
 provide Shared Virtual Addressing (SVA) between accelerators and processes.

base-commit: e5e7ca66a7fc6b8073c30a048e1157b88d427980
-- 
An old man doll... just what I always wanted! - Clara


