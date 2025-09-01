Return-Path: <linux-kernel+bounces-793889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2ABB3D9B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA5188D489
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21597243387;
	Mon,  1 Sep 2025 06:18:17 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06447140E34
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707496; cv=none; b=GeuY/b98e+3OEOKTU6iczaa6UYG+nzi+LBFx84/be3P/45dc3E11JxthJk9N1qFqlmbFVgznCYJBFdhlCjIscTNLS+a9yOSWrqPlQpKTnQBKRNTEPXzozmne/h40NDHuzgJM1iA1SsfdXAFfT8rWA4hLR5ngCc4Q+zUNu7Y4nsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707496; c=relaxed/simple;
	bh=EL5EUGq8LjnKRlfCJg4tsx/HSlRVDTMR+MzapSY6WBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfavkD9l7KBXNSYryn9RsJD+f2dA5KCwClsyOgrvLkHX3StsDmE3bDlS5ka9KO3cS4qt7bCDCc4un7CIxagvzP0MgVq2Ymb+pfHdzv67HSM95iDpISan+yIS15ymTiG5+6xlnTX2RolZ1GwqtZqqwUABRQiVnSH0h3dsiTJAWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b694d5.dsl.pool.telekom.hu [::ffff:81.182.148.213])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088D4E.0000000068B53A9F.002405C5; Mon, 01 Sep 2025 08:18:07 +0200
Message-ID: <3afb62060097eeafbf9faed33654f7f6612596f4.camel@irl.hu>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Fix the order of TAS2563
 calibrated-data
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de
Cc: broonie@kernel.org, andriy.shevchenko@linux.intel.com,
  13564923607@139.com, 13916275206@139.com,
  alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
  baojun.xu@ti.com, Baojun.Xu@fpt.com
Date: Mon, 01 Sep 2025 08:18:06 +0200
In-Reply-To: <20250831124313.438-1-shenghao-ding@ti.com>
References: <20250831124313.438-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Shenghao,

On Sun, 2025-08-31 at 20:43 +0800, Shenghao Ding wrote:
> A bug reported by one of my customers that the order of TAS2563
> calibrated-data is incorrect, the correct way is to move R0_Low_%d
> and insert it between R0_%d and InvR0_%d.
>=20

A similar fix is =E2=80=8B=E2=80=8Balready in Takashi's tree for tas2563.
https://lore.kernel.org/all/20250829160450.66623-1-soyer@irl.hu/

But I think, tas2781 also needs one for the order and one for the
endianness.
I left it out because it's easier for you with documentation.

Gergo

