Return-Path: <linux-kernel+bounces-729224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EE6B03390
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFCD3BA16B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586802E36E7;
	Mon, 14 Jul 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="GumDboUH"
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66C184
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752451528; cv=pass; b=oOgBOWwXb7Kvh3WaeGGdEmi3rEsysh+MuaQRMti9vT1y+pHIg3zOEljMVyQLwFP/50cK6mHTUhwEnEpizKY/rXJ9aGuqdm9udtXIBElt6sixp+qzZlqZrGyqcl6UMdMKt/I2+Kedt/xpxysbOGFVfB/vpfSjBUYuUbxi0OWqWMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752451528; c=relaxed/simple;
	bh=oyVaRut4FAEfUhD4YEWwvSHGtQCo0FrwoB/Rz8rlK4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ljbAEXWM/ZZhfs0aUe3CHSt1Rnif47G9/5gNqDCWg3oxxlrIgVJMCD8BchdeAKVRPOy+XgIqO48aHwyxP1ID3C3t5psIpxsylcuP+kzVzLTVNS0mxWuhGCRa3elJ6ypTnrhsdlKSIqO2JldewKRlDyqSULib1MKI/3QJCOchKv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=GumDboUH; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1752451508; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZeWnGQ+sl/JpsDcV6E7PdRa+4zMlRZnmUCJNz3FxQM3v4oAndbLfbe9ke9Hmm7qssrC8wXM2nF6zEIPZp2YZNOAJvXXBJiqPbzNOYRPNdbQoQgkRO8SjpAltq3sxDrQy3vcdohpJFzTsgVb06XHPynwz3pGmRc9VgDbGc7qM9JQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752451508; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oyVaRut4FAEfUhD4YEWwvSHGtQCo0FrwoB/Rz8rlK4c=; 
	b=YsUttEttI0R314edaRHwKY6Aqclsasl3BpdVWSifaOQ+jI/jmwe2AKBIQA7c7GjGDoo8qRwWPTe/uHkcvUtutWdcDnUZXjwynP4hZSeZqN05XrAedXVmA3AIKyNXADBGZuB7TAjuwiZb9OKerIwD0X9IfKfxNDVP79slI8NS8Ho=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752451508;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=oyVaRut4FAEfUhD4YEWwvSHGtQCo0FrwoB/Rz8rlK4c=;
	b=GumDboUHwBbQoS1/lksEgDwPc8nwK2ic/TtfRQvxeoHmImkWM5Ycd94BLn1eKrOA
	GIUn/C+YvuP0iM3G6BoJdWx22a8PLZVsUfdAF4D/aRZQdV7UXzayETqZjUtG3ZJLV2a
	Vb6n3rp64GVwC1IprGiIqVXC2vcUAIgDdGzFODRI=
Received: by mx.zohomail.com with SMTPS id 1752451505632151.41518657558117;
	Sun, 13 Jul 2025 17:05:05 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: ryasuoka@redhat.com
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	jfalempe@redhat.com,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	virtualization@lists.linux.dev
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
Date: Mon, 14 Jul 2025 03:04:56 +0300
Message-Id: <20250714000456.14-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250613132023.106946-1-ryasuoka@redhat.com>
References: <20250613132023.106946-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227cae78222e5608424e7d23a7a0000ee312201a42be3a6c8c301f2cc67bdd579d09386f1395f25bb:zu080112272569fa9f85039b91f1d6e4ad00009739d396ded1a8e780e7fc362b6b8e7de17c082c4128df7ac0:rf0801122cde5ec2bf4f8a7fcaa033275600007851220b8154e5f9651282473cb1276cc830cf9885e60d8a8ecbbc4b3e19:ZohoMail
X-ZohoMailClient: External

Are normal panics (i. e. not drm panics) still supposed to work with bochs?

If yes, then I want to point out that they, in fact, don't work since 2019.
I. e. panics are not shown in Qemu if:
1) bochs is used
2) we use "normal" panics (not drm panics)

I already reported this here: https://lore.kernel.org/regressions/197f290e30b.eaadc7bc7913.7315623184036672946@zohomail.com/T/#u ,
but nobody answered.

--
Askar Safin

