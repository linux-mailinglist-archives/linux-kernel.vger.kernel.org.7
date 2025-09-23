Return-Path: <linux-kernel+bounces-829484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB1B972D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3AD4A5BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629042FFDF3;
	Tue, 23 Sep 2025 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQd5VRKm"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB72FE57F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651389; cv=none; b=sFXiUxoSm/kp2quA9UYsMx6/UwhUaXC0a0o1IpdERJ/9wbMINwut92c7ZhEdCqH8TRbgt6Oefj5e+SPYDos3IkdsV0VdRX4dLh1010eQ0tuegBZBeJKTLx5Uz1LijqsWTRRF5Ef4L0JumZgsP/jVEcwqZ+tA7oOUXD3bnGVA18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651389; c=relaxed/simple;
	bh=1+kcATkC5f3HWOtC/fC+MLOEx3KLHS28TJMVzM8cWY4=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=F0Mc+1CfpuyPGGG86rqWZQ/cbU9Iwjcf9UQCNiCrpgim+W8t9gQviaMnLxPkkmVupDU/I0ubPFxrxyd34cwGOMJZ8Ezbg91kOn69q/3RaoYVDFSJy6k7d24Pqm/6ibGai7X2FcQEEUiApfqv8z+ToZabe5D0OvnxMCTO01Njo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQd5VRKm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso7066449a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758651388; x=1759256188; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZFznumGd2U85Ri/iOIW1hZfIOtNS7lG+bdZZwUDcAY8=;
        b=ZQd5VRKmAXwId4XltGGKUZT+njt7h+F078lqATJNJQALmw0rBbuzpPB8mKtDXFxbn1
         Dm12jVojNWPFZ23h3FE/VlmgL8mUTR3oaJ7OFKoLFPoRowMvK0sIuwvYK80xevME/W4V
         k398R8/AoeHLw1jduanbNBdXlz7wvT/996DxiIMQPNCeLN2rMLm/aXBkV+yyCUIuuwZp
         eu8hKdPAhogCj8/f9hvuRovOi8/NjWApgnh6POGNjQ/hzQWgLlncVDzGbN4Crf4Ui1gS
         d/sLEXYZZohvMnRudnx+aggvVXGQuQYeFRKiSHfr0xLmwwO2oTqxsgG/DzcwldNZBGjp
         9bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758651388; x=1759256188;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFznumGd2U85Ri/iOIW1hZfIOtNS7lG+bdZZwUDcAY8=;
        b=LMMj72uQuU//HNHxR4GTRYekmHovwT8jrSmRXEG7L4CIrsfMNq9ayO+XLEWZfuDX15
         E/oYC3XtDXTojhjr8NsaS4vZjpvK9jM/QP1TDoFZJR/L+9Za3n9fR7tPN7NHBucvQK3D
         /uodSpXIC73KgU+Ve1md4NwkZzWsLkhqOC9E4Y9cphPDKK5yJQ8BbDCUIRCz7bV2AzHt
         0dUQl8NjRFyv6bTfH/Xr9sb4PJZAU9olKUVLAbHSNEkxpvo7ax4mn/NjxcUSyGwde4wP
         yZ1zoQd1UWbpR8BP4sA9mSPjl2tmeKVmQkdhMfdmgY2o1uO8aiGVsDTrkLcPAepdh0/0
         9Deg==
X-Forwarded-Encrypted: i=1; AJvYcCWfqGDJsr+NL6jUyil3s65M3tDIG/ESRlGda2mNNFGbM0E6K32vc7srrCxgTovm0kwMngX2swg37r1lfF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/d8G5lPVgk+Y18ncgWCvq9dKREDPYsqrhHiVHcDX7xK3chI0d
	570V3DOPhPZQ1hc92tnyMIpwxLVOWZsRvSaGB5GNhKdPsvQe1CCs4SPwd+PyDn9lqpjuLMes2KW
	K4Aytu3upTTafpiNi2g==
X-Google-Smtp-Source: AGHT+IGMvDN2F1NIr0EJNWT6yvgMebfBxe0TzexAE8rpVVOzPJaDcqnhXgvEdqsm1/imNYGJOgUTqlQEJ7XGYx0=
X-Received: from pjbqn13.prod.google.com ([2002:a17:90b:3d4d:b0:31f:2a78:943])
 (user=rdbabiera job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5109:b0:32b:8b8d:c2c6 with SMTP id 98e67ed59e1d1-332a950f797mr4428288a91.14.1758651387626;
 Tue, 23 Sep 2025 11:16:27 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:16:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=0B74D21BCA57BD40083A73A0DB00FC8CD80B20A1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=rdbabiera@google.com;
 h=from:subject; bh=1+kcATkC5f3HWOtC/fC+MLOEx3KLHS28TJMVzM8cWY4=;
 b=owGbwMvMwCV2m+FPzw1uhYWMp9WSGDIuPX7Wu3v6i46T1tIHZ/utTT9m4lI9Z9Lu6ydV+1d9f
 +wn0lnZ1lHKwiDGxSArpsjCXXJJ+lT4XgcOq+IFMHNYmUCGMHBxCsBEPu5k+Kcm0/qVcc4bVSPR
 jtMe7U3ShTJc85f9Py35u0PrdLm14gtGhkNV95NLnXLa3fuvix348iFsaX5ypszKI1qLvzunLOy Q5wUA
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923181606.1583584-4-rdbabiera@google.com>
Subject: [PATCH v2 0/2] usb: typec: altmodes/displayport: add port data role
 handling support
From: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	badhri@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	RD Babiera <rdbabiera@google.com>
Content-Type: text/plain; charset="UTF-8"

This patchset adds support for Type-C PD altmodes drivers to query the port
data role using typec_altmode_get_data_role which requires a new symbol
typec_get_data_role. The UFP is not allowed to send the Enter Mode command,
so Alt Mode drivers can use this check to prevent driver registration
during the probe sequence.

The DisplayPort Alt Mode driver queries for the port data role during the
probe sequence and exits if the port is the UFP. If a data role swap were
initiated, the driver would be unregistered anyways so it is not necessary
to keep it alive.

Changes in v2:
* fixed typec_altmode_get_data_role documentation styling

RD Babiera (2):
  usb: typec: class: add typec_get_data_role symbol
  usb: typec: altmodes/displayport: do not enter mode if port is the UFP

 drivers/usb/typec/altmodes/displayport.c |  4 +++-
 drivers/usb/typec/class.c                | 13 +++++++++++++
 include/linux/usb/typec.h                |  1 +
 include/linux/usb/typec_altmode.h        | 13 +++++++++++++
 4 files changed, 30 insertions(+), 1 deletion(-)


base-commit: a4e143636d5def935dd461539b67b61287a8dfef
-- 
2.51.0.534.gc79095c0ca-goog


