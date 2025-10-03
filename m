Return-Path: <linux-kernel+bounces-841734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 399E0BB8158
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84D0F4EF627
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA123D281;
	Fri,  3 Oct 2025 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M27h8i5f"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7E24CEE8
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522611; cv=none; b=LrbCpFslvExYym4bOTOga+6hF/usJc7ON93s28VmvNy1+zA7DykMcTZSH4IxIMoUUrvDT/IL/lDQ598QFIfaMztmCO9Eo5Ao4wX7Kt77MWs+WoiunVRFaMGwu60YfDJsJir9hu5sRWhVnyXPoOop8oIaAVh+t0mCCyP7RKngZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522611; c=relaxed/simple;
	bh=/IWiE/RhAElpq35FsJrpdQA7r7YbgyvBXs9jvKpEhec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZI99Hdx6wK5cQk3wIimXQze+db0oe8XRzMv2N1YJXXm9XXmgwqWHihn+7EA4oLX1e8GfiI3z9iM66BBGYRFBLLPScrL9FK7aDtd0gZbEwTp0MoWYCr+sQ2tCaX3f0pv3lA2aQwj9K32dCsqkOkagny6CarTXkHq+bwo3dUIhc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M27h8i5f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-273a0aeed57so47121285ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759522609; x=1760127409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnSqhh3nVjPg1ysLaBq/Mv04H2RucMevN3V1v8YC3Ts=;
        b=M27h8i5fk7BkQWSbsDp1twCkzOQrqd6m+xkGzYPXOW/Ogo4aSw2vbMYaXfB60ztBdG
         I3FNWL8sFQsIXsOp/zRziOCPiC65V3cr2deq3eYcSI30IlHkOkDcHekwtfEEAoyVOEel
         1m9tPqszFkBTvaacTBnjR1r/BE1wcfRDl8hIICzyt6BT+sgt6QK+ZvgcY8Cut5HWYWMN
         sVRR9phJH7rIPUYtX8gNI79re2XUs4fdw9WJ1vkN+YM9ta13/FllsTBz9rM/f4fMIm5K
         ZSfme/BnQvjcUCysf8t8xw5uSX6BxriVcC6US27R6H5coi+jSURCxKujUbfFJ3mJOXY3
         kWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759522609; x=1760127409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnSqhh3nVjPg1ysLaBq/Mv04H2RucMevN3V1v8YC3Ts=;
        b=v9efQNSup+yYL/bWETUg9LhtmXSc4nj9ZoLPAtLvSk0vM/A5ySQiy/3SKRUZkoPvyN
         94nn/m4vETZDVlW4wG3SLKdLg/Tl1tN0OhC7DefAlHzu6TDlAZ2hFv7JUmU/VR2vTNf5
         81m+ZOuEpzY3gGauCzCbBvJ7/PmlbeXsak+XtUrwYY2smSElekC/Qcn95uGOs7qVCr23
         pLnmaYMIP537+HScCJsXs2bYg+j5PjC+Xv8mTOuF/99mNaYfK9NhBmf5pOEIrjnCXN88
         g++gOQ4GmGlLEJoaFs5inK4umwBFkMaEkK76NpPCMmD6uEYk/12v3tSGcedUztBkr7AX
         89Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUqZT3jvYks3R0Ht5jvZafAgXjwTFAvdIN/FTMfR0PHzXAMGMPAvERxaFp/t+drqyFnFQX3seDfEjc71WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDEVpw6ypbkwUuHIBidU7yMPPR70F83GGRfyuNzbj5LFlbvAod
	ACdfLZLiGGHBjXyENCZe2yEMhk1UhX16t9b5LTZq40F+8u0y6TFDpsYW
X-Gm-Gg: ASbGncv1UXm1vExOOblNfaJ89aQXx0Z8t15v3O4ARloQNiupUzfgzulkBAHWFNMAofr
	lH0PsWRikann6nqpuiy/Ts2gGiK2xy6P+iL/aLhjbmIT8A7cyz/99mWhxcTyDWX7K/uSf98eAyJ
	M3b09cS6lCaPEg0txXvRT/ajq60lHULWZHIJ3yk5ED6joi0Aq9Hgkvm4A5M7wqcpdSNCBLHtaC/
	E+7brKB8NHtN2JyqIwxzA0WW+3vb+Fpvf4X6xzELr2efOEUz8GR9SvVTa1DVf7BLXXHlCmmVIRS
	35m9xnXlz+SQY5RJhYhOWYRSsKf3OeoFI31PV50CuXBZ7uVDMcXI9nVjpGwGwt/4SZZJ/s1p/h+
	CFu7UOKkAkj4BcC157/Vvyvn4Ca/qjFC9Bk0TwppL3LRxWTz8DUCMHuvCubBJ0dHpKc32GA==
X-Google-Smtp-Source: AGHT+IFBDEunU77jVS2ValYwP9blJBMiAhw9k9jACRnAmsoi2kiPkVHtYHF+8t3GUbOdavDjlSNtLA==
X-Received: by 2002:a17:903:3c24:b0:24b:1585:6350 with SMTP id d9443c01a7336-28e99cc3b7bmr49861095ad.11.1759522608749;
        Fri, 03 Oct 2025 13:16:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d125e9fsm58541455ad.36.2025.10.03.13.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 13:16:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 3 Oct 2025 13:16:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (asus-ec-sensors) add ROG STRIX X870E-H
 GAMING WIFI7
Message-ID: <1feb709d-9c25-4c4d-8209-f84f5cb8641b@roeck-us.net>
References: <20251003081002.1013313-1-eugene.shalygin@gmail.com>
 <20251003081002.1013313-3-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003081002.1013313-3-eugene.shalygin@gmail.com>

On Fri, Oct 03, 2025 at 10:07:57AM +0200, Eugene Shalygin wrote:
> From: Maximilian Luz <luzmaximilian@gmail.com>
> 
> The board has a similar sensor configuration as the ROG STRIX X870E-E
> GAMING WIFI, with an additional temperature sensor header.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Guenter

