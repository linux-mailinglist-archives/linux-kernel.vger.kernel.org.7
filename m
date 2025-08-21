Return-Path: <linux-kernel+bounces-780262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44751B2FF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BA3C4E651A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AD72D0628;
	Thu, 21 Aug 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+CZBy96"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20B27CB04;
	Thu, 21 Aug 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791875; cv=none; b=MZpYxZTUwIHBbQ9FAg/T2mey6bA/vZm+DdsJQNLFtYTzQlunqpXCD1SJ4sJLyoIe+gsZvq4MeSU5cCk5YqefHdKkZwsBRqaIJv77RBIIlrRsP81aXQyzLc2ARCFmg/PIeOoyH0JLXX3aCPJG3PnwyjIaVAfOnb03CgzVxDeYKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791875; c=relaxed/simple;
	bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WvQ5YrdogHFxy1Gf3qDP7WPOtuIql+03lC0Zprn7omuRKvt32D8Qo2nTSDzICJBY1djJOAIzXEpYZGEvv8jP9xX6mTL2duTpzHRLMmINILWOzlBLkt0xx3lj3HAGicrr16+iroqfkWHA3A3+6n9J83n27SaVgRXzhVUpxONdt+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+CZBy96; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so1122776b3a.1;
        Thu, 21 Aug 2025 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791873; x=1756396673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=C+CZBy96E2CVPUm6JHGYQn46M23LcX1sWnkjHRLUHsztTbp0WnewO7o62VYAzv6Evi
         Wrm2MCemjE+RZ1mEcbc9yJDixwcW3b1bksqCdhAsYTscLve9sacY78x0UQj5AGf+lbAU
         cdlVClaL87DNP+meuNf3nuI1MfLpQl/jGiTlPNwyigCXQwDgsDEih5D8BPU/jkuIdpA+
         TGzwyqAMqMZG2L6AIfrPzgt+qIUzXXntJ8bLTOJ6zADMYSwrcSXQqESpWvnkULNRn1eZ
         8l16YPFeN7Xa/ZldPrrxAH8vST7GyjqvnJ5qIriLGnc36L8nF9gNSFllBpQm1/22bcsB
         lrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791873; x=1756396673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=ZLdV0xAQd/+jUM1WYrpLZH3JUAG5dJGAXfk3FhGwGxTXXBvQxgOzlWXNzirb+1jNrM
         C/CpgT5XUOxapa05quTDzJFtxAjwJItKVJJa3O7hin5SWvn+d0tYNvm7hUvWGr8uWPkk
         yVmylk9GIoaBpYQEX7H+6VTWrPS/4TWaWX5vUDq2lbZofKnToIeS1DRVJZx9cPjuS+bI
         RgxsXe6yaMISyg2MdmTZ8jxZqtX/CHVf/1H1r6HreP9lRMm7xNvGniw10tyIsc5VF9eJ
         HmidDGzStKuOGPRxfw2wnQ2lA76/hRMg9U+E43DSubR5HItTiqlsLEDo3gIkZlMOWN9n
         h3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtR9aa/jghysH71D+RUch7SikuGq+d/Zg0g+70cpsEdKbwSzxv2ZjcPkLXu1+WnHzPIbYDetlNhuwA@vger.kernel.org, AJvYcCVOZNuLmYM5CPg2NCPrWheeAV71sRBC0Xk6wXUUd2pUQsuf+IR2YqKrCHWoWQNwj/fGV04dfVVTd+WRxKhM@vger.kernel.org
X-Gm-Message-State: AOJu0YwBP+ybzgcbSJGEZwUb35t2SRiaiBLwAJVvj7goS8Q4fzPfIEqD
	dAlrVZ1Qg/iOoFhPk44sb6N14LStdI5p7Y2xDQ+XueRpA1NHCJFRCCGx
