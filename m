Return-Path: <linux-kernel+bounces-834555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85522BA4EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E4C3B1490
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E027C178;
	Fri, 26 Sep 2025 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="0LbWCRRJ"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BC1A8401;
	Fri, 26 Sep 2025 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758913235; cv=pass; b=Crs6Umbl+6l7pPYxQJD3hiltJ9XnoDDD8O0sBKqivq57qTz8SatPJgWJ6scdOZQlE7t0mGEWPzz5BfNFAk/glfX1Geze1d+zkFCCTHssGvwWaYLe0mg8BzW3RuVkSCCsHqJm4OU5/2VslNRWm0Mt112qbPrVdL7U/5e1ULWdcWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758913235; c=relaxed/simple;
	bh=WgoriSevxiU7oAvbMSTR3+yTBHf2AIccM2rP8yeKFuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJs/14Zl9YStUmpAhUEjUAbtf5ac2ecB2pLmwVPZMeHMY1kLs2lC68LCYDtgFTrm4HUVGt9pgOkzhsCCK6MRidDUVzl7G6IDypiHpX0V1xasVzN0tdj3mOkDa8Zp0VybtkfYZZV56vdhYoJxWW8LcF1g6Kt+9EIN4d/qmG3yjJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=0LbWCRRJ; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 646FA10A24946;
	Sat, 27 Sep 2025 04:00:25 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PUCiYHsEXM2a; Sat, 27 Sep 2025 04:00:21 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 8E477109D57DE; Sat, 27 Sep 2025 04:00:21 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758913221;
	cv=none; b=MGrWNVZ95VNWBlZI2pxZRfiHuQWh94pzFbbBDbZhdDdYqq1nLqQYhZKCzUjuVQsAjLCvv75UyT6xWKCM/kmV9AC5SOh1UJCvWEpSiQKqNspuWQY4jwUdQyXWBcPUjFFmINBl0hInISPGdDF1yzofaWwvkaCfr1Q2rHBFYuDh2AA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758913221; c=relaxed/relaxed;
	bh=ZdGJG/nRtX2LWtCAFzMZ6EQIBaXMBBxK8//9VaIEwhE=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=MiVaPNhviFFDogha2vGuafW38qCBc8UfDQa0A0068i/i2PmrEWXlrQsTywmM+q7X0nEBzLqfLXj4fCQ/OgaxQURLZbruWErRT7fFcP9kyKBdHC6U7ZiXI1V4Aui/hIFKaQgLN583Bw48JOy029N8BEnAUTQaHi2iCYUVZBoLNQ0=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 8E477109D57DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758913221;
	bh=ZdGJG/nRtX2LWtCAFzMZ6EQIBaXMBBxK8//9VaIEwhE=;
	h=From:To:Cc:Subject:Date:From;
	b=0LbWCRRJn4LrMxnhBTIsbwV4hkEzkdG6hFMdTOJt60pKYyUfQVYNWHIRxEMzHeDqG
	 AQrBQFQ2tzEOQRFunmh5+IdWgex6JFSHpDB5wtjnvzLk8xqgbcnxsn6fhjHFXfA2xX
	 HNU2LRxaXbQisiyS/fkXCSWeHx0owk3/HRMwfcAI=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shannon Nelson <sln@onemain.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] Documentation: admin-guide: Correct spelling of "userspace"
Date: Sat, 27 Sep 2025 04:00:19 +0900
Message-ID: <20250926190019.41788-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The term "userspace" should be a single word. Fix the typo
"userpace" accordingly.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 Documentation/admin-guide/tainted-kernels.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/=
admin-guide/tainted-kernels.rst
index a0cc017e4424..ed1f8f1e86c5 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -186,6 +186,6 @@ More detailed explanation for tainting
=20
  18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
=20
- 19) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG=
_WRITE
+ 19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBU=
G_WRITE
      to use the devices debugging features. Device debugging features could
      cause the device to malfunction in undefined ways.
--=20
2.47.3


