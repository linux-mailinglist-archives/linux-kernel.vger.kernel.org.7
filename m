Return-Path: <linux-kernel+bounces-787726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897CEB37A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50401B64410
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97EE2E1753;
	Wed, 27 Aug 2025 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rbDgvQ0K"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6306283FF7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275915; cv=none; b=duQnALP5fMvC7B3arZw4t6Hs55jfDcRRkdLsblowcn7GRfGwTi5pNm0LGmjZq6o5GCcMzQh2W5TbRz7PvxQ8yOYV7eNcpJZCekzbk+4SCmnjOU70oiudfnLy/E+ChjvgL23ThCNXaCO2IwjnqNxRoHplN4a82IXwAznJPInapE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275915; c=relaxed/simple;
	bh=oxgoNFOnO9Qd7ov9g61UmXAsIpwnrJppNkMBXs+e4Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G44Xm5tgGsDj+FykabjE3+R+NG5WQrR1mLshssE8o5W53BmHV4+AIldhw8aX1oxl/lut3jDzW4fx6LHzSlroE/9cMec6of47H9GRy5NG8GEe3s+XFBOpfkON6M9PcpLkJv9HOPycarYxYAnSTiSTSNZjcDnOGnveOZ9uUarzkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rbDgvQ0K; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [223.190.80.94])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E03F8300E;
	Wed, 27 Aug 2025 08:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756275848;
	bh=oxgoNFOnO9Qd7ov9g61UmXAsIpwnrJppNkMBXs+e4Os=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rbDgvQ0KaD8nEdfAISGE4R1o/OuWgVvPe0wSt0RfGq6QHAMzh7gbALvjPDm3C/yuB
	 VCUg0IhGlW57zoBdwdzK3Z0ZCpPCDVSSwgHS+yChCxG+KiE7zMUzpCotOphMZ9gP6h
	 xmQJVR1W344qCy7pUW78ZOB8W+qZLB3gQ5kmDXws=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Wed, 27 Aug 2025 11:54:09 +0530
Subject: [PATCH 2/5] staging: vc04_services: Cleanup formatting TODO entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vchiq-destage-v1-2-5052a0d81c42@ideasonboard.com>
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
In-Reply-To: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com, 
 Stefan Wahren <wahrenst@gmx.net>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=oxgoNFOnO9Qd7ov9g61UmXAsIpwnrJppNkMBXs+e4Os=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBorqSaJ9hpyGNWfMMl3VFVfPZ/dAIfR6p5Dtzp/
 0tDnZ2tvkKJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaK6kmgAKCRBD3pH5JJpx
 RVfvD/9FA4ZMcYtquE5NriSJyqWfJu9WPllIsiorvJLkTeSIrgEW++iIoBgcJ15R2a06jguwIbB
 a5zwHHKSZl+/FPd8B7Im5mUBJcIYyMlwkZaqOueF7DK/4DoaAWtAfqf3u21+1Z0Idk2/Ebh2Fc4
 NH8hbNJIFQzOV9iDH6mMDlD4VYfES3KLqYE7UVuqNrbm0UdAPBA4rH6Uk1OeJNjL2DD+dD1TsoD
 2geJVanK2rvOp/wmA/Xk8+Uv+XJqs5lXRQO0fRJzBqIEzlam9d9nQo4JT3Sa6CG+GXZ7P09etwL
 pZwfb9NEYLdt2rjKLMRDJ11aVO9rNCwEyvuQF7+5INmbPa9hgZw/BI0OiQ0aNIgq3FJB/xnTVKP
 7n7TQcq48BV5SCA+jeEtTnqK3EpkmYmGZWkPRNdE1+sKtUUsFQyHzWXR/Jh7OPw8Uk4BvghEAfe
 Wc3ieThVt4PvuAPg2d8G9mt5+Kw5BWpp/y9A87m6XytBgHH8t1ChlbBeRMM2yWz00R5Z8yhjSK7
 A+VCBgFjoFFYfX+RtpCPUtD2T1ms2H+dA1RyOdJc7l+UsHcM3kfNyhAbSedXFGAk3e1ZPRyFmtF
 DKR37cHkt5Ve01hC9DKz/3rk/Pl06RkLjjtHi4eYETqWF+Kfh8NdNrtl7FuR1sxgz20VoFGZvKP
 8k8S25FTGZSgLhA==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

The code indentation for the vchiq interface driver is not so bad
anymore [1], so drop it from the TODO.

Link: https://lore.kernel.org/all/20241013112128.397249-1-umang.jain@ideasonboard.com/ [1]
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/TODO | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index f6f24600aa86240fba77169f62f3e657e42727c3..6e5f27db88ba8e533ee1fabc3091771d8efe66a2 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -20,9 +20,3 @@ some of the ones we want:
 
 A short top-down description of this driver's architecture (function of
 kthreads, userspace, limitations) could be very helpful for reviewers.
-
-* Reformat core code with more sane indentations
-
-The code follows the 80 characters limitation yet tends to go 3 or 4 levels of
-indentation deep making it very unpleasant to read. This is specially relevant
-in the character driver ioctl code and in the core thread functions.

-- 
2.50.1


