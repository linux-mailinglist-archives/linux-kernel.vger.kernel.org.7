Return-Path: <linux-kernel+bounces-626119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFE3AA3EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 02:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754549A7974
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 00:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A69313CF9C;
	Wed, 30 Apr 2025 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B5mR4VJV"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38112B17C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971956; cv=none; b=jBbYY+303BL1+Q9tMne3AHELnfKbD9a7Dife18MAeVKd7pZfLlXILvRBPhR7KbPp9Vfu+mEEeNMkYFCReCbls6rKqzLwjuXlrqApN/8VdxR/rmO3lUOth1HDQNR4khKSlR8e0kkSxYFrQz3z92+g6QAjzxJu8Px82RYqlemymSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971956; c=relaxed/simple;
	bh=qJvAeC9PJ0yrfTjybs1QJ63QO49Ry6kSSEW1PYb/KCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csF/vGcFnMZrsAGIKsCObRMYtft8DZ2BPQgYoZBGI4oP4i0kakkUXCysuH9B1JELG3KMrs/f04+MFRh8Ify4jAIDO7BcDmjUpyFpgeXgln8cf4TDvV0Xkvn9fhEGXTmgh8ka87i8j4bGhmfWKIBADQPo9tePZu5tblCrJbJO0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B5mR4VJV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4768f90bf36so75863961cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 17:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971954; x=1746576754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s5gcOP/bkzD9yLDRr1nu8e/0M24YgRWFUxLhi7LbcA=;
        b=B5mR4VJVK5aZiN3MIE2zDyFkz1/I+UUKDVZ/Jglqg0mM2oAo1Fj3YBFchXnDN2DD90
         OdjBNFWqkeyfTE/oNh20SSTk0CiaYHL7y8K2JXXk5JuDo6ovGpN7BxM0uQdRte6NK/Nz
         koFYtJMacdZ7yVXB35IyAAICy6HRkXUrYt+ZOed6L5BXKnw1z0vwo5/7R1LgLcN4Dmi8
         6/wnPdbv90D4Xt+9X8HB/s7BdpFDevdvWGMT2c/i2bQkirYEK/FnTj2X5QTUGCa+u7q5
         fyykCrkTZmhTsV6vTlxLZq3Oo3GEVsD19y5FHkNZpke2W4Rbi8foDQfvnOca5xhiSN3u
         YXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971954; x=1746576754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1s5gcOP/bkzD9yLDRr1nu8e/0M24YgRWFUxLhi7LbcA=;
        b=izR05DTXWphLCN8aifRqaqlG+GMmUW+mje0ylolAsJHsGzx1hOC17vRQrJbG4nycMg
         utO10WfKy+gP+SBc8qNMynscxA/E/hfr0klcG6DIgPMnV5mysAS5zCAwWMEM2apxS3De
         SkiN6VMNvcHS5miM5+fHC4d/5yF8wiFFYqSOrbksuXwJjStgjQlVlPoaBtczraa9nxfs
         bwSTz0vhiPZaajdI2gAhoAYvjltwFiFkdlHATmJWie3fTVKWF3HKUTp6dab6/oVJeTID
         lmzmLZp2iLVCvFdw0YFLeHS8sYAc0c00iEhhF+xoTYPCMyxaXUaewzqymADEJ1KMleGD
         WE3A==
X-Forwarded-Encrypted: i=1; AJvYcCW9lUGG7b7R2Wxkt6rkZDj5UlzB+jHGsJqf81if+ItqjemDeHcs+E/RFV+qExoIewS6YW5ePIW8zayzQqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLzp62kNK5eKrr+JGcADcH+fqhjyQiTaVq4T954hgPgE+kQmS
	8tTGhj4J8y0z5frC0FYLumzpLY+xgLy9cxUbruUVRtFk7WwvK98AaW0J+5TqpyMa9M9qjxcnJ1m
	l
X-Gm-Gg: ASbGncsxW/7MFyjkcVEv4ASjktWz1jKPWahP+ZSchKTbtuGmzbTkalIwBMl3TzmExO9
	gUhDP0+lRxgNuQfIDyVSIEzl2anId7XE+hW2zosTZLL3mN8Y65mHlqtlSqd+/9+agRA8egr4PDz
	qrQBRYEo07oo43w6AxtcIJHeNgax8erWnNOygwa9r70vJ/UDwmVN3V5GcTnxGPE4MPSq9G3f1c2
	SgSkmYjnBL6Whd2rNLj1fsuUmwFwh2y12vOF1s5w+QtUzllqVoQsy3tKFqDFDZ0VMcDDt342Pq5
	IiZMGhuOpfEqXfLgYUjPbDeZ6TDmhrfiVEdQHA9dMTgLwCSFH/2tFr880iQv1z73utJntdI7q+Y
	OUwbHRD46emkzjfKVmUfALdNyQHDw
X-Google-Smtp-Source: AGHT+IEKGR2FHHd25LiYQesqqVIWnTFxWxv53o72vrO3uUoe9coBak8e3HrW/K1B4aZLE7+Z/ygLCA==
X-Received: by 2002:ac8:6f10:0:b0:476:79d2:af57 with SMTP id d75a77b69052e-489e4a8942amr9867851cf.22.1745971954008;
        Tue, 29 Apr 2025 17:12:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:33 -0700 (PDT)
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
	corbet@lwn.net
Subject: [RFC PATCH 01/17] cxl: update documentation structure in prep for new docs
Date: Tue, 29 Apr 2025 20:12:08 -0400
Message-ID: <20250430001224.1028656-2-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430001224.1028656-1-gourry@gourry.net>
References: <20250430001224.1028656-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restructure the cxl folder to make adding docs per-page cleaner.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../theory-of-operation.rst}                  |  0
 Documentation/driver-api/cxl/index.rst        | 22 ++++++++++++++++---
 .../cxl/{ => linux}/access-coordinates.rst    |  0
 3 files changed, 19 insertions(+), 3 deletions(-)
 rename Documentation/driver-api/cxl/{memory-devices.rst => devices/theory-of-operation.rst} (100%)
 rename Documentation/driver-api/cxl/{ => linux}/access-coordinates.rst (100%)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/devices/theory-of-operation.rst
similarity index 100%
rename from Documentation/driver-api/cxl/memory-devices.rst
rename to Documentation/driver-api/cxl/devices/theory-of-operation.rst
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 965ba90e8fb7..dfc0a4aa9003 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -4,12 +4,28 @@
 Compute Express Link
 ====================
 
+CXL device configuration has a complex handoff between platform (Hardware,
+BIOS, EFI), OS (early boot, core kernel, driver), and user policy decisions
+that have impacts on each other.  The docs here break up configurations steps.
+
 .. toctree::
    :maxdepth: 1
+   :caption: Overview
 
-   memory-devices
-   access-coordinates
-
+   self
    maturity-map
 
+.. toctree::
+   :maxdepth: 2
+   :caption: Device Reference
+
+   devices/theory-of-operation
+
+.. toctree::
+   :maxdepth: 1
+   :caption: Linux Kernel Configuration
+
+   linux/access-coordinates
+
+
 .. only::  subproject and html
diff --git a/Documentation/driver-api/cxl/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
similarity index 100%
rename from Documentation/driver-api/cxl/access-coordinates.rst
rename to Documentation/driver-api/cxl/linux/access-coordinates.rst
-- 
2.49.0


