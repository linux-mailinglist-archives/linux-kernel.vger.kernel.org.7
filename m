Return-Path: <linux-kernel+bounces-841503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA321BB78A8
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 870EC4EB104
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CFE2C11E4;
	Fri,  3 Oct 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDBdF+Bm"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A12C08D7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508838; cv=none; b=bNCoo4rxN8xjdPppLwEPM76f5TZSlGoJ63ft2Mv4Ibsj+pl3I5AD7tbTkqXxDFiHxbGgQU0Tb07PsMMEFfPD0dRD2euPxwjcgAQcvMQ30ANtcCBRPXZKD4CZyCI/MBzxiX7BQHtRXT0OsNx1Z9D1q9fzEGCcofRLhO2Z84KcNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508838; c=relaxed/simple;
	bh=A0seJZUqD56+LqaPGls9QqXRtY97r8c7RYbr7Ueh1kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZ675X9Mk2vm3KOMwfl2DLyH8MZAQf7EJnhWdUU9je8UIvgZwFEy+oPwHd9BxmXXKIbXPey3k69dxFY3W9oRWONIEB8ywv0XKVEHmWgfq1S0FcQ2mQXcNWnc7nFDNVkK9CuGwFWjf07lUQ0UZI3PUFX7qnBpBMD/gaLggqc36CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDBdF+Bm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2697899a202so24736075ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759508836; x=1760113636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CU1ubv9QFqhwCX/UJW2MkuGJ8oe42GWkgn/905N8tto=;
        b=VDBdF+BmhpAWPAZJ7jIgcxdRnOIxwHmpfmWYxD5+iQvrBm2BiLg9I16IMfwec0URsN
         5fvlJjUsNOogjj42AyW424lW6OiQc5YbgRpXPqXE1LQ/roYtF5yvqoUfrxOJkbXpHFaN
         YhVHj1rmDCJPUGaV3I7rrQsC4CUTrd1U7IOaMFQX4+n148Mwkg8onieDgp0VuuHw8Msm
         kkN90NoyoFi+I2WsZeb2qnS0QsL/YeCGbaeCb4YyxjqnmRp1ax3kuFDb5D5UXQYYBw+S
         OFqBQY0jB4aV+il3OLzUeeWZ4+auX8gO4ImBmR81hJzvrBbA09x6udDKAUavDHTvi3ul
         EH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508836; x=1760113636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CU1ubv9QFqhwCX/UJW2MkuGJ8oe42GWkgn/905N8tto=;
        b=F7vgUjSZdJkXoQGbYRKt4V9VlTqerD8LzH/qq8bLgBomyutJYCrX18bxfIrdUoZ7IP
         eN/n3ZwSryh8wyIUmlpl9PohdCd3zIt/X0GCYGSWiiwEkSv3TW/BQHxoKi9xDQ7hQvzk
         DK3yQtqdFfwp2xkXZWSp98jkxQyliafS+Y6dMEFBuLXtTcHtwz5Po4TKPUKpjGJYv9KY
         Wnvhrr93dHIig4svvmElG2xTA58j3QoXKklrgXNLiBWHz6jHnr8NrnZX0JeBqsngg3Ao
         HTwU5v4dJcJW+i2gLNmyhHpBODsEybAJy5VmYiR4+kYxmWpoemzEAcRFGuAoLNiIp4F8
         d1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmZb6TB+lEZmgrf+W2Y2OZKtsrrLHCkRjknwcCz05l9czlxpM1r8h1LeDxo8H55A9QAInB6GfHwoYQfic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEezmRDd1a+8ij3vLW1hOoJnh7ZNpwfmTmQi3272ygt2se3f1
	Y/GVLX+S8h5NUFD30fPjGVozwvJI25zx8oZt7jRVEM4PtgYLXNe1MokM
X-Gm-Gg: ASbGnctGPWXYuqoZm244FJpHaJxUjdgg+yCFphwUhbr+TxbwDaDeLqB0ws0p8FpEfPD
	EGh6iakVls+Mx7S4fevoy2gnglTtsD+j0C2zUDzhvKblT2VwxpBXv1YzbwxhUEFV9NXUO8uz5me
	qkXg5BQDfmXr35g9lbgbU3tXaf/VqZ+JCmz16Zt0qMJ9PQFS4wvlBlNqVSxl3gytccZyQXmdSdI
	iLu1llS+KveuU/TliLp0P+iHN8v0XtvkIVC3Nb23U0o8jV0bxUmptBV0oDiekbqXRLY16HX2Pv5
	EIwGxoFAoRokZr00cFhIcuVYJaA/ZvofXd2LBmkM9+/b3g1pdcRjTaFSxecwIJEgtgVYA4pn5bf
	Z9WYnm80X72Z586XTRq7qPA1pEF12jy4CPg3Rq1ghMdIbD+8nXvvCrJKWNne/DSMTM9zj3H/pLn
	Iu+PVrpXva1Mg=
X-Google-Smtp-Source: AGHT+IE6rDopDalQuanfI6ZfiLOsAMLpprtvoctAcjUSyZ5ja4KsaqHXynMClqHNTWE1f02Amnq3hQ==
X-Received: by 2002:a17:903:1249:b0:265:e815:fcdf with SMTP id d9443c01a7336-28e8d0a1a55mr93324495ad.17.1759508836311;
        Fri, 03 Oct 2025 09:27:16 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff0dddsm8416787a91.18.2025.10.03.09.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:27:15 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: 2023002089@link.tyut.edu.cn,
	corbet@lwn.net,
	rafael.j.wysocki@intel.com,
	superm1@kernel.org,
	viresh.kumar@linaro.org,
	qyousef@layalina.io,
	zhanjie9@hisilicon.com
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH 1/2] docs/zh_CN: Fix malformed table
Date: Fri,  3 Oct 2025 21:56:10 +0530
Message-ID: <20251003162626.6737-2-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003162626.6737-1-krishnagopi487@gmail.com>
References: <20251003162626.6737-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Running "make htmldocs" generates the following build error
in zh_CN/cpu-freq/cpu-drivers.rst:

Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst:109: ERROR: Malformed table.

Fix the table formatting to resolve the error.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
index 8238f4c6e4f5..2d5e84d8e58d 100644
--- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
@@ -112,7 +112,7 @@ CPUfreq核心层注册一个cpufreq_driver结构体。
 |                                   |                                      |
 +-----------------------------------+--------------------------------------+
 |policy->cpuinfo.transition_latency | CPU在两个频率之间切换所需的时间，以  |
-|                                   | 纳秒为单位                    |
+|                                   | 纳秒为单位                           |
 |                                   |                                      |
 +-----------------------------------+--------------------------------------+
 |policy->cur                        | 该CPU当前的工作频率(如适用)          |
-- 
2.43.0


