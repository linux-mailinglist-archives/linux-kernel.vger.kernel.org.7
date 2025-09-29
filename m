Return-Path: <linux-kernel+bounces-835970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C553CBA8786
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEE73B2F89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518B2C033C;
	Mon, 29 Sep 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzOyU37h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6527F012;
	Mon, 29 Sep 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136047; cv=none; b=fKwxWGA8wYtgFyZK0VcQOreHoOX4awIU4vxvIaqXR6ZPHMoBiZ5ViFWANcVSFw0Q/adMP33MfrMXZgYV54jfOmlHUKBEEef/EILy623C1MbiXjm9vDtDI3JKF5FuG54fFFf600xYXHW6qQd7mqLldNyYGLAHYpSDJ7KihhIDlUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136047; c=relaxed/simple;
	bh=f2nvQNoldy0Wr0lssrlNF9UVO/sGaqRBBP1u0vyUoFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLhqlXlVy5xzBe+fYytIgmj5tq14fAfuEMJjZ4L87U6P+OObDuJF1MyKYygh5BLioKUJIuOvcooEhb3EpmqPrUK6CLx1qoHQDj7/TaI5g8osMX/9PTyQz7yk+nJyYDIaA13kJP/unS46lZV7USVE4YIr2yfpSZImFdgzYku8Cqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzOyU37h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FB3C19421;
	Mon, 29 Sep 2025 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759136047;
	bh=f2nvQNoldy0Wr0lssrlNF9UVO/sGaqRBBP1u0vyUoFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IzOyU37h0LYHQBxkuVhOn+byCi9x0mogP2akPVmofET6ImL3xSamgmJUHTBxMg4IY
	 gOD6YHDge5v9S3CBs8Iod/+DlQjeT8Ze5zW4Rok3MCCssR0YB9hTgAJ3ksOmZpyHFl
	 qm+lSA7hHXlzpwvH8dJSOH7JKhB0m+7ELciDEKzyE3rZZoikB3jrgCnl9AqpvTj1YF
	 BmylS4Dkvy3m27tt+iiyO9LqyYVEQT+YKip8BPL9l0hhLd6OqVgRz0PqZ8BwBis8Nt
	 vywK5ISJ1gM6vUpzLxO7GbyJe8MScCNgOcE+DzEFcDyEE77tdVM5Xi0lXuUO7Ud0Uw
	 6f1v+DlFwS0zQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1v39e1-00000009dSJ-27sn;
	Mon, 29 Sep 2025 10:54:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 2/3] tools/docs: sphinx-build-wrapper: pdflatex is needed only for pdf
Date: Mon, 29 Sep 2025 10:53:29 +0200
Message-ID: <b62bd70e4d8f041b20492ea63b167ec39fa371f7.1759135339.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759135339.git.mchehab+huawei@kernel.org>
References: <cover.1759135339.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Fix the logic which checks for pdflatex. Currently, it complains
for both pdfdocs and latexdocs, but for the latter, all it is
needed is Sphinx.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/cover.1758881658.git.mchehab+huawei@kernel.org/T/#ma81ff2e11b8579e5edc23e4381e464081ae668b7                                      Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index cce985dced00..a74998e8309a 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -650,7 +650,7 @@ class SphinxBuilder:
             if not sphinxbuild and target != "mandocs":
                 sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")
 
-        if builder == "latex":
+        if target == "pdfdocs":
             if not self.pdflatex_cmd and not self.latexmk_cmd:
                 sys.exit("Error: pdflatex or latexmk required for PDF generation")
 
-- 
2.51.0


