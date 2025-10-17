Return-Path: <linux-kernel+bounces-858677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E26FDBEB66B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0CB74E8319
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E3E22A7E2;
	Fri, 17 Oct 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0UE/jn4"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687C33F8C6
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760730405; cv=none; b=NoluLygf1XAwD0ZtBkSzj3JbZC7BryXumIvjZBgFEOnVf9waI1KlGP0FVNuS62Vnf6lXpfYf/LIzqhOzC7ITSLtFMttKHmwADNmJj/j9cTgklrSHLuB8iM7dvqOxJsdIpnTGZJY/6btLjHvVkSxfLzFNlcglg81+sIPPi8f9Y6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760730405; c=relaxed/simple;
	bh=0lGFfw/2rf8/pcHffzruy9bUg8j6oeCW7DHy7uEqSdg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ngPh2mIG8Ux6rX2Kdsquq7KUhtxShEXiyLIpymWxmjRIjrBpLoX1Xd5VtBROr93YzbGM0szFH37m/2ajK2dQDi4dpqzbHKr/3bXzJvYY7/UVAFP+fGhtfIn24FGMC9kUFx3pObLfi9lUzZ6TsK0NxEDkgsvEMmGAqb5GwiXt3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ryanneph.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0UE/jn4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ryanneph.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2697410e7f9so58158405ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760730403; x=1761335203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dr1peWODOMoc8e855aSUXPXrT+Ugw1OVqmj9XmlYyVI=;
        b=s0UE/jn4Dl88llbpODdx8joNFkmFmgTIyT8XlPI71DxLf0tTtjCbTxmnugbGBvxpDG
         7Uj/HVZoki7fQCo/SptyvjNWdgFaVrVtDdi7MmdhiPXWYEw86CbSLI20VqfeOmDpNzNk
         6qgH6qAhhj6kH58WzNuqFun3mPHEIJmTPJifVkhluODnb5+8fAd7A8XriPXvOkei1lpU
         yxS134IrRocg+hK5cPnHFzKQLbHbG84/hL6yyv+ex0BG2SvOtym5WzQrbbukb88fUhZO
         Zmx3ExG/FK2A/vJAxrbjCBv5PUMlEEXjejNn0nuzZXrtwoE/mbB2QzN1oJS1z/UdJ4EZ
         7cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760730403; x=1761335203;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dr1peWODOMoc8e855aSUXPXrT+Ugw1OVqmj9XmlYyVI=;
        b=FTXJZf5zyouZvL1NIKsyqBxKkvhNY9vVJBeQZdAcenywGMv14DKe1K5HlHuGmPsrvV
         hPT9c96o0cAKOztvy80mxHpTY041YDbZeLMsmdX6uiQEgJAvlmWsowJJrhmzXmZI/k0I
         KjbhEpiutQkCOCeSVVTYcDOq/CZDtlT38fpc3jGlOB7atneF85zqay0J0WBAqMnH1+II
         IRs0gsR24xvvV9Atnbnbu6uMFGFaKaYHHEPiGz6wEv8afHIaHCXBfEmqqRI8khvnSwn/
         ufokN81D/siT7VuuORKwN5E7EuZhzfLarVFZAVMjxYJE0eHKzZYpu3aGNSngWsJ2AEVl
         oydQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg9W/MHCW4TOgVexphDzu7911S0z34fMPZ7WxttVgy0NIr6AGTag1x3K0fXKDHKw3jViWFlXK0iqkJUDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUfCCmcx4FKPsRarCJHIJ6hZt0dOs8acHriFE5k9qr/BeJvcQ
	+6scJ6nExH/pNncnO5DNspIY9ULEqEp/+uDOcv8pvdlrIENa7s0JpLK1zN8HeAUYOagCT1ar6Bw
	6OT6lBX9s1cLHvA==
