Return-Path: <linux-kernel+bounces-857150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 493C7BE609D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538C03A27F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3419D082;
	Fri, 17 Oct 2025 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKZPOCYZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C8C120
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760664926; cv=none; b=C0ZBSbLnV7czpXoCOvcptPAg1i6sIhRl0wPr4HkdYGf+no4YMYOpJ7wqE2OM9qCzpIO7c+eXKYWpC6nYF2LAi2jUA7Ca9dW4rsH/n/mYhMwq1rl7aIzr44mf44yiP+VQcYaoixCkx9wSRV9NUFv66be5O8u/8CA1XgkEkHKFD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760664926; c=relaxed/simple;
	bh=joXtVh3UwYtLByf8UHsqtv6L5nl+MB4hmfuzd1U4UxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaIp0IBcgpmc+L9ZPFHW2CHbQ+WhV6syq7EXZfqB39QZaK1TJXunvLl5XiufC5mJ3/0xhVxFUBDo2GwG5XYr9kBHbYi2HwNvCY/7gaOOU9b8SWfs8wTNbWg0sxZJJrJHH6TT9cVIPg1qH3HW46C7ovzzqcyqV+2QBL5MwwzbmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKZPOCYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9211EC4CEF1;
	Fri, 17 Oct 2025 01:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760664925;
	bh=joXtVh3UwYtLByf8UHsqtv6L5nl+MB4hmfuzd1U4UxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKZPOCYZqLnM+s0tdMVkwSA8mRl6LK0kIJ2R1Zk47attKGZNEYjAQT1cPyoVpiqn5
	 DiiR2C8HIZYC2vTaNnOBAQoDLeBBNUXbRpU8NSnlR6IyBNRRo5ZKLPa5G6DbvaRjly
	 d62zA2TDp0F3Izc9RRLbAuRbNDKrigUdXrVHkVboSUNxRhrFfLTkX4W71Y8YIwcjJi
	 d8VX04xfxygqE6YawnDzx/9sMGA1TB0JlGZ2WTMWM14gbWWIqaxMyZfwjya90gLv3o
	 A/Xb+tAVf3TydkNwh6ltpdAdVogGdM3D7CzwP4eyCzJsRJKWgFO2nixfTiuyfNYxw0
	 ZPOvyJH87JNOw==
From: SeongJae Park <sj@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ye Liu <liuye@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/mm/page_owner_sort: add help option support
Date: Thu, 16 Oct 2025 18:35:22 -0700
Message-ID: <20251017013523.112897-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <51f86d0e-e9dc-42ef-baee-0dfdd39b7cab@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Oct 2025 09:19:09 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> 
> 
> 在 2025/10/17 04:10, SeongJae Park 写道:
> > On Thu, 16 Oct 2025 13:49:25 +0800 Ye Liu <ye.liu@linux.dev> wrote:
> > 
> >> From: Ye Liu <liuye@kylinos.cn>
> >>
> >> Add -h/--help option to display usage information and improve code style.
> > 
> > Looks good to me, though I have a trivial comment below.
> > 
> >>
> >> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> >> ---
> >>  tools/mm/page_owner_sort.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
> >> index 880e36df0c11..202eafed66a9 100644
> >> --- a/tools/mm/page_owner_sort.c
> >> +++ b/tools/mm/page_owner_sort.c
> >> @@ -669,14 +669,15 @@ int main(int argc, char **argv)
> >>  		{ "pid", required_argument, NULL, 1 },
> >>  		{ "tgid", required_argument, NULL, 2 },
> >>  		{ "name", required_argument, NULL, 3 },
> >> -		{ "cull",  required_argument, NULL, 4 },
> >> -		{ "sort",  required_argument, NULL, 5 },
> >> +		{ "cull", required_argument, NULL, 4 },
> >> +		{ "sort", required_argument, NULL, 5 },
> > 
> > Seems unnecessary changes.
> The spacing changes fix inconsistent formatting in longopts array.
> Since the format fixes are simple and in the same context, I put them together.

Thank you for clarifying.

> If you insist on removing these changes, I will drop them in the next version.

I have no strong opinion, plese do whatever you prefer :)


Thanks,
SJ

[...]

