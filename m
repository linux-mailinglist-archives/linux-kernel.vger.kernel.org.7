Return-Path: <linux-kernel+bounces-898732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E09C55E13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA2594E3165
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC072315D55;
	Thu, 13 Nov 2025 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARVAYC7U"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A6E314D32
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013817; cv=none; b=T81SLM2LrwFC/gQnQ8mLyaTZo2ahfMYERqbgUppt7FC177c0n+jMt8K14M7Jx8fcbyqGc32fzpWFnPu4InX9yP4JIG+gZz8LMZzyIPRFGe5M1oh7x7+AH4if/dEU7L0gj0UnYfcjRIh4URGP/w51qicEshyuBU8aLLyvO+D+Y0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013817; c=relaxed/simple;
	bh=c8vY1wPUxAKj0bxZ0jHfN63QqwK1RY83S2/Hc6TAEJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbsl0cL4ltzOUkouFVTKNwoW06s1sn5tp2/7phCts9xuEFRIk2/W1Q6n76PLaf10ZCuOwnNnLIbK+A9YNk+kkgWz+r/aFsgyx5UxyFlIYfLvEqTbb7DJdmcTqogANVRz4sOxmZRzbmDgf5dXS8lyvcbGSJz14XmkRegvEY5IClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ARVAYC7U; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so540310a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763013812; x=1763618612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvuh5w1/ZAKgFR/QxFiPcrUwFuMeEU+LS4Dm3RyAWa0=;
        b=ARVAYC7UODvJsr1OeXNIEUm/26Fx8RlInsfqLuP6qCVOnhelJnmoZoxweRiYW/zFkV
         tGEURhi8tahpHP5juPFXtiX3jmnWmstp1QLnhrTYKfrrlemHT85hcZtkwtwKmt4J4Os4
         flMrusE45RjxjShPLaGBz3LLRcSwPXD//cJNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013812; x=1763618612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvuh5w1/ZAKgFR/QxFiPcrUwFuMeEU+LS4Dm3RyAWa0=;
        b=fvoReLctt3AzMyPEIG7DXjUAX9ieYbGSJx02fPIMPJF2FnvJXTQIKG0XGGMdyz9KYG
         PiScAXXd+E0FQKuxT9EwBk9cCJZnthrouqRYfmPpAWKOQ1/4TZIvobUR3urTLg2lD8qT
         UKqeCIQVN7ev8QGvgILN2dMmgn1wNc299lygjThRRKrL30h19Uag0uMLQFR9OfYf8ZeT
         SgaVx3SmB4Xk0tzNgwQ5657Lwx8ZgPtTp0cWoS4lOj9EVHTTEbrQrCDeimNCBtq1vVBZ
         hzNch5mq3tfrTxlJQcSNd4y5TgXkyPwDlZUKERh6F/0QFAreD+sYlPPtAOA25eCgH1rF
         iPkw==
X-Forwarded-Encrypted: i=1; AJvYcCXn+L2QB/9TI0olmI/dcvp10nMS3km5/l00GIRjSP6BYMF88gFiWCh59xoCFQNPjrslcP5UjwKdakFmKzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/v0WdaEe0pKWgfAkCgVTl3dJwnqHElEppLflaRGkCEdMCzwyN
	4uNKr3h7HbXJyjBX0ey4mf6zUkyh6G1PfMQr4Q29Rs9gjv1Fwgurjbbjc67Vb+3yBA==
X-Gm-Gg: ASbGnctJP4p62SFdnMHSttvAeUj/HUTip8S9XV350Vf48TROsLKX3kWJcwlrQuZNgJY
	q6gy8JsF/FdbSrFIOsXQJJA4to3iGqHJ5rcfQw9xZffxKNvfhNP8JlH88L+GELBIeSnMVVEYgTu
	jwU37W05TKc9HBRSPTJes7gcyfSCsEdMFMiLgiDQMLmUJBSroLDmSOcrzJHqP19mNKujkKcWQL6
	S1kww/UXfuT+zszOC3ckepxj7IfBQ3uYzbbLKX4qs2lKQ7KkVNvGyaf7V8lJdsNAyRBSZv8Nep5
	hnO85KpBHCpl0yfJDyMXEDNpJAbEm0GPsKkPeo08AofQtgguiA07DBCqrlC41C87i7hvYeHIU+L
	Y5iYPb1EH3EAAQP/aO//qD/wXuFN45FbaGRbG2ajJHO8oAjlvv2Z3FVvkAotnvMANwUwN7FkY1X
	8vq0Hl
X-Google-Smtp-Source: AGHT+IHJSK58zJfETaE4wa/PjHdjxMZKbnTlC1cgxs6GeEpxRx5OPn8ZRrdiWfc1MRgfi/HYWIglpw==
X-Received: by 2002:a17:90b:58cf:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-343dde6f801mr6239881a91.21.1763013811608;
        Wed, 12 Nov 2025 22:03:31 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed5331e3sm1090918a91.11.2025.11.12.22.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:03:31 -0800 (PST)
Date: Thu, 13 Nov 2025 15:03:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Yuwen Chen <ywen.chen@foxmail.com>, axboe@kernel.dk, 
	akpm@linux-foundation.org, bgeffon@google.com, licayy@outlook.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	liumartin@google.com, richardycc@google.com, senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <kyprvtaorfdq3a6fsddaww4jg6ixv253rfonrdv2snyhq4pkuh@zdei5bgqzd3o>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
 <aRVvTCCZSjPyAF_2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRVvTCCZSjPyAF_2@google.com>

On (25/11/12 21:40), Minchan Kim wrote:
> 
> In my opinion, it's much simpler and strightforward align with current zram
> writeback utility functions.

My preference is [1], which is very close to how current post-processing
is implemented in zram, w/o complexity that dedicated kthread handling
introduces and so on.

[1] https://lore.kernel.org/linux-mm/45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org

