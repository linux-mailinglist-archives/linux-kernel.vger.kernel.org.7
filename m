Return-Path: <linux-kernel+bounces-769075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393A2B269CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF2F5E646F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBD61DB34B;
	Thu, 14 Aug 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VpKlledi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387E1AAE28;
	Thu, 14 Aug 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182152; cv=none; b=EsIGYfvW3fKsb7aXu/ZBJ9efnqyIIJmDEKI176RqIgqEak4vz9Lc9fUPpZsLdpCekAOtsdTPUVKUeSpArz9hLd7/PEJui6JP3mKFUl7lthIw15oNK7oClWlrQjh2ct/ECO7cqOSYx4oXqCiZkhvxwUAUlTCVOsqnOt2Z44zuZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182152; c=relaxed/simple;
	bh=5r1ZfIYGt/SxED81e4SqxHAoPVYmkOk9pNZTa4DTRio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hngq0tUu7XIRk7JsnBnk70HMv56vu69g40ocMyZn5xh4VM1BZ8m6vtM/x4y6WIxgv6f25XWExbC6ceuy7x52VOY13fyAiBgTs0k4pkpioovGnkgdnQ8Mf+e0z/6T9V/ucBF5SmfIvh04GUWFlzrYnad6450O7JYxzDzMbbCnuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VpKlledi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BE8C4CEED;
	Thu, 14 Aug 2025 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755182151;
	bh=5r1ZfIYGt/SxED81e4SqxHAoPVYmkOk9pNZTa4DTRio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VpKlledij6N1ObIMYIvXSGcwhoDFYArU1cCfJrKecfygL3SEf2/Zk9IFYFibNf8cy
	 ZWlpDduYUsGUuhMoOFrTfYB75f8B/qfBVKR7ExKtHROyl5P6ZBl0ztw16nN/bNC5CJ
	 rvmL8iV/zRE8CoUWj846Td8k+RBX4GHwU1LfCOos=
Date: Thu, 14 Aug 2025 16:35:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-hardening@vger.kernel.org,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
Message-ID: <2025081456-reflected-revolver-9f5b@gregkh>
References: <20250814120338.219585-2-thorsten.blum@linux.dev>
 <2025081408-swinging-endorphin-abe2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081408-swinging-endorphin-abe2@gregkh>

On Thu, Aug 14, 2025 at 02:35:56PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 14, 2025 at 02:03:37PM +0200, Thorsten Blum wrote:
> > strcpy() is deprecated; use strscpy() instead and remove several manual
> > NUL-terminations.
> 
> Manual NULL terminations are good, why get rid of that?
> 
> > Since the destination buffers 'cmd_cur' and 'cmd_hist[cmd_head]' have
> > the fixed length CMD_BUFLEN, strscpy() automatically determines their
> > size using sizeof() when the size argument is omitted. This makes the
> > explicit size arguments for the existing strscpy() calls unnecessary,
> > remove them.
> 
> But now you are dynamically calculating this?
> 
> > No functional changes intended.
> 
> How did you test this?  Many of these types of changes are wrong, so you
> really really need to prove it is correct.
> 
> > 
> > Link: https://github.com/KSPP/linux/issues/88
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  kernel/debug/kdb/kdb_main.c | 32 ++++++++++++++------------------
> >  1 file changed, 14 insertions(+), 18 deletions(-)
> > 
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index 7a4d2d4689a5..ea7dc2540e40 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -727,14 +727,10 @@ static int kdb_defcmd(int argc, const char **argv)
> >  	mp->help = kdb_strdup(argv[3], GFP_KDB);
> >  	if (!mp->help)
> >  		goto fail_help;
> > -	if (mp->usage[0] == '"') {
> > -		strcpy(mp->usage, argv[2]+1);
> > -		mp->usage[strlen(mp->usage)-1] = '\0';
> > -	}
> > -	if (mp->help[0] == '"') {
> > -		strcpy(mp->help, argv[3]+1);
> > -		mp->help[strlen(mp->help)-1] = '\0';
> > -	}
> > +	if (mp->usage[0] == '"')
> > +		strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);
> 
> Now you are manually testing the length of argv[2], are you sure that's
> ok?
> 
> > +	if (mp->help[0] == '"')
> > +		strscpy(mp->help, argv[3] + 1, strlen(argv[3]) - 1);
> >  
> >  	INIT_LIST_HEAD(&kdb_macro->statements);
> >  	defcmd_in_progress = true;
> > @@ -860,7 +856,7 @@ static void parse_grep(const char *str)
> >  		kdb_printf("search string too long\n");
> >  		return;
> >  	}
> > -	strcpy(kdb_grep_string, cp);
> > +	strscpy(kdb_grep_string, cp);
> 
> If this was just a search/replace, it would have been done already, so
> why is this ok?

I missed that strscpy() can now handle 2 arguments like this, so yes,
this should be ok.

BUT, you just checked the length above this line, which now isn't
needed, right?  So this function can get simpler?


> 
> 
> >  	kdb_grepping_flag++;
> >  	return;
> >  }
> > @@ -1076,12 +1072,12 @@ static int handle_ctrl_cmd(char *cmd)
> >  		if (cmdptr != cmd_tail)
> >  			cmdptr = (cmdptr + KDB_CMD_HISTORY_COUNT - 1) %
> >  				 KDB_CMD_HISTORY_COUNT;
> > -		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> > +		strscpy(cmd_cur, cmd_hist[cmdptr]);
> 
> Same here.  And other places...

Sorry, this should also be ok, BUT it's really just doing the same exact
thing, right?  And, it's a different thing, so it should be a different
patch (i.e. do not mix different logical things in the same patch, it
confuses everyone.  Well, me at least...)

thanks,

greg k-h

