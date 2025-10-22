Return-Path: <linux-kernel+bounces-865352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D45DBFCDE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADEB85016CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E134D4E1;
	Wed, 22 Oct 2025 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lh2GNXrc"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228034D4CC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146787; cv=none; b=YiQ1TEON+tFbNqC+w/mgl1joR+5W3He2j2jAv0NJInR8n+KAwxU3LK0fCmbToWjRI8SqvE3TASM7btXETm+BQS/f7I0wK+OJIei+6Cs7uOrOKiN/1wN/eIL/yjT7qcfkDg8jqey172yiuyK4p4TDXGsbbuHosfOPFd5EJmOFgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146787; c=relaxed/simple;
	bh=LRcyThRZzNKckLx/U80TKVewi3+2BXLCTF+fupxbHx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtF79wM3Ztca3mAgB3eszOb/4I3k0omEfUKFuX2bVIJCbmq7o/Vjsp0e6cBV5XyIw2PMsL1uxl3fX04fS+vOtXP47pfu9J5CiEX05RoaAt4Yg/m0y7UZGLI+YNp/NXUrdvOVwUmhM21tE19xEi/rkS39v2V2CZEFpuGhHXyqjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lh2GNXrc; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430aeaffeaeso31037905ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761146784; x=1761751584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hKPkWmq5p2r79ibLmLIZ9MOTurUfR2k5+wgsOoKVJ8=;
        b=lh2GNXrcDYpck0RvhTjPE4CTCzTIra30FPm9AAKEFfsmXQ/gbcLx+5np50yJyUMZR4
         vXv5G8o9YD+nAREWabETYOCArE8s2bwdSCUkgfQc0BWMtLD8kSaIkTZVLkuqWrffIt5S
         Sw+UXGg55H7KGEriyf/JaAX6dEK1bsrO3S57u4n12hSgYGNjnxUO1dIcvaVqr7UTQCvy
         V40omi+Zke+dmVHa7GcCkvofDxQbvYZWPafpiiyGanmuMChybPINDWHK2VjZy+32LyzP
         iT3Yi6Itkq4QSzLKOd9IIZi0JfeyBeQKhh4FXrMOqC1kYYSXLJ54+OQSCSyhb2A8ZA5s
         1Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146784; x=1761751584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hKPkWmq5p2r79ibLmLIZ9MOTurUfR2k5+wgsOoKVJ8=;
        b=FNINzNUA9dpXwNy5xxrNV4hzrBjK7++cJgkXuFLnnXUMih0RoaqP5qEIVYwQLNhZeb
         Fub32vmdP//tQcb9OirEULVh4gzEEjhbcJtegDq9pnEENcQgCR/ydShRz7etXdeDhIwN
         CObRG2Bbg4fzvOPHXESpLwqkG1EQtg3BZtdsB+2aYn+WH8OhHEVAO+qmnU5urRI0JaFh
         GiYrC+j3TKtKKEncqCIH++CPbrc21x9DBJE2oV+IUxieaoXBgGZiaCONbGDQSkZrP8Ia
         JenEHFWrHO7Jri4YtrKv7eySSYHq4WLMcNTOpd2bC6GGANA16cIg/N37PEa9b4hwtzPl
         0FbA==
X-Forwarded-Encrypted: i=1; AJvYcCWenQRoNBeKRW6LW1XF2ltyxqJygc63TY74BqLXdi5874fLaMCnd/pvrniq6eCI507tELhyA+nkAR6Qkzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQi6+8aZ++U5TC0uHidalwpCVqFWuGYhDBifzQafjDVTQUibn
	KH4zECsQCQ/uyB/9g2CGkxXcFefMystvXDi967T3rzRhJFyTxwyIfvvOp1muVBwiY9/D81LA6Sc
	FZ6dV3eE=
X-Gm-Gg: ASbGncsuu/jbtp8grUY88bLNk9LgiytgRmYUd8sYJCcN3xF3zjPOMeI1O+hLz7f5XyR
	7c8FFGd6vfgffidZPM0Sd1Y7Iqc69R7imhitAd1DDVf7kKnb5lf6bfia+PKmU/s4Dv+F2mdY799
	LTQFSrwXjEB+D96lZg3ozF6N+UFebOo5ARAio+jqES/qcPBEIrZi2ScMnLD++2ZRB8Esxs76V0s
	1+lrVUJPjaHLFDqhnbOS9yvz/92Ob5VgZFtijokXe4rQs4a22g+pOiwktMmO0rA3ZSleA9j5Z0H
	9vFBrkTee4M2C2bphX3qkZvdAZCo0i8PcGEaRAXIDbXBlI8p/IRgP87Bz/u59Bi6danY8OGuYBo
	2vNeAyTY+M/CpifhT7HGMEZvB6kGsU4g8UtOduhBjQSehQOvi7pNfIUv0Ss35tXyWiOw1OHszYG
	2FSK+pmOA=
X-Google-Smtp-Source: AGHT+IH/AJKSnikGo5wNrnUym0lndDFMHlCN0fa2V9GweWa6rnWf9q9FmfmeJXuUbrL+yAPgextAEA==
X-Received: by 2002:a05:6e02:1522:b0:42f:e334:5ec3 with SMTP id e9e14a558f8ab-430c527fc65mr269056205ab.26.1761146783972;
        Wed, 22 Oct 2025 08:26:23 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a979aa80sm5114331173.64.2025.10.22.08.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:26:23 -0700 (PDT)
Message-ID: <5b78c30d-26de-4e49-9bfa-121c9f40b4e0@kernel.dk>
Date: Wed, 22 Oct 2025 09:26:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: initialize vairable "sqe" to silence build
 warning
To: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, "kernelci . org bot" <bot@kernelci.org>
References: <20251022150716.2157854-1-mallikarjunst09@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251022150716.2157854-1-mallikarjunst09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 9:07 AM, Mallikarjun Thammanavar wrote:
> clang-17 compiler throws build error when [-Werror,-Wuninitialized] are enabled
> error: variable 'sqe' is uninitialized when used here [-Werror,-Wuninitialized]

Already fixed, and as Greg mentioned, this may silence the warning but now it'll
cause a NULL pointer deref instead...

-- 
Jens Axboe


