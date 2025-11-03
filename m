Return-Path: <linux-kernel+bounces-882182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4AC29D45
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1098D4EE660
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184AA28750A;
	Mon,  3 Nov 2025 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFXOIs71"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281A28312B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134671; cv=none; b=fb8UuGhpA+mDRo36BuTdTRuXpulNNem27R4uc8oDJE9AX1bxBcB360r6rtm5uacryyCjy7Uit5CJOhHFoNkXUe30Ij3+H8dxSu9y87kdZC0Clqt1EicYq27BOJIL3bxM8/+5vHS/HY84SZgbSoDYBi0t4UCUmymrxeheJdMgoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134671; c=relaxed/simple;
	bh=GTa5PMbqingrx9UUvDQwwryRQXi1hbUYeu/uDR+oix4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gammYki1Cez2BNayi/MVfiWb7+zs07XHodZTS5fDF5G3o+MURDEMwugZBAdxX3O6ppRXPRJVX25aP+Ra0rG3icMTsgDiBltmXSDzgOXE177IcDOCQw7vuP6yw+V5IuqokIyvB5gc3CuqMaIUB4Ye16hm74CCODZJaaiaOekUYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFXOIs71; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29470bc80ceso42631175ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134668; x=1762739468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjjrDgD3WOpxSbQxw9z6dYOn0RSDkCVjfKdY81mup90=;
        b=nFXOIs71tYVs80IsegIyIuR8MwOqHUs7hfY4XtEosGRZ7W8UrYAD2gpyCIFiG7/6eW
         CxemSDABdC+VCsyVFq6rEpO09FeNlWscPy7MAn3MRyVvvOfTRsKXVwzGnRMG2RDq7Up/
         oQBpa+xMjRZT3JPujzs0kgFNED/E0hb2oWjz3PultsQRUxVndQZTjoMGSB+j6/AJfGRP
         +wEc0y6ZMtDa0Oo5FDU70wgzdhGtlGQrDiBB4A5hxI3QqpJjAUvrqDIPCeQJIj5hPbOy
         cjFq/aNYvfHFl3Hc35ZnVcfuI9nWhYommisw2nyoc0GNKbjpqQbJUKuHCAK9lhkg8S9x
         LhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134668; x=1762739468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjjrDgD3WOpxSbQxw9z6dYOn0RSDkCVjfKdY81mup90=;
        b=aJHpWXtNbwDLCpV/K1hOfv/vbxqREhXIBd9YF19O/u2IjccCHKvmQpsDM8j9Wch8HP
         x9kJgCpytj0UQBPhDwIPVqA1md44Nzd1QOIRH0ORgA/vuJjy2kfR4XUKveGcQzqMwTeT
         Kkbbxy1Xd1HMSmUF8YbxRofcQzIxUOyRiOGYMqVYZ9ZAEJUawO03qJgc45Ren4jxBN0u
         opPIkfg+Rvb5Vhefs55rK7CZcTS3mX4zM0VB7BtuWJCxH5stDhZE4wmTpPWvnTB21Jqk
         nITc6ikK3egPiFIkTRaXMA2C57ETPj35rBJEdB8W4PN9pQUxYfhztAVIDHc7Aw+rEIrj
         e9uw==
X-Gm-Message-State: AOJu0YwQD7ZcFOgjWSRSRIJQjSu6EAMy/4m6eMV0qvxGjEadCzPK1scV
	g/IVpUcN9PMo29fsSv5IsLrS+RqEO/sGtbsQXAJ4Sh0Knq3VCw3Mng745HEu9BHiink=
X-Gm-Gg: ASbGncujYEYYCAug9XM1jsLTp8+FqRxOG3QBm/JYGK/nqZ9md5ADKSVMS5M7mEQzVl3
	pbuTSE4WBrEPsCnZdkMpMuPZfnp1j1XC/F0nP2ZYp963fgD9b6bKxmJosJEpibdmu0aew10ILeX
	MNvXLmB9i9zyWgMlP9ocM4rLtFJWr/S4ZvRUdvD6/ICI3Pnijn7c/aDnFNZMDmIF6mLckI7kU/r
	WXizwfemlYP5MlWPAltmfNss9ZRti2sOP9tVCIuGhpo2Kk/1DXP3MUFwl8plTy1wNBqSvD3ir0u
	pFGxquWr+FP17y3GTH2DW1JKc4YPy/VHVwUT0NGP2WiHqrIIeMyIdqe92/XILROUZGLjSjfivbW
	PPa6VH7pIL3cMzZ3o58w5QtNT0fgblokUheblvz+fns/6lwfjZjyhwcBnPlPuljbs5wHT2EUVLh
	BC8etLOtg12tw=
X-Google-Smtp-Source: AGHT+IFyCErUd2LTMpCfiBKckFhfziU7rNdrc7hqKpWdpQrtJrl/PcLHkl+2t0Dv9Jq0LTgXu93AXQ==
X-Received: by 2002:a17:902:d505:b0:290:b10f:9aec with SMTP id d9443c01a7336-294ed2c61c2mr160888385ad.26.1762134668001;
        Sun, 02 Nov 2025 17:51:08 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2955615d720sm66919025ad.65.2025.11.02.17.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1677C4264540; Mon, 03 Nov 2025 08:50:58 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v3 4/9] Documentation: xfrm_sync: Properly reindent list text
