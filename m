Return-Path: <linux-kernel+bounces-776101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF1DB2C895
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BCF3BB215
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E849827B328;
	Tue, 19 Aug 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XpZWjNsC"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588A24169A;
	Tue, 19 Aug 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617916; cv=none; b=tK6w5HBUbkObrS9BP0pXzS3n/KPragtVtYrfps2ploglHFHmFJOt/j2szHj5wk4WWVN1QpLPUlsEt3dUETFPiJ9eH1uG0n8xay3/A69G7SHkbR07Yco1YnR0nT6yxtz6074pbj9Z2kAoIjsA6uFjuJjzq7NQlkLnSL12wWZEftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617916; c=relaxed/simple;
	bh=AKEYpdsg1TO6d+g8OCNa1j/XG1jevWhR3lT877aplmg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SD1sSV6Au59I3+mIV+ctFgF8mkJRk4R+ralFc2gq9m8xCLTNTVgpmudB9KK30qOMatcRcTKWf6uGJEMFYvuj//oerVmaxx06kWF/vxdEljnl3u10tRnKU98ap/OMB/deOlLBQI+LW3fdbXMDae7IX+OXVEDqniMcMK++1Xmzri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XpZWjNsC; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755617893; x=1756222693; i=markus.elfring@web.de;
	bh=AKEYpdsg1TO6d+g8OCNa1j/XG1jevWhR3lT877aplmg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XpZWjNsCJiKLzo4GCa9J1g7YqbBPtDkj5lcfZuJI0I7iMro7x6O6faPDndX82/TK
	 w/nsPkOrpe0awCWxiLHqYKQ5eiR4wmcs6EN1gbt1iqxpqgvLS/+5g3Xhla+WRQvJ9
	 ZXsO+Q5OkyOm0NXhlnMW1jAuF9TxVIpcnr1VlTuGwaaDPWw2L3MLsbmFX61Jsu3VV
	 U0wyNPdh6+40g9i+dR8j42ELdAakReVPWZTjjUB/n5XOL9Rol9krztI+Bwd2W+1m3
	 LUdHrKknqq+42u9l5IddgrHNZMRQ72+rKWCQ/OSlFqiic1meF1Kfzk2BBzMEHvE2o
	 pEmhlO3iqFBj+WOJwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0Ix-1ue7hO10ix-00wSwe; Tue, 19
 Aug 2025 17:38:13 +0200
Message-ID: <5ff2f176-272d-496f-a62c-f0962b92fe78@web.de>
Date: Tue, 19 Aug 2025 17:38:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Alice Ryhl <aliceryhl@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Sergio Perez Gonzalez <sperezglz@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250819131330.153128-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] lib/vsprintf: remove redundant header files
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250819131330.153128-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:my4EtSvaPXWinE99DATz6vA21DKpQlRT6UldYuCaP2izUFfbgBk
 xQvw54aktQPj7iyOvWl9Qf+2sdcESzKfCP7zxZcg6aL99TGPS4hvty7M04My4/rjCEBPOYR
 rHpJe/ectHJHTpGzR5W6nMVGzO9mTkHYDoHQQOJc1F08CcW75Jvl3YY8WVK6dwvqjEyzCzU
 B/qjPubBSUNHVG9C/XtAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tr2ZXybjbq0=;FzGHvx15I9a6mb68Ozhl9bwL8uj
 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
 o4a81vKBYud4NjIwqIEjNCCSa0B6FOl7LHg8z

> The header file <linux/stdarg.h> is already included on line 6. Remove the
> redundant include.

You would like to omit a duplicate #include directive, don't you?
Will a corresponding refinement become helpful for the summary phrase?

Regards,
Markus

