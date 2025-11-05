Return-Path: <linux-kernel+bounces-886421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D04C3589E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130D51892167
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42865312807;
	Wed,  5 Nov 2025 11:56:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4C305056
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343794; cv=none; b=FQKoLSAuELwCYYRVQOpU2F1vEQyuHVpmdnWtTET2lwyGzJzeTjLr8LAFmKiZLASLZvoG1EQ9e2IJ6jHQw3op+z41JDnh/xBbVlFnHUU3dG7iJ0GJNRZrUDMQ+Zwu1ABfSN/jxeR7CkjYQlWk31Ls3waNc+2k2Uh08j1cVKKSRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343794; c=relaxed/simple;
	bh=JuEAzNp5ccMag6Yvlb4mVnaVw+oCWuSEupYqMfslvDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StCsZ4dnz7JDXO1tJBjm3+qCXBnAnEJ2oKoHC/vH/GbYLEbnXjdBEcI0ermrUV8FG6dNR3rwDUAXCkuq44DaxRmIhUT1mvFW5WcM5nzqopp7gIgDKbcPKvuwQKdtlaU3pkuhaaSz7xvTREPyn88FbIJJv8O/VSYhZQcBR35vl+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bc9c7204ba3d11f0a38c85956e01ac42-20251105
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:12db0465-c413-477c-a9c9-0d5df1bbaa45,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-INFO: VERSION:1.3.6,REQID:12db0465-c413-477c-a9c9-0d5df1bbaa45,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:11b0da5992772f3a2b9da9edd14284b9,BulkI
	D:2511051518140QDP8CZS,BulkQuantity:2,Recheck:0,SF:10|38|66|78|81|82|83|10
	2|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:4
	0,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bc9c7204ba3d11f0a38c85956e01ac42-20251105
X-User: hehuiwen@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <hehuiwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 168032075; Wed, 05 Nov 2025 19:51:16 +0800
From: Huiwen He <hehuiwen@kylinos.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/hist: make err_text array fully const
Date: Wed,  5 Nov 2025 19:50:59 +0800
Message-Id: <20251105115059.261361-1-hehuiwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251104045558.1644671-1-hehuiwen@kylinos.cn>
References: <20251104045558.1644671-1-hehuiwen@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Steven and Masami,

Sorry, I didn’t notice this warning when building the kernel locally.
Please ignore this patch. After further analysis, I found that unless the
prototype of tracing_log_err() is modified, this patch has no effect. It
might not be worth doing this, since the tracing_log_err() interface is
already used in multiple files in the trace subsystem.

Best regards,
Huiwen He

