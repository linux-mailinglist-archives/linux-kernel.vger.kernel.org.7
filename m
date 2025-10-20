Return-Path: <linux-kernel+bounces-861616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF8FBF3319
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53F794FAAF3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2BC2F744C;
	Mon, 20 Oct 2025 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="m4NdjQiG"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C61EDA0B;
	Mon, 20 Oct 2025 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988305; cv=pass; b=j9HWFkAxydPpni5B736hs6pogA6cwNWroS/g4ofJcnJ7hMQJZODpXocpKKsc8kF2Re9vGoXeqkrKNVM8LVyZYWnA2EejMofwSyOhvIvBAdBaBG62zoT1rNg/3q4alvkdleEc/05JoTn15wjVt8N7eRGHypYsokJ22dFvRVd9uNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988305; c=relaxed/simple;
	bh=JL6P2OUeA0wVL21G1YNmzHNInrbon4lvr0o1FthYplQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krWHlDEowKkl2/TAkqA1uZnmb/ahAgUgMwEjBlxKJPXLGHPTYLKhdU40chY+5xlYTvRTWI7+IHSpeC5zaiQYmKxnlwgIIh35c04RgU0srAn2+alBqkpr7CvP1wEn8+O8u/yooRypD+s5m7f2Spy5WQV9ZFys8JITFuOV14mpwjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=m4NdjQiG; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1760988294; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WIHw5MeewAnSwXbZ3xN28bJQFUMJGppZ0D/+Dszcq7uBZki2lIGS1fiQ9uh3L/l9I1BfpZ7uKVow9rxClYOdJ1HwpyreQac877RcaPInIPSTt6srKpbZI2jHM6P17LIdcFcMH3dOvnmcc4GvQrqb1TCkFLfFe2WesUbiTvETkaU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760988294; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E66WXO2Y6Lu1SCm9+0FlDF/DzLuHhC1qHX377lLHLXU=; 
	b=XRT5konqgxfipvafo1KWxQV1+eF4UuUNQ40EmcdtcOK6HncYSi7x0w5Zif+LHLOLR54HHRzFFGxHkejbQBwyjybvpzfXQ6xTCJ9Q+FnJMnUAYE08dU6xA2DvqorXbnPRBXPodvetEYuWckGQEofzkUYhPK3GBeq4015ZNDafYyE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760988294;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=E66WXO2Y6Lu1SCm9+0FlDF/DzLuHhC1qHX377lLHLXU=;
	b=m4NdjQiGz/JR0QlXXYg6WZ8ECiaMF3bivzFynsgfiwdGZ+l72ET3tcuGrhg46FL9
	ZT55duaLjRTmwLurxz5ngShYrvNOouM8sK4c6oY44IyBQYjqK7RTjSluVJUhDw2Umjt
	62l6CG+Stp8nqhtDYWSF2uGNmrMQYL8NykFSTfuc=
Received: by mx.zohomail.com with SMTPS id 1760988290911772.040342745396;
	Mon, 20 Oct 2025 12:24:50 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] platform/x86: ideapad-laptop: Add charge_types:Fast (Rapid Charge)
Date: Tue, 21 Oct 2025 03:24:32 +0800
Message-ID: <20251020192443.33088-1-i@rong.moe>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The GBMD/SBMC interface on IdeaPad/ThinkBook supports Rapid Charge mode
(charge_types: Fast) in addition to Conservation Mode (charge_types:
Long_Life).

This patchset exposes these two modes while carefully maintaining their
mutually exclusive state, which aligns with the behavior of manufacturer
utilities on Windows.

Tested on ThinkBook 14 G7+ ASP.

Rong Zhang (2):
  platform/x86: ideapad-laptop: Protect GBMD/SBMC calls with mutex
  platform/x86: ideapad-laptop: Add charge_types [Fast] (Rapid Charge)

 drivers/platform/x86/lenovo/ideapad-laptop.c | 144 ++++++++++++++-----
 1 file changed, 108 insertions(+), 36 deletions(-)


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.51.0


