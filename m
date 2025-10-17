Return-Path: <linux-kernel+bounces-857869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD6CBE81CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AFF6E1770
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BEF31B119;
	Fri, 17 Oct 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rDBOnWwq"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9D31A7ED
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698045; cv=none; b=Kb7G932C33B0ulGDwmCDibXgP6vSIcHNk9DUH+mpEV0uOEAhFAtCRnkor6H09j0soiLSccAz+MGAPhkVHDYV81BMxwwytaaRQqi2ZyAnksuoymmxunLpdHBJo5n+SKAT/Rw8MMp4I05Cv0s//9v2MNRmMicZGR+IBh+KNKF5krY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698045; c=relaxed/simple;
	bh=eN2u31X6J5x8NVJntOJHFD0HBb59Mnua9RH247iNidU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1P4WK4TBGoZmOo9hxczNhtRetW9MhkkorE5T1Ygu7U0goDayG0wM3VTwLTOGGVqM4uP8EWr6iOstErrjxl+0RptHNlhAxdyddQegwJB7Ui4n5XJJw1X4yxbVXhWJKNYXI7eFDadR69ECblBRil78c5aSIlMHLmPATNZUeemdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rDBOnWwq; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760698031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=knUWhl/rCiuaCj5yd2AoF5o8+aWC64WgMW1HajB4WgE=;
	b=rDBOnWwq5db3qkKX6EGlGM0VxDI4swOJVT/D4MhkmYZuS7nuPXyDW+OVvzWWTkuqd9xMn/
	voAKgP2AvPu2OdBoPwE5SYTP7yOVwizUaqmLrimvf7CCzFNHcVrYFEHG3uXwfkYnYT64/p
	Zw/nHh6uyT3j4/9hTl0xophXzXO9gv8=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v2 0/6] smb/server: fix return values of smb2_0_server_cmds proc
Date: Fri, 17 Oct 2025 18:46:06 +0800
Message-ID: <20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev>
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

v1->v2: Update patch #01 #02 due to typos.

v1: https://lore.kernel.org/all/20251017084610.3085644-1-chenxiaosong.chenxiaosong@linux.dev/

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


