Return-Path: <linux-kernel+bounces-589475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06201A7C6BD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 01:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDA43BBE3E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 23:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3C41F12E7;
	Fri,  4 Apr 2025 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="uNXGvnNd"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735713B2BB
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 23:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743809843; cv=none; b=V5YwxHQWtUrlAgGMT8ScRPmUTwDZmJHBqb1w3shH7go+LoFlGgKLwWc3zivePSBRzm/18+wZNLON7DjfCrTNqWgI6qDJeEkswnGIxhblsxYrW51WGl/F0teFSsl8jmXlbtCGoMYKh4GLVBHn0bVIbn8GhtlgUhDsBlZhoizaaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743809843; c=relaxed/simple;
	bh=GI8K8fXDBCh2FPVk7FuAjB9WmhRKTpeT98nexJxBQqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhUhZsl5qBDr/CrvbBOCTDEVIYVl9Ok6yOPshPWJsMQt/uajhSBmSMtpVN7lkZr1aLSIofb1c28z5pdbaF9DqsYrvB26ztUEuzEyMmCSTQvLBVLYqktED4cwgwmbwIKbHrDWzXIydO42sRNkox3fToEHUqR8qncyJ6HtMT3jgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=uNXGvnNd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Sat, 5 Apr 2025 01:37:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743809837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GI8K8fXDBCh2FPVk7FuAjB9WmhRKTpeT98nexJxBQqw=;
	b=uNXGvnNdzQlXu9Jvln8BKbLoHI2I6EhtvGmXw39XHygcZbI1Ph6xc8LOngN7VwUnmel0iK
	198ALO/ZF31C4Cw2P6/mehcV3hvLRmeXxWyoiYVn952yt1IcKpqTi7oO2FEZjeV22nEjRB
	8rsAbQvNzfdC48WScsCSgjKqAa0FfC0qDkldZTFvyBqKoCVVuNaunnck/GW28gwgr4sHGL
	L3OcEDfyd07EY1cQxRKSNXSFwHupvyuojSVyDGuvxBevPjBuwvddjBr6bW+T1sxktlLIz+
	VxvkkfCiFGEoC7wBBMf8uV6kJ3/cakERzlPY7xemL+/OCfmE45dXCpDMy7DJGg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, ebiederm@xmission.com,
	rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, msizanoen@qtmlabs.xyz,
	rafael.j.wysocki@intel.com, yu.c.chen@intel.com
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z_BtK43rKhxw28l4@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a>
 <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv>
 <Z-hYWc9LtBU1Yhtg@desktop0a>
 <Z_Bry0JcB1jqPztR@desktop0a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_Bry0JcB1jqPztR@desktop0a>
X-Migadu-Flow: FLOW_OUT

On 2025-04-05 01:31 +0200, Roberto Ricci wrote:
> I've bisected this other bug with kexec_load. I found commit
> 62a03defeabd PM / hibernate: Verify the consistent of e820 memory map by md5 digest
> Reverting it on v6.14 fixes kexec_load, but not kexec_file_load.
> Also applying the patch suggested by msizanoen fixes kexec_file_load, too:
> https://lore.kernel.org/all/Z_BDbwmFV6wxDPV1@desktop0a/

I mean, doing both things fixes both bugs. The second thing fixes
kexec_file_load only.

