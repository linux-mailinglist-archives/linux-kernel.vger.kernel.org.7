Return-Path: <linux-kernel+bounces-841391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A924DBB72F0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6955719E8077
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A3323ABBF;
	Fri,  3 Oct 2025 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="rDTQABXf"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F840156F20;
	Fri,  3 Oct 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501744; cv=none; b=DZ/6Vi83uqFq/bIHrkAeHSyNdjbgKXzJUooAoGZdQkk2YfFZhBUMXk5BPCPBuWdHKZgs20TkWtrqfS8BOPqYjrFOhMMMuPo9TeVWJDtDdKgS9aQufeig5zHsb1XTi8vLn28DqWx3ntzZBGOCupKaTMrxWYxSSm1eOrOiDPeSi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501744; c=relaxed/simple;
	bh=MMKF7tw01yglKAHwmffsqsUvjDZqq/s5YQzmuEiXpxQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=s0/qom7e7kLdH/onq0fWeI+d9lAyloyt7jM9iHMfRlLvO40DA5FlmsD0KKbxwObyWlLoWvBYhX92scWwrHx7DFtvCkdC+VZBaQEMA77ATbF+jMMH/c4KffTQtFuc/+9ekD/BwlHRGyIUzFyv6WHBblGF5HkNwZhWeiZvnrEdWM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=rDTQABXf; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759501739; x=1760106539;
	i=markus.stockhausen@gmx.de;
	bh=oTqg2npgKEGMOQMr/s7XNHcjqbDTehdyJapKNLr6RNc=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rDTQABXfyErPT2K1L625KYMykx9n8OYgiN7fYu2Bg6ouOTFKqzBVxyH0/0L/Jo+l
	 PJKx/xq7EInEyrynPIpoV4k6QAJJ/C8mL2RNuMAgohIP3z67HQkI+V1En8q1HkQuM
	 4yEvMfhjQ1WB3m8nGsBgzSFkIzm5atmk8/Sd11FQUyQnAGjFQBv2nBB9q6JSA0C1a
	 MLdQBeDcVz0xfNJ9TyDU7Y0i5nNUMlZ4ayu3zxvIuiAznHHdnRzlNUeIn2nlW5opJ
	 ZNIrhwzc1Hjagc+CQ+PGVLCcu/LssBHBn9sj4asr6sJ4jv1c5O2iBSr8TREzpQIq6
	 5/H3iX3u5i/IYQAhmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1ul5rQ1EwB-00YbBa; Fri, 03
 Oct 2025 16:28:59 +0200
From: <markus.stockhausen@gmx.de>
To: "'Dan Carpenter'" <dan.carpenter@linaro.org>
Cc: "'Miquel Raynal'" <miquel.raynal@bootlin.com>,
	"'Richard Weinberger'" <richard@nod.at>,
	"'Vignesh Raghavendra'" <vigneshr@ti.com>,
	<linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <aN-XoqpP2Jz75pjj@stanley.mountain>
In-Reply-To: <aN-XoqpP2Jz75pjj@stanley.mountain>
Subject: AW: [PATCH next] mtd: nand: realtek-ecc: Fix a IS_ERR() vs NULL bug in probe
Date: Fri, 3 Oct 2025 16:28:59 +0200
Message-ID: <00c601dc3472$0facc810$2f065830$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQJqja67MJKY+tUNx++6gAi8+r8CtrOTyAXw
X-Provags-ID: V03:K1:Cz0hESHIKg77xNOkBMntF6ogc2m+1zwCHA/YQfziEH7mLKM491k
 I+jzBrxGvFhVJ0oytGI8FyEfUrWAy72Ofs+6GqSvZmxBMjyJ1f48txI+MZ6xTWECVIDvPvw
 BmjH3CekeBr1WmVVY2aKrsm8QTSIKgmeUqdLZ1HhPHMneSjtym/wfH4jLxpyR9KBTQbFiTl
 w3IRJx6m6020go591isoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xIktEgnlmIw=;Bi5x9vty1IQzeK0IcPElMhxFx6o
 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
 3Pmqg==

> Von: Dan Carpenter <dan.carpenter@linaro.org>=20
> Gesendet: Freitag, 3. Oktober 2025 11:30
>
> The dma_alloc_noncoherent() function doesn't return error pointers, it
> returns NULL on error.  Fix the error checking to match.

Hi Dan,

thanks for the quick fix.

Markus


