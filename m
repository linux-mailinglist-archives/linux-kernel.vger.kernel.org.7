Return-Path: <linux-kernel+bounces-863083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEBABF6F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8003B5070B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F0338909;
	Tue, 21 Oct 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lS5sJkQG"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031C33B957
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055408; cv=none; b=kmWJ5+QF+SM5JwQt9Ig35LAkHAMFcJ2ODx7brDpuK5XMldlDJCjJALxUaHfXKALEMKR4UPnhJbGdt9M8FhqGgVnpn+HQ0tTs7rexvTE9kn/hkNWgePzfzON/Z59kQZMC7t08cuiHuuSjHn5v0rSUN4ZNI1U+XCij2/gvUD8jSTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055408; c=relaxed/simple;
	bh=kZdmGDrH12a2NZe71q/RdHKraO/fpesXMJWU6nqEF3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siWXcGWYlxM3JxZjPmnfFUc6nzSScfpU4hPCIOrVh2uMIj0VcSSgnXDPyA8Qup4UtULft0uQ811UCIcwE2DLw2qGjBQIBoAC9BUWoTmFAKePtE/vaxyCcPXFJau2hckePUvEn7gdgA2oYRirr/ziPT19xsu4XEGa8EU321srXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lS5sJkQG; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c1877b428so105031566d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761055405; x=1761660205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ydk0vuN1pviEYysaSWh5db6r1AHK7bIxN+bfh1ELr20=;
        b=lS5sJkQG7i2n3ZoBlUS+6MyD9ZeeFQHH8dxdVmRrzlIDlnDpOg6ebTIf5GKFxcHd6X
         k1YmSBulupMSSqLzJH0ERHp1gnyZAtSQXotUHBubuGEp/rWCr4H+HPNCsYsMHgCWybJz
         0hQkLNqT2cX9jVVHUckeWURtmSgykKAURbLx7T6ZJ1rCeApZY/itAZklZiOl5t7EfB87
         C2vhLlHGoLNzO5nJ0B7B7zcXzht9YYhZP1CUjDTzpBPV4eMkags2D/8vVq1bwh7wp6V5
         vA1uzjdNjd+MGPY5owxK/BknFD+ouXV1Q7348UGnPDRomFvLz8rJLjknhUQbTPH56sAm
         SRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055405; x=1761660205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ydk0vuN1pviEYysaSWh5db6r1AHK7bIxN+bfh1ELr20=;
        b=gFkMc5pQsSoyWT5UuyrN3bl+EEVS4h+2k/t3NlAoti5L9iFFJcRHPuHkMcdGx+hPcv
         EvxnVm87QDxwzYgcVoBdQLFIGzS7C2iFqm3btFAEWC5Y5C8c7NTTftSzG54CHbB2BZWx
         uDt6USmBFSYyYWabCrDKniX4XUDhkN5LF/E+HiQ/5RkEad3b44/dbu7dSwfSYzFeecTU
         znx0y8nIBeUrsfJMZnjfHR/ANJOVribjfxOMXYzAAgYA1S0SOq4C3Q3RdENwMxYqIw6Z
         KO5CHCDi9D+CBNU8FHrEa/x16+cJ+BG9eOnApMcJ+g456MLg74CO3jONs4KlMW2drwUd
         W1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3IwyF+7PxcPNYPB/dMQYjVjObkTn5KKGa03r9qAxGJmxjD2iurnKocAQOhn4edUwTv50wl4081p6id44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrLSsvskhj6LBWmCitbIGXnaA7iSkwSR6CL9NNv6N2IVboD36
	SbC+QDPjTA4WoXdo2hp5KObHBa31d0uu6IFW6vI+Rn7XDRREaN4e0SqZucHfU9FbzYA=
X-Gm-Gg: ASbGncsdts5/co4y/iMTk71NfpOhVlevlmIC9dZdq8kyx9DJ6IUxsPbzAWlafir6K+m
	08NK+gDHK+R14q75lbmjV9T6Tht5trRdoQx4KITvFSjfqJlCFJs7wXpU+smgJ9Q8luFErMClaCF
	OIeTezJTF/yb2d8NzU3o1TBjS35ZoYXeklK4EVU9YD+FSU+ge1LTfphd0/rkAabSUjkailt1YbK
	KZHEK9QxCV3tk32KcHXo1BmO6LowbGgZLnUXox6N9wMYrkbveyrAlTcAu8WH1P5lTxegd+UeFK1
	/FgK6prgJT6Y7iLxyGP1gMH4fV8RNOZZCiyi3vIkskF/nkjEkTMrEXoZl5Kwc0T6cw1YPYwa/3p
	3lfvOuvW/iYzJ1a+AA/Qui0rdnAnfNsz2M0ZpNG7OA0TA0iKqA+Zo9GdTfQuVt7/712io+1YMf8
	cjaeHAQ4qkv1SpAYx2U5g3yWV1dAbcEDr4hMHnhF6Z2500ohsP9NzV77bbA8dJpomStXVX0A==
