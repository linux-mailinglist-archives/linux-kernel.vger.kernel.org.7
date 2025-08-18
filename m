Return-Path: <linux-kernel+bounces-774489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F0DB2B2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108581B228DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59E2749E0;
	Mon, 18 Aug 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="QoR529ja"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EC27CCE2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550148; cv=none; b=Z0An/K7Ew3MFLDYnvv598JpFCIjci7N5pezbWlvN7emsjT7disvbBsDYTsE00tRMV4jfz9L3q+yrlG2qFQb5BO+0ADt9PrP1iHq/fBCGBZSUVs5oPLAd97POLDS8l8iR7P63wBzur97/A/4w+xxDQunPzkXT6isAtUhJKOGmYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550148; c=relaxed/simple;
	bh=vVEo6kZb63DLaAYkOac+NkFRMnu2eeTeYkx3Rhj9H/c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=o1sDR1yRkfKY3XY9Q6PGHQ6I2rXPNpUOX4cZkcw9xjLNheARulki5zv4f3InC/fZriaF4PZXyxYhiNR44fYHOhcvXVr+zEVdwr27u2zvQr7g+oUcKTwpvOesJlBT2vTj/ucOwAdATs1Hw1FKCcdTs8aMOQxfno3z95zIi/m2PCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=QoR529ja; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755550140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByNT5QgUCDMMaAGJVbx79L00vBRPCMUQu0+uv6XCpzM=;
	b=QoR529jaPqvL6O3cMXGkjzv6jK29vWphwfTy0I0w3aVwBQt22E0Tm0v0vrTHjX5XQSw2kR
	+P5fqG6y/3FZ7GsiQtIGhmQlJyc5YA77rh3eSfOunxMi4Pc8owbe56z4BBUwb2n/i0hfSn
	v2JzPcZXUMHoNe7Tqz4gSgggb0Xs3f++FIj2J56x/ifbXB76xIvFkKbL17paawt2/mTK6S
	YSsU18tnzZyU4VCZ8Ba2Ndju41HaXB0/WjkHoantOiP27Q11vzPRIzf+w4PESmXSJWNhHm
	nsvthBu4BLSQXTjliGmm96ngTXVZJjoqkdmJhsqJvumiaBWyzPw1OCheD6u5tg==
Content-Type: multipart/signed;
 boundary=74404bb997a85f20169c389c59a45f42fa781e52e1caa9a2b257d66156fa;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 18 Aug 2025 22:48:48 +0200
Message-Id: <DC5UKZ9F6CQZ.2NDFY4S322T2G@cknow.org>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Diederik de Haas" <didi.debian@cknow.org>
Subject: Re: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Keith Busch" <kbusch@kernel.org>
References: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
 <aKCFjzai3Y0RcGHP@kbusch-mbp> <DC3WVB8IOMNV.14F1RIJHNO33Q@cknow.org>
 <aKN30RVeM3p5NJm1@kbusch-mbp>
In-Reply-To: <aKN30RVeM3p5NJm1@kbusch-mbp>
X-Migadu-Flow: FLOW_OUT

--74404bb997a85f20169c389c59a45f42fa781e52e1caa9a2b257d66156fa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

First of all: thanks for taking the time to answer my questions :)

On Mon Aug 18, 2025 at 8:58 PM CEST, Keith Busch wrote:
> On Sat, Aug 16, 2025 at 04:11:00PM +0200, Diederik de Haas wrote:
>> On Sat Aug 16, 2025 at 3:20 PM CEST, Keith Busch wrote:
>>=20
>> > If you want to see what the driver is reacting to, you can check the
>> > subnqn from command line:
>> >
>> >   # nvme id-ctrl /dev/nvme0 | grep subnqn
>> >
>> > It'll probably be all zeros. The field has been required by spec, but
>> > the driver tolerates ones that don't implement it.
>>=20
>> root@nanopi-r5s:~# nvme id-ctrl /dev/nvme0 | grep subnqn
>> subnqn    :
>>=20
>> So it seems to be just empty?
>
> They, it's interpreted as a string. All 0's would be an empty string.

Ah yes, makes sense.

>> The other kernel warning is this:
>>=20
>>   nvme nvme0: using unchecked data buffer
>>=20
>> The SUBNQN message appears every time, this one appears often, but not
>> always.
>
> That one means you've sent a user space passthrough command to a device
> that doesn't support SGL DMA. Without that, the nvme protocol uses
> implicitly sized DMA that the driver can't be sure is accurate. The user
> could theoretically provide a short buffer that can corrupt memory if
> done by accident, or be used as an attack vector if done by malicious
> software.
>
> This is also not something to worry about unless you run malicious or
> buggy software.

I would be surprised if I was running malicious software, but pretty
much all software has bugs, so that's ofc possible.
(I run Debian Testing or Unstable on pretty much all my devices)

I thought it was a HW problem as the problem seemed to disappear from my
PC when I removed the NVMe drive from it. And when put in my NanoPi R5S
it appeared again on that device.
Seemed, as I just found out it happened on my PC as well (with Samsung=20
960 PRO 1TB) this boot (but not the 20 boots prior).

Uninstalled the 3 programs from R5S that showed up the most around the
warning message and it's still there.=20
Would 'dyndbg' be helpful to determine what program is buggy?
=20
>> When researching this/these issues, I discovered the nvme-cli package
>> (with the nvme command) and via its manpage I found this command:
>>=20
>>   nvme get-feature /dev/nvme0 -f 3
>>=20
>> I didn't even know NVMe's had namespaces, but this didn't look good:
>>=20
>>   The namespace or the format of that namespace is invalid(0x200b)
>>=20
>> ... without actually understanding what it means and/or what its
>> consequences are. It could be harmless and/or normal though.
>
> The feature you're requesting is the LBA range, which is namespace
> scoped. You need to specify a namespace id, either by opening the
> namespace's block device (/dev/nvme0n1) instead of the admin handle
> (/dev/nvme0), or you can manually specify the namespace with paramters
> "--namespace-id=3D1" or just "-n1".

Adding "-n1" does show normal (AFAICT) output. It's all zeros though.
And now the error message makes sense too :-)
The nvme-cli man page could/should have a better (ie working) example,
but that's not a kernel problem.

Thanks for your help and reassurances :-)

Cheers,
  Diederik

--74404bb997a85f20169c389c59a45f42fa781e52e1caa9a2b257d66156fa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKORtAAKCRDXblvOeH7b
bpB0AQDnJ4HcRvflUUhFeXsj+tfNwP2JOCXKBs0eHuFJ03qZiAEAisV8mhu5Uwfo
IDyywKOQTyFNwS+aKWk3T5OKt61hKg0=
=4lmg
-----END PGP SIGNATURE-----

--74404bb997a85f20169c389c59a45f42fa781e52e1caa9a2b257d66156fa--

