Return-Path: <linux-kernel+bounces-794112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5DB3DD03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3458E17AC0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1E2FE041;
	Mon,  1 Sep 2025 08:50:32 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654D7262F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716632; cv=none; b=VNLBlJjimYSsGY1Q2VuE02jxygR4TD7/yw+O/Zf+fFiLYIGhwLVsN9aSOtqWUZimXUiwAKfEjHbB4vEcO0rTE1B3ja8xqIWlBSQ1vRkCI72B5tfqwzcs0mBo8IUFO8pOFQS2FEuNGFhKlTqKM9NlonDld3spQQJMi89jCHrD4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716632; c=relaxed/simple;
	bh=zCaP/XNGB0w5HQJ3T+ViAkd0BR55ixOSTJwFjolaPJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kZAV3wk92hymy1Xi13jpbo9V+jdIL92rwJyusmqvwAYbYIzHSXDY+WwU+m7x4BrzzAUbAw9/nHhi5Kz4kOcpggF33tMU2vORVipmnnpxhmQleCwUezd52OsltggMSt+LR3LOnV11ald/x2GKaROlET+IxqsEi3rkccrru6vmFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202509011649157731;
        Mon, 01 Sep 2025 16:49:15 +0800
Received: from localhost.localdomain.com (10.94.9.187) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Mon, 1 Sep 2025 16:49:14 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Koby Elbaz <koby.elbaz@intel.com>, Konstantin Sinyuk
	<konstantin.sinyuk@intel.com>, Oded Gabbay <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	chuguangqing <chuguangqing@inspur.com>
Subject: [PATCH 0/1] fix typo error in
Date: Mon, 1 Sep 2025 16:47:41 +0800
Message-ID: <20250901084742.1935-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 202590116491563ba7ba9caaa19f792d2b2005647f4a6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The word "properties" was misspelled as "properites".

chuguangqing (1):
  accel/habanalabs: fix typo in comment

 drivers/accel/habanalabs/common/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.5


