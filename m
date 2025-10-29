Return-Path: <linux-kernel+bounces-875077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B510C18298
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A9BD4E711D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B529BDA5;
	Wed, 29 Oct 2025 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="wLMobtNT"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE22580DE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708040; cv=none; b=i/hry8dMJsruGAOkT0u3fK88VEjqbDW8aXjlB7FBW9R3vqwzqDZcO1Kjln/iHGmDOYvoVGehFGJ2EFP5Hf3hONbLt6dwxg+ZJpQwIwWCIFJ579oyle0CwTLgSYJW3RcO/TfO8iOO1cX1+fxGHUBICGy/DMUy0YcvWGW7RNqDq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708040; c=relaxed/simple;
	bh=7zBBbCK/11p1K8q2HQ9YDAqZdwiUdhGSicGrtvuJ10Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETYfhSbItQad/e3YqtfiRs+GrqU6/qFSN4eY85uKvrWDL5ZC7+grLkreZZWjaPJmytSrHH/21ztFMlqfamw35/YX58diVPI0wKAz86P4I3Oa0GOvSvA6H/IPWs0HMTZIdBFeqMGXnAtExcB/cCpNaVmMvv1Om0p8Swya4ojliJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=wLMobtNT; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Date: Wed, 29 Oct 2025 03:20:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1761708032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Au77/twQcxrXaUBROjg2lxUxQuqN9PbdITbfFhgx28o=;
	b=wLMobtNTNCvdrlKpw0Ugdf8ZJVRD0Zn9stgwbNsp6i7sBFo/I4qKh8KGCsGm4SFoy/CJ94
	g2n+8FSxAESruZEt8r4FkAc/3SobUjRdQBnJk/gRQ93MIPJUsxUjOMWnF1Nbr58mf5Au6O
	ocpzSN+Voe9kNhs3V+JdVBlpdM9dtOKL6UOboSuPjjaWq261NhHmRGSdOkJwmEjz8YrAFg
	H5nfZWZJwwqM9CoojxhwE+dlD2R69ntpSO9u6DiJ7VcB/EEd2T+Y5M6fv633pcteQdkri+
	dE8OCO0XtULGr1WFxcOYa0H2bR8KAfRRkuWxbB98l1LWlIw5mTU3Ragr8jBLXA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel-mentees@lists.linux.dev" <linux-kernel-mentees@lists.linux.dev>,
	"syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com" <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfs: Validate CNIDs in hfs_read_inode
Message-ID: <aQGIBSZkIWr4Ym7I@Bertha>
References: <20251003024544.477462-1-contact@gvernon.com>
 <405569eb2e0ec4ce2afa9c331eb791941d0cf726.camel@ibm.com>
 <aOB3fME3Q4GfXu0O@Bertha>
 <6ec98658418f12b85e5161d28a59c48a68388b76.camel@dubeyko.com>
 <559c331f-4838-49fb-95aa-2d1498c8a41e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559c331f-4838-49fb-95aa-2d1498c8a41e@I-love.SAKURA.ne.jp>
X-Migadu-Flow: FLOW_OUT

Hi Tetsuo,

On Thu, Oct 09, 2025 at 09:57:33PM +0900, Tetsuo Handa wrote:
> I found this patch. Please CC: me when posting V2.

Sorry I forgot to CC you last time :)

> I'm not suggesting this change. Therefore, Cc: might match.

Sure, I have added a CC tag for you in V2 which I'm currently testing.

> further sanity check). Unless
> 
> >>>
> >>>> +{
> >>>> +	if (likely(cnid >= HFS_FIRSTUSER_CNID))
> >>>> +		return true;
> >>>> +
> >>>> +	switch (cnid) {
> >>>> +	case HFS_POR_CNID:
> 
> we disable HFS_POR_CNID case (which I guess it is wrong to do so),
> we shall hit BUG() in hfs_write_inode().
> 
> >>>> +	case HFS_ROOT_CNID:
> >>>> +		return type == HFS_CDR_DIR;
> >>>> +	case HFS_EXT_CNID:
> >>>> +	case HFS_CAT_CNID:
> >>>> +	case HFS_BAD_CNID:
> >>>> +	case HFS_EXCH_CNID:
> >>>> +		return type == HFS_CDR_FIL;
> >>>> +	default:
> >>>> +		return false;
> >>>
>
> I think that removing this BUG() now is wrong.

I think HFS_POR_CNID case should be disallowed. There is no real
underlying file with that CNID. If we ever found a record with that CNID
it would mean the filesystem image was broken, and if we ever try to
write a record with that CNID, it means we screwed up.

> Without my patch, the inode number of the record retrieved as a
> result of hfs_cat_find_brec(HFS_ROOT_CNID) can be HFS_POR_CNID or
> greater than HFS_FIRSTUSER_CNID, which I think is a logical error
> in the filesystem image.
> 
> Your patch is incomplete. Please also apply my patch.
> 
I agree your check is good to catch root inode's i_ino > 15 (is this
reachable?) and I'd like to add it. Would you be happy if I make a
2-part patch series with your patch second, keeping your sign-off on it?

Thanks,

George

