Return-Path: <linux-kernel+bounces-812836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F994B53D59
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631F77B161F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E723F2D94A9;
	Thu, 11 Sep 2025 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak9Oh9xk"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664C2D781E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624226; cv=none; b=C83+4r1fd7gRL9xDHf+UD8vlKA5NNj0uES++SWYuB3IqwAa1xVYt7U2/AbLPNVcFfAxyuF++O/J+obAJ7nm83XXSmtWn2d9XBjgYViKxxv8QU7oL91FCStH2ZlOGghG3aYpdJxONEJt32W4rAd4ay29KeOZdsYLQ2DhPtcc6cFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624226; c=relaxed/simple;
	bh=3/RgRAcFV2NW0rUq1O8pSUOarRj54QaeN5/ojlVNaE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlBeUQB8vxRAcpVzolx4BC/QbiooPX84hGGj0Gkd8a3o9V5XbH1HjcyNJoc7+RstgOW7OELQCiBsy/XijL3zZf+zxLlvWyuatsAcHgS7vVpy68F2r3+nbMjWbARJz2FjHNQ5AbamRyCgR0sOGFmAPeymLw2zonGywiTlAaCseow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak9Oh9xk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0473327e70so198614666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757624223; x=1758229023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6aOjs8PgmMeVOmmIH10qFkLTayDVCN1LF6r/kVHD1s=;
        b=Ak9Oh9xkVmpI07XrcH6OJrH4iBbaqqA4NLdGjnzh6TEI0UDmko++HT5vd+PI4hbb7p
         p9ncWfCSz1USyg+i6PMrhU4pw9nbOIxJLGDIMomJY/YOYOMnuLfMR/JgCK+PkvXPEFVx
         LCi+gUOYIw/334v+UvmNj5nQe4/TH3c9DN4CtcKb5PN4rnMg1PD/NpyfbQTG0T12rjP6
         hujI2CxxhAZnuxmcgZfS6uyEzzmza7gYcAldWk9E78kUQ068TRTThr6ugcl06iKpiS7x
         GnOVYwvvyAJyevkIvRFXC8GWqA96/ss9MpDA+FZn6Wx8PpRZoNJqdvE0rrArJzrLB2pR
         QmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757624223; x=1758229023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6aOjs8PgmMeVOmmIH10qFkLTayDVCN1LF6r/kVHD1s=;
        b=Z5aBpcUJ5CMX6f4iRENFUnOSRCs5miF5wgqyuESDWY8yOpLGcYWo4t9avemj2A8ZiM
         AVmprp5u2LA4Yzu+FcqJXr/4lknh69P/5jGEy1BlNPCbDeeJfWOx6EjvPoSYtrNKAmeq
         iPiJER5qAdr/G9BQZRmmneWMVnnusc1tsqSCHL90sfzooL6IICQjB9kmB+WUOCwoH8iE
         3MbAHhrUxavrCSG6L5595VlPlbUxk/43I6wOKRbpWTzzg9KtAZcCif7LG1v8b2ig71hL
         TULPR7rmtSaOiVoN+pIGtdfMvdXEFEvBTrWj02YGiBRmk/zPgBE0pubkx7+72BlbwDvE
         AAYg==
X-Forwarded-Encrypted: i=1; AJvYcCUFLuPmTgN/ANKboMU/Pr5rtiFsF7PN1RzH4ELowaZN5ucR47B0jgQSpWC7m2WhKmqXtSrs90C1wcAVjCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4JKjgQZopRwQJF/AyxQMhETRUlbmnqMUNGGr+s4dtJS0j860G
	2ceaiLO7F/y34E+5RyXFjZnVhX2yHTMW3GQPYL/QKzJOU0Lee/kVcFtn
X-Gm-Gg: ASbGncszsbZwLYuqL1g9ZWIgeqpOtNd2HRNtDQwKhb8nGcvQ89OQlF9d4kP9v9G71+l
	vvHMX0nGGcNdISQzDmc8rYI2SRujJe1X3K5/3xMakg6TCbdW0+jtPRzFftY79dWZoTK/J5vKwID
	GeLOP3GWTxLkQdQaAWU2bNmTYyWhKnQqvZNEEKZCeiZfwXB8Zq1RKnE5duHQLhN6yu/UrF1t976
	44je+Y5pTaLN6cGZdPney9A4W3y8VUCN4N47fBevBJ3PSqvuYEk+qU+e/uQpExTOm50obtCzCK1
	iy26SBfRMh23L9bWnX7o3GxaHuAhuNgRDAdQxEOkUgKmkVf4vjrYeHLR7msT02nlrrp9KiMz2Pm
	O6+HiVkFhC1EJsYDi76O4qJwX4XgehSWPdSwi3xoM1g==
X-Google-Smtp-Source: AGHT+IHWdhuUM6f2lywRYg4GOnoPtBiWkw6/PuE3vzVz7Rso77GO0FX2u+NDjsUbuHwsz2f4SXE3DQ==
X-Received: by 2002:a17:907:60d0:b0:ae3:8c9b:bd61 with SMTP id a640c23a62f3a-b07c354fae7mr53944066b.12.1757624222769;
        Thu, 11 Sep 2025 13:57:02 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07c28f190fsm38775366b.39.2025.09.11.13.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:57:02 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 11 Sep 2025 23:56:56 +0300
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845-starqltechn: fix slpi
 reserved mem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-starqltechn_slpi-v1-1-93ebf951a932@gmail.com>
References: <20250911-starqltechn_slpi-v1-0-93ebf951a932@gmail.com>
In-Reply-To: <20250911-starqltechn_slpi-v1-0-93ebf951a932@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757624220; l=1069;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=3/RgRAcFV2NW0rUq1O8pSUOarRj54QaeN5/ojlVNaE8=;
 b=r49EsUNrjWPtZZoQrQ5ZDJdhA/iXH+3jXbgBpvJhDi6VzZKIxfYF7ar34ZX5QtZVE1HAIpRJm
 SD5KLWof2lqAW2ZPaBVxsi7wHs6XHrnGwhBUd49y5OlxYCRUKZdS8YR
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

When adding adsp reserved mem, slpi reserved memory was shrunk
according to vendor kernel log:

`Removed memory: created DMA memory pool at 0x0000000096700000, size 15 M`

However, kernel refuses to boot firmware with 15MiB reserved region.
Increase slpi reserved region to 16MiB.

Fixes: 58782c229e3e ("arm64: dts: qcom: sdm845-starqltechn: add initial sound support")
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 9eeb4b807465..32ce666fc57e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -118,7 +118,7 @@ removed_region: removed-region@88f00000 {
 		};
 
 		slpi_mem: slpi@96700000 {
-			reg = <0 0x96700000 0 0xf00000>;
+			reg = <0 0x96700000 0 0x1000000>;
 			no-map;
 		};
 

-- 
2.39.5


