Return-Path: <linux-kernel+bounces-764569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFD0B224A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107EF1B631A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFE2E7F04;
	Tue, 12 Aug 2025 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EKMx6ZD/"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258E2253FE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994681; cv=none; b=VlTiDV794qgSUM+UiDf7yWzQ7ZEUrAVlEfaPEWjMXz7C9F4pPlqaJDqNveIYsgTNAKDwq4K1rMQrE2t6vaGA2VKkRioj4aVrvZ7xjdhjFh9tXHUbcO4TBOxlxlFlqm14o9Kk2UYsg6Gj76NAvRwiOWHyKn6u2ZizzvMZGQXsL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994681; c=relaxed/simple;
	bh=44tQOSyab7aTUIY6M5IOXUaBWue1n3BKk3TstEGV+kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrz4tVrQTCAqvH2lCFIdQjlrPLm/4ZeLwl11qnPIPsX/hoWKDQepk/fxFnVQzB7/87Rq4BJ1V3j8f1PqHY1SzgWrdFtfLC2SOaML02MJlEA+s+GpHtLjxlp7eY2A3sVNsYlRAVhbJZBFj+YVkL14MjiYPwvKKwGjHsOzrN7je4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EKMx6ZD/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af95d5c0736so825864966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754994677; x=1755599477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfyfTH8ioE5SGTU90p43jnBns9EU3pEximXE83fIapE=;
        b=EKMx6ZD/4YEB8GWScdmNoJON64kYmZutuFQcNIIFsZ+sA3x5wFt8DGg0n/nZ2qdHjL
         hVc+PRNAi0J5E28F74frbe5tO+QXXdcJA8OQH8uJ8KMg3diOsPkrl55H4evZd8kO2t/g
         OBkkvuXGtu/2m7pUfZutseO5X3vxBAq1RtG80KSdiQ7k67PUWXsTYk2AIskWkVTqJkou
         o3v5uvkD8V8cSDgqwLYAPoCGad5b5x2E6lR4B1kakNJ4ac2eDN+4zF8deElT5Bmi6hH9
         00JPiSsE4e5QDtFx6klxHxZJF4/awr+nhPpZ7f74O2intKRdLC32rw9E8yXSKHW0jcd5
         R/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754994677; x=1755599477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfyfTH8ioE5SGTU90p43jnBns9EU3pEximXE83fIapE=;
        b=EOnMCfSdgeYvOuSPZqJW2KuL6VNKNcBhwXeq48t08B6NeeKjb0NJNGKLTi6/H+o3Mn
         IQBoq1t3WnFnyKJVZ1+OrVa/APWoofuuME58uo9pCrMOa7QpJP1ZCG6Vc9CGT4MjMJ8I
         9BVV1kXMslPaXRTkUZXO+eEPDcshaj525UoNki5AdGZrfUualUEvDaV9wCm3Rs428C1y
         AqYqSEUdqMzPq9Si4tIEJO1AQ13ovSReJJybE4LAXmKwgznl2JAlU5eFvcKZPTqDTRjQ
         FVLVMa6iuU282JnTzMmj2wYfHBJ5q6+YqY+MDpCgSspSH8ovZdvSESoAvD85FUZhnZ7V
         4OuA==
X-Forwarded-Encrypted: i=1; AJvYcCVGjAlgfM4OKadf12mWNayVeKIvlXGakYXBUGx+akREvhPioNc8UsW6YZYfFHfPtwdd75c1H+zk26FTMJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbwk0/cS6NofIjeE8T1KeZ6ZRTCp8XuuzN5H4tyCeZHLWwVsh2
	ZfqAvTeBuMlLJaqNrzCpHYV5z8gyJtsgXQr6JVeuxU7xYiveWbmjs7B7t4H+ojGR8PDGfIu9fXm
	VB7lX
X-Gm-Gg: ASbGnctCwTLKvbbyJyJhQN7IAF9q0hMANAiODwnRoC/+HxOXNYDFq7UjaePoq4Wmdub
	V/+YqFjwFyIuC7jSHiUaKffwpNp3q1UrV7zQr4dTDLBwCqfg1LEhJKN6XBh95qQIVtc9B6vtwlM
	UU/3keLZFykQQKW++DYveOGMpVRH0llsfGn6qaywFNlTGo6eUPwA32HGHfy08AJzIdkbeCg1zXw
	EUM0Ew/XXE/yd8R290KggenHOtbO9QNBA7yqmOhi/yS3o7NonxvuJFsckCtExmNu6YMKzTuZt30
	YRx513l1gKvf/tT31w8B6f9x70SooAo3alOsp8/egzbTjvU1ai8XNmpS7WwaGRKXxcWlPXj8wFd
	K9iUrTHUjQt4sXg==
X-Google-Smtp-Source: AGHT+IF1iftVmbzHDs8+PahI/wuU041Ctyni/c+4phDx1uiPk1u6XwGB+yYQPQvYMyTM4HZmXWfTww==
X-Received: by 2002:a17:907:97d1:b0:adb:428f:f748 with SMTP id a640c23a62f3a-afa1dfec6b6mr194862366b.21.1754994674751;
        Tue, 12 Aug 2025 03:31:14 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a22057esm2171868266b.115.2025.08.12.03.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:31:14 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:31:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v3 4/5] panic: add 'panic_sys_info=' setup option for
 kernel cmdline
Message-ID: <aJsX8BBw1cv8Oh0Q@pathway>
References: <20250703021004.42328-1-feng.tang@linux.alibaba.com>
 <20250703021004.42328-5-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703021004.42328-5-feng.tang@linux.alibaba.com>

On Thu 2025-07-03 10:10:03, Feng Tang wrote:
> 'panic_sys_info=' sysctl interface is already added for runtime setting.
> Add counterpart kernel cmdline option for boottime setting.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Just for record:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

