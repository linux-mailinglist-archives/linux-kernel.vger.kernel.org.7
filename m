Return-Path: <linux-kernel+bounces-818494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCEFB59283
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC50320461
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D229D2BE04A;
	Tue, 16 Sep 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NROLxOU4"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10A29B78D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015729; cv=none; b=psy8TnxP+Qj+WFmQQ+PqPID42wn6rlKhTMh/VJdcWgDIZKXiIVbdu6XoXORkkt1w37UdD9SyIb18T5FLHDpEPw4o2SOT59BzyyW27mHnoQBDa55oaWf74R/1zwsUyUcE9UtTCJStkCV+UBIz1GSaEnQtSLy0a4ver2yrhHL3XOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015729; c=relaxed/simple;
	bh=wtSv0L6/GwqZZywYhmXmG694rGZXr5C/8JsbMi/MtQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLNsK4ik49TnCvGvq9Aceti7yJig9TfV4HroO2DHv9pvAs+R4ZLm+jMoZA9fBmD3ZAVb936Cz8tYpY6ZUknWawXxfL+0r2IztJXhr8pjtXpJzkM1fzZwi/nw64RiwxncMyQ5VvexLVs+LIQu98k55jVkayPlR+4uubBnWc9L1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NROLxOU4; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-351f5cec42dso31933261fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758015724; x=1758620524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haBjQsvE5vE3ZaF/RXUldLy+CB1Z0cpROeB+NEV/yO0=;
        b=NROLxOU4z9V4kypeFZVw3XwLvlvgr7633NM1a03un3CtR4lJaMlWQe4MQ9UCfQlvEb
         6ob7dt32cZ4IpbAOwNI4qTzia9lGJazUfcNRQp/OvPUSDu7sGMuWeYcpArVUzIW4p20/
         gKtwWEXsjbsLeP+PHDVCpBxenDK1C/PGey1OlckTGwKYRad5H3S3uYuXCz0vu8CDIW7T
         egPW/KGCxW3n6bStOzn36fCBk211k/YGoekXP8VanV1j1gkifMzn/eUrtagsp5xDC43J
         /jMULwG82ttCurMTfCNleWqTU5QOCkSM5vljU7z/8VsgANXljSZs6vhM5Asl795xTzI1
         suEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015724; x=1758620524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haBjQsvE5vE3ZaF/RXUldLy+CB1Z0cpROeB+NEV/yO0=;
        b=mvsfmuXU/+wZVVsah7IV0RUe7WIVD7n/FfBDXUVYWkDttItnAIhMDdzKM8Vkx8Ax0b
         E2hmWDRpEwedOfpCtotw0gSXxlRBqrUjtfu3Jzb5DoP0tiGnmqE3xygiDNPJJa65I+Bz
         qRrx0jMj5RKIQxZ8EaF2wMVLx1WgHYNqUTkVcJzNFcrow8J4poDuGV9zjjVNUmUHf/vc
         dzF+3VkNfABlxoVTdQRculTv/l6swBTaXKL0nF2Oe8LGf7sFNL+esQqANqGAco7ptEzX
         yxKOK4Wl8nLnNIcYDDRFl2xRKy2SX5KkC74/Gj6vnzM76u2QMZWCURPmFQVAcdQKxd66
         rtYw==
X-Forwarded-Encrypted: i=1; AJvYcCXyWXiJqzwMGYyKAfRu97+V+G4RfKIwNj8SjKLXDQVJ6qXgK/LT70yDGXr6DhzDfg9PpAy4iLFkoVWyrTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6i+mawrNeXXu9qF5MhLT1S8++Xo766unLcpFsqYxVcJwytPaO
	WSvlAZIhrHFtZ3JAU5DiQUZCNTWH/aBvQ7D/xTT9a1/HeJ88Nm7CesqU
X-Gm-Gg: ASbGnctAWSMuhQWquxeXGAx7AbPO+N8EumEHT7DR7+O8GHOfV11JufO6uSGgcC4D2el
	z4mIct+i2iAWQFtjI8M/yCZbOc25UDSA2sjbiJZNBdlvl7FP6ZWg0/rlHTeJuMmkU6xd3gPqT3V
	WfUIotjWg/0uNzVqZG4ZZNPv1brA9Tbom8OJeCFSmp1bBeUsPv2omdWtPJ8qBT3bUuMTMG+3/im
	s7tiLsJBnB5POO1r5AyYnMYFQRREY3qaSKRAQm9HaneO5A1LlpF65FO/7NMF9WL4K5gR2k/Ku8n
	aYYYbN4Bw+9hr1T52OvtdS2Ycf1LW4s0rJUviP8gOqksgklijJg754MjSmdoSo4W5Dfp/hMovBr
	wmahrmmY3f28PmKRX1GpyfbQOYkAj6ChDftBfAGmijqkcwvE=
X-Google-Smtp-Source: AGHT+IGHsAz1XUgqjX9cBNXDDceT4RSYaRrx53ol9Kht+YGnRRfTcQN5imeqv3DeXohNMYqhdx9Bfg==
X-Received: by 2002:a2e:a00e:0:20b0:34a:7575:36db with SMTP id 38308e7fff4ca-351401fd0f5mr48965051fa.33.1758015723646;
        Tue, 16 Sep 2025 02:42:03 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f15a5835asm32481881fa.4.2025.09.16.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:42:02 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 58G9fwKw021585;
	Tue, 16 Sep 2025 12:41:59 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 58G9fts1021584;
	Tue, 16 Sep 2025 12:41:55 +0300
Date: Tue, 16 Sep 2025 12:41:55 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, bigeasy@linutronix.de, hdanton@sina.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
        cgroups@vger.kernel.org, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v3 11/14] net: ncsi: Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-ID: <aMkw4zTLRJqpVGCm@home.paul.comp>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-12-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916044735.2316171-12-dolinux.peng@gmail.com>

Hello pengdonglin,

Thank you for the patch, looks reasonable and justified.

On Tue, Sep 16, 2025 at 12:47:32PM +0800, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> Simplify the code and remove the inner rcu_read_lock() invocation.

Reviewed-by: Paul Fertser <fercerpav@gmail.com>

