Return-Path: <linux-kernel+bounces-746326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93462B12592
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA0D5A58F7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB450259CBE;
	Fri, 25 Jul 2025 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDj6sfyO"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC8239E60
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475555; cv=none; b=XQL2xapyNl8oPgqXpn3hPRxEYyFbDJbBti1WYUl++T+n3j5O9Ni0D30NA9ockrngLyLOfan2zMgcKtwL0l6N5JICrbr3PXMlleJygQQmW7fx2MCOvPMphea1NlJTl+rwRCkeGV2iLMwfJSzt6k2cFCF0YhAewnXLEAlhUdjP5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475555; c=relaxed/simple;
	bh=k8uf4/2FliUY9BeBIlhgAmjlkpZvVx476o9PXTRBjZ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=K231tBxqa9srCdWLK+K78vyJA6mxMZWcrWVLVJd5w316eX6QS5WgSa55wdjXdC8Z8fjoYSZ3n0vLWIRFkT6XA5gadqr96THzWWiuV51gS4MCO4xzyK6nfL1dHlIt5S0IwqDefQzDduvqguF073Yw35Ko55cPY6lu7yLTvyrq89o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDj6sfyO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aec46b50f33so419657066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753475552; x=1754080352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/YWWBYyy945FBnwlnZpKd09E9G+7x9+DymnwvKki5Jw=;
        b=IDj6sfyOWQPXmhZiQKEeNzV/04DUttLviWL1JykzlydnjbTKoH/JNl5dbvxL5etA7q
         vk+xmofxdrbY84p6Gm9n42wWqxmDrYWTcUGMPBTY7fI9plFWMI+q9wN4LVAEKUwYqsif
         Cd6YhpsuS0FXmOaMC848845XGuRqwFjbq1VMpmAWNl4oi3SZkf1RnYuoehIiPRfzOiHC
         K7bYeVUvsDuNKRw5VuOPecHtp0jCuK/gQQ3drch+f9YyLp7g229YrSjhStpR5+XyOCvE
         Dm2TK0oAP8Z8+PWBLNvyhPYxGUBAbwlVjxRYAuME5thJ1p+Bnbv9pBH2zbE/X0rwhaTT
         N/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475552; x=1754080352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YWWBYyy945FBnwlnZpKd09E9G+7x9+DymnwvKki5Jw=;
        b=DxcP56M5l/aeDH1d9E70FCEkJW/BZjX39dUWW4diq6LgWSYw0XfgERpQS1RywVlekp
         e/ZxaoZQCjGheLNGxIUSdUZDmQdE8P3BSgnL4ROYOUz+kigL/jlxII6C0UmZmIL7EA3G
         1L9wTkeNzMeOgEWoEotWgYHAPNT0cH1ZIAPAqzY4pOfCzzcdyRrr2XHOi2VIQLyDVIQV
         Wf8cRIHnMzaMQdmfrZTmnGc9aU8O8EKq9k493Up/d5kSXyKe+cBqSRBhA78Ro12AqYbo
         cnmY4AxDPGCoyUzAcBdC7NexJMsaTUFvxkHuLIbmayoOgRIviKiBcPL+5wR6YXJZsd89
         SNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXKzKBWPJYA5jaXdQZTjGxCX4XB8mVKE9ezbFRKMCr39YMNTWsK8PIXsxZaKzhA9Vka10VuPO4aln9WQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwguNmyOMCdbziu870m6ChB9s1zdJmWwex5uI8Wi4JFmvm3O/j+
	/fHwwu+egXGJE9MIviea0mLJlNbUAeyc0AZAXkEvrS/pTJ6LTjalhdBTVZnF/CqZ9pER3N8hDIk
	J/ZZNFWlKgKjOJTyYV7pQ5bqxSGPjgdiHr8T20zw=
X-Gm-Gg: ASbGnctk3Resg3D25PzZ6HS4FlDCmn72nTWnO0NShzW0xCYIIsPpfgZ/IyBfpsDaDhn
	ERzyaRkX/vjyAtWvgRH/AXmYqdvi58KycAFoA8fhmvnVBDi83u4Pb36qghO0f44FcDdOat7zLeF
	kmsGlnXyhDI7Bk3P7qVPhFEtnLhwliXO0YG1gzTaxktVqapXC6I1dHwpAmpoCajAUzVwF8lEeJW
	KUJPg==
X-Google-Smtp-Source: AGHT+IFDrY1Ilguba3HkIWrrqLS4FdVeacXWI2ssXgaEGE9CqhwabZHerKcNB9u0Wv3SRG36XYQtq+zqAjxcSBLfzK4=
X-Received: by 2002:a17:907:7209:b0:ae0:ac28:ec21 with SMTP id
 a640c23a62f3a-af61730b8dfmr335524766b.13.1753475551807; Fri, 25 Jul 2025
 13:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 26 Jul 2025 06:32:20 +1000
X-Gm-Features: Ac12FXwa5Y-y2EoTKy2xDj2te92g2Mku2sA49fGNEuzXKrTt0wxVd91vzS2PPCQ
Message-ID: <CAPM=9tx6TmT-qQO+MDV5GXCbUbTASh2Ly=eLMJb5+rB6MyJWVA@mail.gmail.com>
Subject: [git pull] drm fixes (part two) for 6.16-rc8/final
To: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Okay this time hopefully in plain text from the start, just the follow
up fixes for i915 and xe, all pretty minor.

Thanks,
Dave.

drm-fixes-2025-07-26:
drm fixes (part 2) for 6.16-rc8/final

i915:
- Fix DP 2.7 Gbps DP_LINK_BW value on g4x
- Fix return value on intel_atomic_commit_fence_wait

xe:
- Fix build without debugfs
The following changes since commit 337666c522b9eca36deabf4133f7b2279155b69f=
:

  Merge tag 'drm-misc-fixes-2025-07-23' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2025-07-24 06:49:38 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-26

for you to fetch changes up to 14e8f8e74dc137ff9f1dfb2781784ceb19497ee5:

  Merge tag 'drm-xe-fixes-2025-07-24' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-07-25 11:03:08 +1000)

----------------------------------------------------------------
drm fixes (part 2) for 6.16-rc8/final

i915:
- Fix DP 2.7 Gbps DP_LINK_BW value on g4x
- Fix return value on intel_atomic_commit_fence_wait

xe:
- Fix build without debugfs

----------------------------------------------------------------
Aakash Deep Sarkar (1):
      drm/i915/display: Fix dma_fence_wait_timeout() return value handling

Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2025-07-24' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-07-24' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Lucas De Marchi (1):
      drm/xe: Fix build without debugfs

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x

 drivers/gpu/drm/i915/display/intel_display.c | 3 ++-
 drivers/gpu/drm/i915/display/intel_dp.c      | 6 ++++++
 drivers/gpu/drm/xe/xe_gt.h                   | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

