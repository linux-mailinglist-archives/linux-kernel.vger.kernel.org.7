Return-Path: <linux-kernel+bounces-776062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E923AB2C80D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EFA188870E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D6E27AC21;
	Tue, 19 Aug 2025 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bRNa3UM9"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA3275869
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615914; cv=none; b=ayOBVs/drfawDJCb1lEnUzf/HR9eR15vkmKgE6X+yFmvp2Sws+K2hLg0XPI4i9BHR+hNwhadlrwegEugwL50p85jQVC1D9Kj0t84UNfzqgop2edLGOflCZFFKOwlxMXesIZFZ7GIv20AtmQUQDin+TcIpygacLNQBMvAIRPyUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615914; c=relaxed/simple;
	bh=dekGUVKlmgJ1LUcSokupcNE9gClnOhE48jKoE7QWVuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eQ6BKvOkD4BJ1gU/mMno5va+Y5cTJvXfzMFAqWyD2eHnejM5hSX/yXC/PyhsUGBDQZJWuOMLamETLQpw+3gmQ17DGrr9sRtzWO5bXyUZ4kZPBz7eYpO4qpdVimU0UK+iwnB/YnCv8xbTLpnirDf+lavterAz2Hjg6iRD8emDeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bRNa3UM9; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74382015df5so997591a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755615911; x=1756220711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMXTmk35S229MAbkPFpiW+nflBx28g6QPg9NXy1ZgtA=;
        b=bRNa3UM98+CRr7ozyuGvPCldgOJpUdgX++S6BdcrcKH5v4xlU7UfCPcIW9MJ6Zuzit
         INVeGC+Ysr7BXhsJxOKFxnVYFtMcOmRlWd2nw6j5HxP9fPIE8HZDGS7L5m++8aVbpz/X
         cAJWhs65lEKaSzluCqFGNiskTUbCb3PQ06Cj2/Zi4aHMniBJrkdRVt9pP1SJhX7Z6HHT
         4HrJorNOGFFZQKLA1kEPP5MTTESvc+lrSvVd8IOmPlFNFLJq5RRRug+pLJLspeOeS3rD
         x/IYgUdI3vNmiJm0cZhqnrQJy4QXoU0xSqsNpXnklzsvDI2ZaCkw6omL9ptfUV4bGlFj
         C20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615911; x=1756220711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMXTmk35S229MAbkPFpiW+nflBx28g6QPg9NXy1ZgtA=;
        b=sRnRblm18lo0u7yr1A3Qwc5/E27Sm1VSbfvBz5zp49PVcadG2oq/8yJcqUBgI4Gt82
         O5zf7xr3RAZWLhvrIpFsEEsY7u4eR/ZFugkyPlkcpxyrhGY0JPz2Q5m9XJR48kzrVcCp
         vK1MgXkIAP+gVK66LE5AxW/xZBiZ1spKKui8iS2wd6CiozhkTi1Li5GSax9UGLq1Kxk9
         SxeIOKmJ0jbfuYZHH8DmsYMwnwXTTtoKFGWzQ+ntrOZqrIAP5K7lLq5wV5IALm7JJfh8
         YwI/9yAYUvx0wJSYlvNBqE2qpX97epwhGKpPGLZFIIjXlvoGVLlxkvXd+Ps7PFUBQhdN
         +xhg==
X-Forwarded-Encrypted: i=1; AJvYcCUxpsJFVcUXnWHpr8oCX0yWumaF3h5EfX/Fh+5/KGQdN7z45oGN2262iI1dhHbsbKZWl2gtCB2ZkYx1PKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQa28jrbpocbAsT1auhXoPdai1M0R35ELyrybv8Z1AKYowBWys
	RNjuAKVbUAciSKbHG55v688HC1TjzbXjHjpoRE1kT26zNHybzhsOIST02yMiqVMvrPQ1JhBv0J2
	iBHIp
X-Gm-Gg: ASbGncujd/uaghuliJNWaMGdO8Hzryhh0+kBv12Cs+AZGy/gKdYcZQqfAo5hYpb3eJo
	6KBoBD/wNIiCDOSPdXHP6UY2wtPMtsVBcasB47nqUfUh4ihlZJg57qkal/WI5x7nfj7bJuWU6/L
	/UaHB+BmpfleaZ9oywbmZeMo84Mf1LXoFZWCifiViaGQAEwO/bDxeCWbfmdQ/wU8wKP8NpZ/Oqk
	Paw1EewccsNatc8oZ5YO2lye7Hr/FDlpfmwyDyaQPB4GWnaRoK7lEvl7Bxzx6ZqKB76NpPEho4c
	jBShhcVkRCoX/04u/RzaZm3PUPKPfTycQ+HODGGBy83osC7QeMYvdM+4l40XSN+6A8dcb1x3+mR
	+SnM0aEBrNZdrFYZypzRQjRwa4TXjSt6TNvj7tcr+g5xjgf2ROXjsPUcoeI7Vpvfvqj/C/VXXNJ
	U=
X-Google-Smtp-Source: AGHT+IG9hSIHsbvBSMuM+1DjW+6RnRyqFcbS8/ej/hb5PzR9IP8FISpX8gnH3Mud8EC9CDMd1mUScg==
X-Received: by 2002:a05:6830:4186:b0:73e:96e6:2540 with SMTP id 46e09a7af769-744e09dfa60mr1883876a34.2.1755615910866;
        Tue, 19 Aug 2025 08:05:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204e556sm2418288a34.43.2025.08.19.08.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 08:05:10 -0700 (PDT)
Message-ID: <f7815955-7e8a-4f67-b699-8b19cb38683a@baylibre.com>
Date: Tue, 19 Aug 2025 10:05:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Drop unnecessary
 dev_set_drvdata() call
To: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <aKSRpTuwA0P-ZaUS@pc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aKSRpTuwA0P-ZaUS@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 10:00 AM, Salah Triki wrote:
> Remove the call to `dev_set_drvdata()` and the associated comment
> since private data is never read.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Changes in v2 :

Reviewed-by: David Lechner <dlechner@baylibre.com>

