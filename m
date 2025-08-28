Return-Path: <linux-kernel+bounces-789232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318D0B39284
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC23998179D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E020459A;
	Thu, 28 Aug 2025 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jxrqicmr"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16330CD97;
	Thu, 28 Aug 2025 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756354743; cv=none; b=hoiV64t6xtd9ay+z5Vc9DmVzkFp60PRBjhUGJh5tLE2Sdx8f5hvCNNF2RJ8kOa4/zWNYzC2yvA2JM/kRYJpAzBjwyBm3dYwTJENdIF9fgMCUIUshD/YQ7eai8pf/5HZX4Qtn65x17TKyU7jmVqKk1MoVIMfqGvVq1SPiq7iNP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756354743; c=relaxed/simple;
	bh=xjPLySpG4Cqaeo6i2PBc0ZZuCTZhuQ8xsn5W87rGIfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZTApYfjYM7ty9Bps9DaR+5WV00BnMsCraLCgkgB6aoaQwRnjiNM3kDoHjy8muzQl7jANCeilQyQvhjaQS4tPHlu0pPYywPSkZ3ZP40OjgoYTpvxJLZvm85CjN49R06H4sU+4oDEtviOVleL4ZOL7Poeq0dfLR/vPi9UCXq0Uzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jxrqicmr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=oNuKGPPg3hK4HshhqAcAMhnyXLVAApIs8OiHECNh8HI=; b=Jxrqicmr34AlSRZm6wMJCkBKeM
	jb5arR1aO4fzHXN+p+DugR/B14WdMERJjWS421KwWRNphNYZChZemDsy/qt9iJrxqzlcY/6oK9jy9
	5ayTR31bi/ca+WCeGlW2se+eijA7w/XPHxHFugWBCmgu6bnUtDONXZ7hUPP+S3No9mYPd4ZujRI3b
	u35wIsfMD2hVid31dSLIVJL/8I0//XFm0AFL6qqfyupnKLFZTBk2VEwoTESYncMRfAFXt5d+QA4qR
	qxULy7IF7SfLZXJNcl90loJGBvz8h56udLj5VQKmQCmu8C6C2IaXrECV/vh4cml5rrRwy20O9fFQ1
	YQaR/LQw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urU6D-00000000Dyq-2i21;
	Thu, 28 Aug 2025 04:18:57 +0000
Message-ID: <d0070beb-f6fd-477c-a315-a2c6db99c227@infradead.org>
Date: Wed, 27 Aug 2025 21:18:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Fox Foster <fox@tardis.ed.ac.uk>, Federico Vaga <federico.vaga@vaga.pv.it>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Matthew Wilcox <willy@infradead.org>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
 <87wm6p9v8l.fsf@trenco.lwn.net> <20250827113312.62162725@foz.lan>
 <aK_XIoncppxWp7sB@archie.me>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aK_XIoncppxWp7sB@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/27/25 9:12 PM, Bagas Sanjaya wrote:
> On Wed, Aug 27, 2025 at 11:33:12AM +0200, Mauro Carvalho Chehab wrote:
>> As a non-native English speaker, "had better know" looks really
>> weird on my eyes, as, at least for me, "know" is a verb.
>>
>> Heh, I just discovered today by looking on a dictionary:
>>
>> 	https://dictionary.cambridge.org/dictionary/english/know
>>
>> That know can informally be used as a noun (a shortcut for
>> knowledge?).
>>
>> For me as a non-native English speaker, when one writes:
>>
>> 	They "most likely know"		(know here is a verb)
>>
>> or:
>> 	They "had better knowledge"	(knowledge is a name)
>>
>> Things become clearer.
>>
>> Heh:
>>
>> 	They "had better know the details better than you"
>>
>> the "better" word is used twice, and yeah, this is requires more
>> fluency in English for a non-native speaker to get what it says.
>>
>> Considering that "know" (noun) seems to be a shortcut
>> for "knowledge", what about:
>>
>> 	They "had better knowledge about the details than you"
> 
> That can be alternative.

Nope, afraid not. Just leave it as is or (I think) 2 people have suggested
something like "They should know better about the details than you".

-- 
~Randy


