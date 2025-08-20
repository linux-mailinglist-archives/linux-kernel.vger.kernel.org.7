Return-Path: <linux-kernel+bounces-777133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96476B2D5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC01188E263
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4782D8DC0;
	Wed, 20 Aug 2025 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c47YfcPn"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F52D8DB5;
	Wed, 20 Aug 2025 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677478; cv=none; b=p0RBGm+OHZ76RCxXzOfFQQ9bYZic7rFY0vkYzu4BAyBjY/i2FIoj0s3LxLeimWrn1vn65QvRCJ3wg0fXF0Ot9Y8Ma/aKV90BBlDMvoz7kHIQnMSgnKq8VTw2QK0E5naa55HCcVLY+MFCW7aXaWR77fZDIPahH0NoGQgKgJ9+v3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677478; c=relaxed/simple;
	bh=zhU90gENIt6m5S9nU72048ieevwHXA6Cr23wBCe1HMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNBt0tQYN69/3PURlPbk+0av1mEOWhyRZ9zQQXYrWgSUwNNni9cmHHhx1dKAbQBRW5DJrexRRDGq/7b+1Q3gnvw8H6kDmvkGs8FYvfR6T2EBCYBfIYXt1FTf0LWZAko5jbutkPhCA1AQFO4ekSLffmeWLNwT2P86gyIxrZMdMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c47YfcPn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b474a38b25cso2348714a12.0;
        Wed, 20 Aug 2025 01:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755677476; x=1756282276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uJToI59rRAOE1gc0N60ALVfYLEIhbuWTNqg5O1wrlA=;
        b=c47YfcPnqPuSo4MsbSy7JMJqbaxZsQdJMv8WyQ+ruZ+OQPNX9tTxWwXm17TjuXRdqN
         R1ZNg0G/8wxol2vlCUpdmffMHjaOHxprHo8O9b+zAwLCOEn23x/jnhTqmo+gKmpdpC/V
         sKSoxoWWALwo2MKpRkHKwq/ozQysnxi7+RzVY7D6ANNGqIg+DqhRwpIyg+dRqsJaVd+j
         w1DjIBzuEGaaAFnYJmTGesyu3apdp2kdbJKujEViY/46keEt/sRrkBS3qSqYvaEHjdvR
         KTi+9yAkT+5ZASxQTVklAvudSNlAdJm8xeXbUBK25S9SWZOeVYo7bGuLCto++cb5bNsk
         3pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677476; x=1756282276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uJToI59rRAOE1gc0N60ALVfYLEIhbuWTNqg5O1wrlA=;
        b=s6f+AHZbV/PJp6qJv9y6FOpCvLYsF5WAojjCoSQX3cMXSprP4WN0EOmWneKLoaRb4z
         eJsXVd1WSA6evyC23MvZT2Gs8KPmf7VXW585OhNGhLQ5d0pBPNK1+Qx1Lr+p9dwbaVEO
         v3lmKdxeOUnjKHKiBdmI6BTo9sxxRXCkILiDdUFgMrityopcqCLJytZoZAhZbFXVpewy
         J8PCHE7lq5y4Ua5zr+e8mrnIGre/NmScr0B1DoZEwKVP7qBeSdzTbbVmap1QCJL1QqGH
         OI/DxoJZn0Tx6Y6bfLB4c2c4RN7FItF0JsRfFzToZAB1iiDcdfTwWnxO/6Rlyytg4JzT
         /CwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhI3UckqBGA6u29torqHSQ/5NbiGbWqdron0KALP5DZZagsAzoTFsVciH2flrD+NtUop4kOWDPSxgTrBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznGYR025Af3gFH2rZYtGbLgV9IlbngHDaPQwoCKaRWLRCR4K5J
	cCJnA8jYSzksRJ71xd6Yzwtvf1uWnmDzKtBt1BFfeYp7lnf2LgpRFHgB
