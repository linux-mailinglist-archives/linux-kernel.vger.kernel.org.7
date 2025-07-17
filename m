Return-Path: <linux-kernel+bounces-734522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E53B082B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536271AA5CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620101D7984;
	Thu, 17 Jul 2025 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OPCBd9xo"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2451D54E3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717795; cv=none; b=ATeQ5j/RJozpjsTnL02A53w78GDl86U2lgKIRkSW4IYwibqJW1XIQ8P8AxmXLZy2vDylzNFqY9lxv3btTWJQjbM49xK7Kzx7vyM6b2U1+VyLpfAmh+uOp4H3dqmXibJ9mt0uaVGkFQLBl1fJscDanJVuBM6J/bqaU5psZo4yVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717795; c=relaxed/simple;
	bh=m4O7swaPtTU1Bb0z9OHP+2fi6+0dDchifP/v5BICy3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=to36pdWXOLbasrbpAOQPrwHGNS+wfO86wqa0vgF2Ic/JM79rgjiLH8wopFDvnCMxyr4T94okEmbwyONe/KPMXlI3QUKHJ0Oto5IIvSrU+5v+NXv6gesHCOlKRgu8TSlNJCp1PyhJ6SwLmc4gynhpReIT6zxd/BTqoRGw4h+aRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OPCBd9xo; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752717790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m4O7swaPtTU1Bb0z9OHP+2fi6+0dDchifP/v5BICy3I=;
	b=OPCBd9xodbRUjyWmKdO+CnVFayDozNMmexogt2F8EfU2yMTqxovy+3QIHAX3rFuuYfnCyP
	rIyow152/E7j4wzZXUJrEpq5sEbIUZ7o0OOphkWsMwI41qM0NEUbb1TdHH0LC+RelP4P+l
	b8j4hAkhFVhxmG+blhYRu0BklspFy6w=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org,  mhocko@kernel.org,  hannes@cmpxchg.org,
  shakeel.butt@linux.dev,  yosryahmed@google.com,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm/vmscan: make __node_reclaim() more generic
In-Reply-To: <20250623185851.830632-4-dave@stgolabs.net> (Davidlohr Bueso's
	message of "Mon, 23 Jun 2025 11:58:50 -0700")
References: <20250623185851.830632-1-dave@stgolabs.net>
	<20250623185851.830632-4-dave@stgolabs.net>
Date: Wed, 16 Jul 2025 19:03:04 -0700
Message-ID: <875xfrshev.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Davidlohr Bueso <dave@stgolabs.net> writes:

> As this will be called from non page allocator paths for
> proactive reclaim, allow users to pass the sc and nr of
> pages, and adjust the return value as well. No change in
> semantics.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks

