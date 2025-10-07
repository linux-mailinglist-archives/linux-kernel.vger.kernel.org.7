Return-Path: <linux-kernel+bounces-844224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362F7BC1563
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE3219A14CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307E2DECA3;
	Tue,  7 Oct 2025 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC0dMdeK"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70735972
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839338; cv=none; b=FUVG0ztFxGBGJddLpLS5L3m89dIaoGxiXZ1fmt2bM9Mq+6TCcGBuKFZGgzjPe5IF9QWaU1nB+mQBJqfwvd3KmvtNrprNh+yduhGFn9I+31D6TjAkoAX6rR7pyPdeoCBK8P/WgQzoNWME/FVdJB9HIPKaJRDcSC28DPqIRcOkDE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839338; c=relaxed/simple;
	bh=WTfNWiSUHE3yzT8NN8B4cyL4njh+KYmZ9d7q1pyxDug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KObhl2iX9mLfH60iokmL+6eWG4p9v1Jm3cPLnghl0LXahhSE7LVOhPCpvDZQmf7fDh7uOCCrclZbgUBP8qNwjf/1O2cJlm2ZcS/jbAT0APbt8UPQ5EqnRBEcAWUIbhVf+O8Q0W7sa2+PpEZ0bF3VtYhp/vODRG9JOoBFCc/cWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC0dMdeK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42421b1514fso2913728f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839335; x=1760444135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euhEJjeobLyj8H5iJ33FXAElxhlSOQw3IhaD7kRk93A=;
        b=KC0dMdeKkdMPtCuP0yAVJKsDK2wsXOF+UQ2yZR881BYhQ+sitWGuEeNg8dsILXfn4Y
         8cuVaw0ASG/t7Z/he8jEvqBu6CjPBV53WrF/cm06ppYyfBNrZ6hBi/kVtrjGIl0fMHFt
         FjSwJknvLfRCNWCYChSTugHHkFJmOpZmcjmn95ENEfMI/ohEWr7NYou5hzGSdGzudP1d
         SuPKtbA/lWrDn0W7ycaEffulNv6nNq9awDEt3fvIAWFiTvVA782hzCfQHIo3ArxGwFQT
         6M5VHIPxdGhars5Wbeiyk/WKaCg8gPAkWEKzBnLwUrar/gFFEhoZz4UF2j5dpzQLdeWk
         4g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839335; x=1760444135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euhEJjeobLyj8H5iJ33FXAElxhlSOQw3IhaD7kRk93A=;
        b=FSqynIYl1ftrdGjj/WEUARU58uvIzDqU2thO9Eu+YR9+SWZJolph25uHBhY5hw/VIP
         rRlFBHsvMPmV/DaPdYgyosd8uYkaLV3aOb0aDweXQ0LBHauWQ6HzFddkIUdHxWqcaSEO
         sNTet0YDRZBYXEf/NMJYbHuek+KKikbx1PiNW0i39LZ8vJWO86GGh0AMVowo010jaNkh
         SCOzj26sDrx9L0VfFXf+j9IKxGvCq7OpBkG5ZIycAJEd9ew3cMwS90kC2u1Jj1wHnVUE
         JLKSZa0ZOJ50Sawo8cclD3kZeqJXZ2te+ljjb28glviLSjUaNiFb+KU/NgyXQDELkTIA
         e99g==
X-Forwarded-Encrypted: i=1; AJvYcCVVgvY1yyyPdDM5r6y3l18jwTZ5cuBdjKgkaK3ZqNc0bZ/JGqtc9HMnD2PM5WEVVusLwylAPF+fINqyPQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcgSNT6ePfIrHCOEwgV3FJFewuDzl4NWljRNICRTo4ATk1g3iS
	svcYFuK7dZRAF397xgLJi6izFY9GCNfwg3XUjVAg7WgQOVfmlyV16YOV
X-Gm-Gg: ASbGncvk2urc4zLMdSkomjeE+YS8nGbpksYDsUmJao1QKC2Y03084f9HUl02pejFSyK
	MyPHmshKI8M5jgHq5ciATEnSuWAvO0Y7Nbi5MH7RKyXULuGN+ttdtxR2T1SE7uirWcRHfbk0k7q
	EYPjpYoAvIOdiCpGcRrzBVMFgx1NqQPIKRLpMVMAYbBEbTv6qHBpOH6WSKeXwAubqwrcK8ZpJrN
	Wor8SxtdqwaiICbzX6bQZV/SmEFjejWLZbnBcWlgrulU7sKP5/a4PnFuN5+f7UgOEXM4y5l579j
	nUkjkmXfrVmkMhStnTVA6K8VRNWhEkZrfTEHjbRqWoQLB7sCz9o4va5Bvofxg9Rd4UHJBR2EywI
	Gz5MYgGjkA1B7DWpaxK5bDsjz80H3WPCIo8jHv+7aoZIWmkjMRVyiS5AMOrlndaDsM3HVaJN822
	b4VU85
X-Google-Smtp-Source: AGHT+IEWjOayRTPZVPnsMccxbWYDGiMC1YfpjgyiCNEpc7Zo759zR8e/RAlhpAfbAmZEfuj9Nojr1g==
X-Received: by 2002:a05:6000:4029:b0:3e4:b44d:c586 with SMTP id ffacd0b85a97d-4256719e10dmr8954404f8f.34.1759839335308;
        Tue, 07 Oct 2025 05:15:35 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:9667:4f0f:586a:20c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6e1bsm25590167f8f.8.2025.10.07.05.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:15:34 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/4] arm64: dts: renesas: r9a09g056: Add Cortex-A55 PMU node
Date: Tue,  7 Oct 2025 13:15:06 +0100
Message-ID: <20251007121508.1595889-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007121508.1595889-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251007121508.1595889-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable the performance monitor unit for the Cortex-A55 cores on the
RZ/V2N (R9A09G056) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index 9d540aa4d10b..8781c2fa7313 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -153,6 +153,11 @@ opp-19687500 {
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
-- 
2.51.0


