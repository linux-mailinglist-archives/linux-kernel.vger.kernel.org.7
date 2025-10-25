Return-Path: <linux-kernel+bounces-870090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2EBC09E25
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 20:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27B7F4E4FF6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6011D514B;
	Sat, 25 Oct 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgBIUpJ6"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1933C35B131
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761415251; cv=none; b=U2PdjsaCXGYd0UUqzhx7eGHuJ83EqnsxbA+MAceCQQ4NoPed9fMpCYCH0Jh+M2RDmeFfkzBTSiQd3qXaR3zE/2dcg3Yc2nUf5aclqbeLKoYG/yverQSmp4O0sCHXdi4p1Y+bxmlPBnsqsfjmfxnYzzzAYmppJHJ9PRA4KS+k/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761415251; c=relaxed/simple;
	bh=4reZdqBKXLAfCl+fqMwNhRzSDJaXcnJ62jSG8fzMP38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S4Z4fHr+G4s92PTCu5ZIQGLIY0SyO+Yu5+Ho9sTfAicga6Nvfbkm4Oo89aLWHFDXIevxsUjl2azcur44vnt3PQK1P4+LrIw4ACVFzlqKDbxGXFyjQtuc5+32vqYzifWNZxn7YvV19ZogluM3qqgGLqt4pNsAcIbrGTFcXQ4OANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgBIUpJ6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-592fdbeb7b2so2364861e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761415248; x=1762020048; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FczjnEOoMGjlPYp5JwUCRjBRTRga8fK3XnuMzP3GAn8=;
        b=KgBIUpJ6A/h5y4mm2wuKvhNuEXslRGNL65KI8fLs0Pz9lkv9eaq8CSBfSVOzbfXYqc
         beepSpLNrufhqWGYLbYUDKnPMuQKPmum86/PuIAeYx6VW9zSAmp27GM5AiPOGI0p1V69
         zH9CDlwAA0+FBrdA+fB8nAv4z5nh+9NXdlKBR/tZDOslI4k7CnjKs+ph+fr0V1K2ZgzM
         SL41oirx294tpHvq0LtetgYK2K6obp8RY9fBFHEcmgDNXj9miNehmLgslo7PVvSj2LSQ
         kPoXvf1pq/ou6zeAVQvTlUu+8T6fC8txlZ2mhJWmmdResJxumYgtpjOcGF1MwG+LKPwy
         oQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761415248; x=1762020048;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FczjnEOoMGjlPYp5JwUCRjBRTRga8fK3XnuMzP3GAn8=;
        b=RnDp4vU7/kAxkS/6UusEeIR9fy6KOjAeIJr7eZWur6eYfCoXOsmlqI6jfC485bfm28
         utFi08THrAMALkECdH6rmH4pJCZntqu1HerODLkotkdN7Jrz2mjQ0b+SE+XVLJc3a+UI
         KNtbdGh450c/y6APDqORV3PI4JEHLtgIcIC8gcDCYa5gH1FmtEygKxstd1FPwuRPdzH3
         k1bWTpWZ+FLnCY9HNXdfkR8ikOO/vJ83zRUi3EVJPHabnqDetA17Z0wSF6CfPsDWF58M
         jRWQGQeOTa0KyhVaF0ArBv/gdcivitwcwBiE7bYWhMBAITBSU3c3PolOXkCPOXzUxxxn
         i3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXxgvJeQ/jwFJjixI0Dt9em/t5XK/Rznh0C4KOWyVbnTAEXJjOs5I8Nl4viO1IeIF9q5UWmhkf6MZomleY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK2qvY9HfNONoYa1swYsMME78BqK8j7OvTBDAaHT7gIUO7lmFj
	hrdoPh9WBiQLh8p8ASmUeiHY/DiXYyxemB3bVmywaFei9IKkE/ZR0w8=
X-Gm-Gg: ASbGncs9kGbe0RmfiKrPbotkbAqam4+No2ypYYReHNAOt4BedoEdTdVRSLlkX56ONzl
	X90P9mBvkpu3GbmgxXxRJXx7EFz5y1PRFNJEzemp+079UNSws1K+6nb9hjbferKTd9lv7ceiQ7U
	t8KC/cQv5sdBXWUI/BRvg20uarWCDf9CWalitsoPcONP3kYiJAUbBYIjoDXXXyqpaMq6RH4mqqW
	Pa9Ulp4ZUxHh7VgMPqn5T5EssISmhHBLrvTsABra8NmG/YZKCluexBkQ3wF0dctN0k4TKNE/mQ1
	EJpcxlh4vHW7ogCXtqEcxG/wmu61FhDbPdXu77sdz3z9KDgaeQyvGO4WAkQNAZFriljhoOqzm8l
	Hf9GzXRGhAj8BiBhZKegQo3winRFZrjxNIuh9D5rDEVCc9d9LlaJeIjX0GnFlLiZSQHjdUgp4
X-Google-Smtp-Source: AGHT+IFtKsbQInhjSF6RbUCEhp+bwcigU1IJ0F+1jsgZ/xmHmrs/T3EcjmrQD4kq/UcsVd3ctZGuCg==
X-Received: by 2002:ac2:4f03:0:b0:57f:42c8:409 with SMTP id 2adb3069b0e04-592fca66deamr2236499e87.39.1761415247996;
        Sat, 25 Oct 2025 11:00:47 -0700 (PDT)
Received: from p183 ([46.53.249.58])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f68e9fsm853360e87.71.2025.10.25.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 11:00:47 -0700 (PDT)
Date: Sat, 25 Oct 2025 21:01:37 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/21] lib: add alternatives for GENMASK()
Message-ID: <3fbe9674-bc06-430d-8702-74d9dd9c3cb0@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> GENMASK(high, low) notation reflects a common pattern to describe
> hardware registers. However, out of drivers context it's confusing and
> error-prone. 
> 
> This series introduces alternatives for GENMASK():
> 
>  - BITS(low, high);

This is less bad (low bit then high), but in a perfect world high bit
should have been exclusive.

>  - FIRST_BITS(nbits);
>  - LAST_BITS(start);

Now it is 200% more confusing.

