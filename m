Return-Path: <linux-kernel+bounces-839225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47943BB1184
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DAB176792
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF862765E1;
	Wed,  1 Oct 2025 15:36:25 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90C1FCCF8
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332984; cv=none; b=tHTrNCsTiq2ru7kgUDawfC1Lqm+Q58m1gDImtRR1Y5/3WMiE/nl76jaRErvJqteL96fs8NaBLGQ9eySRPLdk13uT/1CEPPWoaA32JVcTZRVCP2TjN249Qoa0RPsuzgSbze14KqCBfGWtYZiOyaD3HHLp0y4e6iuBsRbNi9jD9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332984; c=relaxed/simple;
	bh=92BdX1QKhhuJCLx5TFXxA+k5E3PjJXnl323g9dipW6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6Ay521foXgME6tGBW/xlFnwGy42Ipu/yiIIDg7T2mC7Cbf8oOoy5NwDHCIHdchfcxiU/AcYQRDlcaVzNrPlD390WzCc4XTnkeFH+HL8gvIjKIXY06oqUp1e0Kq5YAtsLQBCiLserE56bGVpMAOPRfYCAiM7wJVCouDB2P1MWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 8FB03833BF;
	Wed,  1 Oct 2025 15:36:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id B077C80009;
	Wed,  1 Oct 2025 15:36:19 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:37:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] unwind: Fix unwind_deferred_request() vs NMI
Message-ID: <20251001113757.41beab91@gandalf.local.home>
In-Reply-To: <20250924080119.005422353@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080119.005422353@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dhhjetgb5th4rptogqrzdw8endbt8rm5
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B077C80009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/zmoOxKY9VOEZhOi2T4oOGZKJ1u8ATxvY=
X-HE-Tag: 1759332979-661341
X-HE-Meta: U2FsdGVkX19/WPIEX3ZoOOCLTOcaznl6G8BlyEMJPyHzGgo/xmBOiK8KdgVKUgVwE1iiTWw8ChX8TFsy/brPL6/YtO9/O9W06wxRGDEkMlM/08mUoz8MBV8AJCWZPI9Cok+OBUyqIOT76bwNrYiVS4HtkPd9NiXoGR7awrhFlSq3zgPefbCisZcQpHdVIerF10L7iv03KrQTOxe6HYjC5Gch1WEFAV8dIp/7JDBLSOhf4dBHtm0ZaOvfrFDfVyfu/Bwg6XHrWp3BCmYvlcTiOdNa2N2Kg6WwvkQFgJhb5jYRAcPFDNRsH+9yRDHMlKsccTOk7LE7lTcAva+iydmc9R93uFGgzhqeqcMDtecpGQIx/qag6nxqpCT7diGLc3UvXp2kLPFPj6hXTas1VCTz1WYPxt+OvFFaC98yYdAGorwXjABXsbDrhCzplJX42STq

On Wed, 24 Sep 2025 09:59:54 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> task_work_add(RWA_RESUME) isn't NMI-safe, use TWA_NMI_CURRENT when
> used from NMI context.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

