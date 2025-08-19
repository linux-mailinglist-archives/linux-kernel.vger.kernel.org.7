Return-Path: <linux-kernel+bounces-776691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE10FB2D085
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5993B0F92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E5274B32;
	Tue, 19 Aug 2025 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfojNXYn"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416F2749D7;
	Tue, 19 Aug 2025 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647698; cv=none; b=G6L3Ww1Doa7kSRQGGVw4fSmtQ7S8AlKlro5kkwcGO6aUwWyhiieuFb0Q6I0WMMP2mVs84i90B0nQV9XnIyUhmQUdRohD9thpAQaMtjATdCD9k7CXB80pE5Rq5Ozk1+q+5LhoeQhxfsPWrOpcDsNzn8PHDMmD6g2b4Ke7KFtNp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647698; c=relaxed/simple;
	bh=zmMJu8B6v+FU0zqvsyZUrwKWRDLLAmLxiItXSGlt5Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cljLehpbb7Td8xnD9ZyUvHPiA22RDBeUb4srXy0K7HdmdIvb0Aa68dIK5UvDw2JMRAYTrA7LWoA5ud5biRAqXolALUdFXAVLnsLqZsCJRnTv9Hw41KhkUpesRsxKBlkHpetxJAWapfAYdO8vxVoncpXheDfNu0pXgnTNOduBSpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfojNXYn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32372c05b79so2660210a91.0;
        Tue, 19 Aug 2025 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755647696; x=1756252496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTSfXIhIUm08JwY2Le/9lxhSDqnzBSd8QDKhPsADHWo=;
        b=kfojNXYnVVB53MlxQ+SwDLgziP+vRlVhtyVD5Sg2pLLCdTXx9T7NlKIi34H+PvjnVp
         zro5qfJ+MQeNaDUPxCKKTbdFncEOz4WzbdBM4OHd9WMtG42tz066l+5q/6dK2A88wn5n
         5Glod+3b8O/yEiDgWyPvP4PzaGB+HM6YFh6v+xu8RXrGvBD0p5jwGfMvvLKYZ9ZqcCag
         Jc04J5VvWBRGuu6uTzsEqt4y+qzNWz8XncU/0T66ccbIT2xoopNPvuuRS9eN5iCGMIaH
         8pxiFvVT5gcz9uuzC5oLVrq0Nwh5E63DxMJx7X8eSko9pSP7M34pJlSPamuz2AnobDFS
         r9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755647696; x=1756252496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTSfXIhIUm08JwY2Le/9lxhSDqnzBSd8QDKhPsADHWo=;
        b=EZbFmwh6TTmoHboylTgt5vH+XA6JeuE34WkYVCJC4kjTKcDCzwTeHstHKgQpVF7g3/
         857iZ/BN4VsAq2BXifYT+GRA0zZJzPj34uqYjnfxb5mxF531dQECBGkv2ORGCrjmmKvj
         AzQudA5j3SOl7o3hmqJds6mzlMhqOQSWZB8HhJq1+mdGbztl+qnZu4dTeaoG9eDa+R6R
         4/kZwimUcO9ErybmMA509GDrsG2LVRp3mkuEZtCtnwJjyR1xsGGPLOh5ojKGS0p5hoce
         J4ulm2QFfpud1Ff596j+ydwUT3cHKoLjqjAScnPSGlVZ2ej9BY2bJPTgZZjDoWKJh/mH
         Zckw==
X-Forwarded-Encrypted: i=1; AJvYcCUX9Mslz/nhlD54BS8KVGoqaNEyfsZC1yRrS/GGaA7gdInYw72FFrOVHLHaTHmxcGdqfH3zVgO9SDk=@vger.kernel.org, AJvYcCVQVzcoxZwkogdkR1/sMtmrbPpVBHFH8TNf1xJTqGCRf0HoqVYcCSe1P47btdghpfwGqHFJYUFWaaShVnEO@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIP57ghPSm2EW8rJS7uuD/RVRs91BRviVo+Ksn9Bqb6Y6YVCh
	wyQxslaLAFMYOzpqm+zcZIJ2BtkuXnwQN/ds6geps1uqPaI6OVNFjhsAsS38rA==
