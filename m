Return-Path: <linux-kernel+bounces-747133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD31B13026
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CBA16CF37
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C421B9F0;
	Sun, 27 Jul 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="qcIWYj2X"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987844A33;
	Sun, 27 Jul 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631153; cv=none; b=tJradgoOqc7c5H9TURbDAyoTBbBtbQ3ZSwvUW3IaDuCfVVVUqsiEFwuSff0ldtKKpRga/o5BduVtb4bU/K1ZNbEYExeOi0xGifUBpXdzCb0jPXsT01fxE6SwY6fmIdfDOTfBadX0UPUR3a5aRhc06F3Ily0DFAMi+bJIqBcz0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631153; c=relaxed/simple;
	bh=Nx21Y2DmhvfADZ/RHwGwoASysh8U+aJewA5Rlqxh83A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJh/dvbjn/xfGD8Mo4GkQi+kdXwLHV5qhDLgziEfh3TAxxubnUIJ1L7y2Xil/ZKmRSI7K8xn42tZ0yagQiAeNvUJdDuyX3Es84paNbt0l8S23d/5R1EZ8IP0kJ1YUlk38PW0UgRnTQD6jdVBzvlUK2PXxKCj7926RErjVpuaGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=qcIWYj2X; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=3fxOLzWgOAR/+T3F8n9Mjej5S8eRwkPAUZo9dLFoDEw=; b=qcIWYj2XBgTEAk9R
	L1UsQGa+/Mc5XBkgRtzArY7VkXGj25i/aTPimjDCAZ3zIamSBdR1G2KohDBcol3nNuJ31Yq3xwCqQ
	CUYk3R+FApZvOOor8In1KXxoiyMZu+MMFQMB1PuWHf2Az6BMcqjf3XAyeqTPtJiFdFJOKBo7JJF2/
	L1+p16uZ2WVBbdwQRLV5U+D6kVeQtAgsoBzLmzKJveUFFGzzzGx0h1ZHP9C5oJnIhIdXvbdQKNTuB
	no3iyZz/T4Tr9jo6yaiVScw+aYtEijcDGlcBxRs5fhr6MhZCYBvj4tsNvYWu9W64al+sTkECP+SuI
	f85Ij9MoRSL4NzRAQw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1ug3ZG-000pTt-0C;
	Sun, 27 Jul 2025 15:45:42 +0000
Date: Sun, 27 Jul 2025 15:45:42 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Kees Cook <kees@kernel.org>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Sasha Levin <sashal@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	rostedt@goodmis.org, konstantin@linuxfoundation.org, corbet@lwn.net,
	josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <aIZJppabYBCDBhYJ@gallifrey>
References: <CACzwLxg=vQeQKA1mPiYV9biu=swo7QDmjB3i=UhYmv+fGRBA4Q@mail.gmail.com>
 <053939E0-5BAB-483A-9FE4-92BF35201A4C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <053939E0-5BAB-483A-9FE4-92BF35201A4C@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 15:37:30 up 90 days, 23:51,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Kees Cook (kees@kernel.org) wrote:
> 
> 
...

> I'm hoping to add runtime testing, but the hurdles for getting it to sanely interact with a qemu instance is tricky.

When doing qemu dev, I frequently run it in a tmux, and start it with
'-nographic' which gets you a single stream with both serial and monitor in it;
alternatively you can get one pane with the serial output and one with the
monitor, that takes a little more setup;

anyway, then I can do :

tmux -L $SESS send-keys -t srcqemu "cd /mnt" enter

and have a wait function that waits until a string is displayed:
# pane string command
function waitstr {
  PANE=$1
  STR=$2
  CMD="$3"
  until [ -n "$(tmux -L $SESS capture-pane -p -t $PANE | grep "$STR" )" ]; do
    $CMD
    sleep 1
  done;
}

so do:
waitstr srcqemu "root@localhost" "sleep 1"

it feels like it should be fairly easy to wrap some of those for tests.
(Beware the 'send-keys' command is a bit touchy about what strings it takes,
but it has some flags to help).

Dave


> -- 
> Kees Cook
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

