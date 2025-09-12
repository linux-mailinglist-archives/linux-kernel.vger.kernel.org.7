Return-Path: <linux-kernel+bounces-814254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB2B551B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BD51898125
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEFC320A2B;
	Fri, 12 Sep 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln7bZ/os"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E23148BB;
	Fri, 12 Sep 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687250; cv=none; b=Ne/l6tQkhtaCj8TrT/flGihhkt9NV8f5b0Z2NIvU6rlo7JLJ+3shlvDUHkKutnuB5B+Z8KZYtzTCtiHJEfUp67Ogf4NrcmuOAs/dkPtmHopq71ajWVGT2QHuZMrfApQ5YqqdLF9gvOADbTld/+Ooj5S8a4vFD2dIl/Sx7wS+pWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687250; c=relaxed/simple;
	bh=7m2BSnpn3HLmj5B6FoxLVllK6QAvs55qBOxyGwl9PJI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k0JNW1bkEARd+iiAhRzO9lit9ZhpMqsefAO1ffj3ALNlyeZ4ugzsLYohVOv4/Ah1LUW247+/GGUAOygERJiVxDfHL/4y1ze3bz5rzYM6CbflnGBUrlYi6btbe7yhu1zN3+W783aeKuySz/C1fg3v/53HYOONbLQ62V0dcYzrtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln7bZ/os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED56C4CEF4;
	Fri, 12 Sep 2025 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687250;
	bh=7m2BSnpn3HLmj5B6FoxLVllK6QAvs55qBOxyGwl9PJI=;
	h=From:To:Cc:Subject:Date:From;
	b=Ln7bZ/osevdDT6VhO+M3WDUyVNMspAigzhfC5QTfn2YNlj3nqiOCHJ23U+/Wi0RQL
	 Mra9+53G6vFuaAU0gXzSQrtKT9cZ0G+iRJUHknVydUc/o+TByMD+6MkJZkV/hSKwEC
	 Yn8jRGjYrgkgn0Ga5PumL9U69zlkIZNqrnFHOf1FjHF338Dl4IFY5jfglFOuigibtV
	 Vmn6vC8GWwlcNkAp47PqG/oErPBFxJVqascb6JvSXMcw27STYiMDU/HzhlUgJDm7in
	 YMX80dts1NFk+LiU5VXX4IlV8fS3ILYrhQXQdByFKSBrA2hq3CWxe7BfvlS3A9FAoW
	 LphHVLKa/86rQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux4kK-00000008VrG-16pl;
	Fri, 12 Sep 2025 16:27:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 0/3] Drop another script used during doc builds
Date: Fri, 12 Sep 2025 16:27:19 +0200
Message-ID: <cover.1757685692.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

Heh, with all those scripts and hacks that were accumulated with time
for docs makefile, placing them there with absolutely no documentation,
I ended missing scripts/check-variable-fonts.sh.

I only realized today when searching for the "|| exit" hack we added
in 2017 to fix an issue where make pdfdocs were always returning
errors (again, not documented).

This series comes after(*):

    https://lore.kernel.org/linux-doc/cover.1757677427.git.mchehab+huawei@kernel.org/T/#t

(*) I should probably have named such series as:
    "Move the trick-or-treat build hacks accumulated over time into a single place and document them."

This specific script is called only when PDF build fails. Re-add
it at sphinx-build-wrapper logic. After it, problematic PDF
builds will warn again about possible issues with CJK variable
fonts:

	$ make SPHINXDIRS=translations pdfdocs

	Summary
	=======
	translations: FAILED

	=============================================================================
	XeTeX is confused by "variable font" files listed below:
	    /usr/share/fonts/google-noto-sans-cjk-vf-fonts/NotoSansCJK-VF.ttc
	    /usr/share/fonts/google-noto-sans-mono-cjk-vf-fonts/NotoSansMonoCJK-VF.ttc
	    /usr/share/fonts/google-noto-serif-cjk-vf-fonts/NotoSerifCJK-VF.ttc

	For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
	Or, CJK pages can be skipped by uninstalling texlive-xecjk.

	For more info on denylisting, other options, and variable font, see header
	comments of tools/docs/lib/latex_fonts.py.
	=============================================================================
	PDF build failed: not all PDF files were created.
	make[2]: *** [Documentation/Makefile:58: pdfdocs] Error 1
	make[1]: *** [/new_devel/docs/Makefile:1806: pdfdocs] Error 2
	make: *** [Makefile:248: __sub-make] Error 2

The output message is identical, except that it now uses __file__ to get the
actual location of the verify code (which is now part of a docs lib).

All comments from the original code were preserved, but I opted to use
python docstring to store it. This way, we may even add something like
print(__doc__) in the future, if needed.

I also opted to preserve a command-line interface, which does nothing but
call the check function:

	$ ./tools/docs/check-variable-fonts.py
	=============================================================================
	XeTeX is confused by "variable font" files listed below:
	    /usr/share/fonts/google-noto-sans-cjk-vf-fonts/NotoSansCJK-VF.ttc
	    /usr/share/fonts/google-noto-sans-mono-cjk-vf-fonts/NotoSansMonoCJK-VF.ttc
	    /usr/share/fonts/google-noto-serif-cjk-vf-fonts/NotoSerifCJK-VF.ttc

	For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
	Or, CJK pages can be skipped by uninstalling texlive-xecjk.

	For more info on denylisting, other options, and variable font, see header
	comments of tools/docs/lib/latex_fonts.py.
	=============================================================================

I opted to place it into a class, as we can one day add more functions there,
for instance to create the proposed XML file under ~/deny-vc, as the script's
documentation proposes.

By using a class, we only need to import the class: all functions from
such class are automatically imported altogether. Plus, we don't have to
deal with namespaces for a function called "check()".

Mauro Carvalho Chehab (3):
  scripts/check-variable-fonts.sh: convert to Python
  scripts: check-variable-fonts.py: split into a lib and an exec file
  tools/docs: sphinx-build-wrapper: warn about broken PDF fonts

 MAINTAINERS                        |   1 -
 scripts/check-variable-fonts.sh    | 115 --------------------
 tools/docs/check-variable-fonts.py |  23 ++++
 tools/docs/lib/latex_fonts.py      | 162 +++++++++++++++++++++++++++++
 tools/docs/sphinx-build-wrapper    |   9 +-
 5 files changed, 192 insertions(+), 118 deletions(-)
 delete mode 100755 scripts/check-variable-fonts.sh
 create mode 100755 tools/docs/check-variable-fonts.py
 create mode 100755 tools/docs/lib/latex_fonts.py

-- 
2.50.1


