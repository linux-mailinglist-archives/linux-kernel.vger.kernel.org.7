Return-Path: <linux-kernel+bounces-699454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD4AE5A52
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 05:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A831B6576F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 03:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3821A0730;
	Tue, 24 Jun 2025 03:01:48 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41117D7;
	Tue, 24 Jun 2025 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734107; cv=none; b=jOfiVeusqzbW7ZVvzQh5ongk/FIrHsScRJERly7o4u/MglxQaF9QPYt2iqgiemZTPIPNBCH09DYOrBRojEiadgT89AuTuQb+6MDa01QiZ4S1yqN3hMFwBXc5XmrQ2Gtjcx+xUSfleJdCeQ3CW6TSN8glCkHRqRTCCgzFKb/mgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734107; c=relaxed/simple;
	bh=MsA08rbTxeFhJz/WzNmdbbmzaVE+0kJASkfsGnUl/UI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiW2fU1UIBTiQ49MMYRl5qde36yF6lf3YbMmrp9CbsOtxcHhoFFpQQ2sSBXmmF6eOloC7GPW2cgvIbpso9APU0eDVNR9TCnuVCGy3xFxlgs5iJjpNEg8ou/E6JKZwGYbJAuiDUB9/Y2R/GL2TAf4whDEgVajnfHEE3W7UG7CRf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202506241100305413;
        Tue, 24 Jun 2025 11:00:30 +0800
Received: from localhost.localdomain.com (10.94.6.249) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 24 Jun 2025 11:00:29 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>
Subject: Re: Re: [PATCH 1/1] check the ioremap return value first (supplementary CC)
Date: Tue, 24 Jun 2025 10:58:52 +0800
Message-ID: <20250624025915.1692-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <3bf6df3b-affe-4f10-8b05-29f3393d19e0@intel.com>
References: <3bf6df3b-affe-4f10-8b05-29f3393d19e0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025624110031415c3819e8b85ca5c6989f831ba4e68d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

First of all, thank you for your reply. Yes, this patch doesn't change anything substantial. It's merely for demonstrating good programming practices, so you can decide whether to apply it or not.

