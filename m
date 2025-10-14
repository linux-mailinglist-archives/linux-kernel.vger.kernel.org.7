Return-Path: <linux-kernel+bounces-852923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAA4BDA3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A567D50298C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C84301702;
	Tue, 14 Oct 2025 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE29QtUf"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD530148D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454307; cv=none; b=jFyrPCn7QdQNVwNu5yEulptLfgCaW38kY9fh3bHoWzD+Eot3gnl2MOSy3N6NKP6r9zwJeUoxNb7Z0x5uOr01pAP9G7y4wcIlnk3QRt9ISJRNX37fPc7Q8acxAkep/G3N8jURPF/CGfnGKly4GqTXmPSnp/r8SYvbwS8Cpysn1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454307; c=relaxed/simple;
	bh=XiGGX/gYUODKcUIpICueRO0ZWhSBnplWOTrgw4sJMTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1RhMbeinGxbK20Q3G8MLSSUpi9lzcSS+jSU1/d19x2Zf5IkhtYB7fDXSMn99/xa6GGPd27BPgQ4weL9FuAl24Z/v/+3VQ3fVRKqoFHzUAggHOsAh+Sy5ABIEGTj4yWHAnmqxTOeFTsbRUlKNgJ1YWx08lzxh536ySUIaccrgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE29QtUf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4947787b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454306; x=1761059106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsMRt6a+0MtEqKde4YWuihoSzMbsHghVTF7OAbgmvz8=;
        b=BE29QtUfYh6esS518jkriPB4TxAqDWouJ+j9lxtf1ucD+1+HtXy8V7XdaT3hlLrJsA
         i+E5EGHpbQEBIh1I7e0IrdZVZ40RdJR01hZGz58OotV+DVtc1tejojX7Qpky791W0UhD
         MLk2iYfpfUnlN5jaFMoNuu0OOMfOhgB/k5knUYm+RVe/ievHXSvnFZFNoW7c6I+D5cI+
         G6B7F9fHYgAspAvq81HbCkLam9LCY80LgFTgQsF6NsuJDT7+5kcVNMlx0uNFQ6YE6rft
         j+TqfkxGYcmtMdjv1i8nFFPsCp8KaHjV8A0MQpVl4pz+S/o1HCtcq0hxSKrOqpGb/2oF
         fQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454306; x=1761059106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsMRt6a+0MtEqKde4YWuihoSzMbsHghVTF7OAbgmvz8=;
        b=S9VE1Tg8DDqisEhdRBQ8m0n1kQ9/UTDPBKkj+Wgf31h1wQl8uGB9De8n/TuOYA87Vh
         o8NRlsvzD6zuja5l8ZIVbllMdmQzW5ll7/i+fVJV2qd/ZAP92zXsNuYyszDVXiOe+gOz
         OPAhWw1Ts/ebTOmOFhHBLrgtESuugBPH5yazegmeXyOhWizsNH8lWB9J1eYASlVp+a1g
         2JLDAs92izdjYiSO6LZfb5auVjsI4hCa727wFTy5+gnUUinBE76qRwGZQT8AkOYBK6CH
         lP57WhjH/wv140eQko5XeCB8Gax0itCHBJeu2ulhiLHuTo5ZFQr0Q7bhz6vb/xYDrLAw
         37qA==
X-Forwarded-Encrypted: i=1; AJvYcCXnmFYVKHUiSb2mDIV21aDM0fNnnkv6m/+WGoXFw6yNLjjvNTaNkjSkFo9N9KIUm6M6EQrCKpG/Vn/D0cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFH31MNbi96mmfPU3ak+Immi39wm6uR365F+eG8KoIkmc0XHb
	yzfzlZywdKRnUTT7DTE2D/3qMxW1njlhdQHZ9dlszxBs9RTPHTBCuzXh
