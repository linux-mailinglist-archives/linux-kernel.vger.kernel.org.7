Return-Path: <linux-kernel+bounces-890827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8236C410D7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99C394E83F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7C6335071;
	Fri,  7 Nov 2025 17:36:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97324DFF3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537004; cv=none; b=pGDepSMjEFmcXNYJ3m2iB1sgQKE1CaFt+7IctJmW5BXIRyoNjO6MeFtbggusNrTrr9vyGySpEGKl+XsqgaFiYuk//zD/tPpDaI6mdEP5NEVSDDKCWmnDl3Dc5q0fq/MYztJWrrqP3UKOuNWU6Q6W8/A+hJyiCKMRlHSCHVjNZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537004; c=relaxed/simple;
	bh=1FondDeDCTGznWVHUCg8nQ7VBrZtsywoGfADbYgzvn4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pAoIBgHRb/dSVKVj8WM5IQch/YbHxIBi43PaDbC5awrS/vff/jVqPknnEnagJrj++rfNgayxaIwfBNnhJOjngvSuxRVRXNo4O90G4MtMmyEfPkZy6ZzC0cB8uuECooz8MCpxOSQLXeV1pPMzIhbmEWP0dy+ze3p7FTYnXrZzER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D7BCD88E09;
	Fri,  7 Nov 2025 17:36:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 949A36000B;
	Fri,  7 Nov 2025 17:36:31 +0000 (UTC)
Date: Fri, 07 Nov 2025 12:36:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Subject: =?US-ASCII?Q?Re=3A_=5Bfor-linus=5D=5BPATCH_3/3=5D_tracing/tools=3A_Fix_in?=
 =?US-ASCII?Q?corrcet_short_option_in_usage_text_for_--threads?=
User-Agent: K-9 Mail for Android
In-Reply-To: <af44f010-313f-46ea-b1ef-9be43bbf4f14@efficios.com>
References: <20251107130730.158197641@kernel.org> <20251107130758.272051237@kernel.org> <af44f010-313f-46ea-b1ef-9be43bbf4f14@efficios.com>
Message-ID: <8D8513E9-6527-4AFD-B8FD-146448D867BF@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: mmmegaa7o7mx7hxguguuu5sfuzrsiz3p
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 949A36000B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX196iZTFHedHkhRyK1IGdthF+gtP5YYNHNM=
X-HE-Tag: 1762536991-900020
X-HE-Meta: U2FsdGVkX1/G9LpLVrW9HX7w8oQBPMUhTLxqy78Gy+ZegSOgITgKkjyhvjBOnfpvzK/euLbPjoCTD+m+qUStDXDtwvRSOg2MCyOHIYB350USv2QCGYRzUbDSuXMfAocdtFRQD/axdku9TaHmBOPgWHb/S5ce84f06KShj+EzOLhGiCLaIS3gFxTuuQqY90EKzCO6SBmtNGtMvYkMRdwTd0GJszkRKh1OpbB5ETocmijuxIwRbSCTmnqKEht6e9RlMfZxQIR2C4fz795odhIX19oLywz8iD5D3X+by2Ei2wRJQplva2ahkdxAtrIh3rk7Cq/W0pf14QCnskLU6OKglViNl+l3b+OW95fy/NMWlpwdhU7o5r/f/yc3mFM1x6ZRqm+HLVAlggGuawpJIkU55Q==



On November 7, 2025 8:37:13 AM EST, Mathieu Desnoyers <mathieu=2Edesnoyers=
@efficios=2Ecom> wrote:
>On 2025-11-07 08:07, Steven Rostedt wrote:
>
>Nit: Subject: incorrcet -> incorrect

I saw that just as I did the pull request but figured it wasn't big enough=
 to stop the request=2E

-- Steve=20

>
>Thanks,
>
>Mathieu
>

