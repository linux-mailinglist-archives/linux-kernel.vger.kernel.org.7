Return-Path: <linux-kernel+bounces-859178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC922BECF4E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 140FE4ECA4A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799332FFDFF;
	Sat, 18 Oct 2025 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF8UIsYV"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272482FCBF5
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789535; cv=none; b=jqjvaIzAZARk/mVWO13d9PE3QByweBvESbAOHmNKneWvk8cq1733dZerPqp9ZpLU2PnYdCDfl6DSk0ehrYKJ2vOK/mDl1wzAWQ+BRsLRgOTTnvWOyN2aSbER67JWiN5QoInkEzZTiDiaW3Y4Bu4KAspAWR7m0/41yd1LUKDXe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789535; c=relaxed/simple;
	bh=+kJN5PezJ0QH+/KdewVY3pE+HvTakZByw4n/oGasQtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5+Qs80044tGz+A5DXGIi+UWfIPlWV9IQjRkRE1cdsWYPApkq7oTFU8IAyNmFAc3iKNkBQLdoO1ybj6/HcjHVG69kzxS2o26fCe90QseN1We5vnsPhi13P5VwSpA6HHHkC86OQnCnZA4/clAbwma6Q/ALmDn9y0A9qgUJCq13HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF8UIsYV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710653ac03so1515475e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789532; x=1761394332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61jDuhX++0mCBZApihfwIySM8ZNRnay0trJ/aGXtPcM=;
        b=JF8UIsYVtFaLoiGmpVFSLqos8AUBeS+MbVHPZpm0bsaGgAfRTgxkIcCyVOPulXM00k
         Lz2AJI4U2/+ayvVJs2NUCWFgYHO5i9TjzXmAdYMplvtW1K9tk6rGMd7LCmfgWGNQLKJp
         7k1iwQIeG/NfuuXeL/habIsYwxQgRRWwW635vOPJ78m5+y8IV343Y5CcG+A/sd0bXBrS
         y081/uPii5JP+qjw9AWwvZn+MakEpfQqTvt2tuwB7f/8mlBo8OR5BLuwB5/Nv9eW9mml
         P1/fedQPfAGZ6Nh0rrKvemUn1jaHTvnJRN0ChDqpMnGko+VEjj+ybqknqEZnB5oZrYo2
         /LBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789532; x=1761394332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61jDuhX++0mCBZApihfwIySM8ZNRnay0trJ/aGXtPcM=;
        b=nUoXO+1U0Vyqi4BblxfMICFkeuDihka70TbbyoTzvTBRph0NZ7TuGoRwNYg6zt60V8
         IvQkTxRNDUhxcDizg2Oq2+mSVWsv8QRNDT4wrXI/HTd4FiMQ7Jkhsy+i8mBtiXCxXJEW
         8JpDEFLWelnx0UE/IT9b4S93bJV6kvQyKIzhE+tJDOwhEv15N+kVoeSCb0xbwQb+x3Q8
         av0bA5eD3G5kX8N1CPyETEm6NWeO+FmKfBSXLJHlb9cOYCnILLbutyvE0+1Zouff0Qiu
         gBhGO5Bk0XFEyA5ww1IOWXue7badjqfYN+lSu5TACUHc5O0t5oO3fvcPPKfzFc9h1Y2X
         jKLw==
X-Forwarded-Encrypted: i=1; AJvYcCXV03LIfV9VwrzReTzTOyyljC9YZuazEZEIWJvAEGW0S4NXHKmb6PJoP5t1zTFN2Cezk07UfRtZ66SXJmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy0KHMB53MjZF8urXSxWtY2i1As2ijg//5yO7yVBO5OxgxlvpX
	TAenI3Er1A3Do/8s73x5MKv1xGlhcO2bGQYnkWZ+5EWGOTbRO68O8c2s
X-Gm-Gg: ASbGncs+FJsOZDCpWALh/Yf4XRH4PwFd3Bi01V8aAcF+FNIkXb5cJRbWjgRARepWHlK
	MCb+4qrVdSuThukZ4rX9bKFpnJDrkMmOsFXzG7Fi0HnlIdhgvFgJ5cG1pHjwn4hAG3FXg/gR/UI
	Ep6xKIBI2kR4VbKt7VtLdK7kfdqk82hk5yuy0xaMH4DX8kXX9RbCcazBsIOhfvUXuJNuCoUXCtt
	Ok9hVmwFxz6ddz+FSXsNlMQ+7R6xiWfB0eS7aWvhxWkyjam8O7697JwK7AYK1szkt97o5aDPDK0
	kX1K9x/Nn3+uQ7VDRwsXaOAz152nv5dS5jZtAfbri/yIEEP9iVsTidTesdGozsuj07EqkVRBdLc
	iNN194DjAa8Y9IwlhGtwDVlW8WzJgNt2c6Rfq5BhY7SvN/PqdX4q+duBV/vq0Rk+lQyvlcsSIUZ
	a8vdKq1SrH8oZI5rhvuRiWBF/kPjnrz4zO3OmiQmAf
X-Google-Smtp-Source: AGHT+IGlMnguu1Red8qhAnT6PJQ1lgcFmM+xa7XuGc93PNnZOuj+hJG6gEn0AGzlcZZjZ5KiraKN+A==
X-Received: by 2002:a05:600c:3515:b0:471:152a:e57d with SMTP id 5b1f17b1804b1-47117914193mr28693965e9.3.1760789532118;
        Sat, 18 Oct 2025 05:12:12 -0700 (PDT)
Received: from localhost.localdomain (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm4763812f8f.9.2025.10.18.05.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:12:11 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	martin.petersen@oracle.com,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	bhelgaas@google.com,
	l.rubusch@gmail.com
Cc: arnd@arndb.de,
	matthew.gerlach@altera.com,
	tien.fong.chee@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 10/11] dt-bindings: altera: removal of generic PE1 dts
Date: Sat, 18 Oct 2025 12:11:54 +0000
Message-Id: <20251018121155.7743-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251018121155.7743-1-l.rubusch@gmail.com>
References: <20251018121155.7743-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the binding for the generic Mercury+ AA1 on PE1 carrier board.

The removed Mercury+ AA1 on PE1 carrier board is just a particular
setup case, which is actually replaced by the set of generic Mercury+
AA1 combinations patch.

In other words a combination of a Mercury+ AA1 on a PE1 base board,
with boot mode SD card is already covered by the generic AA1
combinations. There is no further reason to keep this particular case
now in a redundantly. Thus the redundant DT setup is removed.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 227665d0016f..db61537b7115 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -34,7 +34,6 @@ properties:
               - enclustra,mercury-aa1-pe1
               - enclustra,mercury-aa1-pe3
               - enclustra,mercury-aa1-st1
-              - enclustra,mercury-pe1
               - google,chameleon-v3
           - const: enclustra,mercury-aa1
           - const: altr,socfpga-arria10
-- 
2.39.5


