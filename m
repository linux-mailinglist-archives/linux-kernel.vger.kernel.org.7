Return-Path: <linux-kernel+bounces-855149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D4CBE0663
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC30C4FB875
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338373081B7;
	Wed, 15 Oct 2025 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WCSXpa36"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A952304BD6;
	Wed, 15 Oct 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556368; cv=none; b=PaU8Me96YLJcgxbc8PZ++0VcNDzC/CZpcP5fGnqhXLh2elpCM8XLvgMGcmq80rAAcF8Kg5SymxnXWBQxD6xHa8vXZp1CeJrL8Xi2ynVF2vmsuOA8Mt82fhk1+jt4liwXitFiKjsoSx+yTOy6FBjAPcHNeN066q6Gnjtlo+VC24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556368; c=relaxed/simple;
	bh=fETUiz7TJE4QlLr/4kBIH3KDC4K3UN4mzM686RjMqQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SfdvaQCT++S1CoYN94ksfIKa39gRC1+hZzIA2CDPnQWYudc9/HyZd2w0AvTAPBPVkJ6NsCFciBT5metISy1ElZxc5pcDN+d5mR/bvFAsCHZYdZiFsKmtoKrd1XZaPcBVdNWCghVb73olukIaaYdGUnicdM2eeVOIz2FNEGf2qgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WCSXpa36; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760556362; x=1761161162; i=w_armin@gmx.de;
	bh=lrCozfUsgd7HM5+pnas8zeI96y6okDDlnzSbmtRLh5U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WCSXpa36L8h+4MRvP+FjbwJrSsDZYRfemBvcwBb5R7ZisaPoWkFM0iM1kTrOPU03
	 und4A/kO+IZl3XNtYU/C+il4Y/Dm09NlT7EoSJAftCfmQ6arvaFxomFEltD3TZBaF
	 s1jhQyRyFlJEu4DyVOeXwvEpFTMXPZzdp9A7ImmIO7t6UoSCwfvpY8OOwx3qsoC2R
	 PAKRRT6fqxHPvkfyl6gb5UqQlg0BH9YnZfNQby6kKgSkNs6eKTABMJnTNSypFUksw
	 kCx+uS8nmUkTIJsHsUUmi/TUBgS55r8Rr0ju29Czgkz6JEiJBwyn4yum+1g7KMZCI
	 0JTa8htgY10kZuGNAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MnaoZ-1uPZ7P0BEL-00o7Bi; Wed, 15 Oct 2025 21:26:02 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	faiz.faadhillah@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] platform/x86: acer-wmi: Add fan control support
Date: Wed, 15 Oct 2025 21:25:47 +0200
Message-Id: <20251015192551.321200-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WD4MjaQ2a9b3GwGsOwK27V38DBx3R7ygVMyKv9zRRLW8ituDxbj
 Lr9+lgtBFcbAyqsq9jBI9yWQ73E9M9p2sCrMl5Iu+snX9glhATjWsYfDCEws2Q8XgivF8O3
 pJohd538HUe1PTkSvtdcfxjqYOtzYTp6u32QN2wemJ1ntVtege7bVT+efCnEQ/KzbbblOJ5
 rECShNWCiNB2x9YRJDi0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MxxBiq1Afkk=;FxvhmEdtefJN+/rXpkptLwwA8DM
 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

This patch series aims to add fan control support to the acer-wmi
driver. The patches are compile-tested only and need to be tested
on real hardware to verify that they actually work.

I CCed three users who requested support for this feature. I would be
very happy if one of you could test those patches and report back.

Changes since v2:
- get rid of nested bit masks

Changes since v1:
- remove unnecessary blank line

Changes since RFC v2:
- improve error handling when setting fan behavior
- Add Reviewed-by tags
- whitelist PHN16-72

Changes since RFC v1:
- remove duplicate include and replace hwmon_pwm_mode with
  hwmon_pwm_enable in second patch

Armin Wolf (4):
  platform/x86: acer-wmi: Fix setting of fan behavior
  platform/x86: acer-wmi: Add fan control support
  platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
  platform/x86: acer-wmi: Add support for PHN16-72

 drivers/platform/x86/acer-wmi.c | 292 +++++++++++++++++++++++++++++---
 1 file changed, 269 insertions(+), 23 deletions(-)

=2D-=20
2.39.5


