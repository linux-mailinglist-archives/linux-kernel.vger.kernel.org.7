Return-Path: <linux-kernel+bounces-894166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3417C49655
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832A23AE92E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03643302142;
	Mon, 10 Nov 2025 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je/uGsMX"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED61FF61E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809860; cv=none; b=cwiaXBN3UYEHT5fQulN7ySd7zuZ+D/AtRmJ9MaEBzYj+8ND3Hemjkzi/dB5TFy3ewk3bfFnBfqomZK/QdRf8JeOznwvPK7J4rsDdSA2m5sX3IAHWC7hBJz9LTbQWWRt7qPtSpIgLqc25oqjTjkyJUA8RZ/dwEs/j0XeIWJF7T38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809860; c=relaxed/simple;
	bh=vkvNjPVybqGFg3v5E14aYKJtRBrpQakMnNvHoaFRIzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPcvrG3g01Q500JpNrIPUxWv5csCn5g5lFGLFpk8/LHdjYXiYXMg24WnfMTVE4J0dcxV+PSEYCjhcdilsGi6skpmh5ifz3zxWCOzMcfQxHlbhvoTGKl82A7dlUK0x5gcs/abPE8j+OmSObKnXdfr7+NxbkLwVjXdYc+/GEE0qrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je/uGsMX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b0c3451272so4266028b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762809858; x=1763414658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUVNERqw16/pQTgRG4/ce0IUftN0SrBAkIDEVmIs5X4=;
        b=Je/uGsMXM1Out4uEs8TfJvPktfToQx1pukrcIGjIdwu3SJHRVLmfwqe1vZaYC4WwQe
         Co4mkiYU7bgZHOHr9Jv8G2kGvZ3PPrEmCoFKGoVmqJ7Cw/fVbbzP9XAQ1i5ro5rinUuj
         OALY4wgz2t8XzYskvaraAV00bf4VMErSD6e/uhuDRBqxDeUuBVkuQZ+2mLviFeBa+4mk
         rlxJ4t8IMroDNlQ0pFGUZfVNNcCkloYrmTbjQRo/dYPNwAQWDeC6oUxi4uAVY24I3Ah3
         nURNzJ7tz0dYu7vPgKE4ZPzQUblJEuvwxap8EdLjlF1KjIl8MJ5TgpkWwtR/nx4qk74o
         ID5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762809858; x=1763414658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUVNERqw16/pQTgRG4/ce0IUftN0SrBAkIDEVmIs5X4=;
        b=GWBADggtehUq4sz4xnwmGJBlGE+0DgOQ2s6Y0hq2S9GuwE8hLqYYlQklehJSutr7Dn
         w36ih4vMGLrLUDMdF/0RrAts2yvya6HMFNd23iTJK1zoHKelYpGV4TWpIsYRy29oR2JD
         ij3bBtP6Xx1W7a8mEEss7AMo2eOriq2nL/btZhBG63eJ7oGMtjj/vokwj5s7/5itkhKy
         oq913u+Tuc3Kq9lrVCK4akn8fl7fMvVA+FNXXqQiwCWnFR6CMtjKVfTPXV65/5AWQnM9
         2nfqOUrUvvuI/V2aeB2R0r28pN8oxi7gPvicAyfNFvioa21Hr9FO22ProDrn2rA/Eyw0
         V+Ww==
X-Gm-Message-State: AOJu0YwusHTYdf+Z9N7upnqQcjFWK3r0eHXaS2YUKG62ooggQKVQWgGR
	bxi1jj6+rqxh5EGeLB5Ps0kL4vLa86mRMRu1gr8LrwOhrGI/NewSIQPIARrX+g==
X-Gm-Gg: ASbGnctHBSIKAIKEfxKJWvfI33s4RFxDu1sQfDRIdlsGp0cZNXQhYHcDlTPGNZCFLQq
	+bru0hRNJ62MO+fFOC1FIoRo1CxqRUdyEdEKPE0LKi/QLcVVzJaCtf/YdGqtZmIXaR4UYvmJAJw
	CMl5uAmnWqbijwYu9seRsbbb3aTXiM/FgDjPwcKnRpSCCWJw0txx+MLXcrcQcO9voEGtEGIU40V
	syX+Gv6sRF5VdQzGF1Df+SRLzBoAidYGj1aA3k3puxoHyAKbiipyQeT0BtFeZs2e6nIcVUxDl1s
	Age1LGuLPBKjC8ot3lAAR8bpA81Nk2pYw270PblZFOtvCnn1tnqrHo0kNVAFIWO3hg/P6qttQa1
	xykJj+RlE22U1Kf6QbGWHbVdJHsxljU9MD1fX94WhfXmh/Bk=
