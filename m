Return-Path: <linux-kernel+bounces-825438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B45B8BCD3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372BAA014BB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C131FBEB9;
	Sat, 20 Sep 2025 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaSofThA"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627DA22339
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332722; cv=none; b=LoIv4DKmZ6oVO5UCyclwHcliEEB6yvDsiPf99mrLpFV4dXvk1d51rgwYkeuOTgtGaMfgG2RSJNGfZA7gFYFtqCZnG5bmU13uiCjjN/fPNClcV7eJhvlrmcNrZ2p1zWzJIOIJRLvWxeLJiXvWkPdBxQC5tSVp4WL+hCaK7kwKb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332722; c=relaxed/simple;
	bh=n+pJatxQUxiLkmZBL2NjODakscY9/Sz9q1h/+tJ3Wq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rCCWJcf9/KQDt1DJTaYetviAwRN1MfAMFBzki5ESR2RjE304eAn+UTdvwk0IAo7D/KNhLrkRxIPnMJDFRyHz2Z19k3AaWrMjHbMWAbNnp1lD6siBTKsYQ+QlGQGeERfKhZd4kKhVZB9+A7tG84if/fhbFFONzzM5fUPViRn/8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaSofThA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f198bd8eeso229897b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758332720; x=1758937520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MaDslKzWOATYzqYJokHZic8iJI/8ZjqbD74gr3V2Ay8=;
        b=DaSofThABZx1DnmKMd2GiFYQqiUoz98TzmKSnYvRsfjcGHHeANASV7h+Y4Q6ipec+A
         AWnFsJudlXVvDyWSAOtGgETOpFUNBDUYZU+CX8cf3H2sv0S9bTXF0HmN05u6z94EOtcW
         Qt2zIVC3wRqcU0CoA4JwuxjC0Ub7L/2KYNUnr5SG4kvK2gu1AdrRnIqWhIsuhwIL0OsH
         r/UDvMTOMMeTyYBB3qWI24cGpLLKpAWR+xLoCiu58KbUoMiT7qsViJPQy6UIeX5bu94H
         SLlph1WIKG4ZirgbrO3lww/sXaVwpF9LvCzp/Zs9+oe1KeEDTBx6NiQSRc3sxFANeVEB
         CEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758332720; x=1758937520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaDslKzWOATYzqYJokHZic8iJI/8ZjqbD74gr3V2Ay8=;
        b=GPmXxHYx/hww1jNYKWBez1Un4ZfJArCMk8eDzXW1oR2ZjwiYtSVXMn9B7wvOoSharc
         qI640t9VMCzwYbpgv83x7VwaOGIBq1V6R02t7RQP22WcrkxyxAUUsHH+acYAFYuLoP2M
         ASWwjglDzLlk6vdi9YXwbZalHsELAqJbC+pP6ztckFgziTJYoeSRY8JI+8oNcHBVSL7Y
         TU9foch08Xrd/F2OGUsANa3VBusw/fM64kI2s9Dlb5SMEeoqLbVZOpmdtQM0H1equI88
         z9s315tYcgTaOawrzuR3jxonrgGlaOJliMImGf3MlpuaCbHUYvQIOxF0S+5y1X/UGW94
         5ImA==
X-Forwarded-Encrypted: i=1; AJvYcCUqvMM/lg5s0sAwV6Gmy3usK9Nv8PKWQGEdhkjgzSEcYiJ6ScBDXRvXWAPg4yYMZPJqFaUfZzKfhEgtbkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Hkfne510vJSGLwv34kKAEfIxopR/khb2S0RFxpBczhO5fTv2
	j7/slT91/7bgRVbVviO+yENM3XVDvjFrqcNUXOdNwr9n7p9vw1owrt0y
X-Gm-Gg: ASbGncsUZNwKn3xPWT5jOmdCYNzbHMhbBmZ9/8Wm4D4HFk0Ub/LIGv+RNhhbRlEeH4k
	2nw2mf/prPqCxAo516e3nbH0bI5nuKuAbUQluRcQ1SntZF9mTewSB4A8F5RES+Ds3UEC3wld111
	YINOPthwURRiHqcXiBWB+7nrSFD/pK1rcJeOhewaBkL9tPua3qAYZSbzJew8sAqcfPoYMByuvSD
	7SV2U9VwoVBY6jmLNS1JMEX1Q5lZsiM2lJG+wtcMlR3C6CvSULWQX/zzct7qZ8NPoLfzjkkhWTK
	R6p8ea933+j7XmDiwDe6K/6a5luOxwtK4Ar5hB3XIQ+4XdDtg2eJYofAOW8Mt8fVjlKMFPxhIyG
	p6oUc2m1iGk2mcF1TJuG2
X-Google-Smtp-Source: AGHT+IHy1IWqfKaCBizs/nvSOu8RxjFT+9KB6OWZv1nW+R2uVqWiQSnwNDGFXduas9VczYkbNIveNw==
X-Received: by 2002:a05:6a00:cc7:b0:776:1804:6fe with SMTP id d2e1a72fcca58-77e4cc3c5e1mr5540071b3a.7.1758332720446;
        Fri, 19 Sep 2025 18:45:20 -0700 (PDT)
Received: from archlinux ([191.193.70.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1a72e7afsm529395b3a.92.2025.09.19.18.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 18:45:19 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Henrik Rydberg <rydberg@bitmath.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Input: add fts2ba61y touchscreen driver
Date: Sat, 20 Sep 2025 01:44:48 +0000
Message-ID: <20250920014450.37787-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset adds support for the ST-Microelectronics FTS2BA61Y,
a capacitive multi-touch touchscreen controller. this touchscreen
is used in many mobile devices, like ones from the Galaxy S22 series
and the Z Fold 5. Ivaylo Ivanov wrote the driver originally,
and I'm upstreaming it on his behalf.

Shortly after this patchset, I'll be sending another one that
enables touchscreen on the Galaxy S22 (r0q) board.

Thanks!

Changes from RFC->v1:
- move unevaluatedProperties to after the required: field
- set Ivaylo as the author of driver commit

Eric Gonçalves (1):
  dt-bindings: input: Add ST-Microelectronics FTS2BA61Y touchscreen

Ivaylo Ivanov (1):
  Input: add support for the STM FTS2BA61Y touchscreen

 .../input/touchscreen/st,fts2ba61y.yaml       |  52 ++
 drivers/input/touchscreen/Kconfig             |  11 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/fts2ba61y.c         | 588 ++++++++++++++++++
 4 files changed, 652 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/input/touchscreen/st,fts2ba61y.yaml
 create mode 100644 drivers/input/touchscreen/fts2ba61y.c

-- 
2.51.0


