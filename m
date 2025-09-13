Return-Path: <linux-kernel+bounces-815357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FD4B56336
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE8C16A800
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6626288C21;
	Sat, 13 Sep 2025 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxgy57rI"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9B283CB0
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798509; cv=none; b=RcQr9YzNB+os7jACC8uhBrJfgRbVkXsYuwgJua7+QjJu4ycGM2KsbKC08We9IFKUcsxoYxDqwE4tpiivKdbcOX95Vz4a7b66t6TG354/P5ivx/+cXnTN4GmxsL5ELmF+25SSPFY5JjFPZv03vw6/HfirvMfWffS1OAyWp3XnkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798509; c=relaxed/simple;
	bh=ztO90OA7SFIyJUVjK8nlNGn9JJ5eZOFp24N24RDbL0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZ/kPUXPFClxgLdIggO1cmNiF6VkAPnANHS7J4t66WVKyMjciW8CRnXkV7UGTlreUCJY+2NC3z/JMxwppITibP7r8xfW02iGXCSEQexZa6JUZgeOXwTbvwb/7GsewQyYFdkxwiJM2YIBcxMAZ/6NDE6W958d4TxQrr3960MQt84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxgy57rI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so36337135e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798506; x=1758403306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyY3y/zfUMXFXUpRJ3OYxoXXX3m+tz9/9uTca/6/ofU=;
        b=Cxgy57rImp5bFwJj2/yRy9AvVSk3tbtaiHhfNmtWLVrLSiLh+ph5ydyddu6yHxAL7f
         0mIDUo0GHzDiCud31Wu7Zcy58Mr3gFPrqmqRjMSCz+S1iTqXKflV7aMYhNa/UBLHu1me
         U21eNq+rlTdVGsIG0tv5gJQuRIcU5Z7d4TSVNQhrHglBkscWmv1a9vNtRG9fr7TaJfjh
         Ve2SVt5KbFmE/ejJebBl6oYrRpFL6sLU5g1dZxgpu9+F6TdAfSGZMRqXdVqRytrhrZ46
         h7hDvH0GoZIlDfmnhi1DzXRLFeVj7eIBG1H6vTxv6sxLb8qpBejVfktsRtqanip7+2Ke
         KKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798506; x=1758403306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyY3y/zfUMXFXUpRJ3OYxoXXX3m+tz9/9uTca/6/ofU=;
        b=H0J89FXZ0X8B8YrWvBslumg9FG1bLLrkCn0dty/qVG9VT3oEpoVXVj2vhNFqvcvz1m
         V21oxeG1ld/pRi/MbX2UDFHjUL98BUv8ikZvdR6sTkp2UCpfG3rFERQseatYLu8GTkrx
         htYw5rzti+wENlKg8vE9UYXUubI9kZ4vsewL7FOoqwY2/zDKkHVUgDVLF7Zf3T0XLPTb
         IfAHe/zN7yikaIPAcJXSvhcU5D5un5XOq7bi0Lb6adRqfF0Cuyka+7RscBJ/lQo6Osi2
         fh+NlcYq/u3Vluj4fJmH6+dGBPUjaiCVJbCDbUeqjEoEvM+ss/a07AcTs1/Bcwd0xePH
         0hbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe+0/iOzmu1GtUiKY/Bp9I7QeOwZEpJ0oYheKl+S+KnM21YG036PkJB1tK7MDHu/u2O+eiSp3lGPZ55yU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WqJpXBJYuYqhDl1PTJNs7QvJqSl49dKiCjIeM3BQWS6MDsMq
	ADnNV70isXn6Grc2nkT7KA6U6DuWdM+kYTmFWjKFJkKH4RbL7hNZFsij
X-Gm-Gg: ASbGncthjA5wLg0tV53B+XuwHzl7ezwsATNm1khue1jNRfSUPb6WMQg9tr4vuEkt1gQ
	wV9fy7QslH6+lu/Ur/PIZZBgATskpCaiIp6AsK+WWCN39lYWZy2k1froJ999rJQPHEyovKUgtkl
	Bum5nCT9Lh8w7pdWwv3xvxu33I+P6JwPk38x/pAXufY5W9mMosQXGo+lAhMhF3oqYPaFXqJz+DR
	TMVCUVK9NF4CE58iDarWLCwoo9ZDYBZVIBheVHG/UdXy37Veequ9wQDCzUQBbCS2fboGlhj7hic
	bcP8N4t1bS05l5q9kflJxm05UkLh60Zpm4LnmHsDMyNbYZMq/wTVDNikqYjnzqKpzPCpzoCWcHn
	+p46bIktb6+FX8XmWD/UDmqj7QwCxpf8/bD4aIypHYC/GW66KgQsD
X-Google-Smtp-Source: AGHT+IHeRMdY0v41y9UG/rCilo0nlRpcPpVfU8FDp0C5dtOoNsF92GLDoRzILM7KZ+pH0kQfdzQpNQ==
X-Received: by 2002:a05:6000:26cc:b0:3ce:f9b7:4db with SMTP id ffacd0b85a97d-3e765792bb7mr6581555f8f.24.1757798505977;
        Sat, 13 Sep 2025 14:21:45 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:44 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:11 +0200
Subject: [PATCH RESEND 9/9] arm64: dts: marvell: samsung,coreprimevelte:
 Add USB connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-9-8120cdc969b8@dujemihanovic.xyz>
References: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=duje@dujemihanovic.xyz;
 s=20240706; h=from:subject:message-id;
 bh=UoJNCWjZnaplQXJr+hNjiSMuZ5Y1BK5iXqLcT0rH1m0=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/i7ZUddnNcm6NX88ZzeqdVLopceTHzeyvbQ4GbZ5
 PvaH7PaOkpZGMS4GGTFFFly/zte4/0ssnV79jIDmDmsTCBDGLg4BWAiM30ZGT5cnORQud/ucF2i
 9XoPuY3MVi/3HmcWv8LkI6p32urQvgBGhgtbDuqdMI6cvOB80Kwj50vyGvdPfxFbJPvwiQpTp6v
 1H24A
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

Add a node for the micro-USB connector found on the board.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index b3741389e2ae056714ff4235b972bc72b5560455..7c96eaa33b1ef0176811f3b4d915ce1a69cc690b 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -68,6 +68,12 @@ muic: extcon@14 {
 			reg = <0x14>;
 			interrupt-parent = <&gpio>;
 			interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+
+			usb_con: connector {
+				compatible = "usb-b-connector";
+				label = "micro-USB";
+				type = "micro";
+			};
 		};
 	};
 

-- 
2.51.0


