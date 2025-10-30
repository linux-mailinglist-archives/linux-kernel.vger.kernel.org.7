Return-Path: <linux-kernel+bounces-878397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F878C2082F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F9718983BB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D12475CF;
	Thu, 30 Oct 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R/KsH5Ge"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F022688C;
	Thu, 30 Oct 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833187; cv=none; b=TLz++B3qv2Q8bW41zmRhg6315qt3Md+ni5Y8VdvTEKEztrzp6uUepANpx1nna8iBKH9RH5Qdmreto7cWLc0EEGmKa6MVVJP1wM8SBrxvnwLC4rX8T9q52R0luTnH4b1EyCYA60BxFC4k6Q2ROfQsk7HYbzhVDNO8XtnAzArY0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833187; c=relaxed/simple;
	bh=JExjKvHn4HaOKWXUYWTfZ0phNDQXNB6cOdCO+OS/HN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=We8RJDmXyqtJLyA9yrIr1apu8YAhnA6+CPNuj5xx7i2amcnIVud57npL70AH3FZl5RC0HWgcpel0Eh12jPVrxCUQ7OFvRoa/fsoUNAzAyemRPyOKtWMo5PpouNN1yNl2xf+UU2qZjm0V0GQdRVE3ezWhatkmDerkv0cJOfhyyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=R/KsH5Ge; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761833181; x=1762437981; i=markus.elfring@web.de;
	bh=lEgoBK9QEQKqzg5dzQhfR3LPrJ4cxEj9OaDNR0Pzkbg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R/KsH5Ge21Q3YO6peNOOZbmWDBl6+AzHjWhvfDpXWu7Kl5Sr1DMtocIfIy32ZPYC
	 8VfPPn1txFvLxLQ2rh5dr4kTkbbJ7txfKWfjJsXlg44ywEUjF6cJ0Ny0ANI3NCORH
	 qUyDsTNnznTPKYbyWSa/LpgIeA1MoQSrK+cD7a1y3Qs55GeVHh3OezKLC8uzy98tX
	 aVvw+adWxYEL11M/09jUkliNMHNly1o8Kh09LAy9OtO5QY1Xt9L4mTkv8PTM+PUsw
	 WI1cOcY2wzsSSw7Aaj/7NiodpfZivwuGuIb5ItuNE2nuzoPYAgEO6syUnRR/cmnaP
	 KOowZ2fWKH0D4JHxjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxpiO-1wCU1i3rCw-016pHA; Thu, 30
 Oct 2025 15:06:20 +0100
Message-ID: <d67f27c1-973d-470f-8903-7e5aaf93777a@web.de>
Date: Thu, 30 Oct 2025 15:06:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments from
 memcpy() calls with SmPL?
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uUsLVQMS8kabKTgIQGtxnjZG9WKaZBCviZOgmIs3a1igHQOb94o
 I/A3VTn+H+HaHI9QGftSHIRX/htSnvoyor39Ex7OBTguYwRONrdeAihv+s1aoYDsW6HZ+mc
 DFMecKHtsC33Vom+Vxty78CxXmY5auXG2FNK5mi426N6qLdxcOS5O64SjneGoix5FIlajH/
 kDFKTpVtw2z3SPcZtD3vQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KEcLI7s6840=;uMLCdw38StnHmRRGlvYpYKkq6TO
 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
 oe8cA==

> If you have a concern, you have to say what it is.  It doesn't seem it is
> about the running time, so why do you include that information?

How will the chances evolve to integrate another coccicheck script for
the discussed source code transformation approach?

Regards,
Markus

