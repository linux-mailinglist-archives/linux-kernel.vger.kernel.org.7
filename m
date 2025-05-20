Return-Path: <linux-kernel+bounces-655890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15BABDEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB73C4C7A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974025D20B;
	Tue, 20 May 2025 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m9dxw+Aq"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903AB25CC6C
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754586; cv=none; b=E0HkTT2WtBvptqrP4quY1TvTp0ptVWoCyQfPpJYyoTYFNlNBgvBGEg0bJlCUqbbpJcNiINXg2z0xppySvdu/C5sWx4tJTbBap7g7szF8CfurfhRsPay0f1XOJ3fdHIdSG4OpcfpoFWcrnaFi6l/a1gUmSHN/tRnQt+6KL2P41Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754586; c=relaxed/simple;
	bh=vEbcuXQwEDRa0vNR50YOWWWtdFUeo4T8qpaWJJxDqHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NonZNREV+9pqinoGBWYyePtCltTon6p9ZUEE8LuNzyw9qPBA4q7RFF7QlCs0pYe69Tke0cmBM4ps+qT9YAp38bwhFAJ5evmUg6jwdZTLYPhsVz/jphL+RT/vhd8GM+hDT/uPOElReZWo/mjAxgLRmXI+khVf+LX68/EXm2uCRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m9dxw+Aq; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3db87b9605bso37622675ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747754583; x=1748359383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psPdOjdWIgtZdlDW5hj2GFX8fZ81Dk7SDN2MaI3x7nw=;
        b=m9dxw+AqDQ+1rWgodAGFWnhuFaKSCIgi5ZydGaW52KKeWbLHBVKN5J79xHekkhN5uO
         WJei/NE5ldeBweYaP+bnT5llbDOj7a+pQPJTi+IgEbQ5Od+1/K2Dkmhm9dLz+HI/G7d2
         rkH/Fhzb/48Sh/2r5tFFoJo63I7Y9fV5z/y6gRXClhC1VZj4dLYYc96o9jduLxDM0D4c
         ZjxXt8Ty/oei0KrLVfQHFSEuZljFE7vrHD6gwkPc23UyLRZ9MWk9Vac67r7oQIn+x121
         TUi9xpLdBihCEhB2r3RJyfsQzO7U3wAw9EGRijgGbbnG5M6IYD5TOz53jUUymEflYwNu
         9nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754583; x=1748359383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psPdOjdWIgtZdlDW5hj2GFX8fZ81Dk7SDN2MaI3x7nw=;
        b=kwvPLTQrMkOeKw58opn1J6BQzxVH0svM/M3P/7RrLelJhenj0DfLhCXnAS3DOzPs3h
         bshqPXiYZHP4/XbmE8QaA3H5O1+65OPstWSOmv5c12w1w6QCrY4yOl+VxM35E2BCBps0
         hzJztPN3333xXSOqIDj7GvePRVfFlLsoWI4+hXHPtv27O4p68POu7d+zL4hBs99QYgXs
         geSjbZnXML+5X4eqdJv2il1PC5fNJ51ZCkTmySB1DrSJ+nqKKflg3bAzrQsiuPqdWI2S
         +LOaN5SaDdKiUgFl+xqfU6x8NLUl6yAAtNGKTOGF9AAe7b1imnJCf6strbiDmsGzOYNi
         x+5g==
X-Forwarded-Encrypted: i=1; AJvYcCX7nXk/DFClAzsiDVegA3dxpmvs5I6krJYCOgRN98wsJj3HPbuwmYm2ipmHGtyPzVt383jY9PDvzbkoVaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDdfYGMAorH/MsjWMurnH8Owk2YhazL++YmmzFYLDfymRiXjI
	tfJtVbNuO2XQqEYS8g0eXieMqUWb+1Ytdxv4GQcbHXNm1YxAObekE0TkHTC+SIjqxnU=
X-Gm-Gg: ASbGncuUoFooAu3y/nOFo/+/LWeOtBL5Jbj9Cc6AZGSH0A0Pts+CH8e/uToAb/laT6U
	1A8rt6AOuYdKANanA7xs4tJHwanW5w6hTVqPn6yphiKBBturyV1X/WXdfxPt6XJpjykdFm8BpWf
	q8xasJFwjrN/PT45uDvyxyW5Gr7RC//WzoZEvwXsDI5NSFpCCiZTGPdYFLMKypDksc+b7eEQGC9
	j2MfTXaLDPz7elGEsGoovv8ME/yYvcQVLAkZS5rFqnQkFfav+4nZN7JZHLHyKGUHYZA5D7El57x
	9ii13xtkcs/wpuxjyA0TLSeNc2cxg9qArxkE3Hc9nHuimP7KArwSdc1ttw==
X-Google-Smtp-Source: AGHT+IH5FiH5hdeBYNYfGJRWZ52DOo6I2S1qMZg7FuTAuJBXr6A1ts8mPNDcFL0CI9GiyXU3YCIgRA==
X-Received: by 2002:a05:6e02:12cf:b0:3da:7cb7:79c with SMTP id e9e14a558f8ab-3db842dea53mr165651365ab.13.1747754583546;
        Tue, 20 May 2025 08:23:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a556sm2268664173.3.2025.05.20.08.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:23:02 -0700 (PDT)
Message-ID: <72139ccf-892d-40e3-8870-2dff0e30ecd9@kernel.dk>
Date: Tue, 20 May 2025 09:23:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.y regression] loosetup: failed to set up loop device:
 Invalid argument after 184b147b9f7f ("loop: Add sanity check for
 read/write_iter")
To: Salvatore Bonaccorso <carnil@debian.org>,
 Roland Clobus <rclobus@rclobus.nl>, Lizhi Xu <lizhi.xu@windriver.com>,
 Christoph Hellwig <hch@lst.de>
Cc: 1106070@bugs.debian.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
References: <3a333f27-6810-4313-8910-485df652e897@rclobus.nl>
 <aCwZy6leWNvr7EMd@eldamar.lan>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aCwZy6leWNvr7EMd@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fixed here:

https://git.kernel.dk/cgit/linux/commit/?h=block-6.15&id=355341e4359b2d5edf0ed5e117f7e9e7a0a5dac0

and will land upstream this week.

-- 
Jens Axboe


