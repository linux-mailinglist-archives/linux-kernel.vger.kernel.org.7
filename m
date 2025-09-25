Return-Path: <linux-kernel+bounces-832272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A5B9EC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366E14207B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B035E2FB61A;
	Thu, 25 Sep 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VbPz6Qqp"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200342FB086
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796979; cv=none; b=YYQ5y1TaxOINo1BXMtLMUabS28anYIel9Vh85dHFHUZ7gzTBh2j7teniJczWL/unvzCOgd+xNjFZ16+tCwAikmUGex+nazYY/GPUnx0NAGNHZdW65t8gt+VhXRGjDf4pAaduUuG7DgT/wI0x3OkDasDz/TybwOw30n3pc2Ek3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796979; c=relaxed/simple;
	bh=UeezVNoDuhdU59b/omhxGqBB9jTFbx3XHQn1TdwEPBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeSUkaitwXCtkqIYNMztsLDGzt1LoKTPWWcPzmVrYO/UOOUhCZf2rYs/oJuYwlSkLMBDXiEgpYyTwDxrEtioJJigxilHTegNfSKPAJW7Zemct12JbyoGXEbo/W/wXAbOH2NBhYpEtJdjWo2jbspbEVo3vieJkrjLgaTloYSxM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VbPz6Qqp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pcxu//loBh6joTNIURdmB6/Yb3FHDJq7TTFtNqxANwQ=; b=VbPz6QqpNCk8+BvXkXuvYlwAPy
	8+YufG71f9ZCJs22wlBUcCEeW/rYGhD717Ld8rDapRPhbo2CWAh9F+NtHMHF0UzaaiRkG+i98RLBS
	hP9oFrmB5M0emENSM1575+rupDJ9vyTKQxGCJHP+Klg7HT7q6hbDisQ/KxMnXu9kW0fgdK3Q2xdry
	MtLER+vuB8Xof0RT8eXjhaTWbk9JuqZivgEOTjs15a22lT13HMTycjf+LBGcShNKyA7G6dbmPBLc+
	39h3nU4P84cdiFaN/T4dRGDmuTk7Uw//Oy3nX/Ljw8C7P7NVIL8FIiEWhCdJNW79aL5MBV8A84JBe
	waswnYKg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1jR7-0000000947G-0BY4;
	Thu, 25 Sep 2025 10:42:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D1ACD3002BF; Thu, 25 Sep 2025 12:42:51 +0200 (CEST)
Date: Thu, 25 Sep 2025 12:42:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: jpoimboe@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool/x86: Fix NOP decode
Message-ID: <20250925104251.GZ4067720@noisy.programming.kicks-ass.net>
References: <20250924134507.288529132@infradead.org>
 <20250924134644.154610650@infradead.org>
 <b6aaa53d-2658-491a-9308-32ae2b5aefb1@oracle.com>
 <20250924184158.GZ3245006@noisy.programming.kicks-ass.net>
 <f17d5e92-2aaa-43e7-ba67-ea5e7d07601a@oracle.com>
 <20250925100323.GY4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925100323.GY4067720@noisy.programming.kicks-ass.net>

On Thu, Sep 25, 2025 at 12:03:23PM +0200, Peter Zijlstra wrote:

> > > > >    	case 0x90:
> > > > > +		if (prefix != 0xf3) /* REP NOP := PAUSE */
> > > > > +			insn->type = INSN_NOP;
> > > > >    		break;

> > What about 0x49 0x90, which is xchg (XCHG r8,rAX) ?

I've made that:

	case 0x90:                                                                                                                                                                                                                        
		if (rex_b) /* XCHG %r8, %rax */ 
			break; 

		if (prefix == 0xf3) /* REP NOP := PAUSE */ 
			break; 

		insn->type = INSN_NOP; 
		break;



