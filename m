Return-Path: <linux-kernel+bounces-840904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB06EBB5AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350CD4266C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE112F5A5;
	Fri,  3 Oct 2025 00:48:42 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8BE2D7BF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452522; cv=none; b=stlwn57mG5b5DWp21AaMzPOHjc22ZGpCKk45avXih8giolD5oGe82SAOfp00w2MeFjShfM88GVFC9rUhi0nyTEnnoZoZSSj7/CEs9222wAnGKYc9GeykpkltJCczN/qYQEGOPDZfEa8K1FqUO+XdEpLZtsHVoAn2jFnJqx7zZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452522; c=relaxed/simple;
	bh=jWQ2fPuURNEgla6LWOsgm7M2rXbQeY5AnWmOH9ypBVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7stFDbXDSVsqLjyl4w+TH3YjNaE/qK/pQ30G4jQfqYFfzowG6eESQV4mpTQ6oJFQkBTzrtPEjyhBknwh71eEB+n2gX0/iI19gd3Hylpf28wZOe7OcZqdl29oRchSBdRlt67EUr0dcI9JbEfOyHubXI5PWhdKktv34oL2P3q5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-cb-68df1d61727e
Date: Fri, 3 Oct 2025 09:48:28 +0900
From: Byungchul Park <byungchul@sk.com>
To: Hillf Danton <hdanton@sina.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before
 folio_wait_writeback()
Message-ID: <20251003004828.GA75385@system.software.com>
References: <20251002081612.53281-1-byungchul@sk.com>
 <20251002220211.8009-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002220211.8009-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsXC9ZZnkW6i7P0Mg+59KhZz1q9hs/i6/hez
	xYGfz1ksLu+aw2Zxb81/VgdWj02fJrF7nJjxm8Xj/b6rbB6TXrh7fN4kF8AaxWWTkpqTWZZa
	pG+XwJUxaXUHc8EUlor2h5PZGhgXM3cxcnBICJhIvHpfAGM+m+rYxcjJwSKgInHm01dWEJtN
	QF3ixo2fzCC2iICyROeFWWBxZoFJjBI71xeC2MIC4RLT28+xgNi8AhYSB65dArOFBBIkHq95
	wwYRF5Q4OfMJC0SvlsSNfy+ZQNYyC0hLLP/HARLmFDCVmN8xiRHEFgVadWDbcSYQW0JgBpvE
	zrX+ELakxMEVN1gmMArMQjJ1FpKpsxCmLmBkXsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGL7L
	av9E72D8dCH4EKMAB6MSD69Hwb0MIdbEsuLK3EOMEhzMSiK8CSvuZAjxpiRWVqUW5ccXleak
	Fh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpg5DUV5z99zYZ5wTO9Z99q1P33veYr
	8brOW2+/9trfjBT7lxfMCrvsPh76WZpwuqNTWO/9e4e3DBURj30dW2yVfwmfjpgd8eV+kuLt
	WSZpV42iyi3X16/s2dXc+imxsMJ3p6jGnOBlPC/3uuWtyzlkfJl/86ypH17dt+oIvdz5NnL+
	9um3k6o6lViKMxINtZiLihMB7B5lSVsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsXC5WfdrJsoez/DoOuDqMWc9WvYLL6u/8Vs
	ceDncxaLw3NPslpc3jWHzeLemv+sDmwemz5NYvc4MeM3i8f7fVfZPCa9cPdY/OIDk8fnTXIB
	bFFcNimpOZllqUX6dglcGZNWdzAXTGGpaH84ma2BcTFzFyMHh4SAicSzqY5djJwcLAIqEmc+
	fWUFsdkE1CVu3PjJDGKLCChLdF6YBRZnFpjEKLFzfSGILSwQLjG9/RwLiM0rYCFx4NolMFtI
	IEHi8Zo3bBBxQYmTM5+wQPRqSdz495IJZC2zgLTE8n8cIGFOAVOJ+R2TGEFsUaBVB7YdZ5rA
	yDsLSfcsJN2zELoXMDKvYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzIZbV/Ju5g/HLZ/RCj
	AAejEg+vR8G9DCHWxLLiytxDjBIczEoivAkr7mQI8aYkVlalFuXHF5XmpBYfYpTmYFES5/UK
	T00QEkhPLEnNTk0tSC2CyTJxcEo1MPq4X9//tWpOy7usH+fbgkN2LlqbXbAgX/+0s+a6icIp
	gnU3Z7JcCv/NnSZ55lWrwCXH3DArXVu+/8xh867s2D3Jmsd7XS+H52KmyJ55+YvLp1nL8yRa
	hR/K6VxQ2Hgw3vqr9Z7/QRxLt7sssZ4292NMtbZ5/pSOt3pmf+cruvZscrXZ/GStshJLcUai
	oRZzUXEiAO6chMlEAgAA
X-CFilter-Loop: Reflected

On Fri, Oct 03, 2025 at 06:02:10AM +0800, Hillf Danton wrote:
> On Thu, 2 Oct 2025 13:38:59 +0200 David Hildenbrand wrote:
> >
> > If it's a real issue, I wonder if a trylock on the writeback path could
> > be an option.
> >
> Given Thanks to Yunseong for reporting the issue, testing, and confirming if
> this patch can resolve the issue, could you share your reproducer with
> reviewers Byungchul?

Sure.  Yunseong told me it's 100% reproducable.  Yunseong, can you help
him reproduce the issue, please?

	Byungchul

