Return-Path: <linux-kernel+bounces-855678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9FBE1F45
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0D974E258C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFEC2FB96A;
	Thu, 16 Oct 2025 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwvrmy0F"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943D2417E0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600545; cv=none; b=IJ9hO2mHZN9F5NQMqA1UBxBg6MnXG308jEruVzJWvYQvkC9fGtvmSboiJ18G7DR4Ki5PQQ5Hmo50ibKY9JVHJEHqPTffBZyixVSHC2aiD1L05yEEqxNUNe83wxy7fHMiKpMh8kZMHZFHknk9zxIbW/t0Yt9RgECU7Bze3x8hrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600545; c=relaxed/simple;
	bh=TI1ysOXPP4hVMHn60o6TUG3RYzs3fDZDuOhKElmj1NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QB4bvdkWcgSV9oys+V/0RgvfS3U3eBhXEMUW6Vw0KCjBBDQ/2ifrDG9Hm+W5fl0EwB+wU7w6tuvPu1dmf7Aljl6i2feACi57l8gn/Xm7NAhl9y7b0khTyUfnklcKtBqHLWFKDSGwOLNuy0s/IelSSk5uwC8lC81P/InnPj13Hek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwvrmy0F; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3612c38b902so3586301fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760600541; x=1761205341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e0TL/ekeJOQg26wztgmTDgEuvDo0zmkivmyNIAbPqQQ=;
        b=Lwvrmy0FR4SSoTtcsz+k6eel0nldj4A65RjZdGhN88JE/tBUxH96s4h+YSwUtVEMd6
         V7+0OEX1S4NMBNnqFbagKcBO5U2sHUPKo5su3skF2mkklIze/l+3Qw/PB0SyOnR6a4z1
         PZNfDKybX+ET5BdHo4XTi1drTMnryJO63v44eDZ2zyFNOb1xBrVFKGVjE8YmSriA28qP
         w8STUjf5qEqlONfS0WIu160nY+7oGQ5cOulO11V6tMwFM4Y2kai6iiR0cvAPC54EfU1t
         RR5hrpGkGY7HFzWmLaPyTllMQKV069nSrd150HjZPXCMo8VMIvucyem3reIAd1/q7GgI
         6y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760600541; x=1761205341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0TL/ekeJOQg26wztgmTDgEuvDo0zmkivmyNIAbPqQQ=;
        b=YOYcuzEqmEBk4CD7OJhUk5zIMPquvBP+YxofNs5HE/SlAIJ4rH7fPv9jFz7mNer2Mo
         O+TlfmrxbZwTZ7ACku57wpeL9ffaeIdJ1uC7E5uNVTe1YvZhxOIirNmcQmL5Mb0tM21n
         3LEEP+k7tPABOxvsbf8by5xP7yOeZ0zaUgUcD3AB87oDdf8KH7UdkfGyG6UPwPpV0bmk
         qTyBF84sqliCS6bBeMFWrgyzqVcwXF0nNBAA49bz8goMJcTEpG75tSKIFqnzi1h6Wgh1
         /apJ49z0LxrVlCOTdbBSDf0joM9/niXGA3yaxbTaPnVrkCohBqu7aBHgdTxcsfzjpbUS
         xKUA==
X-Forwarded-Encrypted: i=1; AJvYcCXwK/JYITVrYef4rwXvF1Pr0+vmE6S7R7qfwfeXTjF7g4onrv7Qzu/DW3ZW+F6ZTtYHDu7nHoTTgy2sV7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyACPBs6734F/zrTMs/+jwqPwXemmE7IjrNK1Y456BdNeLgEx/B
	QkOc/pVVjpQLxCmyFR5XNLzOIXSt2lsFMd4/3yUfju1M1xi0D/3dJIeQ
X-Gm-Gg: ASbGncusLoLScMB1A7cLVcCDqv49m2WgRb7KO+QffVvStJD12UEaLGHu8mSgd+FHZi5
	LjbRePoPcKg/akYapvQGVUfG6c+ePRZ2m2cVagDwYNXlNLXUjBGciUx5lOWlU4TRAh4NqOqclCg
	BqGL36DHuUq4orwd9ZgUGG3tdV/wcX061O1wiuvOjCR0BBWeVElKe1CMU22x8suZjHmB+mUAsIn
	TU5iEoAFbP5Fnq1mJostIL5ACtx0DFOUBup0Fl+XpbJDeU+XvkTfYXTxxjRglcTKOPbuGw2pTQy
	pymr9nbJA4SjT/McltC3tkRvV6M8vNWMU/PSzlWAf+nwl4jJWm68X6QfGZmtQDXk2mToauowTtg
	U4UhoekM66eZrix3zpwTIVvhnxDVYCpUHIP2HwXz1Az19Keb1xSnNlabXZBYST7Ob6J17QZ8tJs
	mCmg==
X-Google-Smtp-Source: AGHT+IHbI5nRs9M56J22ztjzyvcXIL8I57Igr4lqZlKhfr5x5C0oH/gLGKHadu7CjkSyNXpdSbLboA==
X-Received: by 2002:a2e:a99f:0:b0:372:4d3d:aace with SMTP id 38308e7fff4ca-37609f3086emr82578691fa.38.1760600540863;
        Thu, 16 Oct 2025 00:42:20 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea14d46sm53226121fa.34.2025.10.16.00.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 00:42:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4 RESEND] ARM: tegra: complete Tegra 4 and Tegra K1 device trees
Date: Thu, 16 Oct 2025 10:41:48 +0300
Message-ID: <20251016074152.8759-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complete T114 and T124 device trees.

---
Changes in v5:
- dropped clock and reset names from TSEC schema
- removed clock and reset names from device nodes

Changes in v4:
- configured tsec schema to cover Tegra210 TSEC as well
- added required to tsec schema
- reset-names preserved for consistency with other host1x devices and align with T210
- added clock-names to align with T210
- operating-points-v2 check https://lore.kernel.org/lkml/20230119131033.117324-1-krzysztof.kozlowski@linaro.org/

Changes in v3:
- added tsec description
- swapped compatible back to use enum
- clock and reset description dropped, added maxItems: 1
- reset-names preserved for consistency with other host1x devices
- dropped interconnects and interconnect-names
- dropped isp nodename
- dropped multiple rest names for mpe/msenc
- dropped tegra114 msenc example
- fixed reset name in second isp in t124 dtsi

Changes in v2:
- dropped accepted commits
- added EPP, MPE and ISP compatibility for T114 and T124
- added TSEC schema
---

Svyatoslav Ryhel (4):
  dt-bindings: display: tegra: document EPP, ISP, MPE and TSEC for
    Tegra114+
  ARM: tegra114: add missing HOST1X device nodes
  ARM: tegra124: add missing HOST1X device nodes
  arm64: tegra210: drop redundant clock and reset names from TSEC node

 .../display/tegra/nvidia,tegra114-tsec.yaml   | 68 +++++++++++++++++++
 .../display/tegra/nvidia,tegra20-epp.yaml     | 14 ++--
 .../display/tegra/nvidia,tegra20-isp.yaml     | 15 ++--
 .../display/tegra/nvidia,tegra20-mpe.yaml     | 18 +++--
 arch/arm/boot/dts/nvidia/tegra114.dtsi        | 64 +++++++++++++++++
 arch/arm/boot/dts/nvidia/tegra124.dtsi        | 64 +++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  2 -
 7 files changed, 230 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-tsec.yaml

-- 
2.48.1


