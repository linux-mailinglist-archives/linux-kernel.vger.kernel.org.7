Return-Path: <linux-kernel+bounces-752661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818C4B178FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5D71C80A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1F278761;
	Thu, 31 Jul 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCvpK9I8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E7C276059;
	Thu, 31 Jul 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999965; cv=none; b=iVVRH3q71ETLEIWXORteSjuDlfN+pf10gqWmriSKdyDSxzM81o5h11rVQj89FvIFCzYgUkpCUvBroFw4vVmdzz276Mdy5ESAtdIC1D+IkBy5U5t5OvKveh7uhqvI4VO2gl2QTcxbtTqvWKNxcxiNKyKIXerOgZphkJBsNW4eouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999965; c=relaxed/simple;
	bh=hPXs+VvV1Z0lvnVsLb9P/CrQ7tEFhXZWjhaO05I861c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmVLC7uyKYw2JNPCfXhPol+3XqbtAVTLsaTXwBqWDrPBv1/BtSRdzZZR6y6VBuTbDImBpIR5hyFNyTXNdeIOojd4HABRIKcOAS9oEU5R78x3DywaTD5ADR4LJaX30QhOOqOgaiC6qQTMDmHs9D54gr+1Mua8s5BECGcPgsUZypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCvpK9I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50176C4CEF8;
	Thu, 31 Jul 2025 22:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999963;
	bh=hPXs+VvV1Z0lvnVsLb9P/CrQ7tEFhXZWjhaO05I861c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iCvpK9I82kPhEpK8t1h0Ne7/It67WKDWjCgnmWYXCS/tRB8rDtmureWGGG9qIRa8R
	 Mj87Ii6KoBomAr9zGp3jVH8ws2BgF0nXYrQQSOcRxe7pZUQmtNh0Mz9NiiZK+7vG2i
	 iiCJPiHuoiCmz/VY+BLz5EsGGj5wVQrnM4yjo+s+EWWCpZWytDQRTj+3kIKJE8NTwc
	 YxuhxrvavW3NHcI6J+fmgoSeKmDvCxaFoVF7IgE0HNEEiLyTCHeFDbu8JrOg3CHx7c
	 DziRGP44pSyglPL5umjP3Fd4W77aCbZCJox7ncqdJd5F63fpMBYK5fh0zKT4LvD7/C
	 bXxP3k5x87i9g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:21 -0500
Subject: [PATCH 4/6] MAINTAINERS: Add FSI bindings to FSI subsystem entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-dt-fsi-cleanups-v1-4-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

Maintainers of a subsystem should also be the maintainer for
corresponding DT bindings. Add the FSI bindings to the FSI subsystem
entry.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..4a7b4656822c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9810,6 +9810,7 @@ R:	Ninad Palsule <ninad@linux.ibm.com>
 L:	linux-fsi@lists.ozlabs.org
 S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-fsi/list/
+F:	Documentation/devicetree/bindings/fsi/
 F:	drivers/fsi/
 F:	include/linux/fsi*.h
 F:	include/trace/events/fsi*.h

-- 
2.47.2


