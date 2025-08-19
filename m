Return-Path: <linux-kernel+bounces-775214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA98B2BCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E10516B98C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81E5319878;
	Tue, 19 Aug 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk92PaYl"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71C38B;
	Tue, 19 Aug 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594565; cv=none; b=eE1+wtJzCS7rY/gl2Bq4KSj7VzUhV8LnOyz64PG8l+g2Kw/Pq2v4/fR9SK8VFA+R2uPb1u5GpSYbVefaaRyjWJNnJNJFvOZLCZlQ6gqCh2YkNR4M1Q9iWP4FKjX/oGIJmzg4MX45GrT47DAZy2AUFknSeWQGFwqcvWsQ+hXxHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594565; c=relaxed/simple;
	bh=f/L4xjvWw3y93yLNsybSCqBehXX2kkqDpsD/wGF6kjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRp//G+w8sDbfyDHrzkPWK3LM3WZmG4FX/S2rbX51cWGillARuiU97DeNmdG778gonWdn60Gb/0vzeXtoU0yzURvFM4qQkO1QRLb5Mimrt3pW1moutdVvS54I9VcCVm67YnNNE9xqhujHSWrPxQ3oMdfOnUmZerRB3Jv6ZFBGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk92PaYl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323266cb393so4678799a91.0;
        Tue, 19 Aug 2025 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755594563; x=1756199363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pqwiHlNFTNNZmZBdSJVjG8nSL5ZiU/GxNS1GLAUceqE=;
        b=fk92PaYlTzpYEiOiXhk20Hs9/k9HIUM+nFb15McZKrAieRTo9UOkkWCkjE06MZpR3t
         yM4MGNTwqTqkG3JwD5d8GE/vkrW5XiA7WXeaSrzEwekSj0pteWE0HO6aAYCiJ4RDHrO4
         OAY7ids+F1CXTJRRNMGQh5NhjYMtiM+MOsOiGPJHnu+WBCEzZ393KWROvPaUsbwXzgpm
         mZE1cRGWjgBSrTPeDPcAaM88XErdlXTsrc0YDGL89UhlG1mJ80NWmIXUVXquUWXKzYqg
         xjf4ocPNW5qCRP6ZVTE1df4V7m0XkVgy3SX4glILpcp543PzfiSrMWMgY/H+kuiDHfsx
         kjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755594563; x=1756199363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqwiHlNFTNNZmZBdSJVjG8nSL5ZiU/GxNS1GLAUceqE=;
        b=pOVSQN1QZpLVqKKoSwpmZqBFgloPr8o1/zufR7ELX6+/CsUM9fx4PEXGaG+lbJuYqG
         ORAdTjnO93jq6bjqnWPxZ3tzrSDjEXkJTyNubk/BLw6KAHsWy4Tl840WVm+JH/tOn89u
         nSBdJwPjmgHw3/H5ppTQlNSbqr8ucf6bISZy/vi55AnMoupPZq6z4g+bytvEwMnxc95+
         ANq5OxnS9kxxkrYjBXLHP/Va6nH9bo6Uq/dXGTLT6rk1CHx1zaccCvfobw7uo3EBbm6v
         SqsQCIH+vretR8Z1mNQR0Y9OKWM6PsdN19KlXAdGnB3HgRxBudQxMztzNtmsSvutDfQz
         G62g==
X-Forwarded-Encrypted: i=1; AJvYcCW3E3l9VRdgRaC6Y9l9kXxUgDTuXFL73HhONG/hwic01AJjfad3WHo94xS+Ho+Pd6WFhssirZMgHyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydd92VGoeSIPeR5T7cxYQR277s0L6dAs9tthYtUYA2/92SVpI+
	pokfgzMxCFETxL9nC/ntdT888Zj+1ZYGUxDIoofPHMxSrxy3qB+4/RZY
