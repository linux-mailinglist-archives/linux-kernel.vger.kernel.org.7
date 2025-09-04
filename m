Return-Path: <linux-kernel+bounces-800158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C912CB43431
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02844687D2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BD2C026F;
	Thu,  4 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olTW0BUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F32BE03E;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971207; cv=none; b=UF0VO1Lut9B94hkzIXFsKeyBKstk3fzZoaA+9b3NyTPMyQwPy0E9s+CIveKuF6YipZMUMOAK35Trcy+P2TN5vAv5oMCGM3YuhgejlQ0gR7X0Bgtwnf2DeofeJIlaIctLSWI7PrLQNV6s4DTX67vUvxfRAw9NTi+dV8CvNZnQVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971207; c=relaxed/simple;
	bh=/dLIDswzK4KrvEpdBfQvdI/IqyHPjqk3TcTvIyNvmfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eq0KDrj2lFxFWC+qH3FVXcbA8tKc7p1jLx4JxF9o7NqnzX/7UX2xW+7ZOddcplnDhwqtFNOd/uaD3sm0lEmqufiOX/OCEF2g55YzRIVU8K5fJWlVm/V+j0LrK9N79QG96ftTmuTRTML4/+DmMdhLC09qbemLeceWMdrTfdLrC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olTW0BUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C1EC4CEF4;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756971206;
	bh=/dLIDswzK4KrvEpdBfQvdI/IqyHPjqk3TcTvIyNvmfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=olTW0BUV8uUhz+OhKjYSqZaxES6n4IP1BzDAsguRctcvzUkHBGIsb+3bidZ/OLoO5
	 BYUBLRxjqc77FsXlM1RMu15grqZJFv8CFjo7F2bjlVpX2QHdxwWMfIWvPAhXIv2VHm
	 09WFO6Ip+gT2RtxES96bd9YDuhYRnkTZFUPH2DtuisbRBK/0nmhGSpPKf5+Xo5ZqAH
	 77Mv/8+u8pyeVTbETMgWB3Ng9Gstsbf290/V9+Xq32XQhyrRxzFiPEoRc6HYoVTHAQ
	 zYQN3nOeNEkWlF0THA34KtUugYYLCl3h8HjP3AFJo/4fihlfv0UbBJ4cSmklHovMWB
	 fVyU69HAgjh/g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uu4TE-00000009jPT-3REL;
	Thu, 04 Sep 2025 09:33:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/19] tools/docs: python_version: drop a debug print
Date: Thu,  4 Sep 2025 09:33:06 +0200
Message-ID: <64cdaa3c980931ee7e25e3b3494070c47bbf5545.1756969623.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
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


