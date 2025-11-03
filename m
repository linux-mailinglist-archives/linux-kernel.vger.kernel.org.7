Return-Path: <linux-kernel+bounces-883326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251CCC2D2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DED425447
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02D3191A6;
	Mon,  3 Nov 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rj09nGBa"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC43164D8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186806; cv=none; b=P+QfmasS9+QOYRFIo0IjWfj5m030LFEzfHPknGsVoH5TSP6JxrtfZWlZblxa4H0bbmgrWwAt0kzfazyODn11mMTUHUkbiSn7hLy11f4AroAVX7/R4QAOWOrBWCylwrN3Kpiqvxb2uSGCliUDEGGnBbjh415IoYJMXSDA8NkHlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186806; c=relaxed/simple;
	bh=h7R/k1MMSVPQfBxt0pvy0030CquRgbNXX1VOTDMoaIQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rsCyf1ev+0QpqqaHhrft3YrtVXJc5GdlhZNk4IseEUp3vdSYBZvDMl2G1QuzD+hJSLb8AibCVrF6ZY8emXIri04WYOEyyDj9KiuVGwsd3d/cPTXXogTFNffsJ2d0yFkkdN+oTqAEtAP2XruJejZv+R31LgKt/1QMwvGnFiZKzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rj09nGBa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47740c1442dso14937455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186802; x=1762791602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W8tTM2uCb0zl0k898LdIZTakN1ZygKd+3CMbo77PL78=;
        b=rj09nGBaFeX9xJxGNhVti1JlVGg35iSsZj581DpbIM5CayFWU0a8FRWSK4VebK7qHu
         Ux+y7H3SBxbIMMw9l7HyhN7Ptva2mSJhoC1VSqLuECr8c9NxHO9OT24T4rssf+DC3l4s
         wG/3HPFQP1bi+Nm1IMlehvS1erGMmZ1i8AlRbxXVxR0SuoaVwJ9avqqZTTYVgNf4z8+c
         X0kE/cWi2A52pNCxV6BG9vfj49Ss8qMjosifq2Sa8P6+wD4YW0jhh7Os4pN8CLUXbfjq
         4Z10drFG4KKLrxMdHOK+CXi44cRaLGDIecz3PkEHdqJnO616SPjAVuVmtTFqYEOqhzOm
         1axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186802; x=1762791602;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8tTM2uCb0zl0k898LdIZTakN1ZygKd+3CMbo77PL78=;
        b=bL8nG0oL7ehFJdn45N8RaLoSX9LeykIZHN6pC4Jcvi/i5ALfm2mfjLKWWuG7oHTaSs
         COiob4DWLEkD7ABEcHZRBwd4FEYWlvdez8zpojEaIVFnSaYJVGkIEoDTW0vmjwXObzLi
         L24VLxWsgJ/NOLN42sE0A3mJ60Yfjs1xRoqusUhAQDsWHLCiRytCX1oHJGiFUIct9kWA
         TZ6TbEHe0ZmIs3rGt+lfTcf2nHCeYcWmYvmgXGkfJNvaCykVlAAPbyreAvPxsRZROucd
         yr1JQTPoucpmHqZJdbdIPHHbOyW9srb4d7phwKlW44Qpsxw/qqWR0zAtCrGBux0qyOm5
         BNYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKj+9ej4066G8aprB6L0whehUaOa87JcO8LS4qCaOb0Qvc1mqnKzSx7RtvGPp21thRaGBmGrL7hu10aTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfenYWfIL/rd8i9fjoBiaSxB2+JtuztwiAquXM1Eizk9jCokxj
	OX3D+dismldzZH6CuQ9I9ZmZFXB4cJcdplwPJ+sAD3uFDyja85cs04qzKaYQUWFzND18fZmJWXN
	JCVwj/OCF0hN0lkGANg==
X-Google-Smtp-Source: AGHT+IEbhSxEl23KciUSXJmUxlryd+9/wkj5PORgK0VgJEd3vZvStNFYMjkCuoAO6A/1vErUZgMsibakSlGcVNc=
X-Received: from wmwn6.prod.google.com ([2002:a05:600d:4346:b0:477:3fdf:4c28])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b30:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-477429d8ee4mr73769555e9.30.1762186802499;
 Mon, 03 Nov 2025 08:20:02 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-1-sidnayyar@google.com>
Subject: [PATCH v3 0/8] scalable symbol flags with __kflagstab
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

This patch series implements a mechanism for scalable exported symbol
flags using a separate section called __kflagstab. The series introduces
__kflagstab support, removes *_gpl sections in favor of a GPL flag,
simplifies symbol resolution during module loading.

This series previously added symbol import protection which aims to
restrict the use of "protected symbol" exported by vmlinux, as a use
case for which __kflagstab is being introduced. Such symbols are only
allowed to be imported by signed modules when symbol protection is
enabled. This functionality requires more thought and discussion [1],
and therefore I will create a separate patch series for it. In the
meantime, this series now only focuses on introduction of __kflagstab
which right is an improvement to the module loader's code health [2].

Thank you Petr Pavlu and Jonathan Corbet for their valuable feedback.

---
Changes from v2:
- removed symbol import protection to spin off into its own series

v2:
https://lore.kernel.org/20251013153918.2206045-1-sidnayyar@google.com/

Changes from v1:
- added a check to ensure __kflagstab is present
- added warnings for the obsolete *_gpl sections
- moved protected symbol check before ref_module() call
- moved protected symbol check failure warning to issue detection point

v1:
https://lore.kernel.org/20250829105418.3053274-1-sidnayyar@google.com/

[1] https://lore.kernel.org/cac5ed5e-3320-4db0-99d8-ea5e97e56bfb@suse.com/
[2] https://lore.kernel.org/2bf54830-ea9c-4962-a7ef-653fbed8f8c0@suse.com/

Siddharth Nayyar (8):
  define kernel symbol flags
  linker: add kflagstab section to vmlinux and modules
  modpost: create entries for kflagstab
  module loader: use kflagstab instead of *_gpl sections
  modpost: put all exported symbols in ksymtab section
  module loader: remove references of *_gpl sections
  linker: remove *_gpl sections from vmlinux and modules
  remove references to *_gpl sections in documentation

 Documentation/kbuild/modules.rst  |  11 ++--
 include/asm-generic/vmlinux.lds.h |  21 ++----
 include/linux/export-internal.h   |  28 +++++---
 include/linux/module.h            |   4 +-
 include/linux/module_symbol.h     |   5 ++
 kernel/module/internal.h          |   4 +-
 kernel/module/main.c              | 102 ++++++++++++++----------------
 scripts/mod/modpost.c             |  16 +++--
 scripts/module.lds.S              |   3 +-
 9 files changed, 99 insertions(+), 95 deletions(-)

-- 
2.51.1.930.gacf6e81ea2-goog


