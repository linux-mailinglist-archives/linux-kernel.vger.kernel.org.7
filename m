Return-Path: <linux-kernel+bounces-772510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD4B29385
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6401B25D85
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFEA2E888D;
	Sun, 17 Aug 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="HJOGyR/V"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209532E5D1D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755441126; cv=none; b=Rq3ytO4z3lbLz581CioCGIM96UiKhQfhTi06Iseie2lbMUfttDD4oXjsHO82yE0nZ1nBuU8Sa5WvLRhKhqzSPyP3FIm6iMoKnrUUBR1kdbyRaLLFXo9dr2XC4JaindEa6W1+D2JLM16cyDRdSlReKb3ZyGkB2f9S0ermHg9QR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755441126; c=relaxed/simple;
	bh=APuY7IGlNJIfYkO2UMEto4k+JamrjlxmiPB1aZdUYeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcoxV+e/RMKXx7r4ZOg/4E0ij9ZUh8fTEGcsf9Yvy8PThf/2OopJhrpZWoq7b+1pcrq3kaGEqtTmsrZjsv+2f+UofDLGxvu3c/3ZDFYJkeMin1ap+pcTNuzteSMzdHv50fvhzyzzYq6opq16fUsfJ3gIh0w9/FgwbhNNZm1HcEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=HJOGyR/V; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e8704e9687so370290285a.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755441123; x=1756045923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+77cBk30AgluRk5dNpA6LNSEUzxmOCjKbabXfN6tOQ=;
        b=HJOGyR/VfIe/AZKuQi11FVI3pK3W7p/BbZJXAMMoEpxfJkHYaLOK8120/ejgob8ZrC
         fbTobDKM2Ua/dA4nBKtmxr8iZTLrAirb3tfzmGMDxSUWk3KoVZQQvoVJLGM7GWtPRw2V
         zofHAsi/TZDVd+3B9/Edcr5Bb683pRl5OSSTYmpULg6xyd0E+OMbsBeipJbHZPf0vxEF
         In4uUypXr61iELgLQetx+GobfOR1bwQbdLKdhn976V2INOMJ76cBliEeu2s2AAc1T72j
         g8ar2RIt15BL+4aql7QgTrkvdMKr++yQaExTNCCP2nhrdrfxiBkDKBNKqiZfKru9Tm/K
         DNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755441123; x=1756045923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+77cBk30AgluRk5dNpA6LNSEUzxmOCjKbabXfN6tOQ=;
        b=NvIlPABtsNLMyGf831O/NOiTlw17G8KnvgG23VQDXabPLU0GGaR2he4SF9MP1jzOVM
         ZdOdbBn3IezU+bg+BCLBNKjfR3/h70UVjA8sD1f93lgW4cvpNDnbIUrcsCU3HbROMaQ3
         WbR5kIvHynJ4+mHxfONHimA6wbaMeMoTAwrYUewUilE4/0p7sfmbW0NZcwOdhatm9EDA
         Uq9IfQDBDQ1NE53mEkAPsC8z2b+8UAtGMYL855OzKuHNeKLKQ+BtclUvrtuDhV7q42/u
         F/UAWlQPgl70KJcbP8Xfa+G5+tTnyX7PEmiunGn028mteHTdsF6CA5I1Bgo4dW0Fnfas
         pAKg==
X-Forwarded-Encrypted: i=1; AJvYcCVT57RzWtDEM8U8cHhrH8RxrR8BCF/k/zCnpIzXkRMbDJKb0sHVby4WNJvSDzRk/OkdG/OvzsPS3EbVGB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2MbU64I2bq3rTClQ4iOm8JXgHV3DR+ycaA4qLo73dus1gFZcY
	Ra76ZSdAr2RoBvB2XJo4KoGKDQfT7c80zBO5BgiKwD5V3W3ziwV+wr8/RVeIS+NS5uA=
X-Gm-Gg: ASbGnctanM6hzBOO7Ft8FWEPD5FADNJo9sHV0bnM7OjmyTDTfQh8YhEw+cf+cH/O4tj
	xWq31WxHYG6YY8MDzRV2XoOdxlXehyZi7sGS0DeD5ELphj5e12FPKNV+xfhR1WB77Is8mZ/6vVg
	G9FN+b2Q7WaaoB+7NjeyY+CnTGEMQydYPBXfmon+VqXhVC0m8VqvhB8l26MrcqUPoLtBm8J57Rn
	Qwy98wi7AEYd1CHXuOvGQ5QOsjNSkWd6X1CM/+gJJD0X31EX4KInLFFFmYrid0uh4CUYIwyoKxh
	jRViqoigMioTfkTpoG14MhegseOAgPbG/rjD9ijKNj/xpusRblY9dpumOqJ4S+SiKirNN7qit3e
	kRJkPyYF0rAl8w8HAaTfT0Vm23KFGtvAqhrkaGxrh0Ogxx+0I
X-Google-Smtp-Source: AGHT+IGY+MsSBNuYrWIdq4vldi7/pBPvMxygBrn12VlSeZTZnUkrutReObMqx5vxy+aFdSI9qkm8Wg==
X-Received: by 2002:a05:620a:2985:b0:7e6:604f:f747 with SMTP id af79cd13be357-7e87e1389e6mr1228444785a.63.1755441122966;
        Sun, 17 Aug 2025 07:32:02 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e0204absm435092285a.2.2025.08.17.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 07:32:02 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org
Cc: ethan.ferguson@zetier.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Subject: [PATCH v2 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Sun, 17 Aug 2025 10:32:00 -0400
Message-Id: <20250817143200.331625-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKYAXd-B85ufo-h7bBMFZO9SKBeaQ6t1fvWGVEUd_RLGEEK5BA@mail.gmail.com>
References: <CAKYAXd-B85ufo-h7bBMFZO9SKBeaQ6t1fvWGVEUd_RLGEEK5BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/17/25 08:30, Namjae Jeon wrote:
> On Sun, Aug 17, 2025 at 9:31 AM Ethan Ferguson
> <ethan.ferguson@zetier.com> wrote:
>>
>> Add support for reading / writing to the exfat volume label from the
>> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.
>>
>> Implemented in similar ways to other fs drivers, namely btrfs and ext4,
>> where the ioctls are performed on file inodes.
> We can load and store a volume label using tune.exfat in exfatprogs.
> Is there any usage that requires this, even though there are utils
> that can do it?
> 
> Thanks.
Both e2fsprogs and btrfs-progs now use the FS_IOC_{GET,SET}FSLABEL
ioctls to change the label on a mounted filesystem.

As for me, personally, I ran into this while developing on an
embedded device that does not have, and cannot have, exfatprogs.
Having this be a kernel feature would (I believe) bring the exfat driver
more in line with other fs drivers in the mainline tree.

Thank you for your consideration!

>>
>> v2:
>> Fix endianness conversion as reported by kernel test robot
>> v1:
>> Link: https://lore.kernel.org/all/20250815171056.103751-1-ethan.ferguson@zetier.com/
>>
>> Ethan Ferguson (1):
>>   exfat: Add support for FS_IOC_{GET,SET}FSLABEL
>>   exfat: Fix endian conversion
>>
>>  fs/exfat/exfat_fs.h  |  2 +
>>  fs/exfat/exfat_raw.h |  6 +++
>>  fs/exfat/file.c      | 56 +++++++++++++++++++++++++
>>  fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 163 insertions(+)
>>
>> --
>> 2.50.1
>>

