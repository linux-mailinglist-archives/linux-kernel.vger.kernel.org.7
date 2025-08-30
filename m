Return-Path: <linux-kernel+bounces-792665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BBAB3C765
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 04:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE689207EAE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04BA255F2D;
	Sat, 30 Aug 2025 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="L7PcVgiC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2EkhiG3"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA28255F2C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520880; cv=none; b=GIawo6F+liIaQJyS6FVcDrHCS68lay/HUtsR4dppekzjZJc3bXVFkJl+jYprH+/TJHjGRYK6zshUJHlUwzBUWej+eccsEUX5fRiXlJk23WYKF3W7Dihw7k/GM6vF6tYUlRDeZHvi9/xfwaP2CgyACE3pRu3sw5kDwHMXaU1UExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520880; c=relaxed/simple;
	bh=GhG4XfMjt6bQFCwJZd71+39Ep8zwYcv3X4AHS31dc6s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HzGAI0hf0D6iRA1G5DMy2hptD5/M2Sf/NZao0CANe9OFPLPHCGLyXF+d6TD4QxjYF4pjW46yPprsaVrAMohuGdD4yQY/cb43fHH6o0yWI9KCsVejI7eb2nbyztZScnmBxzwcHwdEUsG/CMaTH1uRlNlNwW97kvgxhLio9fl/qeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=L7PcVgiC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H2EkhiG3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 62DEFEC035F;
	Fri, 29 Aug 2025 22:27:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 29 Aug 2025 22:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756520877; x=1756607277; bh=kaXA6ks/9T
	8Y7cRZC++Biv2EB+ZprmQqqExELnWh43I=; b=L7PcVgiCN7Z3ER8KP9wpYTaEbo
	YkPEzYWF3+iNeRysjP4RKKq9sJ6p62w1yZG6HPAnmz6LZXOBHEwZeMdLdNS2cTxK
	5ioHTyTXWsNTVCO6XvnI7ziNzdFuzfBdKgRahmZcAdKILZQTiwNMpPcimEUaVtvB
	H06YVVuepjDGHxqsDZ7rD3QFYeNmIG/VvlqtZZDbAAATN/OlqVyMQFcXQmSYOg+5
	e5Hlt+qiyMePfqMcaUO5oH2YUnVDunyTazjK51+A2X+oVtLuM5l/gJzPfuD53XSm
	tPBD9gTxAWAj0nWdtptJjZg4r3Te9UWLmPIqJgipsmgCmCZ31mJx+5jiJm7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756520877; x=1756607277; bh=kaXA6ks/9T8Y7cRZC++Biv2EB+ZprmQqqEx
	ELnWh43I=; b=H2EkhiG3BLhJWigUv3Bn/ShDNC8WYQWgS2f7SWwRKhSJ3bIJ432
	85g7zBKnBWAH1NgncYVC0qUsz5UfiB4A9ANrNVKgdsFrZrFmQewpdfBewdyTzAqk
	fYnh1eZczIGwu0YY8mmXqrRJDoB8vw1KQ8O2dzH1wlH+r+OX4lnv29gIrEdR7Qrd
	7HFBrMOMXvV+Y5jD8SOyNpuKIoDax3g5JuYu4kjl7tDhDCjXnVqSpbbC3tqRJscg
	f2bpeqDEEqoFuf67i+MBtvSOdoAGv+exQQaiN/Q3wzhKtVr86Hvhp4gypecjx/6e
	rj7M1kHK0G9QqSYStb4Ugr0wAvF8hJD2sHg==
X-ME-Sender: <xms:rGGyaHIQbueiOzU9lHAYgIrL4v-iSJSc7A2I-w6o742cHmae508UwQ>
    <xme:rGGyaAiApvmtKL5-P7LHXQp8nRazwOnhJINw9UqPe7sXWDYnqck-PA860sZhchhnR
    R1BuGSYF5K54998v-0>
X-ME-Received: <xmr:rGGyaP6ZePVgS2gGenWvT8QyxdsL3jgEgxnmyMyiWaC8plurv2cgnGtSdMCWfl1eyfh80SXmhoMD1LkfbKNSIkjOwgt2vL4oR8IBQJ9EJi2SIu_ZYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeehudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefpihgtohhlrghs
    ucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrh
    hnpeehheffudeluefgleetveffjeegudeugeevffefieeuudeljeetheffgeefgeekuden
    ucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtohesfhhluhig
    nhhitgdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepphgvnhhguhhinhdqkhgvrhhnvghlsehiqdhlohhvvgdrshgrkhhurhgrrdhn
    vgdrjhhppdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rGGyaAZY7rvSBlINZ9K1qKjEJI8HiLCC4OkVvaoQgNTFRxfjcGhCug>
    <xmx:rGGyaM4Iugaqzld-b37xYw_PLjS6YzzNI1jcd2iYrYEivi2P1-2FLQ>
    <xmx:rGGyaLCQHPizVPxGvdGFAJqHi3BYLAVDqd5-tcJggI2fHWB9pdd6qA>
    <xmx:rGGyaKcUZFRtmRHdwjX15swIAjEw-ZXwa6uKlS2RUPwW7AQjN_0Tpg>
    <xmx:rWGyaAWoOk98MsCnS2kHMNUUsITzIQBi8tCw5SCkmWGsuarQDD6cdRCe>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 22:27:56 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id D7475130EDE6;
	Fri, 29 Aug 2025 22:27:55 -0400 (EDT)
Date: Fri, 29 Aug 2025 22:27:55 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc: LKML <linux-kernel@vger.kernel.org>, 
    Christian Brauner <brauner@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] cramfs: Verify inode mode when loading from disk
In-Reply-To: <dca0c449-547e-42fa-a8b7-53787e64e2ec@I-love.SAKURA.ne.jp>
Message-ID: <5n9rqorq-5o43-q195-s28p-p8r5s1o23s92@syhkavp.arg>
References: <ff7dc567-1db3-4939-9b0e-77e91a8d898b@I-love.SAKURA.ne.jp> <dca0c449-547e-42fa-a8b7-53787e64e2ec@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 29 Aug 2025, Tetsuo Handa wrote:

> Any questions? Should I find someone who can take this patch?

Please add

Acked-by: Nicolas Pitre <nico@fluxnic.net>

and send it to linux-fsdevel@vger.kernel.org.

> On 2025/08/12 23:52, Tetsuo Handa wrote:
> > The inode mode loaded from corrupted disk can be invalid. Do like what
> > commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
> > does.
> > 
> > Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
> > Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> >  fs/cramfs/inode.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> > index b002e9b734f9..12daa85ed941 100644
> > --- a/fs/cramfs/inode.c
> > +++ b/fs/cramfs/inode.c
> > @@ -116,9 +116,18 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
> >  		inode_nohighmem(inode);
> >  		inode->i_data.a_ops = &cramfs_aops;
> >  		break;
> > -	default:
> > +	case S_IFCHR:
> > +	case S_IFBLK:
> > +	case S_IFIFO:
> > +	case S_IFSOCK:
> >  		init_special_inode(inode, cramfs_inode->mode,
> >  				old_decode_dev(cramfs_inode->size));
> > +		break;
> > +	default:
> > +		printk(KERN_DEBUG "CRAMFS: Invalid file type 0%04o for inode %lu.\n",
> > +		       inode->i_mode, inode->i_ino);
> > +		iget_failed(inode);
> > +		return ERR_PTR(-EIO);
> >  	}
> >  
> >  	inode->i_mode = cramfs_inode->mode;
> 
> 

