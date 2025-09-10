Return-Path: <linux-kernel+bounces-809406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34707B50D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9A93B9913
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A02BD5BD;
	Wed, 10 Sep 2025 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cNbM6oZ0"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF4262FE7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482349; cv=none; b=OIuqsNFbS3Nn46J5jlWFlFmNterlJhS07tJnOCtnq7cMwFjsZxIRTKIlc+1Fep/99bGbQFFbX3OFa8h4VvAqdjZQTOQW9cEHmGqoDNHScFSE2MH+Gy/B3RrOoaPXd//bG3p5h3pdfYNmggziuMorY6eb5O9FiKKLoPX2D2z1LN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482349; c=relaxed/simple;
	bh=CotDQMMNMI0cY5Kyn0qijR55vKXOv+geaXVNcLr1wtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e09LGhGUCUpDQSLS90ic9K5GZcudS4WqNEEL8yS1cFvl95xICuSUsjiC444m2DoMsHApSn5H0EinSepGsXCRuVfd/jITt4VdmwTdvULv7pyfWXgwRoNwOz+oG2+JpumGMXA2XBo3bIjDgjpOnWtfAXdme4wK+UsxrvfSDbry6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cNbM6oZ0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 22:32:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757482343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96+nFua0lvoBAT5TkzLTpIuvi/sQOjbeRjcMdzpxTOo=;
	b=cNbM6oZ0gFrR0bGqu3X9OuekugDQE09JfMarGERbPwHIC2/j6WgHANxoVgR8Ndb9iq931l
	BGf1d2F7vw5f/u2xoy+RwY63KDxjo56pNaNznjQmSUXrmc0Kht9/v2GYZrPUnClzQ4iLdQ
	eS0ZoVwmL+oyIIq8A/SGQN3829tT510=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	usamaarif642@gmail.com, 00107082@163.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] alloc_tag: prevent enabling memory profiling if it
 was shut down
Message-ID: <k6dhapofhcrhmcigqasy25lxmht4ybxp7jv5rg5oe4fjt3feop@lkyiqad43b5b>
References: <20250909233409.1013367-1-surenb@google.com>
 <20250909233409.1013367-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909233409.1013367-3-surenb@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 04:34:08PM -0700, Suren Baghdasaryan wrote:
> Memory profiling can be shut down due to reasons like a failure during
> initialization. When this happens, the user should not be able to
> re-enable it. Current sysctrl interface does not handle this properly
> and will allow re-enabling memory profiling. Fix this by checking for
> this condition during sysctrl write operation.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

