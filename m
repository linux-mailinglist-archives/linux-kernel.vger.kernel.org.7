Return-Path: <linux-kernel+bounces-857612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BE5BE7427
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 167625028C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A72D46DA;
	Fri, 17 Oct 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aZcVRk5c"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EB8296BCB
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690860; cv=none; b=aHLYxqOae/QCETqWrbTHcjBPWXFj+IeYPrXrnkIaIQbWJeST7pm4W1kFKc7c+Js1wuWWJPBFJj2MN3vBHtWhvdXJcN/YgdXtK4Ka1Gm0ZJ5eDhz5bO1A8FMnkiLMhWt6nI0NJCEEy9BpUw9u9ElgSR2UaTV8u0jTXq0cqhTRSaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690860; c=relaxed/simple;
	bh=5JUMQ9DVUdQVwokzYhzDF5+4yHYW5WaZ6dKFzUPm9mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9v/d7jNM1ow76w6toLKTnTnqI0TpaIi6XJSLN/xU9qQmrXXxoWkumPF2tnyVGqpz9FFW9M8o4DJhWPkA8EPmOrc8ttEYojxRKUeC9sFCBgSQpVYt31ofvyYj4ZcaGErm5tSzrzI94gJauRSBgCy90zjAsRz+hJHHm5a0+r897U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aZcVRk5c; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760690856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ITwxdB7PWXKfRZv2OTqV1MZgCdb/cKw8xN4yW0YqhFU=;
	b=aZcVRk5cWmXQOq+iUjpuHVqys2yCy80XkuWRcRdHAdQg9w1T3IOSgT7YrYVmp8bJfbtn2s
	hE+TjH0zh7mh/zgCMaMBjAsUfWM9++Hk6pKO4/zxZunwBWSnLBHfGiQB0ZySgTeDRUgsO5
	mQdpSnvLaVy50WIXsw5xuUaxLQkEhi0=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 0/6] smb/server: fix return values of smb2_0_server_cmds proc
Date: Fri, 17 Oct 2025 16:46:04 +0800
Message-ID: <20251017084610.3085644-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

These functions should return error code when an error occurs,
then __process_request() will print the error messages.

ChenXiaoSong (6):
  smb/server: fix return value of smb2_read()
  smb/server: fix return value of smb2_notify()
  smb/server: fix return value of smb2_query_dir()
  smb/server: fix return value of smb2_ioctl()
  smb/server: fix return value of smb2_oplock_break()
  smb/server: update some misguided comment of smb2_0_server_cmds proc

 fs/smb/server/smb2pdu.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

-- 
2.43.0


