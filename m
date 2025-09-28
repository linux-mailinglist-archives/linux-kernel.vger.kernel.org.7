Return-Path: <linux-kernel+bounces-835337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2772BA6CA4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BA218853BE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A102BEFF0;
	Sun, 28 Sep 2025 09:01:33 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD52D0267
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759050093; cv=none; b=UiS1yUeNmQ/F9yds/2CF0jsFcTn+ApNAGbVQD84JhjEfkaoALv7nfwmqaXJ8ajWyNhfdqL6mKr/J49lxF4wIZblNgXt6sAZxVVOs2210ckr7MEAaFoSAsevxkiO8gBdKx6wleOrBVh9eay1XC8uCPs3Wt1Y0BFrrEP5luHFyPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759050093; c=relaxed/simple;
	bh=ecPw8zNL+n+k+FMd1IZSgqevUdkxpUKcJBiCN+M/vlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsQIfQRyDUNnaq3hT5n9noi/yJDBuqeskoNY/QuYmU8vcDPodqIOd77w+X5l5lZpN1Kk4/Quz5ajfkV0lW1B0q+CQLC8NKuoKehqLnVcqMu09j2dCZ0hlD3Df9ZCuSSYRSoSv2X3OSzK5lDiN/FDorDDUrYjN+4VLC8SN1CrhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b565383e9c4911f08b9f7d2eb6caa7cf-20250928
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6fcacf06-c994-44eb-8f48-428af6de175c,IP:0,U
	RL:0,TC:0,Content:22,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:47
X-CID-META: VersionHash:6493067,CLOUDID:f2b2493ad5f001821c876600443eafe6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|850,TC:nil,Content:4|50,EDM
	:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b565383e9c4911f08b9f7d2eb6caa7cf-20250928
X-User: liqiang01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 581257618; Sun, 28 Sep 2025 17:01:23 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: will@kernel.org
Cc: catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add unlikely hint to MTE async fault check in el0_svc_common
Date: Sun, 28 Sep 2025 17:01:21 +0800
Message-Id: <20250928090121.3068976-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aNEsDswLSpBkf-5S@willie-the-truck>
References: <aNEsDswLSpBkf-5S@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Does this result in a measurable performance difference?
> Will

Hi,

I did not observe a measurable performance difference in micro-benchmarks 
(e.g. syscall latency tests), since asynchronous MTE faults are extremely 
rare and the branch is almost never taken.

However, `el0_svc_common()` is a very hot path. Without the `unlikely()` 
hint, the compiler may not optimize for the common case, and after an 
I-cache eviction or branch predictor state reset the fault check can 
be mispredicted. Marking it as `unlikely()` makes the fast path layout 
clearer and reduces the chance of branch misprediction in cold-start 
situations, consistent with how other rare-condition checks are annotated.

Thanks,
Li Qiang

