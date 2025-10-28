Return-Path: <linux-kernel+bounces-874647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E4AC16C89
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2137E4F3414
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FBA2C11CB;
	Tue, 28 Oct 2025 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UlcBCkhE"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA32C0F69
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683430; cv=none; b=LUQ/KDezK/jJFe0qyGOxJDW/N0ZQLXiva9Kwvfr+hjdfHTN8fvxEz5XXrMyrlvoPWJtKUjOBs6XYpRBg/WoZyCLGRZaA5TXWbY69r6Uocm7+eLoBUcs1R+GliUzm76lN3TJrQt73lm18q5R/74dGmyxL21bqG/yzkw2LiuN6zs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683430; c=relaxed/simple;
	bh=DdMrjaycl5Rs8nmPFl2T7+j6J1/i4k2BgwnqAEmpOrc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ep2h4970Oi92aiOYBUgnG8GtAholMTAW3WnXxKqYWlMwDG6EUJzOftogUg9KVUZ54Lk97fRp9fA8bqG4BhdnHKWHKweNjRh2RFXf2SXpssUjk5eOLvvCd+1S49HnIgy5hDcIdBzh/rCJAyNR8BuM8OGNjtn1UuEsYT0AY5QQmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UlcBCkhE; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761683425; x=1762288225; i=markus.elfring@web.de;
	bh=DdMrjaycl5Rs8nmPFl2T7+j6J1/i4k2BgwnqAEmpOrc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UlcBCkhEnBsWMIyqODhf6HdylnKyOk80VcaESo2jSlRZZ2Lylb44pMSOhJI0JqHs
	 etL94HqLgmpADDcs54YRRxy8SbFEbcOE6mDWAEex79iXVTkX2P3lmiN6Z4hVQQar3
	 +ooIfSxRaUSFWyGQXTJPPpl8TobSQqud1Bsnc0Dd6U9VSXADEX1kdVTItnOiCCgag
	 g6QbPg96sCCf6xQzP93JlKb8IqHi9C8ITjWAoHng3LsUHwHYouJ2ZgudjOJeS+z5K
	 /BH0ckyLqwPzoKXmUtpRj9/93xoiwV+fdGcUcIViXl8WFv+gYkmLwzbMtZiaBON1C
	 iLE0KNZQItAP36+F0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M76XT-1vLptO3JGB-00B2jn; Tue, 28
 Oct 2025 21:30:25 +0100
Message-ID: <b7a2ac2a-53c3-49ce-862d-eaba86f0b298@web.de>
Date: Tue, 28 Oct 2025 21:30:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lizhi Hou <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>
References: <20251028175452.2329497-1-lizhi.hou@amd.com>
Subject: Re: [PATCH] accel/amdxdna: Fix incorrect command state for timed out
 job
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251028175452.2329497-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QwcS455MG8q2z88fDEKRwpC9wkA+7XEsmIrDO9pzbIqg+wFr1/h
 XGbzjEGZcFLUA06uPjiOniuuQ1q1ZK5KJPEKdpiG2p7jdSNZ+9R8Q0mEH4yIwAWNpGUSiNX
 2nMdJz8oYfBu5HcLwF3LzhNRksQKceJdxBfLfhMtLycNGYCNEmJP6XO0+arA42zMhLCOI/2
 6x+EWnTNIOIPudCVXjQkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:48vK4V+LRzo=;Kj+76tulifBfiLCdw+QyRrDrGrE
 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
 bgsDQ==

> When a command times out, mark it as ERT_CMD_STATE_TIMEOUT. Any other
> commands that are canceled due to this timeout should be marked as
> ERT_CMD_STATE_ABORT.

Would it become helpful to use additional labels for the same state settings?
https://elixir.bootlin.com/linux/v6.18-rc3/source/drivers/accel/amdxdna/aie2_ctx.c#L197-L226

Regards,
Markus

