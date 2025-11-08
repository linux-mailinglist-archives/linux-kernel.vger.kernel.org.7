Return-Path: <linux-kernel+bounces-891520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5A7C42D5F
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 14:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7A43B083C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1504212557;
	Sat,  8 Nov 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DYMH1XF3"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146C41CEADB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762609216; cv=none; b=XFzmYDwMDa6aL76nM00EAgFOS2VwJ5dnkApDC3Te5nDx4G3J9c14SKRpyJZ9TUPNSC8E/TmCIbxx2up6gTlGSbuB3ZJa5TEF/pJ0iCvDLf3ofPdB1uf9fhk02i5m2qH/dEE5Jjy7jsZwCSC7BBlb5Dpf1RVwJQNdb7JlAbAMmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762609216; c=relaxed/simple;
	bh=273VHuh3p/ntcPrXYgH3JgdfT+IV3y3JCMHzGqVXhKM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RVNv6Rv7OcLVnCaAnLNn/JRvJf2D7Zb+kYdRVs3zT6LWCeiZAVkf0bJj72dE1lKcP2XmO3EY3N2i6OWvPTYyOicRjVqz80h/lCdGRHUaQ/RPfMKwlSWNJ8qnWFGt1n2bIle8/cQiYuT8UWU3MJJGBjxyg/uF3Qvl5lz1tbl9b9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DYMH1XF3; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-882399d60baso3602936d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762609213; x=1763214013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2giZadMJBuuT3KA47dI/fWZ1tD3AsoNgXq1hGiRElGk=;
        b=DYMH1XF3HkOMB1JI/syWZ+yjudL++zGbGH4lGi+EiMsfzt2ioJROOoV8h+GtS+D5uH
         cjmKZL5CaLAnSyELS/Lzvcq3glGWkGG9yvtnakrIQK1D6XJpde364NPWxlWm3ihy766p
         7rlPmgynhRUq7BhV21O51hRpGz707GKhEWUYsQvTZXzwcJb7RPYggeGcw5W5A6s0CI3C
         I5AKUY+w/7pFyFOEt97Ukb/vMbBfzsnM+tlSEvKKHjeE3iWNvn4/nPf0nTbXFIIikm9T
         DNleOb8kR1Mi4Xn3+/cmSFaqdr2PDfxRr99uzRIx6N5tSIPgxQOiEIGrfeqziwfBvaam
         O4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762609213; x=1763214013;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2giZadMJBuuT3KA47dI/fWZ1tD3AsoNgXq1hGiRElGk=;
        b=NZ4HyroZlM8dd9HYotfcq1TgWe9jaQSGPLGSxpIvb3AuxBFwP/zPpkv5y4/BqVIASl
         ASJBvBjFBsS/us+6JOByMo8RoevWsC3IxWayJWFshtBZM5NaGKqfvgw5XAl+/rvOcH+Q
         Uh7m1vST9MHQadbzzyRDUwr7KuamZHD2i6uMgegKVL3l8c4usR5m+2F6SdDoAMVyzEse
         aL4z26fozI1/JvBjOoyLmHGHjTlJ6JVqEBQxOnaL0I99VnKsuvVC/tFMc7XteSa2N42E
         shODXoaFMx8GqIxsHXtcCdeWY81BSCDPQANo3cN7QfIsA8N+vfbmEtOijrtnSGTi/un5
         GFHg==
X-Forwarded-Encrypted: i=1; AJvYcCUW5DQZ+YemJrRQUp2+UVg7pYwYtwENtbyA5qU0NSrpVdItjG9WHm7fwoz4I/TW5JE9qnIGLTUlHm4SuxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJ4SeYJCJrArvuZcU7oI62ZG6a6k5MgaXBoWRsyH/fyDnW3IU
	pqM36Pibaw+aDW9IPlPhySfhhREe+D26va8IwpVr/NLmPKpTSZx2rXrGDxNsbPSHZycpB4XOkwJ
	xaXFy
X-Gm-Gg: ASbGncudJUyjdjHo6HGeaVl5Av7jj/sJw88BskUZP0F0s8tjNSzlP/lkWyt2KSQT1CA
	EhDRruy5IzAyX+vXPjyi+vQD1azQqOrarmz+ad4qnyw+JWuz6ZxzL1DJ6uoeeBAZro9M34FrzbC
	rS40B//2DjbpF4aEpspXO7/gPIHSYz6+8r50KEcqEpAvJY/eDZVoNapjzRsT9TsmcBHHP6twQvB
	/++R9IgV/3eoYD5IN6aMLnlpkCSaop2CSIuBH7gs5wyPPOsn+NMAE0R+jvKJm62BNJUn8NMQJLQ
	/mSKCWEH51eEYeEthcgLUoYOLOYqdhpxefa4iDvSFx5MDcEo94bNpi3/cvgnFg/S0GGGi0GN4NS
	N4xCKhYWRuqnYES/Io8UEv/jmvE5PNlpN0lGaLdZfMth+TtQ+KOVi0hiYJUEaaA1lH/Xy+Nz75I
	nAY5cP+w==
X-Google-Smtp-Source: AGHT+IEZDp/cTQkzh9cxMAh79OJkaYdzIACL6/dfy5lNuD3BuayrWignNj/jpDQd1nF/EBwlxeFaNg==
X-Received: by 2002:a05:6214:234f:b0:720:3cd9:1f7e with SMTP id 6a1803df08f44-882384c4c66mr24941386d6.0.1762609212990;
        Sat, 08 Nov 2025 05:40:12 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b290eesm14808676d6.34.2025.11.08.05.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 05:40:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251108040614.3526634-1-csander@purestorage.com>
References: <20251108040614.3526634-1-csander@purestorage.com>
Subject: Re: [PATCH] block: clean up indentation in blk_rq_map_iter_init()
Message-Id: <176260921183.52069.2979400547946367939.b4-ty@kernel.dk>
Date: Sat, 08 Nov 2025 06:40:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 07 Nov 2025 21:06:13 -0700, Caleb Sander Mateos wrote:
> blk_rq_map_iter_init() has one line with 7 spaces of indentation and
> another that mixes 1 tab and 8 spaces. Convert both to tabs.
> 
> 

Applied, thanks!

[1/1] block: clean up indentation in blk_rq_map_iter_init()
      commit: 4cda40dce95a5b4ec0620a84f322472730d01f7a

Best regards,
-- 
Jens Axboe