X-Google-Smtp-Source: AGHT+IEBwSFpEJ5PiWdhZ1vt/3Zo+QC/f+pxn04UBsFp1nmTAGnq5M61eCG5lQtXT6gN+tSJT3aKPA==
X-Received: by 2002:a05:6a21:50a:b0:342:a261:e2bc with SMTP id adf61e73a8af0-353a0f9d59amr13281347637.10.1762809857834;
        Mon, 10 Nov 2025 13:24:17 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902c9d0d4sm13174657a12.36.2025.11.10.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:24:17 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 1/2] firmware: stratix10-rsu: fix 32-bit compilation
Date: Mon, 10 Nov 2025 13:23:59 -0800
Message-ID: <20251110212400.282952-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110212400.282952-1-rosenp@gmail.com>
References: <20251110212400.282952-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The code uses long which is changes depending on CONFIG settings.
However, these longs should really be 64-bit. Fixes at least the
following errors:

drivers/firmware/stratix10-rsu.c: In function ‘rsu_get_spt_callback’:
drivers/firmware/stratix10-rsu.c:285:28: error: left shift count >=
width of type [-Werror=shift-count-overflow]
  285 |         priv->spt0_address <<= 32;
      |                            ^~~
drivers/firmware/stratix10-rsu.c:289:28: error: left shift count >=
width of type [-Werror=shift-count-overflow]
  289 |         priv->spt1_address <<= 32;
      |                            ^~~
In file included from <command-line>:
drivers/firmware/stratix10-rsu.c: In function ‘rsu_status_callback’:
././include/linux/compiler_types.h:597:45: error: call to
‘__compiletime_assert_377’ declared with attribute error: FIELD_GET:
type of reg too small for mask
  597 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:578:25: note: in definition of
macro ‘__compiletime_assert’
  578 |                         prefix ## suffix();
         \
      |                         ^~~~~~
././include/linux/compiler_types.h:597:9: note: in expansion of macro
‘_compiletime_assert’
  597 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro
‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:72:17: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask,
_mask) >     \
      |                 ^~~~~~~~~~~~~~~~
./include/linux/bitfield.h:155:17: note: in expansion of macro
‘__BF_FIELD_CHECK’
  155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET:
");       \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/stratix10-rsu.c:122:40: note: in expansion of macro ‘FIELD_GET’
  122 |                 priv->status.version = FIELD_GET(RSU_VERSION_MASK,
      |                                        ^~~~~~~~~

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/firmware/stratix10-rsu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index 1ea39a0a76c7..2b8ad04679f7 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -97,8 +97,8 @@ struct stratix10_rsu_priv {
 	unsigned int retry_counter;
 	unsigned int max_retry;
 
-	unsigned long spt0_address;
-	unsigned long spt1_address;
+	u64	     spt0_address;
+	u64	     spt1_address;
 
 	unsigned int *get_spt_response_buf;
 };
@@ -120,14 +120,14 @@ static void rsu_status_callback(struct stratix10_svc_client *client,
 
 	if (data->status == BIT(SVC_STATUS_OK)) {
 		priv->status.version = FIELD_GET(RSU_VERSION_MASK,
-						 res->a2);
+						 (u64) res->a2);
 		priv->status.state = FIELD_GET(RSU_STATE_MASK, res->a2);
 		priv->status.fail_image = res->a1;
 		priv->status.current_image = res->a0;
 		priv->status.error_location =
 			FIELD_GET(RSU_ERROR_LOCATION_MASK, res->a3);
 		priv->status.error_details =
-			FIELD_GET(RSU_ERROR_DETAIL_MASK, res->a3);
+			FIELD_GET(RSU_ERROR_DETAIL_MASK, (u64) res->a3);
 	} else {
 		dev_err(client->dev, "COMMAND_RSU_STATUS returned 0x%lX\n",
 			res->a0);
@@ -632,7 +632,7 @@ static ssize_t spt0_address_show(struct device *dev,
 	if (priv->spt0_address == INVALID_SPT_ADDRESS)
 		return -EIO;
 
-	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_address);
+	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n", priv->spt0_address);
 }
 
 static ssize_t spt1_address_show(struct device *dev,
@@ -646,7 +646,7 @@ static ssize_t spt1_address_show(struct device *dev,
 	if (priv->spt1_address == INVALID_SPT_ADDRESS)
 		return -EIO;
 
-	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_address);
+	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n", priv->spt1_address);
 }
 
 static DEVICE_ATTR_RO(current_image);
-- 
2.51.2


