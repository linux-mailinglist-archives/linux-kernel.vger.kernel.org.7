Return-Path: <linux-kernel+bounces-840808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD5BB5778
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D953B4A24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A58D2848B1;
	Thu,  2 Oct 2025 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hXJEFJfm"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B52AF1D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440606; cv=none; b=JsdnWl6ijIbgf0VA0UzwGjmzsmpq4Ur3anEpm1eGk9a79UmCnVUANViDTUHwMWD70KZ1o8j5leydnZmgGsoeN/cafB2kcMP9KnaovU3PYxNw9gE+aqWzHSDaoVg/zcuzUCDEoV9fHUw+zESREbRypDkfPfw0vC+5lhKrx1+gF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440606; c=relaxed/simple;
	bh=R7gp+wUEBlsy8TXb5IZ7eoV7BMXWYpGmkv2yG7V6KXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DU4MEmn8BW+e8HkCb5wNx36kI5LAKCTGpjQHbH5QFtg1UefDFchd6hq7I76T2/7EpQ2LWBYWzXUOmqYXQE4abh/COvOpiZAjEnRMfEDsr2wPHjtbfhbUWWYj0691RsbjtdINSiReu145nVL//1RZfgACWNT6PY17tFmvCwKbVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hXJEFJfm; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-92aee734585so58530539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759440604; x=1760045404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLDl83AHQQg8jNm/Vtit4m6V+8FOHWhqpuduZuJjG4s=;
        b=hXJEFJfm60Ele7Kye0Urg1vcoLd39tKGflls9bpsBMaNqGYA6KgJAl/YOnyHGhkJFM
         XTNiH5gMNJw9l3losW05l4dsDWLa3MB4oH3B2ZP10eRQBY9rrA68Mtiz+DRg1kRkcgUA
         bQC3Gxmk8ZJtV5Qzyk/ogzyGM2dgsY8/1cfW1tHBMqGt/GIZrsV3l4Rc1ZWKfUFfJbNz
         Eyn0b+8VTuOs14klR/38ABi+2tigNkAOuSvWKyoFFGot6OCEWOE+H0SHW5arhRYxKPGK
         vDU1LnWqvSyuVp1zP62i2B0uTo0pNmKjwOVtkW7XWGvpYp34U72pvPO7/zersWrMJcJX
         +TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440604; x=1760045404;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLDl83AHQQg8jNm/Vtit4m6V+8FOHWhqpuduZuJjG4s=;
        b=T5fLj9dmPeeMPRfmeFY3ZXqwGHPKybC/rfTjEfnYuWyQZU6C3BfEVMcg92CR5/K6Aa
         kNEHPdxPbmONmTIh2a6FB3cXpsbPzjejlf7/0zZANx9VQCiktZQ11bOCNX19ez+WO8OB
         rEXZkpYBpfy2ksAypa/Cit+spto1XuDZm3U+wLf6mXgR2tYoskM5wgy0fNBRN2CizJUb
         WtlAkWE8mIlFw3h010Jb/MUVwfyIhso2wpuVgjuAq0SQHhqeZInhXQpg21QknJGZbn4T
         F7eUJWMjXPbpI3eMhdVFFXdc+pE7gE9aiT/kxdZs9FwKG+UiXw/hBC5LFbdJy5Q1PU2g
         tSLg==
X-Forwarded-Encrypted: i=1; AJvYcCWzc8vk61I4hbtShhMsDukIBK88id+9Ao3WuPePCjl8fhQO9mwo8QABdDVTpnNwMdmkGvYVbdrRlBK316E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZXFFVgDLpy9wawsYONYWxE7WUknAzMoCWCiDD2dB++pQvTlY
	aO2pRCmrZTEgc2sI3LE/DuKvWcnPwnLheZxvNExji+dLfU6TFVrdfBxgzrxL2m++KvbScKmkx3w
	7udo3Gk4=
X-Gm-Gg: ASbGnct4asPFytEaYWm9ViMRnglH3MEiecQHDxbexjz7xC5rHWafh7YXKWi1i3l8qA8
	SySAVUgsKJHwXKwkMVQYxV6RUbJVixJ6uwpfOVqLUoXxTsYnG3W9h8/3lEH1DC0o4W5fyQk1TJ+
	wNLaOtMKscARTzay7TyrqPki5F5rQF764t9T/eW+Gx0LgUol2lBDYCYv9iw0mDAMXXWvHanp/0M
	8kngLfJpuHqO2DHCDdh6kDAku+vu9X1BYkSKGLyTP80RRWvC6b7MPHE/Ve5SzW7W1PskmJRNYOJ
	wdKPyUt+7vtVj4clqmG0QSxSMXChXdDdaIU4nnwbPisBVB61VRbRdamcJ7y+2rwWDAHpwHfjIYe
	rUottk0S06hNSF09yWI7+PGFuzEsjXU7hsnEbsOg=
X-Google-Smtp-Source: AGHT+IHxY87feeg8VR7DJ57L7THw1pnEuQD0gg/CzqqgunAYZfmnjkB3QilA5ylhsC2jeajxLrkP+A==
X-Received: by 2002:a05:6602:29c8:b0:887:4ba9:a0ee with SMTP id ca18e2360f4ac-93b96a59d49mr92375139f.10.1759440604235;
        Thu, 02 Oct 2025 14:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7d81bf16sm119168039f.4.2025.10.02.14.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:30:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Lizhi Xu <lizhi.xu@windriver.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Li Chen <me@linux.beauty>
Cc: stable@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>, 
 Yang Erkun <yangerkun@huawei.com>, Ming Lei <ming.lei@redhat.com>, 
 Yu Kuai <yukuai1@huaweicloud.com>
In-Reply-To: <20250930003559.708798-1-me@linux.beauty>
References: <20250930003559.708798-1-me@linux.beauty>
Subject: Re: [PATCH v2] loop: fix backing file reference leak on validation
 error
Message-Id: <175944060261.1563810.3419677787520547910.b4-ty@kernel.dk>
Date: Thu, 02 Oct 2025 15:30:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 30 Sep 2025 08:35:59 +0800, Li Chen wrote:
> loop_change_fd() and loop_configure() call loop_check_backing_file()
> to validate the new backing file. If validation fails, the reference
> acquired by fget() was not dropped, leaking a file reference.
> 
> Fix this by calling fput(file) before returning the error.
> 
> 
> [...]

Applied, thanks!

[1/1] loop: fix backing file reference leak on validation error
      commit: 98b7bf54338b797e3a11e8178ce0e806060d8fa3

Best regards,
-- 
Jens Axboe




