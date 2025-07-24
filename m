Return-Path: <linux-kernel+bounces-744514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43BB10DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8043BAA0E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1393B2E1741;
	Thu, 24 Jul 2025 14:40:19 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D5A1632C8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368018; cv=none; b=qN3/icxiByRBgmZxnzNogLK+PlsfYtjMO76iUkddXEb6i8yjPKwMmxHmO2+5QzyT4n4IZ3fO4wOSw5xjGAAlq5d0QdiLRYcqW3DB2Ps+O6BLh366u4TG/XxYzEpUskAx6mnLdYpy3dJ9AhM1HHKeWhgE18mONgN04tNtttOqgF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368018; c=relaxed/simple;
	bh=Kwuoyq20gwdsTVsdtghzGtITJ0UjutoXvACwhACeCiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUSHBMSVtwk/BytQZpf5uPnWsBitR6hGiBQy6+VygBSiTUv08H1P8epJOmLJI/QtueqO1H5Rt6cezf5v2LmgvHPxNL93Gi97QCoFaTwFI4ppreNyi382vaJwk2Pv2+AjIu6zHQV04KT2TFGMpu74CqZXxdbp5wLdy+LkkeATHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id A052B1DA9ED;
	Thu, 24 Jul 2025 14:40:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id A981C2000E;
	Thu, 24 Jul 2025 14:40:12 +0000 (UTC)
Date: Thu, 24 Jul 2025 10:40:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 0/5] tools/verification: Improvements to rv and rvgen
Message-ID: <20250724104011.7b4e11d9@batman.local.home>
In-Reply-To: <20250723161240.194860-1-gmonaco@redhat.com>
References: <20250723161240.194860-1-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A981C2000E
X-Stat-Signature: a6nbh7ztt5szjp311cqzqzeut84dzrmh
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19EN9ThY9TULi3xMVLYQbWQ2504qJ9g73M=
X-HE-Tag: 1753368012-784414
X-HE-Meta: U2FsdGVkX1/LPy/XQXXx86Alo4Ag+RkXiQ3z2IGQglRa6MrzBt80JHCY1a041IY5I8VUuJMHgtLIWv6tzvzfrCqqA8Wv/4TJS6Md+LPNQUmwhJaILO0U1YesaEWUDZPrWamdfpFxHS+UhKydsYmTHNhq0lgnx2HYLKi6jHhs/1nsrjb/Ci02KQ0/LYno7S0wVDqq8wmt/b8iXooRZx2TutyX3e1inJGEqXh2N+T8Sx6slYGB/0U3OWRCaZlPbFYA8mBdshGdXDjoy453UL8nWx6CzHo9gfxe1570PzJSoqq0+q2aXzK/N8IZqvgYNDue81jlKVBLbXe77LonpdOW0Yo0+vYAo1GM

On Wed, 23 Jul 2025 18:12:35 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> This series introduces various improvements to the rv/rvgen tools as
> first posted in [1]. It also adapts generated kernel files accordingly.
> 
> Specifically:
> 
> Patch 1 fixes the behaviour of the rv tool with -s and idle tasks.
> 
> Patch 2 allows the rv tool to gracefully terminate with SIGTERM
> 
> Patch 3 adjusts dot2c not to create lines over 100 columns
> 
> Patch 4 properly orders nested monitors in the RV Kconfig file

So keeping tools and kernel separate for RV is proving to be quite a
pain as patch 4 has conflicts. I'm going to make a third topic branch
just for RV. This will include anything in tools/verification and
kernel/trace/rv. I'll restructure the patches I already added and move
them into this branch, so that all the RV related work is there and not
in the latency or tools branches.

So no need to separate RV into kernel and tooling anymore.

> 
> Patch 5 returns the registration error in all DA monitor instead of 0
> 
> This series is based on the linux-next tree.

The topic branches I'll have is:

tools - for things like rtla
latency - for the latency tracers (osnoise, etc)
rv - for the runtime verification work.

-- Steve

