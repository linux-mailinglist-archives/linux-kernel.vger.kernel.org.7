Return-Path: <linux-kernel+bounces-899092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D383CC56BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 147F334F6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1D82DF3FD;
	Thu, 13 Nov 2025 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mariuszachmann.de header.i=@mariuszachmann.de header.b="TZO8ogWR"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789152D7384;
	Thu, 13 Nov 2025 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028379; cv=none; b=N1XOMSun75puyz/hLdugcQVPr6Fb20rkE16pIwYKod6/Xm0aatVuvBMS6y8sXdYtTtquDSkf389gjPIuD3TuHMU03ewBj7gfHMlqVum8xgl/Q/YQIgMDJ6HhBaI544TC/u2ZXdpYeu0TCcA0eZEwr925AeSk6y98Rzbt750qbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028379; c=relaxed/simple;
	bh=htTjj9w4FPjRO2mbEyBAGDz1LxDChXGHqJvCrvGl7jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFwfkmYB3AIjIafefWRiPi6lLyWkc/EyBfOy6TWO2aBiVvTGb5657qMTJ8S1uActrpqMLfXoV1xyxErTr83+UOGnz9RLE/t6PDOngwB7z1eKnqTHKAzTOFMQkDIwEwECBBLBY+EMEyJz9BNKbnInrn6ahXmJvoLUU8LVN+SP1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de; spf=pass smtp.mailfrom=mariuszachmann.de; dkim=pass (2048-bit key) header.d=mariuszachmann.de header.i=@mariuszachmann.de header.b=TZO8ogWR; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariuszachmann.de
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4d6bPZ5kMhz47Gj;
	Thu, 13 Nov 2025 11:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mariuszachmann.de;
	s=key2; t=1763028050;
	bh=htTjj9w4FPjRO2mbEyBAGDz1LxDChXGHqJvCrvGl7jM=;
	h=From:To:Cc:Subject:Date:From;
	b=TZO8ogWRtYLQzIyu0JVtLrPICzOtdMJAG7NQZkJShneJ8d6cSjyxMA9Iebes7CAUe
	 RsjL7U7ltzuj10tTsbnfwVMIXzFiMNDvzHAYc8bSMz66qzGA+SejynAUI3Q4x6IP6P
	 YumbdSncnm9pYAww6WFXvuBvdAonm39l2gUuCw0DC2vHsHh0/i6GUmW1h/tYI+Mqog
	 j71iEtqwbeBsqEhSrypj4GiRPiAyKjcarZjQCOctdZZ0SaIXuGx8UJuvcXhkkLJ8u8
	 0SdUNu7a8+TS+TJloTchAmLlEvpxeMn3LhISRXuDoaR2exCvjmlK5C+rfLW8E6e2V+
	 YrdBSNfWFu59Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4d6bPZ516wz47GZ;
	Thu, 13 Nov 2025 11:00:50 +0100 (CET)
Received: from mxe9aa.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4d6bPZ2Fflz8sbF;
	Thu, 13 Nov 2025 11:00:50 +0100 (CET)
Received: from marius (dynamic-2a02-3102-8004-0800-b21c-0b06-5865-dcdb.310.pool.telefonica.de [IPv6:2a02:3102:8004:800:b21c:b06:5865:dcdb])
	by mxe9aa.netcup.net (Postfix) with ESMTPSA id 22F7080083;
	Thu, 13 Nov 2025 11:00:49 +0100 (CET)
Authentication-Results: mxe9aa;
	spf=pass (sender IP is 2a02:3102:8004:800:b21c:b06:5865:dcdb) smtp.mailfrom=mail@mariuszachmann.de smtp.helo=marius
Received-SPF: pass (mxe9aa: connection is authenticated)
From: Marius Zachmann <mail@mariuszachmann.de>
To: linux@roeck-us.net
Cc: mail@mariuszachmann.de,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: corsair-cpro: Read negative temperatures and
 remove magic values
Date: Thu, 13 Nov 2025 11:00:22 +0100
Message-ID: <20251113100024.11103-1-mail@mariuszachmann.de>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176302804953.2250106.10781560279154477715@mxe9aa.netcup.net>
X-NC-CID: n3sTefDapkdA1UfI8s4BOq4mY0MT2V36YfF797xYJCas6gU0fzc=
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 22F7080083

- The Commander Pro also allows reading negative temperatures.
  Adds a conversion to read it correctly.

- Replace two of the magic values in the ccp_device struct
  with constants.

Marius Zachmann (2):
  Read temperature as a signed value.
  Replace magic values with constants

 drivers/hwmon/corsair-cpro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.2


