Return-Path: <linux-kernel+bounces-861348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778BEBF27C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B74418A6073
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F40322C7B;
	Mon, 20 Oct 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IAMe1lZz"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CD3191D2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978358; cv=none; b=X23dA6fGBEj9B1QQSPLy1NttX6ZCfA5cra4BQTgLH7ZfxX3H1t6ByXsOwQQZUBcGA/rDPSCE7/gyuHgh0mbN8DYzxmINzGFPYg0rtsmWTiJv5aXMcbhcyfC2bFZyOQHTG6jPVusqhht7S+o7JRmiCe7IFyXcykzuTiOEej2LrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978358; c=relaxed/simple;
	bh=h4psjA+4m5Yd0xvfxXbO+b9oxRofaNODIGIPOWNQOjw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jhhLSFcUadEZ8Nr3UzVrGGrJTbhnTimrsDTNM/xsIVp6bNtOcxBLumoTww2BU/r5+Gzvtcuqd7VqtoNTdiN7Ev7uE+GHho9JzR08Y15qgEMJLC8WLNUpzemqrH9xvrlLrBXo7k+UFcYCDm8vZQqRqw/dUebHlvvgL8vyR0g05+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IAMe1lZz; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-93e7e87c21bso312741139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760978353; x=1761583153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxMaJn1oMU5F/nUr+F+IuKEyn6pUCEn8SKXf5r6k4ks=;
        b=IAMe1lZz+c00NgTT3srXZfIUfZbhWM3AAFOkymx74Loa0H+yx2vJn9ZH3CTr9rMjiJ
         gtpeN6iCD/8ubtpMNU0uVaRC7Vq233dl5KG06uRIM3KTnsJh4PBgDkb/zYCqDfsy1nC5
         ZwjrNcunvXhiWpZV2pjZRx4DeuKe0YFcMmDqARs7F9d4ylL3y6/IBQY+4M+YR26mBhM+
         avHIpD7LKU9pBU3A+TV3A+rK5cosMvJ8XS04c8SAkM+GdODlOBmZBYa+S5XgP0MY3knX
         BUX4Tpnq2QGzOi+8+/Xq2CDkDCDbLc8n4vGDSSrMjAy+4xsP+r8BL1EowyTrBE6VCO+d
         8DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978353; x=1761583153;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxMaJn1oMU5F/nUr+F+IuKEyn6pUCEn8SKXf5r6k4ks=;
        b=soVPFJc5h4mZrQ8Y4Q6fMndvhSTWrxJJCh4agwiLbbr7kQIp715/qDXgCzF52GrzXs
         okDjRzZg2wMR7u1qRWDCIVKRLKZEpcexU7Jj6XyS5hBXmwSVsldRT8pF8C0TOmA8zeo5
         IngnPbzwr0Lic07N2IfTFUQ1RIS4ovc7g0G7TTWVpfKdPdX26vNLNlGk1r+LOPtV2HQ4
         JVFiYbXZnuzSeK12t970CfY1+Dox3SucR9xSuIvZL3qji26+epPMof/ih2wLd3wsWol7
         /TZQAipqYmXKYjkB5t5fFVmUkyeNRZwFnt0Gdf3io4i8S7UM8li3bX0CMip//SSPv3xI
         uasg==
X-Forwarded-Encrypted: i=1; AJvYcCW7wBuxyYSYUNCVN2m2uy13jQMRAMOps6q5o1ptIdWFFgcOK5c6GgwUmEKw785xFVuNtCOBHJz/4wCn2do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4PzX4aUecnwT47A4PPRUUUZgAmED2GzhCiytVHw66HGFYeTNq
	kJ3JCQ1D4QY8pkM1qsv75RVSM9KIBn/CnXAqj6AkZepMdM1Hae5K2oaWUm+tcGHLoUkYpARJoZ3
	FVNAAb4o=
X-Gm-Gg: ASbGncuNBbdLWVy6N3G+d9q2GQK+pKnlgxerQSJLYGMaZ8IROO5FTv2cWPzfDzu6Avv
	FYZBDBCXGKe6yaOJHPEPbR2IBcs4Gx3cccaN2Bnjr9TeIEAKQ71xLUVjuAa158QPqM0FwxBWWth
	fi6q0/aaHEW0gSasc3yBCTvnqNtfuHKxNjsLVVo2BS8/R+vdxahWTouHDpMfvDuAlyt+W8l/tjf
	p4saRb2wLGsDFmux2AZvxADgk7wkma2sVs7CA+EDz9eOGOSk+bpBz2zO4BTkAezpTRvG91lTnam
	4AFSRKLz/oEPTW7DigYXxZT42B5MhFaX/hcEnaRw17sCekjNTDNUvCLvzqVWfUe9nV2luBUiA7E
	Em7jYVsNjR+2Fprm9Uo/81c5lIqxN6aBpMPEghu3OOhuXuzUyUwreaEfL6j6L/SunOOjAyaynwr
	kvYw==
X-Google-Smtp-Source: AGHT+IFW26MRpxaoSVeHKWJk5WnecJwW3fQuafM/KT8lBR3W1vBSFYWv7g9d2DXyZbjSs0gxMJQgNQ==
X-Received: by 2002:a05:6e02:1fe8:b0:430:c403:97ea with SMTP id e9e14a558f8ab-430c524fbb3mr205255725ab.2.1760978353191;
        Mon, 20 Oct 2025 09:39:13 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07ce09fsm32052445ab.39.2025.10.20.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:39:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20251018213831.260055-1-mehdi.benhadjkhelifa@gmail.com>
References: <20251018213831.260055-1-mehdi.benhadjkhelifa@gmail.com>
Subject: Re: [PATCH] blk-mq: use struct_size() in kmalloc()
Message-Id: <176097835143.28490.789079417051480319.b4-ty@kernel.dk>
Date: Mon, 20 Oct 2025 10:39:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 18 Oct 2025 22:38:13 +0100, Mehdi Ben Hadj Khelifa wrote:
> Change struct size calculation to use struct_size()
> to align with new recommended practices[1] which quotes:
> "Another common case to avoid is calculating the size of a structure with
> a trailing array of others structures, as in:
> 
> header = kzalloc(sizeof(*header) + count * sizeof(*header->item),
>                  GFP_KERNEL);
> 
> [...]

Applied, thanks!

[1/1] blk-mq: use struct_size() in kmalloc()
      commit: e5a82249d88c7063c4ac998704b0ae5784013976

Best regards,
-- 
Jens Axboe




