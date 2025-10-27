Return-Path: <linux-kernel+bounces-872718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 034EDC11D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4444353F48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D5330318;
	Mon, 27 Oct 2025 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Mp2gBSbR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gePJdz2K"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302732D437
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604572; cv=none; b=G+VYB0qaeVIDJCciiI23nsUt+akJbHFFWUVkmjmit3bJBOFHphRcAHk1zVU6ljbLpy1rn+TBwGzlIPHzAOTxLgo59P+XeIENaRThVwg/evnVYxbYHyWLWPpvOXLmSnZlBfCZ3LIjCO/MWDRQTWBZq+D2wt4V0fWWDmO3U7VTLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604572; c=relaxed/simple;
	bh=ue2FCk0Rt9h8qvrBt4qRjaU6eddkTmmOLPnoPsa7JOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhnUWPk3L+UkApETEsMUlQqhuSNxlmGBL261tQwdONNrtnbKUA119U1lLA/7HzHEN3gUMUgAakftlF7gYAIGr9lYKMT5qv1PYCYW3cpZE6RfhWDcF1yPoQNwxASlsI63p+RKjxMrbNMJsmZU7xaHTGImgrEXF8OM06ck7TG4mmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Mp2gBSbR; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gePJdz2K; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwSyw2zzcz9srq;
	Mon, 27 Oct 2025 23:36:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761604568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuUsLiuwoj8ggTq5lXiiF5Pv63rAFaiLnl6w9yXwD6w=;
	b=Mp2gBSbRnGy0ifaAn/i/w/m+OUb52rTU0WcpTnQzhZWQEu2vMN5ZaXLxyF7TB0MWFUvY11
	AKPftDx6jx5PtXn22dBN8HIdrju25ht2waKD1mL42vdQXaGvzvJkV+nwQOd79pA7msMqhQ
	JWz3u+MmGKPZAacgBDsoK5gVAY6TNPshTjLK/A7pBPN0crU4SfuE6tXM9T/F2obXde/QWy
	3q1xCe14aHSMQNppoockyJbIBs3vw3hxfQ+qKNVojuJZ7oPmsEq535hjhlmU+di9r+FhQx
	J3XmBxilXJui7ATKoovPpIVixcRIXtoG3iGZqHuxA1I8T1Zc5SynAeu8QpdHjg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=gePJdz2K;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <4af3080e-14aa-41a2-ac0b-9d1d5a5fd717@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761604566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuUsLiuwoj8ggTq5lXiiF5Pv63rAFaiLnl6w9yXwD6w=;
	b=gePJdz2KIcowQSrB7fpeuhMfXiQNZYLQ+VRJt+zIj/vSohbLE3Eymbhfpb7jVWCxnPlvGm
	nlY0Rx7Lgj46+/Aqcx5V6SEtQRUr0uski0zfZFoSgZRWDgX/eXJcbgtmMf8tBIUpxsFOCF
	nraWvYm+3n1ZF7Gjpx+YJn3leJtjbBCAGSF5JSz4MCVav27Qpk7j/r/wTXiLvg1GFdqS1F
	ZzfUhq4+urMlCdwqwYYEDTegRUMEJ3sGApsZLM4qz6S4vQR02c8s+qaUjzLtOBz0L0I67w
	+EDXVGLJmMDbXPNrtpXG3uhnBX8kgEalkuxsiaN7JSoJYJeP6w9Spyb8PJHQ9g==
Date: Mon, 27 Oct 2025 23:36:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] mtd: spi-nor: spansion: Add SMPT fixup for S25FS-S
To: Takahiro Kuwano <tkuw584924@gmail.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20251022-s25fs-s-smpt-fixup-v1-0-ce26d4084b2d@infineon.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251022-s25fs-s-smpt-fixup-v1-0-ce26d4084b2d@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7a2283d5367fe856f3f
X-MBO-RS-META: o487npcb1q1ndrkbdoizqs4tmhr98yok
X-Rspamd-Queue-Id: 4cwSyw2zzcz9srq

On 10/22/25 12:07 PM, Takahiro Kuwano wrote:
> Suggest new series as the result of discussion in the thread:
> https://patchwork.ozlabs.org/project/linux-mtd/patch/20240914220859.128540-1-marek.vasut+renesas@mailbox.org/
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
> Takahiro Kuwano (3):
>        mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup hook
>        mtd: spi-nor: sfdp: introduce smpt_map_id fixup hook
>        mtd: spi-nor: spansion: SMPT fixups for S25FS-S
I can provide:

Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # S25FS512S

Thank you for your help !

