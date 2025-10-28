Return-Path: <linux-kernel+bounces-874093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FEBC1582F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F4169505DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2696D343D8C;
	Tue, 28 Oct 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcmPIK+C"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80633A005
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665540; cv=none; b=Zy4IK+pd4UxwONYDuSQm65qMmj52DllgRxOo41alU/IVwSogSaRHU9lAkra+DhYYUfxgfN35O5yMlfcjycdTNnWM9ohmgdofVYO8XalDGeiyT03JHSvhDWKXv30BmS4FoBGNu8m5ZU+Sr05H2XhuD45YdjaEsl9hE0nuvVXBqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665540; c=relaxed/simple;
	bh=jHlDAgCUcYD63kwaEY1pmO3dD2BE5jK1MCET6sAnOU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pQ2isuXf41zoGn7Jv7+V+38Im12cpPhGqaqvJD09SW9nitnxB88OwHLSSpH1TEQkamFT6pMK5I3WkO1zAMGzhsfn9IDApSUBJmKtC3IgRq5C9ALmxi/XL2j2iLJGymqaIWJfIi3mHciiSVBuPzi+7cCuynrHfd9q+UufxImPD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hcmPIK+C; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f4319b8c03so738482f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665535; x=1762270335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aC2/7bpg8G2o5qe60+KYExE03W06UZRjcwgPkNC6rgg=;
        b=hcmPIK+CHg1SVjS25NnCfk5kFzJXAHavZaS4gbbIr+W8NTlkUr1CUYSZLhp1nnFMVC
         PNuR7QRolNgmsqm+OUBEM+OSe0AAhYCm3abo2viilkE/1VwO/eHS25Nw+Z07QAK7Y+76
         hcoSpjfTVB7KslLwV4Q+JO3HVw0h1IaF0+Kc7tNWU4v3v/BPsAKR0H4vtF0nfCxQxeU3
         NUwrIeFdjZ8Sp7ED6NErN0nsBJzbC8waafacY72K1Pz4PAfjKE59C+dcxb6vNlprhgbA
         lffmvCwXyRpFcBs2MoAkaOBgtOlqAp3316xa/3St/PgflyVVSYgwfMEC/KwY8PojqktT
         UFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665535; x=1762270335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aC2/7bpg8G2o5qe60+KYExE03W06UZRjcwgPkNC6rgg=;
        b=dAF+ZOBFs4/iNiVfCIpjaajjiaPG/nRGMtZEOJHeR9i7bjXdOPXCvD1F42Huu2bz27
         6e5w4xZI9NOxQxo2v7dfc9GPQNPhl41Ip/RYCHVbW6gJG0Qchkv0NmNZ2PxX8q2EEiwE
         +oHOdbDSXyvjOG7yLxdp3rNt3JlMixQ6ADmKXChbLxvi0YeAxHBZNiNu0I7NW5Mb6/4I
         0eKEs+PlIPA2EAiOELr4epl4SixvEQs84ydqN+CEY2zZBdCztYi/lnI33541GGjjflQ9
         MhZeLMHABmFxvxKUZ4ZCtdjat32O6kIIYHvLgMMYFopH3VuFrQ8qwPxL7DSOri5IT5fq
         sS2Q==
X-Gm-Message-State: AOJu0YzWjyiUrf/aSJzloqGCrCMFuWaZmhM+jpdN1V209dgXJts+E0lV
	NjrlacnzQx6l+OsW0vKXSlVxlkYsPVSuNCajxnh+8pDasXj+m8MK7gxpNq0CXksco2c=
