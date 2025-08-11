Return-Path: <linux-kernel+bounces-762234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C015B203D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4983B20E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD32DF3D1;
	Mon, 11 Aug 2025 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1+Db/9x"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C932BF3E0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904771; cv=none; b=tnfyJg5FlwuXykatCr5k0ROA33TXJbJQlD/OlBpi84fBCHZIrW3Fxy8V3+zSVhbcf3PiZ8r/uyVlu2xonoaahnOSUAWDTAjPYqiiVege1dpM5fKaQYCWd8z9TATTVUOomAnq8KP+8olbuphQxCKgMPV9DE8GHiIO6CQN455G4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904771; c=relaxed/simple;
	bh=o8uIpvdm8rS/o+S1mykUYGGLHkWfPhCsX3cg0yw1X58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzDIH5ROt8PkSszNiTqmCXwAG11fXiUQjXM/BxVCridGJbsLl7POaUGXV3AN8U8aYj5V+t0G/le2FP0dkD45ArjjullOE3cRdcHZg12nsFACKo0bGzsavnByeSKHl0RTiC/GBtqDSNbgeWu7gJbCQN2kObgKvJ4LurQYsEM3mrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1+Db/9x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso25656855e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754904766; x=1755509566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S28JNZPWK+3sAmARH83rSsyGla0uTsZRncPjJTp9toA=;
        b=l1+Db/9xG7MHbrXegbBRTEwdSYzS59sxv21Cik8GWAbImQn4MZ4UAm5FNjQzKdbc2Q
         1QeFmuEwWLKk7IviqZq3PU63dFt97pahZrznp39RbZvnojyTbFjGarDPsjwreh1cvkEk
         Fa+Uq9QnMb6RBnXkuN02q83aXgl3KEhzcPWYCDys5p58orENTARKWat9Ux/cbCsEl0Bd
         tEfcArtd3dQZF0P2dWyY8fQj22t9i6KfSwA4UznMG0F6KPMOvGDaFKEgJ7eLmD8y+5b2
         uCKPYthgmE2I3mMbcchffRnZRVeYlqzm1g1RP2dzyikgej9S5vj2azpZ6qO96ASL+9LG
         q9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904766; x=1755509566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S28JNZPWK+3sAmARH83rSsyGla0uTsZRncPjJTp9toA=;
        b=Kiz7mbzaWn+l6iVXbBOQNHdOSfN3g79P/w/pAClQs9aTGz9jQV4JpwtL0C86cUkmUH
         0l9bzvK0CVHaQJTKtnD0dMtQeuUzLINhdiAUWSUyVaCn5Pe+/HZebEKS0JlNPFCVZldI
         jUKAzXSXOzmGhKPJNRA8W8N8mxEzoqSLATCaUBuQfxT66h1ZjjhOMUjVhjQyFExQ/yxA
         5j8aURAVogBo5/RYKldgRXKVo6x7P6cM4NRsMkeaH6zL5CeKXd6FDB7YOil4+5i91YLu
         pEdbjnnEcdFLUE1EbDoCy+dTTOKef0lRCxJs21lzWySuB4XKI5Xj1qO8MqMrCDu20q70
         n6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIRPC+t9FjKojryUVHzkd3QUNSS4HhUF+ICiLi3yzG01vQngFZeoqkqdZwn1Sg7RWeSo1ePl3/dRo6c9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKqlQ8JdiG4gpUFKRrq/9T9TtFN2fgypEZZdep4QkmiWKPkEy
	jk5azWuBtr74WEgOtAsxa78ExLtFJ3MuDQQS5dGbr1zjJtO/cuVjw3w+GBWGqNp/jIe/IKgLILF
	/9UahrCw=
X-Gm-Gg: ASbGncv9FH73yJY61R+ipC6Ai2h59IVRdL4F/eEIUAJmB5IS7YGIQ9UlpJvfxdGmKyv
	6JPjXhv96TYb/DjxPx3/DiFxwuMDhKWoQzt4wwko0BPlHFmaPtzy6xudEIF12/fWPazFDQHj42C
	HZ6XCUmzH3DMsiEcAeUnbHm/ilUafyS0VSh6AwiFHMyIt6Mj/rHOfucgSk2sLE2mYrq2D93OV1r
	Vr1yUjOnat7RAXfqXRHczS9rY+k0R+tXg730gFu9snBJ3e1l6TIppo/A3GDq9+V02Wsc9UWWxEl
	J2lu8th+acCGoqcKB4WtT1GmzmHGq4R3e2gMSGhLGDGa8bKaDU6pHVbSVNqaWPv4syWK6aBonmj
	w7hnU8g0MIOJfYwyQS5XGNOKwx7FUnmI=
X-Google-Smtp-Source: AGHT+IFaTuEhnneSdqUPVkp8FKoh0YP1/7nEOnYDv0UVx8tWLL1thpj3XGM6kh71NmUAd49x6WzJSg==
X-Received: by 2002:a05:600c:4509:b0:456:496:2100 with SMTP id 5b1f17b1804b1-459f4f2bac3mr129344465e9.31.1754904766361;
        Mon, 11 Aug 2025 02:32:46 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm39904799f8f.39.2025.08.11.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:32:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 11 Aug 2025 10:32:11 +0100
Subject: [PATCH 6/6] coresight: docs: Document etm4x ts_interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-james-cs-syncfreq-v1-6-b001cd6e3404@linaro.org>
References: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org>
In-Reply-To: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Document how the new field is used, maximum value and the interaction
with SYNC timestamps.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/trace/coresight/coresight.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index 806699871b80..0cd83119b83f 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -619,6 +619,20 @@ They are also listed in the folder /sys/bus/event_source/devices/cs_etm/format/
      - Cycle count threshold value. If nothing is provided here or the provided value is 0, then the
        default value i.e 0x100 will be used. If provided value is less than minimum cycles threshold
        value, as indicated via TRCIDR3.CCITMIN, then the minimum value will be used instead.
+   * - ts_level
+     - Controls frequency of timestamps. The reload value of the
+       timestamp counter is 2 raised to the power of this value. If the value is
+       0 then the reload value is 1, if the value is 10 then the reload value is
+       1024. Maximum allowed value is 15, and setting the maximum disables
+       generation of timestamps via the counter, freeing the counter resources.
+       Timestamps will be generated after 2 ^ ts_level cycles.
+
+       Separately to this value, timestamps will also be emitted when a SYNC
+       packet is generated, although this is only for every 4096 bytes of trace.
+       Therefore it's not possible to generate timestamps less frequently than
+       that and ts_level timestamps are always in addition to SYNC timestamps.
+       Timestamps must be enabled for this to have effect.
+
 
 How to use the STM module
 -------------------------

-- 
2.34.1


