Return-Path: <linux-kernel+bounces-861138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9ACBF1E16
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC5EC4E8FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004D121CC60;
	Mon, 20 Oct 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="OwXPKfMY"
Received: from mail-108-mta156.mxroute.com (mail-108-mta156.mxroute.com [136.175.108.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C7F1A0B15
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970998; cv=none; b=DDXvcTmRLJzDYDje3Qq/FJDoK1V3pUB99gbzHALrtfFctLIJ/fU7lwMTmghxfBV97D8XpH3TfdLdKjGa3RB6gsZ+AT1HR0QshWWhk5p6xuIOj5vwTIoo8mgFEqO2XBloYCzF5pLBue1rIOcos8b2c4cAr/fQIzazpZY+GEG9Occ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970998; c=relaxed/simple;
	bh=ddWJdG1P2ZlGpyrf4gCRX+zQV6lQSvd0ATTLs3MzEs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RmsXR3xNKyJhO/5LI546I0t8vVDgz6DtBKg+luuksyI9EkuZTe0X+hMOHt6qQ9mnvETXT76uIFKEwL/H64I3hzbhZm087Ue35Bn0Us5rNyjBJbVaOHHlPDUowaaxNJBEQiSYCjZTKvESQcJOwDCla+9QtBiEeDoPbRDTS+/DRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=OwXPKfMY; arc=none smtp.client-ip=136.175.108.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta156.mxroute.com (ZoneMTA) with ESMTPSA id 19a02084155000c217.00c
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 20 Oct 2025 14:31:26 +0000
X-Zone-Loop: 739e8e0ff8f200ddd65c2dce872699c3a7a8352c4183
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References; bh=KTc+h5WtHJT49QcAJjVdZ5eUjU+Wru+QolCtOi2Ys4c=; b=OwXPKfMYe4oOlU
	1LY8IVK4TQsUMai6QKcWjMnZCjuhk4Y3AihJLdGJw1MgKAG7WZbX+FPgRX2bxjXeaLjJsDbOwbrqp
	ZAH8J/wEPOTl+De0TYI2UrgYisH3WWrc7CdKW8QKWZo+3uSFxoy3OLnPyd/lt7Wd+x8O93iJGVidv
	1lsnEEGPynDgignV+YkW7+QWikHthNnWqVKDp9K78UfGuAV78DlEiacgiAjn6gzFKWm3d8FAv0GUr
	OoQ2SXO58Ex37jfZs639Wpvwa5Z0+wTKTmv85OmFRVQSdOX1iW7WK3Yb/ktjxNfGboigwpI0hPanp
	qcvLHIfdxSJcAy8N1oYg==;
From: Bo Sun <bo@mboxify.com>
To: kuba@kernel.org,
	pabeni@redhat.com
Cc: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>
Subject: [PATCH net 0/1] octeontx2-af: CGX: fix bitmap leaks
Date: Mon, 20 Oct 2025 22:31:11 +0800
Message-Id: <20251020143112.357819-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com

This patch frees the RX/TX flow-control bitmaps in cgx_lmac_exit().
The leak was introduced in commit e740003874ed ("octeontx2-af:Flow
control resource management") and should be back-ported to stable.


Bo Sun (1):
  octeontx2-af: CGX: fix bitmap leaks

 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 ++
 1 file changed, 2 insertions(+)


