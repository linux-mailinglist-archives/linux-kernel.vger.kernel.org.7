Return-Path: <linux-kernel+bounces-859669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B6BEE3D5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19DD24E53D1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377B12E4257;
	Sun, 19 Oct 2025 11:49:36 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24962E371A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760874575; cv=none; b=gx6Xai2c70LIETvtccGN3QKE4HTXNKygdWazgm4PQmkgE1CuGWctKiKEGzmayCffyuZ1zcbHnq6hfvEg7guS9XjGtvNwcOtM/qNU6Vj4/2Ni6MMBVdjgmImjFkr0q4+sBCadtY2sfFQAgP2g43u3zyKI7UQuN2OSx5MYnEivp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760874575; c=relaxed/simple;
	bh=GGcBNr6s8M3CS6C1I+6xFMK3IqOshZ8W5Co1nyYemf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrLaasIwM80UrcJBbBYau5R6aCwrnh4kaJJoPFEmMIrckaMFrvUXHgx/InWZzxMJRZbilH1jmocthIbrGoGjq9TZyAmp/Cl8tc6UBSb51BHuorjUCEaBJKtpZkR5u40svkHUDuf0AZt9CQxzFS34WpPYALKp9t+g2DPs0buumnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a6110220ace111f0a38c85956e01ac42-20251019
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_LOWREP, SRC_LOWREP, DN_TRUSTED
	SRC_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_UNTRUSTED
	SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:dc6f269d-d8e6-48e9-a2d4-9493ac5d2d19,IP:10,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:25
X-CID-INFO: VERSION:1.3.6,REQID:dc6f269d-d8e6-48e9-a2d4-9493ac5d2d19,IP:10,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:d3632cf283a6e97c63ebf86d83d88eba,BulkI
	D:2510190038440NM0JYT2,BulkQuantity:3,Recheck:0,SF:17|19|25|43|66|74|78|81
	|82|83|102|841|850,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a6110220ace111f0a38c85956e01ac42-20251019
X-User: hehuiwen@kylinos.cn
Received: from localhost.localdomain [(220.202.195.150)] by mailgw.kylinos.cn
	(envelope-from <hehuiwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1897312501; Sun, 19 Oct 2025 19:49:20 +0800
From: Huiwen He <hehuiwen@kylinos.cn>
To: markus.elfring@web.de
Cc: Liam.Howlett@oracle.com,
	aliceryhl@google.com,
	andrewjballance@gmail.com,
	hehuiwen@kylinos.cn,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: Fix potential NULL pointer dereference if mas_pop_node() fails
Date: Sun, 19 Oct 2025 19:49:16 +0800
Message-ID: <20251019114916.1618642-1-hehuiwen@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9092f8af-72d9-472e-8d5c-f950c8ce782d@web.de>
References: <9092f8af-72d9-472e-8d5c-f950c8ce782d@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Markus,

Thanks for your suggestion.
The commit description could be improved to better follow the imperative style.
I'll update it in the later version (maybe v2). 

Best regards,
Huiwen He

