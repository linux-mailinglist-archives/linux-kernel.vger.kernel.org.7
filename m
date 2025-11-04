Return-Path: <linux-kernel+bounces-885357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4612AC32AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAAB18C527E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8E63328E1;
	Tue,  4 Nov 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Qfhc1Q3A"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1842E6125
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281203; cv=none; b=JwopuDpwjo0kDNzlWV7eZvfrjtMUKB22ozzddygVQhWSygM9wrxUMMjM9MZ72dDN9U4kLKaaOx5XcPqypZ8R3v1K2Lh9XQ7YROIy8O6eWZjX+Ed08AqmcADTxY3BS/6i2u66WD0quj2xV4F3f5m87eQXn93drWb9tjeOR/RSvb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281203; c=relaxed/simple;
	bh=hglUExweMVsY7DSMynSy081FOf6eRb8tRUYRhO0Q/8g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NM7uSlQDQFVf92mx4n/v4bjOosu+XDrPcQxIMDlQxRHU3w8bjV0fYfXuWkgecI6vucyEDutDeX4EATy952CZpRmK2ekai6HRvws0jjciDVY2r8pUikJp+/n2uNNRVV0v6MocGZy/wS4me5I4SFXbc9ybTma9XfZn0AiY7dFmgU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Qfhc1Q3A; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762281199; x=1762885999; i=markus.elfring@web.de;
	bh=hglUExweMVsY7DSMynSy081FOf6eRb8tRUYRhO0Q/8g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Qfhc1Q3Ahhq2qUafW3xX70XeZbBtleb8cTBujSidrq/BqMPWoRd0BOii0+h+EX2R
	 GmtcLxqq9NH6PdAIe/cPTgn6VXIg4JwlMmNwEFI7Efu6cB3rfYTY08qIQLSH23vAy
	 E2+nWobgzLH6SydG3X4/hwyZsauoBOOWHwHgd9At2YeK4RENd7VxDnQuGioN6jqAv
	 M1+2EbxuHzscfPD/jQWciPoaehgjpGWPcnZHW8GsPzkYnC9ViwTDa0oOqVwleE8zc
	 aqpPGyYswEjLQ8UjNAV65tkZWiA+8vaa9GiXlxLD4xgXqHeFRGulmghO0fBhXa9rH
	 p01Hct6jBPxRAbTcFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqTb-1w3DFW0aLB-00o6JQ; Tue, 04
 Nov 2025 19:33:19 +0100
Message-ID: <ea93f13a-ed14-44c7-ae01-edaea845e65d@web.de>
Date: Tue, 4 Nov 2025 19:33:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Vladimir Zapolskiy <vz@mleia.com>
References: <20251104014042.1389-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] mtd: rawnand: lpc32xx_slc: fix GPIO descriptor leak
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251104014042.1389-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KAY6UE17GKP5TI7ajDXJQsM3CZhA63IE27tryqBBHJtnt3maIEH
 tDvJBsbGcH8RYSCf5nJYuFS6tGadmTM0Iep0doxSxmxFlYH5GjrdfKnEHHZu+bPa+bVNnJT
 ByNkfgHK5bJm+2T3Ju8FFY1+P6D81vp4KXU3uUVsTyBdwGgnczcAT1mxvRuP/LgCCvf9io3
 FUAILCimF8aLri+d9mBNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DDDlCo5CR4A=;rJ3ipbut/1toseLC1tZCjMW83S+
 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
 80EHQylmKWI/yl0cKugkYYbLSk=

> The driver calls gpiod_get_optional() in the probe function but
> never calls gpiod_put() in the remove function or in the probe
=E2=80=A6

You may occasionally put more than 63 characters into text lines
of such a change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n658

Regards,
Markus

