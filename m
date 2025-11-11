Return-Path: <linux-kernel+bounces-896214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 497DEC4FDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC67F4E5D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4985B32694C;
	Tue, 11 Nov 2025 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTP36pAB"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F2D254AE1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896855; cv=none; b=ACdK0/aLznUBL+9scv3UAczQMTdXXg2jrjE6EVrbCsVg7CvhaCvcAPAR/eAT0aNEpt3vy5AhtCGBvoxcEbGtdPolDoDteRH9R1J3DbLWcVcEwrOaYU5FEvTCvUYw/ZcLXH68mtW1MQYqSSWib7m11t5t5G0u4seCOi/yv2g3T0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896855; c=relaxed/simple;
	bh=EpsHWbCPS9QBJDYgd2PMk6G793IhLD6U7GlG4xPdmcs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=exXwILuO48EJnWeQbKTteoQ323xWchMFa46PDciMRbd/PAhM8yr4FqADtpe0q/PBiPbFgfhE48zycdb4zeYy5Gv8QMEQibekuJG5+6lCcvhG0LV3B1EH+Nnx+HZRXjQ3OgpTI2qxDSz0jhI6GmOF9TZnkXSsXtvBJUD2gSuGkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTP36pAB; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-948bf83a707so16690239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896853; x=1763501653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=faoL/581sKLIsYsWqc2fTjhaZ/7dqlOr2SS7YQEysnk=;
        b=RTP36pABvNesvLLaLW+q4Ft6in/TEzB+g25EuSsaawLo2+L8l9FnOTWJw0MfiRz+yk
         QbYVKaWFcaMOO+AUEw7VKeGvaPqOG4h6lDSwfcObx+8o9vbCMnDS5Xm8CWDsu8evuciO
         em78SWtKRIHTtIgGeYHzjWell0SJExtTHChQ8nN57K3y8olvpd0opN7oMn4Q9rCbERG/
         FIwaP/i6X2zAV03PlPynPuXOWemBzkYpbOBvfWUqtpVQbxiZU9cgJn2O0EhMnDA2BHrS
         +2/ltbDrkTvHriwA0SBu6cG948Zjslo+XC53tRu9nqjniZJhT8swOC/L4Tji4BRL4bLc
         +5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896853; x=1763501653;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faoL/581sKLIsYsWqc2fTjhaZ/7dqlOr2SS7YQEysnk=;
        b=mYBCS97hhSFX5pibitMfyvS5FvZmNgKcuJL6qAWnOtgpVGc6+s6hds88Vc7GuTk17Z
         RGxGIkUH9zNSInafneGKXeLO1JiZo/zWiC+VG6zAiSZe6fCjx33Cz4KX+07r//VT2X9T
         6wUYbu9uYFWdr2o88HcgJWH0zSGboCNYb+pK5kYwuWjIOcdYK+mBvoEp0LP4fvIh+FD8
         aqD3w8cikQsEj5uMFcIyzkUpi07gYRc1M5S/x3gm7Wx9g80jIxkYpbjC+P6SuVpWP7w3
         FwStSigHeM/oZT2X8/4dNo+besM0hsHTFPC8scIKwqGMUW80jNZAqSSwqx0WkAuRj6R8
         CJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCVDr8lGWp0nawJvFuTrw0i3IOuPANJ/UIs9pwtVue+m8Po/AvLH0s4JTgy77PdWM7dT0m0rE9HenfHWras=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIVw8NX0xZoBdYTe6z1w/3Ddkt2WRvVoryQdBj6TCMXZjxi8s
	Wz/2A4HFt/FVsgbrO8iL2PGLYvw91nCu/tN+Ow02qvoeEO2ncmraT34bu5M/OlggOQA5uZBOjcj
	gb9itJsnyug==
X-Google-Smtp-Source: AGHT+IG/aZ9go7ZOrpCGgjTMFHeYQjMInmzwgOFE9yrvISrzaBcnwr39cpcFXvyVvz87vkDjNUO/YT25zrlI
X-Received: from iota25.prod.google.com ([2002:a5d:8159:0:b0:945:a6dd:926f])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:2770:b0:948:3f60:a625
 with SMTP id ca18e2360f4ac-948c4551927mr87902539f.3.1762896853288; Tue, 11
 Nov 2025 13:34:13 -0800 (PST)
Date: Tue, 11 Nov 2025 21:34:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM2rE2kC/22Nyw6CMBBFf4XM2jEdHkpd+R+GhbQDTIKUtAQ1p
 P9uJS5dnpPcczcI7IUDXLINPK8SxE0J8kMGZrhPPaPYxJCrvCJFJY5iMTxlMQNObpFO2COZVmu
 q7elcWUjL2XMnr716axIPEhbn3/vJSl/76xXqb28lVGiq2hrdUlloe+2d60c+GveAJsb4AUwjq Di3AAAA
X-Change-Id: 20251014-lid-switch-notifier-1cb9918d675d
X-Mailer: b4 0.14.2
Message-ID: <20251111-lid-switch-notifier-v2-0-789723d78d89@google.com>
Subject: [PATCH v2 0/2] Implement lid-notifier for lid switch events
From: Jonathan Denose <jdenose@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Denose <jdenose@google.com>
Content-Type: text/plain; charset="utf-8"

To circumvent a hardware issue where the touchpad is not physically
connected to the lid angle sensor, implement a notifier chain which
broadcasts lid switch events and a notifier_block which can be enabled
via a quirk to listen for those events turning the touchpad surface
on or off based on if the lid is open or closed. This will prevent
issues resulting from interference between the laptop lid and the
touchpad.

Signed-off-by: Jonathan Denose <jdenose@google.com>
---
Changes in v2:
- Remove notifier logic from input core and add lid-notifier module which exposes lid events
- Kconfig: Add CONFIG_INPUT_LID_NOTIFIER option to include lid-notifier
- Link to v1: https://lore.kernel.org/r/20251030-lid-switch-notifier-v1-0-c58dc9b1439d@google.com

---
Jonathan Denose (2):
      Input: Add lid switch notifier
      HID: multitouch: Toggle touch surface on Elan touchpad on lid event

 drivers/hid/hid-multitouch.c | 32 ++++++++++++++-
 drivers/input/Kconfig        | 11 +++++
 drivers/input/Makefile       |  1 +
 drivers/input/lid-notifier.c | 98 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/input.h        |  2 +
 5 files changed, 143 insertions(+), 1 deletion(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251014-lid-switch-notifier-1cb9918d675d

Best regards,
-- 
Jonathan Denose <jdenose@google.com>