X-Google-Smtp-Source: AGHT+IFuvXAl6TgoeI8SEbMMuK3HQIQ3jXEpVj4KF/jqZKlxNoovA4Y6fEZz3/6cxcExo+Slqui1+g==
X-Received: by 2002:a05:6214:2485:b0:7fd:2bc6:6cad with SMTP id 6a1803df08f44-87c20542e53mr243018526d6.10.1761055404384;
        Tue, 21 Oct 2025 07:03:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad781sm69248486d6.49.2025.10.21.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:03:23 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:03:22 -0400
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
Message-ID: <aPeSqjqU6BH9gvcw@gourry-fedora-PF4VCD3F>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-2-vaslot@nvidia.com>
 <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>
 <aPZE3Spas-IvHmfd@gourry-fedora-PF4VCD3F>
 <aPaNzeGqUHf6gGIu@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPaNzeGqUHf6gGIu@aschofie-mobl2.lan>

On Mon, Oct 20, 2025 at 12:30:21PM -0700, Alison Schofield wrote:
> On Mon, Oct 20, 2025 at 10:19:09AM -0400, Gregory Price wrote:
> > On Mon, Oct 20, 2025 at 12:09:34AM -0700, Alison Schofield wrote:
> > > > This patch updates cxl_test to enable decoders 1 and 2
> > > > in the host-bridge 0 port, in a switch uport under hb0,
> > > > and the endpoints ports with size zero simulating
> > > > committed zero sized decoders.
> > > 
> > > Decoders 1 & 2 - those are after decoder 0, the autoregion.
> > > That's a problem ATM, when we try to teardown the autoregion we
> > > get out of order resets. Like I asked in the other patch, if there
> > > are rules about where these zero size decoders may appear, that
> > > may make the solution here simpler.
> > > 
> > 
> > I think this is going to require a quirk-doc like other deviations.
> 
> Really need to hear more about spec here. You mention quirk, but is it
> really a quirk or spec defined behavior?
>

Quoted below.  Small bit of ambiguity around base=[X] when size=0.

There's no requirement on base for a size=0 decoder, so it sort of implies
the base is ignored - except that the normal commit requires (base+size)
checks on decoder[m]/[m+1] without discussing size=0 decoders.

So while the spec doesn't say the base in a 0-size decoder base address
must be set, if you implement the logic here trivially you will always
fail if the zero-size decoder.base=0.

Note that 14.13.9 also doesn't say firmware must enforce commit-order,
so deviant software could go off and commit decoders out of order.

All the spec says is "If software intends to set Lock On Commit,
Software must configure the decoders in order".

~Gregory


------------------------------------------

Re commit order - Vishal said they do post-lock order
https://lore.kernel.org/linux-cxl/aOP3Kr3jHLWOydRp@gourry-fedora-PF4VCD3F/

Post-lock order
[programmable] [zero-lock] [zero-lock] ... [zero-lock]

Pre-lock order:
[zero-lock] [zero-lock] ... [zero-lock] [programmable]

My reading of the spec suggests that Post-lock ordering is *not legal*,
and would suggest the software has deviated from the spec - which does
not allow for size-zero decoders to ignore commit order.

------------------------------------------
8.2.4.20.12: Committing Decoder Programming

If Software intends to set Lock On Commit, Software must configure the
decoders in order. In other words, decoder m must be configured and
committed before decoder m+1 for all values of m.

Decoder m must cover an HPA range that is below decoder m+1.

...

It is legal for software to program Decoder Size to 0 and commit it. Such a decoder will
not participate in HDM decode.

------------------------------------------
14.13.10: CXL HDM Decoder Zero Size Commit

Test Steps:
  1. Program 0 in the Decoder[m].Size register.
  2. Set the Commit bit in the Decoder[m].Control register.

Pass Criteria:
  • Committed bit in the Decoder[m].Control register is set
  • Error Not Committed bit in the Decoder[].Control register is not set

Fail Conditions:
  • Committed bit in the Decoder[m].Control register is not set within 10 ms
  • Error Not Committed bit in the Decoder[m].Control register is set

------------------------------------------
14.13.9 CXL HDM Decoder Commit

Test Steps:
  1. Program an address range in the Decoder[m+1].Base and Decoder[m+1].Size
     registers such that:

     — Decoder[m+1].Base >= (Decoder[m].Base+Decoder[m].Size), and
     — Decoder[m+1].Base <= Decoder[m+1].Base+Decoder[m+1].Size

