Return-Path: <linux-kernel+bounces-754450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA49B19468
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A5A3B532A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030F17ADF8;
	Sun,  3 Aug 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VfQzwfhA"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6282E3707
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754235955; cv=none; b=E67lBVfZDdpRGT1rICNxVLLYKJ+8Y6m107uLIaJFdK4+gkJBHAjI+lHy4mSoriYjZYcwgAxk3oCzCWZQubYDeVpNtL+LIkAqeQLEz+3Y2mN+5h4NtUOATwsGl6LnvShEGqtOiJIkN2I24Bs/8cgtf0ncnk3lNmiH1Or0QVPuYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754235955; c=relaxed/simple;
	bh=4u3BFJGkGklZSymqiTLQWOC/ieWzOcBzmmj7nT3LnvU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BMyDzNYajvQbchqWdxwy9XATniFl2SfNzXFxOOqaXRebHbH5DrWuvvfKep/S62qUD0OCDqaQ9xwpAvyFuCXw4wmCuaii2Z5zUtFPfqaL1mCp62dk9le0tMsM34n/ppLuilHkQSoXW48PIDce6oI5o1vqMkDrlPFIAIkLHOxDSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VfQzwfhA; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754235934; x=1754840734; i=markus.elfring@web.de;
	bh=1EJsqyoud56UXwFrS+ONP1KUQcds5dW1LMiyulo6zII=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VfQzwfhAdWWDn25B9pS9vDfSFGOLYftsOU9kbMlBlSxHYb9Lo2NMMMXAnjSw4wEa
	 6Iw74pj6hMCD96Ny8ZsSJfJcNOOppllOfUXB0FjfU9joBT8ONpPwfH5PQ1wxLlZd1
	 XPUfATM6VttmqPr+bS5cUS1isU9Yo2ZBZ4mxCNAX2U+U094fGsnMySpEPh8VlTvQW
	 2KatxKvBTY3RocXc3JCuXPLsNqW+12NiaSP9HWamhjclnFZK4U6kFAubhe4inlU7J
	 bhM2WrBjry80xioZ+UfflcyrrdgRgIspRWC7TPrfxJXk2vmohFsg/GJ8cilUlEuPS
	 +L6BXkEC6z76/X44CA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYcpr-1vCgub0xxz-00KKw2; Sun, 03
 Aug 2025 17:45:34 +0200
Message-ID: <04bad825-1dd4-4956-95fb-a4ca62c0ed7b@web.de>
Date: Sun, 3 Aug 2025 17:45:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Elad Nachman <enachman@marvell.com>, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250803102548.669682-1-enachman@marvell.com>
Subject: Re: [PATCH v2 0/1] irqchip/mvebu-gicp: clear pending irqs on init
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250803102548.669682-1-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FARc7NppLlVe9OyRfqHJNzLdpDF4UQRdCF2FR6lWxmWaUUiCeLw
 W5VFgYA9A2jNDzNrJj4viaqNK05toPViesvAqlii7GjNVTRP0PAe6zr+DKA+9iHkEWg+SRe
 nqpcAIWavuks6Dc2jAXN+aZ8DkTY8VQhPK4zdmF215JKSdTXIL1OR2RUN24EAVuhNHex83x
 9+gYV5ISelByNThOuCRBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ui8v8zK55+Q=;GUVrya2wHDWMZnZxm+JSOYrzceM
 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
 hw==

=E2=80=A6
> v2:
>   1) rewrap commit message
=E2=80=A6

You may omit a cover letter for a single patch,
don't you?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n784

Regards,
Markus

