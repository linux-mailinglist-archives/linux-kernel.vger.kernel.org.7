Return-Path: <linux-kernel+bounces-728621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC0B02AE5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 15:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9F2A62E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 12:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C3274B41;
	Sat, 12 Jul 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="V/zBlI5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DBaXuu+0"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9961EB5E5
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752325218; cv=none; b=i3Ym01akcQZjURKvgOZVwq5GXx7mJVpzKLT4Ks3AuACW1IPrk3V+p5jYc12A9eDgD++Yno+1d5aQOSJa1m50yfiOSB6jj1oOA1L9zlT+5eC2bEWaywoVC+ftPpU+P1SQ780dIepqnCVE/1v6ySOficC1xZ6YLBYj6L08IFBlt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752325218; c=relaxed/simple;
	bh=4XGjEJ68hrsWjBZEvYa9c7y7AGTC4LOTmS1S7Y3Vo2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRsvIS/PUcFEVBT3Um7HD6b9Fo8whVtB3Ue0NAGBc5EYOeJp3jpAsS6hmDRjNh3lxIKE44aRyoiFwSteceQgsynbw1dC2CgbMr1zQfR3lkVoY/0Si3Sfk6c5Zq+2xRXzfLVc0y//u82rzvf+T0udzGDov4to0nxtUaFnyihpfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=V/zBlI5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DBaXuu+0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68BD37A018C;
	Sat, 12 Jul 2025 09:00:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 12 Jul 2025 09:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1752325214; x=
	1752411614; bh=jui/+QSpzZNpNgRjCQ8+CrBLxFIQyPUBrGF+R44rlAI=; b=V
	/zBlI5HKTcvYX3YLS2L01uyT6UPgfDhrzLsW8FxZRkpA/1hCoatvQOVmGUuhURzW
	dlENfB0kW50L/QVlvrXf8I1HiMp6J2LNI2ZdeEc48dHCGZPmB+ba5zACp3RSydpw
	Qe24RpCxmO4qnmDYEglW4Uir/py3XPD3e/UJD9cvO6whouXgBJldAfl5kFcHmDnM
	0a+0XghcAsDvB4S19/OmtxE8FVyMiPqtY3QFS8Jri8w+EAJuMDXXp4EFL+k4GWer
	owtUdhKsACGEZst3NZQWViZ20mEyG1pD3jJE1gZ+1y9HV5gQGrCBld6WqeZ1p5is
	jIkCQ+Aq/U5/Xo16o644g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752325214; x=1752411614; bh=jui/+QSpzZNpNgRjCQ8+CrBLxFIQyPUBrGF
	+R44rlAI=; b=DBaXuu+0KfaXZ2lho9YdzIalNdknGeA+qCPl++KrGzaDX2DAI+P
	aCsXQffriq3i2PHsAjlitCcx+YaZlS4lAmtSrzKhHd+2a4vWeIscbLEfqdsClkuL
	LQwmGhCmWjk4SgFbGCstmJrtQ8YCKC07n1uAnpT32TsRM677s/cnKDY7LICSLq6O
	OCxNBxnWMUJaM3/I7TX49fU27yZQ/CjpyrlSQbHzd+yKgEk2q0EsRjjg8e5jSc7j
	NP7LipMLwQz7CnT62xQ/GDrT62RT1lX0dfBN0Kk4OAfBKPIFXWVawT08kOw2FFnn
	+pujbC6R3B3Q8+o5WM8Iu/zpYqJ3CLJMeEw==
X-ME-Sender: <xms:XlxyaDtLWut_vTt0Crq3pXc78BoDaUiXJascm0caP_8cWxkq50Ly9w>
    <xme:XlxyaNaHM8OD8hoa7T13SwewVdQ9L5cMtkWyckdybwqumeUGN9FYe_jFcHuqe2RIw
    Ceg9uh9i_Na1ts8bxM>
X-ME-Received: <xmr:XlxyaIsF29MmdZcJ0mfhy8xOFrZwF9cgMo0ZG_df5h9H9H5FI88YwA4Egs4Dq4lJbOYgiz7wZCGMkS9QnrlFoQ0-yPihTsT6n5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegiedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgke
    dvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XlxyaPHw9Hwlgp9lnHoAhb6rB3QqUuksUgPMqp45hR1p4FlnXGgucA>
    <xmx:XlxyaDwUwRL62kuNqlsrQ7JfcOlJDjQaRXi7WRqJJTmL2UK7sRdC5A>
    <xmx:XlxyaOiNMVg5LqH1ipQe0AQCv5NOAEPPAz7a_IhFz7326i7UGGKJ-g>
    <xmx:XlxyaGxfQv3zZU5vQ4ZOKIwEduUh6_kADgvliZivoxAIFE49wKOnKg>
    <xmx:XlxyaIQq6y9Gq4Df2LwRFGYhdYfHp9Ytdr6qZCiGUYuPRGbpC4wUY92t>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Jul 2025 09:00:13 -0400 (EDT)
Date: Sat, 12 Jul 2025 22:00:10 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: ohci: reduce the size of common context
 structure by extracting members into AT structure
Message-ID: <20250712130010.GA126510@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250710131916.31289-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710131916.31289-1-o-takashi@sakamocchi.jp>

On Thu, Jul 10, 2025 at 10:19:16PM +0900, Takashi Sakamoto wrote:
> In commit 386a4153a2c1 ("firewire: ohci: cache the context run bit"), a
> running member was added to the context structure to cache the running
> state of a given DMA context. Although this member is accessible from IR,
> IT, and AT contexts, it is currently used only by the AT context.
> 
> Additionally, the context structure includes a work item, which is also
> used by the AT context. Both members are unnecessary for IR and IT
> contexts.
> 
> This commit refactors the code by moving these two members into a new
> structure specific to AT context.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/ohci.c | 92 ++++++++++++++++++++++-------------------
>  1 file changed, 49 insertions(+), 43 deletions(-)

Applied to for-next branch.


Thanks

Takashi Sakamoto

