Return-Path: <linux-kernel+bounces-782736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF9EB3249B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756475C8021
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82CA1EC01D;
	Fri, 22 Aug 2025 21:31:43 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E421531C8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898303; cv=none; b=JWarT4QdCObQaOQlc4m51ennWBYAVhO7i0dn5ncOyBkZlABXtTS2PgAIZ8FqmxQ61Zn0o/m+7aijnxklDaNzieGAJDyL7e9HtU1ZFc9hTxPnbrsID1bnlkERqxaI0XuvgkfghsGUGVwJZc1duPycV4c4eGZlFwTXNjNcnM1zoSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898303; c=relaxed/simple;
	bh=xPgnKv+kQRDj//dhxwUnnqmvWNYeLZAD/44Hs76wo0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4OtZ/6SXLJvRuAlI4TuFooUL8TkLk4BUctmrlbfrnPAPT+X3kdD5r6CzkOvmE1L/gVA3ahHgcF/aTMvzBiJhdxiwoqsb3OYgkwB2dTtAeV7L+cB48Rys8PTxXVFErxBFiadwSc7DgKago3FEd87Zuy7k66oXzr70jisz47KNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2107B117610;
	Fri, 22 Aug 2025 21:31:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 9DB832000D;
	Fri, 22 Aug 2025 21:31:36 +0000 (UTC)
Date: Fri, 22 Aug 2025 17:31:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
 <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Liao
 Yuanhong <liaoyuanhong@vivo.com>, Pu Lehui <pulehui@huawei.com>, Tao Chen
 <chen.dylane@linux.dev>, Tengda Wu <wutengda@huaweicloud.com>, Ye Weihua
 <yeweihua4@huawei.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250822173143.2f8c2b4f@gandalf.local.home>
In-Reply-To: <20250822212311.GA1629566@ax162>
References: <20250822124933.74965607@gandalf.local.home>
	<20250822192437.GA458494@ax162>
	<20250822170808.5ce49cc3@gandalf.local.home>
	<20250822171637.7ee1cf7e@gandalf.local.home>
	<20250822212311.GA1629566@ax162>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7u9u8rbfqqq8j9fkde69pks5cnx7jc37
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 9DB832000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19tLT1jI8MXHE9qwl7ZatYZZAK37IfyyYY=
X-HE-Tag: 1755898296-706266
X-HE-Meta: U2FsdGVkX19lmDD6+SF5/80gbwXL29baaydxFvqlAJfWh1vR7CgRddTm8u3Nfh4GkamBK87RTxwEqy1Jcg0173iX5sgNovg9UfttDmwxlKvw4erS01J0tQRrxKmz+pmC2MYpLv/MrQaDsNjdYpkNhqPhNbVZZCXEd4dpZ2Eg8OKBSE0roL7fVgzMNLDbwwhDN6P1LiC0LdERKTKG8xyRAa9WAx65S58dY3J1A2Yhun/isapXwVMGr5Enx9YL5xA2kvMGWY2R0c5uFmax5rgKw5Rd+jO4PxFhprk4LBSeogo2SO//XOzNxh7f5TtWJaWOTlxHXZmQbHV6SqvlvC4VF/NCtLBpwWZDN6MtN4+aa5ZdDYAHkKtI9k4ZxX05AQfsgdIUpqVny/wLUdxKeCoKKA==

On Fri, 22 Aug 2025 14:23:11 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Fri, Aug 22, 2025 at 05:16:37PM -0400, Steven Rostedt wrote:
> > On Fri, 22 Aug 2025 17:08:08 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > > 
> > > > If there is any other information I can provide or patches I can test, I
> > > > am happy to do so.    
> > > 
> > > Can you send me your .config file?  
> > 
> > Actually, can you see if this fixes the bug you are seeing?  
> 
> Yes, it does.
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks! Let me rebase with that update and rerun my tests.

-- Steve

