Return-Path: <linux-kernel+bounces-634717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B1AAB3E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 06:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A08188F549
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 04:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D4B396EA7;
	Tue,  6 May 2025 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcLhrLKN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5E2EC028;
	Mon,  5 May 2025 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486438; cv=none; b=WXF8i/9xbk8gwoSlsz0OCBDCUdSgAEB4uSfu7jPHgH58Uufaf3wbsVBJyv2rYhSERXksAGbz1ucYowrf1s5a6OPRl3BxhguRbrDi3R7Qdfkwcua8fx9dibX4DK2GQlPk+4MJzP7oHtmBCv3kbYc+yU7dZOBEDc8t2Wz/YN7JPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486438; c=relaxed/simple;
	bh=BER7pLxMC+HVOJMzmT6E2tobwzQBzVLGf6Mm2BrfNYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGBTpag3qqvZt3AgVJSAIb1TjM0vaTuQ8ERwMtWjWxbCHD3nwraytQY3OeXeSXzsAPgnj+RQeyzZSwpHRecHiPlIroM/cr+2YTRj1WnwYwi7fWeaiTCIdgzJ2KVeonDBQ9R6SCgD5sd8/7388fvB72Z77LHbwZDh3KoKEc26rTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcLhrLKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8979C4CEED;
	Mon,  5 May 2025 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486438;
	bh=BER7pLxMC+HVOJMzmT6E2tobwzQBzVLGf6Mm2BrfNYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcLhrLKNp/jhf13E9O0tJJ/0PTKxjb/Uxq4FQTP6cfJESpsRuXXgiINDjA5YdCnYc
	 y0i+m7PQTHiSzkBlIpnC3Nyuq02shv636OpSzKCUy4EDtActl+cHMcY/LZ4mxNOXB5
	 O34LeRKa20rCyYQG8d36ghwrDnEdw0p0oJYh80CX3ZlbJq1FzbolxEg+fUKuszf1xL
	 9WR99b6NWAX8IvQKJlzoP0KNaGXHSOlYGVXGW+bbgqWRCU2XxZqOHWJD+xOHZo69VU
	 kH0Z0FOTryAhPiS3KqyY0dGQHAfXRcKtBdzYawOAq5LppAXg4GtNZo3kIOaxUjk1Tr
	 /AKIIIIlA4oQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	snitzer@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 027/212] pNFS/flexfiles: Report ENETDOWN as a connection error
Date: Mon,  5 May 2025 19:03:19 -0400
Message-Id: <20250505230624.2692522-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit aa42add73ce9b9e3714723d385c254b75814e335 ]

If the client should see an ENETDOWN when trying to connect to the data
server, it might still be able to talk to the metadata server through
another NIC. If so, report the error.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8056b05bd8dca..07e5ea64dcd68 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1255,6 +1255,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
-- 
2.39.5


