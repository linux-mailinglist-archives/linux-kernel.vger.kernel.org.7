Return-Path: <linux-kernel+bounces-807338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809B3B4A32B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E91A4E66DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688F306484;
	Tue,  9 Sep 2025 07:13:11 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB246305963
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401990; cv=none; b=izWByVbHjUIwGhi+Ngcwu2jIl04B+LUENm0gNxeUJQt1ih2leZ6rBhb7bzSRIkT26E9uiXzcHEEPV38wlOrPvunfOyYJNIBAaR6yS3eFlkFHDoANkupF2aCbVcMkgPiJzd2hn+WuncZL2nscLmA/dFYi7qOufbYyqufXD1aWln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401990; c=relaxed/simple;
	bh=wzRmohWMQS8lZNVUyISpFRgxEDiC6wOvuY4pdv7ChzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtxgWI2gzU5ePMR+uLahFRt5yqn3ckbIR3R+BW5tmgUVWhFc+8gX/WMdZ1yR1rsJnyOKYXnRxjYfL+iPYW1JXE+6swwcr1onWwCROiRYXDnqHuYdQBvSgEaSq2NkE7zE/e2ItEwT5UkkvW86DfxmZOHC+rSN2sdZfARyuZ2VLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6b0db5248d4c11f0b29709d653e92f7d-20250909
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a8cd9b58-5dbd-4ac7-8008-e9a1ef6a92a4,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:36
X-CID-INFO: VERSION:1.1.45,REQID:a8cd9b58-5dbd-4ac7-8008-e9a1ef6a92a4,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:36
X-CID-META: VersionHash:6493067,CLOUDID:246c3a288db9c8159d9b628c98210061,BulkI
	D:25090911133983AG3DV0,BulkQuantity:1,Recheck:0,SF:19|24|43|66|72|74|78|81
	|82|83|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6b0db5248d4c11f0b29709d653e92f7d-20250909
X-User: cuitao@kylinos.cn
Received: from ctao-ubuntu.. [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1509563055; Tue, 09 Sep 2025 15:13:00 +0800
From: cuitao <cuitao@kylinos.cn>
To: chenhuacai@kernel.org
Cc: cuitao@kylinos.cn,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH] LoongArch: Added detection of return values of some steps in the system init process
Date: Tue,  9 Sep 2025 15:12:36 +0800
Message-ID: <20250909071236.1845637-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAAhV-H7ECnVeOgf93SEXLHLc4wvhQMjQXDbGKCR-KXKWf8Vgtg@mail.gmail.com>
References: <CAAhV-H7ECnVeOgf93SEXLHLc4wvhQMjQXDbGKCR-KXKWf8Vgtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your review. 
Sorry for any inconvenience caused to you, and I will study this part of the process carefully. 
By referring to the code of other architectures, 
I think the check for kobj creation in boardinfo_init can be retained.