X-Gm-Gg: ASbGncvvOQEEObHTi4+dDyt2+tEFe2Kwt6CjoEXXHMuJrv1q6dqWjM4SIv3PFN9Hjv9
	AFdfF4jfC0AmkOLIhQM0WmIGrHEav8gKOyoy/CQ2SyMa8VRMyaWJbjBh57xRnO7rrSVw2NX/k/r
	0D3KpOBuEhdHambZGP9wZD51Nl3I7IjkqbXWggHc1c4NH3HO6wNj2W7p0Xd1lETDtRhRZxs+V+7
	YWTlIwIJ6c448re39W6JVVaKVJfujosIiCTjRnym96Cwrt4Egc1vQGQsOBO40GOi+8t90txCEZM
	iAT3tplSr1WwXnLtlvO3cJlq/KBr4DwIDS3wytr611HoHl6H8aI6rYtQheHXcMyPILbyboG/iJC
	afFIFQ1bhwAZ9I6hgh0RCfPF9B+h7LENaS0Jziv4Th5bri/iV63ls/B9W6Rh2tu5ofU+WvZmfzK
	viWdxH+7K6CJzWvJ3m3kHQNZ4=
X-Google-Smtp-Source: AGHT+IHRpJjOUwdzKFcbumUiG0JtzjRr9ibvwc9l5t2qXGAFlX3fz0AC58y491s3yhEJ8G8oY+hoOg==
X-Received: by 2002:a17:903:2341:b0:240:83af:e2e0 with SMTP id d9443c01a7336-245ef26a246mr26334255ad.47.1755677475645;
        Wed, 20 Aug 2025 01:11:15 -0700 (PDT)
Received: from cs00-MS-7C09.. (2001-b400-e354-0073-e04f-2231-2c79-4065.emome-ip6.hinet.net. [2001:b400:e354:73:e04f:2231:2c79:4065])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4f6a84sm18744625ad.118.2025.08.20.01.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:11:14 -0700 (PDT)
From: hsyemail2@gmail.com
X-Google-Original-From: syhuang3@nuvoton.com
To: Oliver Neukum <oneukum@suse.com>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sheng-Yuan Huang <syhuang3@nuvoton.com>
Subject: [PATCH v4 0/1] USB: serial: nct_usb_serial: add support for Nuvoton USB adapter
Date: Wed, 20 Aug 2025 16:07:13 +0800
Message-ID: <20250820081011.11164-1-syhuang3@nuvoton.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACW=pY7KgEQRJfVOkiSjVSAHDO0b7kOVWSW1GPE_SzLPrb9r6Q@mail.gmail.com>
References: <CACW=pY7KgEQRJfVOkiSjVSAHDO0b7kOVWSW1GPE_SzLPrb9r6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sheng-Yuan Huang <syhuang3@nuvoton.com>

Hi everyone,
This patch is a revised version of the previous submission and includes
changes based on comments from Oliver.
I apologize for the delay in following up, as I’ve been tied up with some
ongoing work.
As requested, I’ve included a detailed explanation at the end of this cover
letter regarding the payload length handling logic. Thank you to Oliver for
the valuable feedback and suggestions provided in the previous review.

The main changes are as follows:

- Remove unnecessary index macros
- Add explicit cast to avoid overflow in command code bit-shifting
- Remove misleading baud rate warning (nct_set_baud())
- Use correct spinlock variant for sleepable context (nct_tiocmset_helper(),
  nct_serial_tiocmget(), and nct_close())
- Clarify and simplify payload length return logic (nct_serial_write_data())
- Remove NULL check for port and for write_urb/transfer_buffer
  (nct_serial_write())
- Use kzalloc for buffer allocation (nct_open())
- Add error handling for nct_vendor_write() calls (nct_open())
- Remove usb_kill_urb() (nct_close())
- Add buffer size check before accessing header (nct_usb_serial_read())

Regarding the handling of the payload length returned to the upper layer
in 'nct_serial_write_data()', as requested by Oliver:
Previously, I checked whether 'usb_submit_urb()' succeeded and only
subtracted the header size from the total length if the submission
was successful, since the upper layer only needs the payload length.  
After considering your feedback, I modified the code so that the return
value is now set directly based on the result of 'usb_submit_urb()'.  
The functionality remains the same, but I hope this version is more
straightforward. If you have any further suggestions or concerns, I would
sincerely appreciate your feedback.

Best regards,
Sheng-Yuan Huang

Sheng-Yuan Huang (1):
  USB: serial: nct_usb_serial: add support for Nuvoton USB adapter

 drivers/usb/serial/Kconfig          |   10 +
 drivers/usb/serial/Makefile         |    1 +
 drivers/usb/serial/nct_usb_serial.c | 1532 +++++++++++++++++++++++++++
 3 files changed, 1543 insertions(+)
 create mode 100644 drivers/usb/serial/nct_usb_serial.c

-- 
2.43.0


