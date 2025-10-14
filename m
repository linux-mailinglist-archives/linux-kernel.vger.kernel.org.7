Return-Path: <linux-kernel+bounces-852445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40ECBD8FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526923ADA58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC542DC768;
	Tue, 14 Oct 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bta5ycB1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F530BF70
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441174; cv=none; b=KrzwGmOwaTXBvLXhdnAFkEUL4A+sKgixGqNGhJjNbL89z/j66q6abrkH4R230bJPNFVuCGWrHD+MgCPvAAFxruvFXMdn2hy3vYVp7VTSahkJnlHRZfyPACmm1znbUCfKj9JJdBTHym+8Jxzgd4gaySucDGd4onwGtHHbgUW0y+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441174; c=relaxed/simple;
	bh=AxhzSl8w445Qz2/9QmnikOtBEtA4YSeYe89CVab5wLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fXOj9UWJE0OxO46Uuo/FlHSCIH8OqvpQZZiOn3VQATZtcHoHbIGAI8w58GZtAn2JN5rQ35MOuNr4zH2Nda6gwZwevHEEU+pxLJr7WHLt0McMNyWuoQi+wynNma4zHDo0WKl5/q1abStf3NllixRW5umoqf921OfkfjGEQk7C15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bta5ycB1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so53076315e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441170; x=1761045970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkgjM/J9Iy/ZQpNJ94vlbj27WexN53OWj0CXa0A7G+Q=;
        b=bta5ycB1i5svdSaKk/wvRw/YwXazpJL8e7sRG02w5K0mVO+o+DIgR/a2JIoFbhtKuj
         SPS61tSYPLJGhvN1gBoCGyoiGuyiV5MkY/z13UUbYxEusP+Tp35f7OHa3u/uxqTj5TOs
         F2JS9+GcxUvPdtBJ/vN1uW+BoljztnVKxz36w2x9U/ngZ9BW+ipMdp6lsSK7KrnBkqk+
         IwYubRRB64hq+s2yQmDjdJQVz7aMHJKAKOCrQ/oWLqN7ZyZA9jWUBv1pOZ1K659ffKxc
         AzrikcPwd4pLWOM1WkAQjI8pXA0OTuE9T22B5/P53i8e3TRe21KOYJVLTNd+PYekmGUK
         POAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441170; x=1761045970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkgjM/J9Iy/ZQpNJ94vlbj27WexN53OWj0CXa0A7G+Q=;
        b=h1cVOsmT/UFplsKiFIg6/kcYK4+VlGYKXkQRlu/s7K5JLWVCEOj0eBdgONiGFdr97e
         sDCfOUnla8AQKY3XhaLVoln222MqHLJpwU1P7fqsBWfq7ANFxROKskNZchcmklUD0caw
         HK9QOAavDKQKkmeWCHxcQ6BLJOpyqmqbHiomzxNVffCVh56BFeSIyj+spuLaIr5D30HC
         8kEkUekYaRnZqEpRx1PYTEPlxvaduidtpGpU7tH7H7XJnhzdRTPB3DoyQAhsgrSGg+bB
         XeUhAVs3rDkvYu6KDLH2+Y9QUVpRsQSjMbAtVN+DADbqUgCrxWV8TgfkZUoNZeqbsBGA
         l1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWlR9FNTz7Okd4GBKbUmLliDp6uBmP6F37m4m4fe/qMJmCZe/a5cq+Qk2RPlQCk/xDKLQCGvykvgLz+lZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweWLCIimym9JMdH3ayIEr/KDE4mFYRRAOTSIwidXgx9nPzzfA2
	MzCWWhmgd5N7CiTE2tLcB3atKBECRn4f4WGtuoOxFodFyn/sWwvw93T2
X-Gm-Gg: ASbGncs48A3TJykCQQ+aDpoWugL2qieEu4BeF1NEKCxI9x5mAVIe5vJuUQQWXVKn3NF
	553uOOMd5/LBy7RLk1uhrmWacr7qcFMgE3AxjnWlE9A81yUaOHUelxapaqd+IPI/CTYXhJ1kFOl
	OHXyxsbCA2u6TmhX+fGWdgI1MoC/LU/k9T7NLHfT20MEWyiYj6OvsoWmxOv+PyFaNE1FKNdJPXz
	bYmznv9oDCM0CH4Oi6m1WINDCqk7gfBIYXcaj3eLhnZMnnNXSfQr8tWT0ScJYLas0LcNdhIk6BT
	6xsrdoD+1Jm+YYGFxF741MpAY3B4DJ223sVzGV9eCYg0rwgcdDDrL343dFaVlhCkIV/1iajaT5N
	xTj9wgzaQgkZpb10d2In6c/agt1Ke7CTvmZmjojO6U+5Temy3aLBLRkPdDrOLep9AFIDP
X-Google-Smtp-Source: AGHT+IFMf6DIq4h/prpv03d57pehdiVcP3X28cHjsLA6mXHmxzjuKa4nBjbv0JtAImSeizIQEmRacg==
X-Received: by 2002:a05:600c:628e:b0:46e:4cd3:7d6e with SMTP id 5b1f17b1804b1-46fa9aa0b49mr152941585e9.9.1760441170197;
        Tue, 14 Oct 2025 04:26:10 -0700 (PDT)
Received: from vitor-nb (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb492e6ddsm265829845e9.0.2025.10.14.04.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:26:09 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ivitro@gmail.com
Subject: [PATCH v1 0/2] PCI: j721e: Add voltage regulator support
Date: Tue, 14 Oct 2025 12:25:47 +0100
Message-ID: <20251014112553.398845-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

Some PCIe endpoints or slots connected to the TI J721E PCIe root complex
may require external voltage regulators to provide 1.5V, 3.3V, or 12V
supplies. These regulators depend on the specific board design — for
example, M.2 or miniPCIe connectors often need 3.3V or 1.5V, while
full-size PCIe slots may also require 12V.

This series adds bindings and driver support for these optional regulators.
When present, the driver enables them automatically using
devm_regulator_get_enable_optional(), ensuring proper cleanup on removal.

Tested on a Toradex Aquila AM69 platform with a Wi-Fi PCIe endpoint
requiring 3.3V.

These changes are based on upstream discussion:
https://lore.kernel.org/linux-pci/20231105092908.3792-1-wsa+renesas@sang-engineering.com/

Vitor Soares (2):
  dt-bindings: PCI: ti,j721e-pci-host: Add optional regulator supplies
  PCI: j721e: Add support for optional regulator supplies

 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 14 ++++++++++++++
 drivers/pci/controller/cadence/pci-j721e.c         | 13 +++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.51.0


