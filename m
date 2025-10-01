Return-Path: <linux-kernel+bounces-839214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E94BB112A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6CA1944FDA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FC1F3BAC;
	Wed,  1 Oct 2025 15:30:41 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E011F03C5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332640; cv=none; b=civpfoFkJ4DgYoDPtb3iOwqCMCls6PrcPh38M5ZCHg/g8vnkotUVEbdp20OgzNV+Bu2A3KEwpBEm1RKOTM8O5QwtoTyW5ZVaC7U6jmUyJLybe5ufAEeFYDBdKjuf6WVc8mCPUsSHs7fmBLMYka+8BAxkNOcrxm5Sc+oV7VpSr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332640; c=relaxed/simple;
	bh=I16pAZ9lqLZxr4yAekkuHspDK2ojPYAeyREJgHLQLzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUbofoI5fSaw2/bOYjpgWadLVNFFs77M2XCRNhCXCamrU1wjZ6tBLfcRSCv7PZNlYQgw7IJXeVARE/ahA+9FfjOZmu9dEaqHMZP7Iwf3NyIFik3Msh0aPRs1N5jqkIWqeevFkio6tci/Zr+MO2K1FuFF3akTsmPZ7K3RJrAatIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 6D64E140126;
	Wed,  1 Oct 2025 15:30:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id B9E0C20010;
	Wed,  1 Oct 2025 15:30:35 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:32:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] unwind: Shorten lines
Message-ID: <20251001113213.01e80a8a@gandalf.local.home>
In-Reply-To: <20250924080118.545274393@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080118.545274393@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zahtxqs5h7zppp3hneu4kcba785z4gut
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B9E0C20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19rBCh3HOQXG943Zj3cChqIXF2dSxgpW1o=
X-HE-Tag: 1759332635-219873
X-HE-Meta: U2FsdGVkX181xM5kv4Vp1iDa5qQsrSj5w9/axgSFzjE2WIPQFeLNY2n9waZTweVAoPCrATZhg+APTvNuSthmMvkJI9D2P5Xh/GfsF7oZbC546Koju+rJK8x4Db4uqAlZ4nNtTY7IDALiXRHd3J+TnfIKDjZ2hhyuLxu1D7OU0PRxdTH/myErj3v7/fefa2IAy+rGsFtd9XEg5B4vbwXnR9aB2etA5AHqV4WJM8j/pqAUaOn19kc6LMx/WfqOf2IQBGdn+NpiaqmjUYYUxCt7OGvsoF4TOYmcmV8CkY5l+n3gj8AtG9veZW7JkkLwCZtzBzi3iuYmi+fUQwtOaD6Nn0QHg/obe+k5UxE/fkWFUSGqgFaV7VAlnBmL5WnumxEfD2elvvWcDb/BwrvHmrLlP9HeB35LS2VjIVUaXAqA1L3aSlCPtP8DUnJBr3R79OIH8q1+0xlzHSw9xmIESQDlEw==

On Wed, 24 Sep 2025 09:59:50 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> There are some exceptionally long lines that cause ugly wrapping.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

