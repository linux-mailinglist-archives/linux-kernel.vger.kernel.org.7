Return-Path: <linux-kernel+bounces-874902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF34C17659
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 364F74E838A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED123054C4;
	Tue, 28 Oct 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRY+4Rf4"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65682DECC2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695444; cv=none; b=WF6n7Hbi2TNqo+6jsh8ZUMpuxpSBCtAl5YpV1xmvgOkMs4iMmDqEAMKjUPRDAtw+TTaOLYDg618ctaHMAdHi8q+wgdIsMJVoepDYaeS83J+u6iEq+5RzPMYoOGinWI5XTcy2fsZIsNMj41SNDq3N0gpHTifOXtJDbrv185+y/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695444; c=relaxed/simple;
	bh=vWlIS3Y/oVX7SW5js/ioA1mtAuSAo2zoDhgZ1h9PcRE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=i2rDZtvYw0EC09Dl7LRvpaHkKtfnmKg+IatFcCxiLS/clxXL/p7UAWY29Wgbtj2LT81slhPHxtkLQdf7ck3q1IR+so0ojettSWfyOla47KBsJsrkAc9AUcnE5ZC9KOmeRibGyoeAtwdAAyTRJ6ewgew8YasVN2lC7z9cvhDRxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRY+4Rf4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-591ea9ccfc2so608152e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761695441; x=1762300241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BcCjrRgOWUo5URvOluVp+lygBcH0R5GiU5s65O64e98=;
        b=dRY+4Rf4UEUxc7iRNg70WCEfkd12JgKkIlZu6ZNMNvCsLkRyeOZdpvBeyeZyt1rmnH
         3pUy/5I9J4qXPq3dvDF5jUK1E5eMdcLwSUhgYqtwlXqCn1g4n1DxPPV/Ce4xK+V8pbbg
         xyxsTihHykN5lC1yD7Xmrpo03rbLdjP8ep4F01daNAh1TlHIK2xI9QVvusttahGgDDIW
         rhqs7t878lu+3xXsvjDaGzKO3Ah2UgJHTtIi/aIoKmlf/PyW8hrj4sQUQRXtijFE0EKP
         pjwUD7UTFUSg1IuxNdnNg6lGryPvhKjXxFLG1Oq8kIhgK1NSN3fyPKwvk4lz69xvHtRq
         d9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695441; x=1762300241;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcCjrRgOWUo5URvOluVp+lygBcH0R5GiU5s65O64e98=;
        b=fbcylF0moUgWVIPF8ypht84VZvtAkkfdkRRnuvSRAKphxeVj5vclaCam/08R0Ai1IC
         kJRuyYe28i4lwYxik6EX5BQ6jMaMv0zND7Yc2NzcfcoNJ8NX/R1ibVFfHmy24T0tIlWL
         7Kt2j2ZCzgBgVDKfOw3styjryNfC1CxG26q1YA7uVfBIII2xltqw5xRHh/6SiC+q8PYG
         P/htoyKveMaYIsgwKKgyQ9k4aMNoYK8v+5kfO5yPvop2Df00vL48moPtF+Kt2ZLzGjEo
         S2BczCE0pwaHhKVUgYRY5xk7czuRPdf8PnS4e+uto1FheMU4LbPeugEHMXSaw+0kPaNR
         PrZw==
X-Forwarded-Encrypted: i=1; AJvYcCVrMzlCB/reKZvafGccGYa2RspmMaqnV/8jLYjIss3dcOo7Zu0lOP3UEw7SO3S7mdn7B0AfvZtmME3BpVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaIyaAt+ZB8s7x18fMwzInPONJkU8XjrtOhEVxMEqt5KkAzcGy
	DnaBicMmOixJIffvby1BCD0xh8pwGOkOqv5bmSxVdDQzPc90NmvuDCa2mtlBQahC7vX2x+ncMQ9
	SXjI5KghlmhWLyj4EqeumdpxgP2RGiG0=
X-Gm-Gg: ASbGncvoFfNhmI8ilv0REewo8oQ6YFpVVs82z9kW3AlTE0NgaSNage5GAbgf98EnCnL
	5aM47EZRtIwL4s0LXIbdtiShibq14flvYyH30SqjpPVO/8g4JEP43M9VXFNRF3fSf4YDjLaH4Wy
	f9dihAxFLgPRtpJUnZvnJpVErFGTs77ZGkfDJxJpFFzYLclAakGXwrsOT4hBGL2rZ2i66uM5DrT
	1fa3MobE09hXtwvwo6zINH6A0RCzf6QomKHB5TtrkJgn9TS/s+dlk1Vg9CQgC1TUU7jNCu/5dSI
	dd7N0gLFR+hOU6NqpF8MqpM1z/lDBvMe438Jf4spMGUMTE8XIvmgJUybmR2qoxW0WIIw7iUvXFJ
	ZEw51Rf9lOrnQrblurrof8avCXMsCfur824xynw1spw==
X-Google-Smtp-Source: AGHT+IEDzoOaSGsGdbeO3X6wLVyV4eHafi+2jrHwh/fj2DuhlHGmtB/8y2IAX/KeBgZufayT6+WEuejDRJEX5cA1JkQ=
X-Received: by 2002:a05:6512:4012:b0:585:1a9b:8b9a with SMTP id
 2adb3069b0e04-5930edc3631mr1517466e87.9.1761695440522; Tue, 28 Oct 2025
 16:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 28 Oct 2025 18:50:25 -0500
X-Gm-Features: AWmQ_bldv1tX4lgQDkpyYvPXZCLltojj1sUsdHeJ-3n6birSyiXJ4DFqxsfAYEw
Message-ID: <CAH2r5mu7ZOL06JftZt4forRyQy77+OYZQ0gWYn5Cs9Rvk62vjQ@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/v6.18-rc3-smb-server-fixes

for you to fetch changes up to f574069c5c55ebe642f899a01c8f127d845fd562:

  smb: server: let smb_direct_cm_handler() call ib_drain_qp() after
smb_direct_disconnect_rdma_work() (2025-10-26 20:47:32 -0500)

----------------------------------------------------------------
Three ksmbd server fixes
- Improve check for malformed payload
- Fix free transport smbdirect potential race
- Fix potential race in credit allocation during smbdirect negotiation
----------------------------------------------------------------
Qianchang Zhao (1):
      ksmbd: transport_ipc: validate payload size before reading handle

Stefan Metzmacher (2):
      smb: server: call smb_direct_post_recv_credits() when the
negotiation is done
      smb: server: let smb_direct_cm_handler() call ib_drain_qp()
after smb_direct_disconnect_rdma_work()

 fs/smb/server/transport_ipc.c  |  8 ++++++-
 fs/smb/server/transport_rdma.c | 47 ++++++++++++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 12 deletions(-)

-- 
Thanks,

Steve

