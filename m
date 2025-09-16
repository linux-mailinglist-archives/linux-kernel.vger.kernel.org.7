Return-Path: <linux-kernel+bounces-818479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8315B5924B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC941B26B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D728C860;
	Tue, 16 Sep 2025 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Xk471+dk"
Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch [109.224.244.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD618DF9D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015264; cv=none; b=uxKlS6r2StmpxPl1dr/0yd2lZrcu+7rOuw7NohOPUVU6GcYq12Twn3joI+syF45HyZiNeq+lZSLuDiU8tv58YWOw5KNND5mvIoDwvy6RtzFDfJiE5NCf2nHnyNl1PvVsjHK2qhDtErXJMln3KfzDDgI9mCBn5P6wRZBdOqLEYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015264; c=relaxed/simple;
	bh=jE9at7fuwyQViSp34l5f0xdOjpqR5lphLXmvDy1XnpU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NLwHwIkYKSOKM24oC4j2oGozjdW6iRdb+GuTzk8PMfu2TENbkhJD7VsVtwy2hotjO1zysOsRMY0bgOMQOpvIMkeW07xxDOj45dstRlgg+C9LuYM5XlwOpN0P/Du1TG+YiHynTnjDsp19WV+uDnp3RCtrG8wHyVR4MJOoTmhyfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Xk471+dk; arc=none smtp.client-ip=109.224.244.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758014820; x=1758274020;
	bh=jE9at7fuwyQViSp34l5f0xdOjpqR5lphLXmvDy1XnpU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Xk471+dknsaV3IrIpCQ+oUypn/h28CAR1urerOWgKXW0ZqixFwWpU6VYypLIZt4xl
	 aj54QAYFOGG2t2jyvl08E0NLbw6QRBQnDhQH46K/GabPausJkASZs10pmiddLN/Dgp
	 yJOQMw/N50rS+XaBvWMnQB1q0Ho8cbcKRe0NV0VCEFldt0GcoPqb+W3FKOHR/2swna
	 tucTktUNsDs5O9wC9/Ypt2sFdMMT8I+92KuhrAiqTYNK3XWa0+b20SPExO6NbSteZo
	 TUgVWsa8KiXIys4KWJZBzoSwuKXmZsx7f2j+OnJf+SHMaq5sQiVAae4hPb/LFmmVWg
	 L33E1jzqtJVIw==
Date: Tue, 16 Sep 2025 09:26:56 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "??\"ceo@teo-en-ming-corp.com\"" <ceo@teo-en-ming-corp.com>
Subject: Linux Kernel 6.18 To Allow Rust And C Code To Use The Same Memory Model
Message-ID: <1EX43nkFgMTiy2Fa-F_e5d02guQlasaamaw-EbFaIkjKttQDbGx6GwiC3F61hKcLMNxenrgBxsYpOsKYc-a6BN70bi66zpiuyY-BI9K40cQ=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: e64140dd1ca7f9d151d5b7cf3cd0b364e608992f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Linux Kernel 6.18 To Allow Rust And C Code To Use The Same Memory =
Model

Good day from Singapore,

Here=E2=80=99s a news article I=E2=80=99d like to share.

Article: Linux Kernel 6.18 To Allow Rust And C Code To Use The Same Memory =
Model
Link: https://www.phoronix.com/news/Rust-Atomic-LKMM-Linux-6.18
Date of article: 15 Sep 2025

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
GIMP =3D Government-Induced Medical Problems
16 Sep 2025 Tuesday 5.26 PM Singapore Time






