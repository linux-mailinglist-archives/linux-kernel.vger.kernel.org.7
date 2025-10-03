Return-Path: <linux-kernel+bounces-841375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBDBB720E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C625219E0C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E672920A5C4;
	Fri,  3 Oct 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hjl/rgOY"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FA1FDE01
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500732; cv=none; b=SApVPqWP4HGkFMSYSqZ4jP+QDXwFPS0OkYW3Nx1bW/fJdqqztYWnsR5Cxqalz1qxZ4huDuHPOghprYZ4nEDXIA1H5maD4VkUvtL62ezKMMvgIJW3c8yUSerc5NcDTSZAW8MWArkFCMq7vljf1vkeGz5zcIG0ImyQYc61QeO7U/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500732; c=relaxed/simple;
	bh=fZ+fkMmXICuEbYBfgxa8doOw0lqrB+P5SyvQIrUOsH4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ays64qvunysbyoEFKaYHTatuJ35+A/aHIjrC4FUapPQOc58uEBEAXbI5xQ0Kud3U3odwlANowtkDCkNpADLPgtbxQF1DQvT0KHEZYB9ZEPYtjNv4SYyURdthwWjXBvwb+tsY+op+UOGcZzSTIlLRtKVjQLw94MPLLmzB0/g9qrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hjl/rgOY; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4C56E406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1759500729; bh=fZ+fkMmXICuEbYBfgxa8doOw0lqrB+P5SyvQIrUOsH4=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=hjl/rgOYjycJK3JjLmftVkbfUKWSAmt23L4UaOxj/Yso4baLCvrfboHcwx6Qvj53l
	 m7SQMXjWgEWImQM36slx1DDj68aba4ztuz+FDkg0xvGXEn87fNnKXwFBcdYQi5uj1J
	 MBQuOXMzTdp8RxapngwJAK0vBF0QVCOvW/jyDnbt4meeK46N34QDCYowzO/lP+E9rj
	 hPTeCXB4Aw80UocGm6Z6LP6ofwEB5Fj4Az6FNoOUobvLiDpNVdC4jxwRJhEuRJ+XQC
	 Q6KSvl/y/rDMtNdnPeTeCVew1FuugB1OYJgbHIENPGb9xkT7+wAYpE4eT+fTDp1Tgj
	 j8R4F4HcULilg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4C56E406FA;
	Fri,  3 Oct 2025 14:12:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>,
 linux-kernel@vger.kernel.org
Subject: Re: Issue in Kernel docs / Admin Guide / SysRq
In-Reply-To: <7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com>
References: <7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com>
Date: Fri, 03 Oct 2025 08:12:04 -0600
Message-ID: <87cy74rs5n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anselm Sch=C3=BCler <mail@anselmschueler.com> writes:

> I=E2=80=99m writing here because I don=E2=80=99t know where to find Kerne=
l docs=20
> (https://docs.kernel.org/) sources and submit patches.

They are in the Documentation/ directory of the kernel sourc.e

Thanks,

jon

