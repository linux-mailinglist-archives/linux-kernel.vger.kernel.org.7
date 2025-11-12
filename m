Return-Path: <linux-kernel+bounces-897251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C08C52613
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A5434ECF71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9829C31BCAB;
	Wed, 12 Nov 2025 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="u/WG/Vyr"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0F30B517
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952548; cv=none; b=P8zjE4/gWJWXShS5v8dcFBUe6O+D9kBP9robKILWgGzVQAXJkLCzYo6VLVA22PEoWRCwMG7iXHIkq1MErgX8OrXR315ur5002dQ45GkF62pM7DvvYMyU7cOfFdhT3p2cmSpF17EmfV9p1fCc74hgvHCsVfptBnZF1DthqUDvZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952548; c=relaxed/simple;
	bh=YGC+k0tk44NwbRkZMJ0Yk/EvTJZmov5Tk93vBGrfByI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V19CoUGbqS79MaKW8TAuGPpsZm8P3vnAVaRcS/RjcPd8dcvU5+GJni1YzhKGadzzbIdLSSf4KJZlE47xscgUJN29E69ImpG6jjz7qFSUQKzRxhLiUdbrO06kguYS78drDtzhIcbAIrgS9q3dc8RXuEh1Q0B66OTlcaRf4oc9b5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=u/WG/Vyr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-880499b2bc7so6731716d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1762952545; x=1763557345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wiC6a6GdtF1gAjMY65zmuS3i8efcnY5DhFQLWpigTpg=;
        b=u/WG/VyrzV6bznnNsPuNspwU17XECqH0bOZo8CJHLZtfH7e9gGeBjU5+l+doWr2Os0
         kzs95YMj+i5dwh7LFjOFI/kESEIEj5WzsFGxUW+6H19MfKRzhJvUAtz0kUupklHW21/K
         PWn+IHXo+cbB05YuJgErcjAZ6Uv73PR8pzycgHypWGGkIClYNAC4AIMZK2Iash1vMeTp
         c+4sjz5qegHXgLqkWMYnlPm54UieAwxbEQSBcESuj2V+UezrthlKZBVZhcSyEaethfIo
         iNwrPTwO0l42OMxMjwf/Ny0jeM+Y4KB+0YL5+N1PhrD5Oh6hmSspmazC0iYNGl0CgYCt
         7OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762952545; x=1763557345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiC6a6GdtF1gAjMY65zmuS3i8efcnY5DhFQLWpigTpg=;
        b=hbJCWFLrMGtLbFY0u4LnHb9vWgbcWcrBC0dUrUyAvy8FamzokN1Pi3OJelJf6jzLMH
         +MOrvwJfdxf59hXOWGQmwqQq4u2cFjRF25TrB2nn8qOlOGQZe0A5Or28OgypBkgFXmt1
         57APxfgdf3rF0bBbR1jOGWrh2VSHroXhQIFIhgSIjOrR8+GuhSw33dygjC8zgofht5Wu
         iPx5EiXjFuHeAMKFaWOJ1kG1TtR/x+KQlBSsKrO5u1HJnyErr0oYj4lNXKZexTXxILGF
         5SxFRD424F4RnQ5Vt8fSYg4TndESZlgGhDDwoczmMVr6maNaAOHF3g+rEzuqeGep5rJh
         FcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBjqRMSVWg6OmoOvbNrImcu9tSBiiXNs+A6VJjASVCTuLFrhPqdM/lViR5j7FOC9dRV2NShQ4mO6tq66c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7cismo28JchlsogCL4dFsHFfctSveDkciulM1xcFllxXjbrqP
	8NebW37u2UHb7QEqA52M9aXWGnsRPw6NOAmfpfDwYmiTbZvCEN1k+LylSPJth9zKk0s=
X-Gm-Gg: ASbGncuhsfxhxvLMu3nuYEiIWzYZ5+o8IrWdNgLsxyy8fxt6VndNibdrZ8v2tdMZpPu
	d/WDoHB8QI39kh0rj0bfm/K6GjLUlWM7IwkotWwaCtIu+DEVmmx6AQDR63f44Lu7ECJ5wAO/oN8
	toydgx8WswfM4Ao1aaRUTCD7jVW1h0h1Gc3zQ6tK5dLM5LZHm7KFdUDYQTefDpTKf4iye1E/ozM
	5c24ZuvptXBgBi61+PgKS+8d50ndIe0931lI+sXxzQ14PefHC/FMK5BKRlfnYbObnXTOQBPLXtU
	Do+aXWmNfXR8rDTbrIhcKjrRAWegeWHlIdUGyvab74GNfp1EC5yYecF9es3mCrzLoSP+5iD45cq
	KvO5veEdsgsgShoMPI6A8AyrnIscUHoNp0vxcJuBRbajIODGBdpEzdhXlQLToyuETxWZ4Smqx7A
	0FFz8hKPdfKx1DHspqKK/2eUYWFFN0XwU=
X-Google-Smtp-Source: AGHT+IFJh7J4bnE3VnVwlrGLXKscLfsnOg+NThjXCk7Mr3nxJJ9ceXnQi59SgZG4nVptSKeRj4ZhRw==
X-Received: by 2002:a05:6214:f03:b0:87c:2270:2b37 with SMTP id 6a1803df08f44-88271a3cdd3mr41231576d6.58.1762952543164;
        Wed, 12 Nov 2025 05:02:23 -0800 (PST)
Received: from fedora (cpezg-94-253-146-68-cbl.xnet.hr. [94.253.146.68])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-88238b7499esm91362126d6.41.2025.11.12.05.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:02:22 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: srini@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	horatiu.vultur@microchip.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/2] dt-bindings: nvmem: lan9662-otpc: Add LAN969x series
Date: Wed, 12 Nov 2025 14:01:59 +0100
Message-ID: <20251112130213.842337-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike LAN966x series which has 8K of OTP space, LAN969x series has 16K of
OTP space, so document the compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Drop individual SoC models since they all use the same HW

 .../devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
index f97c6beb4766..c03e96afe564 100644
--- a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
+++ b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
@@ -25,6 +25,7 @@ properties:
           - const: microchip,lan9662-otpc
       - enum:
           - microchip,lan9662-otpc
+          - microchip,lan9691-otpc
 
   reg:
     maxItems: 1
-- 
2.51.1


