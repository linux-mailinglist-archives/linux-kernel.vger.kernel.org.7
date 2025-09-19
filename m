Return-Path: <linux-kernel+bounces-823954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD7B87CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A353A868C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E113266582;
	Fri, 19 Sep 2025 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9EIKckv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A79B2367D3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252612; cv=none; b=J80PN5X4pNv50/sBjMkNF0jsAfcR+zl3d127tHx75XmuiLrqpdIqWOSNbAbWvVgJurTYjwYdMK9hbFYt4ntLeKFh/DBHJJ8rPig9gcp3mY3d/BL6T3w+gbl2OCcoGg7NLVOQ8R+5VbhLo84gx1wRXc29IOXHYUM6gEn1FmAIh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252612; c=relaxed/simple;
	bh=sNOICaGpO8PzTN7zbuLpyD642t8/tobHiZnf890tHSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfAyuFlFEB7lsvP+eM6YQ3BSapbPAj8lQAqgPKZy5W9XofCdXgygABcV4zP7WPahiRq7ZQCqm5UgymueAbhnrLwKnkxrJX9KXtwJmKJhMtxnDuruvdMKeMxJAh6ev7xdThY8sV7gSMlUVzJdN6DcQoFvSTiTI12Q7D1NN6RH1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9EIKckv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758252609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hARynVBx6wUtc+ogEnVgwz4bGXfrmnzWAy4AkQM2lGY=;
	b=a9EIKckv8gRJPuZMXVhfJV33rwHxmJ3pIrQe64fewlt7VEDsftSIdIrQARJYFiq2m42Hwh
	waV2nYrIEWb3JyoSYV8Hdnv6I5orXJPcO+Z/atBYFVeUC7yQfYDVa0D8fbSzawh9At/XYP
	O5dP3tBITURE/39TqbG/IzpbVgB0AUM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-_o1DR180Nu2_CIbMF5RUVg-1; Thu, 18 Sep 2025 23:30:07 -0400
X-MC-Unique: _o1DR180Nu2_CIbMF5RUVg-1
X-Mimecast-MFC-AGG-ID: _o1DR180Nu2_CIbMF5RUVg_1758252607
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25d21fddb85so30987485ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758252606; x=1758857406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hARynVBx6wUtc+ogEnVgwz4bGXfrmnzWAy4AkQM2lGY=;
        b=KrjuZUWCanIls+jDgQQD4caGk4CS+iIw4v1HAO92dZd4OXQb842HFjdRBN8PYW02i4
         C6t0+5o9gon25XGdscsBp/e5h4C5PkXHWaz2e2/kud2pkm0jMJyB9k2plsGqj92cbNLp
         pcmniPAmGg8UtQ2JTWyBhO4MtnOv2zNRvjBiK8JOaQajDBQQpa/sSYmDiOnDMX1zmmfB
         KFbqx/ruHvFNXFYYJ777CU+MdH9x1wAaLX/JjHMWYTZcWCBa9x+rhMc24je25WXRfZOJ
         LCbVJl+GY93UOMvyJ2ySj/0XKpEYq+V/1jbAwdNN8T5Ia9EmZqd6KzVqca+5JL9reQJJ
         5t9A==
X-Forwarded-Encrypted: i=1; AJvYcCXmUnsOYBuliz3oPthHGexl7f/cYaTTEe/6aootihOn1puqbtU1fPY1STy0SYw+mkaKHbNqq0AjecPX6rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYaqq86iZWEWjX2gmaHoEGnh/ZruDq3h/6IO/gxXZTfFnAHL+
	jEFAW5efMfsPcF2j2DLfUvMK5jg+Q+n7a9OmhE46S1gQLYcnw1NhAT42wAOfM25Q1NwoCW0gmYe
	sOnTFvjxj7CEe0k4Y18nrCEeRHK0mVOobadPZczstUiXR4LP+ifjPvDYFOC4HVoiRdQ==
