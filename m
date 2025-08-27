Return-Path: <linux-kernel+bounces-788245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24FB381BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCB8367353
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C1F2F83B6;
	Wed, 27 Aug 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Iy3ioPuq"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C72EF654
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295586; cv=none; b=U4aQYAqT7u0HJHg2YeYjZlM2+X47tDpZ3SfJiSs+k+kynuJkHV4YOZaXAVaAM0cBjm2171gOoETdGbY/62lza/nhBBNS7a1+g+xzu8ZI0+OHrkLYQfkVU6wwjL0wOk5Bsffcm9iRwzP40Lq734qmUYoQCHeHI4rY8Pjkf1FSSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295586; c=relaxed/simple;
	bh=Q1wvyfNtpBZ25n7ToqHfhAYceHnQbyTxTlk3YBzAMWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPcmydVSzFSgBBm3Sb73OVCh+GLyFaC3OVR5Wv1DtcKRNVmNHOJPjiGRYyOJMwlAN3QM+wvpsHplVS+w0+pByFv5HJxS13Er9z1lR2AT98o9+oDUWUJK5vwmOk1jvtzpzs0lqAJeVoeknlqdspd3OOpGdRscwDCsWrHbVCabOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Iy3ioPuq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-119-253.bstnma.fios.verizon.net [173.48.119.253])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57RBqmmf013246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 07:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756295570; bh=ctUarcq+LCGpo/C7phydeZnd1chontiYFeJ2Bv6TMt0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Iy3ioPuqeJietM2uBdZM13d4LE18QIODtxMiyMI3+utXrLLrFtQghuBzmwdB7y/w7
	 znSTWNd+VGlMIzloXNUVw1bcB1WuEtsx7N43/k/g7Zcz9wGQPN08XJTDa0b3AgRlky
	 /3L99jGM/kGp9PgboJ9GNUPWkvB395NQtKuuu84U5AEdttrnIGO1FWmuG956dtpxwX
	 PBxSWBJYkS4MrdFPWn34hM/k1CGDeC7XbZ3de2wM5VfT3yOsyujvQUDo/6ARCOCHUi
	 aCcgQauhIqDpiUpIlwzHz6XqtqNphgLEVDkkFjqiibhakEgyQRiZn9PrKICDjWvqBA
	 WbP8ulIcJdzqQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D382C2E00D6; Wed, 27 Aug 2025 07:52:47 -0400 (EDT)
Date: Wed, 27 Aug 2025 07:52:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <20250827115247.GD1603531@mit.edu>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <20250826220033.GW39973@ZenIV>
 <0a372029-9a31-54c3-4d8a-8a9597361955@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a372029-9a31-54c3-4d8a-8a9597361955@ispras.ru>

On Wed, Aug 27, 2025 at 10:22:14AM +0300, Alexander Monakov wrote:
> 
> On Tue, 26 Aug 2025, Al Viro wrote:
> 
> > Egads...  Let me get it straight - you have a bunch of threads sharing descriptor
> > tables and some of them are forking (or cloning without shared descriptor tables)
> > while that is going on?
> 
> I suppose if they could start a new process in a more straightforward manner,
> they would. But you cannot start a new process without fork. Anyway, I'm but
> a messenger here: the problem has been hit by various people in the Go community
> (and by Go team itself, at least twice). Here I'm asking about a potential
> shortcoming in __fput that exacerbates the problem.

I'm assuming that the problem is showing up in real life when users
run a go problem using "go run" where the golang compiler freshly
writes the executable, and then fork/exec's the binary.  And using
multiple threads sharing descriptor tables was just to make a reliable
reproducer?

						- Ted

