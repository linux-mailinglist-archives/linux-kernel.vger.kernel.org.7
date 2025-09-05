Return-Path: <linux-kernel+bounces-803894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB709B466DB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7797BA064BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29441FF7C8;
	Fri,  5 Sep 2025 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHb1V8bG"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569D25A2C9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112493; cv=none; b=dGjJPfsiXrgoGXC8g1xn8nzoTRmCy9U4rtM7BcqBm/NWsiKdDXvaDc9qXIpo2QTKa8kAcE0gX7IWVtn5E+EMGP1zoVvuCokEmiNEJs+no3OQe95RmNBokhBEAQdA+ycRY9zYBqxhP/BE05U3c8Tjtb8NWVJUYnRs8iiOUTAzCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112493; c=relaxed/simple;
	bh=/NeEPoYmo/i+0mCtYCXzvr6NHSeL+V/e7VCNvcbNorE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enkUYCaGC843KiDogJOFh4AfIAMe34gG+JpKN9NOgPd2T92DrnfnzK3IcAzYiY4NvX/fhwIalD/0tgNqRmr+V0lphnjL/GmJB61g5GfgWB7AFPFpBUlOqNUhlQjOpEWxZ7r0f8rxOkxGG+U1vqE9vnokrGSySGsNMBdX8UIlRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHb1V8bG; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3f665747b4fso14701925ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757112491; x=1757717291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WdnLhIU8eeSscRHjrKmNdJs/lkEli5/RHH0KzOqfe0=;
        b=VHb1V8bGMo2farAf3P13aEdYcPOc9g4nG2kFTMekl6BmMkfVGbkO/qXDKTiZXzGB5Z
         Gf4CjNCy4PWr/5HOyuyg9oW1vprp2xk6amwn+EmdpJ2oxHlKj+gvAhAy3tx9QZO8NAPo
         yyRFExnei29FbdpQQW20mK9j09oLBRmddh7x9R2C/DDoY2Mzv/rHJHLkGMpoiXxVEpUw
         xC+0vJ0fwO6jzthbFp9VRkZghgvUm9bSnQV59GSfZqMAhH1s7g5MYr32rtxPrBpQAzFl
         clfrPuYYLGbNFkwZTwB6ncBNdWRTflwEBvBFNa+UtXgtSkMW+YpQmplhkRJgutJm560Q
         wbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757112491; x=1757717291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WdnLhIU8eeSscRHjrKmNdJs/lkEli5/RHH0KzOqfe0=;
        b=tLNjcxmP33jYkU7cSDLaRbG7tXj1o9cSReCmeLtGMw9hWinjyBCfPnCAjwT5XyGoxG
         Bvy7lu4ISC+rsTZJQ4szcSUeXZd57xOjpxQXwQmXZfcskN1a0AyBuPTkOwSeyzagpgos
         0+ft9CEU0TuliYeoxH5aEFD3tavArRKVHC8EMDJDhYStbS8r0rpMmEMuP3QBum96rLPH
         SgTrboIRLEQReEKxEOpqNp7Smk3R17T7uBZDMyHD/jZiruZKhXfnTznEGDkRGBMkeqg6
         NYpUudRVuA3dC+3eJa03Nmwhfc7CWWHQVAvai/UPJftUz+6GVYAq54LrYmp6al2RGyFn
         bfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQwRk5+u9FvQlJoXY0KSxUsYDYynJcd4Mv0TGzddi2jQgpfF+kE/6NQo16bYMkwLigENeW8yVPBoxuP6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YybBg2XJH47eej+2hWh29UGQU0JQ1DaXv+IwHNiMT/7d2PnA3Gh
	TZcR087euAC3ApiOuERj/ZQoMWA895RhX+RaGGvPZ6V4M12jhLROmyV+FHdNNGp10GBuyRafDRy
	/TEGF7Ps9
X-Gm-Gg: ASbGncvLBV+Cypg6DuDX5st/b5HN4qljZq6y7v7C1BT4FU60QTExV2CHhXyaL+Dr7/a
	3nJ5tA/kTaSQf+dZkBtWk+Ozyb/bwyb8BfbL8YVxTkoeNso0w0yl0Znj8llu/d4dTGIiDNxyLVq
	/2y9QQlyVhs5PubLpxZtiIr3ZKqDf3o7xMiyG3bv5LDTI9MA7cq1kyrAaF6qKddvYPefgvHkDjT
	nxLyH/T5doZtnAhzAdBVkpQe3wGV6pjegde3PfBjQIgy+cVjhwciQdZNiPC9nrWhNX/FzrqF67K
	unwz8atqTHjTFMDn/0bcXrlrCM+oAhRcxZ/BIj2xjZ0qaLArLUGb/hYiiptDj4Eob3tUi4faBaX
	yAaXvAPqgqinAVqgApNaR6Af9IizXtI+gvG33l/NzRR5bseVPyeqHd2ejktZk2jbdXg==
X-Google-Smtp-Source: AGHT+IGteJPTUg7Q4dY55bVPcXcRiRPHeCcc/yp3td6K98DG8HYiAWfdNzDYCCb8HPGJ8iqvMzuTDQ==
X-Received: by 2002:a05:6e02:1a41:b0:3f6:5688:a088 with SMTP id e9e14a558f8ab-3fd7fc2166fmr11006485ab.10.1757112490698;
        Fri, 05 Sep 2025 15:48:10 -0700 (PDT)
Received: from google.com (189.227.72.34.bc.googleusercontent.com. [34.72.227.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5104e42de56sm1991680173.32.2025.09.05.15.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:48:10 -0700 (PDT)
Date: Fri, 5 Sep 2025 22:48:08 +0000
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selinux: enable per-file labeling for functionfs
Message-ID: <aLtoqKL8plKOF0Ed@google.com>
References: <20250828170317.2322582-1-nkapron@google.com>
 <e2c4c055ff356b4fe5d49bc9df3fd2ab@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c4c055ff356b4fe5d49bc9df3fd2ab@paul-moore.com>

On Thu, Sep 04, 2025 at 04:15:52PM -0400, Paul Moore wrote:
> 
> Merged into selinux/dev, thanks!
>

My appologies, I introduced a logic bug between v1 and v2, and have sent
a patch which fixes it [1].

Thanks,
Neill

[1] https://lore.kernel.org/selinux/20250905222656.3692837-1-nkapron@google.com/

