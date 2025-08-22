Return-Path: <linux-kernel+bounces-782593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E9AB32286
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8175C3B0600
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AA32C21D1;
	Fri, 22 Aug 2025 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZnkQc/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5DA2C159A;
	Fri, 22 Aug 2025 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889209; cv=none; b=tJZ3lN2/sZ7e9gBwp7tEnPGNEf3X01jzYUbLhUyGqZoCGrDQw3c6fPvDhszt/deOpjwcDMLIq6nwx1XTe5gI36VsmsU2MrayFlhXt7+Tj1DdsW2gX7Hd0rKZOZ87PyYJjHOM5CP0bW0GQN73KgP26WvER8dmuSkLz6bajhsghE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889209; c=relaxed/simple;
	bh=YpGCkypuiUiQnT0mRRGycvHjXvj5xUGje4nVXtzQtps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdOY25MX30DvP1pok03UT2n/2bup0Q/lFdbW5+aoJuUv+rNgB0yuTlpJ+mbliAj8y5wnqysJHA4dkrlxfKhxtXnsOsaLkFf2ce9LeFmknm+E+71xct5yr+qfCaru6XHSxtc19020B6E5ZTX9IWQr59KLU8g8+UaqkJGXqfBnM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZnkQc/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EFAC4CEED;
	Fri, 22 Aug 2025 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755889209;
	bh=YpGCkypuiUiQnT0mRRGycvHjXvj5xUGje4nVXtzQtps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZnkQc/rDiTeuQAUc0erQpqKZnK4IEuQFRuoqVC5exD8EbK0zPzdzHkOHdwU+QovT
	 Bo3chm15cUqDQB762Xe1TYny4GQx34zgmzQYGP0zrRYSvxMk93Ha1Tnwzoc9/uSp0W
	 ScHLVcEmrkymoPLYaY7uCBiIywYsNYPur8kOgVx5R38YvJSWDjA8KdwOIyoB9d6qpy
	 49uI+4mY9kSo7tm3EpDl/IHvi/1/sV3JroihrgAqhysMx06v9VjMrjnmP2t8D/zzO0
	 /I4qwWUE57yaz/xoFSUHlKs6BM9CydnfZvkeWxTdiHYyGK/1XhuormLIzHx9Dewnb8
	 Y0wQlszNtNJKQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Yunseong Kim <ysk@kzalloc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tejun Heo <tj@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hyunchul Lee <cheol.lee@lge.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Minwoo Im <minwoo.im@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kukjin Kim <kgene@kernel.org>,
	Chanho Min <chanho.min@lge.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	gwan-gyeong.mun@intel.com,
	yeoreum.yun@arm.com,
	Mingi Cho <mgcho.minic@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	austindh.kim@gmail.com,
	pmnxis@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Documentation: cve Korean translation
Date: Fri, 22 Aug 2025 12:00:06 -0700
Message-Id: <20250822190006.49120-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822185550.48996-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 11:55:49 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello Yunseong,
> 
> On Fri, 22 Aug 2025 22:18:29 +0900 Yunseong Kim <ysk@kzalloc.com> wrote:
> 
> > Understanding the Linux kernel's CVE handling process is becoming
> > increasingly critical. This is especially important for Korean companies
> > exporting products to regions like Europe, as they must comply with
> > regulations such as the Cyber Resilience Act (CRA).
> > 
> > This translation aims to raise awareness among Korean kernel developers and
> > companies, helping them better understand and adhere to the kernel
> > community's security practices.
> > 
> > The translation is based on the contributor's direct experience with
> > the Linux kernel security bug process and obtaining CVEs. Furthermore,
> > completion of the security training program provided by the Linux
> > Foundation ensures the necessary accuracy for this documentation.
> 
> Thank you for continuing this important work!
> 
> > 
> > Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> 
> I left a few comments below, but those are trivial and based on my personal
> (mostly uncautionsly biased) opinions rather than blockers of this patch.
> Nothing really stands out to me,

Except the below request to remove my name from "감수" section.  Please remove
my name.

> so:
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Please take my Reviewed-by tag, only after you remove my name from "감수"
section.

[...]
> > +:역자: 김윤성 <ysk@kzalloc.com>
> > +:감수: 박성재 <sj@kernel.org>, 김동현 <austindh.kim@gmail.com>,
> 
> It is my honor to show my name here, but I don't think I deserve to be listed
> here.  Please remove my name.

Again, please don't add my Reviewed-by tag without removing my name from the
above part.


Thanks,
SJ

[...]

