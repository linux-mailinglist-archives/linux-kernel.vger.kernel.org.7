Return-Path: <linux-kernel+bounces-799305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF252B429CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09AA580F23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBCA322C78;
	Wed,  3 Sep 2025 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnlJyLAQ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8D36932C;
	Wed,  3 Sep 2025 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927385; cv=none; b=b9QDt+fhXcTVC4TK1AfyTq4NjSY0NsJzjUa+2WGcGpjRyvQSpGoRPV0Lz11KdAVsgbhHn/p12bOURZGsTEPiOLPvNdzx7G23/RlIEWODz3POL7TCQkgbofdfAlXcAbt+CdrQbop/UsZ7emCdcjXFf34ggLCzOWwnXudImH+58Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927385; c=relaxed/simple;
	bh=dDZu8UanmT0ZpvuUXQnVzQKPf/1q/pqz/i1RIcgMeuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPkfxh08DS/tuDAZTcU7W9q7p9DGi8zjyiOmiNEFeGIgby8lai9DXYfeNR4Weq+CVFQrg9lV8ASU9VwEomVwFCZHHZspgnlO0Bzbm1iGFfxn0coUFMXvwsr5IZ1WuBJYUuJJc6Kivo8C1n8ukFvqoQf0rECCvN61Jvi4cZWla3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnlJyLAQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c8bee055cso128841a12.2;
        Wed, 03 Sep 2025 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756927383; x=1757532183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yso2jy4NX4diTneo1tU7VM8UpOKgDZTxHV3gGfywGtU=;
        b=GnlJyLAQ1Wd8DHfBdHge0Y3sJMEnvKOPN987Ftxltf+51YygA08enQ+W01CidIoe2S
         cdN1j+aHOsTNO3K6gXTw7Bo0rWZTMWCBRb9Rjq7i8qOndXTSoN0fkLNAwFclafPpFVuP
         XyWjxmnoXNbihME4S3gi6f43cC4MA1ml9DJ16Y+zzvrqPAYnrHrcgxDmxvpwaK6ByNoY
         /SaMG3H69cfxWH1LPQ1hhqjJ9MCdDhSfJJSM02+TweUs9jyrVuhKwWMY/dQDZlE6QOXs
         ckqj1MGaz0e9uLXlSYQIwgfotBJYIim8kTUoUbMuTj2Na3vCinoAQjvdEAEPAhaRrSOo
         KNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756927383; x=1757532183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yso2jy4NX4diTneo1tU7VM8UpOKgDZTxHV3gGfywGtU=;
        b=q4lh0DYTDvfW4q2Xv8u+p70JYXB1ghMsklR8KJg93+XFI/R/vu4cTQwbFuLLXWDi5v
         krJCW6kcHQjZfP6R5e7ynirLByUKePWJaEu3hqbHfJeNFhTY4rv0rggvR9eJyPPYVnCr
         gOM44Y+QqCO9wg/FVD+zZyE50T7Ld6L1S+Fw6zo5ENUwLeSbKnyuNmQ3GlV3BEukVWog
         BFotD6a5IKlNJ05n8LlTcbH34SpvkYpaoYozhY8BqYvUeZ769Uj2io8gmP7Qy7XidsM0
         LaxICDbPRcMisLv0TM7yh+oxdnLBlJ4JI6Zc9tfrEgZKHLEoX2Ly14bQFz8AIITgF3PA
         1V2w==
X-Forwarded-Encrypted: i=1; AJvYcCUY5e3ibLLLUF/BlPb4B+yK4XHgdkhG0gUdDdHuXKwbDkg5KrsN9MrrpeAEBVmsjedXlG8wfXCu5B3CGg==@vger.kernel.org, AJvYcCW7/1yw63pK0R41lCjZi86R43D8JwD5NH7O620oDmvNbGGSK0yixfeRPLBODpO68qG+mOfni9ER/bsTOIYZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw89G//ku+VprsgqWJpTE5njmqmemUbmnZAqGU4ariB1/qQF9z
	TS1I+/uJ8RYSrPd3281qHHOp4WWWYE9xRe7d27tA7Z1fm8enskyPxYrc
X-Gm-Gg: ASbGncsAuH+ceid/gvb8iRO3Dl9sUzIbgqif8YzY+KtnZLThfXH0CKm8VlKD4s9dBY0
	KUig4spMRY0ryVuKLhQjorKxjirrXnS102DkSDvJK+kzcoxYPAnyw2jhlMRXt2OwbmP/kdMb2eQ
	7+Y+v41DAyGLnt07FQkKPgTFEp6gqwre+p17v9FYsB+76a9JNKYZckua+gTX2PoxQ/KAe72zCRm
	fuXlyNv0RVtszxDFDKK33iqM1E3D78PwypxXlqes6F9UNf+Gh3rWHomvM+npOGyDQwO4egKne6C
	vT3fSQvNjB1anD0XGUV6OXVpeWxZTjJ1UwWidijiQXe/g1nDPiUbbxXR3EJVZxuPUANM7Ofs/sD
	CsJmhmJ9OzynzU/rbBLKcSBqiP7X4rcRheixnbfhbdXB0IQ==
X-Google-Smtp-Source: AGHT+IHyElFvdFQp03hwlkVvhHei7OEM97lamNEQUicXhwoB+GRPo5jeUlAP98cbWr/l1rLADZBh2g==
X-Received: by 2002:a17:903:3d07:b0:24c:9306:c30e with SMTP id d9443c01a7336-24c9306c595mr41630895ad.40.1756927383078;
        Wed, 03 Sep 2025 12:23:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b5f94a2a4sm2872989a91.15.2025.09.03.12.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:23:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 3 Sep 2025 12:23:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Michael Tandy <git@mjt.me.uk>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) sort declarations
Message-ID: <740c56de-336e-4a7b-97aa-52ca54bb5d58@roeck-us.net>
References: <20250903184753.5876-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903184753.5876-1-eugene.shalygin@gmail.com>

On Wed, Sep 03, 2025 at 08:47:36PM +0200, Eugene Shalygin wrote:
> From: Michael Tandy <git@mjt.me.uk>
> 
> Sort all the declarations in the source file. Contributors are asked
> o insert new entries keeping alphabetical order, but the existing
> ones were not completely sorted.
> 
> Signed-off-by: Michael Tandy <git@mjt.me.uk>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Guenter

