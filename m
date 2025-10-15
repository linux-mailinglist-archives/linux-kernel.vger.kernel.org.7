Return-Path: <linux-kernel+bounces-853703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A657BDC5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943791898308
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39952BF3DF;
	Wed, 15 Oct 2025 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="A8zFAaLO"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C02DBF4B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499682; cv=none; b=XJKviC25ZnjA8k8O5WCNRszc2VgdbBDzdHdHUoCEYhO1MYL+krYe08mQl9KRwPD/unO0UGJw0a3iTxXjOS9U7zRUEjctOr6GzMiWiPD8q5c9AcrHG/Ib/7HB4b4BgU6lpOn5TxjzWN15veqsFbrPMN/KeuIWowQeBJBU0CaAm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499682; c=relaxed/simple;
	bh=UvVy+BajAErhJO3H45dp4i8wuvTsyXthdxxIvUFbFIQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=n5RlxNke2yLBifgsvFQGezCmptHqT9bp+eNwWX9Dix05OTLpsKKXIqg4nSy1hZMy6Xl783SKqZnPpjvMMXkxOAPCcOthQ3EZSSHZsKKdDf+POAEPfNyW2GoLPt6nJyq+hzP/AtRAC8twz/Vn0JK5jJWqCuU2uB+LZPs7CiFn+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=A8zFAaLO; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b58445361e8so451600a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1760499680; x=1761104480; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UvVy+BajAErhJO3H45dp4i8wuvTsyXthdxxIvUFbFIQ=;
        b=A8zFAaLO3xA5vgRwjswM9GqrH+/mv9UBu/ShRcEbb/6vOM/axkHavN4sfFCpY6DQvJ
         CTUgAcvqcZdokCMH35tHo1IUM4KhohLHvNdjBw6lj1wE2Vq9N0r22QBUgyPpWTWixO9+
         i575VEUPJc2S8OS3UyVwWYKbf1O3lpqOYSnywnvEp3dS9scBm7bczcowcIi9dF0JyNcC
         D0yZ/1t75i820RKaItHCVE/2ZE8df1Frm6zLzZFPXZLJgLtxZ8iVmRz5RsDuEOj7QE3q
         0PIiToJcS66EVXOyXdS2jqtq7xgVV3LZowKJXfKmyRZM+LCQRbxPrPOWPg4o9i3CymQx
         RZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760499680; x=1761104480;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvVy+BajAErhJO3H45dp4i8wuvTsyXthdxxIvUFbFIQ=;
        b=s48DXxTKGaczbXhk5WJwZT0Dz4Ff5BS0MwWoP0dw6MH5t5rsg/nVGZc+Wd9vPdgvQ8
         Vx3xQIli07bFmgL68Wi/E4wV4n3lOmnnfBEJglu9/B49q1wDvuPUQ+Nv/XN8SDe8pGL8
         gfxHp3q5q+epCWannP7aEfyvZ5ld8KwmICZLSfwe8LOGM70cdJRiXl5t9D1FpK6TnUTg
         ug17c0ILI3+6/uuAdg7cdTc8pO3HM7PwSbz5bS4XK8F8/HHIaQ64E0/IChKLbMJEZwXE
         3SsrWnna2n4O871B4dKfswuO8rGYVEtz9rqNHzRu+gT9m0KCJk5aI3mJit4ZNKRF1Ure
         s6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGir9U/1WHkYr8jIYtdN3HF44GFxoh6fhmj+Cuz+3zza+WGb0kKbjR619sfX5OUcLjPjD19lbEZqVorD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgpP1wEhtXqAkrTQysCSSd4pz9WSYH0G//tvj036XanBJAQkny
	mbBpKDQL2T15SlIw9topxQYUlxlFs9dYWSyBg2jHPWw/I8AK2UAEKcGWFjxRQSk3jNI=
X-Gm-Gg: ASbGnctlDT3d+9tzdfOrxPyTyLbjvpn4abL1JbzNPEYD36Xp3INyldduOQMghcD98X6
	tuHvzsL19sQp938qRFreMczEy8BTt2/KgiN83xyYTdZPIJRHXovemhLISzLi/81OQ5nLnWdlwCY
	Xi7moPX10jPAef6vy2nBGElWEpzbLtU10fmqhPfmAf+174QxLwt73vxt9oq/lBmEYqBN10RnFNC
	7jncNpkMj06ii3ShGlsq+6EXa6ZWfPJHrI2ciiXI43DQpaKYk4ZmDYl96AepNSPLWluHNutQWfq
	Skr44kxMo+MHT8Hj88xs9tiotKRG6wumCCehFOEOcDCM0yb9br/ZLR8Y0pxE4A101OfjbSZlsyf
	ZcpsY9wxeYv3NkRqo88cNPfUePhJvrCpJEy8cS+N3XmC1DWqt5e79HnkHpUuR7E3jOKGxOQcd+o
	9EetQHOMzgNqf7SKJBhQnuEP8WFEU=
X-Google-Smtp-Source: AGHT+IFk5b5m32PEcjH/JKtGeyCG8BkT/fRM0LBEsuJmc9XEjSRySY8y+FS7HN+VgONfFO05J6xNhw==
X-Received: by 2002:a17:902:f691:b0:267:cdc1:83e with SMTP id d9443c01a7336-28ec9c975a0mr435584925ad.15.1760499679467;
        Tue, 14 Oct 2025 20:41:19 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e20f8csm180651275ad.49.2025.10.14.20.41.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 20:41:19 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Christian Loehle'" <christian.loehle@arm.com>,
	"'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Sasha Levin'" <sashal@kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"'Tomasz Figa'" <tfiga@chromium.org>,
	<stable@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7> <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq> <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi> <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com> <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
In-Reply-To: <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
Subject: RE: stable: commit "cpuidle: menu: Avoid discarding useful information" causes regressions
Date: Tue, 14 Oct 2025 20:41:20 -0700
Message-ID: <001601dc3d85$933dd540$b9b97fc0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFP8RZJEbA2uDnjQfbsE3QfwpHW3AGSQ1aYA2hH1ScDEHwS7AHjtqkUAUPNRMECUslMCgJdmtwztVwLqSA=

On 2025.10.14 18:30 Sergey Senozhatsky wrote:
> On (25/10/14 17:54), Rafael J. Wysocki wrote:
>> Sergey, can you please run the workload under turbostat on the base
>> 6.1.y and on 6.1.y with the problematic commit reverted and send the
>> turbostat output from both runs (note: turbostat needs to be run as
>> root)?
>
> Please find attached the turbostat logs for both cases.

The turbostat data suggests that power limit throttling is involved.
It also suggests, but I am not sure, that temperature limiting measures might be involved.

We need to know more about the test system involved here.
And we need to separate the variables.
What thermal limiting methods are being used? Is idle injection being used? Or CPU frequency limiting or both.
(I have very limited experience with thermald, and pretty much only use the TCC offset method.)
Power and Thermal throttling is never involved when I test idle governor changes.

If it were me, I would limit the maximum CPU frequency such that power limit throttling did not engage for the test. That would
likely also eliminate the need for any thermal limiting also.
The suggestion is to then repeat the test.

From the discussion on this thread, it makes some sense that the selection of shallower idle states more often might have caused
more throttling leading to the apparent benchmark regression.

... Doug



