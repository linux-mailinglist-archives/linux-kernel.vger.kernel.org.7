Return-Path: <linux-kernel+bounces-728556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1443B029F3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 10:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600B83A4AA6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F17425487C;
	Sat, 12 Jul 2025 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQYTMjOy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DE2AE74;
	Sat, 12 Jul 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752308034; cv=none; b=MVkEaeGZAJ1Qs360pfZGpBM4VV3HJ0pLC/KCbwuW1CLGtin2MU7ipwqBiBC+QE80Dy1ehYIpYJlvBc+ySpEaB+ezCDOnq0kxvpHAbpSRC/8AE+BEHEly/f02rRzImOqDs/29fWc3GKNLr8reo6c33fto3agm2FH+zdW58RktpDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752308034; c=relaxed/simple;
	bh=jok0fOgQSB9QMGXybSCBPoLtXOSykuYUdEN/QWeB5rE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAtUSP7ir6F67mVWok80ug+Yb4xz2eMwUP3wBdRHXVVH1jOH55TPMCzwat4J2LCAsOCYKjmvUL+8LG92Y5qFFXtt5t70B0VASa4hALbbJ25hpklOZtYfu/SRaHn6k75t8mkm6iBSaHidYDcoSGexpA1UkZPyXyBpuc7DYmFlSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQYTMjOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44311C4CEF6;
	Sat, 12 Jul 2025 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752308034;
	bh=jok0fOgQSB9QMGXybSCBPoLtXOSykuYUdEN/QWeB5rE=;
	h=From:To:Cc:Subject:Date:From;
	b=lQYTMjOy8+Fpew2BjxptAcqpoAYhc+FXLOfXKH9mzl04dCI9uLGnpcj7CGny7KYGC
	 N95qHS6u0cy3XFLBSyUvL5tChv5cHjta1SCna1a4cmlzqKzVC+MoeGwVzv5cWQcGCM
	 2q6HPfz51a3EDy+vg+vs7KFviuDI9oZ3TqflpYJZUL+op7hqV60C8FJS/SZUPpmiHl
	 32idRVGXc2m4U725iPY5tvGTQZv+PvYEclz21QvZhCg/kw5BiMrSU4IYQMEDGXKlkk
	 9d/RyS2MAJ622FpPYR5Ax6MDA2MeHzCddpEarV9qkLnIqINkEaofudsJtgob9juGnk
	 xIOJvdkvcl3CQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uaVMm-0000000GrLr-0tz8;
	Sat, 12 Jul 2025 10:13:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2 0/2] Restore kernel-doc support for prehistoric Python 
Date: Sat, 12 Jul 2025 10:13:42 +0200
Message-ID: <cover.1752307866.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

Sendind a v2 that was actually tested with versions 2.7 and 3.4.

While discussing patch v2 12/12 from your kdoc series, I realized
that kernel-doc command line should not crash with Python 3.6,
nor cause compilation breakages with older versions.

The problem mainly affect builds with CONFIG_DRM enabled, due to:

drivers/gpu/drm/Makefile:                PYTHONDONTWRITEBYTECODE=1 $(KERNELDOC) -none $(if $(CONFIG_WERROR)$(CONFIG_DRM_WERROR),-Werror) $<; \
drivers/gpu/drm/i915/Makefile:    cmd_checkdoc = PYTHONDONTWRITEBYTECODE=1 $(KERNELDOC) -none -Werror $<
include/drm/Makefile:           PYTHONDONTWRITEBYTECODE=1 $(KERNELDOC) -none $(if $(CONFIG_WERROR)$(CONFIG_DRM_WERROR),-Werror) $<; \

This small series prevent Kernel build breakages on such case,
and it is meant to be merged after your kdoc patches.

Patch 1 emits a warning wih Python 3.7 siilar to kdoc class,
but on an early stage. More importantly, it emits a warning
and exits the script for versions <= 3.6. 

We still need the kdoc warning, as it detect troubles when
calling kernel-doc as a class.

Patch 2 fix a backward-compatibility issue that otherwise
would require Python 3.9.

With that, building the Kernel with older versions won't break.

Regards,
Mauro

---

v2:
   - added a coding line to kernel-doc exec;
   - only include kdoc lib after checking version;
   - don't use f-strings at main().


Mauro Carvalho Chehab (2):
  docs: kernel-doc: emit warnings for ancient versions of Python
  scripts: kdoc: make it backward-compatible with Python 3.7

 scripts/kernel-doc.py           | 35 ++++++++++++++++++++++++++-------
 scripts/lib/kdoc/kdoc_parser.py |  4 +++-
 2 files changed, 31 insertions(+), 8 deletions(-)

-- 
2.50.0



