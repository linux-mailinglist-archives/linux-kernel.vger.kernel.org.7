Return-Path: <linux-kernel+bounces-808752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413ECB50450
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA993B832B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17364316912;
	Tue,  9 Sep 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9pYGj24"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EB31D36B;
	Tue,  9 Sep 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438343; cv=none; b=nkhngt5QQmQL5/GzAkHX1jR+cg7l8ntvnCKYmT/lf/2kFTTjO05U/QkS16MzvSAYmpTA6J9enryJXDm0jbgc270qadCtTbVO4xdrKAW3X0g5axE6HOm9EvbYJ/KhiwDQRHDUpQ12Sz5o44O3eo6vk4Ei3Iqzg8kIeFLYftiOlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438343; c=relaxed/simple;
	bh=Zm7VvOOeDOR6npg9I6+moKEGxYkK+6BlGRi966Odu/U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZaYjStkiGJCoBsJ6qRBqU4W490lnqFmWHtXO/LTRecJbp+1gSSiGLvvi5vCnCKLW41pyEOYVIcm3lEiSnhYxZvMe09JWyOTPaxv/FKgB0T7ex854RvRep2/KMfaeYoID9XoYLkjdkuYwsspvLjH4GN4XvfcIBUmwTTXcvTxiuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9pYGj24; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-544bac3caf2so4996240e0c.0;
        Tue, 09 Sep 2025 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757438341; x=1758043141; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm7VvOOeDOR6npg9I6+moKEGxYkK+6BlGRi966Odu/U=;
        b=F9pYGj24ZXLL4W1e5RtGzDEQOorGlObpbfI+o5aJXlmYNc+CDAgxI2EhmpwImwjGI+
         buNl6IwTCL1+RJdZkfUPyWLGMBndcbXmGk3MRr21x0Utg66JbHzRS00174rfIS0gUqgp
         KzQnSMZxBoavw/QriOGxviZWWiAmhVSQGxIJUz+GbDihkxpdQ7apq+cHOmSMj9vSIalt
         KMywzdhjin//k4z1GxQo2Rra1XbrorbxVbf0cTz+dm7F/usNHfd9qPbZ2KiZbrN9mava
         wdOBIEM9uthMcGeog505rhR5tMA8VH24MBW3CH8bs2BlaONi5YJRn2L4yrOJgWld5XYY
         Qy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757438341; x=1758043141;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zm7VvOOeDOR6npg9I6+moKEGxYkK+6BlGRi966Odu/U=;
        b=KZ8s91shhhrzsN2kwm0tqHLsnZTFsL8MNeFjVlllWkQmijXnR8868bc4FHO5CS/oMD
         CpMZNIf0TKlQFDD4WcuBE2Fy7lJlnP7dI/TV9tJ6NifJ/p6u0ykGCr52EcVmtMfYjQg6
         emEFUhIKfxM45nkLFgsqizTGPpZHvzXSXFwO8LbGjsNP6N5+iUJ5NT69MMDLI3PmhJ+O
         3RD61aBl6xSFdLjCwh430gLfHh8QjATwC/n1SwCQlkayyYyJs3UGV7MLOjEUGOHIBFiC
         FJkcruny4jJs6NMg12xkMFLF6VrIZyigyc6Br1QMQl9D4zfkQLdBrWqxPZnHl4YmGQBL
         7sVw==
X-Forwarded-Encrypted: i=1; AJvYcCUBfntsVX/uGeZa95KK5gmDEIj5joptYvuDw6oJ1Q6bi0xvYXmCu+PNgx5DuOZ7ioO6bTo/4Ul/dHBScFD4@vger.kernel.org, AJvYcCUWM4v+cTaihZ6k/AWc/tslYL0HDYtKquvu5i8TT5SBsn71PI82B15FA9uNfYmgiNx5q3C/tT0cwhcR@vger.kernel.org, AJvYcCVP2q4cvzhXQ3UGvD4+lVe1ErSWkC9Vn0dupjAUDXxKk5TR6TbPsvBhMUZA+bJbHC1IT+5vNEH7Mt9fJAY=@vger.kernel.org, AJvYcCXSrT6BRv1fB6CkF+Eh9d67ESCeWzHQzx6PyIkdP+mE7jZJevHFuPMwWWDtGSPnyXvWsQq5VJQKGWO6@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7WgCmOWImrRKOd3rUReLlRHXjE/iu+mshB2rW9QUzl2utlm2
	oIYgXOKeB/LoULHv1F0dljvBHG1r4o9Wn9I6AVK+JveV2zSQhnPI+NnW
X-Gm-Gg: ASbGnctAYg+6aL2bVF+W+1w9qKw/9KLcSPIOYp6+RfUjOjRtzbWo2wMNohNt1TG/ak2
	iLEQN8NkodTsnRDGR/ExrFTor1iMyzhN95dZd8b/cvlgcsy8tZyCDZFRI6+9jtGAFK4gDxvZG7O
	4CwntuN2UWxW8oDvpx9OaW5avEDyPmOuHHkjwc7T9ONHkHFSJR3pqM9VmNd7Jh93tm0WkWiUeuB
	XIIUDrW09EKMIUZtn1313OKpCahHExX3hPnkPXOy0IeyRnlqgD/5GMfAvWj4DUcNzUXg0Uoz1Cj
	iBAWN398akq6wY2EgLzgMyOuyx9bcnuexL6tjJeTEGp/R4wiwxqC8OT94dCE6jmx+T0Xzyjo50B
	rvyQFgGoRpcvJ7jgETw==
X-Google-Smtp-Source: AGHT+IHK+XrLR9nzLmssHwGsF3FY/vJz5YzX53asL0ZsGc/4fHjLGGtfvlof1YLUsZOQVPF3Yh2aqA==
X-Received: by 2002:a05:6122:251c:b0:545:f7df:4769 with SMTP id 71dfb90a1353d-547923097c4mr4407967e0c.0.1757438340871;
        Tue, 09 Sep 2025 10:19:00 -0700 (PDT)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5449bc6668esm13241166e0c.0.2025.09.09.10.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 10:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 12:18:58 -0500
Message-Id: <DCOFWB420ZRS.2N43ZQ97QZ8UY@gmail.com>
Cc: "Jean Delvare" <jdelvare@suse.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <linux-hwmon@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: trivial-devices: Add sht2x sensors
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Guenter Roeck" <linux@roeck-us.net>, "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
 <20250908-sht2x-v4-3-bc15f68af7de@gmail.com>
 <58e111ea-508c-4042-9ae4-d4293871e73f@roeck-us.net>
In-Reply-To: <58e111ea-508c-4042-9ae4-d4293871e73f@roeck-us.net>

On Tue Sep 9, 2025 at 7:25 AM -05, Guenter Roeck wrote:
> On Mon, Sep 08, 2025 at 10:54:51AM -0500, Kurt Borja wrote:
>> Add sensirion,sht2x trivial sensors.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Applied.
>
> Guenter

Thanks Guenter and Krzysztof!


--=20
 ~ Kurt


