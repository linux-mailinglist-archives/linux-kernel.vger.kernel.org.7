Return-Path: <linux-kernel+bounces-878185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B50C1FFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF4419C558B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EB42D9493;
	Thu, 30 Oct 2025 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f//lnYEV"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5486347
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826739; cv=none; b=gI/Ft/K6Wrw0d4tKhY1OVMrf9ngpW+JIa7aQnqh9oVq5iKryK5i+QCVmpPNHGUcWD4Ih2Qc6AHSLXLqTX6d3aVbkLWpcAcxYLSyjFD6kkUuqvk1gRVvGEB01RyZNG0JtTVrVcEf4NxdPxM1DMfV6gCWHq6i+CQ+HHciVH0CvNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826739; c=relaxed/simple;
	bh=TABK/Q+ydCHzLyK7rxDmqk1HrIEcMcD1FUzJNM7w9h4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZsK1G0Lp/bO3SoOuwwlHD2InyMXTan1A5h8fyik2DUrv6+2Tcubp+5GIilqJmR6H4pViln2tyrJbY0fW9okAnQEV+3J21Mmk2M3fOIjm+7FFZm1nEzzaPzvnQyPYy/1eXSO66P02oXkDjcON0AiSzXeyqjGvbSyQKCrqAG5GKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f//lnYEV; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761826734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OdFEC/WJhQ8Epnksfw2pN1ATvi7R6vX3+Bf3YnT57Rg=;
	b=f//lnYEVbdkIC+QtcC6zlI35rSP8ZTkEPEk0y5l5VUJBs6py9Zx7ULLvreXbJVLVbrhunh
	wvNNTCenluCx/OuPqAXXx9/mAcYCyy3Un3AmDX2STq4Ie1w4bPbrFAPmlpdeCOHLr4/Lb8
	YeQtH0Ke4edvXDI7rK7xSN0xlVGukwU=
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mailmap: add entry for Hao Ge
Date: Thu, 30 Oct 2025 20:17:46 +0800
Message-Id: <20251030121746.230747-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Use hao.ge@linux.dev as the main address for kernel work

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 717d754b378c..85fc24840c9d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -298,6 +298,7 @@ Hans de Goede <hansg@kernel.org> <hdegoede@redhat.com>
 Hans Verkuil <hverkuil@kernel.org> <hverkuil@xs4all.nl>
 Hans Verkuil <hverkuil@kernel.org> <hverkuil-cisco@xs4all.nl>
 Hans Verkuil <hverkuil@kernel.org> <hansverk@cisco.com>
+Hao Ge <hao.ge@linux.dev> <gehao@kylinos.cn>
 Harry Yoo <harry.yoo@oracle.com> <42.hyeyoo@gmail.com>
 Heiko Carstens <hca@linux.ibm.com> <h.carstens@de.ibm.com>
 Heiko Carstens <hca@linux.ibm.com> <heiko.carstens@de.ibm.com>
-- 
2.25.1


