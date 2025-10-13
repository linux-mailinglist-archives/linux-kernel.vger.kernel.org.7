Return-Path: <linux-kernel+bounces-850231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBE1BD24EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07DB3B7E59
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98B2FD7D3;
	Mon, 13 Oct 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b="KWZmnklH"
Received: from mail3.ecloud.global (mail3.ecloud.global [135.181.139.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E22E7196
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=135.181.139.185
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347985; cv=pass; b=cPlDwqMWddIpKnOB/Eu0UsNX5g7xxDXmFQ8/xSeZ+Jda4B9oBUjqYm40GqMyj4aSdsHICo9Bi54G7NKB5vqocPxkDd/P/C7guXARHXRhpCAzFiRy8Gq2qn/wmBi9rSoZh6GFJ1utYNzV0oMGiS/y9BHrt43irhsqU3Nfwxk2BPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347985; c=relaxed/simple;
	bh=7e4oPSbyT6o1XKtkgDqQchHA30cNRFihW0o+KCSVfM0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=FKN5TGM99d2/ZYL+1YCm6gOX80+NxlRNYSVB7mMSJQtcXIT0+UxbBQ4ohwGpx30fHx0LsR2gCKh76AntJoUK2YW6Xi+T2Nznul76f5DguIURlxVnv0KQrPqFoz/5oDk0ykkWfXxy1NNmDWXN7o9gLoXi1LCwN92uf44OwULWaxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io; spf=pass smtp.mailfrom=murena.io; dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b=KWZmnklH; arc=pass smtp.client-ip=135.181.139.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murena.io
Received: from authenticated-user (mail3.ecloud.global [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail3.ecloud.global (Postfix) with ESMTPSA id 3988688A3EC;
	Mon, 13 Oct 2025 09:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail3;
	t=1760347320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7e4oPSbyT6o1XKtkgDqQchHA30cNRFihW0o+KCSVfM0=;
	b=KWZmnklHrgb53JpNCiU46XtaJg4zhgannNk2NRAkhanaIXcUrRdg9OCwx5WFf20Un+jGUn
	XwOFcrLl1QQF/qN+mwIy58sIwn1dhR8+jFcSVrP6CDRnCtugphqkfaDfNsGXyqJDb8+yKP
	0TNR9KUDxj7vKZ3J6jgAsoE0ffjkPA0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
	s=mail3; t=1760347320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7e4oPSbyT6o1XKtkgDqQchHA30cNRFihW0o+KCSVfM0=;
	b=BrzcjlUU3iNXAcHY+ElA6LJFefQR08+H1hXRQJRcng3/dP2w6jWjScGktlBbof8nhH5oFC
	0s2lgzMiVKywXlXNrUBwHgHnV1aXr1NlW//J1Z1SskROKnaKQSckQitmms4U3GQhD/vrNa
	vkS+UDF0drWoxNoG8EkZLtWOnWeMgYU=
ARC-Authentication-Results: i=1;
	mail3.ecloud.global;
	auth=pass smtp.mailfrom=craftfever@murena.io
ARC-Seal: i=1; s=mail3; d=murena.io; t=1760347320; a=rsa-sha256; cv=none;
	b=PwxP0AJIGQ/zfae6OZPyxKRCEAvpNf8EfcnkrLjQIBKFO2tS2RnKuNHcH5drsPOS9Z1VhZ
	O7NVGyHPg8bPUnXFEb+uvNtlzDvXRUz/0yXFrSTpP5uJFD83/3kfXOcg9kbSZPUHwKwHjL
	I40Fy8Kl5ivXS/7kQUO8jMXV5qtZAzg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Oct 2025 09:22:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: craftfever@murena.io
Message-ID: <020cf8de6e773bb78ba7614ef250129f11a63781@murena.io>
TLS-Required: No
Subject: [Regerssion] [KSM] KSM CPU overhead in 6.16+ kernel compared to
 <=6.15 versions ("folio_walk_start" kernel object overhead)
To: akpm@linux-foundation.org, david@redhat.com, xu.xin16@zte.com.cn,
 chengming.zhou@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev

I've posted about that problem already on bigzilla (#220599), but maintai=
ners asked to post issues on maillist.
The problem with freezes during KSM page scanning with certain processes =
like Chromium with huge virtual memory size amount was fized in 6.17.1 co=
mpared to 6.16.x/6.17, but problem with huge CPU overhead is present ther=
e. Compared to Linux <=3D6.15, where the overhead is much lighter anad th=
ere no much CPU consuming during KSM scanning, there is "folio_walk_start=
" kernel object is present (which I reviewed with "perf top" command) tha=
t is not present in versions <=3D6.15 during KSM work and which is in wor=
k starting from Linux 6.16. This method very resource-consuming compared =
to algorithm used in <=3D6.15 versions. Is there a kernel parameter to di=
sable it or it needs more optimization?

I'm using MemoryKSM setting in systemd in user@.service for KSM process m=
erging and it very light on <=3D6.15 ver., but CPU consuming on 6.16+ (6.=
17.1 without freezes) due to reasons said above.

