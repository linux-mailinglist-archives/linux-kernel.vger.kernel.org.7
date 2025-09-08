Return-Path: <linux-kernel+bounces-806641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A0CB499C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E9A3B74EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259171E8324;
	Mon,  8 Sep 2025 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJcFm/tu"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116026A0A7;
	Mon,  8 Sep 2025 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359223; cv=none; b=rpxwIqVAmM1sTtF1g2wCXSU+79MAQV/1SNd9dVhXkzlsfUGgHXI4fdKQwrXiRs8kFR0yb0m+pw1UokEe4l4ZhxFqsrETkmCuCVLbRbyKZJ7NGniis3IweGizkB/OqJc+tInvz7xN1lR5RYeCEkOPzi1e5ozgU7Im5kL1d3nYAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359223; c=relaxed/simple;
	bh=iZL/SxwpNaH/1QVXXY1HeCOjifUhnTnQ+Pr7jUijluc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVvRwcb5JJ3/3HvuoI2J0HYEfrKXcfMkNAW+OzufMQcbIqH7KDscmN0WetsAxsOjSWJCXz2w37rltTPHqsXWCq56g/Os16+sBMaPkC4bLeqWoVWp4qrOMSLTUaN7/LhkdN3ivcLOlEFjniR+I4P3huzR86dm0vp8NYzDkWhJXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJcFm/tu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24b28de798cso31163875ad.0;
        Mon, 08 Sep 2025 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757359221; x=1757964021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnUqqrBrwj8qokkm9aZA38r2ujXX7+bJc895yl2rkM4=;
        b=FJcFm/tuIPA0vSJ3GD38cFNiGqbkJ2QDIM0Oh3pIOxDnQ9+dvt88Grjsx8vlJZqtOg
         CNkWqhX3rkoEKjUeW+UUPwSwxPtkqW16YkbN9j/NhepIDKR0SyunV1bVfM4Cn6ytWvr4
         QrxalRdl1AJbkPWgjmhddtMjNTLnlcwAxQ4AGv9NW7y7rtkOpbXeCj699kPe0Ziq91If
         z2mDLbgY3d0njPD6fvzdQK4qwLISdzoBtqGtbtPTZvXENg7eylVZkEJwXFkKVyTRH01n
         f1klFjAsfAV7Ct1f2xYsLRI9F4NPkW6mfkbMGb/4J4oJQVivf4h2oZ5d9Z80oLz/BrcZ
         aBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359221; x=1757964021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnUqqrBrwj8qokkm9aZA38r2ujXX7+bJc895yl2rkM4=;
        b=HlT2S9BvnArhPVIWZAniOYpQQ2kOSWvEDy5QhohiOFzV45bzmpvByKi8ivnBaYHXKk
         3cwuARBxJvSQkc4WR9/PmffvdgGxqaAlQasQVWTxFqgWoKL1wMPHUg0I/3HJhnQz9Mzl
         6wDML3Ah8+hwn1UtJZYFG0yJ0cvtJfF27dKdXB2+gJ+4dJ6Jswlp1/dot2jXE5nGpNRU
         xUPk+4jqXHD8KrmpjSwx5npif1efBPhgIbC5JTmWJZ2PZpqsRhoZyPG6trFw8SBuJJm4
         sQw55axpuZbzQP4UMt35BCkSnzRf8QzT5mZeNRyQra8c/h9kK6FXytpKCTC6FpyVSb/y
         RCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+UkjW8iX5jPGsIjzKUsJHJJ3PR6l6WxhdoIb6gHR6Y8G60Yfc0KEMiIkL4JqK//tki+hLFbUGtJLxbnV/@vger.kernel.org, AJvYcCX1RMPmBqa18CX3c1cfkdCKGDcMUZM1xFQwRFKD1sOFNXoxODvJg3n5Fg+NXGQFCOQuy1DXuAVTNHR1J1E=@vger.kernel.org, AJvYcCXrTBMtmlmXwdb4dlcX83ofCAsZ8QgeKtr4XH1qWLbEsu1ZwsD8JOJBBHY2i9GYe3S7LmQexjbV+WUX@vger.kernel.org, AJvYcCXwzdxBVgDSio0eQA4MuLbcfiHyW67Pvc1kR/8Q1zRoN/o3dKS6a/d3e8bNHUoWVQ5pccalMbGYsOJz@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoqN/C3jPUtdC37r2EZBkGK4ytLZxJi6mIR98MYOXgRv86vbX
	L60phjjQtYblMkQXbF/sMIW5W297JkfapvT7Vvd44LxodcvJhylPz1dC
X-Gm-Gg: ASbGncv3OtOMBlcpx4jJrNWGU4E0R9e5s0jppN8UwQkduFBQcFYI/MkJLkoQe4chLVb
	aeXxwMczITJSu1+TrxzErHjFr7o4z4HqkJdUcnSKLXR8XzGMyKXLnkx+JqE65SxiOFUo1IslGd9
	0rv+VQeSmyTvErl/dmLc+w7jQYpknoMuJxykln13r/KyMb+t8MsHaHEeZF9l2RkBmYBwBQBXOYC
	8/QOIp/3gXvh/Z0hKMj1cuhxObnAokHST1/mYHMEICLtr37IsMCSTNdoDujh4s34VxtVYE+XPWa
	K+Nn5Y/t0mQzpmEc6CxcNQ6e5l68bolnVW+kfzVWkuauttXI4+On5tWwyB2LblXxUSF+HrSbqAP
	rCREMX5ix1hK29E3AHhvNJjS0kin/uNCEuuDT3BBLLbtkzA==
X-Google-Smtp-Source: AGHT+IHl2DugnBcc1u7OZ+/3vd9FW5CyYrLi1kqYZdS6Ldook2dLUsOkbI32nrvUGLYlIQYblKo0Hg==
X-Received: by 2002:a17:903:2ec6:b0:24c:9309:586f with SMTP id d9443c01a7336-251703910c3mr127126105ad.24.1757359220993;
        Mon, 08 Sep 2025 12:20:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9c2b1288sm147843745ad.106.2025.09.08.12.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:20:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Sep 2025 12:20:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] hwmon: (sht21) Documentation cleanup
Message-ID: <18918d99-46b6-4eab-af35-d39fb0c0d707@roeck-us.net>
References: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
 <20250908-sht2x-v4-1-bc15f68af7de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-sht2x-v4-1-bc15f68af7de@gmail.com>

On Mon, Sep 08, 2025 at 10:54:49AM -0500, Kurt Borja wrote:
> Drop extra empty lines and organize sysfs entries in a table.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Applied.

Guenter

