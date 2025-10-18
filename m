Return-Path: <linux-kernel+bounces-858911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88549BEC38C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33B0E354218
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4322F1DEFE0;
	Sat, 18 Oct 2025 01:31:30 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D9126C17;
	Sat, 18 Oct 2025 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751089; cv=none; b=N2yDfLn/HFe3Vuij439Lt9KO9qhAs4TSZGKPVodQ06RH7FH9ITxqKKtdZNUWr81S+4h7njVpMkFedKI4fKn8tFAQOhOwJ6oVgbgNk9bsap3QkTU3ZXHLJ5Cg7aJd4tzDw3Vsw3/WNv3qIVbewsOU68yW2nlze4FYd419+Z46voY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751089; c=relaxed/simple;
	bh=jVgd9xIpvYLv/agHOy6+SNyn5rSLqBCQfxjIHngMCpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAD+ffzE/YsvVMp2kiUL2HTU3tquVfn0FeneN/dr050WjrRfCt6nQAFNgXSdX9vylM6h6VsrNxWktrSqe4F6BBXDFiH4M9bIiAKCM0MWlEHS6l4ujrnpmtqWy2x9y1ZnV9TtnLA+1j1KkeTktThuUOES/fwZtaYpqgu7Ptd5PkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id A2B3787960;
	Sat, 18 Oct 2025 01:31:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 4CDAF20025;
	Sat, 18 Oct 2025 01:31:24 +0000 (UTC)
Message-ID: <56f8e40af81a425784cc7f4b9f52038b8369a6d7.camel@perches.com>
Subject: Re: [PATCH v2 1/2] docs: checkpatch: Align block comment style
From: Joe Perches <joe@perches.com>
To: Brian Norris <briannorris@chromium.org>, Dwaipayan Ray	
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap
	 <rdunlap@infradead.org>, workflows@vger.kernel.org
Date: Fri, 17 Oct 2025 18:31:17 -0700
In-Reply-To: <20251017203719.1554224-1-briannorris@chromium.org>
References: <20251017203719.1554224-1-briannorris@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4CDAF20025
X-Stat-Signature: 7kyh6fu5dtxfbjtrd541yoar7dem8fpb
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX183EUSH/kjwdzjsKSKYPP/EWyXCuX/uUCA=
X-HE-Tag: 1760751084-403119
X-HE-Meta: U2FsdGVkX18PFh0EDy4eHBdRU6mdjxbelwAvSIXsFZI0dWLaDCcscFTpNNpoeknZjgDOxO0IMzrZmeZfTgzkoh2bvihQHlP7lZgjukA1CvdByjBWZ4034Lsr8erkX6iy00YjVLoe8jCeM0AhL7/OfmEYqViL1zwMlNdc9PyDY2aosaixk8AUaAyPKJInZAsw9WDMm0DlSp9U9Zlz3yaqcr61hXzqJB7qJYnrnapz8pJ3rpfZ8tijmg2XMKJehiYBCaNs52w2yGvwUKM820V8melBWrg8xWFHVF2P1gUEqm0Dyg4Gh10xhd9tzPcjAG3a

On Fri, 2025-10-17 at 13:37 -0700, Brian Norris wrote:
> Ironically, the block style comments in the checkpatch documentation are
> not aligned properly. Correct that.

<snort>  Thanks.

And for the deletion too.
I didn't know about that changed.

