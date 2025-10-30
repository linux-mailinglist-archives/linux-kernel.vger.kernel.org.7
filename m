Return-Path: <linux-kernel+bounces-879261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E09BC22AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729743A8B74
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F372620DE;
	Thu, 30 Oct 2025 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ct0EKul6"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BF306B1A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865944; cv=none; b=tT1X57cSm1C3kdd1P26nSjszw7qAFlj/WkjHbaUSNrGvJlWHIA9fzailuoj2gdgyetP7HJwplc926RhyOl/1nXwoCZygN6GKkVM6DmG4V/S3fEf4stfN/WnpurJO460UxoSg2ugHBTVWecIyXEa7D4ZCBqlLoL/L/9ZQdZWUpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865944; c=relaxed/simple;
	bh=FWdZ5+r53HLL6DD6sEpsfn5ekax5F9yKhc50i2IuozI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eR5eYm8k1U70RIFwpFl15+HB/tA71y4exyw/YwEStSSSpiwPyEH+BcLlGDqQ1h5yW4Q3iOrsxgjuDvF25kWRlfmqdQz+i/DciEqkB0vG1q2IPpuRU19Ps8+DwhKTCo4CD9iA164Lt8eBaLUHB9H8RBBTgu6zP9VkDbzmT1kR0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ct0EKul6; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-433100c59dcso181105ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761865941; x=1762470741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKw/K+nf9p8Pnc1atkVkdHnJUnVEG2Qa10stPI+AJG0=;
        b=Ct0EKul6gNF8oEa1rVowJH7xNJqnNnkDnN+eQgu0CSUhdbtSfyp+KnG74k/koKq5/1
         LnOWqqU/ZGgK/BJ+FHNYW4O3zcHE+P5stxO/czsxcC01+ehOzBwKXA/QwozPm8XVA6Zr
         VaWtnd15nDUc24sDpPFVzQUX257loU7lOTpRGnZul4w2oJTQXrnzuV02Rs1e6G8JMBwx
         phRolvEZT+Hee70K7nEr86YqqkRrlpaRPPZnOVHCt7Lmp+7q7t6c0I7xdCW3I0eAkBPt
         TV5K8HUINY5Oqlo1O14OBat8raw/6f08fXHWDooWhKObGAaSml7m6iQZYatWg/cjte6G
         D8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761865941; x=1762470741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKw/K+nf9p8Pnc1atkVkdHnJUnVEG2Qa10stPI+AJG0=;
        b=aQn5oRfGGpoueJS/KCQsBJmDDm3W5k0QjCRTLwb4vrZ3o8MU3yTOrzmG6ueaaMLJAR
         6Kf9Of2WpcdreCJZV3gIEFwQOwP6O8Ce+b540O3ff0dVNTd/a5qEbI8hogzmc6PtZBfh
         4bl1EzEGhNX9CIrkNyZRE4x7r855fzTcL1uBELYHkiG7SfJeHEuZPZNpJ4fY+um/6a3f
         VnN7i0W1rbinSLlHKNI3dU/KF8tWlfEj0TgZeFQoeZyeHHv9ogE7M2P6sWAYsex2eWTl
         OThJ0RbjPwdZdhOb1i0NxwCQeC7czxohZdG/uDAJinYJQlcEQdLgWn8bpvVvYBm12mSf
         F28Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWJjog6zSh0Y7GNXOxj9/+pfw6zc4jYnlD/6cOxZGncPYK797HEJLI1ccYxjUWuy3QaYcZ1aPPiaI9VMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2GLw1WsfacBsjqXsFPx33/Uj3onhX5sLaeez5duvZtFJfrot
	GS7KdGTl8IO235mAwAtVWlVz97m8ml2C94PVxP36rZmsbHLcixB72KAFhtBtrj35h+g+HnK2ift
	/kfhr
X-Gm-Gg: ASbGncvZeqX9Db+30d4cjHVHnTdWAsaugj8fhKkJLtaH8XDpG+zkAXF74DL7joZLJD0
	IAbkERlUCKaApgwzDiBbHNUqikVFwgGin5dBPGdfBq6EvHNNKVZKTvOkLwU+h5atXwrWi06JsCC
	dWJjOenl7JUn86RRXrAkr0Q0aUag6yZGU18ilWAwa5JkC+pJ+cl7tJm0ZzRrVNxn821arWqgM9+
	JsgyjTNob98aVyom8ff3WlM/1/PQI5g6L2jmpUaT+fLcAGjj2yIqQzsfAFLHwAJd//ZQ36SJ9Mu
	a329StVs0wxWvOYZon+klHNIEDmHbDOOoaEv1GxHKD2iGUs0FmZxZdvtsAn5tBi+G4Bzeyqb/fC
	UQ+ebJiWg1vWiqAJaxgRj6s8kGcpey3kxN643z5/39o3dG01DO18TTtbTykqcZ+RY/7DcZHIipA
	==
X-Google-Smtp-Source: AGHT+IG1jqu6NrajMqpFEesfbT6+KRwNSIkAiHV63BYEEQUBt3tmL4uGzZ8irT3xY6DfvGjvO0dkZg==
X-Received: by 2002:a05:6e02:3712:b0:426:39a:90f1 with SMTP id e9e14a558f8ab-4330d1c904amr29475295ab.18.1761865941610;
        Thu, 30 Oct 2025 16:12:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94827c84cedsm925939f.12.2025.10.30.16.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 16:12:20 -0700 (PDT)
Message-ID: <132ed630-d885-4fb7-9f85-0d8ce8f25fbb@kernel.dk>
Date: Thu, 30 Oct 2025 17:12:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: global-out-of-bounds Read in
 io_uring_show_fdinfo
To: syzbot <syzbot+b883b008a0b1067d5833@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, kbusch@kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6903e7f7.050a0220.3344a1.044d.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6903e7f7.050a0220.3344a1.044d.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next

-- 
Jens Axboe


