Return-Path: <linux-kernel+bounces-626118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 863A3AA3EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 02:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4106C4C379C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 00:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D1D83A14;
	Wed, 30 Apr 2025 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mtXtP6sn"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4D77104
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971954; cv=none; b=Vfe6uoz0aUH9poyWg9LeXyMg/zJArWwWy8rbcJm2Y165ZxKlndSBmRvMnPnq6WE1BC8GMasj8VWMwXUIjexrh4Vhw5B1N8ljp8GVPaX2CTQ6yWZf5S54ISKxtlLmz2F2OsyfOf8zl6ULWRNuTsof39pCorVNJUSPY2vaCi9gwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971954; c=relaxed/simple;
	bh=ZXjEjXsHfjUa0iCrPCgE3lVEAf2malrtgL9WvuAkaWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJHoEbi7bgTrPxT17CbHhdEG75DfW6/vQFE+krTQt51idvtE4F2Y+y07R4O10dZdNNTSNEkB3gncTD+6Pf/dVsQaaPZqZh5M8p0/klX8+Ijxew6qda1qG6Fi+PQDJeySIwfRX9I+js6PZjf+lLl2KkX/o1ASUFGnTD/qiOrb67o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mtXtP6sn; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4774193fdffso122581311cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 17:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971951; x=1746576751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XwkrHfxPIhIcdIYIVNv5VYPO5SHZTfxK8AinQWxi748=;
        b=mtXtP6sn+DLqWZQ4B5+Mro5FUX85BEkBA3C3KO9jKMQmmXpaPLzCeV1KEZ19PUUGst
         zAjEmSmRJ+M/yclCin2aoVvRAoblqxbD6vll5J6soNmHBgiz4aEo6qqGan3ZAfanB/Q3
         ACA2BmpMI2FAUVVFMqwdb81dXFPj/SPZXFnoWliniuA1LeoiKxAhxuOIRm4eWQOQuJJt
         6no3Pj01tYYx0nBGN9aKLev4SS7v1vU6lWJoR62GHqilH70jX03xFUWl0Uh4Ho9MaXW6
         xxImKq++nNHIULW7LgV/Nxl6kxjRdvh5U2HJ8vTxNrGhsgC3Rt2X8pCfKzVmFYhEAPV9
         RPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971951; x=1746576751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwkrHfxPIhIcdIYIVNv5VYPO5SHZTfxK8AinQWxi748=;
        b=umXtrDGAqZY/h2o49LqTTfs8lkctzRjOWTWaqmgBcBBTgX5lGA+BjYIdtsGqVcA1Ts
         Z4NQ9f1TBtNPFYp6WuSb13f/jlkzZzLZjlwblb083P6AbuzmJrSYvMwBYA3XvrBmKmHv
         +6wl6OvYFM7Dc6F8DbqQQ71OjUPaG7BlKNtaZOaG+1SRfTri+QKsewIhNUbpTOVatrtB
         OUMrRMcAG9IYkDFHUaXXopVDfGbr4HeSsXlSSsyJIiIy2KDnzWKUh4DcmvtB/H8oi51X
         clRs6fs5M50q0ROLxcBsWKUemDLL/jsPcHvIQYKOi6Q1VnNU+1g0Zl+RPqejLU2Lt4AK
         ioRA==
X-Forwarded-Encrypted: i=1; AJvYcCVj791TT9yEd9FjBhHFlg0KWHtGVXlBtHS1zyRXtcaGXFNIl/K1pLKlPEN3OK0PAVrDmSraqzHBY9cOtWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Ed3AZqEh3+WotlU9FLhb4Gavf2TSZta+Rq5Jox1wSxft+j12
	ZWLjKkTdcH1ebfPomNzRvZXM1V9YW7y6Oeduyuq5kj6+3QRleZWFqOGSUz3dFaDK+46e/GReHnf
	t
X-Gm-Gg: ASbGncu7LE8EutNmB6UAjHj5rYrMmi08ZjfcNqfy6spDjscsDU/yCnUX0/h4muu1oud
	OkH7kTSKtkL55dZMnobXJfqnPxa1rgXkDHrqUdJRRogjSEFRLWy0XcJBAWgJ85SlI25T+xKfdKL
	JHm6ceVZ7+zhW/JwXbilc0axN3RiP4apc9lhGIdJ/m856QI5l5VW/r9scxZI109TnfuTMVkPtZk
	Fv8XYYakFQ8TDEQrXVCgQKsj5vr/xEnXatPfZ9liuCMK1Ab45U43Dd36c19NfzcDvXuwH/mA4v5
	bYe9DrsUAB2SxCsBZ/GDYHflFPgL1zP5M0clDoE1k7a8FrcSjX5uBiaJNWu2On5bN2DTMgr43Wo
	wPQPcah3As0ktRve8DuuvNVgomT2z
X-Google-Smtp-Source: AGHT+IGx7yWMnstTX6Ocxy96mhz8w9pNto5sYt4gawjQLHNDDT1JWwKm6SA8P6j6AQaDIRZciIZTvw==
X-Received: by 2002:a05:622a:2b44:b0:476:b7cf:4d42 with SMTP id d75a77b69052e-489e4f6e095mr11161921cf.27.1745971951326;
        Tue, 29 Apr 2025 17:12:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:30 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: [RFC PATCH 00/17] CXL Boot to Bash Documentation
