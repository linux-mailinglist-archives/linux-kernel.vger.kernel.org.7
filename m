Return-Path: <linux-kernel+bounces-876792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6151DC1C596
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B1F24EB922
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5A7347BC0;
	Wed, 29 Oct 2025 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="B6Hpw6Y9"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA6343D9C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757218; cv=none; b=nv4YBFGIQECZhbCvz5lsiwbRTWggUFYKVi70sEAFUJvpW/N+mgJPmj3q5VD96BV6nIiwUFV9iTrKbEEgVasP7w3ZFseW98WsInfCO+Um+83WifbEg5UF8+wJKBMhQ88WVvPLDl3avOq9s3sF7R4meu+Ulx6+h+ubL/X3w28gB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757218; c=relaxed/simple;
	bh=GQ4OV2vmvDqc2ziO3h+7GTerMqTOb9PbTU/6p+ngYnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ONILjTu7ZrFuzDL201lIsVchvSQz0dQ/Eg8d8kBKKW0BqPZvsCDoCOUkSjnqohY2VpjTX8ai5BFBXTqV9xgeJohAutAJ7h5Zt82+HI1lnQ35XwB3L4WLfrCWYuJ+JFlChOx+DZB4NIu4lIlxCJ9PArU1vNuv8bQXTtlS4lIt1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=B6Hpw6Y9; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761757214; x=1762362014; i=markus.elfring@web.de;
	bh=GQ4OV2vmvDqc2ziO3h+7GTerMqTOb9PbTU/6p+ngYnU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B6Hpw6Y9umy+cRpZAaPD62cAQp/oth6lZ6R9+GHBqcsz+TrpqsCyd2S/yhf5GOgf
	 9rhrjL9nY3w0FA6usZvxuZLSkIZ+dKqPH3ZI2yFQ0MleoOqvfocKywO4/9z+wAK7s
	 lczNuKi+1ahfHWYgqne86xTXsXJqAZylH8SPMor570qfFQg/+e5Cn9DvbXNUvNqju
	 TyvbyCkJnw7kE54ieE26YMuKxy/xd3urDCg+HDMC2nH8cbBSsouzW8W2fZNXK48s4
	 ob1AMbszukYjC9DxxxoeDvZic/GotcEph8QLNf3NYh7nAjpPA+6mjRhEO9ReAnzVg
	 1jZriHdqUrJolpumZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKB5-1vdfgu47I5-00WHZt; Wed, 29
 Oct 2025 18:00:14 +0100
Message-ID: <aee265c7-eced-45e8-b016-0dffa5d415a9@web.de>
Date: Wed, 29 Oct 2025 18:00:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
To: Johan Hovold <johan@kernel.org>, Gal Pressman <gal@nvidia.com>,
 cocci@inria.fr, Jakub Kicinski <kuba@kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
 <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Lazar <alazar@nvidia.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Simon Horman <horms@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rAvVUzwZdEp+rl6lv7/Tnexwzdk4K+NqKRJf4B5rTpTdp1NGoZA
 gDU0K2UdhECxFF+e1NoDud4AM7mKZvLhTXJxy2fThFHlEF/2mpN9xGtbj7V08eS4AXWEx0C
 socIWR1g7xqiuD3ArMmQ9LNiGE3LUMliJ9rKZYR8cHFX4qK+n36RWiK/NVIJwS2b1WDwjbu
 6HYWn6n7TR+3NTjthuKKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bpkK97f7A0k=;f4tYsGJGdsk7w0rWDWi9i1Q8YoK
 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
 cs3TAjqD1G6OH8cqs=

>> The test by no means mandates authors to use %pe, as the output says:
>> WARNING: Consider using %pe to print PTR_ERR()
>>
>> "Consider" :).
>=20
> Right, but it's preceded by a big "WARNING".

Would you find an other message prefix nicer?


>> I would consider it best practice to use it, and a few drivers were
>> converted thanks to this test.

Would there be more convincing arguments needed according to better practi=
ce?


> Unlike the rest of the misc cocci scripts I skimmed, this one does not
> guard against any bugs. Instead it's pushing for a subjective style
> preference, which is just going to result in churn when the clean up
> crew starts sending mindless conversions of individual printks.
>=20
> By all means, use %pe for your drivers, but it should not be forced
> upon the rest of us this way.

Is there a need to mark any more SmPL scripts as =E2=80=9Ccontroversial=E2=
=80=9D?


>> If the issue is with automatic build bots, then maybe this test should
>> be excluded from them, rather than deleted?
>=20
> It's both; it's the noise the new warnings generate but also the coming
> flood up patches to "fix" them. There are already some 40 commits or so
> in linux-next referencing this script.

How will the change tolerance evolve further?

Regards,
Markus