X-Google-Smtp-Source: AGHT+IExkJdqxSTmqRHCAPkkBEWF7DmMNdK/cXIXB1TxfYVWkHSdnq0w2r1Nf0jxWEZZoJ+dJW25oyMZL+zAGQ==
X-Received: from plbkc13.prod.google.com ([2002:a17:903:33cd:b0:28e:cc8d:f602])
 (user=ryanneph job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a0e:b0:270:ea84:324a with SMTP id d9443c01a7336-290ca121a70mr48156875ad.38.1760730403026;
 Fri, 17 Oct 2025 12:46:43 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:46:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABCd8mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNj3aI83eS0TN3EJEPTVMPExBSL5DQloOKCotS0zAqwQdGxtbUADsM iOVgAAAA=
X-Change-Id: 20251003-rn-cfi-ab15e1aad8cf
X-Developer-Key: i=ryanneph@google.com; a=openpgp; fpr=10046FDF459A0F9DD68C9C04313B8636EEDD116A
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=ryanneph@google.com;
 h=from:subject:message-id; bh=0lGFfw/2rf8/pcHffzruy9bUg8j6oeCW7DHy7uEqSdg=;
 b=owEBbQKS/ZANAwAKATE7hjbu3RFqAcsmYgBo8p0gDNuv9pMSbS2bie0+GmDQnijYBxb0HESYR
 cLqzNb0rguJAjMEAAEKAB0WIQQQBG/fRZoPndaMnAQxO4Y27t0RagUCaPKdIAAKCRAxO4Y27t0R
 amZUD/45eQI7wnxvyYucDnV7SMk/y5jQYVb4lTHv9uuEvN4hJ2YNDW4IyWM1RgKsbRHuMjZod0s
 XHOklACc9yBaaHWN5uuR3AVpbbtpkiJeqzJpBPJzOqT5efN6Mo0ALnMBwgt2cbRjt9586g+aBi3
 0gM9g15KqJOFhyDYN6vf4mPK986tng67UE3ubiMMpqkJ/S2HDgN9Ughug8Ms5mzzfVHjcGDGd8R
 3aubzlnndsqufRJ/tfWinHS1Jfmu774sgTAORCSHdb03KThfZ6LLR/DLP/OgWe19fyItCUOI7k5
 0TAO5/Q1jG2aCU6QgG5aCxT2WJ1+ncbvTo0S6+acuXAY1ULNQTy77fKbrMBZTO2gr0r2wcgUmvv
 kuPtgLIEJ3niOyqC7PGj+o5Q/GvfvAngTh+T2Dr9fmDueRn1GFculkbCshI74Z9tZYeYW2Z1BXq
 v0lf8mddPYwOUiSHTyripylBPWtPfsmJ+9zTJUsBWne42kJWw6BOhgQoEKcPU0ExDlAFmjlJ9+B
 ZVg0QSCyqsl+OOzQfnzks6GQD/ETjAvo9Lvy3ZhvyS2K+d2pL4SUFbkV2pYbsdyA6OxHKHyjKGI
 TCGjccULNvQHIC9heCgo7LHO5WDYmyEG0wQn7IKfCVm9YLrFdXrTP4p8aVqKhk4bucQCGMp77j1 RG37sdr+m3gaF5Q==
X-Mailer: b4 0.14.2
Message-ID: <20251017-rn-cfi-v1-0-bf66e6ad4fcd@google.com>
Subject: [PATCH 0/2] Fix additional sysfs node access CFI violations
From: Ryan Neph <ryanneph@google.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
	"=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ryan Neph <ryanneph@google.com>
Content-Type: text/plain; charset="utf-8"

There was a patch earlier to fix CFI violations upon sysfs file access,
stemming from Xe's invalid usage of device pointers instead of kobject
pointers in those sysfs file access handlers.

When CFI was disabled, it made no functional difference, because the
`struct device *` decays to a `struct kobject *` (its first member).

However, with CFI enabled this is detected and the kernel is
intentionally crashed.

The earlier patch missed a few instances of this invalid use of `struct
device *` pointers, and a few more have been added to Xe since.

This series cleans up all remaining instances, and fixes an unrelated
compiler warning issued by clang, noticed while testing.

Signed-off-by: Ryan Neph <ryanneph@google.com>
---
Ryan Neph (2):
      drm/xe/sysfs: Fix additional sysfs node access CFI violations
      drm/xe/configfs: fix clang warnings for missing parameter name

 drivers/gpu/drm/xe/xe_configfs.h           | 10 ++++++----
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c        | 24 ++++++++++++------------
 drivers/gpu/drm/xe/xe_survivability_mode.c | 15 ++++++++-------
 drivers/gpu/drm/xe/xe_vram_freq.c          | 20 ++++++++++----------
 4 files changed, 36 insertions(+), 33 deletions(-)
---
base-commit: ee74634683e4b3e526a4b014b0358796e97c7ce3
change-id: 20251003-rn-cfi-ab15e1aad8cf

Best regards,
-- 
Ryan Neph <ryanneph@google.com>


