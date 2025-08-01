Return-Path: <linux-kernel+bounces-753403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65830B18269
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D30586B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF02C253B64;
	Fri,  1 Aug 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d301E4oY"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82E20F098
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054734; cv=none; b=AXKUH+VsBUshAvyXas/ADO0lCCDzP0WaPbgsre3wQBkfxaB05djMeEmXAqfrMIgODIcY7UZjrVNVjNFLw+LKE7NwFXpviMLl6IKW4BChaHX3iSAPTQbrQSUpj+je7m7Pq6cCVdHC7A92SGLQItBbC3tiPNCTodyqq1OaLHajofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054734; c=relaxed/simple;
	bh=3vzDoLAoOsAJm4NOTTSn2eaoO8si9Nfa7L3kKX0v5RQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LvI+jWfW83XQNz9ep+fv1KeqpytO4rjYInJObDXcTWP0MaqdsC7toNCQh6JnJ9QBDgtS9X8xGw4EC8oNo5WiFVcnJ2yli5636qKpZ2+8GC9NVdHdw8ea3GPt0KbZNh00vR+onyrXNjAju1tHxrzmefMPeK1xvS+zkok0e7vzz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d301E4oY; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754054711; x=1754659511; i=markus.elfring@web.de;
	bh=3vzDoLAoOsAJm4NOTTSn2eaoO8si9Nfa7L3kKX0v5RQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d301E4oYG304VwLZudikygurcWqEHr3IRJLr2LK6tBjv7FDI0ISGH3fosV/APRiF
	 dOCAVABjctH+wyvQJ4WJTgVXwzal5885nsjwdnBiJBVw5fxVegUHr/cOeVegkqyyc
	 eS1INLqSFygjfqT1JobYaRtj+jGCdymgwVoBWxT9TJ03uq3/ezGzrQsH/Vu8Gg0iw
	 bUlqIcOJwme5nEjvj9Ce6TGpM8KD+OD7xZjnVfmlGqxsFQDwg2SuZS++MgpwDx0BS
	 51PY/8fqK6zooA41KXR7kaJMCPBK4Q9ngtxCW+1bpS2870XRrpsWsH1ENtdrQh85q
	 u54ZgmOEE5VuD/NS/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALiZ-1upIw00A4B-004rIN; Fri, 01
 Aug 2025 15:25:11 +0200
Message-ID: <b43c5fc0-173a-49e7-86ee-d7a0ddf0d9bd@web.de>
Date: Fri, 1 Aug 2025 15:25:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhen Ni <zhen.ni@easystack.cn>, rmk+kernel@armlinux.org.uk
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250801093806.1223287-1-zhen.ni@easystack.cn>
Subject: Re: [PATCH] fs/adfs: bigdir: Restore EIO errno return when checkbyte
 mismatch
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250801093806.1223287-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LwF/sDXJgbm/rLDYuQmMPtn18XRUbcTRyx8KZ9epsa11kzMSbOX
 7ZGEs+wUCViAig+2yh2eyI9zNq9VqNVsnkENclxVYUaI4HEGbRyLaXtfpKBVXUzKXGxlW+O
 FLe22dmVW70ObamkJAXfvoa5G50yj61CYn1LAnvUdmMi4dZCmrRHzvlmHpmBEZGNS49KmL8
 M0zuYFGPndEJ4n4h7zl9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KOk0vXcslaI=;kK1HSRsOEgRNE/lfAARUxK6AOje
 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

> Fix smatch warn:
> fs/adfs/dir_fplus.c:146 adfs_fplus_read() warn: missing error code 'ret'

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n145

Regards,
Markus