X-Gm-Gg: ASbGncusCPFJNuDOFxSx5ycCjZahxA6m9y+lVKnWyQtoEtNAIz6Ia/6KqA+BHuBF4ET
	iscdWkMA9T2xFChf3CkGrQiWyAWSpGNEZz+/QRyl13TBOsBewWQyMz19D5iMhj2+i72ykylASbQ
	K3WbHAbACyJQjzINKK4AJi0qMy8slAwO0IBX7Smk9tRRtT6/VdnolHfo1totLrPh6H9Q3fvF3i8
	6l7dU1PrVnGsQcoBb36FkCRdQUG+dUbd6Zu1XehiyAto0NPwOtAML/iI3uCHknnB1Z/KjQEqGTW
	xeb0449vzbuiLQM9psRADmMdpSvq9YFuIjFdbhBxg9kT5RBkJ+8S9nQT2gK5xxTSkEm+Bt+5FPD
	xxvobbw7KGvUcPHquby191lMLEdumMBSi+Oq+/9d/hW/bvq4keKnbpw0XjcueK0Phydee
X-Google-Smtp-Source: AGHT+IHSkj5n8OTH+6vGWlbZswrsdfJS7fACZOIWAuOc1IEi9Sdm/4wAH6bGyX2lGQjAG2x0PsNaMA==
X-Received: by 2002:a17:903:2352:b0:240:8ec:fe2 with SMTP id d9443c01a7336-245ef0fe508mr9908765ad.4.1755647695765;
        Tue, 19 Aug 2025 16:54:55 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed379dcfsm8643135ad.68.2025.08.19.16.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 16:54:55 -0700 (PDT)
Message-ID: <08c3a7eb-0425-4709-a3ea-6d1d726fd3c8@gmail.com>
Date: Wed, 20 Aug 2025 08:54:52 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
 <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
 <20250817133606.79d968ed@sal.lan>
 <b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
 <20250817154544.78d61029@foz.lan>
 <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
 <87y0rg7e35.fsf@trenco.lwn.net>
 <16b48826-6634-4ec9-86a0-7ddb59ce3bed@gmail.com>
 <20250819030239.41a2e97f@foz.lan>
 <142b209d-613a-4659-a0f7-27efa8c6be85@gmail.com>
 <20250819153200.3c2b2ff6@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250819153200.3c2b2ff6@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 15:32:00 +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 19 Aug 2025 11:16:29 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:

[...]

>> That's all I am asking.
>>
>> I have no particular interest in the way you are testing all those
>> variety of distros, and have no idea about it.
>>
>> Please provide steps to reproduce.
>> I'd like to see a Dockerfile based "FROM ubuntu:latest" as the testing
>> environment.
> 
> Heh, that's why you can't reproduce... you're using a Docker container
> and a different Ubuntu version than I.
> 
> What I did here was to use a lxc container with 25.04, and used
> a script to pick the exact recommendations given by sphinx-pre-install.
> 
> The container was created with:
>

[...]

> once you get what's needed for make htmldocs work, installing
> only the dependencies recommended by sphinx-pre-install, you can
> start trying to reproduce the build issues for pdf.

I've just built a container "FROM ubuntu:plucky", which has inkscape
instead of imagemagick + rsvg-convert.
I don't see any font issue at 4/11 of this series under the container
(I'm using podman).

Furthermore, after I applied both of your series and the change for
parallel runs of xelatex/latexmk and reverting the 5/11, I don't see
any issue.

Which strongly suggests 5/11 is not fixing any realistic issues.

FWIW, Dockerfile I'm using for building the container is derived from the
one I've been taking care of since 2021 as a LaTeX advisor to perfbook.

If you are interested, here is its repo of Paul:

    git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git

You might be interested in seeing docker/Dockerfile.

I think there is something you are missing in the boot strapping phases
of building your container.

Just my wild guess.

Thanks,
Akira


