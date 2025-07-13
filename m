Return-Path: <linux-kernel+bounces-729047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA0EB03107
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E2B7AD896
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296AB277037;
	Sun, 13 Jul 2025 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ekAYtfPC"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1491F94A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752410810; cv=none; b=kSHneI1a+GQjbCUuK8kCN0FwTit2sUshxb9OvlbibL2E07vsbbvPEDndqqVRuQTj0FTbNtzWKOB6P4ITraxUuHzWcMndVeSAKAZhlf1iFeFr6bZr1kRHX0ALSI7tl5sDYuLUshvVNkmOK2ZXoufOR+xUKUdWUMINnAHZLSi7uuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752410810; c=relaxed/simple;
	bh=EFnV+IT3WMLvWKBJ+A8tOlHnCxdVYxzgQhUY+USgsKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sMOGZukBYU7EqD3guVeNwSl2XUA5yC8LztOI9wEe6xb0smn0gqszPqLYdeU/5CbJyXs9Clk2KnQZTckJp9P+CMOHMrus68ScsZExbNDFgRg/aesgIgi3tPpVYycupLU0gRywurXSiOfZI6SlwX8c1KxZybw2AmYx6iQTiZ+8bM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ekAYtfPC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4e62619afso363538f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752410807; x=1753015607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsHRmEegKuDd3kJrHQl3Yy7EUVWyybJ3UX6f6F6mCeQ=;
        b=ekAYtfPCK5OPml+S/E+zJekFl92eHzRR6pbL49JSU1KCZBoUGA+Nrk23cAWQXZvK5t
         Vm8UWVaYJCqzLsicYA24exZAK8FpMh+XpNi3vah5j3L3wSfLwggQsFSPV7k+1a8gJrZl
         E3eRXOkP1oadlZ4Pp2WbXD0XnGNjwKfEIRT3a1xCr3sXVqTgtqVZnYU90XWknY/ddJ0W
         UcGq8ALabXJSgOb7xKKWHDTk9LnN5Ztge+gzCxqWxeAkBmeH0zGf7YCcCKQetC5n7COI
         GevGUDH81orG9IZjCX13WbhnFPycqveI4rerr72MHWasV5+LrEcj7fv5cyUceawl124R
         gHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752410807; x=1753015607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsHRmEegKuDd3kJrHQl3Yy7EUVWyybJ3UX6f6F6mCeQ=;
        b=Lcpe/XBtdKbFctwtxahxh8jjV2xWVKiiOtnzns56+zszzRRPeU9onIU8YeV9y7vbwM
         3e0YgnCyPgJG6I2XakNAtanuhEGIPGgGjeh2nS/KX5enYmwbKof75iWBpjwKvHeqfNze
         HQJp0kBeMs8cMTXbfCbAiiyAtzqxLou3k+7WpZUzMrb/J9eBF5ckZ8PUOcNlcT6LbmrK
         qfNgiwGZ7GsEhG9AI0K/eAc3msAIzyGTeRXk00L2+S2b035HQNwFI9aHyZy78Pf7VGYp
         26LI9E5lAQWTkJWeHx7m1Af/mgHW2OFf8rls49rTFK+BNFFucW6YgHn/gNJJ7xzVHCRq
         khYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7IqvICpWqUO5KkbpRUjXYzwTqo2VlOmyy2lLGdMoe7hTQrK9OuZTeKNpYfpObTVYXgf6HfFesJrNq2yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr/cwUD7zoFlZNcP4+jy42h/IDB/wTxiIuglddIP+Nkd3oPmgR
	/7mMZfC9HEZ4Z6j7mapBDMG3xlF5nQ7wA5VLcsV/zI/P3MKxuIHP+Ia/LVeJhpzDm0c=
X-Gm-Gg: ASbGnctLZWhcSXScLQdiR3Pa3x/qp3SvKqFrPk1rbQAvLAm6HBCskWPASv8nfn9AL4n
	QFreydjQeJJmkMTVV56zGCs9NBnuKXksGuxfiFpi5qqbXIq5rnlKLBdREuWb6ovjZYXnxxCDS0f
	DES+l2Ad4bJVRM8e0jTXdPbRU2YTZSm16TEJ6MPbBP2rVGhSMr4tdr9JBONy0KoklrJrg5T8lt4
	1mAO385m75a2gaM71lQ4sWZc16ESOc1RBorSkUkn8AhA+t7EutrrhSNvuvKkouGvGcoGhgnMeAG
	YsOnj/L/PhqLLRYu2WlHJFmMmyJwOlN2KfEdsnSViEDEIFo5xPenEYhxfYoMftwSwouzK0uaq+3
	veFWwuNyUWT9FDBmCpNXvqNqu21JkNZT2R/yxnDirp+pAHoM=
