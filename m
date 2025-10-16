Return-Path: <linux-kernel+bounces-856752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA718BE4F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A733A5FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363CD2253E4;
	Thu, 16 Oct 2025 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="auVJZltH"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9C86344;
	Thu, 16 Oct 2025 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637623; cv=none; b=JT2pk95s2dbHpsR6ovPpZAsUwJx3HtvVfutJECTSvIqu4GAqtpU60W5MpDoKMguqjx0olSipgcN3EWmGthLCh6LcsIKZq0ybBkahI+V7P4D78/gkYTXNumgWwBEvB2n3UHNvniFb4LdhLvQjqEMVvgHPe5yOHxxC4EplevmbDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637623; c=relaxed/simple;
	bh=Jd4fck9DHZHCYPAX3Irerlz3poHD7Ra+aOENfUGuPSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZMNXKNZdA2+Ivr05sGIpVRAyhFhEVVWmPQkVBDd7FBOrokLO/RQSJF2n89eH/zq9IJkQcw7YaV4NIihyZX+/FQvo5mhSuHz+mV/8bg4iGMOpsZGgXUyB71z37mJW1EnJ3NmwdlrWstFpjWbmpFw1BuknxcVEDXA6K1OsBz8fzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=auVJZltH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760637614; x=1761242414; i=w_armin@gmx.de;
	bh=XdFB9hr1/DH/n+3LmnrrArS2CHzYfUxejE6e5v7RKKs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=auVJZltH4Q4DVyGsqqke4qAch1+Dsq8pk2N/IZoFAU057yVE+cJZLE4EFlSqYWAX
	 mzdY0NJexz/f2i17mhKzry8k6YuPS3EWCBjF5kfYl4DjRZhWiadtI/f7CBjEdPII8
	 B3s4buUXOAmk2DvOII0PjZ7xIlut9K4OeBfXmByvz/IzRMVvTjV71WrGMgq4ZyMsR
	 f+haTDVdhuQyyJZV74qvXAUXxZjIY/V4c9yU4b+PEgMwf2GmBXi+MeQQueqXWIrZ5
	 b5CZsFuIX8fSrCt8wwd1C9w74+OaSW/52f3/aVk/HBEzAu0445YCdvT8iMXdjjl3D
	 yyo0WOG9HQiKeOOTiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MGQnP-1uzF7j1As9-00Ct9i; Thu, 16 Oct 2025 20:00:14 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	faiz.faadhillah@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] platform/x86: acer-wmi: Add fan control support
Date: Thu, 16 Oct 2025 20:00:04 +0200
Message-Id: <20251016180008.465593-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cQCiri/fyxY41xPE+9aGjZhJblCbsG37Nzt7uPa8fNdBxxhPeqd
 cZEIAQfZLXtv+clJx46O8e4pJjv6LqY95/44K7bdyXxn870MQOnTyYHFPvny9w7DGrC9TH4
 tSQwFVMf0SJj4+Ejz1MXIEbrLPbkk5w5IUK5Ep6iDTpIHFkLRnF+WGGC31PBsbY+c3HbL+4
 LCQuBbz7NBuLISloPmS8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9MokXHKA4l0=;KZPaYXOlWmbWZZVwjDaKZTqQRD6
 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

This patch series aims to add fan control support to the acer-wmi
driver. The patches are compile-tested only and need to be tested
on real hardware to verify that they actually work.

I CCed three users who requested support for this feature. I would be
very happy if one of you could test those patches and report back.

Changes since v3:
- fix error in WMID_gaming_set_fan_behavior()

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


