Return-Path: <linux-kernel+bounces-889969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5473DC3EF00
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE09188A0B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB81F30F537;
	Fri,  7 Nov 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hC6Ybp7C"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99051DE2A7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503825; cv=none; b=bKA+8TeC6Y1YNEjKe3UpHHLtfBIxRIS2NVk0W3BGlzQbPMOeXTBa17AcIfpfglOyEvzfoWQXGD99546u5m58HQ/Ck+JtgI+SSEC1Dq0/S8+igAQM1I2Fqu2qLvvdZbwGV0hfeQ1kS+N5owJZ1Cy2CD/tzagUSZEycuih3aATPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503825; c=relaxed/simple;
	bh=tKf9hicyZnGFrTfWX2o+XRStC8ukCbUa/kgb7DlZK5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s7XLF/kvtMfwbKwrDsVZw7ObL2I6LKGAXM77DCeU98Cxam/fh4i11ohbbGaaAYd04UE3e+p1hmnMxga7mU7wYUV9maNBpBG59Nf1AyufQzg7wGvO9yJGd5IXf3U75oulZ4/dskhs+oxIjAPr1M8iORUCKPk/I9IGp2fp0E4Mru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hC6Ybp7C; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7FCA81A1916;
	Fri,  7 Nov 2025 08:23:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45E2D6070B;
	Fri,  7 Nov 2025 08:23:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C6301185123C;
	Fri,  7 Nov 2025 09:23:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762503816; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tgaD8rjkXyLYWq0MjyglgznDWdH1xBP/wgwuMKwG6Pc=;
	b=hC6Ybp7CevBpMo9V2AKZi62zde0rkJ18ZNGd39fzBSskzr3UJS+9nopOLQUgupWO7r9coQ
	O4KUFo6V7ida1bgUWk+nhnABVueggPqH8ptt/2rCHXA36hqXvavQZ5M8jJuuscflWPgtXj
	s+3C3OBq/wwzGQLkNP3BCEQUB8a5OWlRZmZhMY+RQYvKF7+czxG9jJLJAE9Vle/E9nweBF
	FS5qRI12FUBkFa5w83lQvIhOUbiECdLKRsiOSGyBOcRELO4aMySv3YCFCV/QC+ctJ/9STk
	fri5sXqfNv0vvpTHtHvK2WLXrpm4c5GH820WygJl28LX7w/i0T9sXFkEkIH1Ow==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: richard@nod.at,  chengzhihao1@huawei.com,  vigneshr@ti.com,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  alvinzhou@mxic.com.tw,  leoyu@mxic.com.tw,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 1/1] mtd: ubi: skip programming unused bits in ubi headers
In-Reply-To: <CAAyq3Sb8-FRC+bZt_bEvOdBNVSN4xa5F_TpBbKF__HzhVPEpTw@mail.gmail.com>
	(Cheng Ming Lin's message of "Fri, 7 Nov 2025 14:31:12 +0800")
References: <20251106054940.2728641-1-linchengming884@gmail.com>
	<20251106054940.2728641-2-linchengming884@gmail.com>
	<87o6pf8r24.fsf@bootlin.com>
	<CAAyq3Sb8-FRC+bZt_bEvOdBNVSN4xa5F_TpBbKF__HzhVPEpTw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 07 Nov 2025 09:23:29 +0100
Message-ID: <874ir68d4u.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

>> > +     if (ubi->vid_hdr_shift)
>> > +             memset((char *)p, 0xFF, ubi->vid_hdr_alsize - UBI_VID_HD=
R_SIZE);
>> > +     else
>> > +             memset((char *)p + UBI_VID_HDR_SIZE, 0xFF, ubi->vid_hdr_=
alsize - UBI_VID_HDR_SIZE);
>>
>> Here I am reaching the limits of my UBI knowledge, so I would prefer
>> Richard to (in)validate what I am saying, but AFAIU, the VID header can
>> be literally anywhere in the page, not just at the start or end of a
>> subpage, so in the vid_hdr_shift I would expect some extra maths to
>> happen, no?
>
> I understand your point now. If the VID header is not guaranteed to be
> at the start or end of a subpage, then yes, my current logic needs to be
> reworked to cover that case.

I don't know if this is easy to do, but maybe you can memset the whole
buffer before filling it. That would avoid the need to know where the
VID header will be.

Thanks,
Miqu=C3=A8l

