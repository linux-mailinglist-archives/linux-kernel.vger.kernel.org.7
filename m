Return-Path: <linux-kernel+bounces-824185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A86B884E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D677817894D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B52FFF8A;
	Fri, 19 Sep 2025 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZXyVQWmP"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391C2FF17C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268712; cv=none; b=dYExUstwE/+32Y5AhqWalnS8qJiJkb8szU1gRRYL0YVOzwkqJJGZ1Hhm76hz715+zsPmObOkmwBccrODFQFdR4RkEzVrIO0cZmXQcV2fnPz0XByHuiEKt1nSKv4QTjIOxgNWHNuUzagUj+2s00aQU9flmg1JmbPZ8XJ05GT1C40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268712; c=relaxed/simple;
	bh=l92OkncAkN7CQH5Yv/FMs4byey/iHXNBxiKHSxhWJmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/0XdaLLSzZeDSF8EnpKXMGaPvtMWainqLc8Bb24nUr28If+jPkTDN/mDCkPuMPnuNH0FaJlY6wC5VvYL70dyDSlFRdVi1oaYNO6MZZXX8ihGI6luIx7EfZ1DafFiJcwiiMf4GR3ghiHxUYraswJ8KCdYtje0rw8vZjWjzCuDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ZXyVQWmP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso5465090a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758268709; x=1758873509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/F5R/2NOqkoymo9zvAsteuAQQNJ4xYdq+NdFZB1zNk=;
        b=ZXyVQWmPavnwHO3frbL8P+xuZUywheVdlZZrQQBwhMfqJTXyPYPKVmP/+uObnHk/Zm
         XWoQp7Y+tT0l6vXK7jsKjP/pO9le8YpmiDZGaYgczIyc+6mVDCkrTp+NwBf77IsfEGTM
         nh7BVORtmrZNC+GKLfapW7Z4o5D/h0mekxv5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268709; x=1758873509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/F5R/2NOqkoymo9zvAsteuAQQNJ4xYdq+NdFZB1zNk=;
        b=ed+EDUrVl/1Mjb/zj/MT28RxxAKTEycNcmzgBZwJFGEzaRMRpKdMmdrcGrvDx8REwM
         m9e4XLCyNqwR2GSzTrWFocbqeQbSv55Jg5y4ltoweoETWqQBKd2nWrmeo0kTkja+Msb7
         nhNaC6MffWp0UkafdU5uNqsD35Iwn5y6S7R50XtPFLCdeFS7wwUrlOacjtYP7hN91Ze8
         hmZdDwAwbkuOlh5kq65qjtHmKtyJCLn+qwJZRtnXaBuIvO7lkl+LidY3g8w+LQenGbP+
         6nA/IOGZwUAO1iJjpxmrMIWqCaUcyPWEq1IvnT2gur9kASwiHs9QmGPx6jjD69ERI/qn
         t0VA==
X-Gm-Message-State: AOJu0YwlM4JtGA/O4+/lqTJzdyERMCA9zzWeRLgqwbSkPVAIlkHHmJKp
	k7YvHse1bIxU4vh1qfh89eSc/PcJM8fzjtuX/E0Fva0S9FlXFPr5rhFlTsA55+fVhCIvd6jGJ1H
	JXzAB
X-Gm-Gg: ASbGncsTJF7QXaqmD0KmQCCVoZbRoTbgQQcNHxPd4ae23ukT2s0HfgMMEYM587en9Fh
	JCwhw38NbWNwTpURsqmV82RcbuJZ3P1JjAd5/GSotHYwxM3EG4KgvFLpqCp4he0WLnA9yigr21a
	r/Whr1chui+/NxFQswBS9kmrZtJkW+S08ML/0ycm2j4eyWPAr3h59C0zENp72V5hHi6dA9QsuUs
	qyYetK2Co74Tqc2ScRN9I9ozzA694APK1E2yjolHa9vmhEYJ/ZuY1TcFminK7Lk6LKL9p4GYyoZ
	Ez8r5vfn/ehq70XkP/iOnH6Ssjddo9rS6q6Ogi6QuMrCn0v9U8KeciYaQ6GyhcSsMmqlRf6WGdu
	aur3NXGOXvuJYksJu+CGmbGcn9XuSEcFf0daL5Z1XJQrgrfb1+mFefcWrR73QI5FbpaxD8/kdTO
	LXulhgfxtsEGFYrsXgyGKlUNGKmVLHBrH9qxBj8k0tG3kLvu4kkOr2MAhpeXnT0Wmq
X-Google-Smtp-Source: AGHT+IFWBJ0JF07xrrg1AEfrd/lNei6bNWfdewxHUBTlYbJy0+2ZBEssQAE3DyJkSIWh4hsDeA90Kw==
X-Received: by 2002:a17:906:2e8e:b0:b26:40bd:66fd with SMTP id a640c23a62f3a-b2640ccbdb9mr72789666b.10.1758268709023;
        Fri, 19 Sep 2025 00:58:29 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc890cc98sm384693466b.49.2025.09.19.00.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:58:28 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v5 3/3] dt-bindings: touchscreen: remove touchscreen.txt
Date: Fri, 19 Sep 2025 09:58:11 +0200
Message-ID: <20250919075823.2557865-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919075823.2557865-1-dario.binacchi@amarulasolutions.com>
References: <20250919075823.2557865-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 1d6204e2f51f ("dt-bindings: touchscreen: Add touchscreen
schema") touchscreen.txt is no longer needed, and since no other file
refers to it, it can be safely removed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>

---

Changes in v5:
- Drop patches:
  - v4 1/5 dt-bindings: touchscreen: convert bu21013 bindings to json schema
  - v4 4/5 dt-bindings: touchscreen: convert zet6223 bindings to json schema
  because accepted

Changes in v4:
- For rohm,bu21013 bindings:
  - Drop description from reset-gpios
  - Simplify description of avdd-supply
  - Rename bu21013.yaml to rohm,bu21013.yaml
  - Add Reviewed-by tag of Krzysztof Kozlowski
- For zeitec,zet6223
  - Drop "Phandle to the" from vio-supply and vcc-supply dscription
  - Rename zet6223.yaml to zeitec,zet6223.yaml

Changes in v2:
- Update the commit message
- Add Acked-by tag of Rob Herring
- Add patches:
  - 1/5 dt-bindings: touchscreen: convert bu21013 bindings to json schema
  - 2/5 dt-bindings: touchscreen: convert eeti bindings to json schema
  - 3/5 dt-bindings: touchscreen: convert raspberrypi,firmware-ts bindings
    to json schema
  - 4/5 dt-bindings: touchscreen: convert zet6223 bindings to json schema

 .../devicetree/bindings/input/touchscreen/touchscreen.txt        | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
deleted file mode 100644
index e1adb902d503..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ /dev/null
@@ -1 +0,0 @@
-See touchscreen.yaml
-- 
2.43.0

base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
branch: drop-touchscreen.txt

