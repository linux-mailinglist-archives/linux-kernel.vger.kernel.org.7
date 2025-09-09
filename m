Return-Path: <linux-kernel+bounces-808508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30731B500AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7A9447698
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229C1350D42;
	Tue,  9 Sep 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n3cmd5tJ"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B523C4FD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430679; cv=none; b=n2GfVh/vGC3WcebkgH+yTnS2hVFI89CT+0d8p5g2x9vpBdvxgFbCu9qxdn9MJ0LkfdRA3Cwpt+UrO7QKHYAlTE7Yzfv4b8x05e0p+Gx3J6J7KnCvLRzh3wWTJ2XsxCQqOF5q/B4SU+TXbjcok3QLyTM7O38dbL1lWf7K4YEiDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430679; c=relaxed/simple;
	bh=Yi9alki3/czo+nMmtW8KKc9BPrma/aJL0PzJbvWbD5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pL/N8+vTXhI5jbgXtl3JlqT0lPxBdvRjPyh25Ze0kpVHBJhg8sQHAGM9YCcbGPN+CT+ruPP2q0esybBBhuOG3c+bzr9DffhdVLP/Yda0u9T2K0K+ZtgKpiJylDiQLcgqQCYGHmWPV/WZEX1hSsQZl0qHbfF1JFVxdxHt1kPIDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n3cmd5tJ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-40e925deaa1so9707935ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757430677; x=1758035477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS9b0uFaTGrmrTbYZ9i09A0Kf7zFcLmqjsgw2bdqtEY=;
        b=n3cmd5tJIOCHKXgJ8b63Avz3rUov2w7ykDhPS/9JmuYjNqKv7F3wOLf5OqYmH61ePH
         gIMnHb91L/8JlpL6V+35rAy9C4pVgunrViA+to+XTUtZo6DjP0owdPtGnq/hxT3odqDF
         ImnVkq8TRLJmJ0voimf4qDBdXG1fRx0CMlDsjfvif9r6U0cmqSSZSPwmObmoqme4tjya
         KJIAnEdbaPFJvjVEFTJPy4368WtOnc1LipeVygpdA1/9O8fHNf87kf6p7vlit2PfRQaL
         cQSKgI3fkLIyZ0H5jUoUumipjt5qlf7PEydvMkE7Ff4+4RBlpZhTa+CP9H3redeRCD40
         yXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430677; x=1758035477;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS9b0uFaTGrmrTbYZ9i09A0Kf7zFcLmqjsgw2bdqtEY=;
        b=nNO9teKNDqxUMDjxsp3RKG3NjNNslenHO5w1JG2J/8joRkidDWWczNQK1p+RhnkMBG
         W/dI6N1dcAquYJ0DU+wKdbDUVd51+dcehObkdQy5SX3RsIodrEJeSabKqzgL6vie+T15
         IA1qdrXAFV85zMdqKX+AxhlDhFy5SofZMEpftExsoKDxSI6LjJ/HzsJTjaVhLsHuaM3c
         Q6YE+1Lc1ZzvwVdznkEmNpAHFIf75DrwI17KlSaXqo4VkjYx0Kpu6pboNVqVmYPj5s4i
         niXTPiPWo4qw2denB0jnYSS9g2H9uxo59oHMqaYTUGqKhbrF0myW1DLO7ZiFgnN9fZlM
         w7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf0Z0sN6ITxlyYuXV51oxn3bbKIs8YBmBftBjxKf6dhfZUQyRBYIhygG2qmk/EwyXJCGETsQzF5q4v3sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rrdj5oPcQEOY5Cgk8z5JuKdViRXbuSmyWMgb63QCtUqtZoMJ
	F0ombRRsRxDL6K+DqeiTSR6mPxxp+j3B2arzMa4dnkf5GWq97ilg/HrLfp32GFrAMCILFXyQtBL
	uKf/M
X-Gm-Gg: ASbGncvxgfrwG3iiuPveXOj9i4hgQM2mIxRozqG7A2ePgmbgUzF8BH47jqYYdW7ceOS
	SExMXjerTPT9YpKKUCq02QOfmgGiDwpEd1WpkILUwl92BB6yj3W8qQzQVNqd8FGi2+HiRh4u3co
	u+9okVCt1FCW6uLWEVrm4i+cK57CQ2LkEp+VNIOJDDWdHe09Ssqu3KmSd0ThshYHijfJB0z2kia
	58vfhUPtZ50LpKjW7rJGWYXX6hKTENRD26upMncApI30jv+36q6CFtq7rWEzpAnF4YKnFxatWi4
	X1XGEfwiexJgHY+d1GmDdHAHgJ3QMKXnwnJCNspyQYswtY+vsiLOWQp9OkADGH+NqO3H5qb5gq3
	8AqVZoYm4kFhNgmZxr1kUr63u
X-Google-Smtp-Source: AGHT+IHfZ7aZ9S/jsfKaKrcPjZ/IctI/GBXuJKA4st6w1Jd821n8kXWKAx/LIw2xQak6G/2Gts4/eg==
X-Received: by 2002:a05:6e02:1a0c:b0:40a:e839:a2e4 with SMTP id e9e14a558f8ab-40ae839a49bmr89695045ab.30.1757430671708;
        Tue, 09 Sep 2025 08:11:11 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-51010a3aaa4sm8372222173.7.2025.09.09.08.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:11:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Efremov <efremov@linux.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908201021.439952-1-thorsten.blum@linux.dev>
References: <20250908201021.439952-1-thorsten.blum@linux.dev>
Subject: Re: [PATCH] block: floppy: Replace kmalloc() + copy_from_user()
 with memdup_user()
Message-Id: <175743067102.108760.5963545648599826112.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 09:11:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 08 Sep 2025 22:10:20 +0200, Thorsten Blum wrote:
> Replace kmalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify raw_cmd_copyin().
> 
> No functional changes intended.
> 
> 

Applied, thanks!

[1/1] block: floppy: Replace kmalloc() + copy_from_user() with memdup_user()
      commit: 6214cadd79c610ca903f993c7a6c46a713715e7b

Best regards,
-- 
Jens Axboe