X-Gm-Gg: ASbGncuO404kx3StCztZIsgwC3Le9aClN9qnCw/ZgYHUrvVujDtWInB44Au7oROJWN4
	p8IDjvF6niRb7pJ8efv5H975DBgMTtSAr1EEKKFamtWhz11YVuqEp9tvFA9fWHXNgjX7Q1YyzzJ
	BnGvdbjbANjqM2DqeV8vpM5JA+YxNBm3UqgIlPmgLt4zxnhnTouEjXeiximsSmclZAukNVVyISo
	vialnEyDxG2t5jvwtTlJ4Axav5T3kbq5UV+LfdBTQJPUKVEfOfO8Ua3IH0gQCrtzcGFxEgH7589
	4+/vp5hBIrLAmrrSV1hOX8UuQYJ1nfKesdt/OWzodo7RzE3TeLcgQyP08XHePCPfpUaTg6dwM9F
	a4sPY6IEROwSYjINzRFDHHcPuiSl6GPERXiQaubSrZ8YEDwiOM+Ad8eqChB5Gx5ZO9blJr5jgWI
	PZxhw3QmXxCeOF9ufY
X-Google-Smtp-Source: AGHT+IF2dWta0afPVUf/CFnCKQd1Gr3gEa/5lr0iHnTH3wK4xPGlWaHUfGIaemzNI8UFlSZ2p9yQLw==
X-Received: by 2002:a05:6000:2892:b0:427:401:1986 with SMTP id ffacd0b85a97d-429a7e8683dmr1919010f8f.9.1761665535518;
        Tue, 28 Oct 2025 08:32:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:50 +0100
Subject: [PATCH 01/12] Bluetooth: MAINTAINERS: Orphan Qualcomm hci_qca
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
In-Reply-To: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=756;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jHlDAgCUcYD63kwaEY1pmO3dD2BE5jK1MCET6sAnOU0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOHx+nX5MgClyEZDdSfP7lbNIR0KKnA4BSVjN
 GDxO//+3lyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh8QAKCRDBN2bmhouD
 13LiD/9lBNMsnzHPq8ELAUm/rVGE9l3aQa2Hib0XDc/h2AohzaFbQKB0Ruw+JHSqpN6algBAEKY
 44U2H2pxrVat4KKFKis4hdXel0S2GAC+JCpkdEqEKa/27J1kMT+ujP4I1EcTLYjSjxjOTVAbaot
 5NbqnD44twb/Gb6YZtIXTYjFxPw6MWX85dNQh6qDH47B1PQparFHNpaobrRHnge/G4tXqBjSB57
 kuskq/DhAGeSjV7I60WdvNPhICxq+HVdwVgGAy2Xwsb6DGEoNAgQHN1vjEcgXzY8NVrEzy3OJN8
 JK3u9NE5oG2u28RdF3ZqPn3bVafh2IqtpNNaxbGnoH0SCjbQr5qk41m+oRNEjC3RcaNgfu0e0LI
 VCTkpfbK4j0BllE0MXJGB7+rr0MsI6yOM+xWPwHVfObwBX4oY+xD49rG5vZ0ZTr7Yfy0JBvcI5i
 rL+l6ctLioLoCjreVXfGmK4HkZBHpQ1G4swg9XQVr3ElZpXH5dUOI6z4U5OTE+r70YNI/eBQ3F7
 N5Oxdah3E6TLLccUPsmASIka4Ax3z3NCkkz7niVJU+j6n7ZZW5msdXaFxK2A6H3MEf6KmcXzk5F
 INxN8b/aSoQVHk1Q3XP31Z+Yp2JQNaOmPgfaWj0gIh66E1QktIcZFhyEoROriImK7PlE18yH0Gf
 RGsE62a/gVQ6zOQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

There are no maintainers of Qualcomm hci_qca Bluetooth driver, so make
it explicit that driver was orphaned and no one cares to keep it
maintained.  That's also indication for future removal from the Linux
kernel.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8abdc0e50699..be637b9dc7c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21146,7 +21146,7 @@ F:	drivers/net/wwan/qcom_bam_dmux.c
 
 QUALCOMM BLUETOOTH DRIVER
 L:	linux-arm-msm@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/bluetooth/btqca.[ch]
 F:	drivers/bluetooth/btqcomsmd.c
 F:	drivers/bluetooth/hci_qca.c

-- 
2.48.1


