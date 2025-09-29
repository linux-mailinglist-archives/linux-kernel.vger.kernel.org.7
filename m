Return-Path: <linux-kernel+bounces-835968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8016CBA8785
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14BD57A5537
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5792C029F;
	Mon, 29 Sep 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0p5708C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351927E1A1;
	Mon, 29 Sep 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136047; cv=none; b=kJCv3kFQnnkE22R3VUG8c3j8B/q1JB4sq7xc6BOLmYHDM2qQO7WWcLzjh0iaqs54N0UyIGeMevRu/w6h0zGzxD4buEuKwKSQHyFIqj9g34sh1hhpTIe7W5F4/1tcWCDD6UwCtcN4VxLabBuwUFAcmagmPKh7k4Hi/CucMXzxQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136047; c=relaxed/simple;
	bh=jU9oHR8yt5admku8+N9Ddd9kQrcSpanPsh8gVFIHiGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WD4/eYYaGE++KmVvjTix9XXH7QG7vUsJleYLUtUeD1WXELwX7p1guxueBvF7NHfwi31p0cLByQPqZSp3yz53p3uB1X/DzycTjo4aVwrGyoX2udM1YpuCwRRJHlm3E3FnRl2a+HtSn4l3fOV2Ew/ZF30ZdX9hG60oPAEFOVJ7G00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0p5708C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65485C4CEF4;
	Mon, 29 Sep 2025 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759136047;
	bh=jU9oHR8yt5admku8+N9Ddd9kQrcSpanPsh8gVFIHiGE=;
	h=From:To:Cc:Subject:Date:From;
	b=X0p5708CWMaZwMOc8Zyv7Fpb6MtpuWFSPVCyoZQY7asRCO/erw9toiMbS3TGUoG00
	 RWL3XZEkPv70N5NWXp0pNJX8KA1G27Pb4/1lxXot1OQupDlTjNz+yLJAqUvUq2hRuM
	 qE+es+E3ewsq6GusPzm2YH2EqW5sLE0l7Lt1873rP4H7/ALAaHKPSgQSd/Ks09LMI7
	 MhipNd5w2xFh8XqaGvjY1wPXkBOZ/PbFfTPpHFzed4HfR4IV5vwAW0uoNIVMl+K+kY
	 Ywhgvni6I5v/5Zc5o/Itmy4zAYUMkut6UeZVVWJm8qg2VPyN6vZbF7f4GdgPkr16Br
	 sNpNKZitD5cGA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1v39e1-00000009dSC-1uUu;
	Mon, 29 Sep 2025 10:54:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] some patches against build-script
Date: Mon, 29 Sep 2025 10:53:27 +0200
Message-ID: <cover.1759135339.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

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



