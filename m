Return-Path: <linux-kernel+bounces-752478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFC9B17608
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5E618C397C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3488428EA6E;
	Thu, 31 Jul 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QH4cSGOi"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931B219ED
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985748; cv=none; b=cniDX1yc3/Bwhuoppl1pXg4AGvQ3g/pyneI+XNES5pCctkFweexEV0xcBHiyd0ZbLtJ6tswkW4SHCkXjvoiuWWLc+FmYBKSgjTKNhFyKkYU4J6G3ekrpKQ9NJpTydQJi2QNyGrpyQPsYfVXY2b5VHzXuh/JkP2ehZ+/itQnHJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985748; c=relaxed/simple;
	bh=nL6bD08cavWWnInRlvrh+XvoW6IfwsGnjrYNzsquKbA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SUtT+gnBhhHxwtP8zln2S1XLT3Ez5/rj/8XB3DCyVazcRC71qnux54UCXVVdfJ6i2eRWoUd+XDvWONeZwK3F7rmHrrm1Abdg8M4JGo+42f4wDxEm3j4t2YZUvuWZCA0AdmG/ataeDI+hB1SCHg5Uo+kj7ELqX7QV3Vr15eRGg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QH4cSGOi; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753985720; x=1754590520; i=markus.elfring@web.de;
	bh=nL6bD08cavWWnInRlvrh+XvoW6IfwsGnjrYNzsquKbA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QH4cSGOimtUDQcSwQq9YkWlthXbXUg6n3MjDqIDdtYyRMkDMP3f92jy/LqL6qggl
	 LLkIvpxUqr8KtVnz3dPUY/1b1fqPjpm53aJIqPZO0kl0m5bn4G7f3U4DpSrKmCvfk
	 tVMl+Vy2G5TX9wofdHiRWZ1vJQCMl0Jghcuh76gjXQz33Y8rTqd3cqfS3U3HBhLhG
	 nQIi08QEJM5aBqLKApv8SPJWf71cwdtqkOx2z2WJDpZIcCPZ96iA9radHkA3HVPI4
	 IsyW6bIgHk/ji8wdr6g7AdxxKvV+Myya9GAePJ253n0Ead/liZz2Z5QZ1/xBWeGTd
	 mAT9VW+EwYHr94XaOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Pda-1ufuBK1JBW-00ERTB; Thu, 31
 Jul 2025 20:15:20 +0200
Message-ID: <6bf76f9d-dda4-424b-a0ee-a03547ed5b86@web.de>
Date: Thu, 31 Jul 2025 20:15:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: masonzhang.linuxer@gmail.com, linux-f2fs-devel@lists.sourceforge.net,
 Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250731151917.24800-1-masonzhang.linuxer@gmail.com>
Subject: Re: [PATCH v3] f2fs: add error checking in do_write_page()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250731151917.24800-1-masonzhang.linuxer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IPV5vziLeui+tlVRJvGQ98KSrZtJ88yF2dZGqZkHLBb9AxOFRhT
 oD6OP6Onyd12IrJGiqZCYlOv61f+gVHPjYJsZXhRZksORxqzFpu4x4d2lhrr4jeAjhzIeQj
 jY0lKlQS+UDsUrCqluUT+KDSdFBmER+b6DM0tKQLuDK1rB8MaPRGGnb8NfkLtBVJzr0JiM0
 oKWZqOyY7pSSXtjhi7nyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wThGtQG7gzw=;vxLMV8acAr+Xys20CFCWKkFVjeZ
 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
 gOfXZIFQVsO/9hXDDTz+ujc=

> Otherwise, the filesystem may unaware of potential file corruption.

I find that the change description should be improved considerably.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n45

Regards,
Markus

