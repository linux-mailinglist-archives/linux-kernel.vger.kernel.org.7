Return-Path: <linux-kernel+bounces-854198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 438E4BDDCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0606E4EB63A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511C31A80E;
	Wed, 15 Oct 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="ohd2jmWa"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4E31A7F5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520983; cv=none; b=mp5Z5R+CsVYseMt6XrISl7bIH8kcS1Ag7xMsSutREJLGYIOodwycup5ML5JCD1KgNuOjUU/khRIViJJc+Db5SekifpmdrmudhaW1GaGReoted6Qd8+vH0ZSQ1U5PQgprBZrKiQlIVOOUTbWKpZyx12M3t6L6shuT1OilTqZBujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520983; c=relaxed/simple;
	bh=444rF87rbwnL1HPCf4I+2dUp9e+GDDNxSUd1IzYBqKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjEpYwAnwGegEpyYAv71oxCuRNUBziwec3KNBcbbZQuH9gLfBUCxokHpI3gucytwT2KnLYVqgOcnvkTwKj37Dk3gQw7Ph3z5NbofL2Kv3Z5tmw38O/zXte5BbxI5U5rHiHITAAEuudrwzmGQ87P6VzNeZoEMemiY0Ucvk5r2q7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=ohd2jmWa; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 6DCB393278;
	Wed, 15 Oct 2025 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1760520973;
	bh=444rF87rbwnL1HPCf4I+2dUp9e+GDDNxSUd1IzYBqKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ohd2jmWaAkpvBv9pZqM52/48kSusnuBNByZ8gZ0W8u6RbLJXO+uP9tJRc7aT8vU/Q
	 ektic11TqmL8DSww6OD5HHXkeE+XCeSkVH41KTDC61cgSQ8yOEOU9QgLCuP2OpgmQO
	 hDTzDBja3DueDoLqVdQEAhnTu4SHk8A9q8ZXuG4M=
Date: Wed, 15 Oct 2025 09:36:09 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] x86/irq: Optimize interrupts decimals printing
Message-ID: <aO9rCaHLaXd-iJmi@shell.ilvokhin.com>
References: <aNrBL0Pi6kYXHGxQ@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNrBL0Pi6kYXHGxQ@shell.ilvokhin.com>

Hello everyone,

Just want to follow up on this patch. Does this change looks reasonable
to you? I would appreciate any feedback, and thank you in advance for
the time spent reviewing it.

Best regards,
Dmitry

