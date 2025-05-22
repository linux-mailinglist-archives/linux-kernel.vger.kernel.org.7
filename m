Return-Path: <linux-kernel+bounces-658524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC39AC0390
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 06:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CAC946476
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 04:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A081A238E;
	Thu, 22 May 2025 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYPCpO6A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D670825;
	Thu, 22 May 2025 04:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747889358; cv=none; b=TNus1VBlDRkKs4AVxCZwl85xHnjo/Qh2btyEAP77nlQ+NhuUTwZm0DoDrIA+Jaa0kaJH7chOasKkldEg8iGqIISMqaUkwDsa1cX0+xE9GeQRMgYDYIRHQNETx/jxRXAYeJv9kBe8idFBJ+LiMxMa2aPIW4gFbqlgY7fVP9/JOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747889358; c=relaxed/simple;
	bh=aPudw0dVBQpEvQRl1VFGAdIsPbR2WurQQ1CRwPqaS1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXCG6+P4FtGtIcYoohw8Zj1oVqI64HiIjAk4aZV8qC/mrDsexWlKh+Xzvjcjp+jl7QNjN+qgqoHdWTiWOl9BkJDmGQYhmui8UP7QJNBfH2x+AEnhsK+La39RGxAxwgppHucvBUmOPX+0YI9vkBPW3MOgjRXDQ1XjmNkXzdu11/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYPCpO6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87813C4CEE4;
	Thu, 22 May 2025 04:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747889358;
	bh=aPudw0dVBQpEvQRl1VFGAdIsPbR2WurQQ1CRwPqaS1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYPCpO6AnyGy05ZQCa6yRnp+/da7Ddf9J5JESiN9hJklllo43l2s+jwPAr/02kKs+
	 ChafBGFVdaEY2pAaTktWI4kYFxjrGLtxgT6v0pngjUi0NX42D/4iQxHMkY6TYt5Igw
	 IDx2RH8IQZRcLhFxwbiHY21+37qcNb6CqHxwPGfk=
Date: Thu, 22 May 2025 06:49:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Remo Senekowitsch <remo@buenzli.dev>, Rob Herring <robh@kernel.org>,
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
Message-ID: <2025052244-untaken-spied-868b@gregkh>
References: <20250520200024.268655-1-remo@buenzli.dev>
 <20250520200024.268655-5-remo@buenzli.dev>
 <2025052153-steadier-bargraph-e81a@gregkh>
 <DA1UXY2O47Y2.1ND9MC6L01217@buenzli.dev>
 <2025052116-gem-blend-2585@gregkh>
 <DA220Y73P1NR.192OYSQH3UD7A@buenzli.dev>
 <aC4lxKwYKRkcTNtD@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC4lxKwYKRkcTNtD@cassiopeiae>

On Wed, May 21, 2025 at 09:13:08PM +0200, Danilo Krummrich wrote:
> On Wed, May 21, 2025 at 08:36:10PM +0200, Remo Senekowitsch wrote:
> > On Wed May 21, 2025 at 6:58 PM CEST, Greg Kroah-Hartman wrote:
> > > On Wed, May 21, 2025 at 03:03:07PM +0200, Remo Senekowitsch wrote:
> > >> On Wed May 21, 2025 at 2:02 PM CEST, Greg Kroah-Hartman wrote:
> > >> > On Tue, May 20, 2025 at 10:00:19PM +0200, Remo Senekowitsch wrote:
> > >> >> Add two new public methods `display_name` and `display_path` to
> > >> >> `FwNode`. They can be used by driver authors for logging purposes. In
> > >> >> addition, they will be used by core property abstractions for automatic
> > >> >> logging, for example when a driver attempts to read a required but
> > >> >> missing property.
> > >> >> 
> > >> >> Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
> > >> >> ---
> > >> >>  rust/kernel/device/property.rs | 72 ++++++++++++++++++++++++++++++++++
> > >> >>  1 file changed, 72 insertions(+)
> > >> >> 
> > >> >> diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
> > >> >> index 70593343bd811..6ccc7947f9c31 100644
> > >> >> --- a/rust/kernel/device/property.rs
> > >> >> +++ b/rust/kernel/device/property.rs
> > >> >> @@ -32,6 +32,78 @@ pub(crate) fn as_raw(&self) -> *mut bindings::fwnode_handle {
> > >> >>          self.0.get()
> > >> >>      }
> > >> >>  
> > >> >> +    /// Returns an object that implements [`Display`](core::fmt::Display) for
> > >> >> +    /// printing the name of a node.
> > >> >> +    pub fn display_name(&self) -> impl core::fmt::Display + '_ {
> > >> >> +        struct FwNodeDisplayName<'a>(&'a FwNode);
> > >> >> +
> > >> >> +        impl core::fmt::Display for FwNodeDisplayName<'_> {
> > >> >> +            fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
> > >> >> +                // SAFETY: self is valid by its type invariant
> > >> >> +                let name = unsafe { bindings::fwnode_get_name(self.0.as_raw()) };
> > >> >> +                if name.is_null() {
> > >> >> +                    return Ok(());
> > >> >
> > >> > So if there is no name, you are returning Ok()?  Are you sure that's ok
> > >> > to do?  What will the result of the string look like then?
> > >> 
> > >> In that case we're not writing anything to the formatter, which is
> > >> equivalent to an empty string. `Ok(())` means that writing succeeded.
> > >> 
> > >> I assumed that a valid node would always have a name. And we're
> > >> guaranteed to have a valid node. So I assumed this case would never
> > >> happen and didn't think too hard about it. But even if a valid node has
> > >> not name, empty string is probably the correct thing, right?
> > >
> > > I don't know what this "name" is used for.  An empty string might not be
> > > what you want to use here, given that you could be naming something
> > > based on it, right?  fwnode_get_name() is used for many things,
> > > including the detection if a name is not present at all, and if not,
> > > then the code needs to clean up and abort.
> > >
> > > So what exactly are you going to be using this for?
> > 
> > Valid question... I'm not using it for anything.
> 
> You're using this in PropertyGuard::required_by(), where you use display_path()
> and hence display_name() to print the node path in the error case.
> 
> So, currently, this is only used in the error case when a property of a given
> node that is required by a driver can't be found.

And in that case, the "normal" dev_err() output should be all that is
needed here, not a "pretty printer" that might fail to document it at
all :)

thanks,

greg k-h

