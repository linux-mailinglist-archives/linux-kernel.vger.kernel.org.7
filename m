Return-Path: <linux-kernel+bounces-851720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B2BD7222
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750F118A19DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9243074A7;
	Tue, 14 Oct 2025 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WkK7AiEd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311C3043D6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410855; cv=none; b=NMPSBCSoIe3KiXM/QkorPweibR9mhiUQ58J+i3G1PO5GLQ8J29vtbgesS/ya5l1NU3ZM9lJVYLHNTKpV4ge30t2ktKrs8W8SSpxIp4t5WS02MAWFdn1uurQCuEFvCpoSAYa1i0wrNeZSTSyfkg/nBOJ5JEo29Wis1HPbLKqkwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410855; c=relaxed/simple;
	bh=SZSN7JX3Yjui35vygQzmshrzYjGawPXpQSl+5bX5eZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEwMpwj2I+fl1uzCJBcRolZeA46EN29VrVIu0B0Sk6GzAACj5xKbJpS3HXw0EMZmyK/wZ3x8SpL/gY53yweoOrtDn8bCgeDNehxAE0vqEsnYvgmAXMq+HfXcQOCuz/7DzpZQ1uwAbpdXttqYS2NAAPkqKKZrJBtTUvmqO+RK5jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WkK7AiEd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=LHpE9WJJjaoKMRoNuonFttbOqdD5Cr/QLjLjbsubV38=; b=WkK7AiEddOSmRxq3mN/Hk/zVx8
	snnkv6yBjN+urDWdj6NIzMm94uKn/2TBvBIxKK39P5YAlTZb08OIuXF0umT9MvgbLIVhxeF7fZ70P
	kMlhLgsAoLBQ3xWG3SRgpuD7JI3XdQith0ON0y8VYJvs2WRAK1zCLC8rA6b3Fg517BfMHKLq3kcY6
	zqEtSH5jbypzAu/vCmay5LXyBiOynI85bjtmYLPGbBX0ZowjXFbO2yz7XhNn6nqbA2z5l5tiV1Hqk
	LcJyWMDtoq5nn5+Lc7RERMp96A5s3xeewOvi2yKdCjS+GbseYc1YV7qSthqbOG1lmRD25LN3ip6ru
	8dx2jcAw==;
Received: from [50.53.43.113] (helo=smtpauth.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8VHG-00000004sDF-2jKO;
	Tue, 14 Oct 2025 03:00:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
	Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	industrypack-devel@lists.sourceforge.net
Subject: [PATCH] MAINTAINERS: ipack: add ipack.h header file
Date: Mon, 13 Oct 2025 20:00:38 -0700
Message-ID: <20251014030038.759222-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the header file so that get_maintainer.pl will report useful
info instead of just linux-kernel@vger.

Fixes: 14dc124f1b2f ("MAINTAINERS: Add maintainers for Industry Pack subsystem")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: industrypack-devel@lists.sourceforge.net
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20251013.orig/MAINTAINERS
+++ linux-next-20251013/MAINTAINERS
@@ -12216,6 +12216,7 @@ L:	industrypack-devel@lists.sourceforge.
 S:	Maintained
 W:	http://industrypack.sourceforge.net
 F:	drivers/ipack/
+F:	include/linux/ipack.h
 
 INFINEON DPS310 Driver
 M:	Eddie James <eajames@linux.ibm.com>

