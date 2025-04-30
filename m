Return-Path: <linux-kernel+bounces-626274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0C8AA40DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 04:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546CC3B689F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88136136672;
	Wed, 30 Apr 2025 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VfNFRkKn"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E944C7C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 02:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745979448; cv=none; b=gVZf7PxaQdLKfntY1OSUjeQRGh0oojRKQF17hUB8TNaBPd30TW+wMynahUtICt4JD+PHErA/iLKR/fhSfowhaOCHsaib0v2fPCSI97bvvMXmpXQIWyt3AaN6ZeICIpJzrailg8zvvBXLbfB7ookI1GUtu+6i7A7KYBk7KXiJ6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745979448; c=relaxed/simple;
	bh=NyjvJLCsBhlNw2Ibrf52ASwz7KJTi9jxZNZI9YNILhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI7VBZFyBsJ8132cjtl2QSkvtENOSc9PYeMoBF2oilT84eOOqFL7z2+Yph/MxMxlNsd3/DrnLsvBW9M3/nQmnx+WFESpqgNSgUnFgyvjbXY67n82aIoFbXUmIxh9kujboh+gCKwJ7Zk+cPXOUd97g5xhp2cg0pzWchtBqOEml8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VfNFRkKn; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c9677cd6d7so458195185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 19:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745979445; x=1746584245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzc4zJvvvT+R0NRZat82797TVJNRgtoEukK0z7pxQnI=;
        b=VfNFRkKnTsXPY92rUR0oQsDWlpq0BLXr1swyI6/PNKAOcFtM7c5fRs3u/T2b97oEp3
         hpKgKtuU0/IHYUYq8LrJgEBxWtdBcDiN0TG6keowLwK4pXJa8JVNwfXoSqc+F1Lreae2
         Lphm5gl87pn0r4LLUPaHFc1+e9P3H20iu5a22ncDqBn6i8PFMU8v4/ii3DiwSg7e6o7m
         XXzsnf6DUCgo1zCUPIliMomSfto1kUXaEQdAOWfiGSBRFnZZ3M18sS/cs205x89xmOgE
         ZSkMl5ol+c7nbQipfiJpqDDB9U94RqhsgngEi/Vw3vvoX4r6uCR2SYBFPfJeXpgl6Vuf
         U15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745979445; x=1746584245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzc4zJvvvT+R0NRZat82797TVJNRgtoEukK0z7pxQnI=;
        b=PJEKeqgjwHqrugt7+LNbuw3j5YXrnO9Z+4o/MkWStWt0olaKM+bSugoD6Jw3ooOBqG
         IGiL15xoND7x8KtW087UbguTR4hAeTKSsyL2pofjDO/lFbuZE/cEwb+OZbOfG1YBeCoV
         2SiD3ado72TdOewRtB+gY08E4WAyMCZrHAYDyWQkubhlh5zOwvTqh4J5jW0H4hm032nl
         2dfcNBzFZGzknaEvYlMVJXqccw1YfkfL7HeubiRPVMHEWN49l4Lja05rZtn4bzPq9tVd
         3Bsx+dR0pDppgLlWAMjE3cV7RP4qrfbMU+BKclnIMbCk4239AEuu/ay2g2NFCeDNvWXI
         XLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRQn49rvibctaVACY5aAp1GXt70dpE9YS14eFz9ML4azvLipBnXi6fhPc+Fm+sTCn+rBNNUmPiYC2lQwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62mzLMj7YFY+x2J2K2ax7883FdiDEIHjHZMReWDkHQWhgDulj
	taGfDdOcDjmWLn4304jFYrY2gMlZTFEovOnS51aZXfpB1xS59gdGFs+jdRyYUUE=
X-Gm-Gg: ASbGncsMrQ4MRefdnwg2MEBAHM3FfJcIz8O79p3Aba+U0vXmBCbqvTqWUIxg8tsBeC3
	bDTNnpSWLnl7IuJ6iYhfUxA92NM0ip8F0v4sDM90JgR17w2tyjA2rzp3pgBdZxQSPlkPnvsFThf
	sS+tgzVS+sO/yO6/aqRyLQsYw9hWZOPMC6U3yR5Kyb6kjkAbiELZ8t3leYIdZ1CZcejjUCS8vL/
	zxesNNu7reynQnr1IOcOX4ziSw6+p8UIdYOG9Gdh7PNrNiL96t6CW+79WiTUN2iSLJAQQ0eTdw+
	bxfclVBtOhjaRfa1kP3Fd9r8kUKLmbAeuFxo3EPSeyG2YTOU7/Cm//yIbAuH2hb1Ah8+kIUQwr3
	tYShWlsVftdGL6/qIcaY1tok=
X-Google-Smtp-Source: AGHT+IGeM9v+TJsH9D//e4xqgx1SgQZRFhPsRlriTHS9B28keLWtIOl820J8G6QPyqu2hnxlzoIMiQ==
X-Received: by 2002:a05:620a:2722:b0:7c7:a555:8788 with SMTP id af79cd13be357-7cac7405559mr213547985a.2.1745979444919;
        Tue, 29 Apr 2025 19:17:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86bc3sm799917785a.67.2025.04.29.19.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 19:17:24 -0700 (PDT)
Date: Tue, 29 Apr 2025 22:17:22 -0400
From: Gregory Price <gourry@gourry.net>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cxl: Allow reprogramming misconfigured hdm decoders
Message-ID: <aBGIMglj8r5MNAmN@gourry-fedora-PF4VCD3F>
References: <20250430012915.295136-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430012915.295136-1-lizhijian@fujitsu.com>

On Wed, Apr 30, 2025 at 09:29:15AM +0800, Li Zhijian wrote:
> During kernel booting, CXL drivers will attempt to construct the CXL region
> according to the pre-programed(firmware provisioning) HDM decoders.
> 
> This construction process will fail for some reasons, in this case, the
> userspace cli like ndctl/cxl cannot destroy nor create regions upon the
> existing decoders.
> 
> Introuce a new flag CXL_DECODER_F_NEED_RESET tell the driver to reset
> the decoder during `cxl destroy-region regionN`, so that region can be
> create again after that.
> 

My best understanding of why this is disallowed is that firmware/bios
programmed decoders need to be locked because there is an assumption
that the platform programmed it that way *for a reason* - and that
changing the programming would break it (cause MCEs for other reasons,
etc).

So the appropriate solution here is for the platform vendor to fix their
firmware.

But I am not a platform people - so I will defer to them on whether my
understanding is correct.

~Gregory


