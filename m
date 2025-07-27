Return-Path: <linux-kernel+bounces-746987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EEEB12DF6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E12179E03
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34711CEAC2;
	Sun, 27 Jul 2025 07:04:30 +0000 (UTC)
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F2BA3F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753599870; cv=none; b=Uuq97bNycZBlVGTwom8XoCqXd4xZw5Y7pebskxEzvf9eCX1SnrEzMOKX/bUitCNxeBWoRI/SodhJdxFui1+RDdlNmTAeDOHIDVGhHkOXBsfxMfDpvyPr383g63GNgnnzFTnIQeZZJFTFpTi9Tw6uTtAuu4houuUh/jjsy7WRDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753599870; c=relaxed/simple;
	bh=fU2xMoyWhwe2f0BUvCh9EG5Kj3/nPlAoDJgKfhpTVkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HN6757eRdsmP1msfV8KATLQkiNln/ZCSJaaKb2Syvb1uQ6SYprRmuQIjgun9Sw2Wn1CE/fDPAcU527M/zxwsXBc/ZCq6a+sN3regoKQai/UUU8lE6oyXqTdm9euwxxx4V9JOMov2gbPwXBjQD7e4zT5cYn9eTFpFzOZo5OinjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 3634A3F108;
	Sun, 27 Jul 2025 09:04:23 +0200 (CEST)
From: Simon Richter <Simon.Richter@hogyros.de>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v2 0/1] Mark xe driver as BROKEN if kernel page size is not 4kB
Date: Sun, 27 Jul 2025 16:04:09 +0900
Message-ID: <20250727070413.9743-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

until either of

 - https://patchwork.freedesktop.org/series/150230/

or the (same but rebased)

 - https://patchwork.freedesktop.org/series/151983/

goes in, the xe module will Oops on insmod when kernel page size is not 4kB.
This disables the module for the time being, and should be reverted for fixed
versions.

This should probably also be added to the stable kernel series which will
likely not receive the fix.

Simon Richter (1):
  Mark xe driver as BROKEN if kernel page size is not 4kB

 drivers/gpu/drm/xe/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.2


