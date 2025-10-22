Return-Path: <linux-kernel+bounces-864861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 377EBBFBB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF1E7508D68
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37F33FE1F;
	Wed, 22 Oct 2025 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ee4PHVbU"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294528507E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133539; cv=none; b=AOnv5SgapO+RVMlSZHaKKlQrzZdfYO4AtlpehYK8lJ63DbqQkDomQyoallTw0AFxi63HMEESkHFsrdFs3k7T+f8OiGoz1wvMQIBXKScHthi1txN1B5iaWsIri005oVW+N4Q/TjCo/9lAC1FsS0sV0kTn7iZ11BbvW8P03OdvuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133539; c=relaxed/simple;
	bh=Yhb/PBvrt5X7r833z0XAWWWPGFFAkEhlDlHUakZ/iGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPr98mAr8vQB/L/75Mbh/YfuXdRefJeKPfHehKsKnSOw6+p28/hAX+udjSVZpcg5oMEuoLGdKgp0hMJqVWFxdvGTV2qTAarAqqRULYtAtBBT3wynrxjtrAfYFEaZ8XUBopqzEwF3mb6uaaqldXBtaSs9q6ZxuB5wYEBsYDLD9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Ee4PHVbU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33d55b7a073so623743a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761133536; x=1761738336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+364B2goDi5SXexfzIUd5evbYxen+JjS04/fWf2cdA=;
        b=Ee4PHVbUqp3/sjDktvw7tPgD/3VgaLmkJbIZKigqpQ0KQcaVIYmNaUOvHOY9YtGFCs
         931xrTrUHeYTyFqMJfjlOd0VnRJSt7BH+1YduNuwVPnL2qqFQxhiaFS/JEhTzNSEtbcX
         gR3aEqzmCXNKtyydB69a7UyBPL1+x273CWQZrDBmASVX0nVFIxpTguZscdBl7WBR23Jx
         5guijxxvkROlL/2Lti60c7DuI2I106Jqa7yVo8x5Or6xWD0oLZRjKJgCv2olaV4MX2MG
         NlXTBNRlKeOaAocB+MB470nOmQH6JxFUdgeLIUjOIi1fi5ESL7NIeTNhcYLiHHT+Pgq2
         vuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761133536; x=1761738336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+364B2goDi5SXexfzIUd5evbYxen+JjS04/fWf2cdA=;
        b=cpJ9ojTrV0xg/G9Ay+UrM20gVqB1n6IpZOriUEUPpuAvC7kF73C0r9kLGhhgVGOs84
         eCBrqNjdIOlKCzT3/lVbFGtn60EyGmIkSc+sWQFsSkwhlO74a4hOgN2ipKooL6TZ3gHH
         Msn5TVNYQ0dEVP1s0EHFuSOmiM7a6eDK7DUsgUn9vwOKsPZGMhrhYROi3IYlbqVPtfgQ
         bImC4E7FuJvDzD9nltIduqVp2AJjl126ueuwDYf9BEKGj+U9GYmAjVrHuEviNVg8SBou
         BJ1dMKaQ0hIYWeJqcu2FMAWHsSyvgIQHHfbGmtY3OB9m289+lrwK3apl9KVeIAJvc4ie
         trTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgfRFWhYwdpr7vyCnMa12GACnl6jN2nmNcJrfIASGCBqMMBUFkZNyzWPpaShxRMtVC/H7tUyraT7f1bdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfZ8Cz2cUOxIMF5as7DEWYczj/xSzx0S4QdnxOLV3KDEjw7Fj
	2i7Rv4Qer2hYLbTI1REAsycSO67FYyG0hro/AMTxjFYfR0civ/FOuFVbhzCBEkpsGA==
X-Gm-Gg: ASbGnctkcmXTjy7RKmKcergOzOcD9BbDvJyn1yTaE9aC2m8LBn9NPLlc/U1WLPtfsGY
	byGKvbg/5uD6qHIX+QVhokimUDZblfnpk1U914gREFaem1sf9whhPMtJ8OLnQ02kTl302fakHXa
	p2VOgAUn0xyJULgyFJ539vKgI1XRBvVrOzdrKQewo2fh86bTStHqpSOgWR2pyS4CzrlbrGDMW6/
	tVTbqKT3/rGJLIu7jsnBgPchVOlCNFj9u4PR0EHXHEhwPBRL/1MPZk1l56DQQrYc5wEkRDJdxsU
	xlPjF02Rhag5Bz7IbxQQvLDb9sWH4kQUdCAxU5APtUDxsOr8oO6CqViIFjEasC2MsquhVFEs2Vz
	4uzVRhdkTokkp7xkAU0MlcMFVj7R93q3ogJPJ5SpovYqX5VW7kIk3E7tV90mJ8LMpI0mRlrhyew
	xE+sdjMNiCFVrLSHZ+5g9ltA6je7gq1BjB6lrgMjF5Fl+mEwgv0a2p
X-Google-Smtp-Source: AGHT+IFgJEOxKi7Fm8pdOF2AraOOTO/abP9OXzEw72bKEq6mF/ZI06MunKiyaKf6R5/TOB7ovWFd2A==
X-Received: by 2002:a17:90b:1b4e:b0:332:3ffe:4be5 with SMTP id 98e67ed59e1d1-33dfabae6f7mr4649896a91.7.1761133536392;
        Wed, 22 Oct 2025 04:45:36 -0700 (PDT)
Received: from adriana-field-alert-pcie.sjc.aristanetworks.com ([74.123.28.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e22416d3csm2399895a91.18.2025.10.22.04.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:45:36 -0700 (PDT)
From: adriana <adriana@arista.com>
To: krzk@kernel.org,
	robh+dt@kernel.org,
	jdelvare@suse.com,
	frowand.list@gmail.com
Cc: linux-arm-kernel@lists.infradread.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	vasilykh@arista.com,
	adriana@arista.com
Subject: [PATCH v2 0/2] DMI: Scan for DMI table from DTS info
Date: Wed, 22 Oct 2025 04:45:25 -0700
Message-ID: <20251022114527.618908-1-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bootloaders like U-boot, particularly for the ARM architecture,
provide SMBIOS/DMI tables at a specific memory address. However, these
systems often do not boot using a full UEFI environment, which means the
kernel's standard EFI DMI scanner cannot find these tables.

This series adds support for the kernel to find these tables by
reading properties from the Device Tree /chosen node. The bootloader
can specify the physical addresses using "linux,smbios-table" and
"linux,smbios3-table".

The first patch introduces the device tree binding documentation for this
new ABI, and the second patch implements the driver logic in dmi_scan.c.

Changes in v2:
  - Add missing Device Tree binding documentation (Patch 1/2).
  - Split the original patch into a 2-part series (binding + driver).
  - (No functional changes to the driver code in patch 2/2).

Adriana Nicolae (2):
  dt-bindings: firmware: Add binding for SMBIOS /chosen properties
  drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT

 Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml | 33 +++++
 drivers/firmware/dmi_scan.c                                        | 74 ++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml

-- 
2.34.1

