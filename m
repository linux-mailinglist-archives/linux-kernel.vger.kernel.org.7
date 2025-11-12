Return-Path: <linux-kernel+bounces-896581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161F8C50B70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E30D3B6047
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CB92E0914;
	Wed, 12 Nov 2025 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIqQrXau"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94672DC788
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929054; cv=none; b=qokqkQmoohbhE/QrnAbllKTKpR411ME0kwTvVNRP5WjF9yaMfVIovMwQiXFKcnNgbCOc3OiJc43Gu2LO3ErgHs7qtHunLiwkO4aj3XwjO65B38rv0KCUmdC4DxkmCzxl5JEE2jdLCYz1AOhTCsiYQ3Rdp69VtDxaxJuO4WoHuU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929054; c=relaxed/simple;
	bh=oLh37fNMBvRSTT/Izq4Nw7rEP65AlAkKJab0A95Hefk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcqkL/68ZVe/+APTz8mJrqkmsk8qfRS+scw6e9JiAiZzTR5RDmgDBpniQ2f9LKZ2IiD4OD8Dn/fNtdHMXjUhLqou0thPjsLl6fRMR08h4IJ/kFqEchxpkVms+2LVLcBqJJ4Z9Ldh2IzyLAy3F6l4gM8p93r83YI8DCnsH5Vlwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIqQrXau; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed66b5abf7so4685801cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762929051; x=1763533851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s29KJiL0dIDqEwZ/mOdrOpcbRu0p975bFNSNkFE8iHw=;
        b=gIqQrXauSXEMFsLTBJ178UxLhTDukxgewQVYTqAgrsz48HUdZEA27ehe3d5ApUSE4V
         HKh+CjIPwcil9zUudQg6ap5YQQQUak0fpgTB+2a4hMRF/DsldlztkyPRwdtvSseS5Nnz
         zIST4g1n6KxvelXIWesEcT/1H7tD4nKtJSlOhEE9S5Cqfzfh6KKyoO7MJvphZn7oyyOV
         /qyq2iy8a2KqPEmrUoUMG2u8qBeCyZxx978voi/SKdwbFeUxn2ZOB6cO+kEha2AghrgA
         g5zt2PvpFzn2TID4I3wKGiGZbqYqeVza2xDPS3YOIAbPLPHHV++4HJZmeeQY0qUpqKFM
         Wduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762929051; x=1763533851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s29KJiL0dIDqEwZ/mOdrOpcbRu0p975bFNSNkFE8iHw=;
        b=QVenetxfMnrO1jaONzfvsAZYrw9nkpIpLIj8HTG2G1t0h4CwGOoJvhYsqnofWKRtZQ
         /E2/4bA7tUwUAXt03vG3/KTNkGfnpInNUTjiM+2p3FzeYYRaIsTv332w8fvl3mCKRHR2
         mn4OH2re0Wt88bpKWoXh/mttoAQ40v5tW8TYJ4ot9eIrhYRCQAo0aEBiBu5YBFo+f9Ma
         ipUOZ8TZoBUrbDDBYv6SvnQc46kL1Gpkvq5aTEQY/enSrSe46sXaPwZX+4baKlb5jx2+
         s+Rjlq/t59hSON/sOrJOiG52wMMMiDBKUR0X97zeIRyg7dGzAE6p0mSlNCnSTacA2icf
         AxTA==
X-Gm-Message-State: AOJu0Yzq8R5jV1YM+tqEs27S0LF05wcvWWEOoCDlwIL4DQ5dSxeT7BbJ
	qU9DN+8aKyND9AYSVL37WRpwXUrcjpRyJNrMF/OHx7v3N3WKUpdHcTYmrr7vAw==
X-Gm-Gg: ASbGncvTz0cnF/ObdHjjZr7As8TWrM42uCUuXAomQE3a15fIHyIWfAUx4YPhGwW1kdo
	4x0jYmfh0rUbHU8E3Bg/xfoPPabghDxOve+zQKNOGJqNJyq9pOskzYOclKMtnJoUce0JyK2cA1z
	6NmTYwjVY2AnCU/MmhQ8gioTkRVFuE4DgjKjFy1TDSoPXDPc4q+NYH98N2A702rBr9Stsyeu2xF
	9NkthLiuTLxJW2Mvu71Pu/5ZQWnotuBZmrdwWs3QsiiEw8YL++ks1sVqt/B8+yoemILR6I5HBWd
	YHiWbWT/xBfJi8hhVXlxaICGLV4Qn9J4yryIIbf1+v6usbXWlY95rPqnTo5Qp6Y+LCNyL4EsCQP
	3E0+6XIs9Y80rALXcGntkXzTOkyI2nkdMoRGfYd1zZ1tg2/I=
X-Google-Smtp-Source: AGHT+IE2GtzNWDR84UQ+oEabQsHZ5xtkIlB2j/5UjctWpPj1KnR23pCWoeuh0ZpX/eBDJQNsG9+T6Q==
X-Received: by 2002:a05:622a:14ca:b0:4ed:a8e0:13c2 with SMTP id d75a77b69052e-4edcaaca2e0mr67522811cf.10.1762929051582;
        Tue, 11 Nov 2025 22:30:51 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882638344cesm24932036d6.42.2025.11.11.22.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:30:50 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCHv2 2/2] firmware: stratix10-rsu: add COMPILE_TEST support
Date: Tue, 11 Nov 2025 22:30:33 -0800
Message-ID: <20251112063033.176276-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251112063033.176276-1-rosenp@gmail.com>
References: <20251112063033.176276-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helps the buildbots catch potential issues.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..431f1c782158 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -141,7 +141,7 @@ config FW_CFG_SYSFS_CMDLINE
 
 config INTEL_STRATIX10_SERVICE
 	tristate "Intel Stratix10 Service Layer"
-	depends on ARCH_INTEL_SOCFPGA && ARM64 && HAVE_ARM_SMCCC
+	depends on (ARCH_INTEL_SOCFPGA && ARM64 && HAVE_ARM_SMCCC) || COMPILE_TEST
 	default n
 	help
 	  Intel Stratix10 service layer runs at privileged exception level,
-- 
2.51.2


