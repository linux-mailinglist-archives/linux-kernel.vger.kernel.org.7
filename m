Return-Path: <linux-kernel+bounces-893814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9736C486DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF8F3BA1FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E722B2E5B36;
	Mon, 10 Nov 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MIMRP8mq"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4032E427C;
	Mon, 10 Nov 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797008; cv=none; b=k5c8223/pRtSoR9U9lfUu45rlc+LSCSgWxl+Ad8rZW08AgWIgL98Ll3iZNWyFXYl9UcQmPu3WIjyaCpcJrxoraUtoG5poZD2eVs3W30huv/noLn7gGIyDm9qVktKJhNqpCTojojZoT/fwQqqOhfk0V5+RLb0EGKRwlMocHGbpCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797008; c=relaxed/simple;
	bh=FUDdmVJsV4uGcU+5pjexgyBbWX3bnOosPPg/R1lZtlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7DEz1clncP3mN00R1R8wVOynwwvw0ttAl4LgZzEYhZoBcu3Z6mOG80h3pYdRluyddiZOpI82Xuwlem3f45b8I1XTb0kpqSdC2CVtYocfyu/8sXpUF7lXUl1IwX723ZShN+/siP1YI2kgcodGZ+lCj8te07a4usc3TWbh9paT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MIMRP8mq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762797003; x=1763401803; i=w_armin@gmx.de;
	bh=FUDdmVJsV4uGcU+5pjexgyBbWX3bnOosPPg/R1lZtlY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MIMRP8mqdVZCUo6KOVU56MrOUTQYjo6xwyMZAydoHThme+k/3j+6/bca3jxKFDWL
	 vZGsovxV882bkhoNOO+JF6QfJyBmzP7WxYZfNI/ovqhGdVLnplqIOnWxKB3+QSGoU
	 ThgIPlE5A6InWjMznZaWDWltjxmov2H751+4IJcRwjezse5T4z8AaxEwPhY5WNRI6
	 8inziWBrKhNg9CEnXYXjgABtaZtqgpw3x+F76nX2AEzbeFDC1PANbrtjYm6kBHGCz
	 4+9J/S1QYvXdsz0IlGIhXgJ3ZJ6ZCzRTX/fluCGaKe2GRQpJeJgIV0usOR+dAIKS7
	 Ku3CwtDyrP2fQVQYrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0Fxf-1w5xO82IJ5-016HE1; Mon, 10
 Nov 2025 18:50:03 +0100
Message-ID: <9c18d3d0-92ad-4b99-abe0-9e37e85767d8@gmx.de>
Date: Mon, 10 Nov 2025 18:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: msi-wmi-platform: Fix autoloading
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Antheas Kapenekakis <lkml@antheas.dev>
Cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20251110111253.16204-1-W_Armin@gmx.de>
 <CAGwozwHq45Bj4FgRyrmd4dvLkR_hUGB7wVDUdtttR13sJGHHyw@mail.gmail.com>
 <68328879-4052-2b0f-4cef-fe3fccd2c1c8@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <68328879-4052-2b0f-4cef-fe3fccd2c1c8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bjR4Phxy8rAJiiknR15jIl5edKsG3WH2tuqsnHddBwVMoGCwLFc
 fCw6oVoikFGlUSMNTxhNugu54Bn7VwR2IqzhMITE+iuG9Uo/g6pnaCQmyzAyCNaT2+bYjcA
 P4+pRT7PDoz6yMXLP6eP/D/thDzkujZ41lKotQSSO8f/CQcgKVfgNp6L3Ylo3bIadHKYtLw
 n0fo45tNyNDQvTeMj19rQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hQrtZEU++W8=;5n7AtkKzS5ORJ7/loIyDBzTn0n3
 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
 hDw7DIQfNEQXXqcElk/oGmdALE=

Am 10.11.25 um 18:14 schrieb Ilpo J=C3=A4rvinen:

> On Mon, 10 Nov 2025, Antheas Kapenekakis wrote:
>> On Mon, 10 Nov 2025 at 12:13, Armin Wolf <W_Armin@gmx.de> wrote:
>>> As already noted by Antheas Kapenekakis back in May, the
>>> msi-wmi-platform driver fails to automatically load on MSI Claw
>>> devices. Back then i suspected an issue with the device firmware,
>>> however i just found out that i made a silly mistake when specifying
>>> the GUID string of the driver, preventing the WMI driver core from
>>> matching it to its WMI device.
>>> Additionally i noticed that said GUID was copied from the Windows
>>> driver samples, meaning that it might be shared across different
>>> vendors. Because of this we have to prevent this driver from loading
>>> on non-MSI devices.
>>>
>>> Compile-tested only.
>> Works great. Module loads normally without intervention from userspace.
>>
>> I could not find an online reference for our discussion so I omit the c=
lose tag.
>>
>> Replying to the cover applies to all patches if my understanding is cor=
rect.
>>
>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>> Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
> Thanks, I've added these tags to the commits.
>
Thank you both for the quick reply :)

Thanks,
Armin Wolf


