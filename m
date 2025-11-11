Return-Path: <linux-kernel+bounces-895824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C0FC4F076
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CCEB4E4D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61836CE01;
	Tue, 11 Nov 2025 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJC6/Utw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373E36CDEF;
	Tue, 11 Nov 2025 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878326; cv=none; b=npHmJtWqffFSRxJ+A/ec6mkcZHiXdkkWAPMpkboDHkPnCr4fzDJqzdNBp+tPtgbfw6XSKj6vNO1pNHq3JiL+wuNHas7ftwZdZeGC114P+Zk1sAbubqDEtTYiYl436QUWvI0NDbdB7wiPuKy35mezdk5K/jou21S4S/+Lo1vg9gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878326; c=relaxed/simple;
	bh=1x3bSdifj/Y+agWknxYlWaPSqPf+q8tjTULx6P4sW0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gI10vM2XJCUjtP7CyQ7MbFMwgz0JTjRTnRhylnifZxBbOHH2LHRapYVzDgYp3qpSSlIKpAd2kjV5enY5PoJLeK4FMTepmg33SH4GjoF710bT5OYTbfv1lb62ToNHfRjPPCypI3LmsXmPtdYO7VEF31R8tj+xOe9Gldi9aZZZbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJC6/Utw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D355FC4CEFB;
	Tue, 11 Nov 2025 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762878325;
	bh=1x3bSdifj/Y+agWknxYlWaPSqPf+q8tjTULx6P4sW0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJC6/Utwb31WcJ+HpfUz8DFMbSFU7fJlsCW6yPSkozOyuds65Ps/e6Q0/qLBH6Hoz
	 nM/vOI+F1PV5jGBWbp0GQ4Y4bAWxxDwutvH+rZnJUQJfGRFbpywPMhlozYtdXkzKnV
	 FBetWwj/4MQeFASjUtOHaVfrGBVrBmMFg5PCkKum1f5XlXyAukbSbY6PQHjFfePrlG
	 /KIs/ULKdbhIOLqwtETJfdpXZKr1WQYXKiTkaAy7TZjYtxXZVVwIASSWGGcmAfKnMJ
	 njb79suLh6l0dy2XZVG95Ywa2EfFXcmvOiJDhD2KlE3VewJ19kSQiGs1mtpqt5iL+2
	 l4SZ72oBjkeqQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vIrBL-00000007t07-3PIG;
	Tue, 11 Nov 2025 17:25:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Dongliang Mu" <dzm91@hust.edu.cn>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] docs: parse-headers.rst: remove uneeded parenthesis
Date: Tue, 11 Nov 2025 17:25:11 +0100
Message-ID: <e5de9f7b1f6a963b2912574a65495c47cfbb13ba.1762878176.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1762878176.git.mchehab+huawei@kernel.org>
References: <cover.1762878176.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As pointed by Randy, the parenthesis there is not needed and it
violates the document coding style.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-doc/9d709020-03fe-467c-be7f-d5ee251bb79a@infradead.org/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/doc-guide/parse-headers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/parse-headers.rst b/Documentation/doc-guide/parse-headers.rst
index 954f3285ddf6..bd34a6d00ca9 100644
--- a/Documentation/doc-guide/parse-headers.rst
+++ b/Documentation/doc-guide/parse-headers.rst
@@ -89,7 +89,7 @@ defines the C namespace to be used.
 It is meant to allow having more comprehensive documentation, where
 uAPI headers will create cross-reference links to the code.
 
-The output is written at the (``FILE_OUT``).
+The output is written at the ``FILE_OUT``.
 
 The ``FILE_RULES`` may contain contain three types of statements:
 **ignore**, **replace** and **namespace**.
-- 
2.51.1


