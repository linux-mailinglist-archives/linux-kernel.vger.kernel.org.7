Return-Path: <linux-kernel+bounces-825928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13321B8D239
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C4189F957
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F1267B94;
	Sat, 20 Sep 2025 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p477SXld"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489BE1C3F0C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758410277; cv=none; b=Ckvs6t0PoL9KRBfOW4PFyxo+7bjijiKlHxdrAWPnCSaxnO5wiHnzRBSRgdKgHw+ebHkFG6892O5oZ9/iTi1JsUxRo5/4q7iyYw6p8fEYmU1skmHb+MM98kGwmh47o6Ovv8FIQgUJCWNQG/y6sU3mlzAprxer6wThzIK4FemGy78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758410277; c=relaxed/simple;
	bh=G/KVEA6ViEWnKvN1kHms/3KktEfZIelB3DdtbCJIg34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dzB1FBVkvB3lM+XCmiXnAdF4zQ5iS3YGAaM+OFHaCp6+/lwRmKbxZ5r+8qd6ZbQEq56dhkIjHVxbgT5wREl98C+2PU8/YxOks5GSczM+d1cppj6MqUIoxfiW98cuntjcD9cGOvj5QJX42bF/BS8Khu8FU0rsoXFP7lKYgAdD6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p477SXld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A78C4CEEB;
	Sat, 20 Sep 2025 23:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758410276;
	bh=G/KVEA6ViEWnKvN1kHms/3KktEfZIelB3DdtbCJIg34=;
	h=From:Date:Subject:To:Cc:From;
	b=p477SXldWwo2M0sODjdZxFK6EMik9VbIfWdFl263uvQtZcyjIVfi9+SxvDmRzHw+E
	 2+qtD97oCZjP3CVp9vOCwToOJTHdcWzMzdHthiycDDEDjiVTh0Ha214NXh8IAKVtDN
	 WICQXr/XZxIPqLTGYMiQY96I584WwhjclK/zLgoxfY691p2XtHTN2zWZ/abxjNKqKY
	 HnIbwNaXGeXzX3GFJ0bOOGUmOgBcy7ndY3ScDoAjoahWjd8QzbjPXFpPyD8g2Qia8G
	 mrxCWlzHtQzy6wVWC19ksPRJoCAyZ6UgdNMP604+OrMLgKWTG2hR1jdfe+rZVhVsp6
	 fYwsUWfiAxVeg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 20 Sep 2025 16:17:50 -0700
Subject: [PATCH] mei: late_bind: Fix
 -Wincompatible-function-pointer-types-strict
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-drm-xe-fix-wifpts-v1-1-c89b5357c7ba@kernel.org>
X-B4-Tracking: v=1; b=H4sIAB02z2gC/x2MywqAIBAAf0X23IKvoPqV6FC51h4q0agg/Pek4
 zDMvJAoMiXoxAuRLk587AVUJWBex30hZFcYtNS1bLVEFzd8CD0/eLMPZ8K68U5NZI1xFkoXIhX
 7P/sh5w9pLI6lYwAAAA==
X-Change-ID: 20250920-drm-xe-fix-wifpts-58fd1be433d4
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Alexander Usyskin <alexander.usyskin@intel.com>, 
 Anshuman Gupta <anshuman.gupta@intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235; i=nathan@kernel.org;
 h=from:subject:message-id; bh=G/KVEA6ViEWnKvN1kHms/3KktEfZIelB3DdtbCJIg34=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnnzZQm7b9X9GQT44VEbi8DbaWy7E5bhuanT5bycma45
 ArvUVndUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACaS94fhr/xyvfoNTNo366oV
 Hz/h6PrefvTA/40rxTfvES75aho7w5nhf9Ksk96rEr5ElZ0PU1w/MfDNiTjbU+Llf/89s7u3SFz
 EhR8A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with -Wincompatible-function-pointer-types-strict, a
warning designed to catch kernel control flow integrity (kCFI) issues at
build time, there is an instance in the new mei late binding code
originating from the type parameter of mei_lb_push_payload():

  drivers/misc/mei/mei_lb.c:211:18: error: incompatible function pointer types initializing 'int (*)(struct device *, u32, u32, const void *, size_t)' (aka 'int (*)(struct device *, unsigned int, unsigned int, const void *, unsigned long)') with an expression of type 'int (struct device *, enum intel_lb_type, u32, const void *, size_t)' (aka 'int (struct device *, enum intel_lb_type, unsigned int, const void *, unsigned long)') [-Werror,-Wincompatible-function-pointer-types-strict]
    211 |         .push_payload = mei_lb_push_payload,
        |                         ^~~~~~~~~~~~~~~~~~~

While 'unsigned int' and 'enum intel_lb_type' are ABI compatible, hence
no regular warning from -Wincompatible-function-pointer-types, the
mismatch will trigger a kCFI violation when mei_lb_push_payload() is
called indirectly.

Update the type parameter of mei_lb_push_payload() to be 'u32' to match
the prototype in 'struct intel_lb_component_ops', clearing up the
warning and kCFI violation.

Fixes: 741eeabb7c78 ("mei: late_bind: add late binding component driver")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/misc/mei/mei_lb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/mei/mei_lb.c b/drivers/misc/mei/mei_lb.c
index 77686b108d3c..78717ee8ac9a 100644
--- a/drivers/misc/mei/mei_lb.c
+++ b/drivers/misc/mei/mei_lb.c
@@ -134,8 +134,7 @@ static bool mei_lb_check_response(const struct device *dev, ssize_t bytes,
 	return true;
 }
 
-static int mei_lb_push_payload(struct device *dev,
-			       enum intel_lb_type type, u32 flags,
+static int mei_lb_push_payload(struct device *dev, u32 type, u32 flags,
 			       const void *payload, size_t payload_size)
 {
 	struct mei_cl_device *cldev;

---
base-commit: d9b2623319fa20c2206754284291817488329648
change-id: 20250920-drm-xe-fix-wifpts-58fd1be433d4

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


