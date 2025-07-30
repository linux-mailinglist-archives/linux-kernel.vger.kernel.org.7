Return-Path: <linux-kernel+bounces-750560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA4B15E09
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E63166196
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAED279DA1;
	Wed, 30 Jul 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL0N5Xsn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D026FA4C;
	Wed, 30 Jul 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870820; cv=none; b=Oj0fqXNRjxOnKdAS1rduy0Tmry7HBQfCc4Fh/ciGEvu/9+xf1QYUtFjQfpfhvkAlGsonrM5UducfAIFU2G5RVWch3ohvqbyJIkynhPWmIzzDy8VVzfrYamkF2foFYii2dJ16AVlneik0/DzrtgvezaDm82um/AVRcLATYkfNdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870820; c=relaxed/simple;
	bh=e+JN958vU0P5oJLGzfDThTXGhmm76QefDUtUft7f8pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctwR3Iy2WwPjsqsVBHpoLMxKQrxx2xbxSkNzVmR3qbHHhR65tWFXtpUzfrQNAL4ztPBiXKgl+KtX7w1SrnhXXU7SU0Swnd5IRaCmTM10LseoAsk/xxkbgl2vf7L49EvyKP4CY0do8RcmMKA+Ej6a3qksnu2Y+UQLCoCBbMpBu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL0N5Xsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8422AC4CEE7;
	Wed, 30 Jul 2025 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753870817;
	bh=e+JN958vU0P5oJLGzfDThTXGhmm76QefDUtUft7f8pg=;
	h=From:To:Cc:Subject:Date:From;
	b=FL0N5XsnD1OmwCVAs4iRoWVoFkl+fIuPA63pfcJQcEtT7l6VFZSDVoHZA5paR8fms
	 9Yv9TAV6diQbH83ULeOuJNSG1hOrOPLcnDB237/s17CFQZUhoXIpmlZOivOnuOSrGE
	 qKSwi+b+u58HxLmUMvCaQc74O1cf52U+U2yzcDyOAffrRxRNGs8SjdYB0ZGZY95Nbe
	 TdWnJKDBlp/NAK6w9+ZJckF3JBQA13gZn7fQhVO8lsT6/W8ksouOKmx3DIUMXUxuqX
	 B+pvjwqUp/ZPmr7Q/CZaGnZgK1y6K110wT9oTmXOhcvU/hlXQIYIRDHHJCxBXv/w0P
	 1RXFMyT3MWdgw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uh3uw-0000000CUQV-3s3m;
	Wed, 30 Jul 2025 12:20:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: gpu: nouveau.rst: fix a wrong path
Date: Wed, 30 Jul 2025 12:20:08 +0200
Message-ID: <20250730102010.2976882-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The nouveau.rst file is pointing to a file at the wrong path,
causing doctree cache expires and forcing kernel-doc to run every
time.

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/gpu/nouveau.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/nouveau.rst b/Documentation/gpu/nouveau.rst
index b8c801e0068c..cab2e81013bc 100644
--- a/Documentation/gpu/nouveau.rst
+++ b/Documentation/gpu/nouveau.rst
@@ -25,7 +25,7 @@ providing a consistent API to upper layers of the driver stack.
 GSP Support
 ------------------------
 
-.. kernel-doc:: drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+.. kernel-doc:: drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
    :doc: GSP message queue element
 
 .. kernel-doc:: drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
-- 
2.50.1


