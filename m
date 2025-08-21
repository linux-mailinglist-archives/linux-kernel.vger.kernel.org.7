Return-Path: <linux-kernel+bounces-779266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C1B2F16D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5582AA4780
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712592ECD17;
	Thu, 21 Aug 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzqVNAzw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DEB2EB5C8;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764224; cv=none; b=jY8ss2TDDFLGTuUpHPTknCYKLTX/1o3vHlE6IMDqCX6M3L6lzeVsKphL6AueUpBAF9No04GbVBU5iqtPn3vrj9PfUf9BEzyBTSRYtOIePtRyR+LogEap8UdxMxAj3MZba3l419A5xdYDmIY+y+VuRmpR0px234QUig1n9opAqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764224; c=relaxed/simple;
	bh=7SndwlVAORMkK7k0a/gvSMQNE5mjIwPthu9bKP5Mrso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWrBpTuJLNi6BwcbWP5Ko5JAUfiw2qgqoVamnCW0hpZ5e+4ah7NA7du9Z2jiZ0L/PmxNosZPQQwqU+qAHMMpGfUU4WN/A14wVSSjnVQfplva4ZSoxmK0+7S6JWqbXrqKLw7FprtsKr2eAhr90xzt3CPERQdxHlRhGSY38WVG2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzqVNAzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D82C113CF;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=7SndwlVAORMkK7k0a/gvSMQNE5mjIwPthu9bKP5Mrso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzqVNAzwy+aRE154ZUX8u8PjCB5ANN18wqn882Mpa6XV1eBH6oGh6BB84VjXpdrT8
	 6gYGbF+n4voI0e0h9eEyG7SY9k+ARMYjHSyNUc8HkKdfy8/UcKJl6mYU3m/uSVQ0i4
	 0SX691xRuM0rW4EhzkDQweywtn5SN3gsMqhYrtbMiKTonz/t5zyTrRPhbxBj2ounVm
	 BVsVLSVVbh6fZdByK4YqN7MWX6Hd3WDDcKuCeyCtqAE7Q1TMDtKLvBNL2cwTaNX8Na
	 sZIU6h/AN/fI/OK/g9Jmb+8bS2SUpL9L9ur4aooWLxVQGIFWNG2/UZrnlJ+eRqGP1S
	 NLQz2S1K9EM5A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLg5-2Pub;
	Thu, 21 Aug 2025 10:17:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] docs: Makefile: Fix LaTeX paper size settings
Date: Thu, 21 Aug 2025 10:16:37 +0200
Message-ID: <c50db42ead36010fd42ce1e6a2b9da766c11927b.1755763127.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755763127.git.mchehab+huawei@kernel.org>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

According with:
	https://www.sphinx-doc.org/en/master/latex.html

The variable that handles paper size changed during version 1.5,
as pointed at:
	https://www.sphinx-doc.org/en/master/changes/1.5.html

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 820f07e0afe6..2ed334971acd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -60,8 +60,8 @@ ifeq ($(HAVE_LATEXMK),1)
 endif #HAVE_LATEXMK
 
 # Internal variables.
-PAPEROPT_a4     = -D latex_paper_size=a4
-PAPEROPT_letter = -D latex_paper_size=letter
+PAPEROPT_a4     = -D latex_elements.papersize=a4paper
+PAPEROPT_letter = -D latex_elements.papersize=letterpaper
 ALLSPHINXOPTS   = -D kerneldoc_srctree=$(srctree) -D kerneldoc_bin=$(KERNELDOC)
 ALLSPHINXOPTS   += $(PAPEROPT_$(PAPER)) $(SPHINXOPTS)
 ifneq ($(wildcard $(srctree)/.config),)
-- 
2.50.1


