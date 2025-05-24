Return-Path: <linux-kernel+bounces-661479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F303AC2BAC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 00:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFFA17B7FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 22:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93EE2116E0;
	Fri, 23 May 2025 22:07:48 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23921018A
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748038068; cv=none; b=MkssTvEOIuK7W3Tef6AlRzslK1XD6fjjOmSzw8mlv10o2HUBe688EoPHtjG89zRalUE7lAg7/Wwo/WXKh7ML/ohSf9HWRjTX2X8YHp5hHN8eb7hWqDJKpMwdXL49498inlfPGQE5upEoKTmKjfZCE6fa3LxgXY13aQqygfUBJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748038068; c=relaxed/simple;
	bh=/Vv1WmyqouccS68NScFLocNcJemiPcN41TARbtmKYJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWZCPLN6BW2a7tYgb/jxjDAPUoeDLXWNc5O52zRWsn2lGga67xPRvc4oP0g8koeYiEOJnmnSeAiAxTFHgFP7B7Nbva7I/yWjUkI2K3gQ8hPIZEl2i21pf/c1XbXhDfMqfNYiEBK5Mzc+QBhqSp4Fp0oLfr7A45gGmadYrn+5AcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54NM7JSh006027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 18:07:22 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3AFC12E00DD; Fri, 23 May 2025 18:07:19 -0400 (EDT)
Date: Fri, 23 May 2025 18:07:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kees Cook <kees@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>,
        Ethan Carter Edwards <ethan@ethancedwards.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: replace strcpy() with '.' assignment
Message-ID: <20250523220719.GC332467@mit.edu>
References: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>
 <202505190651.943F729@keescook>
 <20250519145930.GB38098@mit.edu>
 <20250523133100.1b023a6e@pumpkin>
 <20250523142449.GB1414791@mit.edu>
 <85A9A687-D5E0-4EE4-8FFE-ED70C8CCE863@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85A9A687-D5E0-4EE4-8FFE-ED70C8CCE863@kernel.org>

On Fri, May 23, 2025 at 10:14:04AM -0700, Kees Cook wrote:
> 
> 
> On May 23, 2025 7:24:49 AM PDT, Theodore Ts'o <tytso@mit.edu> wrote:
> >On Fri, May 23, 2025 at 01:31:00PM +0100, David Laight wrote:
> >> 
> >> The compiler (or headers files) can also allow strcpy() of constant
> >> length strings into arrays (known size). Erroring requests that are too long.
> >> The strcpy() is then converted to a memcpy() which can then be optimised
> >> into writes of constants.
> >> 
> >> So using strcpy() under those conditions 'isn't all bad' and can generate
> >> better (and less bug prone) code than trying to hand-optimise it.
> >> 
> >> So even through strcpy() is usually a bad idea, there is not need to
> >> remove the calls that the compiler can validate as safe.
> >
> >I assume that what the hardening folks want to do is to assert that
> >strcpy is always evil(tm) so they can detect potential security bugs
> >by doing "git grep strcpy".
> 
> FWIW, what I'd like is a lack of ambiguity for both humans and
> compilers. "Get rid of strcpy" is the Big Hammer solution for
> strcpy. The more precise version is "disallow strcpy of a src or dst
> where either lack a compile-time buffer size".

Well, technically speaking struct ext4_dir_entry.name has a fixed
compile-time buffer size:

struct ext4_dir_entry {
	__le32	inode;			/* Inode number */
	__le16	rec_len;		/* Directory entry length */
	__le16	name_len;		/* Name length */
	char	name[EXT4_NAME_LEN];	/* File name */
};

And what we're copying into name here is also fixed.  It's either "."
or "..".   As far as optimization is concerned, whether

   de->name[0] = de->name[1] = '.';

could be better optimized by the compiler than:

   strcpy(de->name, "..");
or
   memcpy(de->name, "..", 2);
(which is all that is required)

Meh.  Probably the compiler could optimized it into a 2-byte word
store, but it's not like mkdir is a hot path.  :-)

It's probably easier to patch the code path and as opposed to having
the conversation about how "no, really, it's safe, and I can prove
it."  If this was a performance hot path, I might care more, but it
isn't, so I don't.

           	   	    	       - Ted

