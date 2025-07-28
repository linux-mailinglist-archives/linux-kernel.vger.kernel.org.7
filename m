Return-Path: <linux-kernel+bounces-748194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6144AB13DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DF63B6A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7676A270557;
	Mon, 28 Jul 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVmDOMfo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43A26FA60;
	Mon, 28 Jul 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714477; cv=none; b=Oc3I0hf+6TBgMagFIGwj91tDLbeqE/dqqGrGVe1DLBDMJOumz7I7jm5xa1yAYm9xgiGTZYAxg2FqDdzarODi1mLb/o+IKnS5+l8vNZOkz09ZdiJBZZ6jY3it4p0qY2kLtH83xUhJF+yi0eVBQoLcnpx+61OW2L5N+ICIGXwaWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714477; c=relaxed/simple;
	bh=sxDzrgIHM3tBUoaq9l8USZTn0mdRWSqJI4AE6VfR1lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M82hMXiHGnpUNsqCUiwvk0zfKHJDK0zE0wPhftDcvG+XsynKH/BMXT4aVQah3HN896DNZYQUY7n8m5JPrDCc85idbsf0+Uoa4K6TRZCZv09Znsbqm/aO5QczDi6ZRVW58eP2GIlsWFH+se6wy1qwiax8hDdxr7f/KOleFpOHF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVmDOMfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E2FC4CEF7;
	Mon, 28 Jul 2025 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714477;
	bh=sxDzrgIHM3tBUoaq9l8USZTn0mdRWSqJI4AE6VfR1lM=;
	h=From:To:Cc:Subject:Date:From;
	b=aVmDOMfoZ2AyOmXXmkrMvEHRuq3UJd/lZiZpTdoFER5s6eo3X0y/4kow8ST69ps46
	 LBU/qHZYGTbbwdaxu171SXY5ASx2ixp9uTgNpLpA+SH3Kj772TimNKZT1x5ifvbBFU
	 OeBsKIAtIvIsAPNhqVwCDNECsAK2swVQvFsoaw/XR+kIcBjD9hrkHnMsuC+wLMVjB5
	 gp8/tbWLDKfoUZoj1oa/7uYNFfzLd4xa1WbNaAuO08R8bWJxTA+LtRZ0ExoqD8zHAf
	 HldLhTYHdmYM1m50I2SaVilGeWNd0srjKkMJ+fCzblb+jYvVTImBX6pOO0PDIgc04z
	 dfHuJ0nCSacrA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugPFK-00000000G5N-2T2G;
	Mon, 28 Jul 2025 16:54:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	workflows@vger.kernel.org
Subject: [PATCH 0/2] Better handle and document Python needs for Kernel build
Date: Mon, 28 Jul 2025 16:54:27 +0200
Message-ID: <cover.1753713955.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Hi Jon,

As promised, I'm sending you the missing patches from the
python backward-compatibility series. They're not urgent,
IMO it should be OK to have them merged for 6.17.

The first patch fix process/changes.rst. Currently, it makes one 
think that Python is optional. While not having python may work
on some environments, there are some python scripts called 
during Kernel build time that require python.

Document them. 

Also, in order to avoid breaking compilation, make kernel-doc's
main script executable with elder Python versions. 

Backward-compatibility tested with Python 2.7 and 3.4 (although
it may work since 3.2).  On elder versions, it would emit a 
warning and do nothing, as the actual code depends on features
at 3.6 (f-strings) and 3.7 (ordered dict).

Mauro Carvalho Chehab (2):
  docs: kernel-doc: avoid script crash on ancient Python
  docs: changes: better document Python needs

 Documentation/process/changes.rst | 13 ++++++++++-
 scripts/kernel-doc.py             | 37 ++++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 12 deletions(-)

-- 
2.49.0



