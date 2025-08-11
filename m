Return-Path: <linux-kernel+bounces-761882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E000B1FF99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80473BF55D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E24927D771;
	Mon, 11 Aug 2025 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wz3Idh/0"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55F2D7814
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894908; cv=none; b=qSVXcAcF7IncKezMzYc3T2iD9QAXkZ7aGi4WN0rbjiAchOG26lDJqhTcugMQuOMwbJxyU1uejiWatQZZBplqQtBsO5UoIWEC+vYdiX07tocQSiRNkrP7rIQFvMSwB4TfIySo40mgwJx5PsG9kxew93NjUlfB4jmEvPXEBP8NCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894908; c=relaxed/simple;
	bh=yHO6cUwmh0vJOqPZB+SSFPl2iqxHXEQyLC70aK/82a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcxN3vbzy1P8G4pG0E99Pb0b3P3vD+2Qao4iRMSNvRte4F3N8G09Qj8snAZ8Okm6kTVrHLsfpW/lZHkFWkqcTAV4bGyZkFafqTrz+g0q5b0PQWVp+UuljVCU7booXlx4je2xYp+9Za6rxW03Aqz2XFQxt1fsifU3rLXY8H21m7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wz3Idh/0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so2503608f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754894905; x=1755499705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iB0+YESun9o8RNjTK8Ze6bNBvftWgtDMToMEaujBCXs=;
        b=Wz3Idh/0xhu1l3X0pGvzb1SUHe2O2NMJ/WOyfy/APaj8iPLjpzHGUFUPU/Nb3elt4r
         pQmNcYQh4lXdOySruqUj/WOvtqObQ+Fk+fWHHSTT6uCypicJthqzSyTYGAZJfAk2hAFV
         xofem3pHKJvblWXTCwwoKzcs+w8RShJoaU2ED+rmCCrPyZsC+AS/3XmoZxKg9b8ZqohY
         Q8qoDK1cgRjade7rOIp8Aaneop00DYd4/vlkyvPEjEEfMCVavERRUXV8vsQTtxJKms7z
         oqNM4+deHdn7JM1OZ/W2CKou0aFvE4ntCUBU9n6UzTnuI8EWEejm9LtjZFmBQL19xw+Q
         gkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754894905; x=1755499705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB0+YESun9o8RNjTK8Ze6bNBvftWgtDMToMEaujBCXs=;
        b=pnmzPGmSCmE2oIi08X9dQbQDf8T+5+NhULM61nJAumgEPhQF1ErMzRbuLdgVPUZTn7
         2TPG3kDmpevKB2cGo84AONQ7cgxIRbRybZ0kFfps3Vx8kWhJX8u2v2tqHWAhoaYBiHet
         VJE6DiuyHveoWDBconqYoSd0+7ZbBjqXeInGiYP5ElDc1O16XhjprgeGEkHI85pZkDY/
         hTAJb8/2q4cv0KzNPOJ57MKcx3IikF4XOMUiZcL5pA6PTfH7vX0FocImZhRuZlxXY9ZZ
         exkDpCbjeEAYhD5LHcOuV8RSLyVfMkuCwgD/QEPL7CDRUiP0+wLXz6O4QseJ5NQ62hb1
         eGPg==
X-Forwarded-Encrypted: i=1; AJvYcCWl/QYwRG5gamdZWr6D0jkZhXB3YUXIAhomUlJyX2kPLiK1UAvCag68Q7DmNpvorixVSXGnG+ac56LiqsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4u8QlUPQIjymC4wl4uD/1jCTV9Pz7kV1Gi+o0v/J2ftjDPg4D
	5lPrkz/hZKI1zlK6kMrzsYhEbpAMG5z/YpnuFs/tZnbJlt95ffmLIk31VqCoT10oBJs=
X-Gm-Gg: ASbGnctxAsE/E8Mbr2ugutEpUCrhcxG9sk90rdw+1C0hcyDecadfOTa707WpTtSXK/L
	IxX6So/NRacwARayuJ50nAOJjQsYXTgSJBm4GEjKCvjvtG3PtTPQpNAZqKFjAIh3x4T/3uk5OhH
	6jYtMlE3ybOc3pZvfhbsaaLLlL3vddNS3mPlsTGgCWvvgpgAJVyFpWT0PYSxJ62gHeSJGQNmpdk
	o9IeHngBhn8/MSq1Z0dG63d1omJU2fBCFz9kcY/YWqvmSHGDC+P5FAs/yrky3KHNrhKmj9LNTML
	4OHW/WUcyMVVEXfvhT9hFLBovsaPDrgBDcgx2f+EPFSlfkzOR9AgwxvBlwTMVdVOrALkzlmTsAv
	tTukhFwRXHbt0bnkqOJrEq3JGDSZeZZo+AvqVfA==
X-Google-Smtp-Source: AGHT+IHc5PKNrzT8LiPlLkDgs/sPhW/NBYUBD+Ihu1W/7SrUvXMLhGjZr2mUKqRPn1RPV5oYAIgf/g==
X-Received: by 2002:a05:6000:2083:b0:3b4:990b:9ee7 with SMTP id ffacd0b85a97d-3b9009405a4mr9368958f8f.22.1754894905296;
        Sun, 10 Aug 2025 23:48:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e586eef8sm237573375e9.21.2025.08.10.23.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:48:24 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:48:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yao-Wen Chang <changyaowen19980629@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: refactor code for style compliance
Message-ID: <aJmSK7YWWBDBenTm@stanley.mountain>
References: <20250809182835.863172-1-changyaowen19980629@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809182835.863172-1-changyaowen19980629@gmail.com>

On Sun, Aug 10, 2025 at 02:28:35AM +0800, Yao-Wen Chang wrote:
> From: Yao-Wen-Chang <changyaowen19980629@gmail.com>
> 
> This patch refactors the rtl8723bs staging driver to improve code style:
> 1. Ensure lines are within 100 characters per line for readability.
> 2. Add spaces around operators for consistency with kernel coding style.
> 3. Convert camelCase variables to snake_case for uniformity.
> 

Split this into three patches.

regards,
dan carpenter


