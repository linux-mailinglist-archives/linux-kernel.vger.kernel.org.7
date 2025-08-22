Return-Path: <linux-kernel+bounces-782673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B9B32381
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42044AC4311
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8942D73B2;
	Fri, 22 Aug 2025 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuSsiA2N"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AB1D5174;
	Fri, 22 Aug 2025 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893868; cv=none; b=G0gt97d0/EF6Bjsw/jG2hthOePlVOt+GEM40PzUOO+Kv+44opgzlCcSS4i3y0EpMO4hmcvIEp/x20jmag8eBQfiIQjNf4yq3KHLDCfZTkQ9GUXxMQz724L2U7a4FE4qAhAV5kAL+Qy2y1mPHbpU8m0jUY4cXtyyhCKKMue+zYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893868; c=relaxed/simple;
	bh=jAAyVcFMvHBlJFEs2XB61oIZ044lEzeW/L7kWAD+lIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PsJfU4m91TNgvZLJ2CkoWr1MWXePUPG8Ie5r+vxOs2JUIjljrJQPNIM4yuTgw44DqFKNxHF/KZDllRGoSfBVWiCFC//AX4/gMyLWHW+zOaTs4OZnGOql/HNgYPv6jjo8WG28DpDjCmDoVhk/s7ecJkkH+tPqSI+tVLpQ1reLb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuSsiA2N; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9d41bfa35so1915410f8f.0;
        Fri, 22 Aug 2025 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755893864; x=1756498664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhVMJ3YLUuoHZUXPKfr0vbflwD175WfvNAQOTAyxVbQ=;
        b=GuSsiA2NWFG7nqOc14Ir8jh5qpbwiTHUVdosZoRc/HnJdxTEr+S2OzkZIqOn4GKYsG
         F9fv3dYJeeouNBYkbK0d/twmiLCuXns4d0ohAS0+6EBc6By+fh2pFZVwCNpMzgge9xnL
         RDAaQ7v+8+9HvDxQ3xhALPBK4ymfiV09QySYQPOeU6llZDvB3ahAkLWhre9fBbwn8TXM
         Oh+34ptXOiKXQBvXEOq+TK4XDuQGn6bjeD0jUhku3kW++ApmyxAe+26jpb/7scJbmGUY
         wjPaSBO787ckiLMFu49rB05UXe5g9TC/qeCKvIYG4SDisONLrsk+/cE37QVhMgVUHTec
         HBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755893864; x=1756498664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhVMJ3YLUuoHZUXPKfr0vbflwD175WfvNAQOTAyxVbQ=;
        b=hXawV/OipZUOvCejmZLkkA94kohCo4CY9OJNylf48dSnDegz2uW+ETWoCIHEEjlbZF
         k7JAN+siHO45lEkuTdkT/bUjpsaHhc71B3tfcpXB5fcnsOwg6BWGGNHfPWYI4C/FhOdF
         4iuUSfkxp2Db9nRgtzoYMVcrZQsJQhW97+c3MgSruBxWnWHQATsOYRiPUkhwlZ9oAAmB
         QuyhSodMrCIf1JIaZN4zXRbIyTEHU00qHxgGvstAfnckuvAZVtu7lVTX+w0ZiuanZu1q
         CtU3atDFJEvKNRjRgkZ1XXLowZLXBdWf1M23HffgjrmSYooBOKWti5n503exRoXDBpUA
         MakQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+8CrR0NUJoEbgU+habKubWtVDEO5kttMXXrNGWcPrKd2gcnLwCF5KmQizfbXnaWe7XQPvQPtbr/D+@vger.kernel.org, AJvYcCWe6LaGgxWjIH1/7al3sYS6yh5T0vYUV2J+DtZks1mEed4Ldq1SD8p6WFIoLFOJUNNdRvoqW2YsQDS9@vger.kernel.org, AJvYcCXEGYkOmclbIEJAhnu8EvgOc/wKobLm9KL/U0Y0bjug4GHYgU6ynZCQXqAydmuBUkW6VthRgNXIOkjx9hat@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AVf8Lvm+L/cQg80QWJv2ZAN/yQxrBb4cGdZYxzlUxPxcvTZn
	1nfY2TXoDtjvZyZyav5JCEPf2TJlO0eqsOntFnBJa/03HkKUX1i2mPyFW+ebbMM=
