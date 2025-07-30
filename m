Return-Path: <linux-kernel+bounces-750182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A94DB1582B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25B456047F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B91D54E9;
	Wed, 30 Jul 2025 04:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cXuwrd13"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8417BED0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753851123; cv=none; b=Jyhn/RVbJ5uVaihlNwD3LKRU2OsX/8DG9QDulqOk7YkI6qmwrwscqeVE2Q6XP0mAqaFr1MrT83ZvtCivGpkACpXdCFAQBcej6WnhFHpmRadUznsq7KINrlTD4dE3HbD0WythytK87auTsPzi4FFOcjAuptTYrp1rVSA+aS8jIg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753851123; c=relaxed/simple;
	bh=rtGsdysxCxk0KFscxrMLUblgaMWv2B6vLht+Vhy6ZQE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=huam7W8qtKiI3zh6whAj4dmIZAhZJYjaLjzq+RLBdWDDzKVL8T3VxQ0k37425TYbVsABn6S5jDX9Suv227jV0+uZ58nU5spNtC2wLqGsgKwQHiYSb2n+mh5ULKlJcsE0bJSsdcahRFEcU7cCzUO1IFccnmb8NTCEY5oNHu5LBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=cXuwrd13; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1753851105; x=1754110305;
	bh=rtGsdysxCxk0KFscxrMLUblgaMWv2B6vLht+Vhy6ZQE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cXuwrd13R5H7efNc2StNvdyCNoVylfgvpfwbZ3qgBXRtk8b8siPAUa1iW+7XDLC2w
	 SNUFnfkLhdJUL9J18sjtwondzjOLjT8LME+n7Dy+naf8aZ32U5d8wbCH5LLrL8AevM
	 R+2rDxQ8nRWSj0uv2zAbSYe+7M8d8jLHDYvvtPH3oA+E4GAUHY/MNdqPSFNOTgRddf
	 hSWQ3Cm7dCMoJdd7gveuPTOMHcAZRobOt41szQK4FPOp+2ch4KHlsMoaEx2AEejF6P
	 aPMq2iGy/+441J/oxP7kz/N7z+wKnY91jp5IPKxR6s/VrbQqW9SvSik/FBjraBPDqq
	 8+Dji+/oDpT3w==
Date: Wed, 30 Jul 2025 04:51:39 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: =?utf-8?Q?Linux_Kernel_6.16_Officially_Released,_This_Is_What=E2=80=99s_New?=
Message-ID: <RozhySjz63vN_uwH3b1pEF8UUr_dlcd4NdmNM4fB4iY0e73gg2aVIFNk_vmPZ_YHmmsJCWVwgwyaHImtFgBZiRWbYf9rQFgkcizRCoqr2w0=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: c7449d93b47d8db0c79c1ab0e57360eabbd0f965
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Linux Kernel 6.16 Officially Released, This Is What=E2=80=99s New

Good day from Singapore,

Sharing newly released news article.

Article: Linux Kernel 6.16 Officially Released, This Is What=E2=80=99s New
Link: https://9to5linux.com/linux-kernel-6-16-officially-released-this-is-w=
hats-new
Date of article: 28 July 2025

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
GIMP =3D Government-Induced Medical Problems
30 July 2025 Wednesday






