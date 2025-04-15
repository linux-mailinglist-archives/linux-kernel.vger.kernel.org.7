Return-Path: <linux-kernel+bounces-604242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E663A89269
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 05:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECC93B70EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 03:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8821577D;
	Tue, 15 Apr 2025 03:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6mUBNXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C65212FB3;
	Tue, 15 Apr 2025 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686800; cv=none; b=GZOdL/HbqZ8oKTU3bUR9DTPENYHig3XAWlK2jEXwjmWk4lwcwVEyhyK1uqkARC3vxtu3Alu8s1DIfMKKdXKH/IrXjjZNUOExXwsOcFmx9Of3WLH639AcMpbL0EhZ/7A4z66uSslNB+TpGWHEaPJnbAWXUCn1eTJvFmjoqZWqFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686800; c=relaxed/simple;
	bh=+p0de2nK08IJUNkWKnZ2hUub4wqLuqIa0QBeJgsqMJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4B9UGnwBYSKjPxXAXoBTqqP+VqZ2qkXtMtSWNrL0sQdVR8/TewC4DDTpYDih4x3/XpABg8bgF2TE3yt3VKydBo+Q1nG6zSu8hMJUCEakZxoCadKbqdOoacVnjytdRPmExvAunOSQA9Pvytv84RqtUZspmGmHh6jaVg3+sefEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6mUBNXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD996C4CEEB;
	Tue, 15 Apr 2025 03:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744686799;
	bh=+p0de2nK08IJUNkWKnZ2hUub4wqLuqIa0QBeJgsqMJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6mUBNXXJvrHcnDdmS6V8pEUa0PNOvNOMEtD8gmuvwfk++DmBYDsALFL71Wb0IaMP
	 ik+ipXVY/GjwvNF2DKnqxcUr6El/oRrD5y3U2Act8+eTzRCn8u6Ioc3uC3mLeCCX4e
	 ON2NIbHxVVUBWGalmCVcM34Eg70Ypoy6pBJswpqS1zr4dly+BuC9cdsR5E4ocbTdGh
	 SbDC4p+rDkspf7hb7TXn/Kxkp9zZa0d0zvs90AnEUUquN52D/nq2DCwNsnLhhu1MDQ
	 PFo5u6Og0g8aX1iYabA0tj4Sx3wn3i7Mya4/SpHP+Ji7P+uG+9V9Rv5HROENVUbL/+
	 hboahppDYCBcg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1u4WjU-00000002FHD-3pPT;
	Tue, 15 Apr 2025 11:13:08 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] scripts/lib/kdoc/kdoc_files.py: don't try to join None
Date: Tue, 15 Apr 2025 11:12:48 +0800
Message-ID: <4334d16f14cfd93e611b290fb56c35d236cadcb7.1744685912.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744685912.git.mchehab+huawei@kernel.org>
References: <cover.1744685912.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

If out_msg() returns None, it means that an unknown declaration
was found. Avoid letting the script crash on such case.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_files.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index dd003feefd1b..2e51e5f3bb77 100644
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -270,13 +270,16 @@ class KernelFiles():
 
             msg = ""
             for name, arg in self.results[fname]:
-                msg += self.out_msg(fname, name, arg)
+                m = self.out_msg(fname, name, arg)
 
-                if msg is None:
+                if m is None:
                     ln = arg.get("ln", 0)
                     dtype = arg.get('type', "")
 
                     self.config.log.warning("%s:%d Can't handle %s",
                                             fname, ln, dtype)
+                else:
+                    msg += m
+
             if msg:
                 yield fname, msg
-- 
2.49.0


