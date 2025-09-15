Return-Path: <linux-kernel+bounces-815993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1F9B56DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC46D17727E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555072165EA;
	Mon, 15 Sep 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdx+EFKW"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913720A5F3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757900971; cv=none; b=cBZPcp+7ppMjVaqw2bk6AkQ6RQvm2u/pGIKLNc8MFMGA9acGbBITvahXcdr+ZxfITkzGPsChPgkozUaqqbkOHWpOgGueORMTI6OFc8P/8Oxv/3jyxhedwFeDFtJWSEhI6xrmjtDdGW1IrW3W+GAjC4WR/oTYxEdJZFwOiGGx2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757900971; c=relaxed/simple;
	bh=oSreoU6ZmkSN75RCTco6kgjieWSOH7uDaMA8CsUlAvI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cggHtat6PBcZPoQoWvK13enzuVt6HtJMTnHjxdcQe955xAu9SgTZUeH01hCsMOzUTpGQh4tevQgYRwEPTEVXVyDtJ9wGhwwb+1JLvxgZqGXfHmBrTaxDZemJbNgxAX6lKcy3zPKtAU4f3e8H7F8wlXX/M81a9uwiQm1UUXaT6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdx+EFKW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2647bf5cb51so6043675ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757900969; x=1758505769; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wPKyOmuQWUf8l01OnPw9ehRNwWWfONhetwr0Nv+M8qA=;
        b=mdx+EFKWx/rS3DoXnDw1yF7bZFg2ZZ3nT5UFDZcJ7tc/uETs9LHSIb50c0KcfBLjfa
         CTNP7SLCwUcUVJyepiY9zKBDK8lm5S7sN7vyGmOtX8DXnkXtxV3bBBBp5iliXP26+aYi
         7rhvmazxSEWANRJeu2heTpbphlpdmOqKAn0DFmYC0hdzG2sSbCP2EAfqRobGsCSeEjay
         Ox4Gu9Vy/MwRCvU0CvXTkOuMRIWRXq6roY7i4tpVQKS0UQKh5VMpllwlT4mf/HTce3yX
         ZrAVuPAd0isykGnjRpFulu0swFk0HASytwYY7AzuZHuT8lW/BxL/Y353mZ4S6w21dwch
         IuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757900969; x=1758505769;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPKyOmuQWUf8l01OnPw9ehRNwWWfONhetwr0Nv+M8qA=;
        b=iIHrklH4Y6SZJqMJG404uvnwKPxKbUWkwYxjmTXvy24MEWqwR57tRUFIx/8mlHgeE7
         QBtSR0veEG3P12Gl30egEsfRvZ0A4B3Yeee62VvLVPEHa1BIh8D5pIiFaBQ1NPpIFYW5
         NydJ2Xk/GLNe+261sxvKrIav90yaPzaF2A9PDksYeCIDP/QTN6vHosdxegHDwfplgUSE
         YCNlN99PnIAF0g4HpsQQS/g3rWE556ywQTTpiWBVOuo2a1/Z+ykUHyduIyUx9Lp1CGb9
         y4shFBSAuPFS3S5QltgJApJ533eeQUIPX29vd6vZKj86GUIl7YcuP92u0fskN6gBTLCW
         tgtg==
X-Forwarded-Encrypted: i=1; AJvYcCWOmiFdDh+GY/vaFCf6rLEqbzfH/woapvkuzpc9ousKJxSbklZYPsxYYEx3M1EtL/O4AayMOFNgViS839U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtwFnKxdG+fk5jhqlG9VmlSl0Iu/6KkyOLftBFIOac2lEGP//
	8K0pDByQUnavBcbDHfxxNnV8ar0BQlPFqrwPxYiUZtDMzjnXr8LlW7/X
X-Gm-Gg: ASbGnctCvCMof9R4e9sG9a2V1ozpDBDTnXGXjS1qb8A5T2+acr3N+cBH4VWj8vFfQe2
	ln22qzAVi/HfMbsobDvyTwYOXM055q6N27+AP0DDSKEfKED+AYgQuCdgbZeO68Ph7nVsymasqb3
	dsydI0mnuAHQzD+g/Pv9YH/r77wZIfn733ay2LUYsIzgrVCBU04gOpjilPQXUJiVQiRc/AbOZbL
	mu4Uk5HM8BMIQQ8qr9iyzgsXMveSgljO1TVSVzDMLI8AF/rKyBrTcbRzUCpcGjJ6+K65CIx+1xS
	3a1iV0oWuQ3CSAmksD+CXlW9dOawp17a21a7b3gZZmogLZQ650Wy2erGpnthT0ZMzNXm9vxON9t
	cesIFGc+GWE2gFrcpN/YmHwlN
X-Google-Smtp-Source: AGHT+IHBNABRw3UbSzvGuIrlP87lXKciHZg0JsaKpxSUDEQmCGa7IwYsb8d2vZMsVK2RJ1/SO3YUyQ==
X-Received: by 2002:a17:903:22c9:b0:24c:7bf0:6e6b with SMTP id d9443c01a7336-25d26e47c11mr110147975ad.53.1757900969374;
        Sun, 14 Sep 2025 18:49:29 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-26686623f10sm11523175ad.23.2025.09.14.18.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:49:28 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v4 0/3] SPMI dt-bindings and nodes for Apple A11 and T2
 SoCs
