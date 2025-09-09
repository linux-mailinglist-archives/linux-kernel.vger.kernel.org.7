Return-Path: <linux-kernel+bounces-809160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3765B50963
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6857D5465A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45A28CF6F;
	Tue,  9 Sep 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MxdR69z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CF25A35E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462017; cv=none; b=rSyThNqRcV5FgYBTQw1ErpF6pu2j799dqq0+osbnpevmV20aSFNROXTCT1JiyG+xBbq3DNi4xUBWNbPqF9NDRQpxjZrH4FpaZlGRevA+8TtrO0yYGcLoEZrQLyTg8NKP1yCNtiqCJLVDAOCW3H+dyWrHv3cYtV67/2k7GkIk0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462017; c=relaxed/simple;
	bh=TL+mPDulX7ZhVXLQTVuVDyD7XiM47hN+hxaHhpZDWIw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rEyuTSKoojNIl0xCsBkScdRrZkq1TfOXFbSxDGxfvHByl9DkmAhCwBGL/9IrF4VbdSfNgnVfYK8vGdM+rv5z3L0vmmIFZYuAqKaqrcJ5KauxwRTI3hYlUQ9sUPQ4Gkx3d4hywSmHCEwdq4M6OzaKd8dJAxUAH4dC2ewsGwDulX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MxdR69z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEADC4CEF4;
	Tue,  9 Sep 2025 23:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757462017;
	bh=TL+mPDulX7ZhVXLQTVuVDyD7XiM47hN+hxaHhpZDWIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MxdR69z8T2UdS64FQ0ef5nyIc35+yEWFvt6Dloh9Zrs7OjsDpjMx9BA1tex8blA8N
	 9ZO2lBXbfg34iDvDboAwvDDrOYKIvjb5SOWlJAswsYNUUjz30W/Yv24Sc5HNZhKo1E
	 11DCUAvqsSRloZ5VnBDVEinT5bciOOl0jyUfFM58=
Date: Tue, 9 Sep 2025 16:53:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brian Norris <briannorris@chromium.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] mm: vm_event_item: Explicit #include for THREAD_SIZE
Message-Id: <20250909165336.c9505e477461fd5e41e6cfe4@linux-foundation.org>
In-Reply-To: <20250909201419.827638-1-briannorris@chromium.org>
References: <20250909201419.827638-1-briannorris@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Sep 2025 13:13:57 -0700 Brian Norris <briannorris@chromium.org> wrote:

> This header uses THREAD_SIZE, which is provided by the thread_info.h
> header but is not included in this header. Depending on the #include
> ordering in other files, this can produce preprocessor errors.
> 
> ...
>
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -2,6 +2,8 @@
>  #ifndef VM_EVENT_ITEM_H_INCLUDED
>  #define VM_EVENT_ITEM_H_INCLUDED
>  
> +#include <linux/thread_info.h>
> +
>  #ifdef CONFIG_ZONE_DMA
>  #define DMA_ZONE(xx) xx##_DMA,
>  #else

Is there a known configuraion which triggers this, or was this from
inspection?