Date: Tue, 29 Apr 2025 20:12:07 -0400
Message-ID: <20250430001224.1028656-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts CXL Boot to Bash Docs to Linux Kernel Docs.
I tried to break it into separate patches to make it easier for
people with specific expertise to review.

The big open TODOs:
- use-case documentation.

  I only have the type-3 perspective, and only one perspective.
  It would be good to have that hacked on more generally.

- memory tiering documentation.

  I basically left this unfilled for now.  Would like some basic
  docs on at least TPP and DAMON.

- devices: CDAT explanation

  It would be good to have this spelled out at least a little bit.

- platform: ACPI SRAT Generic port / initiator docs

  I don't know anything about this and people say it's important.

Thank you to everyone who contributed feedback during LSF/MM
Boot-to-Bash proposal.  Hopefully I incorporated most feedback,
but I may have missed some.

Co-developed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (17):
  cxl: update documentation structure in prep for new docs
  cxl: docs/devices - device reference and uefi placeholder
  cxl: docs/platform/bios-and-efi documentation
  cxl: docs/platform/acpi reference documentation
  cxl: docs/platform/example-configs documentation
  cxl: docs/linux - overview
  cxl: docs/linux - early boot configuration
  cxl: docs/linux - add cxl-driver theory of operation
  cxl: docs/linux/cxl-driver - add example configurations
  cxl: docs/linux/dax-driver documentation
  cxl: docs/linux/memory-hotplug
  cxl: docs/allocation/dax
  cxl: docs/allocation/page-allocator
  cxl: docs/allocation/reclaim
  cxl: docs/allocation/hugepages
  cxl: docs/allocation/tiering
  cxl: docs/use-cases

 .../driver-api/cxl/allocation/dax.rst         |  59 ++
 .../driver-api/cxl/allocation/hugepages.rst   |  30 +
 .../cxl/allocation/page-allocator.rst         |  85 +++
 .../driver-api/cxl/allocation/reclaim.rst     |  50 ++
 .../driver-api/cxl/allocation/tiering.rst     |  30 +
 .../driver-api/cxl/devices/device-types.rst   | 169 ++++++
 .../theory-of-operation.rst}                  |   0
 Documentation/driver-api/cxl/devices/uefi.rst |   9 +
 Documentation/driver-api/cxl/index.rst        |  55 +-
 .../cxl/{ => linux}/access-coordinates.rst    |   0
 .../driver-api/cxl/linux/cxl-driver.rst       | 531 ++++++++++++++++++
 .../driver-api/cxl/linux/dax-driver.rst       |  42 ++
 .../driver-api/cxl/linux/early-boot.rst       | 129 +++++
 .../example-configurations/hb-interleave.rst  | 314 +++++++++++
 .../intra-hb-interleave.rst                   | 291 ++++++++++
 .../multi-interleave.rst                      | 401 +++++++++++++
 .../example-configurations/single-device.rst  | 246 ++++++++
 .../driver-api/cxl/linux/memory-hotplug.rst   |  77 +++
 .../driver-api/cxl/linux/overview.rst         | 104 ++++
 .../driver-api/cxl/platform/acpi.rst          |  83 +++
 .../driver-api/cxl/platform/acpi/cedt.rst     |  52 ++
 .../driver-api/cxl/platform/acpi/dsdt.rst     |  27 +
 .../driver-api/cxl/platform/acpi/hmat.rst     |  28 +
 .../driver-api/cxl/platform/acpi/slit.rst     |  17 +
 .../driver-api/cxl/platform/acpi/srat.rst     |  37 ++
 .../driver-api/cxl/platform/bios-and-efi.rst  | 261 +++++++++
 .../cxl/platform/example-configs.rst          |  13 +
 .../example-configurations/flexible.rst       | 296 ++++++++++
 .../example-configurations/hb-interleave.rst  | 107 ++++
 .../multi-dev-per-hb.rst                      |  90 +++
 .../example-configurations/one-dev-per-hb.rst | 136 +++++
 .../cxl/use-case/dynamic-capacity.rst         |  19 +
 .../cxl/use-case/memory-expansion.rst         |  14 +
 .../driver-api/cxl/use-case/shared-memory.rst |  14 +
 .../cxl/use-case/virtual-machines.rst         |  18 +
 35 files changed, 3831 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/allocation/dax.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/hugepages.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/page-allocator.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/reclaim.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/tiering.rst
 create mode 100644 Documentation/driver-api/cxl/devices/device-types.rst
 rename Documentation/driver-api/cxl/{memory-devices.rst => devices/theory-of-operation.rst} (100%)
 create mode 100644 Documentation/driver-api/cxl/devices/uefi.rst
 rename Documentation/driver-api/cxl/{ => linux}/access-coordinates.rst (100%)
 create mode 100644 Documentation/driver-api/cxl/linux/cxl-driver.rst
 create mode 100644 Documentation/driver-api/cxl/linux/dax-driver.rst
 create mode 100644 Documentation/driver-api/cxl/linux/early-boot.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/intra-hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/multi-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/single-device.rst
 create mode 100644 Documentation/driver-api/cxl/linux/memory-hotplug.rst
 create mode 100644 Documentation/driver-api/cxl/linux/overview.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/cedt.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/dsdt.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/hmat.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/slit.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/srat.rst
 create mode 100644 Documentation/driver-api/cxl/platform/bios-and-efi.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configs.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/dynamic-capacity.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/memory-expansion.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/shared-memory.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/virtual-machines.rst

-- 
2.49.0


