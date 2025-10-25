Return-Path: <linux-kernel+bounces-869797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3846C08C31
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFFBA4E64E7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BD2D7D41;
	Sat, 25 Oct 2025 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTWlzsEm"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865542727E3
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761373754; cv=none; b=IOM9LzGHjsxhSYd4h4aDJSfJ4Mfyb4Rh6uQNOh868913vLi8+G/idRv1DRwJj3wUphahLmNREOmE4ilycgdzzDqhvUA50yBqB6r0b4LspRZdhN5yLcUWO8JwRnPkw6brCutsPX/pPJEBtb3zgiw5cR/2GcC+weq7krbkKmLfSeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761373754; c=relaxed/simple;
	bh=ujGGd/a7ODVUfmCS2kG83LM8Y1iCgHMqzkGVaDz6NNA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9rTJHHd0prsh1ZS+EHfko5xSU6Paa96yxtzZk0gtEq0Lu/hnJEyu6RZsyQIF3W5wt3H4FLcVTPQ30b1zrcGkEDxepb8VA99QzfJYILjIIbt2mgvZZegtevbwUQPzf32KMIky7Q5GhEgdfyAwT/UqWqKVpwILrnW4QB2j/7aQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTWlzsEm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so3844435b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761373753; x=1761978553; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ujGGd/a7ODVUfmCS2kG83LM8Y1iCgHMqzkGVaDz6NNA=;
        b=dTWlzsEm1l2G9adWWl3xBc7R3/a6QZRPzPRzfVNA3Az+VXjrOkqXkLctfH4bW1fo4w
         k9at0EvHSm9ekagkY79nm3/HK5/m5aTsHeR8zaj6PmiMF0Ve4Z3khG7o/dwOzPOyZJ6z
         9ZujqRNxRMXepJ11jGfIwMpcNDIeWYsKIVJYOGEQssG4uJZL51sxd4/OhdZhiruQc+d4
         Ve2HsMh6EO1WvBkr1H9YFRb/noihuCdlHGwxAZmUWkCo9dpUTZYAhxgXB5BzAtlRkS9U
         3GNSuNyIHFuyCKfemUKfh905RuFeNuVAHzZclkhYHWMG96DHdPp7STfc5KfL9VkemTwv
         THGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761373753; x=1761978553;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujGGd/a7ODVUfmCS2kG83LM8Y1iCgHMqzkGVaDz6NNA=;
        b=JgCjfwwmqCM64XY0znt1HPB5/a0Oy7Ct6UsItoJH4tNaaYzjD8oLEFGmRmmCYzQQNv
         rcGneOEeG+Qtmo2y/uHtpWd9QleprWle0wFava8BrgJBLtP56LFQWDMX0G17pp8kicMt
         ppTzk3O9ymyjXzddeiDXleCDhtszpJZLXebPWezgy0QGo48ZfY3ZMkTodo4EyOEvezHM
         uZx4zEOjovx3hCKRD+NfLMMzm5Q9o1HHcEwMpO9NISGjm/XBV7TBXHYanO4i17BWOp7u
         a16gavSD04vmL0lcHpsw1hR/MxScT3zOIslo3ye1bPudNOyNRhN3RpEaWVDYJC/g9PxS
         xKHA==
X-Forwarded-Encrypted: i=1; AJvYcCXfRW3VcK2FIxYBGCJjGfZflBqJPqJ7WTDrD0exTyhbB2B6TFpMqQOTfpuNKmox7ougNEoWirCjIavhOYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn6JD7X1weVFaA2ftUOYAsQUUuxSIOUxGKAxBnyd/4E5jGE6on
	b4ZvGNJMHsmMt/q/pGf/CgiKkV99Wz4susRULsm6KIBvTea5fO2ExKjOwB2v2PKB
X-Gm-Gg: ASbGncuTooKFZnC96KZPjf3ndJUfDmUmWwO7B/caY1+0uDaPptKG7/c5d0UWtglLP0F
	4+AMUzowofGaISfyFgeldNW+lUr2RzrQihe60kYW8ccl77Uig0thok2EkTFLdv087pmFUClKG5r
	BNcf1gji6lV7NP9XJC57m5dqhiI9u/03qR11dGa7HVJMH4bGIGvhN9g8ZC0+qPXoDDm8n4ih+W1
	wGRtT4U/AMz+ZLtMSCKf71oNagegikPUd5epzeZPPoEKP5e6Zh9ZSEpfiL2ISoNJwF9zWtLZJ3h
	BsZ1pTvkcGuCNXO5uxt1UotKNHuLeIwd9j1EFi5DOluytZCVvmuPIYcvXojvFUbI5+x8o8xHquC
	UwXTJmKlz+D9nhSBEmAAtMAEFJ0Rfz9HiWL9O/FgUOXX7O8ZB5ZYeLjsIQ1dH9YZG8YTQu5sI1a
	B0riSdZyGDO4ItDCqY8JYtpQ02LFgp6osKsJSpFGjHZ1TiCkH3XwPrq7CA
X-Google-Smtp-Source: AGHT+IFWUEUqUpK9BOM5WuZByjx+FKXT3VLhONWJFmh5THmG3nVw5cQe7vhxVbZm9c/e9p2ROCfQ7w==
X-Received: by 2002:a05:6a00:cd4:b0:7a2:7d0d:80d5 with SMTP id d2e1a72fcca58-7a28680406amr5047434b3a.16.1761373752751;
        Fri, 24 Oct 2025 23:29:12 -0700 (PDT)
Received: from ?IPv6:2401:4900:88f6:d7b0:443:a828:b6ba:688d? ([2401:4900:88f6:d7b0:443:a828:b6ba:688d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049f47sm1181005b3a.31.2025.10.24.23.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:29:12 -0700 (PDT)
Message-ID: <403df2fefa9b6f83f805de3da37c18c7d6ef661f.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
From: ally heev <allyheev@gmail.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	 <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, Jonathan Corbet
	 <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Date: Sat, 25 Oct 2025 11:59:05 +0530
In-Reply-To: <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
References: 
	<20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
	 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Based on the comments. I will drop this patch in next version

