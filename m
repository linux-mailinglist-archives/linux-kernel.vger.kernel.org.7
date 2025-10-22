Return-Path: <linux-kernel+bounces-865705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ED9BFDCBE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9361819A4615
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709B92D640A;
	Wed, 22 Oct 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WUQLEwmC"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD341D5141
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156998; cv=none; b=SmxlgBdT/2Bw+tBXNEMkDWsgKtha8syS8PWOOXsFEVv+5FD6CKmkrTainyTAfXUcEXtacT8hdIxkPuKt8kaY3+LDGgeXnmgC9p3VkzzmIhiCdqprlYJHK/pL2L2DBkbQzk/II5ktaacz8GpFUltsvYvux9x8ddrp4I7ZLTMU5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156998; c=relaxed/simple;
	bh=CQLsR10lQ5p+uieUD6e/BZLiOnPZEH1GIBqYdfEk1T8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gP4Mul5QSrLOzMiMMqHkmclcaitvmMj3iFU8CbbnpqaaC9sBQfVprqH/evr9m8jjJffEO8mEWZrU26Aitj9YkMNitDI+H/EAm5/dhRXklo0S7Oe8zAaRgN4TcdPiTl5Ywk5yXhvOBrcEyFmqGVArrjQD7PO4OUsSB4tFNoU1PYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WUQLEwmC; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761156987; x=1761761787; i=markus.elfring@web.de;
	bh=CQLsR10lQ5p+uieUD6e/BZLiOnPZEH1GIBqYdfEk1T8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WUQLEwmCrYR4sOhYejbmgsl5NUnZot4R0fVbxhpZvuqJ4APRID+92Ie2HdCEaIYk
	 OVjODbtZmRIW8JZtx4JZncqZH2Sr/Yjhm6PtKIiIQE6Amib7+wYLo30BilBFPn6e8
	 VWTS8donmFsRtZZ9Pgit2syTuIEdh9LOl2zaYyntvw+bMNVSuXS3aoWL2U57lQ+8n
	 KYDycacBnP/7adWzS8GfZkB8rrCL93SwRhR39P+PwUnp8HwxTYi+GjBWnE8oMiXXe
	 +4bM1RNVlEE+x+AMB4IFt/b4a2O9WaIRiEwBPTosl9US4fmvVlf1+XB6lMOqF6Xs8
	 k92pjpLu1UXKQ6hNfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jaS-1uBAMJ1nbw-00ySDF; Wed, 22
 Oct 2025 20:16:27 +0200
Message-ID: <ee6da75f-027a-4894-a502-c45a929ab20b@web.de>
Date: Wed, 22 Oct 2025 20:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, lkp@intel.com
References: <20251022175556.62141-1-biancaa2210329@ssn.edu.in>
Subject: Re: [PATCH] Subject: [PATCH v2] pcmcia/parport_cs: fix probe function
 syntax and error handling
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251022175556.62141-1-biancaa2210329@ssn.edu.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n9R5cToY51eF81jPV0QgsvVB8o2RW3PSFkccvh7I3h+GfVAC7og
 Cp8kRxJ3VMbByY04bYoKBOMm0gE2pGwWluGMIDVYa/v179ytmXh+P9qpyc3tL1R6gdVt1PW
 Zr1D6vxO9owrVDLlg1d/HY5JHzv0ufFBYwtA04gQP6r8tXO5P3ruOye7ocR2tDV6j3BAf0s
 A2L5MX5nYUc+7SKxIcAqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SlE7Pnn56O0=;i4UZWi4dVibkGaXKxMjR1U9xJ6q
 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

> This patch fixes =E2=80=A6

Please fix remaining known open issues also according to Linux development=
 processes.
Are you looking for further guidance by more =E2=80=9Cadvanced=E2=80=9D co=
mmunication tools?

Regards,
Markus