X-Gm-Gg: ASbGncswO9t7Gd1xNIGZVvoQ1QXSgWHoMD9kGlKrfgIsvjqwVYV/p+MSyg0gnjZSRi4
	Kyg/FTFe5q1OrXUphZzQ1fJ+taODBEKzfvCioV9l+nMk4LRfqeKEgfxoO7FwQDEnwFhUlg4vn3r
	7jcvwtLaqZlLr0zN4zJ4C8JkbAEjTDFyM2aDjd5yoEPk6TXHtASRB81nuaEdJe7apYrppdMDlpF
	1B2tnjW6CtmN8DSAyR6sfIy704FuUbaL4A5yRXgpimxA4lunL8fkJPxVrhmUBr97v6nBNjRn9wh
	GtQWw1n75fDfykJ2Pn8B+GHFiBT+KsjuVG4=
X-Received: by 2002:a17:903:b48:b0:269:8c12:909a with SMTP id d9443c01a7336-269ba51175amr24401415ad.31.1758252606570;
        Thu, 18 Sep 2025 20:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsOZ+qyws+SGDCdwtAw9gyecdBjV3fndhavA2LPihQIkNaarPBI9MMby+SKHSIxbr1bqlpGQ==
X-Received: by 2002:a17:903:b48:b0:269:8c12:909a with SMTP id d9443c01a7336-269ba51175amr24401005ad.31.1758252606138;
        Thu, 18 Sep 2025 20:30:06 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330606509e9sm4054289a91.9.2025.09.18.20.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 20:30:05 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jfalempe@redhat.com,
	ian.forbes@broadcom.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH drm-misc-next v3 0/1] add drm_panic_support for vmwgfx-stdu
Date: Fri, 19 Sep 2025 12:29:29 +0900
Message-ID: <20250919032936.2267240-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add drm_panic support for stdu in vmwgfx. This patch was tested in a VM
with VMSVGA on Virtual Box.

Based on the feedback for v2 patch, I've made the following updates in
my v3 patch.
- Use MEMREMAP_WB | MEMREMAP_DEC flags for memremap
- Use vmw_priv->initial_height and initial_width for sb and VRAM
- Move all panic related functions to the vmwgfx_kms.c file
- Ensure if the current display unit is 0 in get_scanout_buffer()

I did not apply all of Ian's feedback in this v3 patch for the reasons
outlined below.

> 1. You can call `vmw_kms_write_svga` directly in `panic_flush`. There
> is no need to mark the buffer as dirty or send any commands.

In my test environment (VirtualBox), the panic screen appears unstably 
without dirty command's submission. Without it, the screen sometimes
appears immediately as expected, and at other times, there's a delay
of 15 to 20 seconds. I've also observed that it sometimes only appears
after switching between the VirtualBox console window and other windows.

With command submission, we can stably get a panic screen. Even if it
fails, we may get the panic screen ultimately. Therefore, I think we
should retain vmw_kms_panic_do_bo_dirty() to submit commands.

> 2. The format should be hardcoded to RGB565 to minimize the risk of
> overrunning VRAM. Adjust the pitch accordingly to 2x width.

While it's possible to output the panic screen with RGB565 by adjusting
pitch and width, and BPP on the (virtual) hardware side, this approach
causes debugfs to fail. It appears that the BPP must be reset after the
panic screen is displayed, and there is no way to wait for the screen
to be fully displayed within the drm_panic handler code.

In my test environment, as VRAM has enough space even when using
XRGB8888 (32 bits), I think the risk of overruning VRAM is low. So I've
kept the default format and CPP size.

v1:
https://lore.kernel.org/all/20250901083701.32365-1-ryasuoka@redhat.com/

v2:
https://lore.kernel.org/all/20250908141152.221291-2-ryasuoka@redhat.com/
- Map a scanout_buffer to VRAM in .get_scanout_buffer
- And then write to VRAM directly using fifo in legacy mode to avoid
allocations or command submissions.


Ryosuke Yasuoka (1):
  drm/vmwgfx: add drm_panic support for stdu mode

 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  |   4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 165 +++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |   2 +
 3 files changed, 171 insertions(+)


base-commit: d41c79838c47bc822534cd53628fe5e0f8ad2424
-- 
2.51.0


