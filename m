Return-Path: <linux-kernel+bounces-727941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1EB021A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FAE16A881
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E22EF64B;
	Fri, 11 Jul 2025 16:24:22 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62BB1CDFD5;
	Fri, 11 Jul 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251061; cv=none; b=YvNr26rghOded4HGa3pjMEWYOn5N2gqrI4H2kRkfC3qw12sNG+OYI+nry7hSOFhOGMWnFQoSh9sMe5v/85D47bMcp8VrBMupUdegNZxnQFjMwi6O2grGJkcygikQxLrscPPvKvp1sOgemmu1CIA0KruVimOP/l9mbiV4zG96PMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251061; c=relaxed/simple;
	bh=B07AFIXz8x2CBNkfSGAD1YIVHaOwa73nqUf3T2GkWQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3gqEmGAS46sPceFmZwtpJ2lJ2toXG/6lVKA3yiW6vyCeHWs3yqTo5lxJprQFrZFnBORaiBJb1dHqUU5YziLjtSK/yNGzaLa+8E5aZLR46Z61tq97u1QjQfgG5plSX6k+qx1jtRcJvD5jZWyYXWQTIiZ4HQttC3FJBeXk0RY78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 0A82C5D512;
	Fri, 11 Jul 2025 16:24:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id C07B82002A;
	Fri, 11 Jul 2025 16:24:14 +0000 (UTC)
Date: Fri, 11 Jul 2025 12:24:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix up build issues with vpanic
Message-ID: <20250711122413.15b8456f@batman.local.home>
In-Reply-To: <cover.1752232374.git.namcao@linutronix.de>
References: <cover.1752232374.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4fm9d6grjcfjrxhitoc89phodocr3w61
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C07B82002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ZHgneXBDZjZOMaJc5MGp5oQDB4BbUZuo=
X-HE-Tag: 1752251054-968879
X-HE-Meta: U2FsdGVkX18AurL+Ktxdx9Vo9Jj+ixQ+eTFaV91s4dRUU/gI5AfKNrmcoRqkzE4Us1A9DBo1w73xAWUFOfFoeking1IC46yBJUVfUpY/7qfGytILr7ecrcIXt/+PI979Yu3+F4eT4Q3YWrscLnHqvBW+1RZcRi8OwEISVoGNZDt2JO9ivi01GnXhfNj51KhssMGgaxZrKlfKvoDosZehKOkuuGQeGMtO0XU6AMZ5Pe/GA3YX3HJI2oMwG5yIlCkeRYPMaknMvJGx7KFuNKe+LDsZnys36ghqaUsJ5I8vV11FgyHLZuNwGzd+zyqSt65C

On Fri, 11 Jul 2025 13:20:41 +0200
Nam Cao <namcao@linutronix.de> wrote:

> Hi,
> 
> The newly introduced vpanic() has some build issues. This series fix them
> up.
> 
> As the vpanic() is only in ftrace tree for now, it is probably best to let
> this series goes to ftrace tree, if everyone is okay with that.

Since the bug is in my tree I'll take it, but can I get an acked-by
from Peter or Josh?

Thanks,

-- Steve

