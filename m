Return-Path: <linux-kernel+bounces-818343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F7DB5904B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D79B1B26B18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D7C289367;
	Tue, 16 Sep 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybSYsLBp"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037F24338F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010898; cv=none; b=jRsl42diR1saoqFBZE/HOF5CVXTqduQI/VdCkjOMmLL0GJMjrJdTYQ4JK17Snl9qBo9HObd/ycSKRnw8itoHZy68WDv0s2Y8nufZqDuaoBYlIw1r8dUbA9TozwzdOa0q7FH+jfTYxVkCFFyFyFC7Kjcer5xGWaiLsVniuXkiPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010898; c=relaxed/simple;
	bh=igBowHbVySS8/xIED1bBfHp9jhT6D8Dlc5QYdnIxemI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r9eFochjHp8oieMcYbsf1KP1RoGi0QOE1svH4ex3mXaZw/kC6uMOsxXGKHJLEGwBIJ9H/osw100gXmw/ZdAAAYicypmgVXbC7L3Wkde/eTpIollGQL+YxA/ENcuG+XNVzyBeuc1p866DsNoTKCy+N+9wPDtBiSA24/WfA6ypAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybSYsLBp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77619bb3871so6049576b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758010896; x=1758615696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qevWpjrmJDOUG49KKW+Rqwgbi0ZKsNjqTf6b+uw3m1Q=;
        b=ybSYsLBptwerSPqKbJ9QHAqWqLGYgozY2vDLlWNvufohJTDi2lpXChCveDoYt8OkZv
         8pSckC57oEaRF3V0SlmiYgmWaV510gNF+pTKBc+G/hJlpo6gJteg54atWo3A6NrKf3eo
         SHDL5veVIjyWQvx5E/7PIuR+HAtK6pr04RKRt6ruXgztGyRLfzLblxFP795//PVVXX45
         TPt7G8+IgDLQaqcjxd+ReVhYAg2Dv1ZC9jezgthCITx01yvwXn41NhGc6AoUKdFFMgGY
         Jvq/zW2cuCsPmmvU1ZI37o502EC+zsGPASo8YBT2/HCyoEBnEEk2ak4C+2nAPrVrBay0
         J/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010896; x=1758615696;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qevWpjrmJDOUG49KKW+Rqwgbi0ZKsNjqTf6b+uw3m1Q=;
        b=aY/atsFPP/Vv788zTR/qmj0vIRmZ20IiHULb1yynWaXk/ciIKt+Ej98CjMfIBuauV5
         CZ1Z+lrMbG85hi0tVO2D24ZPIPTjirptFMEg4LJ4hRvKTxS9X4OmIXrkFe8GDk03y4nN
         1LPOxR+YDsJVne6XuLyoRjhh9M7FLhf7P6y38P+gW4yzGHwY6vn3mXGSo1zArdDcH6bW
         vGwkQ+6PuwFf5560D4P1QcLcZ9O8hn+b68absDxTc6xy3AMBHtpexIP4UcMuICUAp64D
         umqqrzKNJfV7svXQBLp3cSrXQweuLAO2MaxcD930hQZ8g9PVs5uC3hW7VognAOM/AlCH
         Z2vg==
X-Forwarded-Encrypted: i=1; AJvYcCVZlvFvhOiDMp/oNICM9RMrAMkI/n7jmthEXKAH4XLt71UCB6+JM6ln9higuwpcTEFNErjUk+5cYtCrm9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJgArDx+YN0PqX5LEm9tyZHa0qfEga1IvF0OGkTQJArUedRdY
	uITCLKy1q5zpiIPybGL2c6YahD5GE2gUac1uscPfapjT2rFh5DN5dFZ0a/rIK4w+2dMHpxtVKTP
	JthgqjA==
X-Google-Smtp-Source: AGHT+IFvel9CU31L53CIMc1qeSjIKTGiCmn37+ks78QucyUW/LpgCyEp4S/ag96tAm+tptFANGYbjjZgJXQ=
X-Received: from pfbbn4.prod.google.com ([2002:a05:6a00:3244:b0:775:fbfd:750d])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7343:b0:243:aca2:e500
 with SMTP id adf61e73a8af0-2602c04a56fmr19800408637.29.1758010895998; Tue, 16
 Sep 2025 01:21:35 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:21:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAweyWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3aLUxJRKXXODJMNkU9MUQ5MkMyWg2oKi1LTMCrA50bG1tQB+GXw 7VwAAAA==
X-Change-Id: 20250916-ready-70b1c55d14b6
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758010894; l=1966;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=igBowHbVySS8/xIED1bBfHp9jhT6D8Dlc5QYdnIxemI=; b=D2bIGxYuFI4YVWTH82zzAOTvL2P5Ov2Rp87f9DIUJS0oqek1LtMinJchyaC8D0FrOTJMK3CMS
 ZecamcoTUl8A5azavL6S3CAaSQGIbQx9ZK1XYD+Zrzu/lzOyyUSksag
X-Mailer: b4 0.14.2
Message-ID: <20250916-ready-v1-0-4997bf277548@google.com>
Subject: [PATCH 0/6] usb: gadget: Refactor function drivers to use __free() cleanup
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	David Brownell <dbrownell@users.sourceforge.net>, Nam Cao <namcao@linutronix.de>, 
	Zack Rusin <zack.rusin@broadcom.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Prashanth K <prashanth.k@oss.qualcomm.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, John Keeping <jkeeping@inmusicbrands.com>, 
	Roy Luo <royluo@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>, stable@kernel.org
Content-Type: text/plain; charset="utf-8"

Hello,

This patch series refactors the error-handling paths in the bind()
function for f_ncm, f_acm, f_ecm, and f_rndis drivers. 

The current, unified goto logic in these drivers is vulnerable to a null
pointer dereference. This is caused by the cleanup logic incorrectly
handling the stale usb_request pointer after a bind/unbind cycle. This
series fixes this issue by converting the drivers to use the modern
__free() scope-based cleanup mechanism.

Patches 1-2 are preparatory, adding the endpoint pointer to struct
usb_request and defining helpers for the __free() cleanup. The remaining
four patches use this new plumbing to refactor each driver.

Future work
-----------

1. Refactor usb_ep_free_request(), usb_ep_queue(), and usb_ep_dequeue()
   functions as the ep parameter becomes redudant.
2. Convert the remaining gadget function drivers to use the new __free()
   cleanup mechanism.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
Kuen-Han Tsai (6):
      usb: gadget: Store endpoint pointer in usb_request
      usb: gadget: Introduce free_usb_request helper
      usb: gadget: f_ncm: Refactor bind path to use __free()
      usb: gadget: f_acm: Refactor bind path to use __free()
      usb: gadget: f_ecm: Refactor bind path to use __free()
      usb: gadget: f_rndis: Refactor bind path to use __free()

 drivers/usb/gadget/function/f_acm.c   | 42 ++++++++---------
 drivers/usb/gadget/function/f_ecm.c   | 48 +++++++++-----------
 drivers/usb/gadget/function/f_ncm.c   | 78 ++++++++++++++------------------
 drivers/usb/gadget/function/f_rndis.c | 85 +++++++++++++++--------------------
 drivers/usb/gadget/udc/core.c         |  3 ++
 include/linux/usb/gadget.h            | 25 +++++++++++
 6 files changed, 135 insertions(+), 146 deletions(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250916-ready-70b1c55d14b6

Best regards,
-- 
Kuen-Han Tsai <khtsai@google.com>