X-Gm-Gg: ASbGncusnk0PKLEKyNO8Bbx1R0O7DMd6M6Gk9Da48ZDZAKeUsMheO/g9HR8PkcmU8I9
	OWSpCLX0ZQgFlF7wCGkzN+pI44jIAxxq2nC5zpJLXs6JW+avxNvsvQx2xd/czgDjVbbSPyTS/i/
	s9/Fvhj6d7ReR6EXUBOx2CyhO3/crWWVAu2WB7AXm2hy6nB1fvVgifYGelbHvpy785ZSCCjuKjp
	gAJBzaG8xeY9EeAYDRDo254+rygzQgAdYiUqPSbZW5huFKSYNVQTG0Q7x9j+cAmbNAXkIMNINRp
	KOnSLaYWWQ0EFT5EVjxlclHLaa1D5gqLzH9Y7mdgSgaoMBo6zDz+46cFM75NlKWk/jxOhuyfYIK
	N5DPkltfU2mOuMObiOpldEzSrHXMMwcGu2Zs7SUFN58KhqA==
X-Google-Smtp-Source: AGHT+IEN6R6H0FaGCpWfE7IYVuRm41MEXO1zxSp33BkRVDnuZD8L7cgHea3pkIGG2m7WpM5sSdhtPg==
X-Received: by 2002:a05:6000:2dc7:b0:3b9:15eb:6464 with SMTP id ffacd0b85a97d-3c5daefa9e0mr3375503f8f.15.1755893864093;
        Fri, 22 Aug 2025 13:17:44 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:58f:6d42:4e65:e74f:bc8e:3791])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm840377f8f.14.2025.08.22.13.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 13:17:43 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: robh@kernel.org
Cc: gregkh@linuxfoundation.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peter.ujfalusi@gmail.com,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v6 0/2] usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema
Date: Fri, 22 Aug 2025 22:17:25 +0200
Message-Id: <20250822201727.71593-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series converts the legacy TXT bindings for the TI TWL4030
and TWL6030 USB modules to the modern YAML DT schema format.

This version (v6) addresses maintainer feedback by defining the
'interrupts' property with a list of 'items' for better clarity and
validation.

With the conversion complete, the second patch in this series removes
the now-obsolete .txt binding file.

Thank you,
Jihed

---
Changes in v6:
 - Reworked 'interrupts' property in both patches to use a list of
   items with descriptions, per reviewer feedback.

Changes in v5:
 - Split combined twlxxxx-usb binding into two dedicated files
   for TWL4030 and TWL6030 per maintainer feedback.
 - Used more accurate header file for interrupt macros.
 - Improved formatting in the examples.
 - Patch 2/2 removes the old .txt file.

Changes in v4:
 - This patch is split from larger series per maintainer feedback.
 - v3 link:
    https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/
 - Removed i2c node as it wasn't required by the old binding file.
 - Updated node names to 'usb' and 'usb-phy' in the examples to follow
   generic naming conventions per the Device Tree specification.
 - Replaced raw interrupt values with standard defines for clarity.
 - Improved formatting in the examples for clarity and consistency.

Changes in v3:
 - No changes.

Changes in v2:
 - Added '#phy-cells' property to support PHY framework integration.

Jihed Chaibi (2):
  usb: dt-bindings: ti,twl4030-usb: convert to DT schema
  usb: dt-bindings: ti,twl6030-usb: convert to DT schema

 .../bindings/usb/ti,twl4030-usb.yaml          | 74 +++++++++++++++++++
 .../bindings/usb/ti,twl6030-usb.yaml          | 48 ++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   | 43 -----------
 3 files changed, 122 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

-- 
2.39.5


