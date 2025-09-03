Return-Path: <linux-kernel+bounces-799005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC7B425C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1FC3B0AB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3C13A258;
	Wed,  3 Sep 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpZOoyQJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF6285C8A;
	Wed,  3 Sep 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914302; cv=none; b=pwRSRdHvmoasqg3MWG47wet9L80CsBgYL8MfaAJ6zbZHi4S/1xe8iMTZ5nDacn+Y2eC5Uf0uRx5hmwWVlFbcXjRcjilc1Y0MJdNkucC0kEW1MgJqineQCejwisW12RCp4VKa+Yd5pCvvce2lIsxhtIwARU1GzSwa/tV+aD0t+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914302; c=relaxed/simple;
	bh=uGAsJGJpxFTuaDQGGkCgIKWHmb8lqqQagqgiF5HxTWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Me/UsGWH9GygJ7j/T+jJ/UdinzGx8Ke7GMg6zsBFrucyrpRheFPX3Tme27mNgXlIrSUPKDxsou9Feb9PxdihMRYn7u3BRVJq8KlhKr9UW8YeelIFWXq1xwy/RgM0zPvQH5me+d9ptsKf0j6i84Vu9CIlCLwLf7WLhJDHhuxg5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpZOoyQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8E0C4CEF0;
	Wed,  3 Sep 2025 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756914302;
	bh=uGAsJGJpxFTuaDQGGkCgIKWHmb8lqqQagqgiF5HxTWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpZOoyQJjY6zwmfqMRfRaJs1CEyKHhqCZmi2VogdhVE64l8kCkKVq8YYkKF3RJQB5
	 /JaNo6aZSbVKNgCbOXfuSsphLmfOldD3xDVs2dT+ShQe+eUKhU9LTHpMoJwuJmgu88
	 Yky28Ohx5PrYUQEqS3PkJbIzGdms8+hCb/Q44vkrSIqYjFkvagxl6g/CsGBJzi3p5y
	 gKKUhY/mFJMou+v1o0tT+sIQi54DAlPs5FiPAROWWuCPNSVnXbJis5ymwrJ+QUYyhG
	 VLHJfK6FfiPXgYBuTjDYk/5xLy8iL9VtEu4riCoNpC7rAnxKjXzRE6bV9oemrM9s9k
	 qumLtKUWxtHMA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1utpfQ-00000007N6f-0ucW;
	Wed, 03 Sep 2025 17:45:00 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/3] tools/docs: sphinx-* break documentation bulds on openSUSE
Date: Wed,  3 Sep 2025 17:44:36 +0200
Message-ID: <35ccc7da482127f1ed1f04b22b6fe42c39e86ab7.1756913837.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756913837.git.mchehab+huawei@kernel.org>
References: <cover.1756913837.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Before this patch, building htmldocs on opensuseLEAP works
fine:

    # make htmldocs
    Available Python versions:
      /usr/bin/python3.11

    Python 3.6.15 not supported. Changing to /usr/bin/python3.11
    Python 3.6.15 not supported. Changing to /usr/bin/python3.11
    Using alabaster theme
    Using Python kernel-doc

    ...

As the logic detects that Python 3.6 is too old and recommends
intalling python311-Sphinx. If installed, documentation builds
work like a charm.

Yet, some develpers complained that running python3.11 instead
of python3 should not happen. So, let's break the build to make
them happier:

    # make htmldocs Available Python versions:
      /usr/bin/python3.11

    Python 3.6.15 not supported. Bailing out
    make[2]: *** [Documentation/Makefile:74: htmldocs] Error 1
    make[1]: *** [/root/Makefile:1806: htmldocs] Error 2
    make: *** [Makefile:248: __sub-make] Error 2

It should be then up to the user to figure out a way to make
it work again.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-pre-install | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install
index 663d4e2a3f57..ecd08e09bae9 100755
--- a/tools/docs/sphinx-pre-install
+++ b/tools/docs/sphinx-pre-install
@@ -1531,7 +1531,7 @@ def main():
 
     checker = SphinxDependencyChecker(args)
 
-    PythonVersion.check_python(MIN_PYTHON_VERSION)
+    PythonVersion.check_python(MIN_PYTHON_VERSION, show_alternatives=True)
     checker.check_needs()
 
 # Call main if not used as module
-- 
2.51.0


