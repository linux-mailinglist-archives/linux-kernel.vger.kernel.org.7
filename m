Return-Path: <linux-kernel+bounces-885417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF31C32D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7013BEC9D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82128488D;
	Tue,  4 Nov 2025 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EOCeJATq"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288B8F54;
	Tue,  4 Nov 2025 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762285448; cv=none; b=GBIciWWeA0u5BjmTrKxgjFhEucv4Lssu5GpH8MJmSTSK7/axBVPKglIQcvMTh765Z1h3VqVYBdIFOvYsANUsxFoAl2qWoKZ9fHKagOhqc77Mt5Yg1KcfSIk0q/lzQeBWhUyGEobVe9PGOngVrY0vXsiVEE0AavmvH0F35MZRT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762285448; c=relaxed/simple;
	bh=6Bs6ZFjnmrNbaGeBHQrUsugCXNjNkpXzPySWEj5QiTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wic2x1yA81o1fAh6YXtp14IHFoelB6bqLMiwCoLsOL/sw8bAezAteGtYNifLm8AgBwSFSXWSRUe7nQ1r+r8Rsm5LRNYVg6n3M3TWkI8v+HYwTqU+A9jg3tf+IqRfoKazwUytW9bDckHx86H/scDsP+GJDz+MiPp5HILU3DbP6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EOCeJATq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wiFhPlcxfsNJzsZl7Xko7j2Tn+MGl6s9EF86TfNl/Wc=; b=EOCeJATqiKCyUApr8VFm1h4VBF
	pnyeapSjvtRcxA/Abnxc4t1vDvMXTaJRPQ6fKAKSnJUDE2BG+qE9OMJTrafrnax6xxSBTCqI0ROgY
	dmFTcIyqGF4Sqjvw+TSFZ3nP7IPdbTW5kokRxCOotaInbaqa4go+j6vdyiqvjRCMxqEs9wA1IW3fc
	8kwNegbsyVLrSlUei1ilegYEXscsXp1Mz3vvAOk6azXpSZkklytDXDmuwOaU26ccLUrIV0aBm1dbf
	jTpqcqCPMRbzz0YXvGvS3/lvkC7SnXY7NSQeD2UIRB9NTHzfYc8SEARyKT/4zzZv0rs71wYd84B5C
	ZrhAf6VQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGMwl-0000000CVGF-3SiS;
	Tue, 04 Nov 2025 19:44:03 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Eugene Polyakov <zbr@ioremap.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: w1: fix w1-netlink invalid URL
Date: Tue,  4 Nov 2025 11:44:03 -0800
Message-ID: <20251104194403.945611-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The URL in w1-netlink.rst for an example userspace application
has changed. The former URL is no longer valid. Update it to the
github URL.

Fixes: e4e056aa3518 ("w1: documentation update")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Eugene Polyakov <zbr@ioremap.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/w1/w1-netlink.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20251103.orig/Documentation/w1/w1-netlink.rst
+++ linux-next-20251103/Documentation/w1/w1-netlink.rst
@@ -196,7 +196,7 @@ Additional documentation, source code ex
 ==============================================
 
 1. Documentation/driver-api/connector.rst
-2. http://www.ioremap.net/archive/w1
+2. https://github.com/bioothod/w1
 
    This archive includes userspace application w1d.c which uses
    read/write/search commands for all master/slave devices found on the bus.

