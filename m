Return-Path: <linux-kernel+bounces-860711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7EABF0BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B35188D7CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ECF2F83DF;
	Mon, 20 Oct 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhEOgi5U"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4F32F83AF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958702; cv=none; b=AHAS74Kf8cLgcaHa4oKeyn74Aq5WsPnC1C2PEfIiO2h0BUJhOcTpyWe3o0REKKbEWb+6dAnJDbtkKd+InlIr38/5kaopHFeojR+7skKqPpR39YwV7Ouvl01uy5h9vBhyELeDlOj9qtC3L7hESaX4B5XPD3HV2evtEvuXat6KNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958702; c=relaxed/simple;
	bh=/u/sHVZSfi2e7MdgOitq2zS+yVeC+SRdoWU5NFexqrU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hX5RbE2vGw6i25+zjTZ8UY9lbH8Ko8/FVzNhnXEAIHepJIzGuyVs/IEmMbDNWYCDIf/bCmjzbDw0WMpALBCloVcep3a2i9cEXCs4fCDr3uu7iJ1D0IQKEoM/99UKo+uIRKGyADKijWZyxSmTASWqWXnRCVMAHMPHxrAKfvjeNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhEOgi5U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711810948aso27748405e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958698; x=1761563498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1J6WMqH03oILDs2/tT5ntrxwega9iCwgysVz89dOfmY=;
        b=RhEOgi5UXsSU8vNyKz4oBwYPFx1Uzzzf9JTlFu2Dd88WadnggN+nWEI/T3+a3D6eLC
         d0GwMBepUd+UXj7RMdPkiRnX4EKTdsT9dWfKhmXemlBPqdRj5c92UYEC48OyYy89C7PY
         DkNxeN6uPpUX00JOG2niIt6fsxg5IOmXgL/7QX+J8k0NLZm14AYWNr9whKDyTH/csKuG
         Nvk3MQB8LR+f3XUGeKOKvDxWS3WoRb9u92JE+Q0A07o0MWWQsis3FquRfH6UjK6PrS45
         GYkMEiHdhr0A4Fs4trwPxn7LfErpW69Er5PA13bURCu4Mnb7ICobaqdb8fHZZ8Fwv8QF
         fSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958698; x=1761563498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J6WMqH03oILDs2/tT5ntrxwega9iCwgysVz89dOfmY=;
        b=s4hNSN1BVSR57rgraXJH9GK8CzQH41YrYEDu68GBb1/jGttACmj9xE+MYKf13TARbQ
         y/UGvGvqwRARKZFPzotdxjDz3KsZEwOf+5bSTKumdbpTRp4ijL/FZ9GAb4+4v88AHZEP
         N/srQyetqtSqIKV6mrpigyLkq0Kqe6plqFobvkirIgypETLP3MVw20ldk184eImqUNpO
         p9nj0K0US0mBxeDuNyLqTTeKM/KPOrAj1h3c4BeC5apqo+ROtxqkeUZ/j4IZXKolkML6
         X2tMAWvlt8oGiF/uu/vFTyqLD0Rmc7LG+Kj6EFBusNbLh0EelHf53KA5Oqe6+4MSQEQK
         FLpg==
X-Forwarded-Encrypted: i=1; AJvYcCXnLCUyGg0HRdGfX3zJeW+0is65j/xq5Ct6HVY6GZzPU+/TRtCxVEfTjqB8SIeqrAScHqHUYj6znghiUZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQS1wqCkjdOGLD0WDjxpci/3lJmCFsHYbnyRjWGIyAWRw7zo1d
	2K1AW2Lw1PgKteQvNqXh7xz2vRH2L4N/+shxtoaxTMs4oy9e1XFk7ZoZ
X-Gm-Gg: ASbGncvuidHdREhXfPFRyzHiJCqymH0MPgUX99uV6C2RIsaz0ruTS88pN8pgZ5elYR3
	KTMHwEwMtrYNW6BjRha1//yYrEOd+yYvlVTXKBFiIeYni2gcG54ZM2xrqNk5ZfYZdX2FjiBdPyL
	ostcYTkzaIFc8TCp5ko3pCZ5tC+HHqNR2SRk8Tk5Oswb1dci4eYXYn1Ga66HN51t/oH9MKjVouN
	2MdotcoB/8JU4SEbrN6KhL5iuSqmHwPyymyoaKDbKSwZsNfJ8bm2/Z+yMMdV8VLMF7pdcYGm7DB
	7yiMOXforRxk8LdF0yHorAKClxbwWy3zhv2XLcSYr2/1wpYMz1ggKUrtQ0lNY4BVB7iifiattDi
	c+CvuIBIpEhzE43XpEU6JB6thMwAcLQcbJMdcNKNgm/mSsVU0kFYkB0OSvBX+70DPtTuY6YMAHu
	VcLnIkjf/HJ8ZsytHMsGU9hV5pn8b9C/wFu83GbigkTMY=
X-Google-Smtp-Source: AGHT+IHVbG6TZHa2zycGcNFH3hDK5XZiaq2XHp38I80LU/N8i2ztgAzL/k/rCSUQlcdD5KrEG0KaOA==
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-4711791cadfmr110884785e9.32.1760958697834;
        Mon, 20 Oct 2025 04:11:37 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm12692219f8f.10.2025.10.20.04.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:11:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v6 0/5] PCI: mediatek: add support AN7583 + YAML rework
Date: Mon, 20 Oct 2025 13:11:04 +0200
Message-ID: <20251020111121.31779-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This little series convert the PCIe GEN2 Documentation to YAML schema
and adds support for Airoha AN7583 GEN2 PCIe Controller.

Changes v6:
- Flags -> quirks
- Align commit title to previous titles
- Drop redundant comment for PCIE_T_PVPERL_MS
- Drop DT merged patch
- Add Review tag from Rob
Changes v5:
- Drop redudant entry from AN7583 patch
- Fix YAML error for AN7583 patch (sorry)
Changes v4:
- Additional fix/improvement for YAML conversion
- Add review tag
- Fix wording on hifsys patch
- Rework PCI driver to flags and improve PBus logic
Changes v3:
- Rework patch 1 to drop syscon compatible
Changes v2:
- Add cover letter
- Describe skip_pcie_rstb variable
- Fix hifsys schema (missing syscon)
- Address comments on the YAML schema for PCIe GEN2
- Keep alphabetical order for AN7583

Christian Marangi (5):
  dt-bindings: PCI: mediatek: Convert to YAML schema
  dt-bindings: PCI: mediatek: Add support for Airoha AN7583
  PCI: mediatek: Convert bool to single quirks entry and bitmap
  PCI: mediatek: Use generic MACRO for TPVPERL delay
  PCI: mediatek: Add support for Airoha AN7583 SoC

 .../bindings/pci/mediatek-pcie-mt7623.yaml    | 164 +++++++
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ------------
 .../bindings/pci/mediatek-pcie.yaml           | 438 ++++++++++++++++++
 drivers/pci/controller/pcie-mediatek.c        | 113 +++--
 4 files changed, 683 insertions(+), 321 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml

-- 
2.51.0


