Return-Path: <linux-kernel+bounces-849879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94908BD1283
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF2533475CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D4C27A122;
	Mon, 13 Oct 2025 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dBQyeU6e"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191EDF72
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320902; cv=none; b=VcH2KsW3scphW0U5fE/A3SRV6AAsfWXchoAtkSVHEI68MdjTd3FQKgy5KEnN4nYrmK1twDFLqoU5NrqwwqusgZisC2xpiQmh6O4qZYQRue/Ca5b1xhgHyCScFwtHxXqkzBXjici0QpVzr8iANL4LQNffYltDHl8s2rPLtLdVrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320902; c=relaxed/simple;
	bh=6rOl5TirSFV9ovbqlSzIwyNT5PV/3iS1uNoq79WE41U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XT2NgxIjcFviT65g8hmxusP6CY56c2X98FQ2FPbkdSryuDvSsngu1ceNFtxN2nVe0uV3+Dy6bRak1Ujozi4FmIhTeiHvtJIgRYEZGX6cNDNZhTaDahaQLAaiZVLliepnKO48dMdD9Vx8xRReRNcT8l3zC4H8NzJp2XxubCtOKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dBQyeU6e; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b56ae0c8226so6527693a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760320900; x=1760925700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JpvLI5nP+gyknn6opMKaUZOwwLDmtrVHeM32uuY4r+Q=;
        b=dBQyeU6e3UWJFCEPxGVx9dwabhw+8B1ynC8dpWZCqoivQkPZZzFM2BAXLa40bBO9Bt
         tkigoD5Ke5xoyfSarexmMwED6+S9DOX3IWhI8eAkg4SF+dLcQGthDXPeDhL5VVJaKwRg
         bznvnuhQ1SGyRVW9R8ui+szw3pezECwo7DLsLQm0nCZflEz2DfVfOUqZ3sZJ4C0aOSfr
         clPxRsmvCHt381euEYHi3MAU7yzp2Fwp3ILutN4g0SOyXCx44eZSCe3hg6xQoNLRlDUs
         2+TgDK66ET05vcnAhOvGwdSfBIy+Yq8rjy7pOeWQQp2/iOyB297sQE9T3DGsKQv98NSG
         N4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760320900; x=1760925700;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpvLI5nP+gyknn6opMKaUZOwwLDmtrVHeM32uuY4r+Q=;
        b=DTg8rpmjuvhqgLTbDRGPqr3JhyX6dAkmAmAtzu5KQP2C1Y37wVfHAIgkDCjdnVuSNR
         dp6Km/luB0CMtDW8dPOcLBuGY+KGOcc+5pYOtUzXRCFAQx3/C1ZQbtHFLsBXrod8DvFg
         p0YX6K2QzJUWqw4V5Ctmv0m24Dxo2TxK4SDQaGXi5uuqgP+o5Wu8qIMEkFCB9h/8TYvb
         kmAwycxMBEE4Pxt7CfPKXKgqUFtjZ2aul+K9BVdZrd0i7BFTyK6a+x1VHb/mtlfRpM23
         xEU8FienzsU6lMfuM71vT9ZZL/A9goQfWKplPAW7PeuavFLtAIyZC4btSiNcJ89s7AW/
         oIIw==
X-Forwarded-Encrypted: i=1; AJvYcCWGl6XLZ5HS/dXOFQkM6uPD+tyFcfOvynVpDzYlBcdtIAJ5EfguC63+zIuY+LXfV0Jsj6LCguLOEJ6NPkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyHOEb/Y2uDt0xImJ3I+a8BRXIu+iwVBKi7Ehba1/5nhkPOcbS
	sEtdSOHOxy0c8F3YD4bUdrQJweLYe7EHee9gqjp7M+G+tZ/R07mf4ZA0NFiood57H8q6nHrffXx
	n/7sCuA==
X-Google-Smtp-Source: AGHT+IGSV4Ol9o+z7zxIxvoRhwLVMndDrfeb5+nVBlXaOxuO1evVU3XRexYaQ2WpjeMZq92/z1BnpCgFK+Y=
X-Received: from pjtp2.prod.google.com ([2002:a17:90a:c002:b0:330:9870:9f18])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38ce:b0:32e:5646:d448
 with SMTP id 98e67ed59e1d1-33b513b2ab9mr24908105a91.21.1760320899866; Sun, 12
 Oct 2025 19:01:39 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:01:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHFd7GgC/x3MQQqAIBBA0avIrBN0oqKuEi3SppqNxlgRhHdPW
 r7F/y8kEqYEg3pB6ObEMRTYSoHf57CR5qUY0GBjjUV9JeejkD5l9hw23bWrMb536GqCUh1CKz/ /cZxy/gDvV/PPYQAAAA==
X-Change-Id: 20251012-usbcore-tracing-76f00c9b2b3e
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760320897; l=1014;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=6rOl5TirSFV9ovbqlSzIwyNT5PV/3iS1uNoq79WE41U=; b=YY+P8OtFoKB5B2qwpSCuEgDKP9NncBkOqOAnvOShle8YqXY/5iIDKpIZAczOupGq+TfovGCgS
 26kzOaY1AirBXEN1QaqbgRX2ldF5HWv2umw+vqpZhAIm6PrAfNgz/Hq
X-Mailer: b4 0.14.2
Message-ID: <20251013-usbcore-tracing-v1-0-b885a3121b09@google.com>
Subject: [PATCH 0/2] usb: core: Improve device lifecycle debuggability
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
Kuen-Han Tsai (2):
      usb: core: Centralize device state update logic
      usb: core: Add tracepoints for device allocation and state changes

 drivers/usb/core/Makefile |  4 ++++
 drivers/usb/core/hub.c    | 30 +++++++++++++----------
 drivers/usb/core/trace.c  |  6 +++++
 drivers/usb/core/trace.h  | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c    |  2 ++
 5 files changed, 91 insertions(+), 12 deletions(-)
---
base-commit: 5472d60c129f75282d94ae5ad072ee6dfb7c7246
change-id: 20251012-usbcore-tracing-76f00c9b2b3e

Best regards,
-- 
Kuen-Han Tsai <khtsai@google.com>


