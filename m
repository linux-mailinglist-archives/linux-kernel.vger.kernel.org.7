Return-Path: <linux-kernel+bounces-774748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4866DB2B6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B8952708C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19E2882AF;
	Tue, 19 Aug 2025 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5O1dPQ/"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2D1DF75D;
	Tue, 19 Aug 2025 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569794; cv=none; b=MKfTLyHiBGoec+zgorQijQNZDZybGGeeZzTVgz7yF7ALcCA/3McwNbY00LfQN4NLCTohIHTyRHae5amAcYB2nmwJ05GMoO5w0w1o/BEIB3ZkeF/srhljhRJ1uI3mejIw8sqr1gTOt1g5Z5zUTHZJB7ZxTZXFR0eJQigyJ9mlREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569794; c=relaxed/simple;
	bh=wEBTBsi/hcUVKMlOzMP69SwlKubLM6KYBiYPCGcj8jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qx/830gRz9yuNPzrBe36jypkUwkEe4GPgPh4mC/29EpK+0kSd5r7/ZiALLJRN584CAqyqFXhqCryfTtieDaIJEV4jYf/XiHW4Bw62woJloAC9CowpziyA7s398XKy8lqaxjpuTp4ORYBbideZaoQlx1N4/kfeBsNlmYzfCnWWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5O1dPQ/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e614b84so4524233b3a.0;
        Mon, 18 Aug 2025 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755569792; x=1756174592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUMjtB1PcmTd4JrJR0QidjQdvsMM/g3PEjSotjCaP7o=;
        b=R5O1dPQ/yARkI7dMscUMUri0tOBsR++LLApv/AUbqmhMZcVUWt6SENy7C6iAd9tXOR
         FoPuAGGWn90xE8ZVtfqKTPBr6vLRx25J/a6utPuqd5ebTN0LKZNbngUcHIptafXozezJ
         gYcjacO24LJdFWfN24K2nKuP+QR+UPXSj6dWiVFPNhSWWnnwRIsQZAfnefXhEMeuTHmh
         MRhfdGM3mdU8DKgb8UsB/mpHbyOypgBkL6UAeSDrRoZk+JL/61U4S58NjCBbSTo+V47T
         xqXQ7OGPQDWHksR4cLYUthdrdz9RXq5/pzWbbLFXpraCsXmR/UOc1Wzfm43r/v3SXe5Q
         U1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755569792; x=1756174592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUMjtB1PcmTd4JrJR0QidjQdvsMM/g3PEjSotjCaP7o=;
        b=GY162n2ODFfSb6HH8oUQn94IaPLGvM9HnFPBLoendYkbBHPfCCBfUJNYaK4nKrMUt4
         Ug2AsEm4iR/fGG+JjXO/71ehZAYxlrQ7yqpDIm1q1TYlNK/oYnm1MJXyNfFtqbfd3tcg
         8SV+R+T71F2mq4V4ypQXxrmi/G8q4eKWWxu0K+Y3BlFTolo/kClM7M8ST31llypBVVjG
         glOrFyfebirTQ8EA8pMz3wTJC7kENcaMgU+pTuM20y2Ioxs14M4BwckNACe4+mP/803a
         zu8mYfTk7f+4Tsdb691/kmrZHEf6j8VZUf47mZLkAvRi8lOJOoOEmvxxWtGWvKbyg61h
         sstA==
X-Forwarded-Encrypted: i=1; AJvYcCUPvgqiMTBTk2H+c9zm7B87X5Jc1nHOu3O5UedLYjSQjxZu6mxvAq4zkWF5Gi2QEsolxvP9LxlTPU3bvhHK@vger.kernel.org, AJvYcCXN44Er6eVOPsHMn43S8H1ePnac1XcZdEmRwsPuMrUOBPDC/pQGb+maNTppDgCkQowWO4YProbWf2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxBdn6UCUYwMDOctcwlaq9O8JUPdP67Iw/elijYv/mS3QgtFr
	nQllV3leThvWbPpUqnmWmWDSQUN2c51gqoIlnxDDXbVLkCONh8QcWvdL
X-Gm-Gg: ASbGncvHtj6W/vlPBVms5mO0CJyvqSZFXLH8d5mAoQvfiNNIoKlNgSJ3cZs26H0Om2R
	0st57KoJiYIbdN28XB/alb2dCU1CUbnaou+sYLmUQLJw4zF/D+LuuhNLYrOxm0Y87+UVs4mC/HD
	BaRz2RJ+aRwU88WnvaveHaLdcjSg6yCZhQeWfQpxUq1Mo2d2L9R0CTUiXn7mnlSz4itR4oCEHMi
	qFEzhu0RHUEU6Oivdj4+h5bXaUyalZJj1ag2i4rsvbE1VsIuOinrBTpCugCTyX1we1AB5hMZeid
	1DS7X4jtA4rTHX9Qhj8Pv+Tv/PJRsAfOY3KrGMtgAGMWIlVecECEo/sB8fANiYM6WhUId/KOxGp
	YIIDTXN4KL3Ke00Bq36CXJXNoI/GD1GB8KYwFZY0ggwKzlwUH2EgoeZBV7H7DYXqOE04g
X-Google-Smtp-Source: AGHT+IH5+G65yCUd7tPSOj6guoM3nLxRZtasmsYtRIjAS46VDy7cxCcuAr2hNK05bhcFDKxiNGhPbQ==
X-Received: by 2002:a05:6a20:7d8a:b0:240:16ef:ec16 with SMTP id adf61e73a8af0-2430d454e1emr1135515637.46.1755569792212;
        Mon, 18 Aug 2025 19:16:32 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5d7070sm9183138a12.15.2025.08.18.19.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 19:16:31 -0700 (PDT)
Message-ID: <142b209d-613a-4659-a0f7-27efa8c6be85@gmail.com>
Date: Tue, 19 Aug 2025 11:16:29 +0900
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
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250819030239.41a2e97f@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

Please calm down.
Apologizes if my wording has annoyed you.

On Tue, 19 Aug 2025 03:02:39 +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 19 Aug 2025 08:26:31 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:

[...]

>> Mauro, I can't review on 5/11 unless you provide me exact steps to reproduce
>> the font discovery issue you said you have observed under debian at 4/11 of
>> this series.  That is, without assuming your other series of build-wrapper.
> 
> See below.
> 
>> The build-wrapper should be upper compatible with the current way of
>> running sub-make, without any change in conf.py.
> 
> The build-wrapper series doesn't make any changes on conf.py:

Of course not, I'm well aware of the fact from the cover letter.

[...]

> 4. It prevents the usage of T1 fontenc fonts, which could be
>    caused by either one of those two reasons:
> 
> 	a) \sphinxhyphen{}
> 	b) index build
> 
> I got those when checking what packages were required on some
> distros (Debian, Ubuntu, Mageia, openMandriva, Gentoo).

I couldn't reproduce it at PATCH 4/11 under a Ubnutu-based container
I've been using, ignoring your sphinx-build-warpper series.

I'd really like to see the issue with my eyes on top current way of
doc building!

That's all I am asking.

I have no particular interest in the way you are testing all those
variety of distros, and have no idea about it.

Please provide steps to reproduce.
I'd like to see a Dockerfile based "FROM ubuntu:latest" as the testing
environment.

I suspect you have encountered some issue due to some missing package/
setting in the container container side.

Or does the issue only appear when you run the script directly?

Of course, there always is a chance I might be missing something
important.

Regards,
Akira


