Return-Path: <linux-kernel+bounces-826101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50019B8D884
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C809C189FA40
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B45824DD0E;
	Sun, 21 Sep 2025 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQaTGE9j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4A2475C7;
	Sun, 21 Sep 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758446024; cv=none; b=f1wqxrR4J1aHNAc6RXry9b10UFlA22EpDgonksdxL/IQFJ1Qrq8qZpSTUQXgONh+85OjvV/+ETWNxaNuzrVPvn7NhMN7A+irjGlDaGol/p6hojfU0TdHV6kPQOppdYsSuPhgX8Gt5WwlJELwzR+6U9PZb/cUXNT8EB6uU+Ros9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758446024; c=relaxed/simple;
	bh=GaBF4kI+LgcvSNariUqxHlLUkATP6xIPgMgblSu0q8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivtiwv2U0cQAQlI7/zDtZQd7pqIpDTfQg3lsT1iwG0gqFPnHCzenc1HCk5jQvj4xYjMYhXhaJmj/AxWInye1G/Eg43z1hYQ81ddxGzGuqZJxUcmx9KxRAEw1toDbaBnSQ6ReCxYCwC14w8EW7bk0mv14zbJh/Wgn9tUkdl6MWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQaTGE9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A32C4CEF7;
	Sun, 21 Sep 2025 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758446023;
	bh=GaBF4kI+LgcvSNariUqxHlLUkATP6xIPgMgblSu0q8I=;
	h=From:To:Cc:Subject:Date:From;
	b=YQaTGE9jh/izHc8C9lXYFbo3XGb7FzXvUuGvmlmm5LDzPYKrvce/hBOeUCtHBhcl2
	 LXUOWAxNMUnzQD8vtkgeVV89CcdCQINrHYMv5+7bYmbAh2teApR8C3uH102koWW6li
	 TR9OiOJK/6fWIIE4CL6sleLV8+IaurbMnnXO7eRbDWe0WEJObgttOFspBAl5AcVjIU
	 I1XChFTS/WPaXwqvThv/o1ZGMuAr5tWz4gKt0M2QLJkWxp/SIenlVg5S1PqsDPCPkd
	 2/T7s0Ha+exuGMqHZQnsLnpesI0ge5ZSDBeSKjFseZQ91311N+jgmuO+7+Oh8GhyGe
	 bMxE0FowORD9A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0G8b-00000005CWB-1uS3;
	Sun, 21 Sep 2025 11:13:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 0/1] sphinx-build-wrapper: add support for skipping sphinx-build
Date: Sun, 21 Sep 2025 11:13:24 +0200
Message-ID: <cover.1758444913.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

This patch adds support for not running sphinx-build at the wrapper
tool. It was requested by Akira, who wanted to be able to ignore
Sphinx errors during latex build and still try to build PDF.

This patch is against docs/build-script and applies after the 3 patch
series I sent yesterday:

    https://lore.kernel.org/linux-doc/cover.1758361087.git.mchehab+huawei@kernel.org/


While Akira's original intention is to have pdfdocs target depend on
latexdocs, IMO, this is overkill, as probably only Akira and a couple
of other developers might want to have such behavior.

See, after all changes, the makefile rule for *all* doc build targets
is simple:

        $(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
        +$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
                --sphinxdirs="$(SPHINXDIRS)" $(RUSTDOC) \
                --builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
                --theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)

After applying patch 1 from this series, it is really easy to replicate 
"make -i" by writing a small script that does:

	tools/docs/sphinx-pre-install --version-check	
	tools/docs/sphinx-build-wrapper latexdocs || echo "LaTeX build failed, but we'll try build PDF anyway"
	tools/docs/sphinx-build-wrapper -s pdfdocs

So, I'm not proposing doing any changes to Makefile, as IMHO, for
most people, the intermediate steps don't matter.

Mauro Carvalho Chehab (1):
  tools/docs/sphinx-build-wrapper: allow skipping sphinx-build step

 tools/docs/sphinx-build-wrapper | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.51.0



