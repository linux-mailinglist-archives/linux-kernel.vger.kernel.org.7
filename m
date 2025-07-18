Return-Path: <linux-kernel+bounces-737256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E44B0A9EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EF61C47B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5A51E5B62;
	Fri, 18 Jul 2025 18:02:35 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0C1A7AE3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861754; cv=none; b=rbu2J2B0LMnYX6/scPXzwfbMrjZA2uK8tdSC9BHz7l14UQRYkRD83eCMJhCB9fGgeLXbzdgDW0W2218UPwfWnjRGpHdqQZrb6odX0cN3XubR8FXw/7MqIuNFsspv0CN31cxowyzN2sYYqlnOxvenwtQyJ0mco4EI+AXnWf441h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861754; c=relaxed/simple;
	bh=tCni6XPQ9BJHv84/TFjEYSWuyMxSMOC8cIy5cz8oqEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIs8N7wUzFJWwx8iYPTHt5JHQsLuskuPasIjP8dw84ZWDB+2DXdZZOaQnQMoucW/gI4Ei3/x6p6NdUdjaZy61LKknbTE0RhjzztpOOs4SIIsmfK71htbh6XzaW50qZyY+oAb7EEsuRWahUYOb1c5js7589DOwFMGbO6UP2HglQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id B9D4D1A017C;
	Fri, 18 Jul 2025 18:02:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 7B18930;
	Fri, 18 Jul 2025 18:02:28 +0000 (UTC)
Date: Fri, 18 Jul 2025 14:02:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chris Mason <clm@meta.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/12] psi: Split psi_ttwu_dequeue()
Message-ID: <20250718140227.6902fb06@batman.local.home>
In-Reply-To: <94ea5721-2d32-416c-919c-a0d9e5eadf99@meta.com>
References: <20250702114924.091581796@infradead.org>
	<20250702121159.050144163@infradead.org>
	<94ea5721-2d32-416c-919c-a0d9e5eadf99@meta.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 55pqnwuf55fwm5uhd3fr8zegx3bo4xib
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7B18930
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19NvXEeZ8SeZXrEZgTYCWEIBVrBWzG0LKU=
X-HE-Tag: 1752861748-436800
X-HE-Meta: U2FsdGVkX18XBeIT0q8nkMkeGPvLZA50UOR4aG5BzfonEeSH1UGE1u44u7cDlFTYutirWqqUfejsWztdKSrM/+75AWFIJJU9/1pO4wzhXHXZzXoQ2OHy6LNM9FC/GPk43j6rOvTWAzbQ2Uj0M0+rV5UBqTf3xkuWl8/2mNRTcoZbTiSE9KADrBVz/JwnMIF1hoA6pANTfgdtmG10eGxT8PjoNK+tPVNHJ6aJFFlv6COM7rMd5qq/w/239W7tF+xiZrVXpiMj+cEVI6EL3Iemnz+7KhAEN46oHvCVbr8lNXBSjB4SV05bqHGx6fZ06ShNqSJZxHViSZYBbh1HOfewVuK43Vrq88NiddqQkS1gN6XO+5l4KecRhs2ncUIutQDRD/phwT3DhyFFuWHKk6OtBQ==

On Thu, 17 Jul 2025 19:59:52 -0400
Chris Mason <clm@meta.com> wrote:

> > -	}
> > +	if (!likely(!p->psi_flags))  
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I think we need roughly one less bang?

I think it needs two fewer bangs!

	if (unlikely(p->psi_flags))

  ;-)

-- Steve