X-Google-Smtp-Source: AGHT+IFTstnrjdXM4TS5/Iksr3hAwMqkve0ZmV3EsyB4JGAGxrnN82uit9Rx/A34hGD36CuTf2kvdA==
X-Received: by 2002:a7b:ce02:0:b0:456:c48:4907 with SMTP id 5b1f17b1804b1-4560c484c3cmr10560765e9.0.1752410806902;
        Sun, 13 Jul 2025 05:46:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14d07sm9828835f8f.66.2025.07.13.05.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 05:46:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 13 Jul 2025 14:46:36 +0200
Subject: [PATCH v2 1/4] docs: dt: submitting-patches: Avoid 'YAML' in the
 subject and add an example
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-dt-bindings-docs-v2-1-672c898054ae@linaro.org>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
In-Reply-To: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=EFnV+IT3WMLvWKBJ+A8tOlHnCxdVYxzgQhUY+USgsKw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoc6qweJaWH/TRT931L8OZ38HVdqa8pjCZqhxSK
 /dwLKoqIzqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHOqsAAKCRDBN2bmhouD
 1w/2D/95B+NllypkDLynxCCtdYG3KNi7EV7jEcL2XGFI47cF18YE1rv8vkPYdzt821JHMphrirn
 4E6wnuFVigP7GY+RIOL4xAOOJRmXeIr+eLy7SmOREQb+BjDwCx7afe65jcvHapznbSNgZ45xN3F
 j1WIJou3TnUsJqoDDnI6FdNF0yv66y4LeBRa9SJjgca/KfMBwQhP417LabcHQ50CaGJEm4iVTZB
 zPsFi6+9pbvGgdRfH15MUeS+iyZqSepuqGZTQSQLn2OwUHofwGL6UbH6/MTjzgCMC6tqdozNL49
 yAmjRjuSdhbHv9K/oIzF0ugpMJ4OieTCOuBiJaHsppLX16vOWCW8xAVuCHYObelbUONprkaGWSL
 riuSJ0jHv8OQ6UKlPwlXcTXTCdswYQL+rNdzMQqi3hY58GYZnea8oNzWpqhJID39ljAXytFuruE
 xTx1/9hNF+Z7v8xU/5pDl6nyyjX16bprT/5LBIrbtZYuyUkVlWtAWy39pr3OxZwQ+caPkjiJjIV
 284GtX/1MYcdavKP4sVCojmhYRAcEAHEz9Vbmv3Ql8uVd2bO+70MvIdu7+aqOBC4EmcNIZvbsBG
 4GzWeMMGgC3MxsGILY+eZyhF2RMCvCCMN2xMEowYRrVjiLPLsKsli3YBJlbjUGdchKWhpIafWWP
 1BhvRlv4HYjoKHw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Patches adding new device bindings should avoid 'YAML' keyword in the
subject, because all bindings are supposed to be in DT schema format,
which uses YAML.  The DT schema is welcomed only in case of patches
doing conversion.  Effectively people get confused that subject should
not contain anything else than device name after the prefix, so add two
recommended examples.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Rephrase - use YAML instead of schema, add another example for
   conversion.
---
 Documentation/devicetree/bindings/submitting-patches.rst | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index f3e23e69a6389e7e5d8db66af5060978ecff8a9d..46d0b036c97eb531dec95ef52261988d3bfa3aad 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -21,8 +21,16 @@ I. For patch submitters
        "<binding dir>: dt-bindings: ..."
 
      The 80 characters of the subject are precious. It is recommended to not
-     use "Documentation" or "doc" because that is implied. All bindings are
-     docs. Repeating "binding" again should also be avoided.
+     use "Documentation", "doc" or "YAML" because that is implied. All
+     bindings are docs and all new bindings are supposed to be in Devicetree
+     schema format.  Repeating "binding" again should also be avoided, so for
+     a new device it is often enough for example::
+
+       "dt-bindings: iio: adc: Add ROHM BD79100G"
+
+     Conversion of other formats to DT schema::
+
+       "dt-bindings: iio: adc: adi,ad7476: Convert to DT schema"
 
   2) DT binding files are written in DT schema format using json-schema
      vocabulary and YAML file format. The DT binding files must pass validation

-- 
2.43.0


