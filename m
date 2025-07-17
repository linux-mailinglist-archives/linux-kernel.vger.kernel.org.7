Return-Path: <linux-kernel+bounces-734508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F8AB08293
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7A54A4ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F11DB127;
	Thu, 17 Jul 2025 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mGobXmh4"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD352219EB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716654; cv=none; b=YmpuSdIdTiKwQID/v5faYNev7niQYAuq+W+kKzmqJHzR+y2oL7a0Srbwkmaro8N4ajLyCPt++gZ5E4iGZojVwqibglKKdgfXrd9P27P9bI6qMPTQEM+3jWPdGKrFOCxVkn/kCGKQ0Cu3zooR7tcDeMbBeTDS4NFKvQkxpiL/qgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716654; c=relaxed/simple;
	bh=bXS7gweYb3FFFMLkEJkzFZ6xxQTF0VYbLxl1zfE9Dg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZdmLxBw/6j8H2b5HI/+YaLoMwEoX/EP4UO1LMNITfAywRLLBij7mbnS08uPyPQ6DoFDVb7C2XaGE9J2drpr0yvYyksLQdQNM57g9rFDMkqlYxbXChEx+LFXk2tuHuHl0WglgTKlJOOFz/aiD+ZkemoZ6lAlaTvNRiJDZd3B0nA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mGobXmh4; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752716648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXS7gweYb3FFFMLkEJkzFZ6xxQTF0VYbLxl1zfE9Dg0=;
	b=mGobXmh44qd2Ck991YD+PSKQjjg7ZFdGplYzv2/TIpoeWX3GATWwDXHeKpOfE4yC5hTOEK
	TW/sr3veW/SMsmqaZje78uAXIT//nv3/TC0k0k7GCU49RGrmLEknjdU8A8tJ+hwB/JczR7
	kDzeyN94UCx0cPPvJzHgX2FnQtO2vkU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org,  mhocko@kernel.org,  hannes@cmpxchg.org,
  shakeel.butt@linux.dev,  yosryahmed@google.com,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/vmscan: respect psi_memstall region in node reclaim
In-Reply-To: <20250623185851.830632-2-dave@stgolabs.net> (Davidlohr Bueso's
	message of "Mon, 23 Jun 2025 11:58:48 -0700")
References: <20250623185851.830632-1-dave@stgolabs.net>
	<20250623185851.830632-2-dave@stgolabs.net>
Date: Wed, 16 Jul 2025 18:44:01 -0700
Message-ID: <87v7nrsiam.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Davidlohr Bueso <dave@stgolabs.net> writes:

> ... rather benign but keep proper ending order.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

