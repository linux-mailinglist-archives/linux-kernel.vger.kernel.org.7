Return-Path: <linux-kernel+bounces-732344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11216B06561
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DE8500B43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152B2287504;
	Tue, 15 Jul 2025 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="kT4Ewi0g"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010AD186E2E;
	Tue, 15 Jul 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601747; cv=none; b=KmLFZeHLKlE1VS+uq0MYBSbaBLypFtaN1/KOiHCUv3Rr/Ob5RMZ+Dv0Ta7pwHYb9eyLswhtqgSyv24rDahZWOTSnEt+UMlakb3MrmrK59dO5ceIe311RPxUIsNnle18HncvkQ9Dgx/NY2ClKF8fa4/nblyOsLKEEqmmFWobPMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601747; c=relaxed/simple;
	bh=szoPdU8t5HxV3+qu49EKJRl2lJmf68LJg4pDte/fGFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSXHrKKO4nrWGStkya2K32JqeT+nSPE2+YRsazpvfobHtUF11VNv6IZR8TZgbX8ToXl6jy2gdL7y0gC8hB7mcbo1S4PSgQIxz4aiTGE7xpkcvW976uqMTdD+PskM/cQVXwAnY4DZVw+ZlfePc6+VmZq3PXrBGt3bAaBuPK6y0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=kT4Ewi0g; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C1414C0005E0;
	Tue, 15 Jul 2025 10:42:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C1414C0005E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1752601340;
	bh=szoPdU8t5HxV3+qu49EKJRl2lJmf68LJg4pDte/fGFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kT4Ewi0gvW8Ipq8NdA8VUvem2aII/sgJ6l8dGH1wH92aJnwlEqh+22j3tNHNJfUNz
	 LdM4clMG0Vd1AlGgKOEnFdeNdgH2hPN8XyzcB6pmIxHGZU6/GgzBGRK60uVnKy5vVh
	 NvivarNrIm9TTzeF1vSMwnkZ8YlD6NISJv2AAUbs=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 56FB218000847;
	Tue, 15 Jul 2025 10:42:20 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: broadcom: Fix bcm7445 memory controller compatible
Date: Tue, 15 Jul 2025 10:42:19 -0700
Message-ID: <20250715174219.2421220-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701175538.1633435-1-florian.fainelli@broadcom.com>
References: <20250701175538.1633435-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue,  1 Jul 2025 10:55:38 -0700, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> The memory controller node compatible string was incompletely specified
> and used the fallback compatible. After commit 501be7cecec9
> ("dt-bindings: memory-controller: Define fallback compatible") however,
> we need to fully specify the compatible string.
> 
> Fixes: 501be7cecec9 ("dt-bindings: memory-controller: Define fallback compatible")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507011302.ZqNlBKWX-lkp@intel.com/
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian

