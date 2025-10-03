Return-Path: <linux-kernel+bounces-841546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA4DBB7A07
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 816BE3474C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38CF2BFC9B;
	Fri,  3 Oct 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPsv2t/l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF72C21D4
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510609; cv=none; b=bTpHhOGT4m9FIDEDIC8SGeSQa3ZYKe3VnnYOrd98xHooyxThs3hgXupnpf5BPLPScW3gMaxGmKyd39xXQ3W6V5sIinfk/KciN+wTK8A5arcRZh0KA1UqrJgc6p0karxJnh4gjByjKDIIOoHfmsfNVJh9C1v3v9NMkGLZ4uLK3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510609; c=relaxed/simple;
	bh=JV3UpCx5Xkf4WnYDKXQq5+YoXg9RglDY2VFNOWzZ3sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bpb9+UZoO5/cwBaCIWVcqy5ld66UKzHaf54R19TQsg6jGJCHmm7xgA5b9firLGqxdORGGcQitqMGyR/2+u8PvNoLEHnxzkxuDgp2kTcMV5jd2oCyxuegYYY81CbW0+KOR2UkusIWyfQF1SyHkcdlLyXXdtUb3pBf6sHKXnnxixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPsv2t/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E760C4CEF7;
	Fri,  3 Oct 2025 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759510609;
	bh=JV3UpCx5Xkf4WnYDKXQq5+YoXg9RglDY2VFNOWzZ3sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPsv2t/lOBILV84DJkEkxasJK9RmPc6DgbHdJkM5szfTaHyfm1vKo68P0wApmk+dQ
	 FXrTb5AvwQkIhwv12T/eSUb0fVBHHv+z4KUB3jBpxkWBqd1JJHYeQhYpILwcpJqBhW
	 NNEXNpnBWO/qIpxFgRfNZxb1ufpNDjtWtFgLKU3as/8nSTRiAx3eoih81Ef1y+X+/7
	 FA/4sdDhzcyTdffwUNQsAyRDbjiws7eWWXAhxppoQUIjBVeNEBdSMaY+PKGsMXHkIq
	 UrVTfvD2WzacOrhTDYZEpRGgFheZogC7HNEhK6x/72p22igrL7sJIQ9oyNPFYJ8Hhf
	 vZg9Gi/Q4rqzg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6FB2CF40066;
	Fri,  3 Oct 2025 12:56:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 03 Oct 2025 12:56:47 -0400
X-ME-Sender: <xms:TwDgaFlxUqzapmQZHn0PHbC8ptyLONHzP77fFPhx3m5xw4_bahlqow>
    <xme:TwDgaIksgsykPA-UJGwoR42X7ivZT7u1ZC7mJbk0dg9QKLHMLqi9OGgFZrl9s1VQ2
    WA0S7Vo84qmp_m-Ol3zKDG_W3OxOt25SVx5jTan6sPr8aAqgeL4WL4>
X-ME-Received: <xmr:TwDgaKMyLseSqZpgPPwZ74nAqOedbBSkXpt_lZlwqN73Qj9tD7G29FwjTMJHTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhieekteelledugefhffekfffgjedtveevgffgjeeffeegvdekteetudeggefgkeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvg
    hrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfedt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
    pdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphht
    thhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtghomhdprhgtphhtthhopehvsggrsg
    hkrgesshhushgvrdgtiidprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehmhhhotg
    hkohesshhushgvrdgtohhm
X-ME-Proxy: <xmx:TwDgaP4CAVLa8vmKSGL8lliQN1Pc5vTXs4CmYx14EsepnVmM8SAG0Q>
    <xmx:TwDgaHslB2UC6UlQCYocZTPwhw9-JVFyVn6xmEBxdSa9JsSQpxeepw>
    <xmx:TwDgaJOAjuiaDVGUeo8aIL7JTEPFk-giBcQqiFTQpRbmgLT2YC5SCg>
    <xmx:TwDgaDoAejs1PnA71FQLjfBHG_79VltNAwQhHhXagqXTcfEiRJ4elg>
    <xmx:TwDgaOHKPLYAKhYXsvdVNvTYraMDsRLij-Ypg_1jBYrAtYnAszsrwD-K>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 12:56:46 -0400 (EDT)
Date: Fri, 3 Oct 2025 17:56:44 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm/mmap: Fix fsnotify_mmap_perm() call in vm_mmap_pgoff()
Message-ID: <bqmxwfi4kohx744fa5ggoiovrhiwsoehqn57kptoni64lgflim@ibt5bjvcbhdx>
References: <20251003155804.1571242-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003155804.1571242-1-kirill@shutemov.name>

On Fri, Oct 03, 2025 at 04:58:04PM +0100, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> vm_mmap_pgoff() includes a fsnotify call that allows for pre-content
> hooks on mmap().
> 
> The fsnotify_mmap_perm() function takes, among other arguments, an
> offset in the file in the form of loff_t. However, vm_mmap_pgoff() has
> file offset in the form of pgoff. This offset needs to be converted
> before being passed to fsnotify_mmap_perm().
> 
> The conversion from pgoff to loff_t is incorrect. The pgoff value needs
> to be shifted left by PAGE_SHIFT to obtain loff_t, not right.
> 
> This issue was identified through code inspection.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
> Cc: stable@vger.kernel.org
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jan Kara <jack@suse.cz>
> ---
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index f814e6a59ab1..52a667157264 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -573,7 +573,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>  
>  	ret = security_mmap_file(file, prot, flag);
>  	if (!ret)
> -		ret = fsnotify_mmap_perm(file, prot, pgoff >> PAGE_SHIFT, len);
> +		ret = fsnotify_mmap_perm(file, prot, pgoff << PAGE_SHIFT, len);

It misses the case to (loff_t) and it broken for 32-bit machines.

Luckily, Ryan submitted another fix for the same bug at the almost the
same time. And he was more careful around types:

https://lore.kernel.org/all/20251003155238.2147410-1-ryan.roberts@arm.com

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

