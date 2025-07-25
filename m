Return-Path: <linux-kernel+bounces-745120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDEEB1152F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD184E609D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41421288A2;
	Fri, 25 Jul 2025 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BhGyERed"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493835949
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402812; cv=none; b=fBT1Ynvn2rqt+66grMcPCF/557M6b0+1kwqPsslpjp5BYvQm74Mfr+aJHx/gEEMl32D1E0gT9PdQEu8DZxyR0ESSJxw4MM7NcWfRr3JzBGeusg2GTG1j7ei7EJ9sB2+FRnjTjTOalcuZUIvgGfDqS2LPjIx/NotweYx3Zb5CBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402812; c=relaxed/simple;
	bh=6oWoQS0KDdTSfqPVNvYgaX1tpp8E7ImtovxTgv8batk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD8Fin9MF9VdhVYqMRoa3vjUcEL7L9EGVeNrn2SCAsVVzzAfmdCPMp5hHlfqOKGyeAxAqat1ZqnpK5NOPCgRXbZqTa4neZKCn1HhxLuwoT+P6nDTMVZkWDntH19HSALylVFoUbzaiSDwv0+3WVHSzo+u1jDR0fpU51zaLM62bKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BhGyERed; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=4P+w3vSTMHUr1hNRLBxl7UjYefaMy8nDONhfQiLxz6g=; b=BhGyERedkNNjLicgs9l5uK6Zvt
	sj2gp/CKwyxY2tadA+Zxmx+K80/kx2GLjqJsmd6RhQt30/NHWSW+lV4oFPltYIOoejl+6AaOyZbAe
	vxJPQciAv6jTWvKsV4K6yj2cdpMSih5BniZc95AWPmNzSyxYcR64YH8IAFOVqDGuOUZ9lEgtYNCCC
	JCJy561hz5AZn0pjSTurOVLuIxHZadEL8C6TeErHtOuY+xMNWuWewdanzEiWfYSaNQcpdweUEw8Fz
	NyVDtj6DvLw3rrq2W8Cd4O63yHYyDe0JkgcWAY/vaylUHyafC737UcBKJx/35mza+pj8rdpvaN4e3
	lvBpoy1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uf6AS-00000009fdO-1624;
	Fri, 25 Jul 2025 00:20:08 +0000
Date: Fri, 25 Jul 2025 01:20:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Cc: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
Message-ID: <20250725002008.GX2580412@ZenIV>
References: <20250724064051.431879-2-moonhee.lee.ca@gmail.com>
 <20250724155832.GU2580412@ZenIV>
 <CAF3JpA6FguWASZM98DWsvEasOAHH2WVkSmcY0D-V6V=-DFjoJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF3JpA6FguWASZM98DWsvEasOAHH2WVkSmcY0D-V6V=-DFjoJQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jul 24, 2025 at 10:29:47AM -0700, Moon Hee Lee wrote:
> On Thu, Jul 24, 2025 at 8:58 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > It might paper over the specific reproducer, but that's not a fix...
> > I'm not familiar with that code; will check the details, but in
> > this form it is obviously still racy.
> 
> Thanks for the feedback, Al.
> 
> Agreed, this only papers over the issue. I'm tracing the
> sta_info_destroy() path to confirm the race and will follow up with a
> proper fix if confirmed.

Note that if you have nested subtrees, you have to be very careful
about removals - after all, removal of the bigger one drops the
references we are holding to the roots of the smaller ones.