X-Gm-Gg: ASbGncuZdRh+bp88vyDrkOTGmN+0hb0RDKVeB3HdZbVx/swhg+QH83c4uv9InMdE7ic
	CYbcrNQ2cXn3ftj6h0N8/ef4K9O5+xSPTNtckWZ/UME+hOXsLJRqZPp8vjCeMTkIowKMC4vbxO6
	SMcCU1p06sHUN5EO/JTCH85DMso1kjroTlctf9Zr+TUAIjE5ll13VEj8s8iED/BPaGdA9Nk4eF7
	N00Uy46jPXSarxodubRkQ4HdqkAxvJuqssV1jLWZnD5Iq8pzmyIWsQV60MkLRVB2grrU7gkL6rW
	9OxyyVqIlDRLzr/HzKdr68oyPQrNVUvQaBWZ6jrLjWeK8TO+5o7zU3KRj+2uN13BWnmqmgW6DV0
	uSMCppfVsaA0dgUZd7rAixVLa4U8Yu81Inwhv10zwHQJk9cFE8K49pFD5ahCCQlpvpk8f
X-Google-Smtp-Source: AGHT+IHV7VOI6KP4TwHbQ5qJlhVTQqUCySd4urt+mrDdTZldlbSMNXKQ/Uc+YZrphtil3vdvQARkqg==
X-Received: by 2002:a17:90b:5447:b0:321:1a89:f692 with SMTP id 98e67ed59e1d1-3245e562fa5mr2872427a91.8.1755594562856;
        Tue, 19 Aug 2025 02:09:22 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3244230b33csm785004a91.2.2025.08.19.02.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 02:09:22 -0700 (PDT)
Message-ID: <19f031e5-0060-4957-8cc8-9cd21e7d6304@gmail.com>
Date: Tue, 19 Aug 2025 18:09:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scripts/sphinx-build-wrapper: allow building PDF
 files in parallel
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755540431.git.mchehab+huawei@kernel.org>
 <26e5efca73dbd2f863a51018054a749c9e5f5a19.1755540431.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <26e5efca73dbd2f863a51018054a749c9e5f5a19.1755540431.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 20:10:01 +0200, Mauro Carvalho Chehab wrote:
> Use POSIX jobserver when available or -j<number> to run PDF
> builds in parallel, restoring pdf build performance. Yet,
> running it when debugging troubles is a bad idea, so, when
> calling directly via command line, except if "-j" is splicitly
> requested, it will serialize the build.
> 
> With such change, a PDF doc builds now takes around 5 minutes
> on a Ryzen 9 machine with 32 cpu threads:
> 
> 	# Explicitly paralelize both Sphinx and LaTeX pdf builds
> 	$ make cleandocs; time scripts/sphinx-build-wrapper pdfdocs -j 33
> 
> 	real	5m17.901s
> 	user	15m1.499s
> 	sys	2m31.482s
> 
> 	# Use POSIX jobserver to paralelize both sphinx-build and LaTeX
> 	$ make cleandocs; time make pdfdocs
> 
> 	real	5m22.369s
> 	user	15m9.076s
> 	sys	2m31.419s
> 
> 	# Serializes PDF build, while keeping Sphinx parallelized.
> 	# it is equivalent of passing -jauto via command line
> 	$ make cleandocs; time scripts/sphinx-build-wrapper pdfdocs
> 
> 	real	11m20.901s
> 	user	13m2.910s
> 	sys	1m44.553s
> 

Sounds promising to me!

I couldn't test this because I couldn't apply your sphinx-build-wrapper
series on top of docs-next.  :-/
Which commit does it based on?

Thanks,
Akira

> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Closes: https://lore.kernel.org/linux-doc/9b3b0430-066f-486e-89cc-00e6f1f3b096@gmail.com/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/sphinx-build-wrapper | 141 ++++++++++++++++++++++++++---------
>  1 file changed, 106 insertions(+), 35 deletions(-)


