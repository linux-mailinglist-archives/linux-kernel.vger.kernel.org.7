Return-Path: <linux-kernel+bounces-863046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DD8BF6DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D29B50292C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2687C338903;
	Tue, 21 Oct 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="E3zOyJhf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A826E6F4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054451; cv=none; b=g2sb3IQFTNb+sCsU4zVHyow/81vLrGtZOUpMe1vSbWFM5HJM/Pszx4MJZxirFM7coBFneFOaR1I4JNHffIQNbsgNLlALGom3Eiz2wbQq2CBnN6mhj4dfItRmFROn+zh3sVIS1giQK8jUXxsas+h+Db9X6gSXCw5lfyT4c2tsR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054451; c=relaxed/simple;
	bh=DMLwn51T6K9IdREpAAEHmPpOteBRQo+lhtzWQBv+Zjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TS3xrEDQnnBNi0OE1FqKNAdFW0WqgI0MeNN5xsVCBTUpxoyZwZJFJGUdz4JuAv1XwymcATXwydOAh6DnRWcEQN4HwuAcUIwA3tRfN4roBoy0haAnR1psPk9SFyIKlDgc0D4osklDa42pQRr+WE6KDUHIXqEOOLfSd0hkSg5CHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=E3zOyJhf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-269af38418aso68526635ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761054448; x=1761659248; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HYbKO+EA+3D381YTWjNUqIB0fBV0NifpQnOT3Il33MM=;
        b=E3zOyJhfdxR5mIsXAeLd/6BWFCXgyqzpU7z5MHEMDRTvFSXyihneEKNYLYHPGE1c+S
         kXhDpV/Y7MH+F64MhLWo0RyubAoGIu7Xnzaslb+DEYd8UvSp/nyWwf5j+zzAQqaXpvWm
         gHHZ6XD4it4weAUTZlbYWhsfrubFFIPhdEmVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054448; x=1761659248;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYbKO+EA+3D381YTWjNUqIB0fBV0NifpQnOT3Il33MM=;
        b=T3UFTR3H5SwTaUdJLrCPK0tF9leFjXr7UCuy/wskSJzzSaYPTK0PjW55ktAcFKNKoB
         i1Z9MIC+mk1++Xax7JlbIA+/k02g35rtaqEHQeSQUNHnJJeBpSyjr/l4NfbBrrYJ/xsc
         9CO848G9O1P/wkZdI0Of13RAFe3+SEq51C9sATaL6ngxuYpNmNRDdXjX8IeR2qQK0fET
         I4pB+yOfjTb74zoPO1kvPo3RsLXaIrS256GrSUPen+I6ZzSOiaDYMVA7nqv37AYjOaM/
         r04mK1L4JJIDZHD6sswDszadM2Rifigc6rzn1n5aoFnbOUgt1mEjqUkKGg03xZWmt3Ps
         2a7Q==
X-Gm-Message-State: AOJu0YwO85pz4WPlrU7f3Cc/rehRujsNJnhL6+VN2nPww0pmdE5xT+Wx
	fx1QbLNtzuCMdTyAVhFVCLlIOKkX5vBXDjq3jroKcSYIaxlQ08noiiwjWTLVjmLllHN/UYIeo+K
	S9Xt70l2tBiTz2F3mhctJS3Vgl9Ti3x59BG9coGekI+uc8xS9hHFw4slJT/zR7J3GMO17sv8i3p
	g=
X-Gm-Gg: ASbGncvzg45aKEJsgM8LARMTNkb3RWVGfbteqq35RyVali3QjgOJAJHj6rN+Ly9DZhD
	UMxX0YS3eLe8gshkeGfuYVav3EHw3qjeTqYjsxCRbN5/odA5ENOhWh1x0wRQQBGJGqceub/5fgp
	k+rKg+5rZQ7DTp0Gj1vLbLLzBk74emhHPKy/9FuKmtEzVL7wJ6D+3GDGcv1L6TIGva3TLe3rDzz
	3tJ/WIUWBy1iFk9IZko5YgHW6mbvWGXZH+t+7kk4aAjKqhfe0gGFYehifhTcwdH37EenEINy2aW
	Y7yvg7YGHZZIu/gY9JgD8V3FvziKGYvU16xQQ4Gy9z1BoNTZbQa58DwSRFtyNCX4nAXq11K0PXD
	36urAyE003IrOGnFlfdOpvpl3yYDTdsI+WhshZSiKnqkAcXj0BjlsxJRP+FrUrpbcdIGohqBpBK
	TxFJY+rPgJI8hac4es5gPaTC3ScpLJV2tB7vs30+Ki+Fbfq6zutjMNZXw05YtxgGnx1UEsMSE1z
	vnqm+d5kjBg3VQ=
X-Google-Smtp-Source: AGHT+IGThZgDZ255TU31mu6v8A4uddckOexxcGDPwxOc6BafvBvbDQkFUNHDVDdfwtEebe4cXwqUNQ==
X-Received: by 2002:a17:902:dac6:b0:290:b158:5db8 with SMTP id d9443c01a7336-290cb65b668mr251091615ad.44.1761054448260;
        Tue, 21 Oct 2025 06:47:28 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5938sm110041815ad.58.2025.10.21.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:47:27 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] Kconfig :Fix aggregate spelling fix
Date: Tue, 21 Oct 2025 19:17:22 +0530
Message-ID: <20251021134722.31375-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/interconnect/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 5b4bb9f1382b..4948662f4869 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -131,7 +131,7 @@ config INTERCONNECT_QCOM_QCS8300
 	help
 	  This is a driver for the Qualcomm Technologies, Inc. Network-on-Chip
 	  on QCS8300-based platforms. The interconnect provider collects and
-	  aggreagates the cosumer bandwidth requests to satisfy constraints
+	  aggregates the cosumer bandwidth requests to satisfy constraints
 	  placed on Network-on-Chip performance states.
 
 config INTERCONNECT_QCOM_QDU1000
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

