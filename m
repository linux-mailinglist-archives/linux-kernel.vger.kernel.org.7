Return-Path: <linux-kernel+bounces-818573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587FDB5938E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC7C7B3A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA28308F09;
	Tue, 16 Sep 2025 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5y++ur3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2F30506D;
	Tue, 16 Sep 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018216; cv=none; b=YygVJpM0uJ+3abNhiYBy0O2D/sKcdHSU6Fn1hnG+DiDknsJ5FoKday/lKy1/DbPc6HhSJ8QtmxF3WriMmvnMXJL+p8ZSQPqUSQ1vX3WZjohdC/87Via7zfFZMArJGgQIUefgR47Ws6U97ObC87dcEbFQjhPCSZgrQHQs3qcz09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018216; c=relaxed/simple;
	bh=/dLIDswzK4KrvEpdBfQvdI/IqyHPjqk3TcTvIyNvmfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/YbCeFElzsJI8pTvhnPEBm+/AHLB5ffI5QjeuuAD7ClUwNLePHBQ26GbWrc8KjRxdBkl9sI+7p/k9kzbZfvAJ3aCcIH+6gRDteNy9ArjM4eCn8kiaKTVTm0tJ7qOZeQXjqYVj13cKZVaDm9ZfI9WbHZfGD4WXwNZfciMwj9L4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5y++ur3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF02C4CEFE;
	Tue, 16 Sep 2025 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018216;
	bh=/dLIDswzK4KrvEpdBfQvdI/IqyHPjqk3TcTvIyNvmfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5y++ur3FJctcIQyCdY6+J2GJxxq/RSju+p2kJCbJQAqw8rlikBKIGxxYOKH7cKAc
	 bhdY5SLNfJIr2XPy5lbLi1vWaqLvhTind+M3iByH4G1vhOuXb4xG0tD1W2IynoJXtq
	 yFj5W+tuGVTpZVsbmZ8EMwkbHCIhsmohDixhAfOpYzkDJK4MMzj0sXCGHaoeRwGzR4
	 tNpYbmp5w+agXnZaO0fuXr6Yyw5UbKrW6H+tUct2ZZ07HABIpAWA5QuHgtG+CF3Hde
	 lsQMTZ9h5OPGAcMYqLorUMKV/jyIzw2+nbIEpI6pyD4m3E0lS0cUakL4iT1U/sA2X4
	 byeekTu925/Ew==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqS-0000000BBP7-3XsV;
	Tue, 16 Sep 2025 12:23:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/21] tools/docs: python_version: drop a debug print
Date: Tue, 16 Sep 2025 12:22:44 +0200
Message-ID: <b7083c2f1c2355e0b566f6d991328d12f193e4cd.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
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


