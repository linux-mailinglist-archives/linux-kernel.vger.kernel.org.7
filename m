Return-Path: <linux-kernel+bounces-760432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E267B1EAFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A627AA2696
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110F12836A0;
	Fri,  8 Aug 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHu94B/H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A978283159
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664875; cv=none; b=FpLkYZ5s2O+fnQGyrOpX2xINfmlRwgIi6gmzMwh32phL9HugJMDfmMQZ0NLlh0Na9gpFtfh/FHbXMxLtd0Slt2wUumONFSOL1wQjtqbARpZXluHTKBGujmiAlcwsWfw46lK3HdMXTIkgbvpYPxUbbqyv3tuPQquvnOFVQ2z5vx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664875; c=relaxed/simple;
	bh=463e1ppa1j1UMhFgECjJexr+1G0LQuX81slOJNxRD6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABdjp+EYsn8YbH9N5Gh8A4VnV1SQRef9VrcqZ+uMaWW+/aKKPyIWOhvqnhjc77eZUEB1kEFzBo482eCnpFOPK6pyRd4oc6os5If8vG/OgV7rvt3jKs30jmdYGz6niN/sMCFYDVPLvhzhaizDEuVXeDwEeflerLj3DDGTUxPeDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHu94B/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE03C4CEED;
	Fri,  8 Aug 2025 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664874;
	bh=463e1ppa1j1UMhFgECjJexr+1G0LQuX81slOJNxRD6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHu94B/H6wiJ6iyg+i8llXhV8SVyU9FbloHnK9aSVj++gMoL7om0y4NiDrBB3Li+p
	 t0kbAYleORDXnBjn2kwLvjBZgSk7XeROhJP7uqSdMnLuVGS2H9EXLj5TZ8Vny41rlC
	 9rLqElJvcPC7r1jYfSW6i8IABszrB5eKVld4PUQ7hYrSIb0rG3k0VseJEmODNpl+3U
	 Uar4YlE4CWGherbO2ePthfzfDC6AzQrMa1TmmbbcoOdn0El3Rhifq2QkTeaJCbMrz3
	 93o1OkBcs4upmqU30kNzdv4Q7cloTohLPSnA3gklTXujBDFsI5nsLvWb3lJhezibl2
	 KfHtBHXnDzqdw==
Date: Fri, 8 Aug 2025 16:54:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Xiang Gao <gxxa03070307@gmail.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYQ==?= =?utf-8?Q?l?= Mail]Re:
 [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250808-laufen-messen-d160e27a73cc@brauner>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
 <20250802084525.GB31711@redhat.com>
 <80be47cb31d14ffc9f9a7d8d4408ab0a@xiaomi.com>
 <20250804114900.GA6656@redhat.com>
 <20250804-gepfercht-delfin-0172b1ee9556@brauner>
 <aa5272ddcec944e2a35ca7104f6a86bf@xiaomi.com>
 <20250805194302.GC27131@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805194302.GC27131@redhat.com>

On Tue, Aug 05, 2025 at 09:43:02PM +0200, Oleg Nesterov wrote:
> On 08/05, 高翔 wrote:
> >
> > I also think "WARN ON ONCE" is quite sensible .
> 
> I am starting to agree, but lets wait for Christian.

Yeah, fine by me.

