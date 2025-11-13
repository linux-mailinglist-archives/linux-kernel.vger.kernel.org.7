Return-Path: <linux-kernel+bounces-899679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E13EC58901
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DB434F7175
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612E4346A10;
	Thu, 13 Nov 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="itzfM3rT"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A0346778
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048382; cv=none; b=oQabe/ZWzFN39ZRLSewfLiTkqFKlfz2GX5zBvdtC23kJW2hcqkGKumNeVfKcMeG+XrePzJcGCE5zK8CSe6FrolhaCc1+kp771VXGFErMiRhP1u13dn9nSenxdiiqheVgFftc9FSq3M3l929SUBaexgjSNiPbG9jd3aX0cV/F2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048382; c=relaxed/simple;
	bh=rPDGirdNX7egxsQQCFOPloEeBzb80gdFa4+7RU1D6gk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1OJTlgn0Iz57kNYg+NhsUhnaIRy57NXvzcFrE7Hq+LvS0rLS7Jzw1WyZ7wM84wiu3tfX9yN18BK5KW4jJSX/3+bbMd2G6ZIopRX/2sB6SrQYJ2hkK94BbOs3293MZhaJThk+8uGza8UsQNLWs/zLTdZ5Zh8QiE9kiWFiGkxZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=itzfM3rT; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763048377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VsSo0rHruUYZUSRInyxcyCIV2SApYNLgLqp/uhMcd54=;
	b=itzfM3rTNRenebQwm+O2xoQPz+w2sJQcLcsGGiKHPoOVKyLL8OmRZkNh6vzwqPlMyscxhq
	qBLToCimsI4idMU7ycNWx22mEjVyaQURtcy1qwfU+Hn13bfIOK1Ru+bODhjs+3LDP6axYU
	ueJTceI6ZYNGz8EwwMXykwDfwCQzEOU=
From: Dawei Li <dawei.li@linux.dev>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dawei.li@linux.dev,
	set_pte_at@outlook.com
Subject: [PATCH v3 0/3] Fix and rework of rpmsg_eptdev_add()
Date: Thu, 13 Nov 2025 23:39:06 +0800
Message-Id: <20251113153909.3789-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

This series fixes bug introduced by anonymous inode eptdev code and
rework the exception handing paths. 

And it tries to address a long suffering issue which may be backported
to stable kernels. 

Change for v3:
- Split it into 3 patches:
  1/3: Fix legacy bug.
  2/3: Fix new bug introduced by anonymous eptdev code.
  3/3: Rework error handling code.
Link to v2:
https://lore.kernel.org/all/20251112150108.49017-1-dawei.li@linux.dev/

Change for v2:
- Add put_device() when __rpmsg_eptdev_open() failed.
Link to v1:
https://lore.kernel.org/all/20251112142813.33708-1-dawei.li@linux.dev/

Dawei Li (3):
  rpmsg: char: Remove put_device() in rpmsg_eptdev_add()
  rpmsg: char: Fix UAF and memory leak in
    rpmsg_anonymous_eptdev_create()
  rpmsg: char: Rework exception handling of rpmsg_eptdev_add()

 drivers/rpmsg/rpmsg_char.c | 61 +++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 27 deletions(-)

-- 
2.25.1


