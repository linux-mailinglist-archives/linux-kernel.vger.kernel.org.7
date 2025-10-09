Return-Path: <linux-kernel+bounces-846124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDC7BC719B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D26724E4568
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9791F3F9FB;
	Thu,  9 Oct 2025 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Mga/hAds"
Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6666534BA2C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973013; cv=none; b=bSWk+9IuVNCHFn+iGgPBTHrLWoLAWAQLID0FquBzbSCJ56CeGa7CmhjaYCPpuIGzUuiBfZGR99kkVG0H3K7QP9SzU9TMcGJDDSljASMjDzeH4m6JV76q3SxjYyQaHqoAAHK91BO847+KHoAQnBvNNdy7HARG9wIbJEvQH3g21PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973013; c=relaxed/simple;
	bh=MjObFjLaUqfDGj6Zdjth6QHgRthEnafnA2lPXMpbxSE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mqH2saetrsEqMvrN1pZVznFJpshZZWzw8uRAF0c6wx6UBfhPjMN/9AtUALF02/vljHTB3KtMB71q6kzmp3Mvqh22VGH4mODFXDLoxdJKVrkM+uuaCJT1bnh02Q6rYgCWHAmuDMV95CpBAl2jcRhIwwd1ehe/qA0a8arUrRY/mUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Mga/hAds; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1759972993; x=1760232193;
	bh=MjObFjLaUqfDGj6Zdjth6QHgRthEnafnA2lPXMpbxSE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Mga/hAds5afLrs+6Gz/mvVx5lXWGri/Xu0aXPXPIaIY+61nZR0Lw8CukOKLbGrjyP
	 PkGMJWhXhQW9pZq8EN2w5TloDJojeIbDejYrFJ5hW8Gx0vxoGleS3mv5NrXNGxpVSC
	 qtu4Oj532bmraYn3rcbFno+InPdHpPHiYnHmeEZe9nPy3Gsiu5LGo76bAplBxQvgL/
	 s/T1D/z1EMW/Ih0dnJg9ALL82qdICR7tfCZo/mUZLcgbHXerXyfxoOC3furbRJhsq1
	 6GOHHfLL9ef1LmR4F90+zqKlI631i6C0IsQ+4ZdKeEB7NYlss8xFB6iYpf/+hMhC5t
	 /vZr/ofiwqCig==
Date: Thu, 09 Oct 2025 01:23:09 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "??\"ceo@teo-en-ming-corp.com\"" <ceo@teo-en-ming-corp.com>
Subject: Linux Kernel 6.18 Will Be A Big Improvement For Servers Encountering DDoS Attacks
Message-ID: <soiAjUme5vEigjJCe-gtfKVWnfKNG2b3JXQ4KbROFoIWmlPhaOVqzzx-o40m0wa_lE1--k2aFX_Jh_dn4z97uR4_NrmSWreG_gSFw1zZiP8=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: d094b41da9777d58aa0331c8aef85117bdb1373f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Linux Kernel 6.18 Will Be A Big Improvement For Servers Encounteri=
ng DDoS Attacks

Good day from Singapore,

Here=E2=80=99s a news article I=E2=80=99d like to share.

Article: Linux Kernel 6.18 Will Be A Big Improvement For Servers Encounteri=
ng DDoS Attacks
Link: https://www.phoronix.com/news/Linux-6.18-DDoS-Improvement
Date of article: 3 Oct 2025

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Singapore
9 Oct 2025 Thursday 9.22 AM





