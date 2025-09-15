Return-Path: <linux-kernel+bounces-817378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15992B58173
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8507C1AA374D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30721D5CC7;
	Mon, 15 Sep 2025 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="Oqsszjz+"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71081A0B15
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952159; cv=none; b=kliDUGFSjz7UPeUZKQnmFMnduFtyk7FQbOLYIetnECjcO02mI/KkTWEpbgJ7OO4cq/dMgOOfpXv7meSdKJsOBIvKMFJ7F/zGPOcOd2CXR2ZfRZZ6spyXSPznOINYefpE5LkIBxatjJLahf9SichJEA69jY6VgawI/TZsLnsz0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952159; c=relaxed/simple;
	bh=PZCbahEO0Aw/Rlkp5fiG1DLe5Od+rkGa3tXo90vPdVk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CCJvaISOFRvRKgCeMHF11moc6C1STwVHNS1EtjUwweYII3kuu5iheY2/EJSI2bsn7pilpQPjG6mCb93c2rCxy65Bg0yxixvR03js5CISnowTlhAaCBha7v3GNEBV57F12mMAYLD+vW1wTh5L18RhwORk5TYbXNAa4u32IPmkoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=Oqsszjz+; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1757952142;
	bh=PZCbahEO0Aw/Rlkp5fiG1DLe5Od+rkGa3tXo90vPdVk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Oqsszjz+nzLSGDoapxTXItdZX+1EhbRR/shy+5MTb9fF+CZM1X4Rl1iD/Y1iY+lYp
	 V90CrciwqGefxoh/SS8VQsDK7JS/qPcgYZTa59g19Y+llXS6b/kczsrQHe4l24IXbe
	 f27JiGMPbZD2Z5DqrD4AKpglx1Jz9NxXniNgXVrs=
Received: by gentwo.org (Postfix, from userid 1003)
	id 90FCE40346; Mon, 15 Sep 2025 09:02:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 8EE8E40345;
	Mon, 15 Sep 2025 09:02:22 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:02:22 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
cc: Ryan Roberts <ryan.roberts@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    Takao Indoh <indou.takao@jp.fujitsu.com>, QI Fuli <qi.fuli@fujitsu.com>, 
    Andrea Arcangeli <aarcange@redhat.com>, Rafael Aquini <aquini@redhat.com>
Subject: Re: [RFC PATCH v1 0/2] Don't broadcast TLBI if mm was only active
 on local CPU
In-Reply-To: <874itk1dy3.fsf@DESKTOP-5N7EMDA>
Message-ID: <096ba6dd-091e-c86b-79f5-ecba9ce59b9e@gentwo.org>
References: <20250829153510.2401161-1-ryan.roberts@arm.com> <874itk1dy3.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

On Wed, 3 Sep 2025, Huang, Ying wrote:

> https://lore.kernel.org/all/20200314031609.GB2250@redhat.com/

This patch is part of the Redhat 8 ARM kernels.


