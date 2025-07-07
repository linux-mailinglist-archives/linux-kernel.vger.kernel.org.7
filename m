Return-Path: <linux-kernel+bounces-720613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAEAAFBE43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65281707C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D645127B51A;
	Mon,  7 Jul 2025 22:33:38 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52602261595
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927618; cv=none; b=txZPuypQZ+zhJ8sY4R7Ey+GrB9+FXpnKh1n9pDngNJJAerB4wLtM7BRqk0UqEO2JOfPy+Ci/OL8B1RU13ZDs998EjW4XQicSLe3OY8VXXFCK+GhFx0ymA53w2n7JTBgoKaKVNoKjzp3s1mhyutuYgKfocvdGUCCTSEtU84hvrZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927618; c=relaxed/simple;
	bh=gHuOtVbKthgr22SBGZy/A0wvt+qeFmQUe444seNla3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnWxZj+yGmqiB9VypgEhkJ3bAMdSqrKI6LphjkEtf4MVMrg56E5o6HxutssSe+QEkiFKAFFB6JZgte3SwcHb7ch3xUFO5bRZwT0LeT7VIsmLG01OuZjT0LKtknz5oaiZX+OqWwM7KMeqNgqLf6Vo0QGMxij+P5F15lq1+HpsV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 81F0CB9379;
	Mon,  7 Jul 2025 22:33:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 0D1322002A;
	Mon,  7 Jul 2025 22:33:31 +0000 (UTC)
Date: Mon, 7 Jul 2025 18:33:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Li,Rongqing" <lirongqing@baidu.com>, Peter Zijlstra
 <peterz@infradead.org>, David Laight <david.laight.linux@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vschneid@redhat.com" <vschneid@redhat.com>, "mgorman@suse.de"
 <mgorman@suse.de>, "bsegall@google.com" <bsegall@google.com>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>, "mingo@redhat.com"
 <mingo@redhat.com>
Subject: Re: divide error in x86 and cputime
Message-ID: <20250707183331.029570bf@gandalf.local.home>
In-Reply-To: <20250707182056.66a8468a@gandalf.local.home>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707182056.66a8468a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8biuro3kk731n1rhaipw8c6wmip4uc1s
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0D1322002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18yspf9x5BL3vabmTX9xXWNr0IMyvZTkUU=
X-HE-Tag: 1751927611-184412
X-HE-Meta: U2FsdGVkX1+GZHjmh4I8/ObKNWNaz5K9EYO/QRXkFLTg5OdJ0oj5R3kbVPyknrFVDaX4i0Kks4v5nwnk6VjeXhyIaCZwPkGQjBsH4v53bmsLlW4ptQiVQJEncnwNLLfOUqdslZcpVRRVQRwzmQbBgX8hUHCTOqQf9RlXU7cEvpzyBNAjEk6g130gQ30LMvvO132SAnhtKUiufzbE8el5cQAH22Q1ctTBVWK2G5g5LMk0F1T2u48f+V3b4HQkJGZY9o0cUuaOEUHt/ZjvmyugHU4NO4djwwVMjSTPFjPgYFMCusxir6Hmr7TfQFX8S/K1r+WH74m4pzLF2vWIr8SRR795gbuYNv3c4545PzoFyqtdNVAlOJTFRS7tzfsA1kdj

On Mon, 7 Jul 2025 18:20:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I would say this should never happen and if it does, let the kernel crash.

>> [78250815.703852] CPU: 127 PID: 83435 Comm: killall Kdump: loaded Tainted: P           OE K   5.10.0 #1

This happened on a 5.10 kernel with a proprietary module loaded, so
honestly, if it can't be reproduced on a newer kernel without any
proprietary modules loaded, I say we don't worry about it.

I also don't by the utime + stime overflowing a 64bit number.

  2^64 / 2 = 2^63 = 9223372036854775808

That would be:

                                   minutes    days
                                      v        v
  9223372036854775808 / 1000000000 / 60 / 60 / 24 / 365.25 = 292.27
                           ^               ^         ^
                        ns -> sec       hours       years

So the report says they have threads running for a very long time, it would
still be 292 years of run time!

-- Steve

