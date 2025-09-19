Return-Path: <linux-kernel+bounces-824816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693B8B8A358
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F371679FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50EC31579B;
	Fri, 19 Sep 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O68SLvaS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAC30DEA7;
	Fri, 19 Sep 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294607; cv=none; b=fEs8n6JbFtFUMF3mN424S4H8oLosl2CbfC7q8ZuVGh1qBQ4g0suzEflbEaYHQ8eMzqarJ5cSDSk6j4RHhov0CvcgMvXqbn98Z3EbWiAnUrQGAsm5KxPftUMI+9zAafo3754qe4/LDicvSGZt7394/prWgD0pPFvWaXVvZrcyHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294607; c=relaxed/simple;
	bh=OZrDpXvXlQuEM0VXhxJ50BrsDq1+DzNvoYuPk5LMHe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1jwAcEdluYcFnqBpzI7ELO/7Y7mTMc2AYxOslzaQf72Wc/fDlSCOzqZmQzcEh/yRGfXHVFRXVaezeTvNpqQjLaFVVCWFNImUoDztf2JTCy5EvmYdp3V0OLJTEk9gPR3SWztrn8ukUBqPYLFMYMqxMcRLxxpCN3Vi3Dt9efH4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O68SLvaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9365C4CEF0;
	Fri, 19 Sep 2025 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758294606;
	bh=OZrDpXvXlQuEM0VXhxJ50BrsDq1+DzNvoYuPk5LMHe8=;
	h=From:To:Cc:Subject:Date:From;
	b=O68SLvaSpbSq56oSpBpEaVYe8gBf7pm9LFZZ1hetAhH1ZaVYClQOy4zw3RP4I6zRd
	 jerZMqZnymDa1RRCjFHDH1tbIpC6A4dd1lDNtnGVBDj5Naf3Hik0J9OOeP98qI+qV7
	 U0/qK8mVv6xXZ3HAE6KSo2ejmVtyLDOvtIchS254EvujMzvYVgpoK1hwn6WzWHweuC
	 nji0pdPFQaLpd5IXSvtjebQBY05Y6PZNbIfM8cOq0z/d3cs1DFPkC3Hei9uQob8h2g
	 jUnZJPzpauufUszGLks10dPrEPHTwLsbKgmVOZCOHVkrPJW1uU3COtYnMRd0ETf68e
	 vLL+DP4e3R+Wg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uzckO-0000000443a-3HYl;
	Fri, 19 Sep 2025 17:10:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/2] A couple patches for sphinx-build-wrapper
Date: Fri, 19 Sep 2025 17:09:58 +0200
Message-ID: <cover.1758294450.git.mchehab+huawei@kernel.org>
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

This small series is against docs/build-script branch.

The first patch addresses the lack of a check after running
sphinx-build to see if it returned some error code.

The second patch is a bonus cleanup: it get rids with
load_config.py, replacing it by a single line at conf.py,
simplifying even further docs Makefile. Thanks for
reminding me about that legacy code that we can drop!

-

I didn't implement yet Akira's suggestion of having a way
to use make -i to ignore errors from latexdocs while
doing pdf builds. I have a couple of ideas on my head.

I'm tempting to implement a:

    --no-sphinx

command line argument at sphinx-build-wrapper, which would
make it ignore the sphinx-build step. this way a makefile
rule like:

    pdf-after-latex: latexdocs
        +$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ $(RUSTDOC) \
                --sphinxdirs="$(SPHINXDIRS)" \
                --builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
                --css=$(DOCS_CSS) --paper=$(PAPER) --no-sphinx

would allow people to play with "-i", "-k", "--output-sync" and
other make arguments.

However, Friday's happy hour is quickly approaching here... Not the
best time to implement new ideas :-D

I'll try to materialize it next week.

Have a nice weekend!
Mauro

Mauro Carvalho Chehab (2):
  tools/docs: sphinx-build-wrapper: handle sphinx-build errors
  docs: conf.py: get rid of load_config.py

 Documentation/Makefile              |  4 --
 Documentation/conf.py               | 15 +++-----
 Documentation/sphinx/load_config.py | 60 -----------------------------
 tools/docs/sphinx-build-wrapper     |  9 ++++-
 4 files changed, 12 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/sphinx/load_config.py

-- 
2.51.0


