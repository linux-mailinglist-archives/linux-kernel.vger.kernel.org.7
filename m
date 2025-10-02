Return-Path: <linux-kernel+bounces-840111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2472BB3908
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825631921348
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989530AACA;
	Thu,  2 Oct 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDVYz6yM"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DB3093B6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399805; cv=none; b=tpNQYGgJYISl5QL3tJUitPjz801hq0VLuR0+hy94/B5RA0eSS4Ftr2VmZBNc4x+mOenWw0xShmy2eDnx/J7KiaQ64mykztGixvCsFKm3T5k4q1MpS+eL/FNt6t5+tJoF5gW8FE5uCJl8gsr5fL/vrluIrpxulSeZZdHaJNdivkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399805; c=relaxed/simple;
	bh=o8uIpvdm8rS/o+S1mykUYGGLHkWfPhCsX3cg0yw1X58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7yDC2IT2m/YjSuikckb0ehmW/cAX2xn7TZE0dXdsIvwBoeAysad1fpUsERGTAB4Ggw6lXkmT01t2jK8+vnUZA4ts+pqixS1+b2DgHrCRO4Rxjd+7o5J3+WhzrtK7XWVZZWeBIgQ8A3xrjBIZlqBUsX+ah4pvafOukjWXE6rKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZDVYz6yM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so723031f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759399800; x=1760004600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S28JNZPWK+3sAmARH83rSsyGla0uTsZRncPjJTp9toA=;
        b=ZDVYz6yMmRu6882C7YCgncuxHZK1w/wzCMXkNq+Wbp9p5lV78PDRPvJpAfKCFarqLg
         uJD09CeMZnKKzKQwRB3Y0qmS/Akysi9xtoIsZLjmGmcMM0nmq5bF31NW10/kII/BA+vk
         c6jxGdDosYJfAzAdgmJYuw+NhzY6voZTi4zEYIlAzCxz4rUPxrAlZX+z6wQBmNAsGLLY
         kaP52H7M28Qv/8vHWomuuTAw9h4PZc+ipoSRDe1VAwpfql3gkNzgLRoAZfbCMZ0UuUYy
         446R1+oKPitoNe5dHo3m1AlYd1SyIBdE+7+Rnw/ZWqQcuZ+7U79u2KxLoCRipforqW12
         I6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399800; x=1760004600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S28JNZPWK+3sAmARH83rSsyGla0uTsZRncPjJTp9toA=;
        b=qqdDix2B5tGGc155mqnoKSxHgZtf6CL3gQEvUz197Nv1OLBgYdqzk7TlA3Tt4zL5+V
         RnjQHFnaZtd9CAxJRNvULUgNbTrcgxFUco3R6lg6TrxWW+fEK6ttQWbHui2sEBGgikGK
         N3QFjbkbXE1oKR8mKtSLBPI0zogDw/F5xasfeMXAEO0SmY/KMXuP9uQ9ajXM5a5MTAMx
         qPbJ7E8hzOhW5vZ0/H5wNsk0J+k0hsrEPRDGF59SufH2W+vDuZSLYc7r+LcBjy+SlfJD
         9+/r+X57yKipyBIT9YhgxDqafpOKlwd2aVmXa6EqulrBIkp9YwsS43vbmfs+3o6LZJB+
         K1EA==
X-Forwarded-Encrypted: i=1; AJvYcCXElqMTyX4YIF1EtGS8l+e69RIxE7jsKR5QylBdFkVa7XtAleEwtcTJsPsE/2Aln9/OMPXRfb8sYeMnMjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTolpTWcVSFecEIa4qvQZjnKSq60rZ5uQ1JbxHz8ruyt4e67Zw
	Mmx19IxaRMMIwntJ4FXsESx6HiqdmnJVLyQ0/BZhqHrqDaF0tr8U1wL6BkVZbTWcyeQ=
X-Gm-Gg: ASbGncva05MDiSMxUh6jqUDRMQxfaxcu1/4vMPLL8Zn8uD+3cNwwqLMj+HfBhAOFqt5
	RHjVZX++olFrEuMVww2TI5CMRESwcJdScuypRUcVmr1DrjxzhhkdKhDscU4nUlviJNdAqsWib25
	Our7WSsuA6SyVRzegJns4v8qqplOmPavTLno32yfoaSJHRR4hrLLkP+x0Bqrlp6KdFDNNe/zrBz
	iDSL5JWERe0SGmox5Uh0dLJPfJTUTkpnGQN6e2daMAjqibJjGtXvEQQkQ32cWraYIm1v3w2waxT
	3F5cAyA7F3K/hW1MClvl0NwRwlaIPGbVepJTnRxoWagfrKKcN5Pt4T0sdb3ihGinzYc3Ie8Ssi3
	DxAh4Z3LWcHK+/UAeO9joZ7vm9eUuikCTCMTOKI04y3xSCQo41KU8DlD/4nHb
X-Google-Smtp-Source: AGHT+IG6HKInp+uRx4lrhBICFNa45XLSFjaTQzHhAm4u0XucfQOV7OmI9NNGmwwxaM0SBXY84aYtrw==
X-Received: by 2002:a05:6000:40cb:b0:3ec:df2b:14c8 with SMTP id ffacd0b85a97d-425577ea4bcmr5328296f8f.20.1759399800449;
        Thu, 02 Oct 2025 03:10:00 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab960sm3017289f8f.13.2025.10.02.03.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:10:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 02 Oct 2025 11:09:33 +0100
Subject: [PATCH v3 5/5] coresight: docs: Document etm4x ts_interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-james-cs-syncfreq-v3-5-fe5df2bf91d1@linaro.org>
References: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org>
In-Reply-To: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org>
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


