Return-Path: <linux-kernel+bounces-866856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EC1C00CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8741A62500
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181E530E0DC;
	Thu, 23 Oct 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vGBqCB4c"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F3130CD8D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219616; cv=none; b=qzUPjBZmc0U1mrKrHLVYMVPDopXY1rIpFVBFYztGPD7nRx9Hop4fi1EEzn7vCkO+5b1JnU1aDGb3kkHmAxuf0fqhYT0p2qlf7Zgl0ZlUyuTsoVw3PfgeN2nPwUoE1oFbgY2/Roa4vb0RSvkD81pk01K02vvDtkw14vMeHO3uPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219616; c=relaxed/simple;
	bh=mOdQL1gEA0sDveYqZF59jTdhyi6R3BOt3m/pryB1k8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IocfXi2+oqM6nMbn8GDxvs782yNX4MwLDlNVVOlko19tbppLfNqSUIAVUSEAhvyd01OkOPFm+JZQUhp5HXEXZz98xU4BPYC7nDJPp0TdH8oFl9gAcf5qUywMm1A94zsranGFaMD4mt+BssAL0rQOqrsrGXAo/ql2SaXGsB9V3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=vGBqCB4c; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d2ef066c7so144727466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219613; x=1761824413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqaZdRm6596hrpgIfe4f6IaRd+GA1qO846EqRJ45Rvc=;
        b=vGBqCB4ccxWyVAU3pZzCslMMgzZotbTA9BO6VYQRdn5sss0Axnv3ofhXPjWYRRPSlF
         rtapqclTI/KdsyLuRnQFnuRDODVHFj9FOX1mcrn+jnAqTUzh7Fi4pA/aCDmbKKp7s3CF
         zjUSpB3H5ETKlZGpTl6NJJ3zj3zjaYluphscVpKTV0lwPTkAshYauQxbcVJAjqB3w1Gz
         K50xnFeRR1pBmaIrlP13JIGWCdg6WdOIjGva0xhBh4nC4FhF/tYZvgWv3AMZtDAro9vy
         tUSrvmphEVqIFf6fREqb71fLbfCGg0xWyGxvACb4FqszlwPpxLR0D/Vyqlyb1e5ADOf4
         4KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219613; x=1761824413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqaZdRm6596hrpgIfe4f6IaRd+GA1qO846EqRJ45Rvc=;
        b=V9jDJAyy6LOhgjwb7y9iUBkgos+oF3t03A9XM1toiliRiV/XZ/bSgY3zTSKPmbZBuH
         97ws/pRxBJJ5CPIkhGD8SCl9aHAtwniaHhdhzH9+CjejgZ8c5bRMHpJUIvmLy5bJkuIz
         OUxxxEUolE78lHgGovgvJrPp7GGRHDIzC/D4Oqf21lVMBwPthqOCdyzr2ebLpcmYFx4P
         /2aoie9RXNvzIZc2JVVVR/K+1ZLX2c6ynD38JGRjDGyKq0C2RL87RubvzLj9GFTElJPl
         Mde23C29AqD6Wb+Wr6MHtHhxaKvxAgwrw/LlCGUnj4msaCRY3VlBEbG8FF56C7lG4fWL
         zijQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7T/kK3yMWT31za84WA75ZA/wYcXAPR9SkRtz3Xgw1x+b6cwhexUwgIMEU95zrI1LiJ+6hDWlIHUgqZvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UNUemHP3NlRnWFEqrAuJPQZhi9CC/KJ8mF6hfi7Ix6ZLH0ho
	iXgg+U6nTrpBZ2PqIxSCJIne2k9YhJqubo/2+0AWUzVYbMUhqvvNUboKo5Kbs1qphas=
X-Gm-Gg: ASbGnctaxH/esRKxW2+yxvvRDeLCJoOIQ+VV7iOtD/E0TP0LixUih/i3ec0Y3m6en7Q
	3cN8mV7dDC2caaaXmuBjg/zl1MeWwkIol9XDVeNCQ1LNKL/T8Mq1vf0r2WQL4w3JZZpFfnJyu4g
	NWIV7HhBjI7t8nsAvd1B4Vf5odqPKb5rS4e3ydaW6e5epO3nYvhvX7M/Btla03J5HXJ3i2yElBy
	v9Z57KVEb41qdFPogSKeI61OV7KC0/sAvvwlLDOQpLv/f9IYhkA8WPBg+a5yaEQs4UI8cKQuYaO
	3qpHhVnECFPaeEA9tA8TQXVUC8ZekmZQeYjPFYCs6pPI/Bt2IuebKLMUhDW0Sa9JfS7rZfwPXuf
	4Zua0EnQ+vpu+PceSJXqlQERKfK8S07/R0CHKfbFRey1PoFCTgD0M/zRUYQn39wgz8O2CbzxdXM
	adkYLfxPg8Wyp3p+BLXO9z87IYdL9U3rHMwUgEW2gOESgB0Q==
X-Google-Smtp-Source: AGHT+IH3p84PJmGwvI2f01P7O38tZI9K0OwbqpVO9/74/g6JJiwjHN+D0EAPynMe39kBO0m67vhIJA==
X-Received: by 2002:a17:906:fd87:b0:b2b:63a9:223b with SMTP id a640c23a62f3a-b6474b365eamr3224940566b.31.1761219612666;
        Thu, 23 Oct 2025 04:40:12 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144cfbcsm192518066b.56.2025.10.23.04.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:40:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 23 Oct 2025 13:39:26 +0200
Subject: [PATCH v3 1/3] arm64: dts: qcom: sm6350: Fix wrong order of
 freq-table-hz for UFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sm6350-ufs-things-v3-1-b68b74e29d35@fairphone.com>
References: <20251023-sm6350-ufs-things-v3-0-b68b74e29d35@fairphone.com>
In-Reply-To: <20251023-sm6350-ufs-things-v3-0-b68b74e29d35@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, stable@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219609; l=1104;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=mOdQL1gEA0sDveYqZF59jTdhyi6R3BOt3m/pryB1k8s=;
 b=NCjA1CK8e9d0aUeCy3cGdfqVTHyko0drrGnsVMBqRTZVSMlkuM4GnexZJZlNUg0ij/Nsv9VFw
 SauSJBL7lv3BIvn7xnvQ7AhQfeGtgraNKQviqsTWHgSqoGVmyMBsfkV
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

During upstreaming the order of clocks was adjusted to match the
upstream sort order, but mistakently freq-table-hz wasn't re-ordered
with the new order.

Fix that by moving the entry for the ICE clk to the last place.

Fixes: 5a814af5fc22 ("arm64: dts: qcom: sm6350: Add UFS nodes")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8459b27cacc7..19a7b9f9ea8b 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1180,11 +1180,11 @@ ufs_mem_hc: ufshc@1d84000 {
 				<0 0>,
 				<0 0>,
 				<37500000 150000000>,
-				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<0 0>;
+				<0 0>,
+				<75000000 300000000>;
 
 			status = "disabled";
 		};

-- 
2.51.1


