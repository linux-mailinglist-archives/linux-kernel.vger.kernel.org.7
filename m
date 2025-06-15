Return-Path: <linux-kernel+bounces-687294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C302ADA283
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 18:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1374316CD22
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B221126A0A0;
	Sun, 15 Jun 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eb5xFic0"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE7F35947
	for <linux-kernel@vger.kernel.org>; Sun, 15 Jun 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750003526; cv=none; b=Oqjx1KUwU6mpZOSoKRHm3GaRy3wmglQH2GnLf+wT8Lu6X8HxTbGLsw8ZKYFdIPuSAy96iI9xiCZjWgmzFKaHoGfuvtQ1J2rwE9Sm5Z8WYv2AoUDj2hyyuZbRB74d3xu970I+v3az+zgeK9b0MGUAtUq8a+ldeSvqeTYJG7q8Jq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750003526; c=relaxed/simple;
	bh=fIvay9xLyX/NWF4lX2vHQs13c8n2lD9h76kkaOi/uhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ansql/oetteDf3cmSM/t7yJrELA/hyIybSE/ylrku9+vTKHGPUyWN3KxhA5CTjPdor9mgl977nxEYhgzHTVjROD2j6XEcBUFUR/Ggvd3Yd7CUUuEcW00nO7GjvTVUrhJ0oUvWgl/W0ljOCR7MVWVEfFYvltRHqloQgNVHyhyAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eb5xFic0; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 15 Jun 2025 12:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750003520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Hgn6R4b9LLUSEv1FAPxA4416olKaWNCaPHmrL00OGs=;
	b=eb5xFic0d0VYZfPWOT//vD5drVCZEiFvfE769zyFbXItUs3s3llR9QVwGXT8qqE2uC+cO7
	VtXU2Ix56qteF+4taeyPyzNTteSzUaUvTCILSDTS4LRn4CHLUwn+cTRopmcxddhvr31suT
	O1FG59yjtfe8ymgICwhF6sksr0ARPKU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	syzbot+cfd994b9cdf00446fd54@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: don't return early from __btree_err for bad or
 incompatible node read errors
Message-ID: <tqzma4qfw7ppu56mqucmekmuhtqs5raos6wrzddf7fjouaeb6g@himxw7j544tb>
References: <20250614185743.657564-1-bharadwaj.raju777@gmail.com>
 <bwga4jheevnhuwwpopfwbzsjsxvmte4mtybevkfgssem4zftjo@anj44i6sfyd4>
 <CAPZ5DTEtsqJ_z7OtRVKDqb+LkvS=UfNvCTUqnY2Pu6qGVs+PEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPZ5DTEtsqJ_z7OtRVKDqb+LkvS=UfNvCTUqnY2Pu6qGVs+PEQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 15, 2025 at 01:42:22PM +0530, Bharadwaj Raju wrote:
> On Sun, Jun 15, 2025 at 5:49 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Sun, Jun 15, 2025 at 12:27:40AM +0530, Bharadwaj Raju wrote:
> > > After cd3cdb1ef706 ("Single err message for btree node reads"),
> > > all errors caused __btree_err to return BCH_ERR_fsck_fix no matter what
> > > the actual error type was if the recovery pass was scanning for btree
> > > nodes. This lead to the code continuing despite things like bad node
> > > formats when they earlier would have caused a jump to fsck_err, because
> > > btree_err only jumps when the return from __btree_err does not match
> > > fsck_fix. Ultimately this lead to undefined behavior by attempting to
> > > unpack a key based on an invalid format.
> >
> > Hang on, -BCH_ERR_fsck_fix should've caused us to fix fixable errors,
> > not cause undefined behaviour.
> 
> -BCH_ERR_fsck_fix in btree_err (as _ret from __btree_err) prevents a jump
> to fsck_err, so if that is the case, the code afterwards continues
> as normal. That's where the UB in this bug comes from.
> 
> I think I should explain the path of the bug:
> 1. bch2_btree_node_read_done calls validate_bset, with a jump to
> fsck_err if it returns an error.
> 2. validate_bset has btree_err_on(bch2_bkey_format_invalid(...), ...),
> but in the bug case we were in btree-node-scan so __btree_err returns
> fsck_fix, which means ret isn't modified and we don't jump to
> fsck_err.
> 3. validate_bset doesn't return an error code, so
> bch2_btree_node_read_done goes ahead and sets the invalid format --
> and then UB happens when trying to unpack keys based on it.
> 
> > Or is the issue that we're returning -BCH_ERR_fsck_fix for non-fixable
> > errors?
> >
> > Glancing at the code, I think the bug might not be limited to btree node
> > scan; we now seem to be passing FSCK_CAN_FIX for all errors in the
> > non-btree-node-scan case, and I don't think that's right for
> > BCH_ERR_btree_node_read_err_must_retry cases.
> >
> > But I'll have to go digging through the git history to confirm that, and
> > it sounds like you've already looked - does that sound like it?
> 
> Isn't the bch2_fsck_err_opt(c, FSCK_CAN_FIX, err_type) call only in
> the node_read_err_fixable case?

You're right, it is. Ok, so it's just the scan_for_btree_nodes path
that's busted.

But then you're calling __bch2_topology_error()? When we're in
scan_for_btree_nodes we're just checking if the node is readable, we
shouldn't be doing anything that flags errors/recovery passes elsewhere.

I think the correct fix would be more like

if (scan_for_btree_nodes)
	return ret == -BCH_ERR_btree_node_read_err_fixable
		? bch_err_throw(c, fsck_fix)
		: ret; /* or -BCH_ERR_btree_node_read_err_bad_node? */

The error codes feel pretty awkward here, we're converting between
different classes of error codes more than we should be which makes
things hard to follow - this is code that predates modern errcode.h
errcodes and was converted from a private enum, I think I could've done
that better - but I think either way works.

