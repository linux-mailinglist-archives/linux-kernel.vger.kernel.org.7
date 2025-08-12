Return-Path: <linux-kernel+bounces-765216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E064B22CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE951728C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDADC2F83C5;
	Tue, 12 Aug 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NHqyh+ut"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00192EAB65;
	Tue, 12 Aug 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014614; cv=none; b=CH4z98jcKCXrBao+ByTG3ND0eO9CUg9FfESxXHJbjIwUI5CQW2d7TA7eIArcg7Lm+XfEXer0rf0DrRTIoCV9/esdOhzxQ8rLfJbPjYocangDJQ5l+UmXqP34bXAsknEup9Hf9uPTxT8V00e6T0568s9GGjskz91jIiApDIUcYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014614; c=relaxed/simple;
	bh=rLDokQ3meDb12H0ixXllyRaNPT5ixWjxQgRmY1Y8n0Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=q2mgWk+tSQtH3EINo8EeAmy0gpWvKjUZKVAsizO72FGDLZ4uGZLvCrOjtb9Arkam1WAG+QgQEqs3FjGAyyUPn0Uyl+2SrKIGp+pDgZkQ0rx4V+/h4Norinlw9iCYMRO30CIIexYkqiMISWUEkUYa2nqeysWTK3TcHq8kmnz3yYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NHqyh+ut; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755014604; x=1755619404; i=markus.elfring@web.de;
	bh=w3zBTRQBpWsXwpXyA85dTEYjXcvJ7ige8VdHG7gLgoM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NHqyh+utjC1zjs+VOuLFKBZRwOfu34eBNn8ZaVPuURw7FpwWLVPx37ANnA5JniwU
	 Z1M5EnCGJLlJJS5szyaKx0PtoV6qNXJIdUg7B6J4VR42pkpkS1hPiYccWTe3W9fMW
	 58+Njw3ZG8Sw0oeaGDV9MsnpGY7l+bO+w69EuVfO/jzOrhh8OFZ/Ue9pVNx/Ulf14
	 mt5Lcl6ErM8DscDIVplbUr14S1j/Xj9HVq5p9KZGrXmMzAtx+JRP6sfgGScrB+KL5
	 fdv7vgPhKY9hcXHXRTsj3jgrhNujhxRnQUhr0AGudstchWYp/n6Vi3E0OiHMiTfTu
	 BLw9RUtMS8Yt0zmHWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1uWFOF2GFd-010jt2; Tue, 12
 Aug 2025 17:57:54 +0200
Message-ID: <29a87213-8a56-439a-98d3-377d067dda9d@web.de>
Date: Tue, 12 Aug 2025 17:57:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Scott Guo <scottzhguo@tencent.com>,
 Phillip Lougher <phillip@squashfs.org.uk>
Cc: Scott Guo <scott_gzh@163.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20250812030403.517269-1-scott_gzh@163.com>
Subject: Re: [PATCH v2] squashfs: Avoid mem leak in squashfs_fill_super()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250812030403.517269-1-scott_gzh@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sSV3r31ikOCCp0ZOCPrk29+dRSognoGv43dc94j8wd14HcS0W5W
 NaKMj1DRooDNX1KyDL8d91W2b8szmJXP8fOJWFASOdlIKInDtvoMCrB9l/yw8xZdQZsmFWJ
 Pulb4AYdoHyNcQduQ/MN1bayz+36LJUJGDbrOhcx1aOsRp2VOgP5w4lTMyELGS9mcpqBPJY
 3h/r4MMUDbulvrEFPVawg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HVlPc0rffEQ=;uhQS8IUm8Aa0kQoABWs2q+glsyq
 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
 /30loklX6OS71Ty3GK6Q==

> If sb_min_blocksize() returns 0, -EINVAL was returned without freeing
> sb->s_fs_info, causing mem leak.

                         memory?


> Fix it by calling and checking result of sb_min_blocksize() before
> kzalloc.

         () call?

Regards,
Markus

