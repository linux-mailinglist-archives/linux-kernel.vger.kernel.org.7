Return-Path: <linux-kernel+bounces-813838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40861B54B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9900A1BC3BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFAA302774;
	Fri, 12 Sep 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5OMPN1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60772957C2;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677594; cv=none; b=e6GXDuNci4iRZBQsgDIH6fxF1l/+dQnXKmhU66/2lPFhzHXgD9JIOVj7MNQfmVd4n9g0wyou9JsS95WolhZXGkhEXrd7A7ORC7VeqhpdUaEw75T2ZUDfKndFWgqnMmTNvQkjWqBcq/gN9F16pi1xUvDrfUNpm7FDVswqwSKJrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677594; c=relaxed/simple;
	bh=/dLIDswzK4KrvEpdBfQvdI/IqyHPjqk3TcTvIyNvmfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fuDzh3M2A/aD1BP8vcnVmNzlmxPQP+iyTRReoYh1XG5srJHBM7xHp5WIKUiEojD7DHj4WdoHYNbYoeVExiKCrNanI4amun3SX1OD7aqCuG9cTgz1DUI5s4qTCWKUH3HEFYSYF7rVJ4I1wOGcF9vvkD81qwXni77eiheE0moeSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5OMPN1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BCEC4CEFC;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677594;
	bh=/dLIDswzK4KrvEpdBfQvdI/IqyHPjqk3TcTvIyNvmfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5OMPN1ERnOeUMs/6FawiCHzvZyV1lvwFU0rJdlxnSKLCaEhu2Ij7XV0c2vGt3WWe
	 JKd/ChpZ1Y8caFtA9fkFVwFzCOp+Q3Mx3aOFc6hs0GNTT0Pt6iTXl0ccc1vuBvO/Ev
	 ZjQ3A7Y5aLaV1hrUlAQsE3bfwG2KHWryQqZOs+TasN5GxO+amF4WvQnpzS+Rkoh7uP
	 3Z6QxiCRhEAFoKmJin9IxTJm9mepOFRGKF+w73fbq7yCor9k6RAfvM/qrSMfffWk2h
	 zVLLkrGRT6wkSiLTHebOOrmVhpaqFALEzWI5HDMppLpf+lrGcezy4IuFPX0cysPhea
	 53saI8sMksUCw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux2Ea-00000008RsH-2eZb;
	Fri, 12 Sep 2025 13:46:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/18] tools/docs: python_version: drop a debug print
Date: Fri, 12 Sep 2025 13:46:13 +0200
Message-ID: <ad6999e249924d0794cdf394f327ce47a17c1e78.1757677427.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757677427.git.mchehab+huawei@kernel.org>
References: <cover.1757677427.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The version print at the lib was added for debugging purposes.
Get rid of it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/lib/python_version.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/docs/lib/python_version.py b/tools/docs/lib/python_version.py
index 0519d524e547..660bfe7d23fa 100644
--- a/tools/docs/lib/python_version.py
+++ b/tools/docs/lib/python_version.py
@@ -109,8 +109,6 @@ class PythonVersion:
         cur_ver = sys.version_info[:3]
         if cur_ver >= min_version:
             ver = PythonVersion.ver_str(cur_ver)
-            print(f"Python version: {ver}")
-
             return
 
         python_ver = PythonVersion.ver_str(cur_ver)
-- 
2.51.0


