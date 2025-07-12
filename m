Return-Path: <linux-kernel+bounces-728740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AA5B02C66
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AE23B4EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5052135C5;
	Sat, 12 Jul 2025 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Npb7rfQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BBF28DF3F
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344387; cv=none; b=J4xI6/SLMa15TeSVE/Bv0scaCfUXQ4LLmFHu+8ngbyrZiTf1zKB65dFJxFuyyy/b7xYNrvh1Z7azDXkv0xFn79oi7iIjhdRCELMk1wdEVDqlZcqwDeUZaBtsTA2MwRepQTTfKCn4e0FhnaXvaG+29yUsXAFnmEz9nEEeoZB9BTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344387; c=relaxed/simple;
	bh=cKDo2cQYpxbxGJvwA2sWGEMdZk+lmXE1gNeWaC3kzNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWBKHzMZgoJULdBs51WuOXRwYc9jLoaLhmeE9Lgnq/wnAwYA84wk9MTrF6DLpWbegYnIfl6TLPrWItBaQmxZRMCBmu/y95QXsLb0ABxcVZkjS3IBuY1PFX1+HpVAsJenBn422R99FdUWRrK3g4QGDSiRDugdhOdoIa/zaSWn6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Npb7rfQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B490CC4CEEF;
	Sat, 12 Jul 2025 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344386;
	bh=cKDo2cQYpxbxGJvwA2sWGEMdZk+lmXE1gNeWaC3kzNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Npb7rfQG2sf758jYUOrQ13QbLjNK/q3ZH2nN4beZxUEAr9YiajoAeXKMNAI3DtJhp
	 YWSRnX+EMkda842LuHkvwE0MrceFyTcSomN6rLP7WLOlUYefszIyjzkYKnHKXf6MnW
	 zvMJUs1cMPSpEX/FVxPGbExAFlp5M2lMxEEjmy0StRfBkQD8+s4eF2uMlspow5rCtl
	 YvHXLAf/4PhZ498uRQC3oo39eJT5mZ6d5+73WwQ7ge0ZVbxLwErDsABCzMnZFjSHXt
	 xoLlgq9ZjlN0dptAp7gUtlArpZgycewh4wwzk2IVItqUVdiuHf8Xhv9lq8CNEhoXeT
	 YKhZnESnPw+8w==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 5/8] nvmem: make nvmem_bus_type constant
Date: Sat, 12 Jul 2025 19:19:01 +0100
Message-ID: <20250712181905.6738-6-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250712181905.6738-1-srini@kernel.org>
References: <20250712181905.6738-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Now that the driver core can properly handle constant struct bus_type,
move the nvmem_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 880572ba515a..817f55f3a19e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -544,7 +544,7 @@ static const struct device_type nvmem_provider_type = {
 	.release	= nvmem_release,
 };
 
-static struct bus_type nvmem_bus_type = {
+static const struct bus_type nvmem_bus_type = {
 	.name		= "nvmem",
 };
 
-- 
2.43.0


