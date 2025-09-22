Return-Path: <linux-kernel+bounces-827186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A812B91161
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAD27A91B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8001B2FE561;
	Mon, 22 Sep 2025 12:18:03 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640617082F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543483; cv=none; b=KboJu+Ee6/mklqCiLQCpMnz5Bv+8qeMSirXU+iMeltF7gK356x1qwhRkI83bXyUJ2WsjCpm0vvIM6trLjLNlgM1CGTOXww9KkXeUiX0nR9pRCGnm9uNQR2gO3U7WcLWY9Zz/Hcf5YZpxU89JWC+fogSd9POjmsvERfkUXd1x8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543483; c=relaxed/simple;
	bh=XB+nvJd7kpPnGIf/ybciiOSmoyAe+o7RdndRV1ON4zA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXHHseiXdXhvY4Jq4TX/gV9Xv0SBU9zRQUI4Z3tQ4Bif51ABHyu2BoKx7qAlXk8R1bfb/oU5uvUz2UignYbYS65C/Fnu1txT8z8IapcyjcJlVOZZdSFyXhAv3gdjUr1BOWyHv3gpIwyHQdv4eDgT23vuLkxxGThbq/8NKxpoAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 293a636a97ae11f08b9f7d2eb6caa7cf-20250922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:820a0db1-d8aa-4ccd-a29a-d5a8403565fe,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-INFO: VERSION:1.1.45,REQID:820a0db1-d8aa-4ccd-a29a-d5a8403565fe,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:a01a001bb6b5825328af111a4ef35bfd,BulkI
	D:250922201752257MKIUF,BulkQuantity:0,Recheck:0,SF:10|24|38|44|64|66|78|80
	|81|82|83|102|841|850,TC:nil,Content:-10|0|50,EDM:-3,IP:-2,URL:0,File:nil,
	RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|UOG
X-CID-BAS: 1,FCT|UOG,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-UUID: 293a636a97ae11f08b9f7d2eb6caa7cf-20250922
X-User: pengcan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1686138324; Mon, 22 Sep 2025 20:17:52 +0800
From: Can Peng <pengcan@kylinos.cn>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm/syscalls: mark syscall invocation as
Date: Mon, 22 Sep 2025 20:17:30 +0800
Message-Id: <20250922121730.986761-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aM1BSZV43DB_l5OU@willie-the-truck>
References: <aM1BSZV43DB_l5OU@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

>> The invoke_syscall() function is overwhelmingly called for
>> valid system call entries. Annotate the main path with likely()
>> to help the compiler generate better branch prediction hints,
>> reducing CPU pipeline stalls due to mispredictions.
>> 
>> This is a micro-optimization targeting syscall-heavy workloads.
>
>Does it actually make a measurable difference?

This change implements a micro-optimization. Benchmark results
from the Kunpeng 920 machine are as follows:

before:
- lat_syscall result 
write call      0.2332  0.2337  0.2341
read call       0.2501  0.2493  0.2506

after:
- lat_syscall result
write call      0.2301  0.2316  0.2307
read call       0.2492  0.2498  0.2491


Best regards,
Can Peng

