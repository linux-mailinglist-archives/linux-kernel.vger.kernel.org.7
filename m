Return-Path: <linux-kernel+bounces-806648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A62B499DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A1EF7AE249
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3CE27CCE2;
	Mon,  8 Sep 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZG1Rn05"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F827B346;
	Mon,  8 Sep 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359367; cv=none; b=Lp8fhzlrDNg1vQGiZVbGYf719j7xeP2YOKeJ03r4ZFFZ3mRwvRSTu6rwlfvuA/4mBPRISHy+5hFo9o9rkAqmAuMKfwkUJJ9+e8ptc2KhEAY0FaJA/WbCHXeGEo1I9hS9iQL6N5/AY3m/cLTLripMS2jVLrCpcrMZkSPZ3oqugfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359367; c=relaxed/simple;
	bh=i+1gUo25QAYIkAtfs1W2WQ2KPPxBtZ8s34Kqlmu5qY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqW64e78XzvbbqIOHkA2CNev973ddeySSHJtcOtbj0b9D1qalD2OL+/lMQQcHwElOzdaz3/YWC3f7R/ZNaZswuJLkUnZ1x0YIFl5nPCeaTrZu4jLc9O6p7IHskETCRri6CzI0DRF17DAVx/VaYk3vWi/ZJNN/PjGP1SIewzOFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZG1Rn05; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24cbd9d9f09so63724355ad.2;
        Mon, 08 Sep 2025 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757359365; x=1757964165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KI3ctfrnvQONdgPkMOEdiajuJBRA6f0TmNsZjTS3ges=;
        b=IZG1Rn05rNvGYX7jDGF3fPxit0MyMidjhjdX9eGYZngPXan7UwXygl3BnB5Z0LNkJ2
         Ju7XhWppjO6goo5QYAY1u6Ge6G5QUMAF6IhqAsKq7lFgWJ4GSFzO/0CQo4/+78Amd5Ah
         3wciixa+t9VIiLSI3RVkLfF8FkUuz3IsiXBdLdH+RakQ8IqLokmuOMsWL2sz6uG/5s72
         5gKw0jRbBBxfW84omMeFGYlPjKB1fsj6YYsk48EQPyBmPpbEuh3TNUgxFuXE6NL2Iyga
         j5RoZSnek5tVgMy/v5z9+0aX9gVj9gepgAPxGcD3v4oAMIVEYkqCFWnfle12Z9n3GKBP
         yxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359365; x=1757964165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI3ctfrnvQONdgPkMOEdiajuJBRA6f0TmNsZjTS3ges=;
        b=eb/u0d5Sxv/D5ueleJg0XdOE0CFWEZbXaQJ6Jywfaj1m7nOKll/pzLM/ALrR1j2C1s
         PUVA9d3vR9g4ydagiwlPQajzJylAWXwqeooFbkZPCierbFWs4BLMCwi4eXZiW4P0ylSy
         eakjlJqtM5auGqbH3nxpm2OIzgCCeCgAInt8/lcMwn0UqMgJ+I+W8F6WXt3PqJGVH3Fp
         3ZZqXlvlDdDhpSP8v2uoAvP3hozUzIx9YVZj9UMGtP9DwDJBawj4XhyWr5CI26vCofZe
         tWCOmaE3uYlNiZYQp03+kf3inXVVBkdNRiA598wikhCR9gnRdyEdBHMSJyVJ4KnQcK2M
         mwYg==
X-Forwarded-Encrypted: i=1; AJvYcCV5+mnkkiEdNst9r3myd6VqD15v+rAFuvyZRPR18zIPtunlPfPYE0J4xJwK5qSRDGqB9sxDvV4nPiA=@vger.kernel.org, AJvYcCXGl/MmQ+aqvvcRIuKSXJSkKR4WHSwKR5u20u5dgTaXFW/t9JAagngQMW5EUQizKURsaK5iBmzaLkWbFBY=@vger.kernel.org, AJvYcCXaHHzDyRp4LYl7klWoNevaustxwXrlsc+4lGWq7MYI0qZN+Hwm3qnsfMJD9pvWb0SL6aerqxgu6nThZbOB@vger.kernel.org
X-Gm-Message-State: AOJu0YwBe+WtrkA7Jj5qI5BvbGS0tW0N4/mJk6xeAUdQy4cRTX+hKKew
	ukB6nfwuGDT7BtI7vrg5n/hoTgC0Fp++PDSUdduJIVcd/6Bq6OOP980k
X-Gm-Gg: ASbGncvsuir8co0usjPlEZLdYtebmVgSXTJ9CvnFdwGbF0kteTJyAMybVa4V6dmMIEP
	4NUqYP+FPULV8BdXd3zDZH+sJRqxUJw/FsjDAV+953ebVKJyB2e2wS3eEbTs8iRAodPqP+LBHVy
	mRkXhWRm8fLiu5ycbdfcn9aDdtEX7edmi5Q8EM3NuudR6u1oC+RVD4ut2H0sfTWoUmnYCwwG7Qv
	tun8NZNOi5ol++rIZP78IAivD2dWvv4M/M4uSQLe5/J5I7oKi2m41qnkIv+N56AIOwVdpl7tCRL
	FrJttI1rKPeedafO9fi+632TF7WNdgMavLGbEmsJpWuoWd5J1Iz8RjGelzrAkAZTvCLDxCzdVo2
	7YOo8dHyq+tHzeSWnzTphFsSopt/twmG2mfw=
X-Google-Smtp-Source: AGHT+IEU8PhPJvzL2pWcwLiCOwam9XZADE3q6DHHuzAzvf84V/Nt+nrocAE4ZERNPUAaKkMr7KT4uQ==
X-Received: by 2002:a17:902:ce89:b0:251:493c:43e6 with SMTP id d9443c01a7336-2516ef57cd4mr108047555ad.10.1757359365511;
        Mon, 08 Sep 2025 12:22:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f7492d8sm177011875ad.129.2025.09.08.12.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:22:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Sep 2025 12:22:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	Jun Zhan <zhanjun@uniontech.com>,
	Cheng Nie <niecheng1@uniontech.com>
Subject: Re: [PATCH v9 2/2] hwmon: document: add gpd-fan
Message-ID: <ab050d0d-595e-4b8e-8868-684886255c88@roeck-us.net>
References: <20250908-gpd_fan-v9-0-7b4506c03953@uniontech.com>
 <20250908-gpd_fan-v9-2-7b4506c03953@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-gpd_fan-v9-2-7b4506c03953@uniontech.com>

On Mon, Sep 08, 2025 at 10:25:45AM +0800, Cryolitia PukNgae wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> Add GPD fan driver document
> 
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Applied.

Guenter

