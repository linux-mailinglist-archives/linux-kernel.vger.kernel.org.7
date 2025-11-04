Return-Path: <linux-kernel+bounces-884071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E09C2F4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011AE3B73AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEBF2C1598;
	Tue,  4 Nov 2025 04:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTlTFM0T"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522542609FC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 04:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229919; cv=none; b=tA75hXtdlB3yQe7L5wCRMrWM6v1mJUZpliRZs6+rRoXslZZi/Jp38kp/b5D3Vo6U/FIl7+NkRsl3jwsOVifYN25hD7jmpsDLXFl+AtNndy+3oaDPkTc/wkpHLgt6EXwpnQXFADNYrmCJfZC8BzRPguNMvI3rDa7OiXfwqBAWZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229919; c=relaxed/simple;
	bh=8855m9+nqy+8wYqmAZmw0bP5tKS9ASfH2+owXVBRaZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cl2yV6FnadQuIrOzvWD6RjcHkyj6AkswsFklCwxKhdcggSnnVxEA2WlpVl9NWV0g69Qd6hejk25yeamBEKQOx8v87PmqeAJ3hNHZNjLoTUkrbRoASmDWoMKpH6SKgEBfAkUk7I6YxHCPMo1YuPYhKXTgo0ON0V7M/mUCnWwhDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTlTFM0T; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b994baabfcfso1123152a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 20:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762229915; x=1762834715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0HMtYKZFYGMCTqL+m68iyK+g2w90hvxS2w8+ON2XP0=;
        b=fTlTFM0ToMSBftDU5O1wmYMTBQsx6b7HkTm6HJVEG3acqYzsbPMzXhutECiGuSB/mu
         CZV2Ba8JvN0LwuoNN7v9C+CazVrLw1yJ5/yEb5zUdtF5h3vli54VHEzhhilxD4OOIqfm
         VwBS1o7QdG6+6Yxc05/0fOl6slCkvddTjr+b6ZGE3B81OWnQFBuSA5Wf2BseNXGrak92
         OVMq/EnqJW/PYK6JAltfr6niznQYKesmAlb6PqtLujoid+95rT/Q+yVLcOypKyFu49Ko
         4XDvZOyAHb+rBL/GPGSt8WClWX+7nz/VoulH6ny/tPynD+OWVkbxOe1W5XMBADBLvY54
         Ffsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762229915; x=1762834715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0HMtYKZFYGMCTqL+m68iyK+g2w90hvxS2w8+ON2XP0=;
        b=Emw41iqRo73MlAKkUpA4V3d4rCCmyMXxdMGvf0+1tNohB9bHLBL2AmRvKHGn08rDM+
         N+RIWmeL7zpdnqClUUFWWaVg77R4M25sfhDufkWsCO808/zAqRVwcQg1lmWaONDSJYAE
         9f1ovoonv/PZlD7DD0/esHPvJUeGyEjOllFk4qaR3AanQGBB79MW3CI/3+30j4I7TARs
         irqwKHj89M228Qu4DAOzj/1OCkQPTgk/7tZQx15zWSbNz8ef7t2heH52xduiLycaw1hY
         bqbT2wufJmZeIP6RHdodc4Jb0K7SsT9mDc+TK42R6S2WNVTeJrXsv4HwsmN/omE8gnOB
         k/5A==
X-Gm-Message-State: AOJu0YzPBUOLRDBg0deCvA3OY6f7cCCbGMFYtpjR84gOoGYWEfc4UDvS
	mbuS/uYJq+0Nxnud3iVdWsxGaI2KcCd0NoSsVBdz5J3Ucdv1CCfPNZBj
X-Gm-Gg: ASbGncuRoRQ92n30v+zVvuXbUy0Oj9DAuSRsOmxmtSL/ii23o7JNrRWk95LbdH/0vky
	5QVVHD7U/VNkxVbFVIKrzoSedF5FHfwyKRyspOyk5IEzfIoasrIHl464I9osMwWg/Tjdtr9UTDk
	weCxrsnkfP3TAC9x1uy4A1H9ZuXCQTp+aQ3lmHqFiFqA2ymsOASZidK6NEDKirbufuNXDnpmVWM
	aaYmFVJgpI8hjQilChn7CGQp809oinlU+B9pFJAEAXYymDQox4dIUX6JagBTxRFdi4NS/ohjJEX
	9FUMSCCBRyWE+Onvk+GI+rXqzhBUZAhDQTN1QE4LEG+5Y8//Jlrw7z7fVrF4L7LSJGDpSxuhOVO
	aWQW9eZNa44irDN6lpjFZKlVuVBduZ3ZGJuzk49yVPltni4rNK3Zz/GfBldvRyJL8qeC0pLZ7qd
	AP
X-Google-Smtp-Source: AGHT+IH86x1mFFyx35rf6M/5gXmaVcDwtyw0wR56zZN3L/VZzuo6T3GgD57pxoyZP4hb3kyYFK8e6g==
X-Received: by 2002:a17:902:ea0e:b0:28e:9427:68f6 with SMTP id d9443c01a7336-2951a3e6517mr189573085ad.27.1762229915395;
        Mon, 03 Nov 2025 20:18:35 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a375ddsm9071975ad.72.2025.11.03.20.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 20:18:33 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 9BF6A420A6EE; Tue, 04 Nov 2025 11:18:21 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Akshay Gupta <akshay.gupta@amd.com>,
	Srujana Challa <schalla@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Julien Panis <jpanis@baylibre.com>
Subject: [PATCH 1/3] Documentation: amd-sbi: Wrap miscdevice listing snippet in literal code block
Date: Tue,  4 Nov 2025 11:18:10 +0700
Message-ID: <20251104041812.31402-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104041812.31402-1-bagasdotme@gmail.com>
References: <20251104041812.31402-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=bagasdotme@gmail.com; h=from:subject; bh=8855m9+nqy+8wYqmAZmw0bP5tKS9ASfH2+owXVBRaZQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmctQyHL3Vr1f2aEnB9x6RNWecn2vMF/tH6uP0ow43fE fOPuWgodZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAilhcYGRou3e3g2/Vy47So +VLT/Gectd2r9fb0utMHWO+b/8qrObCBkeHphOgS4aVVP3Y3TdmhmSYWrHJd6XvnnbxWtkeLfj6 MWMcLAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Device file listing (ls output) is shown as long-running paragraph
instead. Wrap it in literal code block.

Fixes: 4d95514d14e874 ("misc: amd-sbi: Add document for AMD SB IOCTL description")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/misc-devices/amd-sbi.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/misc-devices/amd-sbi.rst b/Documentation/misc-devices/amd-sbi.rst
index 5648fc6ec5726a..07ceb44fbe5e19 100644
--- a/Documentation/misc-devices/amd-sbi.rst
+++ b/Documentation/misc-devices/amd-sbi.rst
@@ -28,8 +28,10 @@ MCAMSR and register xfer commands.
 Register sets is common across APML protocols. IOCTL is providing synchronization
 among protocols as transactions may create race condition.
 
-$ ls -al /dev/sbrmi-3c
-crw-------    1 root     root       10,  53 Jul 10 11:13 /dev/sbrmi-3c
+.. code-block:: bash
+
+   $ ls -al /dev/sbrmi-3c
+   crw-------    1 root     root       10,  53 Jul 10 11:13 /dev/sbrmi-3c
 
 apml_sbrmi driver registers hwmon sensors for monitoring power_cap_max,
 current power consumption and managing power_cap.
-- 
An old man doll... just what I always wanted! - Clara


