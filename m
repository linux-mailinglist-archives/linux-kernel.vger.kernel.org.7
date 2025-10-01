Return-Path: <linux-kernel+bounces-839218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A17BB113F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12503AC591
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC874256C76;
	Wed,  1 Oct 2025 15:31:51 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8131F03C5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332711; cv=none; b=X0x0flB2YE6PAXpvQjDTz2HSagF3tgOugHRert/pDtUw7BSOAie074jQ0zx+VVT6aKBU82amIl6gye2JDwfu5yvP15OC+bGXXLrAGzubBjqhD2XJk1fRa9zYI/wNgK+J/Z/BK2muJppDhvUqAyX30yknCuVT1zAcKN0fjnuvj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332711; c=relaxed/simple;
	bh=ADKNz1bqaSSpcYAqR2CuzhAYcZNO4vuE4vrE3Als3zo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnIhrzVfGo7YvwB+0mzKadFc8rH01Wqg3csG+0yjhTMRdWP2w2Q7sRhb48a6b7JYjfFOf3gDd7Hw86n1v+5ra82SB0q67/fNNQQCLtSAyCxkRLwEJ/l82+et+wYu0fmIhyyueE/uFqF0dsRWBxA8CpjH5rmFO9GsUViuBZsOzuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id BB6F31DAE0A;
	Wed,  1 Oct 2025 15:31:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 1C65535;
	Wed,  1 Oct 2025 15:31:46 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:33:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] unwind: Simplify unwind_reset_info()
Message-ID: <20251001113324.0e54de69@gandalf.local.home>
In-Reply-To: <20250924080118.777916262@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080118.777916262@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5jtbpjyu88umkqs6bkr7na6gp5nk11gp
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1C65535
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19c2cltHeUsmvjWYxjVtiTRA6b7okgaI2g=
X-HE-Tag: 1759332706-381636
X-HE-Meta: U2FsdGVkX186C1CBYrmZzWVRVNN1Xecl1p0cTjL/4QPRj1SHiIiLy8F+K8OaD1l6C5s1wzGyRxlGCQ5ngKHrab0d372/bwWSsUK8vxSBzYJcye0tk7CjGfb7/1l64s6bsktRTr3tVc6/rp+MBmMPnbYpPhESCz26JHwoUNibFjX6OHw+shRgAsb7uajLkX1mU8CidEosCrY/ZUbWy2FEADmQlU7ynb6eRDtIxSKIqSaRuX3izP/Z0+0lUIXTGQ7Up1u9djwNK0UtZYgMz8bxldvs51yxr4iR8D8dmrovRSgu0S5WVP9CGVmwaGfqszl1hw8ZWpqytGzRhGLhBpVdZ3Zdp+Ff7HFXsQQ3bgc8KzPQ5X/KVlq5NM8vmxSm+gMVpsRHGAlJ5pI51f79pmerPgiUBwnINu/zDSsgZ+BH/aAqzO0eEdsYcDLDyNo0uMRJ

On Wed, 24 Sep 2025 09:59:52 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Invert the condition of the first if and make it an early exit to
> reduce an indent level for the rest fo the function.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

