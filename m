Return-Path: <linux-kernel+bounces-796077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0320B3FBA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FC23A2CD3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3912EFD82;
	Tue,  2 Sep 2025 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQWLRUOK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547C2ED873
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807349; cv=none; b=qUy155ZhBomzXnIAkPeAt+oKpSXsDGUEZoIjwmE5Esn6VfENQLZieP/5VTKuTflpEVyt634MJLYmzDMwPbs8un+gzRzCHYCJNQ50+DE4FI1dmyxKMUzi27+X/fdyr+UGSI6ISklyWypRK86L9eXZeCU7jBQ7yAdCmmUopYOY2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807349; c=relaxed/simple;
	bh=D5MSQz7Pvdz2UU7sRfKmdPF8rx4gsuLLpdAGOHXsbHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCBXb1SLni9WfbWh6fKjyTqc+ka69p7WokWRmuVVFD9KktnFhKtJgLONcvMuHCohGujWA7FWIiVb2u2yuUg71PgU0yA8t6X6LoM6VU7srmVeqccRXG+nk3DtJK14cZznRNvdDRyoBmMH8E4DuZnzlvJv+CzRadGxjQ2kdRK16DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQWLRUOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A02C4CEF8;
	Tue,  2 Sep 2025 10:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756807349;
	bh=D5MSQz7Pvdz2UU7sRfKmdPF8rx4gsuLLpdAGOHXsbHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQWLRUOK/qLmcG3q4X8TWTm1EkP6hei+fKvnZ/6iJwOV+ra2EhqTT7kyHPz3+QpnU
	 cQ1Bf9R2fCCeCf3NopZprus6a7Yvgz5zfIGl2SUQaWt9NV4cnGuuo1GDufRl5F+Xtf
	 VID08cr39S9+Lbu0ZYY9McyRk6H4MohxlFbMqGr32tker4PepXQJkRfg/AkSboU/zu
	 IyipPL0sLLEvlnBwHl6dVXhur1ETut+xCeNYsO8PTF+VY8TOpjbSmrMg1Jd1ZTa2e3
	 96OJhcJhni9pMKVDk7Y+5oyw5v6oCixGgpjnuqyDOmCvmguMKSOw1xHCTNflbFO3O0
	 UDh4ZYTndLlJQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1utNqM-00000003X7h-3Zpo;
	Tue, 02 Sep 2025 12:02:26 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Hans Verkuil" <hverkuil@xs4all.nl>,
	"Sakari Ailus" <sakari.ailus@iki.fi>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] MAINTAINERS: fix a couple issues at media input infrastructure
Date: Tue,  2 Sep 2025 12:02:19 +0200
Message-ID: <2cfcaefd4680270a470a5ada6d07128c0133c317.1756807237.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756807237.git.mchehab+huawei@kernel.org>
References: <cover.1756807237.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The media input infrastructure is missing a record for our maintainer's
entry profile. Also, patchwork link is wrong.

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..6934c453bc48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15415,8 +15415,9 @@ MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
+P:	Documentation/driver-api/media/maintainer-entry-profile.rst
 W:	https://linuxtv.org
-Q:	http://patchwork.kernel.org/project/linux-media/list/
+Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/media.git
 F:	Documentation/admin-guide/media/
 F:	Documentation/devicetree/bindings/media/
-- 
2.51.0


