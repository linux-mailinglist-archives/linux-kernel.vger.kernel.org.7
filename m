Return-Path: <linux-kernel+bounces-765384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F628B2317E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4447C3A93AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125582D46B3;
	Tue, 12 Aug 2025 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AQ75tvf6"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE932DCF46
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021773; cv=none; b=qF32chmTpIVX3ZzJoMTv6BnlZReZqOMHCGFIkSi7qTKef2VHfy/6lTEPj1lyOM6s0f2GVC/y8/9z7l54TPdj/8ed0HOrG6BYTZ0rOZEKmHCV+AhsDFmArxWfKs+AYIzGCKGOBdBUNTUL/YfHbSEXs7rtM3d2HSRoXmOiAK5cXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021773; c=relaxed/simple;
	bh=f6JI2JAYXjY1iDRoVAScvHlom5T6q+J2Z00xcft9+l4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtRmSaPvVAjYvAzDALtTbEeWD5Sc6qHAl5iH84E/zcIv7rbZJ0sVg2tOUbXlHRdGiABoE9ShJqtcRKkDw2uhVCJOigU1iKSx0zj1tQOilYGl0sMmIejrj956es5izfw4CdrXYASmNlC3KJWOwDyqshc9Ofky4FXkIAZK6VqhowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AQ75tvf6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 54BB3201A7DF;
	Tue, 12 Aug 2025 11:02:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54BB3201A7DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755021761;
	bh=Rc4RvJjETyMR89OVna5sDTm18+yyF6wK4oNen4cdtNg=;
	h=From:To:Cc:Subject:Date:From;
	b=AQ75tvf6jHet5IbvTMZ/pU4F1Wa77kNdCAiMCdyrDuUPNgy8JJN5CnOJ2RsG/nOxG
	 wt2QT1SUhrpxY7Wubf4EYNxRFv4mxNY7GSWAzCarp5bEWN1Kwx70Jc6eUM3uzhZM6+
	 3IEY11+BS++bSxcENzqC3aRGGae8Th0svhGi75A4=
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	Shannon Nelson <sln@onemain.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Cc: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Subject: [PATCH] .mailmap: Add entry for Easwar Hariharan
Date: Tue, 12 Aug 2025 18:02:14 +0000
Message-ID: <20250812180218.92755-1-easwar.hariharan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map my old, obsolete work email address to my current one.

Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index d9fa1b5551165..a124aeed52a2a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -226,6 +226,8 @@ Domen Puncer <domen@coderock.org>
 Douglas Gilbert <dougg@torque.net>
 Drew Fustini <fustini@kernel.org> <drew@pdp7.com>
 <duje@dujemihanovic.xyz> <duje.mihanovic@skole.hr>
+Easwar Hariharan <easwar.hariharan@linux.microsoft.com> <easwar.hariharan@intel.com>
+Easwar Hariharan <easwar.hariharan@linux.microsoft.com> <eahariha@linux.microsoft.com>
 Ed L. Cashin <ecashin@coraid.com>
 Elliot Berman <quic_eberman@quicinc.com> <eberman@codeaurora.org>
 Enric Balletbo i Serra <eballetbo@kernel.org> <enric.balletbo@collabora.com>
-- 
2.43.0


