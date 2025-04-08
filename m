Return-Path: <linux-kernel+bounces-594028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F847A80C2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 15:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E276C1BC6A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227E13AD38;
	Tue,  8 Apr 2025 13:22:08 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC73288D6;
	Tue,  8 Apr 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118527; cv=none; b=JH1F7weZvsOXlMyjR70ntSIe5brG3nANUeXwPJB41gvsfA4He/X/mhAaRXqpA+thHs5UlRbxv4D2JxxlHPfkzD6R5w+e+CI6vD/I8sQyiod/MeFgbVQcj74FSR6T75y6PnooraQupJ4tEvmwLWEjOPXcMw+sgs0C9o48yqKQ18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118527; c=relaxed/simple;
	bh=etWs6aCDo7E7JhUAsTiPQeU2J8BLZjBokKe7QYKQPg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tkOB9chwudb8QTonU4m9X5+oE4uDTz0p1PJwUz2JI1V81ZGxLMnABYpplsQvV/WYuCwXarSSqzjkwgpAwGP/QiI3ZxmaaJ2JDmN9Ef/fXAlZGIC0qzE320qTvlgdPOIyELhIk6Ctkdc5Tpu58HXEAIq13QihbIyYEaoscdqsu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.. (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id D2CFF20CE9;
	Tue, 08 Apr 2025 15:22:02 +0200 (CEST)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 0/1] media: mgb4: Enumerate only the available timings
Date: Tue,  8 Apr 2025 15:21:54 +0200
Message-ID: <20250408132155.2175-1-tumic@gpxsee.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Enumerate only the available (as given by the input source) timings, not
all theoretically possible. The "complete" set is misleading for
the user/user SW (including qv4l).

Changes in v2:
- Removed the vidioc_s_dv_timings part. It turned out doing a query/exact
match check in the set operation is not a good idea as the returned query
value is unstable (and the query/set combo done by the user may fail).

Martin Tůma (1):
  media: mgb4: Enumerate only the available timings

 drivers/media/pci/mgb4/mgb4_vin.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.48.1


