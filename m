Return-Path: <linux-kernel+bounces-793983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD5B3DB26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13479189BE6D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB16A272E5E;
	Mon,  1 Sep 2025 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="t5K/FdXe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9pH8I4e"
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF326C39F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712027; cv=none; b=VeZ4qdVQZmaYKrsq6XxmkBBMS6XsDIRqeaS6heP+VjIC/eX5UBVIZKVfe4SEKiJpu/r1uzYkvVmM9pYQL17Jq4dGR0vZ9OlLL5cB6rjut1w0QndKQsxBVHzVbRPKVr3RULaFUkHyvjaxmy3R96FWUKW1ZKJ+iSvVR6ly2QatCbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712027; c=relaxed/simple;
	bh=lvFxhKXCcw+AoQxQLdV7pkmoY5luQSrtl9cwHURPrOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kes1MR/Xks1+VqY4yeARvXjVwmC2qF8/PbD4fwiY6a13f2NSNHxK6lHR4ASLsoDTWi38drcqFMc+D2r1zAu8i7ysDvUOOx050//S1cV+cwzTCK9RjpZTW+E4s8ZYA94Prr8bVvVicJJzpfyYIsOMjdB4eiX8GjgX7L4r9T1k8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=t5K/FdXe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d9pH8I4e; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id DB6E41380899;
	Mon,  1 Sep 2025 03:33:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 01 Sep 2025 03:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756712023; x=
	1756719223; bh=kipqqFjvNo4Y7cKqBGTxkuUKZhPOTVfUMxxW+rU6c9A=; b=t
	5K/FdXewrZ/2RM0ILP5bn/BSgfkppqHgUi3igvqnqeGA5aDPWPJsC/LdoVYaofkA
	sJ32mSKBRiJa8wEp8Pm6HwjCR7WJHIdCBFafpeUeZTDqwvs0XLoFm8Nx+WcTIR73
	HWg1Ct9+WQLc9Xf2uN4BqQOzmfuZx7XjslJnxWo/znyIhanaxEaDyc1JyasghSJU
	tOHiZjv30PsIGYfqjBDfObB0Xf686lH4t6T1jB89tlhNril0TX+vZBW950L/RIRJ
	tViNZSvTBph5SioKh8trP+mT2glGwhsuWv+0lIJqNdQsdnxMgQJ7g/brwLNKXg2A
	imc/wCaOCJtzOJNa9Dx3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756712023; x=1756719223; bh=kipqqFjvNo4Y7cKqBGTxkuUKZhPOTVfUMxx
	W+rU6c9A=; b=d9pH8I4eJlpTVAKsPhcxy3QKdiHStJQ7QJdlktmIl4Kzsif8Inp
	PIWU8XuJavqBtq1c+/CvuAUaIvfLjsdVguBAmOYirGLEyn1ueUWf7w99pi/b+WTN
	54JMBGOmGUBB9NgsFYsEmlEK5QHz0JxsQOvVWkPFfIhtjks2OBa4cpF23fD3pRjy
	eOgg41MipZwrC9fRhUsr2k//nypy+asK58+6tNYD6aTOHhSlUS+MwkBi+FtlBFRE
	DpVFdqBdWqftW4ifDvUe9AjtFGAgr69HFNWQskc+iF5f8oqSkCu+gl1V/dmk8Rum
	/O1oQLXSkDHaOYDssQ6j9e3nVAEVq3tTPDA==
X-ME-Sender: <xms:V0y1aBr5HiwXCvRLQUdKYZUC84eaB_o-kdsUG2icLXzarDBxSvBTGg>
    <xme:V0y1aKkmys6-VIv-rPjYo7HZNXEeXy5W-jnSzSW_8mjrOrCPoeMZkMXEXPKUDOdhE
    fX4kt0KgHUqBNu8SaY>
X-ME-Received: <xmr:V0y1aHKBDaeXz67Axu793x2bRGZSUbTJYEscAPZ-71awhVphpMEZ-xhJZg-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeef
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrgidrkhgvlhhlvghrmhgrnh
    hnsehiohhnohhsrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegrgigvlhhrrghsmhhushhsvghnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopeihuhgrnhgthhhusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifihhllhihse
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhhughhhugesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepmhhhohgtkhhosehsuhhsvgdrtghomhdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:V0y1aEuB8tB740d972UnXCn45IlKHzD42mDAtCYsahDqJ9tLrBW_fw>
    <xmx:V0y1aLJRG_CNTVDYmXinLvFryldEDJCWT6y7yCMnquXYmM1Te1Z9-g>
    <xmx:V0y1aPH1gHI2QNDi1NhCPg2FjwKx8asUSsXJ8pN60onRx4q0OOgobA>
    <xmx:V0y1aPRbDGazDrF3jETq-sSMS-9GHWFnRkBwkSwLzvw2MQY1OVH1Ig>
    <xmx:V0y1aMr7Kb1WDmz7LMq0yZ1qG7t19mc6H_PSdsnscLmn-4dWYOatGyWi>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Sep 2025 03:33:42 -0400 (EDT)
Date: Mon, 1 Sep 2025 08:33:39 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer
 parameters
Message-ID: <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831093918.2815332-2-max.kellermann@ionos.com>

On Sun, Aug 31, 2025 at 11:39:07AM +0200, Max Kellermann wrote:
> For improved const-correctness.

It is not a proper commit message.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

