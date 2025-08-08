Return-Path: <linux-kernel+bounces-760323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62730B1E986
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD2A3BDEEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A673126C03;
	Fri,  8 Aug 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CvVs8Zf1"
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4235961
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661059; cv=none; b=RJnUCLvydnLV2WA3qnUcjLbE5B5+Y/uvoOeaR4JlE0Fv0ZOoVYJnpJzd+JB6BwaHUuRPqpD7b86wZb2R9aN0YzFHyI/yce7dfBF+MQ+MA5wUsPr+SD34zyJPpwqgySE6U/jV5H5B1GswAv/lPmWWNHtcs5zanNLYpZSqL9fnIRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661059; c=relaxed/simple;
	bh=eBlzYYEDKZ/bzHpdPUPduwb/0YYIgOgqFczneNMpEPg=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmEj9RJdJLudRYJNuIT3z/mlmN8IXR4OXu+tIUdEmaZuQqSUdfFj1tszglkxg6nqDwWJcJ/U3dAmhX/EKLr2Nu7GVdRJpCXhRvz8upOF/+bAVGDRnyoMI7c0GLseJmMOhydLAVCg8jSJfYcCW7ET8IrO/vgp0ztHyLQcjhOmXWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CvVs8Zf1; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1754661047; x=1754920247;
	bh=eBlzYYEDKZ/bzHpdPUPduwb/0YYIgOgqFczneNMpEPg=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CvVs8Zf1mJoqPSuny+QGAGtESMBnGlP9C+jSMxMI45aVpHwKaG+uxdO/3+MHodj0N
	 uBQ2iz0d3IlTJAuYkxr1oTlmgGJNvgsrijwuQBwBHUXoBIYHY3s+NzCyora5xmOtoS
	 Y/XniAYd3Siz/OwmJxXkGGzx/MNl5HGn5pQXzMA/Z2KE5aorOE1/zKRd5/Tf7YPVue
	 KUuwwYFhsJebQvAAS/kz44SLzQC8M6do3UcUV2MU2PJXUsh6uSf8wkZ/sGr0ID8/Pz
	 xsj01LcWY17gOAayODe7aoU4jHRYzLiFl2aFgHVopXIQlgKcnNHJ4wAvq1jV35q6zs
	 3YLOeVmzIMk+A==
Date: Fri, 08 Aug 2025 13:50:44 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>
From: "edmund.raile" <edmund.raile@proton.me>
Subject: Re: [GIT PULL] firewire updates for v6.17 kernel
Message-ID: <pTURxXSK4yF5-FlMBbpWLMW5JUC2s1BvSYdYGKBAgEOpI9z4RhnQsLrrRj7E2Iu02sOznG5ysKRVpXR4ZWFp-CSeSebIP1YGQl7gbFLGeEo=@proton.me>
In-Reply-To: <20250802054917.GA127374@workstation.local>
References: <20250802054917.GA127374@workstation.local>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: 32ba37d8ef6a000a2834e8cb5f0b03366b7e1299
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Mr. Sakamoto,
thank you for including me in the pull request, I am honored!

I tested the combination of this pull request and your fix patches [1]
on arch 6.16.0-1-mainline (based on "Linux 6.16" 038d61fd6422)
with TI XIO2213B and RME FireFace 800.

[1] https://lore.kernel.org/lkml/20250728015125.17825-1-o-takashi@sakamocch=
i.jp/

So far audio playback seems perfectly stable:
days with varying CPU load, compiles, even mprime.
Suspend also seems fine, even without first powering down / disconnecting
the FireFace.
Direct ALSA streaming or pipewire, no issues so far.

Tested-by: Edmund Raile (edmund.raile@proton.me)

Thank you for keeping FireWire alive and even developing it!

Kind regards,
Edmund Raile

