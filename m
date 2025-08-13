Return-Path: <linux-kernel+bounces-767434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B138AB25430
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C156D5A6CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5832FFDD4;
	Wed, 13 Aug 2025 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIvjxT/m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0362D641A;
	Wed, 13 Aug 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115539; cv=none; b=iRzO4fwvseR0QMGocrtAj2Yu82EwurxDBP8WtAxKtstjAtqpk+su3DGwDGhJZpOCiNdHcGcvyvm8N9dGRRoptmz2S5fsrU7UVuaRefjMF/B3HrSBWrX7faYbWStP93FxRkl9BbKVyOfoZev3EmL366sBcxBDYahLtDWG1CBQdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115539; c=relaxed/simple;
	bh=KZpxOt2wjgnHDU3rHzqcK9FNzF1fZcSOQ63W2A6ys3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRhPzP+ueKvF1hSsK39X/n3Cd1TicyQkBgQNsG5gq/1DDbjQ2cSTC/mFjmM7ogxrX8c5ydjzMu0eMenRgr8or9kBA7gvh/N26hjb85WTK5bxBWCgw5EKKzvgLNVYH6Iv6kglQ2iBCvpBkDmIj7QWa5f5jGfvtmIg1vULyRaAGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIvjxT/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F413C4CEEF;
	Wed, 13 Aug 2025 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755115537;
	bh=KZpxOt2wjgnHDU3rHzqcK9FNzF1fZcSOQ63W2A6ys3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIvjxT/mmPQRGD1HcQWIkNrWc4i6cCAU9NScvfNlBiNG8CL0IxWDEnoZsU+WsaQ7F
	 XZgHL71hZoHl2xrKwOBgc2TEulid/1kZEueoCdIspoxK2VH5XMDexEJSHWvXIs/r98
	 L/V/KiFBRqbkxmdoOyzuqOyAHFhG+JdBp71gz5YZN7314SEl1S923rhJrK1eRMwkTD
	 AUXMm2h0FsqAmriUQykNqYlgneUR97ft0UZiCCxR3POQwgJ78LXZw73BI+jawOLvWt
	 /bKOxwCMzK1fD5a/SqONDXVinnLya/Vw9nKq1dbQod0jwft8ePe6yXlQIRo6TIuHdu
	 ZrEPdmkq05Fsg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/9] Documentation: Fix PCI typos
Date: Wed, 13 Aug 2025 15:04:57 -0500
Message-ID: <20250813200526.290420-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813200526.290420-1-helgaas@kernel.org>
References: <20250813200526.290420-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/PCI/endpoint/pci-endpoint-cfs.rst | 4 ++--
 Documentation/PCI/endpoint/pci-endpoint.rst     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
index fb73345cfb8a..e69c2872ce3b 100644
--- a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
@@ -86,7 +86,7 @@ The <EPF Device> directory can have a list of symbolic links
 be created by the user to represent the virtual functions that are bound to
 the physical function. In the above directory structure <EPF Device 11> is a
 physical function and <EPF Device 31> is a virtual function. An EPF device once
-it's linked to another EPF device, cannot be linked to a EPC device.
+it's linked to another EPF device, cannot be linked to an EPC device.
 
 EPC Device
 ==========
@@ -108,7 +108,7 @@ entries corresponding to EPC device will be created by the EPC core.
 The <EPC Device> directory will have a list of symbolic links to
 <EPF Device>. These symbolic links should be created by the user to
 represent the functions present in the endpoint device. Only <EPF Device>
-that represents a physical function can be linked to a EPC device.
+that represents a physical function can be linked to an EPC device.
 
 The <EPC Device> directory will also have a *start* field. Once
 "1" is written to this field, the endpoint device will be ready to
diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 599763aa01ca..0741c8cbd74e 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -197,8 +197,8 @@ by the PCI endpoint function driver.
 * pci_epf_register_driver()
 
    The PCI Endpoint Function driver should implement the following ops:
-	 * bind: ops to perform when a EPC device has been bound to EPF device
-	 * unbind: ops to perform when a binding has been lost between a EPC
+	 * bind: ops to perform when an EPC device has been bound to EPF device
+	 * unbind: ops to perform when a binding has been lost between an EPC
 	   device and EPF device
 	 * add_cfs: optional ops to create function specific configfs
 	   attributes
@@ -251,7 +251,7 @@ pci-ep-cfs.c can be used as reference for using these APIs.
 * pci_epf_bind()
 
    pci_epf_bind() should be invoked when the EPF device has been bound to
-   a EPC device.
+   an EPC device.
 
 * pci_epf_unbind()
 
-- 
2.43.0


