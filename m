Return-Path: <linux-kernel+bounces-852330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E162BD8B36
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953903A4A22
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBF2FD1A7;
	Tue, 14 Oct 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="d85UoATp"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CB2DC320
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436832; cv=none; b=pr3o+sS3iUzmYJOV7hSc7x9j3tLYVFjGaGGPGubjVV93o5zbk7A8TY5xRGLR2kEWcC2f8UDuvUAx8lArf8BLI+Ng3zMsUtY1Ya2d4LyifQoAcuewoGX3fPq5jIJrhmdoEXdnHS+QqjuzMm87uQwuU2DuiGcClNZC9ZFm6vMBI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436832; c=relaxed/simple;
	bh=Eh5BVoIdj3E+g/qo7JJOEx2ayp6tBh/70JNpJI0OD+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlZwcGuyocYIseArhMaVnTtPMtnoVHtj48FZFMvxNj2okjYDJg9hHqz8vAd9PAF3uLGNtr0BAzDNoCVFryjXarRK7wcVY345pX1ZsC3n0zHwG0X8OImAMiTVrgzhWXKmj4Nb24lB4jQhzpTEpe7uFenvt8Mh+Voazs/VgZBCswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=d85UoATp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-426edfffc66so504827f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760436829; x=1761041629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MszmfM3qK8hojDktVnhjA9AYopNSPQh34JsmCIb7qSc=;
        b=d85UoATp6fQGf77g72ufnB+c5XzyTEdYJpJ14ctGTEu/Sahws0rO3IgWEUJcWak6xM
         euwiPhvxcZ3gOWW3NLlzMZ+FnnpDl9BsItmr5CXTDFwibSpW3awPUFodQZMSoiyXS5LU
         tV9xx9GKK7lOayJSDblSwVye7gWNCEvq2XpYlmaWjQ/hYr+iD2113aTwn5qxygvYjV/S
         XDl4NUTgUkLu/9/BSQCHk/WP2hs6z+s6vcSi0pzL6eW6NiSgZyw+uJg6IeGvyNSlndGA
         WQPX2Ui+es4PLgUPGrIhx8B43nzbNPZEkhts4ipWPU4FnLgrdOUAKBX99Aiy8QGCaKkR
         NP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436829; x=1761041629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MszmfM3qK8hojDktVnhjA9AYopNSPQh34JsmCIb7qSc=;
        b=DORMXvga50Qo+qJ3NdMMgaMOaOIjG2AsBf9UWTrAzdUEOuTxoWmuGQS2Tpo0tPX4El
         eZd4aRR5mqR4VssItRm2YPbYv3Ni5lMxJ7JL4F52tWvB7MHkRaXDU9SYzMHSni+6tIKu
         0K0BMl9ORcy3y3ai7JHNr/JWsw1nkH6/tc1p5AN+potxOIBXsk1wrNklv4OEyoVnZFYT
         hf67K7UXpxyjbA9HNxDjDhVsUlPH6i1bgyetv1kCsE5eA/v2o9iX5lPtNeevO+jbDR0b
         uVjihASiC93wZxM+KSL92WXNnnDK322PKITlaGSw01Gb9fUOdd8JZDcrZLqn1gfOlgSC
         WJCA==
X-Forwarded-Encrypted: i=1; AJvYcCXTy2RDV3akH1JjjkH1jy/xhBaTRBKP4ZN+jdVKU/lLmatYHkTlSh6cA5vZ1zyQDFvUecqB2UAl5MsSwTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsj3ufPyS4r3pG3/exbs434vIQpuFj3Li/89vUGHA4pT1R0HoN
	c9Jm5yUOpnIfL7E1llafK0F8n5Nv4+veIBBI7nCli5YDYqaru4SBbD9hZg0JRZMXRN4=
X-Gm-Gg: ASbGncsGRSnHm6rGn3wQgOksmmAbQjHnsOiYBIYClNAS6eVmXTHYagBUCUx73jQQqnX
	BKdImlu1danvKaBgKc7ppPluVEjNQvs0GxSNVWEwpNlp4APj6yH5n5XJL8jCH1iW/CMvG68nd73
	Vp4zt9z/bgs73mMG07v1D3Ja4w0EgDQLWq4MbLTN+jS2cLWJgEm6NHNWQrrLpri4N2Q7gccKN05
	wIZd6+HTd8+b1tjh533QsW98e3YbWor7dvacm4PRC9UmItDCak5fMh0PopOo1x2tp262yNv7Lig
	CfYLTZgdmnyZJIXsV6G/3NYTDcxXFLbLCupfl0bIwIP7LtTTTvnkPTlk3SXouOzt986sTOlScp1
	nhxFxGv9MTMNBU8vlyxoY6dkmXQ==
X-Google-Smtp-Source: AGHT+IFWdFmuBH45KApzDATfMiXATkGI8VwBnZcXpUsUtaPvnVOQgNZ6Tnlsi5kbUQn142h2b+DYoA==
X-Received: by 2002:a05:6000:4009:b0:425:86d1:bcc7 with SMTP id ffacd0b85a97d-42586d1c0cdmr15589331f8f.23.1760436828649;
        Tue, 14 Oct 2025 03:13:48 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3df:19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm23371423f8f.32.2025.10.14.03.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:13:47 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:13:46 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Jan Kara <jack@suse.cz>
Cc: adilger.kernel@dilger.ca, kernel-team@cloudflare.com,
	libaokun1@huawei.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251014101346.ep73uuigr25xu5a2@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
 <20251009101748.529277-1-matt@readmodwrite.com>
 <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>
 <20251009172153.kx72mao26tc7v2yu@matt-Precision-5490>
 <ok5xj3zppjeg7n6ltuv4gnd5bj5adyd6w5pbvaaaenz7oyb2sz@653qwjse63x7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ok5xj3zppjeg7n6ltuv4gnd5bj5adyd6w5pbvaaaenz7oyb2sz@653qwjse63x7>

On Fri, Oct 10, 2025 at 07:23:54PM +0200, Jan Kara wrote:
> 
> Maybe I misunderstood what you wrote about your profiles but you wrote that
> we were spending about 4% of CPU time in the block allocation code. Even if
> we get that close to 0%, you'd still gain only 4%. Or am I misunderstanding
> something?

Ah, I see. Yeah that's true but that's 4% of CPU cycles that could be
put to better use elsehwere :D

