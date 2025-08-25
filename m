Return-Path: <linux-kernel+bounces-784189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C108B337D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238073BA53F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F259291C21;
	Mon, 25 Aug 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Bf43Z7A+"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D2292917;
	Mon, 25 Aug 2025 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107044; cv=none; b=fzBp2xKkRGl0weh5rUHmG5EUCRvnMDGw7Z8yH0WXyepZP6ID/z/hiMo2xFe1aCUo5X26F5bYwolzrE7YynmTA7Z2KUDsGrqMN2hyjTEjWQqvHZvkGcfTA4A1oe+UHjvHJjI2vD8/nf4EPT3biJBDu+Hfn1c3ghcM7S4/6azBcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107044; c=relaxed/simple;
	bh=RrKkzMhwHqnnYMjEL02yHKYN21NRLd2hI5l31R+mIYs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QrGp0jGQSpoO9hCliUrwabK2dVzG6wXL9KHhkKZnGGfUnju7wjHV0g6siEv6okTvxubM/x7P7I3wuJFpdL/zJ31nWJ+rBnTKiu7BIhNChNgO+e+27SGUt6CuhvdmCt3q5pLOu3KMr42VB6S0+HuyU1zPWd5rQPfQPIAEU9jOOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Bf43Z7A+; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756107038; x=1756711838; i=markus.elfring@web.de;
	bh=x7b7KM6j1olmX7tk4Pi1MmXVIPo5kgG3MZLq5xyTLm4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bf43Z7A+G6ojwANsnOwGvMsuX6uIyh3jMjJWDa55cVBpY601EcRaFE5yTHlIPAO1
	 ITTylTFyLy+WljwwX5iyJ7rtDVxQO6VmizUjkCOT9sbI9c842CZOTRS+Qb3DJMJiF
	 zmAtwkW9YpclqFdgrDZOUzXO4emgaf2RgZQHkU3ykuE3VVvNiv++NR0GqjZgdmS+Z
	 WXpXkGI3+U2UW2z6OOqoUcxkWmrL5VHreU11GLF30nuIqG4Zsi9yJ+ic20WhMoY0i
	 C9IeGk4usw0vHKMeJW1Ek2xkRSZuZhC9hBIm4kpLBmrtYGNQyDgyIuxoE5Am1zrcu
	 gZSQukY3iefxiTbz+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Vsr-1uUwdb2wXR-0127ni; Mon, 25
 Aug 2025 09:30:38 +0200
Message-ID: <eb3e0445-39fa-4f4a-aeed-96eadc94657d@web.de>
Date: Mon, 25 Aug 2025 09:30:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtSRkNdIENob29zaW5nIOKAnHNlbWFudGljc+KAnSBiZXR0ZXIg?=
 =?UTF-8?Q?for_SmPL_script_parts=3F?=
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <574a6fa0-00a0-43c2-8e66-cc6443f5cfd4@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <574a6fa0-00a0-43c2-8e66-cc6443f5cfd4@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sbUIoRHwyzbe1P8FCbNYmE/R/rNOv01LsPWd08M73Kg9f/teBny
 kFyxD6qmbqCLkGlK8f4OciGgZ0SteyAGrkz86UEj3tI0z4ij5PF8OSUZqBfxt2wa1om5wBF
 zBw3PgJfVfz4/CdANXksyh6UvM1+Pj6jYoqQvTP0X9cSwwZDZVWrbZYF/ahUMWZFIQZbxHE
 +vSI4f6h1wEDXNm4FcfQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NGK5Ld/ho2c=;zDpl6giyDuvkyR5NakLjUaAa5PN
 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

> A bit of information is provided about special =E2=80=9Csemantics=E2=80=
=9D (also in the manual
> for the semantic patch language).

The usage of the semantic match functionality influences which default sem=
antics
should be applied for the evaluation of an SmPL rule.
I imagine that the corresponding data processing can become more interesti=
ng
when the needed semantics would actually be the opposite setting.

* Do you tend to look for the existence of selected implementation details
  more than that source code variants can occur on all executions paths
  according to evolving control flows?

* Would you expect to use the source code search parameter =E2=80=9Cexists=
=E2=80=9D more often
  then =E2=80=9Cforall=E2=80=9D?


Regards,
Markus

