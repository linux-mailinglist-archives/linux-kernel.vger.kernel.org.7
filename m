Return-Path: <linux-kernel+bounces-725447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 411CEAFFF41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3544C1C4213F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4192E11B3;
	Thu, 10 Jul 2025 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P96Rwtpj"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61752DC331
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143232; cv=none; b=EvKc7QwKTIwuYhTOtOweb5gxETGxkQkqCQ0Zzqd59JXfUhMBTBbxYEdjsRQ/7D2AY2Q1WNu0S6+8EVVlPXJF1qEDQ/oYVKOFUoarPEdInQoATZLnflt+VS9PzSuzP0/Pb5lYh2N2ozqp6iC/yWWff4KIqjCpvDd4l+IP/KrgHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143232; c=relaxed/simple;
	bh=2ialj3ffNNqXJ+tFyTS7uvxfvmvcjXBiITgVM1cZTTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DonMT2A0qCq4mEjBcsFgeFi7zJHc411wE3iqm5i5TXynBIsTNlkPH1mG02NbRa94ztjw0VPyhcesiIzuuF51qBnqTCGVKRXVKfqOPYT2FBtUSbZA8/+TzHgrvxywm4fvO6l9D0FHGbbEF3pGf/0uHQ6EchTBVw9rFUyqfnLR/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P96Rwtpj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55511c3e203so739726e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752143229; x=1752748029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMrHrwj6C4PnAa1hwUllth+c9S0hJcOtmNg/4I4sqcg=;
        b=P96RwtpjVC25o1Is6n3sltloP8MNpfNpNRrEgUKQ7K/TANl/HiTmPhGxqlZ3Pgvttg
         jkNkOBoVkhsZPw2+MDJzUG1V6qi0c/HoPHut6BLbRwT3lFUwOOwMo/p85EeDX/K2OVrU
         U9D7p9Vd/sCcCzdrmfzKxcWbNYyeUXndIvdqXCD3fb7xe6yVSUqPnjtRFsEsg8Lcb1ER
         pmRgkHjmkWn7/Di8Jk4TO9aMSQ3hE80Kg30YjS8iU4v3RZZzyiJe/6ZdGxFKm8wlCIBM
         yoIdNcCzgJo2UXzzLQeN/VEI/SmWtnJnaCdHDGXBhMbSzsFu1NivKxJsK3UXX8uanyAd
         fyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143229; x=1752748029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMrHrwj6C4PnAa1hwUllth+c9S0hJcOtmNg/4I4sqcg=;
        b=iIhJ7tfwrC6PozRGAKRH0/IvHgWqHVbkAIa0TjFFoVqiDPrB0vRlo/BUF7SMGjKNsC
         4BLIc/nv76AdebnpuT6QyYSOgk3S2j/0TSpzHtFtPC1fP6f2+5e6bdMsVxPHg6A8xxOr
         A8TMu0GnlThvwWDz+6bL0AAP7kC7CpE0O6uDazHK6fmBGCj5tpUf02aHCcjqjtiA7KPm
         /lyAgJZiDsMhuGT8Q7dc2OVO+Of4yDk91IWs5Gs1lUI1t2mW/aS4y/WR115Gefx5hdiZ
         80lLfnItccsggSOtURxMvB+gvGHbmjO/SRmWhUhtD0jx7VMGwYSNvj/WMpXaBgh0bv4K
         47dQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+OjCMu/ED4IWmH8AXJvce388tp985Mpuika8biSAJCI4B3VUwI6xr5H6r8qxg8wRIKeOHrg1miZQjNrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJd2A8I801vPUu/6XS3D+FSvJPsreT1oF4oVdokJ4CMkXYcwUe
	bhqGlPoy8tLUz/C6ZA4UNRZCUFyU/aNgvM8qY4XK0OdOZksTAYb0nW4s3cjVRi5tQ7NPPhBiY2y
	zlTQh
X-Gm-Gg: ASbGnctF4CD4i0IkXMIchHhdBaH5jX+EbmSvJ5MbVs09eJSPng2vy8pcuTmB1Odfm6z
	v1PvqcyaN/1kHxjmQ4pcSuV/i3sx0yM9nwvE3NTCTq4FWqYqwIJ5hKDNHBeIJL0+GqAUWIAkdtW
	IgtTBCkcsSFSp+8jH0DVBN90kL48L7yhYADx1e505bTYwHBpKkV3K0WN7c2nRlgl7LjHzkhla4z
	3PuD25o/kjSfweaTqhzlse5lcXGY9/hbboyt75/dNyuKPrW4Fph2iiEL3uTHfDvBU9NiZvceKRh
	rycLTnUOBYjA2h/XhBfXCxbOLJnzgZJXOx+45k3wy/LLJjMgE8jQmu5AvqW0+vWJkhkAuG1y
X-Google-Smtp-Source: AGHT+IEbwAYT58wBNJO6H6c+k8X2Vy8uQf5jbBswQDcyQ8gT0o6ph/EqrKs9YgCXi1YgCf3JOkjDxA==
X-Received: by 2002:a05:6512:2252:b0:553:341f:12a3 with SMTP id 2adb3069b0e04-55935b358d9mr704060e87.39.1752143228189;
        Thu, 10 Jul 2025 03:27:08 -0700 (PDT)
Received: from uffe-tuxpro14.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d315dsm321144e87.110.2025.07.10.03.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:27:07 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: power: Remove info about non-existing QoS interfaces
Date: Thu, 10 Jul 2025 12:26:56 +0200
Message-ID: <20250710102656.127654-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_latency_qos_add|remove_notifier() doesn't exist, hence let's drop the
documentation of them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/power/pm_qos_interface.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 69b0fe3e2542..5019c79c7710 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -52,13 +52,6 @@ int cpu_latency_qos_request_active(handle):
   Returns if the request is still active, i.e. it has not been removed from the
   CPU latency QoS list.
 
-int cpu_latency_qos_add_notifier(notifier):
-  Adds a notification callback function to the CPU latency QoS. The callback is
-  called when the aggregated value for the CPU latency QoS is changed.
-
-int cpu_latency_qos_remove_notifier(notifier):
-  Removes the notification callback function from the CPU latency QoS.
-
 
 From user space:
 
-- 
2.43.0


