Return-Path: <linux-kernel+bounces-850285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1188BD265E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A64B3A5543
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3A2FE05F;
	Mon, 13 Oct 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4i8Uarc"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC041946AA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349408; cv=none; b=hjbYN0vfFUSkljS6RmEQYtnlKKPIRUVfGaa4Nsd8RSCCiGVgiEzszw4l+PKMWRSLPhGVDADmMrRwZY/KXng8m3nuk5EiqFcAT5AWPUFSduk/ko39q4S5trUvg3awyKEdfufe8EY0gEgkdl7LCJocAuZabDodOl0B4usWFTK5ZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349408; c=relaxed/simple;
	bh=EGmxIR9kKOSX51N1HxGcneN2hhaHwAGf1JsXcHdoHVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lEpJi2C7bw4pRem//f8OrdrqoEizZHaMFO5qTjSdd8ziMMylQBaJbLmXgU38F9AFV1kx1qJ8XTdBtxyRZJh6u+6KsjuLqupDsWWFjJHYlLIHRuHnTJeUqlnPVY82vYaI9swgRA/w/2o7Gh1Ims/LArQRwyUViw+3MsmNhn24BHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4i8Uarc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b57d93ae3b0so2379048a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760349406; x=1760954206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJifNO/MlvLEol8h2cpUsahhKb87GytRbrPHmHhE5dM=;
        b=H4i8Uarc6bjN2gVX5qLBjCa0nVGVJQckdrm56FA3S5nghxdBjfny01RXcuz0eA7Kp9
         X/+QQmMZDkAI00aQCqkx/EuFp0AYIWHE5yHFAV2EOlKG7/EoTiUbR+AiA+1elktykWxR
         iNq0Icotv2fpyg9xPsrjT6uutm1uHFZtZnu+5is3kXq61WCRmvIQCtBCO2ekcVw7B/dy
         B5v/AzPQd3MhlKgB6alWIj9iYpcQOw+M1FMAZZLMlKp4av4DYBpmCURMpdGag7vljfLk
         WgrBGl5vDVHISvG3qzBls1bhaD9GGsOAHUiXiyKWCOHgs1OJIqq/1amz7kAoYptIRNIQ
         fmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349406; x=1760954206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJifNO/MlvLEol8h2cpUsahhKb87GytRbrPHmHhE5dM=;
        b=o+KMR8rTgnVUjTWYKemvFeZsp/1KhCotoDERlWLeKlXMyG9i2NdAB2PxeTMWsr5GFV
         a0bpoUH6dNhVAG4UgUuOP+OYPVkFBANxBrxetWg1j8hHdXv0zmkgFE19kojDXRS5M5SF
         XDZ8Nw2cmgFRcuGKFu2uhW4oYgariSe9pScij9p3kvI8fEyFkInOf6KK4lwdZJwvhj+W
         KuTJKFSPmD4nUrgrfSvuRL6SsBgLnN/Tu3wTkEKggdU/lDS6Rr2j/m7mTa4UV3QHWZmh
         OnkRfa95WYuulKf36F63WNeRCnk4jOqr8V0hs1XG01kj/a3IUKenrUJk74zstUOZv9YB
         0fJQ==
X-Gm-Message-State: AOJu0YygnT5y0OphWD9cb3oJT09DIjl6JIQO/ssX5svn2w+c2xVqj6Gg
	Q/FZx8nO2/jPgQv+EnfVvbis1qedTNExuUk2xlmReiFTSiJz1Pd1HdMEJv9hTodD
X-Gm-Gg: ASbGncsgDl8VZ7gJHXGsT6GgRgOL9MkKbTb3kBU5W95L4vp0KDfXPrhc69wBnXRXnv9
	k497yDYGUwNwZ8R8UU8jI6ma9eGCNzRZyxiJO06wHZC6sdj+mRkUEZoq9x429TtPTYvxa951dLR
	8aFTeSTtBDQ7guTPNphYHtZVLICYpg4Mv8WkgEiSRqSWooZFwyaNN0Pwv1Dem+xoGlDYu3Ias2X
	knFvocEPCOkCYhM4pfAzBcD1eAEQccNQaubaKuAGVtgfpKw9Do7hMDrvJntNcv9lwGrsA5Us9Fl
	ewlNG7/Qzaakw5kvryl5gSKU/EVXR0rVeF5DH9sx3Re7EhVVn95ZzXhZeYmkZQXQeUFHrfZtQqO
	/FRO2vqWVVBi2OimNaCKPaVJrxkTswNvGzZzpFNDHf2oAwhIJrYkM7Iw=
X-Google-Smtp-Source: AGHT+IGzpC5rqfVmsWGMJXGyOLj84deaeSTSLGbIECeDpck55uHP7Se5TrOU8rzQ6Rt7w04+qGi3PQ==
X-Received: by 2002:a17:903:903:b0:274:3db8:e755 with SMTP id d9443c01a7336-290272c0358mr237517515ad.30.1760349406411;
        Mon, 13 Oct 2025 02:56:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f078aesm128287165ad.64.2025.10.13.02.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:56:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3174B424BFFB; Mon, 13 Oct 2025 16:56:43 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Will Deacon <will@kernel.org>,
	Markus Heiser <markus.heiser@darmarit.de>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Silvio Fricke <silvio.fricke@gmail.com>
Subject: [PATCH v2 0/2] Associative arrays documentation formatting cleanups
Date: Mon, 13 Oct 2025 16:56:29 +0700
Message-ID: <20251013095630.34235-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=708; i=bagasdotme@gmail.com; h=from:subject; bh=EGmxIR9kKOSX51N1HxGcneN2hhaHwAGf1JsXcHdoHVw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlvzhTpTzz78X/QzmP7+U+2fnJteX7S43LshGkn3W/9+ aI/RUSbr6OUhUGMi0FWTJFlUiJf0+ldRiIX2tc6wsxhZQIZwsDFKQATuWPA8N9z7deAJX3GIv8c A77en772USUHx4czn1iz2xkEhGTuu51gZPjqqFoiGmv06vyp6M2LP+rNXiFc1tmbf0ti2cfzvWE X1ZkA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here's two-patch formatting cleanup series for generic associative array
implementation docs. The shortlog below should be self-explanatory.

Enjoy!

Changes since v1 [1]:

  - Apply review trailers (Randy)

[1]: https://lore.kernel.org/linux-doc/20250920024227.19474-2-bagasdotme@gmail.com/

Bagas Sanjaya (2):
  Documentation: assoc_array: Indent function explanation text
  Documentation: assoc_array: Format internal tree layout tables

 Documentation/core-api/assoc_array.rst | 196 +++++++++++++------------
 1 file changed, 103 insertions(+), 93 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
An old man doll... just what I always wanted! - Clara


