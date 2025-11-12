Return-Path: <linux-kernel+bounces-896551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D265FC50A76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94EE44E56AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F62DBF40;
	Wed, 12 Nov 2025 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE7Nb+g1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A735CBDC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927101; cv=none; b=gQHjX/jOpl2TUzoccpx6HSmRrwiOyDPfcTwvQsNMstAcp1XQuB1OWJhYAcXT5GAWaKlF0VZz+V08fAOcXGxBPdWx6vnKdLmKgi1t2BCAQK1FTN2HfvvP9HYDyflCHKqMuzjUWXFUPv1dyKDvwW0T6lp+1FCBlfRmCWK5XQfE4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927101; c=relaxed/simple;
	bh=KMVPQU6AS/v7oNHJYF9l/1cd4YGs3GSrORGFBhYfvSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKzp5azAVfxDiXo59WewQsmE8DkV7xboZlaS/v41Ydd7a3esnngn0iJoy5awDY7Cn7a/6vJZfEpXGwzFzEwuP6MhxYpkD2NOZEEh08ANK9WdSJd1Aua9f0iSz+C7LnVC30WmZbaPdmqEfYfyVnII+Uh3hqa/o+4T/N2N68LJH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE7Nb+g1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so327746b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762927100; x=1763531900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKHdK8U3MCmMakl9CmRgXs3sD+ncRr9aTOUvShNhzd8=;
        b=YE7Nb+g1bQhSbfivBe8Yi8itWsgxsYIQkrC0V8Ek2jPsMbjkto41eF4DvKmHWuNIjI
         wznTvi8X0qB+Gc/xmTGSffGKf1neMAenEOwWxwDx9WvH/flLcYxcf2KPrcGTJwjefuww
         QiCqmDPseWjVar7DxbM+D3E6HvS5fL1gwGbf22GBrYDICS0ISLg22ugam/Y2OugZ3LGW
         uDCWqArkBV+aBmK7EpHXwY/CnrBBqT2aD6gwosxAiskpdIWYSfKEcHhIDCL5RbowVcCE
         7sGdqAhSY5LB8+lTeG10b1Ndmn+Wr9FvTf733B2q6L1rgbxXpmKn5uT8/7v9zomUWJ5a
         xz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762927100; x=1763531900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKHdK8U3MCmMakl9CmRgXs3sD+ncRr9aTOUvShNhzd8=;
        b=nouzWFp+BdXqxaHBaLT7MJRwHAr0VKROxYfegN6sjAGDTmMaFZGtMdPUHEcjPl5OQ7
         TpwC86ypzNLu24dJLvV1zNDk7buKOXwWOFnBm6VZayO9HRlePXUaiZU6Y3pYVdNrJ4I4
         ebJqpXoJ3iG88Z/31mVaRj0IuWc2rr6W0B2ad/L2yj1Xr7Q4Zw1rcwHJgpz6/ZIElaHl
         5xXLuEKCnbj/me8lQYJa1r5XhoRz+thKQOQjeiDfKOEFgQJ1OqNsR97MEW0ztiKz9xUJ
         LW2AK+t1ovHIc4N8y/qR8YQrjex2MJxAXtiEpnNo/3feOLAfq9e8HPRcR9VzUVNSVbn7
         QVgg==
X-Forwarded-Encrypted: i=1; AJvYcCWfMsopNjgQgjoZlSoaJxvOpcmgY2DIDG3PQ9WCdLROZIFaP939f2yACN/KNf8SdgtlXqibYbRcJ+qQ2eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxymxGECGDukYHZbsagXV7TOAAyznq11Ne+p6QKBvVSqUJ3nnfd
	p6sPImRVU2ifp98+u5BXDe4EPxu3RYlm1hw+tr6oGrdUgIhNYZa/dOWW
X-Gm-Gg: ASbGncvNEJjxGYBuTvEw/cVJHKCz6iTpukXFDPO+PqNsstOv5+K6JGff7snaImZCHQv
	pU2UIcdHvSHDiG9VfdCF1zkmJRdUaGonSXHoSHmBbD19gTyhvlUHTYdqyMqpVPb/plR7Y1lIBG/
	WO3lM+xc58jsRgYyT71kFStO+oQsAJ4vuI3e38X0IW0qkG/NoQwiNyh4Tq/2p+Ogq/APAggayyN
	P6an6QAfVwTsaWCnXkfUm4pG+M7JvYLqesI5FegtqWm+WlRDBU8+OiMy1WgkRundk39agn97CRv
	Tah2UVqgd/IAmVtH3WhJPTpQU7ItGQWpUa8XG8wDk7kCSSAD19v7a9WXTFEihGlGv2Di9k5WbWT
	dKrAVAkbkxJRqXBJthQCh/pahPPiGbr9IRjkWhzEG213hUgNjXyk0HUQ/uNO1wVkUuZv+I71CPA
	nE5nm1PRfWBaunkc1f
X-Google-Smtp-Source: AGHT+IE3/tV0L6LmzB1TOOszkqRLe67V6aPM21N3b8BA8c6diEO/NirFT8DNeyb7sUBcqf1qNtSnQA==
X-Received: by 2002:a05:6a20:7f9c:b0:352:eede:89cd with SMTP id adf61e73a8af0-359099863f0mr2318490637.17.1762927099543;
        Tue, 11 Nov 2025 21:58:19 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b140210c75sm16395549b3a.11.2025.11.11.21.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 21:58:19 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH v2] dpll: zl3073x: fix kernel-doc name and missing parameter in fw.c
Date: Wed, 12 Nov 2025 05:56:42 +0000
Message-Id: <20251112055642.2597450-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation build reported:

  Warning: drivers/dpll/zl3073x/fw.c:365 function parameter 'comp' not described in 'zl3073x_fw_component_flash'
  Warning: drivers/dpll/zl3073x/fw.c:365 expecting prototype for zl3073x_flash_bundle_flash(). Prototype was for zl3073x_fw_component_flash() instead
  Warning: drivers/dpll/zl3073x/fw.c:365 No description found for return value of 'zl3073x_fw_component_flash'

The kernel-doc comment above `zl3073x_fw_component_flash()` used the wrong
function name (`zl3073x_flash_bundle_flash`) and omitted the `@comp` parameter.
This patch updates the comment to correctly document the
`zl3073x_fw_component_flash()` function and its arguments.

Fixes: ca017409da69 ("dpll: zl3073x: Add firmware loading functionality")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v2:
 - Added colon to fix kernel-doc warning for `Return:` line.

v1: https://lore.kernel.org/all/20251110195030.2248235-1-kriish.sharma2006@gmail.com

 drivers/dpll/zl3073x/fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
index def37fe8d9b0..55b638247f4b 100644
--- a/drivers/dpll/zl3073x/fw.c
+++ b/drivers/dpll/zl3073x/fw.c
@@ -352,12 +352,12 @@ struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const char *data,
 }
 
 /**
- * zl3073x_flash_bundle_flash - Flash all components
+ * zl3073x_fw_component_flash - Flash all components
  * @zldev: zl3073x device structure
- * @components: pointer to components array
+ * @comp: pointer to components array
  * @extack: netlink extack pointer to report errors
  *
- * Returns 0 in case of success or negative number otherwise.
+ * Return: 0 in case of success or negative number otherwise.
  */
 static int
 zl3073x_fw_component_flash(struct zl3073x_dev *zldev,
-- 
2.34.1


