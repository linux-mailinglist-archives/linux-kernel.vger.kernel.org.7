Return-Path: <linux-kernel+bounces-732665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44136B06A60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAAE563E78
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C4015E8B;
	Wed, 16 Jul 2025 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="o74Mn7mm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C1846F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625452; cv=none; b=WmNpIx59IVP36UArUl82aej4Xn9G1Wh+t+RZ8AjE9PW83ESIIpIK1JYWKO1O6UF1e4yiRsJ+1r41hMNaGhKI0JlifjcOkmfaQ3+xyfXxI3QAQWoApvvLE31Xf5J4koQdOvTlErofC4KpZtFU0pKwa18W5oTQFHwjmjsCJ0qhb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625452; c=relaxed/simple;
	bh=csUauH43hrv9OgkwXydgwkjLx1nf5ApP77esmBcLsEU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cokHbsp0463gwre5vfjRSjcdw0ODOhydwHVKaeKjVw7jDxCcFgTaY/o+dm9dWvuQ6MCO9DdSzNeW1jWQ51uoI4oOuMBJM8YxrKwRKqPPvqf8KRCXE+nyHtKgLuPRmvv6ZGqDhWY46bodbKWLYT9KJ1VFWSR7oMoE68aus9gRbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=o74Mn7mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8075DC4CEE3;
	Wed, 16 Jul 2025 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752625451;
	bh=csUauH43hrv9OgkwXydgwkjLx1nf5ApP77esmBcLsEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o74Mn7mmzmwM/gNYJRC101NkvfvOBvKL7s7Fl8Pv6mL7fSAC2GrGLgGsFz1TYt9tp
	 IptqFrARn7181wxV+JQqJ72O3Gl+7gQdoEsDLC8YNU2XYcJPNQCWuIae9m54ESfpRU
	 BCSxIu15vPNs8i32HeR2mILSGEKMkhyrgA05MdKo=
Date: Tue, 15 Jul 2025 17:24:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: mhocko@kernel.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, yosryahmed@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2 0/4] mm: per-node proactive reclaim
Message-Id: <20250715172410.e22bc8f791325b01b6241d6c@linux-foundation.org>
In-Reply-To: <20250623185851.830632-1-dave@stgolabs.net>
References: <20250623185851.830632-1-dave@stgolabs.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


We're a bit short of reviews of David's series.  Does anyone have
additional input?

Thanks.

