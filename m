Return-Path: <linux-kernel+bounces-897822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27485C53BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CAC427878
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064AFE56A;
	Wed, 12 Nov 2025 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jovBnGhN"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73477199939;
	Wed, 12 Nov 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968190; cv=none; b=q83x1tY2z3jxfqXirytfZ83AXvWGtf4TdztIocso+6uORxPIG4s9/2rZME4SNpopp0fQMTuId5cLlrx3lJvNyqm6PsDZkb5rjgrj+rARibScwtRL/wbO8PlHDxKIfV5hiJWO6Qb91GIcnvim7TzTGxNt3hCnNcJCV+hWkW57pBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968190; c=relaxed/simple;
	bh=Ln2RTp+mbijFrYasgSo1wSriperDQCOQ0AAZGCZqAkc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eQTOvuKCtyL/sktrlMR2PsqzSdI5EKeKBjS68NSGwivZt4FEo5cgn1gPACDoxVCLAVVxVBhHwqv0tVeVFMTQVTkX4Hsdxp+sWU+H/WMP9CDCN+71vBK+PTzlsCHzC60RPxDgFgfOpApWRrKG4Z0Oa700mkamKwLzXiqTkIRrh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jovBnGhN; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762968186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ln2RTp+mbijFrYasgSo1wSriperDQCOQ0AAZGCZqAkc=;
	b=jovBnGhNfdHlUD58sNneivSPCWyZL4z3UqJSQHs0vgduEQJUWDKqzLYnkSKWlgBbzRHBEz
	eAYyk7CKcuQstKwofU+D+xdOMX2KVmlOKVG5ExXxcHk/GdW6qN3HquBqi0XjXAiXgQDpse
	lg3/bUoZhgipDpNqVJtuMJycvv2usEg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/2] ASoC: Intel: atom: Replace deprecated strcpy in
 sst_slot_enum_info
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <49fc19ea-4401-4f33-ad4d-5419acf6139a@intel.com>
Date: Wed, 12 Nov 2025 18:23:02 +0100
Cc: linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90195EA0-41FE-414F-BCA5-1D0E64612A87@linux.dev>
References: <20251111224706.87508-2-thorsten.blum@linux.dev>
 <49fc19ea-4401-4f33-ad4d-5419acf6139a@intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
X-Migadu-Flow: FLOW_OUT

On 12. Nov 2025, at 12:44, Cezary Rojewski wrote:
> On 2025-11-11 11:47 PM, Thorsten Blum wrote:
>> [...]
>=20
> If you go for one-patch approach as suggested by me in the PATCH 2/2 =
review, the title should be: 'ASoC: Intel: atom: Replace strcpy() with =
strscpy()'
>=20
> For this patch, both for v1 and v2 (if any):
>=20
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

Thanks for the review.

Takashi or Mark, do you want to combine the two patches yourself and
update the title or should I submit a v2?

Best,
Thorsten


