Return-Path: <linux-kernel+bounces-846779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEC3BC9039
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A706352A05
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4B2E1F05;
	Thu,  9 Oct 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fZN0ltVN"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7E2E091C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012991; cv=none; b=LgBc6eXgPfyhZmUDrNYWAHh7aFsaUL/pZ9PgYZEgOZ6No5MRKMX2Fgx6LV3NYxgJnXJitPwT6TBrAOzmf2QE/aBtSGQGXvWUi04j9UuK3flLye4CE9nUb1gSieZlrKNCalU7ZXkiGbun8ZgBEWhMcKBchwJ+8VnYpxzB9WmtyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012991; c=relaxed/simple;
	bh=nIFboafrNi0BUG3ws1UQuEY6t196iFtUs5CJ/6Z3qdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me9uDD4syqZHuVxtjE7s6htD8TngFkAfwjQJUWZ8Z+ql3zyJmwXBxAHZKtFvu+6MC61V4eM4iO4JsBrZPmrbvAO92kRXpokuWOKGce2XuCRB7db6xv7f2TsxNMltXbjzySXnzp9bHT+BbvIxF2g0nfyFVLTd4QG0pNLKXbLlORA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fZN0ltVN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so565877f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760012986; x=1760617786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu6ugJTTIypDI4SOSb2R8Mjsv30lTM9CYkItNRo7M18=;
        b=fZN0ltVNBZLzDuGmnhfxKaSLry1tBTskH40GPkHJ6g6k15o9lg17w9NBU5nckbRo0y
         AvlQOAro60dGS9FdNvbKaVOTlMPhnGAONtyp6pZ9etygtBPYHt8+NnfCL1Ar14ceEkQr
         ahyzExSZLnhTSYcJxfmk5NgvubNs5S6+fHjdbMqor3wDodSS7CSNUmw6HJR7s1NfxMCL
         o7nu1nxDzA0LodCMTOrBAqYHW3AnmcQL3QSIyI42Pa0JlEn83m3tgp60CdppVp7yPHqk
         E3zlEl8MyzWIgn/S6ZE4cT5sjeWDc2psrUoYgkQtICWV/U917Sh4aDWFVc87Gsnlm5z2
         ShdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012986; x=1760617786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cu6ugJTTIypDI4SOSb2R8Mjsv30lTM9CYkItNRo7M18=;
        b=soKfXZj6gQZG6vXTsN7sW+ifk3QhkEq4JwGm2340kayUtkQmCdzEshGcOJiB3i00PT
         o3Bm7hkTI4YnS7I6WIb/6HYWQSbKJQYSUxgjUniaE0ouC5LG9vwlTgmKIsd4AxDXVTDU
         ijE2FVbpLALb+ToVnUdyf+HdPNkO/McUG0xqMXo+iGBNmUm0CwMte9tg7LH0FVmAmwft
         UB0fu3SFpgdRy5ZJ1MhXuqm+rsKurJ19atMGLj4Ln5HYN7myh4aAIK6nThDpEAUI+JCl
         AnPFRDRf029tjtc7agMEu7aEuorc/mWBy3FW9yN+FAFGNhEdmZW20fqx99GwFbrs/P+r
         A9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1ukDvaUnBSAgOBo11s4J3//NKSwD3KMpj0RxzG0RqWDH2BcMKnRwOsQht1P7Riq7E2NiD4eTIzhtM4wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyypDIrJWxkP4ALfsYKrKAlpHJeQw+dMDnDubIXOUiAkW/IMc/M
	HYVSXg+7A7tOODs1cTcIvjRVsNbDI+wjQcKiriHVIdWV+N3f35vk3JO2ftR0F454Pg0=
X-Gm-Gg: ASbGncs+msjQXcT97PTMVWYlYFztARrAEvhhQ5QUp1rSO+Zxvs44LiXbWNXzeMH1y4n
	ZZqyy73A5dB0K6ZcbxPOQxE8igSs/Vszij5+70W7ARTXSc36qglTSwRd3iza5t2t+fnoaQILYIk
	k6teYz/WGFWZDd9zXu5xHC0zq2Xqtdt9Djtta93raqYih7VrJ5NXhNqxF9Cvm1wQc+D+lIL0sCP
	cBb0uRGuNy8Lz4+2lyQ9qsfdyS01/8t57AvthJxRuFgd6a6LrRnTrqpXPO/8g5WQl9IIrDJFmQA
	nojZ9Qq+PHS0EB6sY/rNC2NDMSibCPaCi6hIj/2eIcatuA4PUsHS5V0wSuEXXXeoZqOjJMVlamI
	Z7aT3Vh7g1Ze33oUzJ3iUSyL+qvYVYyoau7zdsS7bZQxfiJ30Zw==
