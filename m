Return-Path: <linux-kernel+bounces-845664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59309BC5BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E93C19E3FA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CB5301002;
	Wed,  8 Oct 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B10ueDmc"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72630100F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937651; cv=none; b=CTVmmikFFmfauNq6jmWA1gxRCoPdYAG/Fo99bcdjDz4TYABDyqYEft/FbQ0vu4LSlbKYEtOWl2m58kVipGG39CLyqdv3aur56ucc3DbI2LgxkMj2jlrk8j5D9gUNzf5b4viSWwLYFuIZLiT4N44+iV6Geq1yykGVQEZyakkdvXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937651; c=relaxed/simple;
	bh=81mkZlQSBdCKGQbglxWaHnFhDvryAJU0e3jWFOvHPjk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U0iOiujk8LCoxQF94xVMyH2Jl2/EoTxEkNRFmGRgIc4snYbxBsN/Ee71yB6puLBdVsA6p6b0RkHn3jE7qteUOEpFAFkQF8+VQ/wWNz/UpKi+2VvMwh4tsE+AYMCJVd/4v9q1nFyRZs0s6KQuBs3angqPmHxtKfKwYHHg3SyBM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B10ueDmc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=l8oO3/pg6CmV2p3K97uD74zhg8Z0UWj/UPOYhl1Zo0w=; b=B10ueDmcM/SylBaBdgXfdp4OBf
	IRFCD7EWQJi175dNzQJtH4nMUKjtazucCYKhqUG4hAqGxohiAft+dj8GIlWO+0zaBYvxQI22rDnBP
	xY4IVBJ4GAU/IcjKB0tVsihi14MHscNJWO56kItbiB1iChF35r/Mwqf6tYk2AaRCEoaQy0grYJ5Ij
	Rs+PUVwvojMBGWEnlAmLXXUZpgc0UNsD2aRDIODXmM6Xjag1W4jeesqQTKq1SS7kyfkVm98c6roz7
	CjQxlLKh8vamkW7ruj4jRLXdSquLjHHgVaZoSHgCFwacAF5RBHFo/02rREJG5y9lKlE9BtW1pPfa9
	QVTIXAvA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6WB5-00000007jkZ-2HTW
	for linux-kernel@vger.kernel.org;
	Wed, 08 Oct 2025 15:34:07 +0000
Date: Wed, 8 Oct 2025 16:34:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Using Gmail for kernel development Considered Harmful
Message-ID: <aOaEb_9j6CwGgX7r@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Don't use gmail addresses for your kernel development.  You'll
randomly lose email because gmail thinks it knows better and gives
no way to say "you're wrong".

----- Forwarded message from Mail Delivery System <Mailer-Daemon@infradead.org> -----

Date: Wed, 08 Oct 2025 13:40:38 +0000
From: Mail Delivery System <Mailer-Daemon@infradead.org>
To: willy@infradead.org
Subject: Mail delivery failed: returning message to sender

This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  airlied@gmail.com
    host gmail-smtp-in.l.google.com [2a00:1450:400c:c04::1a]
    SMTP error from remote mail server after pipelined end of data:
    550-5.7.1 [2001:8b0:10b:1236::1      12] Gmail has detected that this message is
    550-5.7.1 likely unsolicited mail. To reduce the amount of spam sent to Gmail,
    550-5.7.1 this message has been blocked. For more information, go to
    550 5.7.1  https://support.google.com/mail/?p=UnsolicitedMessageError ffacd0b85a97d-42583ab9ab6si2621680f8f.237 - gsmtp
  boqun.feng@gmail.com
    host gmail-smtp-in.l.google.com [2a00:1450:400c:c04::1a]
    SMTP error from remote mail server after pipelined end of data:
    550-5.7.1 [2001:8b0:10b:1236::1      12] Gmail has detected that this message is
    550-5.7.1 likely unsolicited mail. To reduce the amount of spam sent to Gmail,
    550-5.7.1 this message has been blocked. For more information, go to
    550 5.7.1  https://support.google.com/mail/?p=UnsolicitedMessageError ffacd0b85a97d-42583ab9ab6si2621680f8f.237 - gsmtp
  alex.gaynor@gmail.com
    host gmail-smtp-in.l.google.com [2a00:1450:400c:c04::1a]
    SMTP error from remote mail server after pipelined end of data:
    550-5.7.1 [2001:8b0:10b:1236::1      12] Gmail has detected that this message is
    550-5.7.1 likely unsolicited mail. To reduce the amount of spam sent to Gmail,
    550-5.7.1 this message has been blocked. For more information, go to
    550 5.7.1  https://support.google.com/mail/?p=UnsolicitedMessageError ffacd0b85a97d-42583ab9ab6si2621680f8f.237 - gsmtp

Reporting-MTA: dns; casper.infradead.org

Action: failed
Final-Recipient: rfc822;alex.gaynor@gmail.com
Status: 5.0.0
Remote-MTA: dns; gmail-smtp-in.l.google.com
Diagnostic-Code: smtp; 550-5.7.1 [2001:8b0:10b:1236::1      12] Gmail has detected that this message is
 550-5.7.1 likely unsolicited mail. To reduce the amount of spam sent to Gmail,
 550-5.7.1 this message has been blocked. For more information, go to
 550 5.7.1  https://support.google.com/mail/?p=UnsolicitedMessageError ffacd0b85a97d-42583ab9ab6si2621680f8f.237 - gsmtp

Action: failed
Final-Recipient: rfc822;boqun.feng@gmail.com
Status: 5.0.0
Remote-MTA: dns; gmail-smtp-in.l.google.com
Diagnostic-Code: smtp; 550-5.7.1 [2001:8b0:10b:1236::1      12] Gmail has detected that this message is
 550-5.7.1 likely unsolicited mail. To reduce the amount of spam sent to Gmail,
 550-5.7.1 this message has been blocked. For more information, go to
 550 5.7.1  https://support.google.com/mail/?p=UnsolicitedMessageError ffacd0b85a97d-42583ab9ab6si2621680f8f.237 - gsmtp

Action: failed
Final-Recipient: rfc822;airlied@gmail.com
Status: 5.0.0
Remote-MTA: dns; gmail-smtp-in.l.google.com
Diagnostic-Code: smtp; 550-5.7.1 [2001:8b0:10b:1236::1      12] Gmail has detected that this message is
 550-5.7.1 likely unsolicited mail. To reduce the amount of spam sent to Gmail,
 550-5.7.1 this message has been blocked. For more information, go to
 550 5.7.1  https://support.google.com/mail/?p=UnsolicitedMessageError ffacd0b85a97d-42583ab9ab6si2621680f8f.237 - gsmtp

Date: Wed, 8 Oct 2025 14:40:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Onur Özkan <work@onurozkan.dev>, rust-for-linux@vger.kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, linux-kernel@vger.kernel.org,
 acourbot@nvidia.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 corbet@lwn.net, lyude@redhat.com, linux-doc@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2 2/4] rust: xarray: abstract `xa_alloc`

On Wed, Oct 08, 2025 at 01:04:11PM +0000, Alice Ryhl wrote:
> > +        limit: Range<u32>,
> 
> The Range type is inclusive/exclusive but xa_limit is
> inclusive/inclusive. They should match to avoid confusion.

... and xa_limit is inclusive at the top end to be sure that we can
actually allocate 2^32-1.  Or does Range handle that by using 0 to mean
that 2^32-1 is allowed?
> 


----- End forwarded message -----

