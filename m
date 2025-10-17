Return-Path: <linux-kernel+bounces-858517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0078BEB0BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D28F4052EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387A42FF649;
	Fri, 17 Oct 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QR/Xoy3w"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9942F7AA4;
	Fri, 17 Oct 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721294; cv=none; b=a6QH8q16TNm70bJbIRcGDdbKOdIu1GM8Lq1sOoILj1LFmL/qyOagMCo6O32DOY9bUmJlS5pkzah/JUrgyLL5zvguK1YWg2MJKbA13PTGlnI5LkMOgIgbnv9968RbrulIbifI4tw5tftg90J1b27/Hl+NaRLdvHp4PAwsiFO+6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721294; c=relaxed/simple;
	bh=mdf/klidMqoI6MzEnqB8TaUYWb/MP81BD0oAtwcWvpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtZw74HpDoTqTImPgQaZbUOdvLcfe47O/S4PutkN5ROD5MCjqivSsYqs5Al5v91VTzf+bhAF0syFOG0k47JoJu8n7zO8iIdtKS/yP96eDMc8j1z/R39ORolhA3g16bQGplGnHVxkvOmuJeGhbNNBN4nuDSnZp5+/o8xPJBG+85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QR/Xoy3w; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760721286; x=1761326086; i=w_armin@gmx.de;
	bh=NCiKFUjTLIOC22GPGQAq7JHlZu1FbnMKDsPhavOTMfQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QR/Xoy3wNyF1MzH3jDDoYln8P+mZxb+HxNtinXNZIcWvLGv9vIAu3SpWzJ1wDqAu
	 ebfckNCdEgE7W/WDYlRMFx/ylsR9mWhNfl/t+voB6b04zx37OJ6Y/wBjXvDXS/bLD
	 cgyKtXLnPWR0yjCqeyjBqe06goIVgjA+Cids0YYR1USiwXqOKgslieH6R+Fj6zlrE
	 jMJDZu/ddTo3QD2OJOi9OVeD+91ERorPBZz/Lgk1lutuMC+AqPPWthLcvQhWvMiX9
	 fCOHxtIXoW0ocuwYdS/zktc687Rr81wUPxgH9w3sbpSr51k9YoLtvgBIWkEgybx6y
	 uxelLlTZ9+Izd3eyXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ81-1ugGZc3K0z-00KbNB; Fri, 17
 Oct 2025 19:14:45 +0200
Message-ID: <41a10635-09bd-41e8-a21a-9a19376b17c9@gmx.de>
Date: Fri, 17 Oct 2025 19:14:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] platform/x86: acer-wmi: Add fan control support
To: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>, jlee@suse.com,
 basak.sb2006@gmail.com, rayanmargham4@gmail.com
Cc: kuurtb@gmail.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251016180008.465593-1-W_Armin@gmx.de>
 <12762215.O9o76ZdvQC@cacher>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <12762215.O9o76ZdvQC@cacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TGpaB6esbq9Iduq9H2LkTYNn0BVkttZfchQjEFc5RKcmnpNr9jh
 vRIiEiMPhm/p+P6L4L5RHxy0/XFzevk4HYWuL0+GxbSNlZDXvHWRXuti9kSzQUww2uOk+Hh
 U9Ec+HyOGLVB5gLDFoVFnf8TJQ1PZqr2/EfTuRpEJCuXA+KErP82syFthX834XlC7dOToc6
 Y2Xmnhk0fvFD4q9BisnSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y2uZ6IoOocs=;5Sb6cm2udCyf7oXkC/d1fL9UFWz
 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
 yx8QTYhqUZg5nGUMNAw4GP5LvlollsaA/B0=

Am 17.10.25 um 16:42 schrieb Fa-Iz Faadhillah Ibrahim:

> On Friday, October 17, 2025 1:00=E2=80=AFAM Armin Wolf wrote:
>> This patch series aims to add fan control support to the acer-wmi
>> driver. The patches are compile-tested only and need to be tested
>> on real hardware to verify that they actually work.
>>
>> I CCed three users who requested support for this feature. I would be
>> very happy if one of you could test those patches and report back.
>>
>> Changes since v3:
>> - fix error in WMID_gaming_set_fan_behavior()
>>
>> Changes since v2:
>> - get rid of nested bit masks
>>
>> Changes since v1:
>> - remove unnecessary blank line
>>
>> Changes since RFC v2:
>> - improve error handling when setting fan behavior
>> - Add Reviewed-by tags
>> - whitelist PHN16-72
>>
>> Changes since RFC v1:
>> - remove duplicate include and replace hwmon_pwm_mode with
>>    hwmon_pwm_enable in second patch
>>
>> Armin Wolf (4):
>>    platform/x86: acer-wmi: Fix setting of fan behavior
>>    platform/x86: acer-wmi: Add fan control support
>>    platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
>>    platform/x86: acer-wmi: Add support for PHN16-72
>>
>>   drivers/platform/x86/acer-wmi.c | 292 +++++++++++++++++++++++++++++--=
-
>>   1 file changed, 269 insertions(+), 23 deletions(-)
> Hello,
>
> I've tested your patch, had a weird thing where i need to reboot to wind=
ows
> first to make fan control works again, but it all works well now, both C=
PU and
> GPU fan control works just fine.
>
> Thanks,
> Fa-Iz Faadhillah Ibrahim

Good work, the reason for this fan control glitch could be that the faulty=
 version of the acpi-wmi
driver left the ACPI firmware interface in an invalid state.

Ilpo, what do you thing about this series?

Thanks,
Armin Wolf