X-Google-Smtp-Source: AGHT+IG2Tl/tPro1CfvQuSpKAz35uSnQDYXoHXriXJMjWBawh/THIKmCxLzrEGjeTY0zfp/rdITohQ==
X-Received: by 2002:a05:6000:200c:b0:3c8:7fbf:2d6d with SMTP id ffacd0b85a97d-4266e8ddfecmr4564181f8f.50.1760012986407;
        Thu, 09 Oct 2025 05:29:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0170sm35660941f8f.49.2025.10.09.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:29:45 -0700 (PDT)
Date: Thu, 9 Oct 2025 14:29:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
	laokz <laokz@foxmail.com>, Jiri Kosina <jikos@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Weinan Liu <wnliu@google.com>,
	Fazla Mehrab <a.mehrab@bytedance.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 51/63] objtool/klp: Introduce klp diff subcommand for
 diffing object files
Message-ID: <aOeqt32wQhB5jAD-@pathway.suse.cz>
References: <cover.1758067942.git.jpoimboe@kernel.org>
 <702078edac02ecf79f869575f06c5b2dba8cd768.1758067943.git.jpoimboe@kernel.org>
 <aOZuzj0vhKPF1bcW@pathway.suse.cz>
 <bnipx2pvsyxcd27uhxw5rr5yugm7iuint6rg3lzt3hdm7vkeue@g3wzb7kyr5da>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnipx2pvsyxcd27uhxw5rr5yugm7iuint6rg3lzt3hdm7vkeue@g3wzb7kyr5da>

On Wed 2025-10-08 08:27:45, Josh Poimboeuf wrote:
> On Wed, Oct 08, 2025 at 04:01:50PM +0200, Petr Mladek wrote:
> > On Wed 2025-09-17 09:03:59, Josh Poimboeuf wrote:
> > > +static int read_exports(void)
> > > +{
> > > +	const char *symvers = "Module.symvers";
> > > +	char line[1024], *path = NULL;
> > > +	unsigned int line_num = 1;
> > > +	FILE *file;
> > > +
> > > +	file = fopen(symvers, "r");
> > > +	if (!file) {
> > > +		path = top_level_dir(symvers);
> > > +		if (!path) {
> > > +			ERROR("can't open '%s', \"objtool diff\" should be run from the kernel tree", symvers);
> > > +			return -1;
> > > +		}
> > > +
> > > +		file = fopen(path, "r");
> > > +		if (!file) {
> > > +			ERROR_GLIBC("fopen");
> > > +			return -1;
> > > +		}
> > > +	}
> > > +
> > > +	while (fgets(line, 1024, file)) {
> > 
> > Nit: It might be more safe to replace 1024 with sizeof(line).
> >      It might be fixed later in a separate patch.
> 
> Indeed.
> 
> > > +/*
> > > + * Klp relocations aren't allowed for __jump_table and .static_call_sites if
> > > + * the referenced symbol lives in a kernel module, because such klp relocs may
> > > + * be applied after static branch/call init, resulting in code corruption.
> > > + *
> > > + * Validate a special section entry to avoid that.  Note that an inert
> > > + * tracepoint is harmless enough, in that case just skip the entry and print a
> > > + * warning.  Otherwise, return an error.
> > > + *
> > > + * This is only a temporary limitation which will be fixed when livepatch adds
> > > + * support for submodules: fully self-contained modules which are embedded in
> > > + * the top-level livepatch module's data and which can be loaded on demand when
> > > + * their corresponding to-be-patched module gets loaded.  Then klp relocs can
> > > + * be retired.
> > 
> > I wonder how temporary this is ;-) The comment looks optimistic. I am
> > just curious. Do you have any plans to implement the support for
> > the submodules... ?
> 
> I actually already have a working POC for that, but didn't want to make
> the patch set even longer ;-)

Sure.

> It was surprisingly easy and straightforward to implement.

I am curious ;-)

> > PS: To make some expectations. I am not doing a deep review.
> >     I am just looking at the patchset to see how far and mature
> >     it is. And I just comment what catches my eye.
> > 
> >     My first impression is that it is already in a pretty good state.
> >     And I do not see any big problem there. Well, some documentation
> >     would be fine ;-)
> > 
> >     What are your plans, please?
> 
> >From my perspective, it's testing well and in a good enough state for
> merging soon (after the merge window?), if there aren't any objections
> to that.
> 
> There will be more patches to come, like the submodules and other arch
> support.  And of course there will be bugs discovered by broader
> testing.  But I think this is a good foundation to begin with.
> 
> And the sooner we can get people using this, the sooner we can start
> deprecating kpatch-build, which would be really nice.

Sounds reasonable and I am fine with it. I have one more question
before I give my ack ;-)

I wonder about the patchset which better integrate callbacks with shadow
variables and state API, see
https://lore.kernel.org/r/20250115082431.5550-1-pmladek@suse.com

I think that it should not be that big problem to update it on top
of this patchset. It would require:

   + moving declarations from livepatch.h to livepatch_external.h
   + updating the macros in livepatch_helpers.h
   + update callback-related code in create_klp_sections()

Or do you expect bigger problems, please?

Best Regards,
Petr

