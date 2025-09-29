Return-Path: <linux-kernel+bounces-835988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF886BA884B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAEB1893F18
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8878127E049;
	Mon, 29 Sep 2025 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="2rj7Svl1"
Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB823C506;
	Mon, 29 Sep 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136767; cv=none; b=MykwRHEiolOUVd9VhUOvcviDcW/Lo60DZlr1LWV5O0pm7tuv8+zvsi3Jwa7khdWAhC+iT4qxKrmb8LFZJLg0ASy/twneSdf093IVh6IwgILr6m9KDVwQMFyPSGi4aImTDUVoBkD9hUoh/9+qVo3En2esLYFvknFwnwLqEiGFXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136767; c=relaxed/simple;
	bh=frTvTh/jan7s+DHeodJZzdQk9x60lL/gV5zS6RcE0bA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUJ/GobkL4FnxgHbDUpOtrHkXBI3P/dA9lFqDHIlI+khWVTQrCDmvhO7zd334rOAUPqV+10c8VBQdt04X/AoKAZiu5vpFI561hX8dTq5rB0ATGt3SO60wqdgJ7PaB/VjGpRR4a5gPfT23D+oCN5lU9j0alQvW3MRi7crHOOKw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=2rj7Svl1; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58T91Gs5072822;
	Mon, 29 Sep 2025 11:05:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp-2025; bh=0dU35KlsEl1QBhjdMKYrJ5/tMivYBlJNdymcOfqRRhs=; b=2rj7
	Svl1tNuzqLmNN61qwvQOy70HvUf2OJp83ZrkfBZMIe6acCmFwsKUEV1k2c3YvOJ0
	s1kLk8Vnc6j4LnoFRbN0fAvD6o3sxvoZdUchqyKcZgUvw/Z4bF+5c5rvq/hFfIup
	SpMpd2xZgSZ1vzXdMyNtCyt9zK/X+WNHXzfIipMDZeXMpCXrhMIFG0Lgg3JTLbzM
	eaJ0Yx2uQALp3eC8aII0PWJDLAcwKUq6+N/2T5Of+DNhOCkg9hgqOvloO+qq/dNC
	M1cy7vQ7OlUZFCWpa9U/tybyh7eKrMu/NPKWNnGV7adltAg+FU6l2Xcf0Q6jHliv
	IAjUfG52hidhBT3Bjw==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 49ev1ggdya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 11:05:46 +0200 (MEST)
Received: from Adranos.cab.de (10.10.1.54) by Adranos.cab.de (10.10.1.54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Mon, 29 Sep
 2025 11:06:01 +0200
Received: from Adranos.cab.de ([fe80::9298:8fc8:395c:3859]) by Adranos.cab.de
 ([fe80::9298:8fc8:395c:3859%7]) with mapi id 15.02.1748.036; Mon, 29 Sep 2025
 11:06:01 +0200
From: Markus Heidelberg <M.Heidelberg@cab.de>
To: Randy Dunlap <rdunlap@infradead.org>
CC: Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: fix spelling, typos, grammar, duplicated
 words
Thread-Topic: [PATCH] Documentation: fix spelling, typos, grammar, duplicated
 words
Thread-Index: AQHcLstyktyjxwWy7UeU9d2/LWnMJrSlmQ8AgAQoTAA=
Date: Mon, 29 Sep 2025 09:06:01 +0000
Message-ID: <aNpL6DOVTu4mpL2L@KAN23-025>
References: <20250926095312.206231-1-m.heidelberg@cab.de>
 <44f3bd7c-b32c-420e-a738-02f40853e472@infradead.org>
In-Reply-To: <44f3bd7c-b32c-420e-a738-02f40853e472@infradead.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2AA433378A84BD44B150C58B7F38ADE4@cab.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4OCBTYWx0ZWRfX7FM+0fRfDr0Z
 SjT86AABBIAyiMPX9MZwdPbdMVR0oEe72pYHbunTLp+NEwWqLa61e82YuX05aUBGQHx73CvGYs9
 AZwEokRdEMBs/L9DdQj9Te6ZxGd6NNZo/NaFYnhBU0JaFMS3gT6k5rIu3x+KmuNlfKnJuMC9DVk
 11lnkEhxoeKKX512+L2mgBemTO6lkHqf0iiaBmlV8ucme23GInQ5kjTtAr6XGls90vqH462G7m+
 u+OqS8LTnnYT5a2HUkdTGCPRKC8wPQPwzgc24LZMi3pNHVTGShefk/1DPhMryNviIGFkedneMnF
 9U6ghX81Rc941nhTF2wR3gG0RGH2XAC+mDUWV+khtUWNUgVvxQ9ywbhY+fxru6RDrYT4qPjMz3l
 +d/HmSSpwgZWrAuv9coIAPA9u6zX8Q==
X-Proofpoint-GUID: _PoRQnvtKrli8P1FqpnaoQRFuHPNltzz
X-Proofpoint-ORIG-GUID: _PoRQnvtKrli8P1FqpnaoQRFuHPNltzz
X-Authority-Analysis: v=2.4 cv=SNZPlevH c=1 sm=1 tr=0 ts=68da4bea cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=xqWC_Br6kY4A:10 a=kldc_9v1VKEA:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10
 a=uHx7LAfKJh6wF2AsyZgA:9 a=CjuIK1q_8ugA:10

On Fri, Sep 26, 2025 at 10:36:28AM -0700, Randy Dunlap wrote:
> On 9/26/25 2:53 AM, Markus Heidelberg wrote:
> > Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
> > ---
> >  Documentation/bpf/prog_flow_dissector.rst  | 4 ++--
> >  Documentation/fb/fbcon.rst                 | 2 +-
> >  Documentation/filesystems/path-lookup.rst  | 2 +-
> >  Documentation/hwmon/lm75.rst               | 2 +-
> >  Documentation/kernel-hacking/hacking.rst   | 2 +-
> >  Documentation/networking/phy.rst           | 8 ++++----
> >  Documentation/process/management-style.rst | 2 +-
> >  7 files changed, 11 insertions(+), 11 deletions(-)
>=20
> These changes mostly look good. I'm curious about how you
> found these. ??

Hi Randy,

I just stumbled upon them while reading the documentation.
The "the to -> to the" swap I originally found in another file and then
searched for more occurrences with something like this:

  $ git grep -w -C1 "the to"

Markus=

