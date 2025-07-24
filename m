Return-Path: <linux-kernel+bounces-743898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD7FB1051F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909F516591C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF99D274669;
	Thu, 24 Jul 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QW2Qa9gP"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDE238149
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347447; cv=none; b=FSY2rhJ06Z3HHOOecLXcCCM6gTHhCYAb9I7uxpUr1mdc1317mnAFFjrHYTo6I8Sx5BfZueDE8XkAvQ5Amm6Ga/Z/vbk260p4A+nrYUbX36gtDG3Xib6TROmpi87M7mW+dp1SZfNetq/rPlMFhCtk32z9ri6QUENJmW/b/GbT9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347447; c=relaxed/simple;
	bh=QcWILp4Z5jt+vGflrEuXR/ZENzCW6DcbFrpCHXiiczA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dMux7cfUlStlPUmDcAFJ3Cb5MBlXdhdLlH8VixiZfJFpcM+1UhTFTe5xvfwlb23tVLg58KKvUr7MSPwTsPOH9yEu/j+uz7OdAORKUKZujczQq3qWzXCpa8mtttr+Yw6uC1gCbMhtKvy5SSoIjz28E3ETIH/2PQ4cO48JW6X4ebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QW2Qa9gP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56O8vK9z9200661, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753347441; bh=QcWILp4Z5jt+vGflrEuXR/ZENzCW6DcbFrpCHXiiczA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QW2Qa9gPfz+vQwrWRVlpgYoSLdrd1ArxPOczDTfnBkoqGmWFyU8Wo1+xIwWWaDSIi
	 GNoXBlcSyneFwCfe9wllepjbmGDifvApRKiD3x1HikA2kwk4yBFL1HDXfWIzd5SykW
	 FaPf43glLoLcAVhlc+IwC9B3W3n3au2CrMKlYLR0rXGUe3Y+wrQzkrPXB9IWwYGLRG
	 fSZrWko7m/Ufx5xHy7vA+Tky5V7vjhq9ZOFn03uWiKHLLR4epU+/cLeljVurwrw9+x
	 VGyqR6tWLsC+GYzlx1qU3U+XRZJ1TYIjKnBq7NXrS9MEnlvh4nZTOvnB+RXMuqN9w1
	 fJuKsRU3xCcJw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56O8vK9z9200661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:57:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 16:57:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 24 Jul 2025 16:57:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Thu, 24 Jul 2025 16:57:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Mande Imran Ahmed
	<immu.ahmed1905@gmail.com>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>,
        Bernie Huang <phhuang@realtek.com>,
        Damon Chen
	<damon.chen@realtek.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net:realtek:use sysfs_emit() instead of scnprintf() for sysfs consistency
Thread-Topic: [PATCH] net:realtek:use sysfs_emit() instead of scnprintf() for
 sysfs consistency
Thread-Index: AQHb/F77hbotMQz0+kWksK3l7vm4l7RAbuyAgACIoGA=
Date: Thu, 24 Jul 2025 08:57:19 +0000
Message-ID: <f420a63d63334e5b97e7562ce5be0d5d@realtek.com>
References: <20250724055018.15878-1-immu.ahmed1905@gmail.com>
 <a28456f5b8d2477785493c6081f24401@realtek.com>
In-Reply-To: <a28456f5b8d2477785493c6081f24401@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Zong-Zhe Yang <kevin_yang@realtek.com> wrote:
> Mande Imran Ahmed <immu.ahmed1905@gmail.com> wrote:
> >
> > Update the Realtek rtw89 wireless driver to replace scnprintf() with
> > sysfs_emit() for formatting sysfs attribute output, in line with the re=
commendations from
> > Documentation/filesystems/sysfs.rst.

This is for sysfs, no? But this patch is related to debugfs, which buffer
size isn't PAGE_SIZE. Please refer to implementation of sysfs_emit().

So NACK.

> >
> > This change enhances the safety and correctness of sysfs handling, prom=
otes consistency
> > throughout the kernel, and aids long-term maintainability.
> >
> > Functionality verified using ping, iperf, and connection tests to ensur=
e stability after the
> > change.
> >
> > Signed-off-by: Mande Imran Ahmed <immu.ahmed1905@gmail.com>

[...]

>=20
> (1.) buffer might not just be allocated with PAGE_SIZE
> (2.) the pointer passed to leaf function might not point to the head of a=
llocated buffer
>=20
> Will the above cause some problems ?
>=20
> For (2.), maybe need to tweak them with sysfs_emit_at() instead of sysfs_=
emit(). !?

The assumption of buffer size in sysfs_emit() is PAGE_SIZE, but this is
totally wrong in rtw89 debugfs.



