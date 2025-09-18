Return-Path: <linux-kernel+bounces-809117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE4B508D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9647A32A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB29B26CE2E;
	Tue,  9 Sep 2025 22:23:47 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952AA25DCE0;
	Tue,  9 Sep 2025 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757456627; cv=none; b=S97kHp13Fn/nLG2p6hLqBmFV7X7Cm0379YCBhJZXXN2TVSIVJK+z2hWxj+igM/99KxqZLvQMI84QmgdzR1pO1xRUzJb42XCBbAdi4+Q5INj/ip9ql+6BGaBo3wn11Va4vRhW13b75WO1UNCXFhfTjvtYW7HZ+DCs8uN0WimBEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757456627; c=relaxed/simple;
	bh=zFUBPtIyoFSY0XlA6eNWYROEO8YcDxqHhcflxQ8m8LM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9R50II8yS0cUH72P0aq/kS2iXynn/8MEmPd4JqGPJkZI829DsJfOKurQ7xB6jcN5df/eJjM5LgVt199xA1dCtr8DYKQkm/h18yQdyCZDxq+iCXDu+6aXZv7/Twmt2GA1c90/zQhrVrfFv9NoZvqI1iudA94S4U0wdCXpxhdTZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id EB4215A424;
	Tue,  9 Sep 2025 22:23:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 663D320013;
	Tue,  9 Sep 2025 22:23:39 +0000 (UTC)
Date: Tue, 9 Sep 2025 18:24:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/24] tracing: Add events to trace remotes
Message-ID: <20250909182427.711d2915@gandalf.local.home>
In-Reply-To: <20250909174750.72be9bbc@gandalf.local.home>
References: <20250821081412.1008261-1-vdonnefort@google.com>
	<20250821081412.1008261-7-vdonnefort@google.com>
	<20250909174750.72be9bbc@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: oy166uftup53oqxzi6gdnzpyd9g5yr6b
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 663D320013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+c18lJAA4FCi9ZnqCLxVscRpbdr51n5oM=
X-HE-Tag: 1757456619-137741
X-HE-Meta: U2FsdGVkX1+TJJFJ97IrGgRByHl23s45JciDfMCRsTB9AxoeD68Gc6N74Z1sMF6z+Z+y2y6mpD3LRTcKFNPyCtMUXePkIvddOih2DBzuZ/CuM/vxJdiQLLiU/4j6LQO96UKjt3NIs2pqH0mPV/Hm/XP2QiTC0Dgv1V8yaEF53iPKnYmsObPOsFFzmqeeZyKr8a8Up8DWE5dN3nDoMDOLVVZjb4Qd5Win7b0Kwiz+gVDRkJct8+AFyIrBanyFSwddri13LqWKywLTPou1QNIuklZQ/A8a8IroKq0DGX208FZQPwqeo1xCCJVoiDYqeHayGCfCwlFCrV74pICFjyWzlhbyybI5kWBEJlpEPsaAjBuCRaMe9GNOg26v21t2DPxk

On Tue, 9 Sep 2025 17:47:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> >  		iter->evt_cpu = cpu;
> > +		iter->evt = (struct remote_event_hdr *)&rb_evt->array[1];  
> 
> Hmm, shouldn't this use ring_buffer_event_data(rb_evt) instead?
> 
> If the events get big, then it would be array[2]. But the
> ring_buffer_event_data() hides that detail.

Ahh, looking at the patch 10, it is always array[1].

Still should use a helper function instead of exposing the internals like
this.

-- Steve