X-Gm-Gg: ASbGncvJQ4iK2HmHR2XwOSlU1nwJTsHtI135Uw14U0WWUgk+2lKx3gyPWwQwKCIEVux
	G3Y+XHKCOG9mVAcgQXcVfFgbKsOrWFEbtXeHmRbwL3e5QwyqVdB/pLcIKksMWEp6zuoAPw6cGad
	GP95dR7nAa5vP6sVmslUb4+PeWet4RxVgI/79wT6wwR2+tjfaWNnQRlCbe6q+GbYLfVYpZal/VH
	bqJnNzmje1ltgvvK2mTk2Req1fENMkuFzKfFHbQq76NNbvB/8uMyyyVtVXtATmhXWJ+TiB7EgHb
	PFbMGDSJASqh9deG3s1qRGIU4qf+JrhOPqi0myMsqV366VTRrm61ltnQhzywCkMJeOupzi4WHLK
	pGpcUkcy2aid8hS7mixDZvZiRaZGLKn0KydKTlxCUTLPlgRM=
X-Google-Smtp-Source: AGHT+IGl8DhfBnfyyRb/1wuIt4ZnuuK5v/ajSI18QqjSW5uA5+dCScmkCcOWU0FTW5Qiao6GY4NPmg==
X-Received: by 2002:a05:6a21:999e:b0:243:78a:828a with SMTP id adf61e73a8af0-24330aaa986mr4832755637.49.1755791873031;
        Thu, 21 Aug 2025 08:57:53 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:52 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:43 +0800
Subject: [PATCH v3 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-6-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HVe+SYcZ4v31RCzG+zBlarAEg9e5w9fD6uT
 6uHdqv3tdGJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1QAKCRABygi3psUI
 JKl0D/9L0mE7dXU2s95VtJEOhw9hiZJoAf0kmkheBDiq2ex+CgUM9689RXA8Q5UIFgqG3HwcT1u
 qdSi9MwNSV+DmDZa0NteXj/QA3FPkz2wu1qFqwGiTDMOt+V/nB0yK29xB6a8mkzdQU9BI5GvCtj
 8iupQqETr3cuFkQ/wUH4OfFwgxxN2TBlOLUPedcog2Esg1Gdl/oS4VKymOgOMEZTJkWWGzUCvH1
 Tb7gEOdgDmdt86gzbH4R8hC/a5NPIdw//ESycyj+0mAOn/CRpGSz1ql9cTzfrAEG5XjqAd76dar
 xyFOG28eH754ZioFrxEA4nbNtZkptM2JQUyxJrnafS7BkydNBN4ihW6ZXT6FgB59AVUT8CCKUo7
 IOKblLdv3m104dkriKSm5IN8RO8GI23IFnvmRkn7NB93PeEp8nc+F+SpZep9I+aODBxxnavPfBB
 LW3TVrL0QsMpDU3YzP9g4SEqFSswAzJDLKv/JR21yoFbYH5yZmaxtlcqk58X+apLffev2Rt12EJ
 tnQQKquhH/Awk+CFvyVMSo4sswgvsdXpdpjP5wLqW/iXt10Hfn5VTnpkFAoRD47IuJxfVdlR7A1
 B7W234hW/PkZgtLyYnAkThuEdXQHpKthI3H5Ht49QcHOXhTJHAWD0CDaO2ACod2v/gRFQ5+TL16
 Wmv/t0XQ1D945YA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add ANS2 NVMe bindings for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -11,12 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t8103-nvme-ans2
-          - apple,t8112-nvme-ans2
-          - apple,t6000-nvme-ans2
-      - const: apple,nvme-ans2
+    oneOf:
+      - const: apple,t8015-nvme-ans2
+      - items:
+          - enum:
+              - apple,t8103-nvme-ans2
+              - apple,t8112-nvme-ans2
+              - apple,t6000-nvme-ans2
+          - const: apple,nvme-ans2
 
   reg:
     items:
@@ -67,6 +69,7 @@ if:
     compatible:
       contains:
         enum:
+          - apple,t8015-nvme-ans2
           - apple,t8103-nvme-ans2
           - apple,t8112-nvme-ans2
 then:

-- 
2.50.1


