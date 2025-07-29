Return-Path: <linux-kernel+bounces-748767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B4B145D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EB316B858
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515521F8753;
	Tue, 29 Jul 2025 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rVeF7vFo"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCC1F4162
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753752794; cv=none; b=MqtUGsD3wAQhYYqZ53opfm4vBz5S2VXi5rUDUsQRhToH7yo/csZAO09irkrYHR1tI1xDCXVXGvfwdyjH8Ij1AESRhGiRJqAXG/0jHX3CVoRMFb2RxCDZvxubucRrnM9ZB2+hUrOD/c2RNWlCl7HGJ7ra8lCXp3gDqcKso5+XMG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753752794; c=relaxed/simple;
	bh=/HGRnYEQGLZaT3xJ+wFvEsemHMJyMzBhBEQdzubwELs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RtN/d31J3Xjyeb9WbrfOtTigsddE0ylW2VyyeYWfwnilalIssy9v080XSQroep3Ex56B1fu7gU3IkEf9pchhyTrWWyL+r0HStnXnGIqTYYL0jOVD7qn13RuGri+UF5oK1M6C5IIzgoLJ2PL9PCmyzoIrwAGpEACpwxkccf1fXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rVeF7vFo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56T1X5bD4858423, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753752785; bh=gdWasU/IdPl8ekcovteXs63yrb725xyVBg7HglMYh28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rVeF7vFoTxG3NldToXT14GRHdZdQbkTmUCttieSgiY/D+Q64bFfFApr6C6EcoHp4h
	 uKV0qQW5kFKvEm4uH/9Uvh+6Ur3VaQS4i8i5omiLr0xPxUCxtmv1r65M8RiEqi/1aH
	 z9x1oR3hkaqhEOHDzz4YtNjfgzTaGdLR/+ut/ivzMrUVAD+1+/2vsg+eFiVDUMi+f+
	 mwWHhIHMktqnEx/ghqd0wDkoDUEPk53n2OfXutbIm1k/czC2BLTTFS1qgpUoRaUqpo
	 gAyzYP944EhkQNOb38OcBSY4ljPLFawd956rpYdHIV02N/1r64IdEYRtGhnesjUNac
	 N+l0tOvN99EsA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56T1X5bD4858423
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:33:05 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 09:33:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 29 Jul 2025 09:33:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Tue, 29 Jul 2025 09:33:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mande Imran Ahmed <immu.ahmed1905@gmail.com>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>,
        Bernie Huang <phhuang@realtek.com>,
        Damon Chen
	<damon.chen@realtek.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net:realtek:use sysfs_emit() instead of scnprintf() for sysfs consistency
Thread-Topic: [PATCH v2] net:realtek:use sysfs_emit() instead of scnprintf()
 for sysfs consistency
Thread-Index: AQHb/7KNKr1y0kye70a0T4vlsYw6t7RIT+LA
Date: Tue, 29 Jul 2025 01:33:05 +0000
Message-ID: <532f36a2a3524f2aac67b95935387302@realtek.com>
References: <a28456f5b8d2477785493c6081f24401@realtek.com>
 <20250728112638.39412-1-immu.ahmed1905@gmail.com>
In-Reply-To: <20250728112638.39412-1-immu.ahmed1905@gmail.com>
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

Mande Imran Ahmed <immu.ahmed1905@gmail.com> wrote:
> Update the Realtek rtw89 wireless driver to replace scnprintf() with
> sysfs_emit() for formatting sysfs attribute output, in line with the
> recommendations from Documentation/filesystems/sysfs.rst.

As mentioned in v1. This is debugfs, not sysfs. The assumption of PAGE_SIZE
buffer can't be guaranteed. More, this driver must not depend on sysfs.

NACK. Please do not try to respin patch by v3 I'll ignore it.

>=20
> This change enhances the safety and correctness of sysfs handling,
> promotes consistency throughout the kernel, and aids long-term
> maintainability.
>=20
> Functionality verified using ping, iperf, and connection tests to ensure
> stability after the changes.
>=20
> Changes since v1:
> - Replaced sysfs_emit() with sysfs_emit_at()
> - Removed unused function parameters.
>=20
> Signed-off-by: Mande Imran Ahmed <immu.ahmed1905@gmail.com>

[...]


>=20
> -       p +=3D sysfs_emit(p, "ChainA offset: %d dBm\n", offset_patha);
> -       p +=3D sysfs_emit(p, "ChainB offset: %d dBm\n", offset_pathb);

By the way, the original driver never uses sysfs_emit().=20

> +       len =3D sysfs_emit(buf, "ChainA offset: %d dBm\n", offset_patha);
> +       len +=3D sysfs_emit_at(buf, len, "ChainB offset: %d dBm\n", offse=
t_pathb);

[...]


