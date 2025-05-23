Return-Path: <linux-kernel+bounces-660213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C53DAC1A28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 04:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B91507FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 02:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA91F9EC0;
	Fri, 23 May 2025 02:36:58 +0000 (UTC)
Received: from smtp134-102.sina.com.cn (smtp134-102.sina.com.cn [180.149.134.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396818E1A
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747967817; cv=none; b=uLsUgv3/27Ap+AN+ctrHQnB0HHeLkMFdu0hvXCGlGrZYjS42r8DQK+erMaffidyxJ7yxzzz4DopyMvUTfGDwzGTDyQTcCFHOtKetTBEQIihAyf3cYSVwrti5Owfexpk9Bgm1OcZ+TvCclyBZ926L8wKyc/60Qp7m80hGbHZuyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747967817; c=relaxed/simple;
	bh=zun1QY8q1fAVtur2VQ7pww2aQwPnElLNn6ZMshj/Nnc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ofu8+zDmPFZ+rfUOz6g4mDdT2vTWYK+8duQL/ypaJnNBMKHVJqUc4A9ff0p3lFgWMSQKjd6zBbwpeg+86J7PK/TkV/13xYi9yIcJjB05lGTXQRGAG/3+Nr4vERlXmIBayKl6yQAT0RaWt2IWE8pq88+UcT9MrItiY0lJXe6+fDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com; spf=pass smtp.mailfrom=everest-semi.com; arc=none smtp.client-ip=180.149.134.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everest-semi.com
Received: from unknown (HELO zy-virtual-machine.localdomain)([180.172.39.205])
	by sina.net (10.185.250.32) with ESMTP
	id 682FDF42000051ED; Fri, 23 May 2025 10:36:51 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 2C340DD7119046EDBCC7EA177B04D1E5
X-SMAIL-UIID: 2C340DD7119046EDBCC7EA177B04D1E5-20250523-103651
From: Zhang Yi <zhangyi@everest-semi.com>
To: krzk@kernel.org
Cc: robh@kernel.org,
	tiwai@suse.com,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	krzk+dt@kernel.org,
	amadeuszx.slawinski@linux.intel.com,
	broonie@kernel.org
Subject: RE: [PATCH v1 0/2] ASoC: codecs: add support for ES8375
Date: Fri, 23 May 2025 10:36:47 +0800
Message-Id: <20250523023649.22785-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> > The driver is for codec ES8375 of everest-semi.
> > 
> > v1 -> v0:
> >           - Add the description of everest,mclk-src in the yaml file
> 
> Version your patches correctly - that's v2. Or just start using b4.

ok, I'll change it to v3 for the next version

