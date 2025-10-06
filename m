Return-Path: <linux-kernel+bounces-842714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34291BBD605
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0841894E29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950CB25A34F;
	Mon,  6 Oct 2025 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="W4W8E3MD"
Received: from outbound.qs.icloud.com (p-east3-cluster2-host11-snip4-10.eps.apple.com [57.103.87.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF719FA8D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759740313; cv=none; b=SUiY8gZZsJmQeEa3uuNPCUGgQIs8wabZ+Jf9xonmLk9oPN5U/tArkA7rsB9KYNNgpHzTSN78fqWs8B3wlrL7o24ZftanFJ/mdUi1w+hOOHhEm2NVIS1L+q0ocH8g10ZIdLzUyFpIToq0+wTLoNjLL0M2WkMHZ1mNnuziTi9BNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759740313; c=relaxed/simple;
	bh=0y/tJlB/QNLH4JSDNiH1J3b9lD764Sm6vYuI9bPdIJk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=glqgfM1x7ko0Sb4Po2VNpyzyJl8O+fQ/mwJC9F//a03dpwckWmny2EE5p2wnpoyhoFxKUIfO4gSoZUp1EsVJEAZwzVlU0h/crvdWa/uvzTLN5GBeJRyHs96Z44wVUVE4ppVtKWbAoN4B1VMPo1vdr07Mnm3gwuyKsY7F8WqvwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=pass smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=W4W8E3MD; arc=none smtp.client-ip=57.103.87.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ljones.dev
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id D10771800146;
	Mon,  6 Oct 2025 08:45:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; s=sig1; bh=NmmJuRpnjEPHFy7rpKMyL+ir1ct/FIcWdYPmbJcFT1I=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=W4W8E3MDR+B0RW3BzZ72jAt2W8UJbELyEV8y3bPw0cm4H6HG6QBN9N12Hcg7KWK8AAIeJjg9L8sKDeuv7UA8ZfQF/QZ3tZtfTvXojf5BuVxnynYEze+IPgDYhg5i8xIKii3d4D1DzXblz4smE6/FfQ4nD8+ROgGmmZBMYEpryNePyWw6OVFf7N6GXOthyOky0dih6HgLwOUYYnOws5zfRkzSGVBSMsyOUYnlyx5I4A4hJCL/hQopbOwOTkWQMlh8bWt4WiI1I7V2US8fgBTXtFdUSag6pUaEyBT9wqnBzkYtn7BLVtw7M/I8WQ7MGalRhVhz8g+tRmvB+zcOJHNg+A==
mail-alias-created-date: 1566896761000
Received: from smtpclient.apple (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id A27EF180017A;
	Mon,  6 Oct 2025 08:45:03 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.33\))
Subject: Re: [PATCH] MAINTAINERS: add Denis Benato as maintainer for asus
 notebooks
From: luke@ljones.dev
In-Reply-To: <ebe38602-1832-391f-b043-cae0c10d7e30@linux.intel.com>
Date: Mon, 6 Oct 2025 10:44:51 +0200
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Denis Benato <benato.denis96@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7993E86-3805-4E93-A714-0D4A33FBA759@ljones.dev>
References: <20251003184949.1083030-1-benato.denis96@gmail.com>
 <46762a7e-e8cb-45fb-8d62-062915133463@kernel.org>
 <36720829-6ba3-4178-952c-4236622edfa2@kernel.org>
 <ebe38602-1832-391f-b043-cae0c10d7e30@linux.intel.com>
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Mailer: Apple Mail (2.3864.200.33)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDA2OSBTYWx0ZWRfX9Oc5lSQNey2f
 BEp9lPvBCGvD5GzEkVrIoNvhr6xSc2+o5GqBEA8If1HjVoGQgmJqu3NakWbh/ZpNYbCFhWyC3aV
 TTWMFr50uQMwJheImHd4QV3jWiK6v+c6h4SK67G/UCWXgFRqKoxRmIV0GlgsV+9syPbMdNHswA7
 p/bWTaRpDjumSv4FcSxMcr+iq5iit++4slFMhqUZRVISConi+j5OVoWqI+BMzv+9QQ/lc4O1Vb5
 Fef0Awx1p/dtpjmhewcrNwo0pf1XgtIVPXR9Fxx3rq//LddeUqAHo/sChez2xT8PparYEj5IM=
X-Proofpoint-GUID: gf0Yb-eDMZe3BkoZtf2d74Ns211qwgiq
X-Proofpoint-ORIG-GUID: gf0Yb-eDMZe3BkoZtf2d74Ns211qwgiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510060069



> On 6 Oct 2025, at 10:31, Ilpo J=C3=A4rvinen =
<ilpo.jarvinen@linux.intel.com> wrote:
>=20
> On Fri, 3 Oct 2025, Mario Limonciello (AMD) (kernel.org) wrote:
>> On 10/3/2025 1:58 PM, Hans de Goede wrote:
>>> On 3-Oct-25 8:49 PM, Denis Benato wrote:
>>>> Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI =
EXTRAS
>>>> DRIVERS" as suggested by Hans de Goede and Armin Wolf.
>>>>=20
>>>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
>>>> Link:
>>>> =
https://lore.kernel.org/all/8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com=

>>>=20
>>> Thanks, patch looks good to me:
>>>=20
>>> Reviewed-by: Hans de Goede <hansg@kernel.org>
>>>=20
>>> Regards,
>>>=20
>>> Hans
>>=20
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>=20
>> Luke,
>>=20
>> You are planning to step down from maintainer too, right?  Can you =
send a last
>> patch doing that too?  Or let Denis send one and Ack that?

I will eventually step down yes. Denis asked me to stay on for the =
moment.

>>=20
>>>=20
>>>=20
>>>=20
>>>> ---
>>>>  MAINTAINERS | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>=20
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 156fa8eefa69..81bcb934748d 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -3841,6 +3841,7 @@ F: drivers/hwmon/asus-ec-sensors.c
>>>>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>>>>  M: Corentin Chary <corentin.chary@gmail.com>
>>>>  M: Luke D. Jones <luke@ljones.dev>
>>>> +M: Denis Benato <benato.denis96@gmail.com>
>>>>  L: platform-driver-x86@vger.kernel.org
>>>>  S: Maintained
>>>>  W: https://asus-linux.org/
>=20
> Hi all,
>=20
> Unrelated to the patch itself, I'm more wondering if Corentin Chary=20
> <corentin.chary@gmail.com> is still around as I don't recall ever =
hearing=20
> anything from that address in any context. The latest email from that=20=

> address lore.kernel.org could find is from 2017.
>=20
> Maybe we should remove that address from the maintainers list?

I=E2=80=99d been wondering if that should be done. Though never was sure =
of the process or if that was okay.




