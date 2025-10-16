Return-Path: <linux-kernel+bounces-857071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E50D6BE5D66
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C6E6356122
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846A2E7193;
	Thu, 16 Oct 2025 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SpHCaxLJ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692E20C00A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659155; cv=none; b=EMi7+KT2fYpA4mtaZZjK76nw0hTVVIb+2eDSVRFII0yWhAIGGQynLIigqgzrOmHlw2qHOW1agK3Nw0S9bUGWkMHVsGIbRpDfl2fQSOH28Y7bCsXsl8Cr9EivE/lap1JukqddoEVO1ZNGlcWj6OinJE/IAvacoEf/xP8MlmI/PRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659155; c=relaxed/simple;
	bh=HBiddadU9m7kjU0oqtk462Jkzkl4y5+s8GpBQ6GxRKI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uvT98DSL7kqVJCuvVZ+C1zdTWf+psAHEiw0FkZuXV2o9NXTfWuZijDlS4uB2N8I6IHeHKeNfD7ipXGGr2iw0g6eg2VxIWdLEGfPPP+Mg/GtFAAvAuY5EE0V85Ca3cgUS5EnX/EGLjy/z1shPP9Ba7YIIeFAcMtqI2HxN/8ej5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SpHCaxLJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so1404504a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760659153; x=1761263953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WawDHA60a6s4raK4N/aQLo6JOofQaLsnvf/pVAIpEpk=;
        b=SpHCaxLJBSgFjbCHaYFI1lIvy9zyL4YBTBpYhjvmdpqBXxX5fMb0r5ET2UphM68pWW
         Cyl1N8Efb5Nb2v0+ZUYUrk0CmpQqcdhOqZKJHrT5ym3Kv1FSJXcVVRWJOQ7nf3vD8EsR
         /ZGAaHmOdF+mUjet9r5hOEPGpa5+7xrZyqiXn2RP5H9Xog129+8M0bmurhcvaAKSRkbF
         fpvtWfjf7I8ycIYVssxxxC2EpA9ksMC7PhSwl5l5gS5uh7+PDmGTcE1GHIYeXFJlvAZe
         /m5V/sVZ97uvBQgOyJchO2uCdZ5+IMZtmUpgsLI2fetziBrD788N8nY5lYUlI93ua1EP
         FSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659153; x=1761263953;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WawDHA60a6s4raK4N/aQLo6JOofQaLsnvf/pVAIpEpk=;
        b=ibC0NMj1XoNcOE/bN3uWHO3zLjwJWWrSkUdEWsey5mmEYEVydUhgqe+De2lnzxr0mq
         jEkjHqobD1vyu/pw2xkFNOeCPKI/kHZiGpj4u2Jq3ZJ3l41H+wJQfJDdTpmwaoDE80Cm
         U3l8Hew+y4pjkwVv0r5I7eEPszas90Hq/mqiTFSM5Yj+hG3WdDGo/c6WA7WF4bpyjwUE
         5gbF9YErPFTbflbkEhxLF0oBpFs5z/GWDHxrGb8jCHl5E6OecOv4qQJz1dC6+4usmgcA
         n7KoksWM/2hz65tvzVfB4DuaDeYmmFnRGFdXdvTCnqHYO4m6tkzHGSaIEzW/9RrfZdrh
         bAcw==
X-Forwarded-Encrypted: i=1; AJvYcCUOa84fdYe/7h8NXYYsj5bp33s/7MEDmWsGwVvksSScp/8A9GkbkW3o14V59fpw4KKWowGk0w0DUxNzp0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTiYC8jMT0xruQMTE/Rjs2KE+2OKyyZzU5ydgAq86cSYQDdmw
	Tt5B772UXsQmFA7dIkAcDeOF+lBZa7YK0dHXQIbe9XQD22NWavAousn/ap0vwWubxTI+9j1V6ri
	R2rXqcA==
X-Google-Smtp-Source: AGHT+IEU+N5aH0xxOsEz+DyPSJOr/pus0xHhiIOJ6c9Ask7TcSZD4nSQ/AeRjmE0UAo2XpRAtOkANqnYu1Y=
X-Received: from plrt13.prod.google.com ([2002:a17:902:b20d:b0:267:fa7d:b637])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:138a:b0:290:567a:bb98
 with SMTP id d9443c01a7336-290cc6da1fdmr19433285ad.57.1760659153500; Thu, 16
 Oct 2025 16:59:13 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:59:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016235909.2092917-1-jthies@google.com>
Subject: [PATCH v2 0/3] UCSI Power Supply Updates
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, kenny@panix.com, 
	linux-pm@vger.kernel.org, Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

This series includes the following minor changes to power supply
handling by the UCSI driver.

1) Adds the "Status" property to power supplies registered by the UCSI
driver.
2) Updates ucsi.c to report a power supply change all power opmode
changes. Currently this only gets reported when opmode is PD.
3) Updates ucsi.c to report a power supply change when the PPM signals
a sink path change.

v2 changes
- Removed patch adding support for reporting DRP power supply types.
  It led to spam in dmesg and needs further debug.
- Removed patch to report 0 max current when a port is not connected.
  This is a bug fix and should be reviewed separately.
- Removed patch to refresh connector status after PR swaps. This is
  not directly related to the power supply and should be sent up
  separately.
- Updated patch notify the power supply class of sink path status
  changes. It now uses a single bit mask for checking both sink path
  status changes and battery charging status changes.

Jameson Thies (3):
  usb: typec: ucsi: psy: Add power supply status
  usb: typec: ucsi: Report power supply changes on power opmode changes
  usb: typec: ucsi: Report power supply change on sink path change

 drivers/usb/typec/ucsi/psy.c  | 26 ++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.c |  5 ++++-
 drivers/usb/typec/ucsi/ucsi.h |  4 ++++
 3 files changed, 34 insertions(+), 1 deletion(-)


base-commit: e40b984b6c4ce3f80814f39f86f87b2a48f2e662
-- 
2.51.0.858.gf9c4a03a3a-goog


