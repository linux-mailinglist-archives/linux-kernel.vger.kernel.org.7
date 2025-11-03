Return-Path: <linux-kernel+bounces-882274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18F5C2A0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0055F188FC27
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316641B7F4;
	Mon,  3 Nov 2025 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=sanganaka@siddh.me header.b="LLK6DNXU"
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9738D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762146342; cv=pass; b=MbSPwmJG8jepqVwUY+lhspvaO2Yn5VF9PSCSxdby2RmmSgkIoEIz4bBroEo0Q/ivugzIzFft9zWcsH+O+iiCv7nMk4hwFFro4AgaW62TKa+XmTN3IDZrbgJYeX+gFMG8csMU/UfHUeA3//U4j+TLhVPjtOrsGs1L0UWOUviLh0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762146342; c=relaxed/simple;
	bh=UuIkn7EWXGxLiAQbNA/3G4v1WKpNPE7gcCd65q3uyp0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SeCe2v8fLGFvZqDbmUSjhTYqcmuK98LvcZ/t5Q7AJ01+vvQcpnJQDEIwQOLrP5QYf29+MyciNkXEuZ0I5g3jct2Hllp5YP4f7N8jxWs2RLG7nlUdKWK3FZoI2zSGC8e/Hw/0cPXJwSP8CZlCatCOxNbler9pGx8vrFyMmapYyAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siddh.me; spf=pass smtp.mailfrom=siddh.me; dkim=pass (1024-bit key) header.d=siddh.me header.i=sanganaka@siddh.me header.b=LLK6DNXU; arc=pass smtp.client-ip=103.117.158.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siddh.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siddh.me
ARC-Seal: i=1; a=rsa-sha256; t=1762146318; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=cLtRgdmyVWgaYNxVr///y7GQgt5qvGrM+Ha++ghOq5D9FjdVsL7GQZZUh0JRVljuG0QYlQ5IAsZbOc0uU4FIcD7t7+hO6wfaqlBCAkzGgwRweqF+ESWrwd0WJoxVsECrR3TVElZx9Guqk/VUFuPxDoOByje698StFhUaUXBXQh8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1762146318; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UuIkn7EWXGxLiAQbNA/3G4v1WKpNPE7gcCd65q3uyp0=; 
	b=UwODotAHY5uaA6TjHDW3tOgfQ8EkbtM5C1e8ShUpyq+oXucV5iu7MoO6EdFLyL0RH5s8QknuNgUwZcW/Nl44RBgP7GSROCWx2wj7pgPqf6NNsNZiWNuND6B+UwC2t0HUqenPJoHhtFx03jRfds6XM7PgB/b3u2bpqRco/NZd7yk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=sanganaka@siddh.me;
	dmarc=pass header.from=<sanganaka@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762146318;
	s=zmail; d=siddh.me; i=sanganaka@siddh.me;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UuIkn7EWXGxLiAQbNA/3G4v1WKpNPE7gcCd65q3uyp0=;
	b=LLK6DNXUZPGeo3Gz/gLG0+mbRxVOu4visvjNgLUyJNGMzngaqU5snn93GcBW5e4Y
	T7gamwe0+ThWI+f1VsnlIqa3KQjYZ/XQUQm9TTPH1DdVQKVn8iH7eXufTXp0/NAtENt
	iBsjyL5MARcrj9FiXrOK/qgigzxbeZMQ3nSxxkos=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1762146285742831.872406016107; Mon, 3 Nov 2025 10:34:45 +0530 (IST)
Date: Mon, 03 Nov 2025 10:34:45 +0530
From: Siddh Raman Pant <sanganaka@siddh.me>
To: "pintu.ping" <pintu.ping@gmail.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
	"kernelnewbies" <kernelnewbies@nl.linux.org>,
	"kernelnewbies" <kernelnewbies@kernelnewbies.org>
Message-ID: <19a481a7843.53422ba121754.4867625372707455852@siddh.me>
In-Reply-To: <CAOuPNLh4R=H0BfQ4f13woGzc82jX9LGB+kxAGeGVkhwYqKcg4w@mail.gmail.com>
References: <CAOuPNLh4R=H0BfQ4f13woGzc82jX9LGB+kxAGeGVkhwYqKcg4w@mail.gmail.com>
Subject: =?UTF-8?Q?Re:=C2=A0Query:_Y2038_patch_series_for_3.18_Kernel?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Mon, 03 Nov 2025 09:57:18 +0530 =E0=A4=95=E0=A5=8B Pintu Kumar Agarwal =E0=
=A4=A8=E0=A5=87 =E0=A4=B2=E0=A4=BF=E0=A4=96=E0=A4=BE :
> We have an arm32 based embedded product which is based on the 3.18
> kernel and a simple busybox.
> We wanted to support the Y2038 issue on this older kernel.
> Is this feasible
> Do we have the Y2038 separate patches available for both kernel and users=
pace
> ?
> Or upgrading the kernel is the only option ?

Upgrading is a much much better option.

3.18 is extremely ancient and extremely insecure.

(Sending again as I didn't press "reply all")

Thanks,
Siddh