Date: Mon,  3 Nov 2025 08:50:25 +0700
Message-ID: <20251103015029.17018-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5939; i=bagasdotme@gmail.com; h=from:subject; bh=GTa5PMbqingrx9UUvDQwwryRQXi1hbUYeu/uDR+oix4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnJVtbMe6i2fllH6Q9Ln1ePVJz1Zd42qjyOd2lew/L j0sM3/QUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIlM0GT478PqcP7YFKNoUW+u c552OypmmG8vnXnuhehbpddTL79c84SR4dqdrftzet4b61XtkQrqDd0sGXLfo0/TiunqoedBuZ5 F7AA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

List texts are currently aligned at the start of column, rather than
after the list marker. Reindent them.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_sync.rst | 77 +++++++++++++-------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
index 6246503ceab2d2..c811c3edfa571a 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm_sync.rst
@@ -88,23 +88,23 @@ to get notified of these events.
 
 a) byte value (XFRMA_LTIME_VAL)
 
-This TLV carries the running/current counter for byte lifetime since
-last event.
+   This TLV carries the running/current counter for byte lifetime since
+   last event.
 
-b)replay value (XFRMA_REPLAY_VAL)
+b) replay value (XFRMA_REPLAY_VAL)
 
-This TLV carries the running/current counter for replay sequence since
-last event.
+   This TLV carries the running/current counter for replay sequence since
+   last event.
 
-c)replay threshold (XFRMA_REPLAY_THRESH)
+c) replay threshold (XFRMA_REPLAY_THRESH)
 
-This TLV carries the threshold being used by the kernel to trigger events
-when the replay sequence is exceeded.
+   This TLV carries the threshold being used by the kernel to trigger events
+   when the replay sequence is exceeded.
 
 d) expiry timer (XFRMA_ETIMER_THRESH)
 
-This is a timer value in milliseconds which is used as the nagle
-value to rate limit the events.
+   This is a timer value in milliseconds which is used as the nagle
+   value to rate limit the events.
 
 3) Default configurations for the parameters:
 ---------------------------------------------
@@ -121,12 +121,14 @@ in case they are not specified.
 the two sysctls/proc entries are:
 
 a) /proc/sys/net/core/sysctl_xfrm_aevent_etime
-used to provide default values for the XFRMA_ETIMER_THRESH in incremental
-units of time of 100ms. The default is 10 (1 second)
+
+   Used to provide default values for the XFRMA_ETIMER_THRESH in incremental
+   units of time of 100ms. The default is 10 (1 second)
 
 b) /proc/sys/net/core/sysctl_xfrm_aevent_rseqth
-used to provide default values for XFRMA_REPLAY_THRESH parameter
-in incremental packet count. The default is two packets.
+
+   Used to provide default values for XFRMA_REPLAY_THRESH parameter
+   in incremental packet count. The default is two packets.
 
 4) Message types
 ----------------
@@ -134,42 +136,43 @@ in incremental packet count. The default is two packets.
 a) XFRM_MSG_GETAE issued by user-->kernel.
    XFRM_MSG_GETAE does not carry any TLVs.
 
-The response is a XFRM_MSG_NEWAE which is formatted based on what
-XFRM_MSG_GETAE queried for.
+   The response is a XFRM_MSG_NEWAE which is formatted based on what
+   XFRM_MSG_GETAE queried for.
 
-The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
-* if XFRM_AE_RTHR flag is set, then XFRMA_REPLAY_THRESH is also retrieved
-* if XFRM_AE_ETHR flag is set, then XFRMA_ETIMER_THRESH is also retrieved
+   The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
+
+     * if XFRM_AE_RTHR flag is set, then XFRMA_REPLAY_THRESH is also retrieved
+     * if XFRM_AE_ETHR flag is set, then XFRMA_ETIMER_THRESH is also retrieved
 
 b) XFRM_MSG_NEWAE is issued by either user space to configure
    or kernel to announce events or respond to a XFRM_MSG_GETAE.
 
-i) user --> kernel to configure a specific SA.
+   i) user --> kernel to configure a specific SA.
 
-any of the values or threshold parameters can be updated by passing the
-appropriate TLV.
+      any of the values or threshold parameters can be updated by passing the
+      appropriate TLV.
 
-A response is issued back to the sender in user space to indicate success
-or failure.
+      A response is issued back to the sender in user space to indicate success
+      or failure.
 
-In the case of success, additionally an event with
-XFRM_MSG_NEWAE is also issued to any listeners as described in iii).
+      In the case of success, additionally an event with
+      XFRM_MSG_NEWAE is also issued to any listeners as described in iii).
 
-ii) kernel->user direction as a response to XFRM_MSG_GETAE
+   ii) kernel->user direction as a response to XFRM_MSG_GETAE
 
-The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
+       The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
 
-The threshold TLVs will be included if explicitly requested in
-the XFRM_MSG_GETAE message.
+       The threshold TLVs will be included if explicitly requested in
+       the XFRM_MSG_GETAE message.
 
-iii) kernel->user to report as event if someone sets any values or
-     thresholds for an SA using XFRM_MSG_NEWAE (as described in #i above).
-     In such a case XFRM_AE_CU flag is set to inform the user that
-     the change happened as a result of an update.
-     The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
+   iii) kernel->user to report as event if someone sets any values or
+        thresholds for an SA using XFRM_MSG_NEWAE (as described in #i above).
+        In such a case XFRM_AE_CU flag is set to inform the user that
+        the change happened as a result of an update.
+        The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
 
-iv) kernel->user to report event when replay threshold or a timeout
-    is exceeded.
+   iv) kernel->user to report event when replay threshold or a timeout
+       is exceeded.
 
 In such a case either XFRM_AE_CR (replay exceeded) or XFRM_AE_CE (timeout
 happened) is set to inform the user what happened.
-- 
An old man doll... just what I always wanted! - Clara


