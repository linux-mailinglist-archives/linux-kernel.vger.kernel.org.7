Return-Path: <linux-kernel+bounces-755712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E518FB1AAC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B84A7A250D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0500723E32B;
	Mon,  4 Aug 2025 22:14:27 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459014AD20;
	Mon,  4 Aug 2025 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754345666; cv=none; b=T7upzSMbEUd0TgRVW97qjxFT09MiRz2iNtXo2GM0hATphm0MK9slI4k7CWtMalkQ4fqpEZu4a5OidbMgrhWF3pfi4/em1glNREWvUCbPoqmRM7IpLsi/ljVd1LZDepqz2gBZzmKOR+Qr8C2Z/gCPMAc6q21OaxvqRAUIO18fBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754345666; c=relaxed/simple;
	bh=pFbnUxGl0sPENav/GjAMaSL10vuA8xzn7uiyMHniyW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPQP5pqAzdS4dv8wa105ar1S8uJMS3O6leTYCpbURHyymGx7QALlFlT8u5Onu2dKpL/ZRlSqEwWQsH4hwXouAIrK42f18cs6ElxCb9lw5s8KvHcch30OHAuXtrwEMtZ6bfX5dzgn4rYRArC1YifwI72/JkIu3nbpbP594H43/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id F08E1115A44;
	Mon,  4 Aug 2025 22:14:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 4DB632F;
	Mon,  4 Aug 2025 22:14:19 +0000 (UTC)
Date: Mon, 4 Aug 2025 18:14:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Kosina <kosina@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, Michal Hocko <mhocko@suse.com>, David
 Hildenbrand <david@redhat.com>, Greg KH <gregkh@linuxfoundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, corbet@lwn.net,
 linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250804181447.0c518b14@gandalf.local.home>
In-Reply-To: <alpine.LRH.2.00.2508050000580.22517@gjva.wvxbf.pm>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
	<9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>
	<2025072832-enrich-pampers-54b9@gregkh>
	<1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com>
	<aId1oZn_KFaa0R_Q@lappy>
	<aJB8CdXqCEuitnQj@tiehlicka>
	<aJC0ssMzX0KWnTkG@lappy>
	<alpine.LRH.2.00.2508050000580.22517@gjva.wvxbf.pm>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4DB632F
X-Stat-Signature: 1hz9xr1y1u4hbk67z9uwtg71uuu5ga5m
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+E+wlnvIcd+hUCrbJeRFIBLjjjBhto9Bg=
X-HE-Tag: 1754345659-681559
X-HE-Meta: U2FsdGVkX18YLrxLOUkgjEfopPIdEJvv5mN/WnXnXi2698t+Z9iw7lw9P7RfYOXup5q61vC8AuwXqCP5z6DOr/0gxHsXYrFE6H341O9++kbf2D4rHks6cEYfwSHrPxEfn5Qio8yHeTwsBZe5wKiEpPc8Pj1LV3kEki76UaqATIB6YhH985G1osdDxGijQRahZNKgSGhR6hEa7GsX+0WxmpxIdfclwkmPsxpNMDSNJQgRwSPPFnXJfiI75D1PS91p+Dr1pwBkdrD65NdcYokVmyZGy5eNgSWsf87OY1VkeNGMfmvDF4PHfkGzUGKUXDR4G66r+vFvQhfowpLED9jSBBK++BM0IXLv

On Tue, 5 Aug 2025 00:03:29 +0200 (CEST)
Jiri Kosina <kosina@gmail.com> wrote:

> Al made a very important point somewhere earlier in this thread.
> 
> The most important (from the code quality POV) thing is -- is there a 
> person that understands the patch enough to be able to answer questions 
> (coming from some other human -- most likely reviewer/maintainer)?
> 
> That's not something that'd be reflected in DCO, but it's very important 
> fact for the maintainer's decision process.

Perhaps this is what needs to be explicitly stated in the SubmittingPatches
document.

I know we can't change the DCO, but could we add something about our policy
is that if you submit code, you certify that you understand said code, even
if (especially) it was produced by AI?

-- Steve

