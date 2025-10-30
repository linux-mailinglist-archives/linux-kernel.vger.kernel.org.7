Return-Path: <linux-kernel+bounces-878424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A40C20935
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFA214EE148
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD2258EC3;
	Thu, 30 Oct 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="JAeVHA6X"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E81990A7;
	Thu, 30 Oct 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834081; cv=none; b=MkaBSAl4e2eaUuX6xtunF1/OthUrgXiYiKt1NAnmBi8i+7u6WYt7FhB7lgd+f/OC2rjUeflKouNImmuRLHxHdVfSbTrAKv/b/uwt6mT6Ws61T910cAFpk2cH8WO1P/DSRc7pi1Z564kuyzugTDuYJkHI/BusPQo5ffKaA+hBwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834081; c=relaxed/simple;
	bh=cpWP1PDpmQC8mrIhQknuZq+cukReClKurwt6mtHnFZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdjM4dWanfTlfrt9zzSj1r6pnE82VD2zYVEmosgOWnGzUWyG1Y06rXjGa/aHqIhup+/h+CJQV8HfzNDHtdfGba7KBvEAVk/iU1WOZ6TsThnuiRSh60WenPaVQbuVXWfFlBK/MXTZmhFgzQkKgsJGtL3ZyQnuVMj2b87emnwJKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=JAeVHA6X; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761834077; x=1762438877; i=deller@gmx.de;
	bh=52j1php9L8cIvUxewIkUMNjUXJ3OzivZO+CGo1ph/+U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JAeVHA6XNxuE6xrXMEEz1muBFmwstNNkOmJQyrEgEw1qGmYqcWCRK6t+TNByvihI
	 tFUu6IOw7yKV59ic+PerJYDuNrHIXiA8aaehL6oXaFKFVfIHg+iMsaWXdV6/PyTtp
	 1izZGZMs7fcIi6K8lX5phzlME7inMXgo2iJCzIg084DHlNzHrz316i5XvcIu/Xel0
	 haekdGFLtjuIB4utUEQwtC+L4Lslrabp5eIzUKV0oBwkne+iZGqnd0ayHxxGH9sCA
	 yOvQmxWE5l2Ffooo5ImxHyxeuJJLHwND/9K/HNYwPxGeXFa/fQUsWwKmSp0vbGQvD
	 IM7t0O9sZjK4e2l8Qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49h5-1wDpee0ARl-014wBK; Thu, 30
 Oct 2025 15:21:17 +0100
Message-ID: <4ee64e89-1e67-42b5-96e0-e79375c6f383@gmx.de>
Date: Thu, 30 Oct 2025 15:21:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc/entry: fix space adjustment on interruption
To: Sven Schnelle <svens@stackframe.org>
Cc: John David Anglin <dave.anglin@bell.net>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20251030075605.61854-1-svens@stackframe.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251030075605.61854-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lqWZWon2HnLT3wViCyxKnvR9do21m/SY/OeUQTpkDdKw9KhNeb+
 zHGO7Vj5KUyP2NBW8uSJtrKgKJ2Zj+9LoJCol/LpSv1kLr10GzaQT3wyLfh7vTqjj6XHw2+
 wBh77QtlsJoFSVr04k1q/9Xgag9eMlEMr4SwDNmiumFs3lMXCNCUil3YzuMsx2cVS1N+H/o
 Gp6kqkSOo/SCy+UV3/Mlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mLbYAWbSOWQ=;/D/DsEJwsgYtpUgv7qaO0FNMLL6
 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
 cF9fQ==

On 10/30/25 08:56, Sven Schnelle wrote:
> In wide mode, the IASQ contain the upper part of the GVA
> during interruption. This needs to be reversed before
> the space is used - otherwise it contains parts of IAOQ.
> See Page 2-13 "Processing Resources / Interruption Instruction
> Address Queues" in the Parisc 2.0 Architecture Manual page 2-13
> for an explanation.
>=20
> The IAOQ/IASQ space_adjust was skipped for other interruptions
> than itlb misses. However, the code in handle_interruption()
> checks whether iasq[0] contains a valid space. Due to the not
> masked out bits this match failed and the process was killed.
>=20
> Also add space_adjust for IAOQ1/IASQ1 so ptregs contains sane values.
>=20
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   arch/parisc/kernel/entry.S | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)

applied.

Thanks!
Helge

