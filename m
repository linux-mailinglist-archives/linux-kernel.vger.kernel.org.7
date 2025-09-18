Return-Path: <linux-kernel+bounces-808297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA8B4FDA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E687B188652A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182ED343216;
	Tue,  9 Sep 2025 13:39:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BC340DA7;
	Tue,  9 Sep 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425191; cv=none; b=Lp4ocI2BiBRYkBKaPV0aSDncboX1AkUaf42uApSLG7Ohhav7slBNgGvLtpe0az60M4zMdczYyLmv++KJ6LZoo/9Na0ybEVeDDVXIU/5SWirVnuU0AsBiIpBz3cQLlj/7NQexz0zT2ovqnBcjuHVAswIzxC7D800+Ji5GyEAmEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425191; c=relaxed/simple;
	bh=zXP0vgpsslX+xoM+R5u5Z8Qq+cPpKOIF09oVF2DyXdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOdB3h1uOxDRR+TnUOoGJIE0R3FWW1O+rJv9OSpiw2EPXM67Vpm9Wziw2YJWP/xyIFdmXPwLYlTwXv+QkIQ1QxWfUcI/j2nCYPsSeqHaO4nAqNDixmBFX+56MqI4Xx9ZbxQ7EBJ88VMnWLl5BarLlBghBzpXb50i1Zvt020N1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 324285951B;
	Tue,  9 Sep 2025 13:39:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 900C62002A;
	Tue,  9 Sep 2025 13:39:40 +0000 (UTC)
Date: Tue, 9 Sep 2025 09:40:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/24] tracing: Add reset to trace remotes
Message-ID: <20250909094028.3265b751@gandalf.local.home>
In-Reply-To: <aMAZMaZJ1_Eny5Ku@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
	<20250821081412.1008261-5-vdonnefort@google.com>
	<20250908193757.079aae76@gandalf.local.home>
	<aMAZMaZJ1_Eny5Ku@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 900C62002A
X-Stat-Signature: wfa3mdrmcbzi14spidjppaqea6aw3qp1
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+E8T0HTQskMKNFMQEhwq4iyvDU75kvHts=
X-HE-Tag: 1757425180-933823
X-HE-Meta: U2FsdGVkX1+Wwks7b6yVoepNeV7TOzWudjuaDH2HvpSyApAYLfX3FbQwoINlsSIJNvKZcFkkzCa70xLZ8yV4M3RgoVBTMxN5wkAN4Tvsgw8YtAsvBOUnzzaGQoIagJtU8jlbuWu7YwTn4neLH9QVlsUmEnxOFj+Ce+XWBl2YeuaS2Co2nBtPDT2dppC4tUtOJR/BNg+CfKupetaSNKi+SIEiMtMc+wVlYX5nkohak+WdMCO/O577kVmfRGQBv0yYCqWaEXG1hBinQi1qPSUlt1pVhygCIsWRDJWGDRHVLOLUYn/A+q+kGxNNxzOWFpeRPlmy68ip0z5ZjM1JDFzumCv8TLnOFVx7

On Tue, 9 Sep 2025 13:10:25 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > I wonder if we should name the file "reset" to not be confusing to users
> > when they cat the file and it doesn't produce any output.  
> 
> My idea was to keep the exact same interface as the rest of the tracing. I could
> keep that /trace file for compatibility and add /reset?
> 
> "cat trace" could also just returns a text like *** not supported *** ?

If it's never going to be supported, I rather not add it. It not being
there is a sure way of knowing it's not supported. Just adding it because
the normal system has it is actually worse if it doesn't behave the same.

-- Steve

