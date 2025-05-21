Return-Path: <linux-kernel+bounces-658136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238DAABFD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 21:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778FB1BC30BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 19:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4B428F94F;
	Wed, 21 May 2025 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7RjyOTr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51919C55E;
	Wed, 21 May 2025 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747854795; cv=none; b=IQ9nV2+ZKWdwTZzjLOmVnLlOm25lf4qsKsKhGN+FVuFZ1IIMs9g9/FzWOUSq04bqfbUaKQXs0/Zg/sEPBZmG0vZyDP1UwTikb7Rg08HbwLeDM5zf8Jy+IZ3CYFeRzrvEPUft/V5penpGrvkZgohfsJDWCzEUlyCiLvsaLUbwhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747854795; c=relaxed/simple;
	bh=9EzX2dU90JJhlq1Gk4qYp3Mu+bt0OVzSdbWgoGAqck4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltLQNJK4ecthA3yzlxC8zThiWLBn2DIAFf2TupZWRlljtVlI7NdfuSWnADcalZb7c+0Qaq0EHUm29SqItgqX71mUyvOvLF51ljXU4nVtkIIqwVf5qWkqe4M+QZeuU6k28z88bFQI7NsziAmKxJ15p+/9JPXTOEtwlbuuwOihQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7RjyOTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F9AC4CEE4;
	Wed, 21 May 2025 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747854794;
	bh=9EzX2dU90JJhlq1Gk4qYp3Mu+bt0OVzSdbWgoGAqck4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7RjyOTr3b+qLyS1PUQ32UD9xSlhoPBu58KK7FCfQ252QsIRtIXCL2k19LfT0aT9D
	 M7beP0wJs0ZwQ4A4+N7ezNkSfkausTZCA/QuSqOGJMi7vAfRU8eOETVvOFGn0RVEI5
	 VDMiqBK7rwoBs9Zwj3SrxeRu18/dPtaDZZOtek6i/E4SqOpCHQ7VI8qvF+eu1kwiCj
	 NYKHvJ8O8Ga9c9D7jD+mixEyL9/Uu66NPfzyQs6v/rwGj1dz16QXJhrxoBLVSS7OzN
	 Ss2WqF+hqlVzyEh0TKi/pyYnoHC3ihGuqm3DiBLY89ILZo2SsuAPEyWBNGraKSJGDc
	 hkUfV3mI0fttA==
Date: Wed, 21 May 2025 21:13:08 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 4/9] rust: device: Enable printing fwnode name and path
Message-ID: <aC4lxKwYKRkcTNtD@cassiopeiae>
References: <20250520200024.268655-1-remo@buenzli.dev>
 <20250520200024.268655-5-remo@buenzli.dev>
 <2025052153-steadier-bargraph-e81a@gregkh>
 <DA1UXY2O47Y2.1ND9MC6L01217@buenzli.dev>
 <2025052116-gem-blend-2585@gregkh>
 <DA220Y73P1NR.192OYSQH3UD7A@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA220Y73P1NR.192OYSQH3UD7A@buenzli.dev>

On Wed, May 21, 2025 at 08:36:10PM +0200, Remo Senekowitsch wrote:
> On Wed May 21, 2025 at 6:58 PM CEST, Greg Kroah-Hartman wrote:
> > On Wed, May 21, 2025 at 03:03:07PM +0200, Remo Senekowitsch wrote:
> >> On Wed May 21, 2025 at 2:02 PM CEST, Greg Kroah-Hartman wrote:
> >> > On Tue, May 20, 2025 at 10:00:19PM +0200, Remo Senekowitsch wrote:
> >> >> Add two new public methods `display_name` and `display_path` to
> >> >> `FwNode`. They can be used by driver authors for logging purposes. In
> >> >> addition, they will be used by core property abstractions for automatic
> >> >> logging, for example when a driver attempts to read a required but
> >> >> missing property.
> >> >> 
> >> >> Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
> >> >> ---
> >> >>  rust/kernel/device/property.rs | 72 ++++++++++++++++++++++++++++++++++
> >> >>  1 file changed, 72 insertions(+)
> >> >> 
> >> >> diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
> >> >> index 70593343bd811..6ccc7947f9c31 100644
> >> >> --- a/rust/kernel/device/property.rs
> >> >> +++ b/rust/kernel/device/property.rs
> >> >> @@ -32,6 +32,78 @@ pub(crate) fn as_raw(&self) -> *mut bindings::fwnode_handle {
> >> >>          self.0.get()
> >> >>      }
> >> >>  
> >> >> +    /// Returns an object that implements [`Display`](core::fmt::Display) for
> >> >> +    /// printing the name of a node.
> >> >> +    pub fn display_name(&self) -> impl core::fmt::Display + '_ {
> >> >> +        struct FwNodeDisplayName<'a>(&'a FwNode);
> >> >> +
> >> >> +        impl core::fmt::Display for FwNodeDisplayName<'_> {
> >> >> +            fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
> >> >> +                // SAFETY: self is valid by its type invariant
> >> >> +                let name = unsafe { bindings::fwnode_get_name(self.0.as_raw()) };
> >> >> +                if name.is_null() {
> >> >> +                    return Ok(());
> >> >
> >> > So if there is no name, you are returning Ok()?  Are you sure that's ok
> >> > to do?  What will the result of the string look like then?
> >> 
> >> In that case we're not writing anything to the formatter, which is
> >> equivalent to an empty string. `Ok(())` means that writing succeeded.
> >> 
> >> I assumed that a valid node would always have a name. And we're
> >> guaranteed to have a valid node. So I assumed this case would never
> >> happen and didn't think too hard about it. But even if a valid node has
> >> not name, empty string is probably the correct thing, right?
> >
> > I don't know what this "name" is used for.  An empty string might not be
> > what you want to use here, given that you could be naming something
> > based on it, right?  fwnode_get_name() is used for many things,
> > including the detection if a name is not present at all, and if not,
> > then the code needs to clean up and abort.
> >
> > So what exactly are you going to be using this for?
> 
> Valid question... I'm not using it for anything.

You're using this in PropertyGuard::required_by(), where you use display_path()
and hence display_name() to print the node path in the error case.

So, currently, this is only used in the error case when a property of a given
node that is required by a driver can't be found.

