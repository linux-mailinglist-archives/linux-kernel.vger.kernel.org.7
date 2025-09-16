Return-Path: <linux-kernel+bounces-817956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FD0B589A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB423ACA41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F797E0E4;
	Tue, 16 Sep 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH7nllJm"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5422BB13
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982851; cv=none; b=mS1BtCWc+D+c5D1F10XofSqMPqhrvZ1ku+FIEWNcJPBSVrtrr38HdDjaH0L/2F/KmnwjGNrAlX5/nz5WL7efHeW62NuOmMHumqMZZeKiHPYAnOl4L92Qut9oPYVYK2GkvErKreOFoTCAi1YVK7NfPPaT0zsrcq7QY9ToPavOpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982851; c=relaxed/simple;
	bh=sDVawro9p00LTqe7c+Lp+ZD+SMWiULzE0k3J0VNEc4A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Yk7aAhp0dBXI80j9w0Xr3/yvmUAMyfVhUGbfIOl418idFBIOwzfWmoZwBnLxXBph+K3d5bq6xBky30zooBLuDvuUm3jiTAXzVLpGME1vEt89jfdkpEDS2erOya+zaUsF0EEm1QKLE+NonMnINK+YcENTul8x3vO8ZpbWeWAE004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH7nllJm; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c6b9fcso37809721cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757982849; x=1758587649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+5NwP28sr5fb/80uCv4rqvtNt3VujNBkpwom97yF1s=;
        b=WH7nllJmDRoTgb1dm6wFyOSlK7tUhAQUZBaBQZrE+CYerv9Zn6lxDYcYY0bv4Rigm6
         HZevqp9HqkXtlEMZtqW4DBGvAMhQR04FCcAaqduc0fz/gVcm0Od+z65rKtKOqqyHKa8A
         Yh5oeR8Gh9dpsiitppoSPszpSyRli4hbkmU64UCH13xn5N2imiw5p/uzBRLSh5QCFgyj
         qwcdbMs4hJ49IQw9nYP/v3dFY8LBIhJNORpVz8YAU7iEcjkT5wYNarkvfFvhjAqITpoQ
         KTi/NW2CiUKmtFqqULEJ8qRHoymsHakWLwhw6/wuUiFBmHh1OP4jgDl3VwMKMUbJo/Jt
         R7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982849; x=1758587649;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9+5NwP28sr5fb/80uCv4rqvtNt3VujNBkpwom97yF1s=;
        b=eAWFPSrfLKV+QF/1mueDsTbdWGE7Q2yMOYnBLp7Ckq827Fk7c+gwKIk/zEgMqHZNQR
         v04WJsxw5oSUchId2SrHo3C4NZvK8/ZvMELr0de80Ewn6DpVc3+Hp6e0c11FFAKotpQN
         TYhvf3kPK6Lgafs3RVoMv8/QsUjc53/JGuDmDhNlUptndc/If7M4HLOWQKp4nuApJLKC
         lmSllcC9MAqVl8R9FVSyV20OjWhQIm7RQihKF3TS7FHGUjz3TB0gPEjcu1Rz5I3Svy5k
         fCZ7I9g2b/0VMSJNXYYYKWkYSTq152+OTEBt3uKTuMN7TvvhmmEfI87s97s38VQMG8JB
         N1kA==
X-Forwarded-Encrypted: i=1; AJvYcCWxOSmR95mjEyuaZok8EPmIieYfgB0KTXs9rREVDE5s4ueQRiSadS8d9B2hWuNTjNlsiM6+xjKWRabh/ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmEMP6CLJRN9VoOEiTOmhWDdOV309KK1iRQfJGPa7qI3O/x7aW
	xW6xnwn/b6/BuV4JOI3CsCnxzqPX5ZWZBzwQad1YZGTOrsErO6RAfw0b
X-Gm-Gg: ASbGncuInLjvZvxpt1z00QiLNZe4K0/aw70f2PIXEYgWGlR8HmuynHpDKCxSmMoJcH5
	qzwkcFRwV5aBeqAWD5OYl9cyZr5T3LejzxwocZqWaq02yI6yDNcLNtftZpM81NQe+Ulmsmjf8Yy
	XlrtazAOENj9WsPHcANVw8DOpFmgR3zkP5JInyDGda0w8PJOqldNUhMLo0QbkIvRdqvwoPQ/MrH
	5RCh1+EC1HIppSyXo2RXV9tsSOHwSPc53ESQPRV7vCPhEcM+3lQzNDqgNoM2G1yWMFu0JZTEti3
	5nZiUgMnCARqYevBZQD6XWu3xC5GmSzB9FszDDrD452+croHWkvI8z6Oh+h6QiZ9PTkfuoXUbG1
	a7bo4xTFs0xqkonuZaL0j3dHQyylAScVY+O3u4JGU0FopppRHFUhNpCh4qZAyG2FvtjcsimX5dE
	6tJiVUmlNgN6ii
X-Google-Smtp-Source: AGHT+IHqEpffw/GbFtTW2ljkbOhtFN8NkS3JEYAxkA7MZpUcyloe8Kcaz/yLQmHPxx3z20rra2gswQ==
X-Received: by 2002:a05:620a:390a:b0:7e9:f81f:ce70 with SMTP id af79cd13be357-82401a9600bmr1798659085a.70.1757982849154;
        Mon, 15 Sep 2025 17:34:09 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-827e59af540sm472056985a.35.2025.09.15.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:34:08 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:34:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.14c591e08d91a@gmail.com>
In-Reply-To: <20250915113933.3293-6-richardbgobert@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-6-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v5 5/5] selftests/net: test ipip packets in
 gro.sh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Add IPIP test-cases to the GRO selftest.
> 
> This selftest already contains IP ID test-cases. They are now
> also tested for encapsulated packets.
> 
> This commit also fixes ipip packet generation in the test.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

