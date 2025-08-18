Return-Path: <linux-kernel+bounces-772709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D864B29662
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E47F1962D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3424A233704;
	Mon, 18 Aug 2025 01:53:13 +0000 (UTC)
Received: from mail78-50.sinamail.sina.com.cn (mail78-50.sinamail.sina.com.cn [219.142.78.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189522D7B0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755481992; cv=none; b=IP4j56g6ecaMHzG55T9j1wVoqz3M13IqxKcdU4s9lKQogHq1MFIvISEjX4/VFJflhQ3w8F6LsyJsaipwr2946UXm1VPJnJHtNm0ra3fLUH1Q0Pl4UTwK84SSSd60vC7mLa18fRZc9U/Ssx9zAzTtWwnVlJLj1ju+booaI7Urd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755481992; c=relaxed/simple;
	bh=dOpMsWyD+xgBXRLdesy7FDW3THzxxzGpJ6oI3+RNelM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BgxtDPe9PlULFh9T9pBqi2kkuJaGp4aYta4xv/EzZ3TA4l4Vh6A1PqXx/xkpsfSWb/fknh738X/cJAWxPmhOVHksoLOUSpvn5XEosj/T4c9Ph5YWssKjouguqXAuGmddJvsETUWfpk4kvLwWSiYuzoijSgREh9CRJsCKkjLvl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com; spf=pass smtp.mailfrom=everest-semi.com; arc=none smtp.client-ip=219.142.78.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everest-semi.com
Received: from unknown (HELO zy-virtual-machine.localdomain)([180.154.41.66])
	by sina.net (10.185.250.30) with ESMTP
	id 68A286F000005FF3; Mon, 18 Aug 2025 09:50:41 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 039FF8A482114002AF9C2621D5CA46BE
X-SMAIL-UIID: 039FF8A482114002AF9C2621D5CA46BE-20250818-095041
From: Zhang Yi <zhangyi@everest-semi.com>
To: broonie@kernel.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: RE: [PATCH] ASoC: codecs: ES9389: Modify the standby configuration
Date: Mon, 18 Aug 2025 09:50:39 +0800
Message-Id: <20250818015039.2915-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Why?  Is this a fix?  You're just changing one magic number for another here...

I apologize for not providing an explanation. 
Because the old configuration caused the I2C address to change when standby was entered,
I modified the configuration.

