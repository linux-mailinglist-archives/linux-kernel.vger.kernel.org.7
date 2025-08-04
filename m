Return-Path: <linux-kernel+bounces-755732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0A9B1AAFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A8916E8AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BFA18D;
	Mon,  4 Aug 2025 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL5ewztc"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69E38FA6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346879; cv=none; b=Q0m8vABd9BsscPZHK1mWNlnuEBtjvd5LnEYBgDV227E1vERtM08K/OW7YCN5WH9kuYVYnzujIqevRDO75E+Iq66LNuu2Qgkcn4f4ytmaymNE1i+EFvaiVkfGdllIcYx+0If7oCRkHfpoBZjGYtfS+bMFzF6hFRWWO0UsAd84rSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346879; c=relaxed/simple;
	bh=jLqHuEkPoyPdegSoer1lnw1IVig1L4050MNMgQHpMcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=py/kEfg+MIVddfOp6ovzCvU++UCbZ4an/nFCIBCLYyNjnOsTqjJlYPnFCBdpvRR+tYdksx2kcETKyyHnGUfBIlmsJKrdUZIeNabepmKGwE57XZ52OAzN7SRxmf+siPskS8SXKqLil36FrSUgvOhmo0E7W8crfNY4kGi2oZR4Vdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL5ewztc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b786421e36so2798898f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754346876; x=1754951676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOe+oseDiKDWnydBzNUnhpGVuR6PDQg1TJ9zx0VvakQ=;
        b=FL5ewztcSYYHGVQ8mSXMfw8ZRkW2N8h+IJugT9eSyDTJqxrcqjIULnxc3MaObLabz5
         bwMEgHdXO708Tp4DZcolZ9XIyMoz7Izl+Pp8arLHiYvNKeEAzStAJupag4wx7qopqWNM
         upIHx1Derq6Wotx5Zc4su7HRhCZTwjztrD/0HENrk/6GAyBeUU3oXzZV0UbWddUsEu3i
         eVLjcAP6fXZmz2/L6h3y+FMGJ14h2SM7P+9nBYNynMIS5G4nERlypbC4Bubs1tXMvapG
         Y57JtdzFkDZSg0Zet1wZDDleU77/+k+qDChTujeF+bQWwcSqO3r/x6+Rt/5AlpUE/T60
         i72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754346876; x=1754951676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOe+oseDiKDWnydBzNUnhpGVuR6PDQg1TJ9zx0VvakQ=;
        b=NnBYY8TyytNmqivq1tnna4bhJmEzY8Ud7jwShAQtSoKnv4LiO8H8urhcdRx//uu6ec
         ewY4RohwsLLyg8jy1HDNWpB6y2dH3fQ1BcoYZVdrqyClTUm4343LKpTSvqGjL87CnOOv
         yFQDdE0pKejcuPXV+gMNQsJJOH+rfq/elDampOKNbUW6zFuW2pJA6QJtPRGbsvN+fb2y
         lAQRK4WeNBvGYalQihmOnnJ57FElGoU4yZuzQIkGxXSheMnN6dKuTZMisSiNjVx6O/Sd
         ftHH1n1aJVKzazd8eld5jUba0c2D48CeRJixFnGX+sLMyjudRvoQPNeQenIHlZ5j6Clb
         0Q0w==
X-Gm-Message-State: AOJu0Ywc1v7+5yB0CDoaMakTmhqMZy7qz48/N7x1o65PnfGAQhYu/Xww
	tIGD0+nr6K7P067az7+bs4ylO5qnza4zNKR1IGKDPh3RQ2gAYoZF/DcA
X-Gm-Gg: ASbGncs4/xlAFLr4JI7aeGm2akWyo1A8Ox6eOw8boVu6oMI3k988y6sYCen9QB9keQV
	O/Cd2cCwb7PHoj3evPtF2Oro4oqvfuCUY6gFQZ/YaH/CASHwUwbboA5tBkQQBcI7aw7JlrqMjc2
	BXsYJCXNPDIoR0APXWp09ryQ6bWqSQgG9aMquUMEG9FZWlAgg8fbISK+jetzgMi1lVeO7VMhNWo
	dRgq5woEG1/ezTgAZgOP+H6Qtiw7zk5p4fmUQ/19l0q6ewCz/EnkTVlrVaUbdV6Z6sbbA9MJXIn
	kVykjyDLSq9TVLpaB/z+1+1fGHjwH59mcTSMx1ncLFFa8bfZm9LLDwC0eUNaWxbiP0Hc8voa8ba
	YNfEo6Tpq58K1nOoT4GuvijRThLj8pzgcIw==
X-Google-Smtp-Source: AGHT+IGd8DDZ8BWAVJh7j/vBDdXoFmEdTXbAwA3/m84GUdaa2S9/2l9tNyJgnm6A6l0F+/T0kNg2nA==
X-Received: by 2002:a05:6000:2204:b0:3b7:8b5e:831d with SMTP id ffacd0b85a97d-3b8d9472d25mr8064796f8f.17.1754346875994;
        Mon, 04 Aug 2025 15:34:35 -0700 (PDT)
Received: from debian.local ([90.252.123.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abed3sm16807486f8f.10.2025.08.04.15.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 15:34:34 -0700 (PDT)
Date: Mon, 4 Aug 2025 23:34:32 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, surenb@google.com, bsegall@google.com,
	dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
	mgorman@suse.de, peterz@infradead.org, rostedt@goodmis.org,
	vschneid@redhat.com, vincent.guittot@linaro.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] intermittent psi_avgs_work soft lockup
Message-ID: <aJE1eGwVkQdfDeOF@debian.local>
References: <aI_fUhpBrIBrJ073@debian.local>
 <20250804133240.GA1303466@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804133240.GA1303466@cmpxchg.org>

On Mon, Aug 04, 2025 at 09:32:40AM -0400, Johannes Weiner wrote:
> Hi Chris,
> 
> On Sun, Aug 03, 2025 at 11:14:42PM +0100, Chris Bainbridge wrote:
> > Hello,
> > 
> > I'm getting intermittent soft lockups with recent kernel builds. This is
> > a new error that I haven't seen before.
> 
> This smells of the seqlock re-init problem in 570c8efd5eb7. Could you
> try to see if the below patch fixes it for you?
> 
> https://lore.kernel.org/lkml/20250716104050.GR1613200@noisy.programming.kicks-ass.net/
> 
> We probably want Cc: stable on this patch now that 6.16 is released.
> 
> Thanks

That's the one. Thank you.

#regzbot introduced: 570c8efd5eb7
#regzbot monitor: https://lore.kernel.org/lkml/0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com/
#regzbot fix: 99b773d720ae

