Return-Path: <linux-kernel+bounces-786448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E130AB359F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5492A665C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BEB2820DC;
	Tue, 26 Aug 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DlwsE44T"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E429C33F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203476; cv=none; b=r+1DqsE11T0aXfdbV4tne6r7kgc0IOfrCiIB9+D8DD29RzRKg38j/TPTAqQ+BynnvvS4svssgf9+XrCBoiIGCELJqkKPt+d/39mWcMz5rdYczkJZ0yzcMRQDvTK7Bzd/oxQX4T08vumHbkZ7YUxjGGSjMLpKBHddYPxbB7SGqno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203476; c=relaxed/simple;
	bh=6q+vuTcUXvVZNZ5e9dFqPX9cDauBBESomVWRf3zjxYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQ/7havw1TvjHYnD0m9qE0EhusXzVXiJVy/NT9I0vrNG+fW/+XZe/UXdP8iW9k8jpeq5k/OFD01W3wjeKxyaNbx7M1LzrN2CsJ4Ux4dbmI0yAMOhH3fznV7D0VPHiL2SL6cXZMM4a4lQMHYcppH47Nai36h8l6spmR4j1xL1I+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DlwsE44T; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso31574085e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756203473; x=1756808273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyBee5/lG0iyjNbfsN6MdpA5vjiXdFs/oW+uOE3oHX0=;
        b=DlwsE44Tp+JAQybWAtHhaJnau2L0skxO3QVhxLf0d2CHhxwct7bk/c93UIy8C8laZ0
         R6rAVfqvM38q9kk2JfQbAtLB2b3GvJotbGq0FQI+LD0JfKPx93QbGibV7vQca7eYviJL
         eWMBvEZ/khPxnm8cqh8GerixQxICu4d+CWE7ToxJdyrhBcqX1E3m5/VIwkysuMfZgwtD
         yQ2kJ4bUPdgYnB3qgWGv9jz1gysOm0j8oBbCJssaqakG7leXHLoMHMVCz/SIvTB+yTtu
         Ap+rjHrv2SAxp38I8scTUJXDPxb0nZjEpKC9A5Prg1Bd4Y7ozeCGrQW7oFTFJ1jLwa5p
         3ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756203473; x=1756808273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyBee5/lG0iyjNbfsN6MdpA5vjiXdFs/oW+uOE3oHX0=;
        b=DBMRCWVFBu+pTuoKrsG+XdcY1pG0lcICfcTTseINkoc+m9TugGF3F0Ht+1vJus3B6d
         2BCwzTohIoRZCLlBy06fRfCcYGn3ez4niAyIjeAkXwxAuS/gaiRa35Pseq7BDHEZmH6E
         v0C4sC8uh68URFidmzFvHCezJmdNcambZGnxKRHRri7WS1r5FYDnDqlNFd1jocf/Vajt
         jhRqs4fr9Q8700vZHdhIKA7AViYwYg3cFeTRzlYLMt5IgQJhQFk0MenMLORGXqASm7ui
         +d682QTnQOqCLSMyjF960WyHyEoDqHcZXG1NYzUldbgnvfaYuKYP6vB9ZG8yfuWBltIT
         weQw==
X-Gm-Message-State: AOJu0Yx9MpxwKfrKxc88sUvzUWRYaWO6eRpOK1g/1v5rrV5QMaez9eO8
	KwEFCPPsfFT+oNRc2pKQMiS3rRBpOyS8gkgL7d7KZaeQAUfvDAVpj00ZqliDBI5A7Rb/sW+4XHT
	Cr39WEXg=
X-Gm-Gg: ASbGncsqws1DV4iCBuJTTgYDPbvjIKq3lpW8lsiC6Q5NraCmA61fF0T2/26YSFW8ORx
	WWvVPCQ340tMWBoSXsMvJRRqt6g60/0FPXzmHgFG9izrOQZXqDKvJyZ2M1PY4wrwZwYjikYVcAG
	5HWzox/ADfv2WoJX+mDmuW3+24jcAArmro1vGDQpWWng8qPNhaDf+tHKhJO01iEFfP8eZ4hPIRk
	Chq+mR36cj/7YxH+z7aVCp1J+wUN/kscJTxYSiCeyY2OMMIOPAtYfNRUqXACBEHuiU1Eipo5R1G
	0J9DINRGXKCPOyUK5zVerXVlXc2nUZkyvnMX43A6l/CDBD8gsSK3zrAe7qeXVwywS0id+BkhDRU
	28aIUNRzMmoubrYjZgA31S44PbKLCTQPW4lo=
X-Google-Smtp-Source: AGHT+IH1baQ8dv50QBcdonum2RD5GCC5lK6g2hKYNq3INEU13savhIHkHrBcxJgVeloJtotIPnwysg==
X-Received: by 2002:a05:600c:46d1:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-45b5179d088mr179725745e9.16.1756203472781;
        Tue, 26 Aug 2025 03:17:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba390sm16286582f8f.12.2025.08.26.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 03:17:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kernel@vger.kernel.org,
	mun.yew.tham@intel.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org,
	adrianhoyin.ng@altera.com
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Change Altera-PIO driver maintainer
Date: Tue, 26 Aug 2025 12:17:51 +0200
Message-ID: <175620346857.22769.1782746483858887988.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825071637.40441-1-adrianhoyin.ng@altera.com>
References: <20250825071637.40441-1-adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 25 Aug 2025 15:16:37 +0800, adrianhoyin.ng@altera.com wrote:
> Update Altera-PIO Driver maintainer from <mun.yew.tham@intel.com> to
> <adrianhoyin.ng@altera.com> as Mun Yew is no longer with Altera.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Change Altera-PIO driver maintainer
      https://git.kernel.org/brgl/linux/c/6fe31c8b53003134e5573cfb89aea85f96a43afd

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

