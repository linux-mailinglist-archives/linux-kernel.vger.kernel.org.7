Return-Path: <linux-kernel+bounces-804052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6DB46938
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 07:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DC01D22EB3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BBB281341;
	Sat,  6 Sep 2025 05:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWjjX7MO"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BED27F16A;
	Sat,  6 Sep 2025 05:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757135465; cv=none; b=amxjeUUAs1kRSb2n5TlZXee8+vKrl/TwX1yzo0AXuvtQE6ZjjYBOmJtHx3itK7DCz8Jrugtbkdkn1iAckO5Cbc2mX7+8+2yuBH/Sox70TAaZ5pGmPE8fhXexRXUGJI7LB18OvBCaQro0Mh6C8gkRHjeHQ16KVjRmX8JEHM05TiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757135465; c=relaxed/simple;
	bh=4nntbxd9QhxEvmQibcuTIkC0BAC5Ve0dSQ5OC0TBN9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L67szIcVsXHuJbneHDlswYF+y51bidvF8FfzuYQkH3j4bj9Bg4P8/2MMBaWKIFyriq/LGnR74NWnU5c7dc4WIhkKlIG6oURXQG4KAri+ElIexeQuN1+jCBtSgD2PTvIkP2I7tJTZguMROI9hcKTAnd/kv3kU8dw6sZtCIZYaJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWjjX7MO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b5d3e1762so2162548a91.3;
        Fri, 05 Sep 2025 22:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757135464; x=1757740264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkyhEF1uSyF+/KrhAZe6tTEv+I/fUAI0IzZh62oGhRI=;
        b=IWjjX7MOWjrsgf32S9GCgI2qffbz6faLv6hmURR1EOPWqviO4Z7QAa9Hdb3+IdTxIa
         yRHKyaVKQybIGvUj8rTRrRGjqyLbBiirjMfpWPlcaOCU+3o4HoMail49ZrLJyVUvh/n2
         Gk3UAYwvuY9lt7zySyk8rQNttNhrvklSWqoPZyHwFvrFN/EI6MybbK6d697saQPRn/q+
         KwixJkPRkSzaeyB5xorGDZosG10Udm/wZP0b8BhZ6k3awijkSWvkQExfisVuCPAtp+ZF
         j/m+rhjaHB05O0Va5X16r0WL4Zz2tDEIRshIfXArFjpbv3Z86bWrS3nknyEqXPVw7OsM
         +NKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757135464; x=1757740264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkyhEF1uSyF+/KrhAZe6tTEv+I/fUAI0IzZh62oGhRI=;
        b=B2Dd7iZm9DdaJa8BZ+D3+3nZLRghZhH72rIdVDVk+NY4We6XPTOKb6QpAzBL3eEwOE
         oqzM0MOs1MN4Bg6gJLGzWNsqeP4lsrW5FZOsYrLo1CzGjYrcG2ny6fsq29O9CpVFw/YU
         FLDBcfkdIwWoQd9vuVlxwCRBKADPVnpqyx+JzdikTKNzF5rJb44N/9goxfLCoIjlBx4p
         ooGtULhhmHWOa6vIT7bEZfNn4ZRzLtahhhSLTPLIdrkpt/em/e1BnF1W4yb867r2v15C
         AOTGRKG6zTRg6UtrBxtepDYCFN5FkMnNnwQT7BON86b/rgmJwpySGYZWOkFizq0ejBlM
         1tZw==
X-Forwarded-Encrypted: i=1; AJvYcCU4VEbf8KWYtDNhLdEL01YHGhDp60hQ903MoQf+wzSV0VXSKU79QnYSpv8OZhChoXqxleFo8gGcN+s+@vger.kernel.org, AJvYcCXGl1DpV32hhV6kYUlXOSpx/os0YbfyPekW65RxSrur3EsKONwyCy8uW0+dJx/8HMv5bGiF4PdYo0GJ9xp/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xl75UNZsrsjguUQJ0TZbDf6lA3xq/WyJDcA5PcvU2Zozh272
	mfCRFbjISlpdGYujZrh1mQjRIx7wLqvKwV7TyfLbB822b7QmrOLbuT8C
X-Gm-Gg: ASbGncvoercH+vRcvmaLFvb3HrOCdmoYkczsnrabfEDJvVfCNnRh/r9hTM1BiXpIk4t
	f/WWPDL/wyKmaQ+nskG1LMCqiAgw9rJo/G1r2Hj9dcjVoakfAqpN527xyfMSLGTEYW8zNz00qHC
	THxwXNfJ+gbri9eGxlFrsZHlzwPWCM02n8kxWAzVbm8y095mWn2g9gLNi+a/AZWvd9G53E6p3n5
	IexZWIkFShRCxQqXCTllv0EStgLsXX1JortxtzdcukvGbG5N4uud5SwyqnZUrwJ9TsD8jjutnJQ
	AVUtUhA+5dldDOmeySrCCQw6+fVR2FCnG80QF/KyxktiLtxgHUubukNPLCD5mzxDbzGGt07ppIF
	XEqXl26vfa3I3Gc7kVHe2vWSMBiCopou5a+HPergVm4NlMsZMyVF2kSs1mgmWXTpgWA17
X-Google-Smtp-Source: AGHT+IFq4mQJjK7aXAmsb8vtgpc82tkdzv5y29eghdeUy4RFUZ02sQsFvKl+ceIS8gdWlwBZ9SS80Q==
X-Received: by 2002:a17:90b:17c8:b0:32b:be45:6864 with SMTP id 98e67ed59e1d1-32d43f6da5bmr1345792a91.25.1757135463651;
        Fri, 05 Sep 2025 22:11:03 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d8ca7aa0sm13118020a91.19.2025.09.05.22.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 22:11:03 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: kusogame68@gmail.com,
	pumeining@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	n1136402@ntub.edu.tw,
	good@ntub.edu.tw,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: mfd: nxp,bbnsm: Fix typo in documentation
Date: Sat,  6 Sep 2025 13:10:40 +0800
Message-ID: <20250906051040.22944-4-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250906051040.22944-1-sef1548@gmail.com>
References: <20250906051040.22944-1-sef1548@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling of "Intergrates" -> "integrates" in documentation

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml b/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml
index b1ade64a15..1705812f2d 100644
--- a/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml
+++ b/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   NXP BBNSM serves as non-volatile logic and storage for the system.
-  it Intergrates RTC & ON/OFF control.
+  It integrates RTC & ON/OFF control.
   The RTC can retain its state and continues counting even when the
   main chip is power down. A time alarm is generated once the most
   significant 32 bits of the real-time counter match the value in the
-- 
2.48.1


