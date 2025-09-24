Return-Path: <linux-kernel+bounces-829984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD14B985FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6774A6B33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C079723AB8B;
	Wed, 24 Sep 2025 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="QzTbaZFZ"
Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8311C158DAC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695186; cv=none; b=LNS7TmTCp2pF+Q4YeF7/zhrIFHQ5BYrGjkOWKOEpMKfiw9DALo2G/fHaqBIErIicA2meBwDs0Vg0OXAzn8q+WYKuR0PwsrjPV7PFwRSMamvqVmfVEnvMNonfKVsH+NjVRUhceGRd2APvyu2BIqUr8ZHbZNlvvCh7lrVRu5vizB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695186; c=relaxed/simple;
	bh=XR91gSIF8yYJ5cE4+Q2CghSblnkU6VvRnTYF/fkodlI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bigSQGq2eKhdOPvM0z/c6kFRo5leV3gsBN/LfsbHsa6A+otPOv8D3XOnFnAPYnky/vNm7ilbU8lF2tcqZ852kMJUQgIjOiwHz+7scg/Moi2tywxLYl2AvPzjS2SYRtIng6CaoPitqAi/2P8cl45XW7Rkoj9q0F5fl6+2isVgviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=QzTbaZFZ; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758695176; x=1758954376;
	bh=XR91gSIF8yYJ5cE4+Q2CghSblnkU6VvRnTYF/fkodlI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QzTbaZFZtKbaC4nrn9eTtNgwLz+3fXVgmNm7k2racHNPx+sXksVzWhP2kmP73hGrB
	 qlf3JhSgh+5jP5Ho7Shnfl0HpzhPPQJRO1CKHLahWUp10pGp35jzoCo+GOfyAlYiGp
	 0uVJLBqKoixfMrXff5a5wKBIgx3Uy80gRdgeJuRCD1axQXVNFGvRQTblQIMHmb4pDe
	 o/geZL1debeHZIc1GSej5qyTCp6BwOjk+AK/UTiPYQAQTypIonjPG0ItIv0gldWXBR
	 0vgHcF3I1b7/oFLMcvrDW/skvTljtKyjlr3/vGsbH3XWPVA3n/JVhwN7KZhhhg45cr
	 MNVm+nSg8iAXA==
Date: Wed, 24 Sep 2025 06:26:08 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "??\"ceo@teo-en-ming-corp.com\"" <ceo@teo-en-ming-corp.com>
Subject: Multi-Kernel Architecture Proposed For The Linux Kernel
Message-ID: <k5mmH9tDmG_NISYPd0uMa7fNamg6orS3dQV3DuUpI1lBg-oiAe6VJDB4wjbbRXygUmK0JFTZ7EVSXxWdYldrs_s0OmVAyidCAg55zYrY6mE=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 0271ad7693063da623a80f8ab76d544eb22f323c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Multi-Kernel Architecture Proposed For The Linux Kernel

Good day from Singapore,

Here=E2=80=99s a news article I=E2=80=99d like to share.

Article: Multi-Kernel Architecture Proposed For The Linux Kernel
Link: https://www.phoronix.com/news/Linux-Multi-Kernel-Patches
Date of article: 21 Sep 2025

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
GIMP =3D Government-Induced Medical / Mental Problems
24 Sep 2025 Wednesday 2.25 PM Singapore Time




