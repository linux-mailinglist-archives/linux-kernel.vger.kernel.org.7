Return-Path: <linux-kernel+bounces-889478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4442C3DBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBF7188CF71
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C8C2BE7A6;
	Thu,  6 Nov 2025 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffoNfZt+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaOHgvWE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5B309F1C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470706; cv=none; b=PcbdiHRWlEgMQjBSSjBZM//yzWoNd0tU7Zj0etfxLTHKFN9GZwLzmt5ssYhepHeepGkwaSzqmtgh6+HYipHoJhTeiFzuoK0dV563CFRBIcHUfrGKGp8MLr/WKEE+stUJJInxJOB1c4d6Fwx0pkRx05WlAXup0yH/xaZtECSLZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470706; c=relaxed/simple;
	bh=jnYyMdabvpIDS8ikxG1OUNDRq/l1mITuGWaWLHaryfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcYvdcuZ1RNoROXft6hAltFKse0It+KqPZRVLXN/JXG7HeMGQ5A3bR1a3n7H5dIA0NrXqtPZO1WWqZhss7UM15j/sin/OcJh36DZGN2sTES5HI4FRZHPmg1iCDyD+hWBcP8RmOU77J+tzLh+/yRZW6sHNyp+TmxbJXFUriBXzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffoNfZt+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KaOHgvWE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762470703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXr28wg8D7Sns2qkEeLZq8j8Ed6Tt4Rhy3ccABxhAR4=;
	b=ffoNfZt+4EwKYQZhUq9CmQ7krU9OWDgy2PcqqjcavAJ+302QZWMBE3OQp41akYkDml5xQN
	t3j3R2sh5X1HxLx4VN/LXhD7SB3EphW4bAd6qdM1rpG4YJAvhcd1ojiAtG0LH5EI6ap5y4
	JxnRcLKT+5R8dCkk6Uzz3dJI5ySmWHw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-hCDiPgzCM1CIfNoei36UTw-1; Thu, 06 Nov 2025 18:11:42 -0500
X-MC-Unique: hCDiPgzCM1CIfNoei36UTw-1
X-Mimecast-MFC-AGG-ID: hCDiPgzCM1CIfNoei36UTw_1762470702
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8908a248048so37200585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762470701; x=1763075501; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXr28wg8D7Sns2qkEeLZq8j8Ed6Tt4Rhy3ccABxhAR4=;
        b=KaOHgvWE1Zj9SbX4hUgrpggXpxlcdnYy7OYNLde0PqOkLCTvT24d9dgdQgZhcIla7e
         XDwv+t0pSz1DTc+TMwVWAiSWAlj60OskvFgHvg+ioyP+AvfWa49WUQ8dGeezpEOEAHt/
         PZzBFMyLPJlXr7/qXE0xHkyG8h63T2uJSbN1ENpbaY4LaHab/atys/6rCm/HKpxZURL9
         /5SQsDXHlO+3BoU3Fon2f9HzPOYcU+5rbeBIQeFdJ5g4XoN2STvWYAO4yl6bInb6Jdsc
         qb6CYgf0I8JLKmUxhq2+w2XR4h82hA3iq3eLzfcCcCR7KEtIWUPN+0GgHRQF66vKBI3l
         z3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470701; x=1763075501;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXr28wg8D7Sns2qkEeLZq8j8Ed6Tt4Rhy3ccABxhAR4=;
        b=lDT31kLbADcUDlFFKm4pjPt+UdxPoznp640CrQ0/D1lRc3tdeI44tYAzNqUcaEIHO7
         FQUAUbauVzPCA663br8A58aCj+W5JDs9gyd5b7kK8uaO8BnJj8PbljrxoT8rOZ7KKuqe
         2bram6b+lJwhcf4lWSysE9nYkyfmQ1M2aYA3gkka0pBllvysJdmfLv6aSZXtGGRk+k3N
         wDq8izMAcpBCeD0dcuPXqD12hqgwBWX9D6htOL566Q/5s6A+qKi2Jn9FyI2T8I9jZtAv
         brMRIGXQeo8GFD+GPCMhaPh20a2wG7TvFbUC79XlLf0pEu/6ZbcIYQqMgv38FFyhb/R3
         x0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXmN9KRG8cmkTPJFYdADZPIsRcjNCBt99Wd7iI2H54BJT5kRpqeqJGh1+Zsbp3VsYdSAbQBNT6Lx9nFuy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfnbXttXLdeerleeDR1JHAc+Oa2enEdDrHm+sjocxHudvXTOYl
	5DgD/CBj5qPuJVVzZJNM+BA9HYvvR13cMcSMZBZfOEOHQ/IhSTQe+8n3Rx0vsvtlYecrSvO+0rL
	AAKDbMEzFjbBCiaX05ELJt66MpDJ2CL1+6TuB9R9KFs4JHiCxuNzne5NEzcgCT0tWn1K0Yo1ufw
	==
