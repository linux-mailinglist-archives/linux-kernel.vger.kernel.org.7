Return-Path: <linux-kernel+bounces-839029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350CFBB0AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CEC3B841A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F525487C;
	Wed,  1 Oct 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKFdCRq3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832E6BFCE;
	Wed,  1 Oct 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328136; cv=none; b=D8t6WJAKp9htn6FJOkZR1dxYeqAfGhVPv+OaxGi2JiXOWNfN9SZNoeQsKMOMAALv7jCmNzFYqLFcak+35Iy6phtz2Y6USVviOjNMHxYP+uNPnXFpBk2m5+grnWz+kzTcRSjN442jatKqKJhg2f+3P1Z//X3A88xLufW3gzWIqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328136; c=relaxed/simple;
	bh=jU9oHR8yt5admku8+N9Ddd9kQrcSpanPsh8gVFIHiGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFYKgCGCQji77CN7H6OKyJBhpcbYr3/jlDnWg1jxgwe0VNRN3cjCpH8Ut+JKrbz6V+qWp+cHZ26OqMGHUZlCC4EUu6NiiTfjwrerv0IWy1sS5ynHiApDZo55X6h09+eLRVlzzPQzPT3o8zuA5bBudkt+cQHw+p/0zFzu2w5vr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKFdCRq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD4DC4CEF1;
	Wed,  1 Oct 2025 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328136;
	bh=jU9oHR8yt5admku8+N9Ddd9kQrcSpanPsh8gVFIHiGE=;
	h=From:To:Cc:Subject:Date:From;
	b=jKFdCRq3XoN4m8NUO4rBFjaGr7bitoJReZZsmrifN/gWJwIzxPo3cNdeJqXxleAmh
	 /BXlp6sgQqpevk514xdeMVfX6zFz7hyYNJ2yreH9J9Mo0vI6RtuNre3vcaeEzdyTNL
	 UQYtD4mKNPyJVWWcIcscPWzcMA2NZKHwepAIrS+rP4Udui6sbz/HyPKlRdpdAu9ZHt
	 0i2uyb21yMdysN7hK+Sn/XkKJqLQhLxoxb7y+6zlzpxM1os2K40HIhyMixxe9In0Nj
	 NxK4b1YNt4cg8RB6Xm393JGWnRDCe3MOw9ZOoMw32GLabMWFwD8m28IxXv4kJRRMwz
	 H7lzqieOXz1Lg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v3xcE-0000000BJ9K-313E;
	Wed, 01 Oct 2025 16:15:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Some patches against build-script
Date: Wed,  1 Oct 2025 16:15:23 +0200
Message-ID: <cover.1759328070.git.mchehab+huawei@kernel.org>
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

This small patch series contain 3 minor fixes/cleanups for
sphinx-build-wrapper addressing some corner usecases.

Patch 1 was already submitted. It avoids 2 harmless warnings when
texlive is not installed.

Patch 2 fixes the checker for latexmk (PDFLATEX env) when texlive
is not installed.

Patch 3 restores the logic to store *.pyc files under builddir 
instead of sourcedir.

Mauro Carvalho Chehab (3):
  docs: Makefile: avoid a warning when using without texlive
  tools/docs: sphinx-build-wrapper: pdflatex is needed only for pdf
  docs: Makefile: use PYTHONPYCACHEPREFIX

 Documentation/Makefile          | 19 ++++++++-----------
 tools/docs/sphinx-build-wrapper |  2 +-
 2 files changed, 9 insertions(+), 12 deletions(-)

-- 
2.51.0


