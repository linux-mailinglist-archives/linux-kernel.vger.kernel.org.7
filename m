Return-Path: <linux-kernel+bounces-756550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F78B1B5F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807051890643
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC7279DB4;
	Tue,  5 Aug 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="K9IgMDmz"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAD277CB1;
	Tue,  5 Aug 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402514; cv=pass; b=fTdA8tlOPVb7ryURJ826L42J2YKJuz0g4KfQed4CkS2jdb8nspznpszgph6DRkn24/oLm/2Y/Es7QCBUy9znv1EIxulWR0m6wByaTj7Je1pC/H3JtZRzTWtir/PkNTPX62VZxvqv/GoIxXAsRBZpRNbjuvEKlgDWzjd7XthdsXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402514; c=relaxed/simple;
	bh=kw7M/ecYySK+M7TXf0TvcftnX4ZgqU/pRG5ET/ZpJb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1+jTy34F2HbhcbxuaUZzL+ORQCKfAginfaNB+Xmm7F6y/8sr7LFuIwARyLZYrsf3VBeYGvhIQPWmfZAqv9Vh99GGvk5p/4fHisogvHG9yhv/qt/JUxkC8DfJdLBBJtLN8Jcu9X4Q+Wx+XvUnQWxOI4LdUjglgYDgBBvDjsYVgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=K9IgMDmz; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1754402498; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Sd0Dr5kX9OcnHZ+t8lb87VYTLeOdd3DVH5Yo/TqvYtrh8J+/jEYGUAk4txN7Fmc4NyHhjsrruJUYDnkV9fhXw8SvDSOW3IYJyZlWRG5ei1dd4KvnA8hjO7N/ei/wnIaCrBxYZB7t9gQ/nc4zMzLwfOrM5rV52/WenG8GAU5ijdE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754402498; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zIxenSvc5QRv/8tnOS9rbi/vcQ8yJDMbjw9/75c6GH0=; 
	b=GKgy5++tixvwo8AGYgDJgo9Zphm5HBSlRHUJaD/+tpwqdW3Zd8RYnisiRvUTHqWoLflS1/vVtER6F378OakA4JiBdvPxGXnrJ0v6P8ixslJt2SdzxR5Smh6DUWpgHsz2fftN0qOHSag5O5VyjPmEa3+Tq2HEnuYcNZvmhFJ2Sjw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754402498;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zIxenSvc5QRv/8tnOS9rbi/vcQ8yJDMbjw9/75c6GH0=;
	b=K9IgMDmzPi6o5Fn9RXrRweflGs0UDMbsbTQMrMAOsvN7Zpc9bwgylB2e/LSsWbPg
	+iuSbTr1XTaHa5D1G69ZPRhI480hxbojHPpCe/lUnderYJP84o1nTkLEJMa477aIpLq
	yTDDPKepJGy+lrH09IDZ8zxjyhz+8bi4O1/6WFSo=
Received: by mx.zohomail.com with SMTPS id 1754402494881164.47444048051364;
	Tue, 5 Aug 2025 07:01:34 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] platform/x86: ideapad-laptop: Fully support auto kbd backlight
Date: Tue,  5 Aug 2025 22:01:27 +0800
Message-ID: <20250805140131.284122-1-i@rong.moe>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi all,

Some recent models supported by ideapad-laptop come with an ambient
light sensor (ALS). On these models, their EC will automatically set the
keyboard backlight to an appropriate brightness when the effective "HW
brightness" is 3. The term "HW brightness" means that it cannot be
perfectly mapped to an LED classdev brightness, but the EC does use this
predefined brightness value to represent such a mode.

Currently, the auto brightness mode of keyboard backlight maps to
brightness=0 in LED classdev. The only method to switch to this mode is
by pressing the manufacturer-defined shortcut (Fn+Space). However, 0 is
a multiplexed brightness value; writing 0 simply results in the
backlight being turned off.

Fully support this mode by adding a sysfs node:
/sys/class/leds/platform::kbd_backlight/als_enabled. The name is chosen
to align with dell-laptop, which provides a similar feature.

Thanks,
Rong

Rong Zhang (2):
  platform/x86: ideapad-laptop: Decouple HW & cdev brightness for kbd
    backlight
  platform/x86: ideapad-laptop: Fully support auto kbd backlight

 .../ABI/testing/sysfs-platform-ideapad-laptop |  12 ++
 drivers/platform/x86/lenovo/ideapad-laptop.c  | 186 ++++++++++++++----
 2 files changed, 163 insertions(+), 35 deletions(-)


base-commit: 7e161a991ea71e6ec526abc8f40c6852ebe3d946
-- 
2.50.1


