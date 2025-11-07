Return-Path: <linux-kernel+bounces-890505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CF6C40349
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68A73A4BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39801319875;
	Fri,  7 Nov 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5oMzYhe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CBF2E62A4;
	Fri,  7 Nov 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523702; cv=none; b=scscx5Ep/qZmN5xusFl9J9qI2B1UTkGmPzgQPTP4UpNpD9m2A4UGes02n8jM3+Ja4z3FaE81i3BnkqZqZrpE0/w9wOXeK8yxWQ3PQO66yAPa4lArpThIEruZxHhYCg6q12lsiV7KAJrUY64ZBG1tLXEh8rI8s1rGDq7y+iBpVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523702; c=relaxed/simple;
	bh=6NCfWVkIp1Q2R/4X+yJFBnR/cpv4ykJqJ8l4keGl8nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFkjvtB6L2UWnoeGT1bqvbaPvapf+OnlWKd54NnQcAAyHwBPxNBgiN/+h3s/iG8+gWsmhUSL8NkA0Cj/nUNE7onvoGRIZj8tRlrI7fQfgWuxdgDH6fAJyFw3699wR0xYzLgxLH0pdWDA6le32UsipoNLsgLnnxNszc7wWj6yLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5oMzYhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150DAC19421;
	Fri,  7 Nov 2025 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762523701;
	bh=6NCfWVkIp1Q2R/4X+yJFBnR/cpv4ykJqJ8l4keGl8nw=;
	h=From:To:Cc:Subject:Date:From;
	b=g5oMzYhedcKq+VcXbfaAX3nGEAR5LPfkH467a15WhkMeGwTVFuMtzaIAj9ibkZ1c6
	 LNUpjO+O0xHQR13rX+mc/0B4AqcDWYFT4hbL0HLDSOu762GFQ8EFv7t7XFByRPrMVI
	 AIz7MLPs/0oZ1VhiguU1NG9RlFBQ7d0cud7yrvI16GFqtNlDOae2O+t1HnwJx99yBY
	 zd8a38rEa1JawnZ/KotdkfA3XZlQaJn6wFByMk5UL9hUjJGlKQnB6G8gT1v5/x5QZ7
	 8eB81nStL1SWiKLw6bbu+pQ7J7jmzDmf+CGvRNvOCZ4rejajwXwYlSSboIwqD7zQSB
	 /5hc/7BVAfuUQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vHMva-00000002GNp-3wkk;
	Fri, 07 Nov 2025 14:54:58 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/docs/get_abi.py: fix get_abi library directory
Date: Fri,  7 Nov 2025 14:54:49 +0100
Message-ID: <3839bc4db2d5c7e14dd2686876a2c7b5d72a46cd.1762523688.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

changeset a5dd93016f20 ("docs: move get_abi.py to tools/docs") moved
the script location, but didn't update library location, causing it
to fail.

Fixes: a5dd93016f20 ("docs: move get_abi.py to tools/docs")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/get_abi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docs/get_abi.py b/tools/docs/get_abi.py
index 7ce4748a46d2..da69e77559cc 100755
--- a/tools/docs/get_abi.py
+++ b/tools/docs/get_abi.py
@@ -14,7 +14,7 @@ import sys
 
 # Import Python modules
 
-LIB_DIR = "lib/abi"
+LIB_DIR = "../../scripts/lib/abi"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
-- 
2.51.1