Date: Mon, 15 Sep 2025 09:48:53 +0800
Message-Id: <20250915-t8015-spmi-v4-0-0574eda4ba5a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIVwx2gC/12Qy27DIBBFf8ViXSqGhw1Z9T+qLAYYEqQ6TsCxW
 kX595J4UafLO6NzRndurFLJVNmuu7FCS655OrWg3zoWjng6EM+xZSaFNMLIgc9WgOH1PGZulfV
 eu6g0EmvAuVDK30/Z577lY67zVH6e7gUe01XTC7fVLMAF9yoYg1GAdvBxGDF/vYdpZA/NIv9QC
 /CCyoaidIAhiah79x9VG1S+XlUNNdaDIZLBSrNF72ubQpdr+8i8VmIeK/G2H/O865x1Aa1RMRI
 ljFpbH5MfBgBQCZMLQVvhVN9k918eiBEbZgEAAA==
X-Change-ID: 20250527-t8015-spmi-838bb49d34ae
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=oSreoU6ZmkSN75RCTco6kgjieWSOH7uDaMA8CsUlAvI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBox3Cg6vCkFtk2gUKfofkTMYN1rFg/vlHOsb70A
 qiMAv3+rPWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaMdwoAAKCRABygi3psUI
 JMeMD/4ry6RelVSMt+gVOgcbYvGaKJQNQepagwG0kBxfvKJSzp2mDb5ioYvyighK9C5Fqazdis/
 NdWRCrGuNzcZY7tIaO3aPyeHf5yTa5148SP11XAPQG3t+rmg9ufFE5tFEJtWFb9YcnhGM32NlR8
 har6l8XzrunRGFCh7T/bO3t6LZLxwPfTx6ZZo0EXEbsKzEGr0im/njL9dvS7q2BUwArPSbvxqio
 am9yN+l1h/TjdWvMi6OTYgwnjEr0aWGly3AGkJ6Xv1R0731Sle5UPZxRnkOVilxe5ywKW3sDJ4i
 VbDygmzgetzxAh/UH37Q4e7mhYaq6/dAS057qXBoASrbTpvVq9mKANKWiL650xF8XvpkxqPF5+f
 VGxS7phVfNZfsQvWjjssk4pFIIqnbo0W/8hVIw/NDaoqP4Dziu6hwecl5JfXaPKrJbLGPxgo6Jq
 c4ySFOtg0h87IMvAh/egNye5z+5ujnSxrx6mcVdpj5/Y8A7BBSbin2RUrLnWp0UTvPa7t/dn751
 rp9i0Fu8URTXXycUpLfSj3n7WjkV6+oaqmEzBN+SVVGv9KpbOdyL6fsR/dSubD509ykCJpl1ZF0
 adYBzhymPqGlJoX8ubNHB6io96cmYd930j/JrtCckSvNC2GL3d25dvejoGTKav0ye73PFMoIYk9
 1fOv1NDd7Yv/9+Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Hi,

This series adds dt-bindings and nodes for Apple A11 and T2 SoCs,
and the existing driver appears to be compatible. Drivers for the attached
Dialog DA2422 and DA2449 PMICs will be in a future patch series.

The dt-binding patch depends on other spmi dt-binding patches that are
already applied in apple-soc/drivers-6.18, so it is best for it to be
applied through there.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v4:
- Keep the empty lines as is in the spmi dt-bindings file
- Keep DT includes in alphabetical order
- Drop tags for dt-bindings since they are sigificantly different from v2
- Link to v3: https://lore.kernel.org/r/20250829-t8015-spmi-v3-0-58b15ee2c825@gmail.com

Changes in v3:
- After discussion with the DT maintainers we agreed not to extend the
  generic compatible[1]. Change the series to the agreed-upon style.
- Now depends on a patch[2] adding the t602x spmi compatible.
- Link to v2: https://lore.kernel.org/r/20250811-t8015-spmi-v2-0-a291acf0d469@gmail.com

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
[2]: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-22-507ba4c4b98e@jannau.net/

Changes in v2:
- Rebased on top of v6.17-rc1
- Collect Rob and Sven's tags
- Link to v1: https://lore.kernel.org/r/20250609-t8015-spmi-v1-0-b3c55ad01491@gmail.com

---
Nick Chan (3):
      dt-bindings: spmi: Add Apple A11 and T2 compatible
      arm64: dts: apple: t8012: Add SPMI node
      arm64: dts: apple: t8015: Add SPMI node

 Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 5 ++++-
 arch/arm64/boot/dts/apple/t8012.dtsi                   | 8 ++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi                   | 8 ++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)
---
base-commit: 989ca853ddeefad448bdfb771113faf9cc480936
change-id: 20250527-t8015-spmi-838bb49d34ae

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


