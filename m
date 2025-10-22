Return-Path: <linux-kernel+bounces-864939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11F5BFBE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821711A0350C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D21834573D;
	Wed, 22 Oct 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a2gCHAIC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7363385BF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137205; cv=none; b=TAR/0crYB0UdIT7FwWCqR0rxWKgTHtlz7Y8KUmFxh+c7FuDKEOl55kZ4tI26TD71IcbMiqv35gBFXcpqrFYSQv/bW+75DOn0VZ/AEkuBgOuHTJAMjv9Sel+VgHeffXWoTnmg1G+cp+8TEha66ygYC04JjDPJZR6fY6hOHJAX3yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137205; c=relaxed/simple;
	bh=lKHPikKgoYxEYOntCdbUp/DJEya0IYEm+RIQKCUtDrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJZxdu5YJhlwuuL/we+/HC/uGbmTyeHCW98Kd4A4rPa6/JY8RHRVdyWwLoiGJKB14nZL4F+u2i25CiPdGeNqebfSl1mmltYZrsMwIkzELSRBxeTEBKW5O+f2bG7ORgDvUnLyRftTCfy9P0TISRBLhwBtArV5Y+GxfxZegPuXbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a2gCHAIC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711f3c386eso35585645e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761137199; x=1761741999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+eJIb9e/dit4IcI+hh5SwKkS+l65KZdzN8pb+HcjFzw=;
        b=a2gCHAICIDS+FJpDWnGlaUpNwdWZITJ7c25meVkx+1Mi4us6E/DtHeCN6HXr38u4+Q
         X1sozfDSnlslk1nlGDLEzOqKhFc8L94ugozL9gk7D+2uw86PCWsSA1bwqxSufu+MofiO
         ED2FhZadLy9CvDWaxtgV/n5YMssnd/E5KZ145E8ZphzvFjXGPnRFr1Eij4QqE4+9TTgC
         HvHVJLaU/Xbwxqa2uWbtZ4ES1Ua7ZtU0xHiDEk7FrbpyUwufCb0YhoKloWJibdMHlYhO
         Yc5ePncu4vkL3UXanxODUcCjrAFvX2R+BpHDuy4VVFBHxAR48jdT4BMdiVBVFch18WXS
         U2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137199; x=1761741999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eJIb9e/dit4IcI+hh5SwKkS+l65KZdzN8pb+HcjFzw=;
        b=LBAS6U5MFJtbJ13FRNnjEoA/C+kbQZEKSDc7Ly0shX3HvWvtMJqf6ATwYxdi1rKjmT
         S1gnmyQJd1ZQunN/agk8M/UzjG62JAtB+IGcaXdrDHkI37+VBO4s4WsMZER/ZhO1fDQn
         AYdazYMYobKhYlRGPDvl4Gsu1viFzIx2oXa8xB89etqreb7jO10ibUyaWtj27WRn7pBW
         0497y0h6pS6tnKxJCY5WK7ipeNGfdIHuMGmABw9mn5207zzjs36RbQmzuBEyvp6V5VUs
         YwKbKKMGp/LdvDd0L7xiMIfUdkXu7NLzHNnns4r2TGKrs6OyKkud6gIimVjjUfeEBYbA
         TeYg==
X-Gm-Message-State: AOJu0YypHNO14KZEGH4iU9DoJ2lxSjW/oGNS4BKHWCIDtFw/Ct+KT5/6
	dNU1Q2W9vArI+mwqXm8adhNnYM3VwunPXpJhN8ham/F0p7zuo4eYn81CgZrf+LUv5zY=
X-Gm-Gg: ASbGncusa4gbW4FOlFqFuuULGhaN43vLhU34YIBl0vDBXIGFY67/cIhKWYBSdrN7Bmd
	w64uos2vF/+hUscAgAaEiYBITQqvqxcdAcPT5IZuh+rVofbWY/LND8/Ra+ZkhubBalughdlVR0h
	aY0Nu/T+oj0Gh1ToN1IJ7yDNBrEJHoFdR0OF6Y7YVGY1X6kOj4u3qK9q/0Bmfmq7nMnuq3MRSVs
	TwfCzZljT8OifnangV+Nni5nlaZi6HkopSVE5cFNu5ysrb27umjZsrvDG5DBKAYnSq4AJiQDCAt
	SeWqPHrzxQ6GMd8qllUlUwEkNl6KiRD8KHwvB18HbYtzWuSiKL7M/vSX6w0kDU+lZyIoRjuS5k5
	3slDF/KtOlMpBC+YrGRtwu/uYnmconmC4wHVMnmfhiP7DFPKXptUoS0BouY9yqtlIt1jMrz6q4u
	MGuK8=
X-Google-Smtp-Source: AGHT+IHxyEUKjS8XNV5DBaNklQ0lwHjh+pif7C9NRYDYhQuU2Ts4Y+mCy/5OY5a4hDGOSePFNSHUDg==
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4711791c522mr149658215e9.27.1761137198924;
        Wed, 22 Oct 2025 05:46:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428a5bcsm43170045e9.7.2025.10.22.05.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:46:38 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:46:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 1/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aPjSJ80eHQSqvdPx@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <20250905144152.9137-2-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905144152.9137-2-d-tatianin@yandex-team.ru>

On Fri 2025-09-05 17:41:51, Daniil Tatianin wrote:
> Previously, data blocks that perfectly fit the data ring buffer would
> get wrapped around to the beginning for no reason since the calculated
> offset of the next data block would belong to the next wrap. Since this
> offset is not actually part of the data block, but rather the offset of
> where the next data block is going to start, there is no reason to
> include it when deciding whether the current block fits the buffer.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

JFYI, the patch has been comitted into printk/linux.git,
branch for-6.19.

I have updated the indentation as proposed by John.

Best Regards,
Petr

