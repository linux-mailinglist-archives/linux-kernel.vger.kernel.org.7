Return-Path: <linux-kernel+bounces-808550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB181B50164
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E841651BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D136C09A;
	Tue,  9 Sep 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WnE546bA"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E235FC07
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431697; cv=none; b=Ov5Pqke945aV/o63PCfuVrDCWarKJ9jaa59Ea4ruq4fIHvEKOAc3ez6ADdl0vvHM4+9/P0uccVTs8jG+C+qt9/jYwsPYAeQLCjD91wHPWAhivF0ldoe9lZJFQNZufLr7RubEE4nePelRMZyQ3tv4AOOlsUUybpCNrLtiW82mHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431697; c=relaxed/simple;
	bh=zdmMTS66pDXSVVeEoILIIh+RFkwTTy3dD9US6WLNHvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iicBK8msw9yqIo6JzAk806sVyHbCjrsXl6A8tWx83XAnfTVArW8JpeuEIoYhZfBiSnVwfXoecKbLkIaBYGSLTFfH2j6y3MlgSJhVrwkMgqL7WGjM6/96A7xpBrwDa2GjP9cWNB11tcmbEG63EBvqimN5rx4o11PcedDfDDRL/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WnE546bA; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-40032bf3feeso14068475ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757431695; x=1758036495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jN1Kj7K7CkcC2gypxZGow6Wd+LfV+1NytZv39KYFilg=;
        b=WnE546bAGlo5G+8fg8jwTZo4lmsOMgNuGpIiLHtxNJ8GJ7O3Po14xHWH77y80XNtmG
         TjyfjohcywWIVVHmy70qFv2w4685MgZSg4ec/xc39NOAtoAxWSPJW4CGL6F+V+G7Gvaf
         Uf0d+Lv2fg2cqeIdD+0ln3wa0nCHnoZiImMzinbEyh7DIzvILb7/oHvq7mTtEnBPSVxK
         xH7m4MlU06X1aUwaV1vcjgokNNf8wScfBjQzp50AwKwqMk/SSowjDIa9N+t4o/00JiJl
         W/kIGX4EKBUjQktsif9voUWtpzY5ruvCxLcJM/H7Sfs12ReWECAitqF9zdhiixW5xgGp
         xPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431695; x=1758036495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jN1Kj7K7CkcC2gypxZGow6Wd+LfV+1NytZv39KYFilg=;
        b=r0NIQhgpSGHbgaYuADu+iIMiTy/TI5EHTpczTgdLgvHPMtVn8AD5in2t2ZR82/6mPR
         tIIH6knj8IoM0Nt7GRNjwkdIqUt6HHvFxSPX9RdPjF4nqrXjcFEL1DDWmmNGFEgOvaim
         k3fgcEYVt2RJo2Xr7FDmcPHtf2N0+it3K6c7CDOtNmEECXkitP8Z+hHNuKrz2aqAl3Ty
         6f6+8Agb2Kid1YEPoyDHoiFAZP0jLbr3BmlqyGFf01VJgVdMYTB+m4OzMnYe+mqe2LjA
         OY6IgPSS+I+UBNweHX4xBQuNw2KHMWshrtr2zt7NtmU2RsJfjtyL/lgvQB1Md4ao+dxQ
         FiSA==
X-Forwarded-Encrypted: i=1; AJvYcCUselH+ptAmFbgzuTR5cbaPj0mEMzO3iFqZdQustBziOea6Tin5CXKAs/S1sQf1NYjDagP5CC7h1R1bjCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzbwgL6ocrhJwSEDZdbxWBz1LfWdwTMqPqVOZTajl+XyWxDK1W
	GIjMI9txS03dSWMaYZChuTRD5f8m3JV8hoU4WRv+oe7V1N09ovwDKbIuj9T2f76xyPE=
X-Gm-Gg: ASbGncua8Fy6VeHwtY1jTRkI0NVE7jbqi85+1Wkvb0FQVOcvdOVtBGI+R4KejLhI9yJ
	g19PmA7Y8zjSTzDKmOHcEJfPJ2JaEw8ieepoe2W4UcmCkhDMunab8eYKNu/KzLbsa1/VoHlEoBE
	vIi7Zq/5VSQ4FoO8vKK0XF/bBsTYDrGvSdBOiT45MFghJ8UMye0OtrLJd6stNJdQu+pOqv/adYs
	C8c2tCJOLpJzLZfWOyyTPd/f2KLsuP8kvrEd77llptYMXvBMPqHRxPW73P9QQC/Ihkoadp0gpkM
	yQlKfnC7/84RDmoEV/Q0MPLE8Csscz5/1osx+PNGK/vXXNuMLAzKPpVFFad0/jx4QoZcU5eYqNK
	oNSAIm4oNoLJS6yOqxc8G8txluy3Rvxv6KWl0A2He
X-Google-Smtp-Source: AGHT+IHxQYn//P6OlMBv4Hjw7zsJ7Uk1Uew3KWJj5QRX2MyObcGnhrIGAx1/Aj6Ur5T/j8o5uW59sg==
X-Received: by 2002:a05:6e02:1d99:b0:3f6:5e25:a5cc with SMTP id e9e14a558f8ab-3fd87781510mr141362695ab.23.1757431694832;
        Tue, 09 Sep 2025 08:28:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5103baa86e9sm5847043173.9.2025.09.09.08.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 08:28:14 -0700 (PDT)
Message-ID: <165f4091-c6c9-40f7-9b41-e89bfdd948cf@kernel.dk>
Date: Tue, 9 Sep 2025 09:28:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 00/16] block: fix reordered IO in the case
 recursive split
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, bvanassche@acm.org,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Can you spin a new version with the commit messages sorted out and with
the missing "if defined" for BLK_CGROUP fixed up too? Looks like this is
good to go.

-- 
Jens Axboe

