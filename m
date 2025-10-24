Return-Path: <linux-kernel+bounces-868871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A7BC06600
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44C8D50298E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C585431A564;
	Fri, 24 Oct 2025 12:58:18 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41931280B;
	Fri, 24 Oct 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310698; cv=none; b=jvy2FhN82PTONqZTCPAIakvYszxPv9s/KEGQG2Qb+edihyKaCrsBZE7AaSIjOyh93/FQVeu43FEfi1oB5QaZcHEziycL6BdGgPDar6Gm4tQPHVwvUEnoNVCi0HBRxdLV5nXm+PxtnSlXlROkjSQI0XNQ+/u8Xtbboa6L82D2clA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310698; c=relaxed/simple;
	bh=LC0WkeQMDcTsA+mG2+dgh2PuWHMRw/795KAlcCmwjbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2wvRaYsRBy/hRTy3EOrC2TfUMq7P1oTS1Wr2trzaoPwF5oVsrgRKUi8fGhcReHlx2LD0F1a/EqaE7gUTCk1oRJilVkA4xl6scsOxCtPoCbBWBQkTpRAQaDJabNO/iep+5yYbfwkKDejbhLzmxeoaStQnmGA+xcEaQD7MAUwjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2B1D060308; Fri, 24 Oct 2025 14:58:14 +0200 (CEST)
Date: Fri, 24 Oct 2025 14:58:13 +0200
From: Florian Westphal <fw@strlen.de>
To: Andrii Melnychenko <a.melnychenko@vyos.io>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org,
	phil@nwl.cc, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] nft_ct: Added nfct_seqadj_ext_add() for NAT'ed
 conntrack.
Message-ID: <aPt35eDPqjUAuG1U@strlen.de>
References: <20251021133918.500380-1-a.melnychenko@vyos.io>
 <20251021133918.500380-2-a.melnychenko@vyos.io>
 <aPeZ_4bano8JJigk@strlen.de>
 <aPghQ2-QVkeNgib1@calendula>
 <aPi8h_Ervgips4X4@strlen.de>
 <CANhDHd_iPWgSuxi-6EVWE2HVbFUKqfuGoo-p_vcZgNst=RSqCA@mail.gmail.com>
 <CANhDHd_xhYxWOzGxmumnUk1f6gSWZYCahg0so+AzOE3i12bL9A@mail.gmail.com>
 <aPoi0Sozs3C9Ohlc@strlen.de>
 <CANhDHd_W=FQkm0u3ZBSE4-RQpGQcXUqKwJRDj7e9anPbv8Djrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANhDHd_W=FQkm0u3ZBSE4-RQpGQcXUqKwJRDj7e9anPbv8Djrw@mail.gmail.com>

Andrii Melnychenko <a.melnychenko@vyos.io> wrote:
> Client has to connect to the router (192.168.100.2 -> 192.168.100.2),
> while the FTP server would receive the connection from the client
> (192.168.100.2 -> 192.168.33.2).
> So the connection hits SNAT when it's already established and confirmed.
> 
> > This sets up snat which calls nf_nat_setup_info which adds the
> > seqadj extension.
> 
> So, we still need to add seqadj allocation for DNAT.
> I will propose a new patch v4 with `regs->verdict.code = NF_DROP;`.

Yes, just resend your previous patch with the DROP added to force
rexmit rather than ending up with a non-working/stuck connection.

> And later, I can provide a new ruleset for tests in `nft_ftp` for `nftables`.

Thank you.

> Any suggestions?

You can send the bug fix now and followup with a different config later,
you can just extend the existing test case or, if you think your scenario
differs too much, add a new one.

