Return-Path: <linux-kernel+bounces-841932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85500BB88E8
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B882F4C19B6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA7B17A2EA;
	Sat,  4 Oct 2025 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWDKCQRE"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BDB1A9F90
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759548137; cv=none; b=km+FmFsRT37I4uIwzkLWZP4QIphaFk/m+6btF593eDQGM1hUCHcZfbkuB3Ds6XQH1Ew7MDXWsV/a7unMfgsN7Qh4poAHW07K9QnrsNxjcDOLJeaN1SzamSTNXnEDQVPs9T+MdVF688hlNDyDKX2y1yyIULjLkhoGEZSiGH1GlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759548137; c=relaxed/simple;
	bh=ey/UirZuMoQH6VVDj0zZ1/9OEU+uMzZ+O8OKJwtAu/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxioZx9fNnpSqI7K7mFkyz1Nig/sxy0Q9h3xm2lMoA+vMuMlGokwsXLeMZ7is/e2D6ZoWQ3BwIZNKLZ/0u4i6cdUjBq7sT9adS4AJRH3T0FoEyFV+bhnqShMah/whQ66qZTC5Awln4BXoijEf7yPsuIhWpjOvyTlRBSueoQA/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWDKCQRE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso2674900a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 20:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759548135; x=1760152935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vT/ORNW0pW5y5PIVl3vdZCajLNmtGvBDvw6fpaJcnVQ=;
        b=OWDKCQRERpYz8eXQbDiX4hmRiCEC3XqA3Sc49LfxUJyPS35ZyTUdB+zWdCAVtTqSJ8
         ZeA0tmBUoXc/9sFKH56O9ZHA0n9w0qwGQr6fIW4O96nvin5qEsH3rh0h6b9Y4pvx5HSo
         SoEUMQZ55ZepDw2PpWs2sp69z0NEXZPARjTZj3Jf5l7Fpey1ws9beSUVQJ0RzBujgns3
         V46SKM6owzLY8Ky0purH/MyAa0/+sIbFUdFKz1Nmr97qugj0ZcamwcJAUZ7bFPk321lx
         bRb6sR5XwRr1IgwVOZMmmVgZbiDgtt5jbhvMX82KORtYEGkFUGhoi92pHotunkmUKh/s
         VO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759548135; x=1760152935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT/ORNW0pW5y5PIVl3vdZCajLNmtGvBDvw6fpaJcnVQ=;
        b=Qu+4H00MD4ALszACnXXrzMhz/cDwC7RiVIOqcKewtOlD9wO5b1nqJ3sDcpXEfWz7S1
         LpVdtcEoKwenhmZB9XYFXhlp5uo6L6wkVmLlX4a8+Rocxce1bUqrEktK/1TrLyMDKP9Z
         U9Ff92x7/SSAJPHLZFByWtkK6JMvrSkSMkh16rNpy6jdNdvmQXkUgEhNeKLXCfmn0SzV
         NXNmtG8QF9a4DG41Q1ExgUS+Co8ATTrh8F0gn4mWs1mbZ9jp8fuBfHbFGI8TUaWprrbx
         Kp1XhrYlvP6lT8w8sQEeTgEkUwpy2mcOMD217S5ItIDhNyYz65dFIa8OdgdiN/dz/SMZ
         yP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbf+wf7X4uWY3IGJcaJQpGk1/o/kpTSDdxN+HTrrTB4jSgH4Hbt2ezUBn2nn4gWF+xdb5dnl9RpnklSRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZGqh9mS9S/ybqi48cetJHkEAeqdDIasKQ80yUR8poVMuBs6ii
	rtYJsjhWIzKeDSK0xOZG7PK8lVPi9/cgftl4+jJzYSRObD6d3Wl6Axz/
X-Gm-Gg: ASbGncsDjZb2VlxDtsdjMpTZ21A9jjNWQKebXJ4gOyMouLV2ql53cQ/MczIS0VdAr/N
	nOSVq9vYYrJgHQjBHPBf1Ty4rq1Aw3nRkv74w1s7wqzTy1gRQ6+nLivXjwlPgy9pwP6G7ZAesjZ
	SB0ij5PBSbZsAb8QVDg/x+8fy+e2rl4sIAC8oHwCm0gzY6qt8jSXDAhTi9ykMN5GoQTkt4xAXo5
	3Kps47ZVDeXB0VTCjekUfNHiDjbS3rtSNkd9heIXn7zytscR+h8cqheqUjsX8exR3qtaAa3gTp6
	LsNDu/8QCz1K+61Et1fP+0PBHAmBMpBATkMWO2mEbf8HzVYu77BRqUBLJhFgf35VjZy2gSg8V7g
	qN3WE2R3X/VIjFzhzGEikU/pADRFXnt/EI0LwWxzohtN6kX9/FhTlJnOov+MGYvDaAePJmbM=
X-Google-Smtp-Source: AGHT+IHEj0aXuUhMgTbCirX4CidHBDMcg5LPlI/yovtk5eB8b98mCogwEGyUGrgHax0e9En0MN3Xpg==
X-Received: by 2002:a17:903:2f8e:b0:24c:d322:d587 with SMTP id d9443c01a7336-28e9a60b519mr64976925ad.26.1759548135023;
        Fri, 03 Oct 2025 20:22:15 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.90.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b8444sm64824745ad.86.2025.10.03.20.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 20:22:14 -0700 (PDT)
Message-ID: <21b1dc10-acad-43b9-a9c6-24abb2886856@gmail.com>
Date: Sat, 4 Oct 2025 08:52:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: Shrikant Raskar <raskar.shree97@gmail.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 matt@ranostay.sg, skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
 <20251004015623.7019-2-raskar.shree97@gmail.com>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20251004015623.7019-2-raskar.shree97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/25 07:26, Shrikant Raskar wrote:
> The MAX30100 sensor supports multiple LED pulse widths (200us, 400us,
> 800us, 1600us). These settings affect measurement resolution and power
> consumption. Until now, the driver always defaulted to 1600us.
> 
> Introduce a new device tree property `maxim,pulse-width` that allows
> users to select the desired pulse width in microseconds from device
> tree.
> 
> Valid values are: 200, 400, 800, 1600.
> 
> This prepares for driver changes that read this property and configure
> the SPO2 register accordingly.
> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>

The subject prefix [PATCH 1/2] says it's a two part patch series. But I think
you send all changes in a single patch. If single patch use [PATCH] instead
of [PATCH 1/2].



