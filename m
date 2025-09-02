Return-Path: <linux-kernel+bounces-796078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B93AB3FBA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFF03A2461
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC82EFD81;
	Tue,  2 Sep 2025 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itHUnhd8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FF2ED868;
	Tue,  2 Sep 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807349; cv=none; b=rgQXKRz9zZ+v3U/uSmGmpfoZpidBB+fUewGfN7hLDlZdR0s6wYeBEwPW38qdX/3I2xhP4zwP4l0kBZadPbTBMlHcwi4pyHSa2F8lsoJMI4x/jk190135ElBORXFXTiCBmdVlmAZn7DnEDFCNH3ZoIctHtV4sGo3EyA8jRwcUWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807349; c=relaxed/simple;
	bh=KNXqRhmdy4JV+Ng/rg+beXmKR5uyZSW68UcsdbZ0D8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1H7CTHaHIfuglS3tYiV4S34Rfsyg61NsQ4VxjFnmWr+Y5rE+aagwpebvef15l3sTJSM7Htd1wjWfm4SRec8maBHygnsMuqTCKF/44RLZFg6QA25z7ppNz/wRd+B0jEQAj9KJ3Vcg15AEt4dGx5jGCzTf8y7L5Y/SoUeJIVgbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itHUnhd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E377C4CEF7;
	Tue,  2 Sep 2025 10:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756807349;
	bh=KNXqRhmdy4JV+Ng/rg+beXmKR5uyZSW68UcsdbZ0D8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=itHUnhd8erIjyGjbqj4h8Pu5qWcaqaj6DPG9K5mBWTLQvjRzGLMZfeKXs2SobP6M7
	 ZzR6K486K1b4eCyo13ZkYTwcX7WFHlcXyeQglG5GSszlBiSHaP8ctIJcr2MqLPT2Xr
	 Dg/FuK+fFQxEMnyATtBnhAGjgvlbp0h1UNsg3bHVcytg8v62rgDVh2/1HcBA4zZWMA
	 XKrGUUBTFyMauT6KvwCst4d1SDv1PFCaiQ/9/WnodM3zNmrDxwpcQJZ6QyudbHTWMx
	 D88c7ybOvorbY37IiAeiIcKhkk3VFEQTZf19nAkVPdC2KSyqlleyG0h528x8pubZUp
	 qdJtysabOZ9Rg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1utNqM-00000003X7d-3T0v;
	Tue, 02 Sep 2025 12:02:26 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Hans Verkuil" <hverkuil@xs4all.nl>,
	"Sakari Ailus" <sakari.ailus@iki.fi>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH v5 1/5] docs: maintainer-pgp-guide.rst: add a reference for kernel.org sign
Date: Tue,  2 Sep 2025 12:02:18 +0200
Message-ID: <2d8d4e6eeb3c5adbf0f34c8096d594c6bca2c82d.1756807237.git.mchehab+huawei@kernel.org>
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

The media profile documentation will point to kernel.org sign.
Add a link to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/process/maintainer-pgp-guide.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index f5277993b195..795ef8d89271 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -903,6 +903,8 @@ the new default in GnuPG v2). To set it, add (or modify) the
 
     trust-model tofu+pgp
 
+.. _kernel_org_trust_repository:
+
 Using the kernel.org web of trust repository
 --------------------------------------------
 
-- 
2.51.0


