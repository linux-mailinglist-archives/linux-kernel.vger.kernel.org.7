Return-Path: <linux-kernel+bounces-786905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F19EB36DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421E8188D9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8E92701B1;
	Tue, 26 Aug 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b="Cmki5lHO"
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14D26B955
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221799; cv=none; b=qTl7nirC2lyTrj3zOYlxUiyIn0m5JR66wYXfKIZl5d4IvG7rZ58FDk0Dm7Dx8NwKwBpboU3ejp2ZMVYZ2hWudf1UbLWG/b/FR+qczb5VDlwSQTtT9Fhd62drwQMXIYxygtZ9lzEHP5gmV2oZP64/pZf7FGh6pRfvriGaMSAvyMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221799; c=relaxed/simple;
	bh=aZKtwQOmcc2qN/pwCBkZCaBz5G9Qh63XuyUppp9STWo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMZEDehwgcJLJew2FNey2Ofw8nrMulK5GtBST9UOCmej+vggFM34s1ESMd2WlVlq+suVp9kiFYxwJmAzAWXrBg1PDwg/9V8wBVz1dVe3jC/uY+1QjoKvhTDXpKTetZmC0UrgNucKReOqlmcO9U4xG4JzQ6UYSH0tdxCy8hOWgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=Cmki5lHO; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r26.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail3; t=1756221789; x=1756480989;
	bh=aZKtwQOmcc2qN/pwCBkZCaBz5G9Qh63XuyUppp9STWo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Cmki5lHOGwN2aoLvumRb60R4amX8PPEoATxnRo3mmsLA0fNsbHNQI05VgJ2qB5hjs
	 Uqx/dNibAChyZnbHiQe5DYkXtOuDnuSdVC+MegihJCVemD3DC4qxUk93HOso0iLAeV
	 5NNtnjU1WW7980yCDDDtFuLK7WVGsQ499k5gBChFLyzgSS9l5Jv99sszcPZv6xvRNA
	 cnYNAKVYEzPqv6qcyh6CqMk5SZ0d2Xd85NwKY4GnzjYqCpSSV5kzmePZ0Xr3AqEiRA
	 VBeZnUU+5Gt43FVJLHNVSyXuKLvZpy3XYJKxYqREd1h/6W0CjhaQrNRJIgfHbEUk93
	 ukcqFbIiTs7Mw==
Date: Tue, 26 Aug 2025 15:23:05 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Rio Liu <rio@r26.me>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, D Scott Phillips <scott@os.amperecomputing.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Markus Elfring <Markus.Elfring@web.de>, linux-kernel@vger.kernel.org, =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 0/3] PCI: Resource fitting algorith fixes
Message-ID: <kkLqpZHhRDV1br6t0vgaBpHfeQ5TW35Cq28vSxIeSn4JoqkRonRLXLzgPm3UJ_OFiNNDA9GK56vir_5UJj97M6kSRGiDn1Meeug_P-vKxG8=@r26.me>
In-Reply-To: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
References: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: afd556c8e8ac7154d6f866b5d30bb33c19f227ba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Friday, August 22nd, 2025 at AM 8:34, Ilpo J=C3=A4rvinen <ilpo.jarvinen@=
linux.intel.com> wrote:

>=20
> Once Rio has tested the first patch, these should replace the v2
> patches in the pci/resource branch.
>=20

Hello Ilpo,

I've just applied PATCH v3 1/3 on the v6.17-rc1 mainline (commit 8f5ae30d69=
d7543eee0d70083daf4de8fe15d585) and tested it, looks like it still works! T=
hanks again for your work.

Rio

