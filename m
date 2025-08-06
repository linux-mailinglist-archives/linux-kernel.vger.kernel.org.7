Return-Path: <linux-kernel+bounces-758076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1EBB1CA90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D5C1675AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB71E2989BF;
	Wed,  6 Aug 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2gy0iAq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03D1CD0C;
	Wed,  6 Aug 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500796; cv=none; b=KL/L9VdiawPzG5xjeQG07Qs7GfMDElaujpNfgAIsP+JKEMx2RGYL19KQ90FmsENqmnQiC2LOlgEAyz6JYuIJOY1S1oe6iYskJTdLHhhtvh8OUG0DZSr+6hVMXEPXryzmmt/aFWgRwxOIS/GC2vcBVhGEBlU8DIiCwVbmTQxgUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500796; c=relaxed/simple;
	bh=JRj7PsQL/s6lQLMH5Hz+ENNgXMGZvOEDW61OthTTRbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaty+U8x/qDZIJzy5KYqGzJLynj8krWi5UqnrkjhFXHu2dRNtYsycmQ7i09/Il7Krkqwu0FdGsdWR+EgspHRT9iXTZ1UFBL/gcyno2eoCl9JTm8ZzVE//vRpldOI2r/m8Y3lVvEUG09U8a/N/qj5Z1Gl1XqQOjgQhKfmhw5ZO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2gy0iAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965F1C4CEF8;
	Wed,  6 Aug 2025 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500795;
	bh=JRj7PsQL/s6lQLMH5Hz+ENNgXMGZvOEDW61OthTTRbo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=m2gy0iAq3W71Wn7Z6j8l6kdsbV/fyxb53mB0i/tb3+atk4apGrhtwMlsT10iASRxz
	 XvfWNOZtPKze+81Eoy5qw3mnbEwYUQFZwYB5B8PCGg3rFxGadlS538XOzG6Qw9v7XM
	 fXdXBpbVJmYzkk23BzkNOPzvBpfmveQOzUWbXrs3KqDm0wHBXgtB5XU7wDIffcYDjw
	 x4lrtnrLkjrTztrjSlRENngOjwNtzJYdmbmAg6BmqnBgjAVm2Tx56vKo6V5zpvDcqv
	 rnEnA9TzcAK/MVL46ThGV3xoIUKAVNMJxgeI6s4Y10Y6mVLjcEfcZwEldY/t+rWhwZ
	 OHXreM4mw+kBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 42AC7CE0C35; Wed,  6 Aug 2025 10:19:55 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:19:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Carlos Bilbao <bilbao@vt.edu>
Cc: Akira Yokosawa <akiyks@gmail.com>, carlos.bilbao@kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] docs/core-api: Fix circular buffer examples
Message-ID: <f4c744ec-0f68-49e2-93ff-8d7461cce2fc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250720160243.149595-1-carlos.bilbao@kernel.org>
 <1e3c4ee3-f66e-4ce0-819e-e0bed6a744e8@gmail.com>
 <8723a37f-0a04-4e46-80a1-7bb817ecae03@paulmck-laptop>
 <9dcd185f-184e-4c1b-95c8-9f649a9d05f8@vt.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dcd185f-184e-4c1b-95c8-9f649a9d05f8@vt.edu>

On Mon, Aug 04, 2025 at 05:05:30PM -0500, Carlos Bilbao wrote:
> Hello,
> 
> On 7/23/25 15:47, Paul E. McKenney wrote:
> > On Mon, Jul 21, 2025 at 11:47:25AM +0900, Akira Yokosawa wrote:
> > > +CC David and Paul, who are the authors of this doc.
> > > 
> > > On Sun, 20 Jul 2025 11:02:43 -0500, Carlos Bilbao wrote:
> > > > From: Carlos Bilbao <carlos.bilbao@kernel.org>
> > > > 
> > > > Fix circular buffer usage in producer/consumer examples in
> > > > circular-buffers.rst. They incorrectly access items using buffer[head] and
> > > > buffer[tail], as if buffer was a flat array; but the examples also use
> > > > buffer->head and buffer->tail, so it's a struct. Use buffer->vals[head] and
> > > > buffer->vals[tail] instead to match the intended layout.>
> > > > 
> > > > Signed-off-by: Carlos Bilbao <carlos.bilbao@kernel.org>
> > Hello, Carlos, and thank you for your attention to detail!
> > 
> > This one could likely use more help, as the last substantive change was
> > more than ten years ago.
> > 
> > But are you referring to a particular use of CIRC_SPACE() and CIRC_CNT()
> > for this change?  If so, could you please identify it in the commit log?
> 
> No, it's just the uses of the structure. Take a look at the patch, you'll
> see. The mistake was introduced in this commit:
> 
> commit 90fddabf5818367c6bd1fe1b256a10e01827862f
> Author: David Howells <dhowells@redhat.com>
> Date:   Wed Mar 24 09:43:00 2010 +0000
> 
>     Document Linux's circular buffering capabilities
> 
>     Document the circular buffering capabilities available in Linux.
> 
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     Reviewed-by: Randy Dunlap <rdunlap@xenotime.net>
>     Reviewed-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Please understand that I am not arguing for no change, and that I do
appreciate your attention to detail and your willingness to propose an
actual change.

In this sentence in the original:  "The producer will look something like
this", the words "something like" are important, as in the following is
pseudocode rather than code that can be built.  You appear to be looking
to make this be actual code, which would be a good thing.  Except that
we have this:

	struct circ_buf {
		char *buf;
		int head;
		int tail;
	};

As you can see, there is no ->vals member, which is likely to look silly
to some future reader, just as the conflict between "buffer->size"
on the one hand and "buffer[head]" on the other looked silly to you,
and rightly so.  And both you and that potential future reader would be
quite justified in their judging the pseudo code as being silly.

So if we are going to change this, why not bite the bullet and make it
be real code that lives within the confines of the circ_buf structure?
Or, alternatively, that creates its own structure on the other?
Either approach will be a larger change, but the result will be more
helpful to a larger fraction of the future readers.

One approach would be to look for uses of the circ_buf structure,
CIRC_SPACE(), and CIRC_CNT() in the kernel and create an example
based on a simple use case.

Would you be willing to take this on?

							Thanx, Paul

> > > > ---
> > > >   Documentation/core-api/circular-buffers.rst | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/Documentation/core-api/circular-buffers.rst b/Documentation/core-api/circular-buffers.rst
> > > > index 50966f66e398..b697915a2bd0 100644
> > > > --- a/Documentation/core-api/circular-buffers.rst
> > > > +++ b/Documentation/core-api/circular-buffers.rst
> > > > @@ -161,7 +161,7 @@ The producer will look something like this::
> > > >   	if (CIRC_SPACE(head, tail, buffer->size) >= 1) {
> > > >   		/* insert one item into the buffer */
> > > > -		struct item *item = buffer[head];
> > > > +		struct item *item = buffer->vals[head];
> > > >   		produce_item(item);
> > > > @@ -203,7 +203,7 @@ The consumer will look something like this::
> > > >   	if (CIRC_CNT(head, tail, buffer->size) >= 1) {
> > > >   		/* extract one item from the buffer */
> > > > -		struct item *item = buffer[tail];
> > > > +		struct item *item = buffer->vals[tail];
> > > >   		consume_item(item);
> > > > -- 
> > > > 2.43.0
> > >          Thanks, Akira
> > > 
> 
> Thanks,
> 
> Carlos
> 

