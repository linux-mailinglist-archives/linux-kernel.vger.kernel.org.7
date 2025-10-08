Return-Path: <linux-kernel+bounces-845413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9E4BC4C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE2F3C1518
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332A257435;
	Wed,  8 Oct 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zjKL47YI"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA724E4A8
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926517; cv=none; b=W7ZKb1AOxHp5vBKHl6ozcpK6foZjHmcqtCd8qKU/8Oby1269eCVhseSW2H3QgyID1hAeYC+K1/AHgbjdc93KUmXhbBUJt+CqQtecwQgCOPZg2hBd43CzzPuzjjmojHQQ/5oI5a1lKKah/UMX1mEHtYRajou76qGEhTkzQKsduSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926517; c=relaxed/simple;
	bh=J+ST8B1duH0xVw6MSCh6lDkEGNmwImONntlHDiFPjjA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YJ8eC8l0EU3ThxkohPQirwzIVgGnMGOsyToUcoQ+6tATsSpWRSMLEQvYjQLsWf/ABmeZ99xjN1dGn9CQr41LlpXGLVpKXaqR0BCvu+DnEvqLmBzs1liCxe7LJCiCrWj+fFxvsnFaxYikID/le8Vem8NtBF5SW+vfnSGY8Q2Ka+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zjKL47YI; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-91e578e2a61so294220239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759926514; x=1760531314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7P1IY2ruXTZr+b9uSPcLMIKiYjNCkwp6VYKIvdirvQ=;
        b=zjKL47YIB1JnSjdPOQc1kq5noKO3oq2AyaIpouSII1voYgJJ6ETC7DEaXcYrW2bSjC
         1ofkWpEztHZNku/D8hrQUI72JHUnDnDKsuZp4ZOj6NajlTPQdkrsDo5AAUV6iICchxUA
         4KzxhkJfXRgv0547cnZ62fHJ175wEt6dqQ+5ejw/MSOrvDK8feAUWf8REQx5v8tIgglP
         k20OaV4ska1mSTq8w2V2MMBjhWWi0nwfUc1I4WqxSkIG1eloxIAMRorcpi8SxueAr0HK
         wnRlPDoTNHMP5AnQQW+wWT4+uPUgVry+YPCHlxzCCJtyGS79nGWKDhNIh7QDnC6O1Br3
         qYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926514; x=1760531314;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7P1IY2ruXTZr+b9uSPcLMIKiYjNCkwp6VYKIvdirvQ=;
        b=ZvlPrn1+/jXklDtuuOCnm1OA8vI+gMYf9UVfOTFf/luGXtDilhvxlCpGDMYroTEKV8
         TTSel6ny93YhjxU0RX1gGEAVtfHJRoQ5P+XJM+eZV1LgZW0RPAWxWY9ooEuNHNY3KL0S
         Z1RU49WXuFZvsStNVeQB+JE7B0EPA8xz4fHSa9f+VWlNW/gGTY+sR2Lg24iza8L9KsB+
         VibIG+YQDfh5KoKZ3Zm0lqhYvEqpR1WfwzB3h0OOEoznE5Xb7nNn8BwU8TSbkCJmH6/+
         //mDeScqJn6GDZu4n6AB21t7yGdK63cIoOqjT9pd3ry7mtbKWAgwtMNhANt+3bZJPupk
         GwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc2yoE7uAHnDgiWGMvuJJ0Rk0oOJnbG998TBRstDEiTdg9Ct99kAm0gwTjBHKr1WqsDze30YGZQZzxt/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz/H4aYi9wcWPsRZ+M8juBYiLbNByI3lkNNTTcUkDTRtB6yunW
	YciOZgBhEGEQvVuzrfEKPR8I95yq/Udd/B8leZBCaHA0IFIFeFzNFYBww3mfxGKCnLDvCJvesoy
	PcYq1iw0=
X-Gm-Gg: ASbGncvGD/d1+2X62p8FxD18yq8KyYzP3ZJ9/FhvBH6jZcZ8bRz+OwAwlIIrmhpmg4T
	Ok4AdIwdW8UtCkQBiSWgrsMkT+9OVRC43QFAu5Ro5jZa+8rxl/T9Kla7DfhDez15FqTmyqRIZMR
	S+Q12hHJpQdxuyR0Y9bVS4RxbhF1cLzaM4RkHRD3EqtAit+viAOP1kCM2COthXEdp4I1tyX9uf2
	YuB33PJJ/OqxMqe9lFTfWVpoxX2BhKiMZItkFLJNgNb6ZugD9G68CSWK7UsWqJPTpMOeoC6Uc/t
	AuovemDwjADLiVHBbztHY1/Z5gurFn58cBEVw4LrVJWmpev2Ezrny49Udv5AB3n3//bt5nN3O9c
	g92/uFUxyMgn8TxZZmH8yoGWHbeZCyEtccvijnUk=
X-Google-Smtp-Source: AGHT+IHAtBcDrbT9BvlKU4yOyNu1cam7D59FfGTizxMcGiKYN3MdbtgMVOI7VgVCLe9zn0w1vOfqSg==
X-Received: by 2002:a05:6602:6010:b0:894:6ff:6eb0 with SMTP id ca18e2360f4ac-93bd19cef0cmr299245439f.16.1759926513769;
        Wed, 08 Oct 2025 05:28:33 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a88961d74sm688387839f.22.2025.10.08.05.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:28:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251007181205.228473-1-pedrodemargomes@gmail.com>
References: <20251007181205.228473-1-pedrodemargomes@gmail.com>
Subject: Re: [PATCH] loop: remove redundant __GFP_NOWARN flag
Message-Id: <175992651273.2000341.9110846781378593790.b4-ty@kernel.dk>
Date: Wed, 08 Oct 2025 06:28:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 07 Oct 2025 15:12:05 -0300, Pedro Demarchi Gomes wrote:
> GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the
> redundant __GFP_NOWARN.
> 
> 

Applied, thanks!

[1/1] loop: remove redundant __GFP_NOWARN flag
      commit: 455281c0ef4e2cabdfe2e8b83fa6010d5210811c

Best regards,
-- 
Jens Axboe