X-Gm-Gg: ASbGncsVOcv44gOX8Ma+h5nfrw2WaS0fsffw+GysaM7E++Yi5tRnk0zo2iq3rDgoxun
	nkGCgjoSgljPGvHrjmGPN/t3rXtnQAHNV7LsO8szqCyD0BlvW4T01bdlvtbLk26nypP2tN12ruq
	iMiE1F1SSzfzMrVpQllgJ2pVRftjECOqMEi2YrbAVnuRdDnCiLMwMYV9EiGiJrIAktf0qTy8xp0
	b5MAevXAN8TseAkBjB6oZpRVJQHEt6qqfg3jKWusBUAHeCndAyYvva9Vr7Fm0RnJ2BMEa+VVSJS
	wR86kvfRwLrACjx7S6wuwIo2Yt+jwRJV1UadvyY4IXPVD4MjWQBPKCC02PnPrdGU+PMD0WvH4or
	dslzjNT/TugDKRgi6gWsXEmT81zk7N0rv+YuxOCR4GxXp3sihyjnhoA==
X-Google-Smtp-Source: AGHT+IHfYvpkP9qBYR0QxPI4MGOvmRjmBPWouaaIKnO8VsRvsEyRGrUKru6CiIL2ZB5M9rvBGZzptA==
X-Received: by 2002:a05:6a20:7d9d:b0:303:8207:eb51 with SMTP id adf61e73a8af0-32da8462f4bmr34021694637.55.1760454305535;
        Tue, 14 Oct 2025 08:05:05 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:46 +0800
Subject: [PATCH RESEND v8 13/21] arm64: dts: apple: s5l8960x: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-13-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=XiGGX/gYUODKcUIpICueRO0ZWhSBnplWOTrgw4sJMTI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZuP34mQJBCd6DStjvUZPuGtGfYF/188yqem
 GL19LCKE4WJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbgAKCRABygi3psUI
 JBi6EACU9XHCs8g+4Qbt5yLz0F/EmK7cgyB1bpMgI6YWmKeTTXtIGIGFCPumMb5BOwQ2XU/cQhS
 pcNOLz7i0HEv7X/unBThX2PCscxe+9eSw59pvdHe4eEG+BDlHTFbIqZmPTzE2kMNZPLRXAGLdXU
 +UZWuG6HsNZSOknammazcOredp9P7t8+oCxz9X29YuMBXlzN6Tn95qwDmdbVUzuPBC4OvIY5/Jz
 uKigRJS/Jb6WCsRKMKx5v8QWbGRF4MRaBL2ddz8AIM9t73e0KUsnGG201jxuMUnEzPmQsxbngFi
 KdoT97UWsrW+eBqgVzrN/LoBPYcIGqskAcw4TRUmntFDVqi2S/cN3zbS40XpwnU9GNqwr798pgB
 ZYNP/Ay0Y1E2hbQJ4OqT8eEEFklsPT/7nw8hU+ZlcV2/2gIkSlUNN27N5M9fEULSRYK7hTYl3dB
 ft4GbH6QRVusX/oZVtoxaXQbKDJ2kvQw/mabUxusGg1CAsecpBDQYRky+n9DBIKRY+bqKVmWudr
 JrxS1XszQOq3013ZUOxJnDMsSMBtsekgfjST/EAIBJ4MZoI6WbQenxgZjTsIRFx7C7rpC4qazWK
 CFW4RAYAIuIArBchm8OO8dpRHXeuSnnWFezg3vOrr3cSX9TX9asFqC9xiSwxgfOcpG96SSTLWeq
 +9oQspGNJtE4Dtw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A7 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s5l8960x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s5l8960x.dtsi b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
index 5b5175d6978c45052ded495fc0d18ee3a8fbfdcb..1a3a90f7b9ded42e371ef0b41057fd3081579615 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -151,6 +151,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,cyclone-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 178 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 181 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s5l8960x-pmgr.dtsi"

-- 
2.51.0


