Return-Path: <linux-kernel+bounces-884442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68BAC302F3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157B83ABB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720762BE7BE;
	Tue,  4 Nov 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brlo1/S8"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36D28507E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247265; cv=none; b=RMlUfYhRt9VHKaowbHn2AlplrFOYHxJa8AIvMmLB+KEkALvqICsli6CU56AffUH/a3PBvO9B/g1IdvCBbPB+lCUvxb4A34jVL9cKvb5lfeytejNw/jUMxBaUyxJNKSX4h1mIaWfoGOrQZz/AZIsD7b/Ho7Nh1rpbvhypudByZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247265; c=relaxed/simple;
	bh=TuCtzip3bah74WZxRFQntclSEQkH+x93jxSA+LPQEmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3Aq80ELxkpiUXrdPGbhJFLtIHsyF9EBFxv4UMFIHh4XH5FS8vQ0a5BHOb71NMTL5sZT65QUoMmq0FlleWS0vWcmP7PTa+eKqSTwv7aHWP6o2p8Km+t+9Y2vCpY2MmT+qj+SqEpPFbPqWxUL/0z0LRDvDt31+zJQQjw22RQQnRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brlo1/S8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso3899922f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762247262; x=1762852062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2U78b0r3LFoVttw9h5UMzm3u/4eL0eV3x6qiyPWr8c=;
        b=brlo1/S8kBrEcFO5CswBCcoV9bVu1UDbErFy0lCds4tlq5ARvrCyDl1pW/NOkk9Bhn
         92rG5z3F7DJkcNgkmt/9hNyDv5Oppk4/7dNazmB7m86c57LFHs1jDm+Ipv4Od6OWpHlH
         bp2AN+wcDnFXcQF0eS0BeDECZ8aavMVer4yAoRiPwTYn/oPnXlXRQOwLkqoizMxWapoT
         itSEWOvSknF/dPJawBDoT6bQ+g5dB8EWaonz3vDkQEZnMBQrI0xvDPhcHHzbNjPAUqCs
         dSjRsgIIO4f4YOK5zItDPoS50/rElKIoZ8wXVs2UwpK/Qe7ugGPpft7wPfpogeooRF7t
         u5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247262; x=1762852062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2U78b0r3LFoVttw9h5UMzm3u/4eL0eV3x6qiyPWr8c=;
        b=XNhm6eCyxZKZcLzEiwKEztLAG3riGwhJI4+T9dvMG8s36a3Oafg/0tdTMjTl2JyMJx
         GIq2ikvhpXTvq/SeoIP7W48xCoHr2AtdEaL7sQULEDZW/TQafg33McJ+kocnkHDJOq8o
         CeSxk8+KfLcLx3Q3V+XYz6/znkeYFR2NC5IlaPH35/s15xgFJVZ/QoLX2Vlat5Itq+SG
         Dr9p+UKieYNMl122BAjHt4teq92O1E+uqbxgZMuWDGjIqJpNEGuTmCMJuvvH8vJyEIOQ
         ggW25GjL2lVd+DOVlpqiS6iwoEy+vaZfVvVfulbRD1fgToNyopD57mRM/Rny/DQv1PdX
         6AYw==
X-Forwarded-Encrypted: i=1; AJvYcCUtB92x1XfYgCpsMA2pz9O8CbYezuCx91wdn2pyMygt/xxiUkkerDN5DmUNQmOwrV1750/aanMSwZ4FlQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhooFTx2Z4QvG0G1B8k7UJU5Dgi8MiaV9DpjYFEZtsIl0eOSx3
	SVWtSjnC5bScR0Y6IXn0qjabVV42KcIlc9zLIegIJm0kwu7aPFH4oYPw
X-Gm-Gg: ASbGncvn1AKeVQFBfo3QFY0logEySdBDrrlCjGb9Sf7vrzDdi4SM+AHLenRDgFJrFpX
	L5J0glnboI0YZj+HH8w5/e4WLAGNNEqImLrInTeKsUVyMBB3+bVrGwCy84wMy6iEa4KT/PQAvCM
	jRGgLgTCRlgyHe6SbuWb5yqFYSzEr+GrWOWZEeKOOrkqeB2skWFOLWZNDhI8oeLGWUXkZKK73sF
	9PfmJQNQV85jwbv4wVEE1bux80rsdTlTkOA4msthB9lB9RuQ+ih9H+al67uMxFGeWrKcZRc3DEj
	XZQkCRK58AMkaw0UVpAPYU/mPqtdmNj4Msn+P6db/oP3gHSIZw5ajKpf6wRo1yjuirZ4VIQJ8e5
	dZaL+GEJD7NEIvq8RmTHkFm6MC/H86jB8da3aGbtdC2FNB9g0X9tp9fx/sjC3NFOOE59EtTCOZT
	aCzuF9MYcxKOkCjw1iM91sGkJ2QdRq7tcMB8n09/3QZA==
X-Google-Smtp-Source: AGHT+IGYgbpd1b66F43ND0mYohd2NaRrHEGUtk1/aV25HsbPFVKRFBE4YMwDgaXfjm+Jhw+aUuciPQ==
X-Received: by 2002:a05:6000:250c:b0:428:3bf5:b3a3 with SMTP id ffacd0b85a97d-429dbcc5d5cmr1908926f8f.1.1762247262377;
        Tue, 04 Nov 2025 01:07:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394f0csm199510285e9.16.2025.11.04.01.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:07:42 -0800 (PST)
Date: Tue, 4 Nov 2025 09:07:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] base64: Unroll the tables initialisers
Message-ID: <20251104090740.716dd95f@pumpkin>
In-Reply-To: <aQm2366wMJ1K1fp7@smile.fi.intel.com>
References: <20251103190510.627314-1-andriy.shevchenko@linux.intel.com>
	<20251103221857.1acaf6ab@pumpkin>
	<aQm2366wMJ1K1fp7@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 10:18:39 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Nov 03, 2025 at 10:18:57PM +0000, David Laight wrote:
..
> > > +	[BASE64_STD] = {
> > > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*   0 -   7 */  
> > 
> > You need to use -1 not 0xff.  
> 
> Whu? The s8 type is pretty much 8-bit, care to explain the point?

I think it is clang that complains that the value is out of range.

	David



