Return-Path: <linux-kernel+bounces-797134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B94B40C42
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9275647AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BC4341662;
	Tue,  2 Sep 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="b4+xqIHW"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C728C01E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834801; cv=none; b=m4Y+omSoMbJm1m/3ai++IjnX6jK8tLeOUJqKv0ce+n2jD8uwTJup8oxTfYbFbn8DyTaDuIrEUkMUod1BztW1nboM27ob5HRXJ0XF/30BqqbhCwsw4djEI5Y+8ieSOgUdapslRxmbdIdijpFD6jP/1fqIgZdfYIp+u+K6F0WiJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834801; c=relaxed/simple;
	bh=tdm8cJuBjFeRqOfTlDgRh0c55lXPWPzhbvCHUdH/3gU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yojboqth5LcyEFuLZQAmUXTDfRScGjbedNYdceW1rrHsFvnDtpM3RkmFiOBRNK6RrTn33uOWZmyziHtjTilSk+JQEaW1z4itpEitB/0PWVC57kBndrt6/5ZySx7lwXBl11IlCX1w97/P9P/FbZTIUlfQJHccZ9G1ZXXITY9lyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=b4+xqIHW; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1756834794;
	bh=tdm8cJuBjFeRqOfTlDgRh0c55lXPWPzhbvCHUdH/3gU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=b4+xqIHWQXgQEEQBHtoDlOk+MJl0kThgV0LG4fMjlgSCiwBB4kAcz4fy8/u/5Uyrg
	 ACoZqE9SjObqBm1fvZyVTPWkvyHanIIh3/0H7wXQe1xiiIkYBkhLqwSEyWCn3+M57J
	 GxyzNXcVo8Y7Km9vOZkQeJW4FCPa4XGCamITFgeA=
Received: by gentwo.org (Postfix, from userid 1003)
	id 3A9C040398; Tue,  2 Sep 2025 10:39:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 398BD4038E;
	Tue,  2 Sep 2025 10:39:54 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:39:54 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vlad Dumitrescu <vdumitrescu@nvidia.com>
cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
    Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: fix race on alloc failed warning limit
In-Reply-To: <ab22061a-a62f-4429-945b-744e5cc4ba35@nvidia.com>
Message-ID: <061405e5-8670-2873-9b6f-0f152863adfc@gentwo.org>
References: <ab22061a-a62f-4429-945b-744e5cc4ba35@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 22 Aug 2025, Vlad Dumitrescu wrote:

> +	if (do_warn && atomic_read(&warn_limit) > 0) {
> +		int remaining = atomic_dec_return(&warn_limit);


The code creates a race condition since another atomic_dec_return() can
happen on another cpu between these two lines. warn_limit can go negative.

Use a single atomic operation instead?