X-Gm-Gg: ASbGnctK/WsY6on64WgjX2LAuUbgBJIXRKjcoQFTviFAk+elZpgkwiltAxwvziZ8eq9
	VVjf1Fug4CKlmU+j3a39hOy3tRaeaD08K0w+mtoiqWHe5su/WfaTQK3qwYnburvgb4/TVjtuKNQ
	LB5D8qqeFHwdm+OWbqmjIMWrYB05NHR7GDj6B9roorOrQuZYBOoJiiN8oP+cFcCr4ZGuz69WiwF
	FXtl4ZyPABTYMQNLdF9NnkkZ+8z8NXx1Pd1td6E2eN15sG7ubtYih/FO+1dnF4iUKd/7FTJuofR
	kmEntvfvHdKUaQPKsBjVmcI/2cfYF5tenkZ0IyXVpyTiSQ1ozcTH/A6qkGrdsOpIOwIadvlMFbw
	Ll1qhirEy+XoD5Bmq+duLoZ4P+R9+5xaW7w==
X-Received: by 2002:a05:620a:31a4:b0:8b2:43f7:c07a with SMTP id af79cd13be357-8b2452a2167mr193181185a.22.1762470701620;
        Thu, 06 Nov 2025 15:11:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVetiFRByjjykyfxVb5wuiQuE2TgT+5D6JC3vwCG5rcTtdy2u5B3i2rGtKd9IxnXFml+2NaA==
X-Received: by 2002:a05:620a:31a4:b0:8b2:43f7:c07a with SMTP id af79cd13be357-8b2452a2167mr193177985a.22.1762470701157;
        Thu, 06 Nov 2025 15:11:41 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355e56c0sm281056785a.14.2025.11.06.15.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:11:40 -0800 (PST)
Date: Thu, 6 Nov 2025 18:11:35 -0500
From: Brian Masney <bmasney@redhat.com>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Message-ID: <aQ0rJ3ahOV0gmUVM@redhat.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
 <aMatZAX6eFI1RmDH@redhat.com>
 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
 <aPEZSY6RC-UVclxN@redhat.com>
 <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
 <2025101759-runner-landing-374b@gregkh>
 <2975918e3f3a7de245e93fbee52335acb78bb23a.camel@codeconstruct.com.au>
 <2025101721-twiddling-huskiness-4852@gregkh>
 <13566a08eeaed313ad789abcae1920d9b00483b0.camel@codeconstruct.com.au>
 <d53256b35ee7089607463c66bb4a8c3420faf058.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53256b35ee7089607463c66bb4a8c3420faf058.camel@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Iwona,

On Tue, Oct 21, 2025 at 09:01:23PM +0000, Winiarska, Iwona wrote:
> Sorry for the delay - for some reason this entire thread didn't land in my inbox
> and I just found it now, randomly browsing mailing list :/
> 
> I will sent it as a PR for v6.19.

I'm just checking if this patch should show up in linux-next by now?

Sorry to be a pest. This patch, and one other series in another
subsystem is all that's holding me back from removing a legacy API in
the clk subsystem. I'd really like to get these dependencies merged for
v6.19 so that I can do that cleanup work in v6.20.

Thanks,

Brian


