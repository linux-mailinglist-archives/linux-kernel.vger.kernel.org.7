Return-Path: <linux-kernel+bounces-799089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CD2B426D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310E61889AB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEF92EF675;
	Wed,  3 Sep 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChG+Pq3q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C842D63E4;
	Wed,  3 Sep 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916671; cv=none; b=ivGlkiadMQ4dm7Bkrhn4+fcRDi1EqK1tOMjnCsawNygHDsNYjhTBpiDK/1+fNKbE2rmi2EsJ9yxNh2cIkvdgDIszYZXCrARfRFXEzfnu0PuOPrHRdK+F3Ee5ZmNon3oqrZoxTohtfTE50zMvMWasCHXipw6+EWLUzf7Yvg03pLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916671; c=relaxed/simple;
	bh=DL6QTWpxjep8S77vkYK54cGY5aTugS5u3x3ExCSFzJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oyDjURu+ff3TvgbPLd7zbLEl949gA7smaqHwLVugvg9liQJ+m08ka3v5bahe2K8Nw4xfvowxCCbHfZRaHhgp9WPDfhfZc8S7pN8odX+lUhWBLkh+YNUvqvgZBkyb3Cu5Gd4xbIR2LKljyezWEPo1WDZdvvgJtdir/7KtojjaUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChG+Pq3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEA7C4CEF7;
	Wed,  3 Sep 2025 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756916670;
	bh=DL6QTWpxjep8S77vkYK54cGY5aTugS5u3x3ExCSFzJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChG+Pq3qDcRC+nd4R6whFyaNia1iwrqnCqXksGoRITxD03ICyUn4RQpLKr7UHAkut
	 HRog8JvEQ45l2VlKsVFoI9LC9sKQSL/HNK9SfFWeQoZbprCCTmfP84yQtFC9k30Lq4
	 FoyU9CFEMGuHrjuHQ6UfINLNSNJ5hGot05u8Wf7hV6fkggnT0MF4KZvE7f/xR1BA7f
	 asBYUj9eqs+WUq3QbfehrVWmUJ41gwf2LPp6p4eO7X8tL1RXU3fyOXAOhQd9+js6jg
	 0yrCfVrD2RQLJCWa8Uhlrm9cyFCxj9zfO9OqYLzWH5bOnfUnYdfR45K2Fijj94GSlC
	 DpZMs8XmcbIfg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1utqHc-00000007Vov-3kcx;
	Wed, 03 Sep 2025 18:24:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <mchehab+huawei@kernel.org>,
	Benno Lossin <mchehab+huawei@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <mchehab+huawei@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Miguel Ojeda <mchehab+huawei@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 3/3] tools/docs: sphinx-* break documentation bulds on openSUSE
Date: Wed,  3 Sep 2025 18:24:16 +0200
Message-ID: <29135db8c8094006f256e1fa0b64663c735737e7.1756916565.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756916565.git.mchehab+huawei@kernel.org>
References: <cover.1756916565.git.mchehab+huawei@kernel.org>
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

    $ make htmldocs
    Python 3.6.15 not supported. Bailing out
    You could run, instead:
      /usr/bin/python3.11 /root/tools/docs/sphinx-build-wrapper htmldocs --sphinxdirs=. --conf=conf.py --theme= --css= --paper=

    Python 3.6.15 not supported. Bailing out
    make[2]: *** [Documentation/Makefile:75: htmldocs] Error 1
    make[1]: *** [/root/Makefile:1806: htmldocs] Error 2
    make: *** [Makefile:248: __sub-make] Error 2

It should be noticed that:

1. after this change, sphinx-pre-install needs to be called
   by hand:

    $ /usr/bin/python3.11 tools/docs/sphinx-pre-install
    Detected OS: openSUSE Leap 15.6.
    Sphinx version: 7.2.6

    All optional dependencies are met.
    Needed package dependencies are met.

2. sphinx-build-wrapper will auto-detect python3.11 and
   suggest a way to build the docs using the parameters passed
   via make variables. In this specific example:

   /usr/bin/python3.11 /root/tools/docs/sphinx-build-wrapper htmldocs --sphinxdirs=. --conf=conf.py --theme= --css= --paper=

3. As this needs to be executed outside docs Makefile, it won't run
   the validation check scripts nor build Rust documentation if
   enabled, as the extra scripts are part of the docs Makefile.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 3 ++-
 tools/docs/sphinx-pre-install   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 932b1b675274..48e6e0a76aeb 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -719,7 +719,8 @@ def main():
 
     args = parser.parse_args()
 
-    PythonVersion.check_python(MIN_PYTHON_VERSION)
+    PythonVersion.check_python(MIN_PYTHON_VERSION, show_alternatives=True,
+                               bail_out=True)
 
     builder = SphinxBuilder(venv=args.venv, verbose=args.verbose,
                             n_jobs=args.jobs, interactive=args.interactive)
diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install
index 663d4e2a3f57..698989584b6a 100755
--- a/tools/docs/sphinx-pre-install
+++ b/tools/docs/sphinx-pre-install
@@ -1531,7 +1531,8 @@ def main():
 
     checker = SphinxDependencyChecker(args)
 
-    PythonVersion.check_python(MIN_PYTHON_VERSION)
+    PythonVersion.check_python(MIN_PYTHON_VERSION,
+                               bail_out=True, success_on_error=True)
     checker.check_needs()
 
 # Call main if not used as module
-- 
2.51.0


