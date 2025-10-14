Return-Path: <linux-kernel+bounces-853290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68567BDB1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8717F4F57D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DBB2FFF89;
	Tue, 14 Oct 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fclIYF/A"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C792FDC59
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471466; cv=none; b=ECKrYY8gRmUw8LFwHuDohHG2217Le9jWorPpYq9EwxNAiYiU0jaJumgAWTfLGvifY0Ml/C5zSHDkc/RAd6uAdgxEB5d6qOAtqOiFDmUfTauA4H1tkHcc7E4aGo3oq2eFcDLDfestjtcOTy2FogLxFt7goHhHw2Hc03Oqp+XJpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471466; c=relaxed/simple;
	bh=Ijp1VtW3sCTN0HRjaPhc/qjooksItCMfBcCT4A+kleE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uFFcAgD4gmwW3mGizyOk49pCaSnoD3kyuaXbI0TiEqeRg2lx9SkrxzhKZDp228Xhtn5Wudvs4YdBoZ9s5LzehcPj8tLNpa8PJTUhM5jMzMLoXKS72kFHx46bT1u1h3Gd5zMgCi5OnrLFSv3HDm6qIvHLWJs+MNHFIfLmhCXNocc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fclIYF/A; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-336b9f3b5b0so12018374a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760471464; x=1761076264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3cDXlMZxOoVcnGlvE2gm/D9u8jXhQYn3ndXe2iATDdA=;
        b=fclIYF/AyAnsMiBsmwCPXQt86qUTDs3OG5ulFxiSUez3AcWnNdprbxJFXjgP+25QQd
         Q3ViSSI1H1TBW3a3CBZPqunxmEmu4Ut9/G0INUe7zT0HCETGBAB1lnWOmGECKcZ3u6vm
         WgM7OJRAlG5jH98JQcg9ORSIaElgj9DyIZYQaVuOamnWaN0YREHNagS8qnhH9BwkuKBa
         WZe78aYMJwgHfHPwMT/V04IqMibggxyQTK+zn04MPzRKEaVGYj24ff28O6SsDS2Ba75B
         KQboYKcyDZtb0rhnI4t2w4IkKKq1yrKxkyHpA1e92Ov47aNoN7/3178qhQpRE7fwLDOk
         VEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760471464; x=1761076264;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cDXlMZxOoVcnGlvE2gm/D9u8jXhQYn3ndXe2iATDdA=;
        b=CTdeEuMqtvcRd2Pjz/gS8+PRXdlFNQkXxRIrukDR6wOab9mpBhLgw5nloBUQUNWgBS
         SvnBfVy8WX0hk0KGh7bxyw6au4WXl/vxy5Lxm+voDx/297ADW4X0pr8Md8//UBP3uGcR
         3GlDbvQKs8b4dFUOGg+9eblmqghtSwNnN6rTDDbU97TeFfyub/WhKF1MM0RO6XA+TyRy
         z+hVYdE3jvYwvZKCVsNkBcC9YlHUVEKGnHP/6yP/LjaGwMkOKbsTTfbAs6kZEMuTPVwt
         JRdME5iDOAx2T0/hPA+crmGlfHY3q/FozO9zD/P2SnTP7twOafOMgpPWSqWN7ECqWrvG
         BlTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUf+boRzJt85WebEfryCS9vMS3gCCCe9GyXdKkGEQnAgjhaGd7sTVbTVxcDOXrSZynnnllW8OgNuJUaZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2rqvBA2DF3BIsndJ0C/lyyvGHsPrQgnlY+drConuY/nsuRgD
	W1lME5zpyaolkV6yyLqAAZ8M7azruxRXgxXtiTDowy3wUIC+6HtZCRKum7imaP4L+L3ZLhOFyLI
	8xZw1tQ==
X-Google-Smtp-Source: AGHT+IH0UgvKHyNNd/2HCWoyaAmmxv7czoCMX6c2TMl67kneo6Lh6AkQpjRwUiWyALxipeVcCN7PIKpy0+o=
X-Received: from pjbrs12.prod.google.com ([2002:a17:90b:2b8c:b0:334:1935:56cc])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8b:b0:332:8491:ec2
 with SMTP id 98e67ed59e1d1-33b51168defmr38387393a91.16.1760471464087; Tue, 14
 Oct 2025 12:51:04 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:50:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJqp7mgC/2WNQQrCMBBFr1JmbSSTUG1deQ/pIonTdEAbSWpQS
 u5uLLhy+R7891dIFJkSnJoVImVOHOYKateAm8zsSfC1MiipWpSoxDNZFyKJJRrHsxfHwyil662
 ymqCuHpFGfm3Fy1B54rSE+N4OMn7tr6X/WhmFFLbrWqNRoZX92Yfgb7R34Q5DKeUDxUNt+a8AA AA=
X-Change-Id: 20251012-usbcore-tracing-76f00c9b2b3e
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760471462; l=1293;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=Ijp1VtW3sCTN0HRjaPhc/qjooksItCMfBcCT4A+kleE=; b=9OEec9pdhWBuXcmreaTVPLPFnbEd51oj5dgRsEhnF2uNNdinVLuazFcuPELqE+/kN+2KWMc55
 o5QicXnyfPQB8C8a6SFFtHQolc6qt+/6DuhtJvOijkB61E7rSd8fI7H
X-Mailer: b4 0.14.2
Message-ID: <20251015-usbcore-tracing-v2-0-5a14b5b9d4e0@google.com>
Subject: [PATCH v2 0/2] usb: core: Improve device lifecycle debuggability
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="utf-8"

This series enhances USB core debuggability. The first patch refactors
device state updates into a new update_usb_device_state() helper 
function, centralizing logic and preparing for tracing.

The second patch adds tracepoints for USB device allocation and state 
changes, providing better visibility into the device lifecycle.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
Changes in v2:
- hub.c: Changed the inline function to a standard one.
- Makefile: Moved trace.o to the preceding line.
- trace.h: Changed the speed and state into strings.
- Link to v1: https://lore.kernel.org/r/20251013-usbcore-tracing-v1-0-b885a3121b09@google.com

---
Kuen-Han Tsai (2):
      usb: core: Centralize device state update logic
      usb: core: Add tracepoints for device allocation and state changes

 drivers/usb/core/Makefile |  5 +++-
 drivers/usb/core/hub.c    | 30 +++++++++++++----------
 drivers/usb/core/trace.c  |  6 +++++
 drivers/usb/core/trace.h  | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c    |  2 ++
 5 files changed, 91 insertions(+), 13 deletions(-)
---
base-commit: 5472d60c129f75282d94ae5ad072ee6dfb7c7246
change-id: 20251012-usbcore-tracing-76f00c9b2b3e

Best regards,
-- 
Kuen-Han Tsai <khtsai@google.com>


